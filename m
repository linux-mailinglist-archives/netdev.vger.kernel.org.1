Return-Path: <netdev+bounces-50879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E9D7F76E9
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D34C282405
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949CC2D62C;
	Fri, 24 Nov 2023 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XakICAB4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8AFD60
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 06:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700837571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ap6fiQil2Ft40pSx8Ez60gBhy9KG4NpYhydDRp/BJQ=;
	b=XakICAB4htA7Zt88ZTiY8YI0cjLjzVBSi3Vz7ajfU28TIu7NSyYUc8ntt7yzwpcv8ib+Vm
	4JH7Yxy3UJ/y/aAKPrlT49s6NRWPEyzBfMS5Jvhz0efun5MXZT2AbKkxiHRl4yuCF4Iqi8
	TvT5WgYuuHmd8PmgjP9+tD2/wrdnsAQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-pV1hPVSUNtqfoJ2xBmpj-A-1; Fri, 24 Nov 2023 09:52:50 -0500
X-MC-Unique: pV1hPVSUNtqfoJ2xBmpj-A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4295831520;
	Fri, 24 Nov 2023 14:52:49 +0000 (UTC)
Received: from [10.45.226.4] (unknown [10.45.226.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB4AE492BE7;
	Fri, 24 Nov 2023 14:52:47 +0000 (UTC)
Message-ID: <838b7b9b-a937-4f6c-9239-93e40fe0a97b@redhat.com>
Date: Fri, 24 Nov 2023 15:52:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] i40e: Introduce and use macros for iterating VSIs
 and VEBs
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, Simon Horman
 <horms@kernel.org>, mschmidt@redhat.com, netdev@vger.kernel.org
References: <20231122101545.28819-1-ivecera@redhat.com>
 <20231122101545.28819-3-ivecera@redhat.com>
In-Reply-To: <20231122101545.28819-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 22. 11. 23 11:15, Ivan Vecera wrote:
> Introduce i40e_for_each_vsi() and i40e_for_each_veb() helper
> macros and use them to iterate relevant arrays.
> 
> Replace pattern:
> for (i = 0; i < pf->num_alloc_vsi; i++)
> by:
> i40e_for_each_vsi(pf, i, vsi)
> 
> and pattern:
> for (i = 0; i < I40E_MAX_VEB; i++)
> by
> i40e_for_each_veb(pf, i, veb)
> 
> These macros also check if array item pf->vsi[i] or pf->veb[i]
> are not NULL and skip such items so we can remove redundant
> checks from loop bodies.
> 
> Reviewed-by: Wojciech Drewek<wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h        |  56 ++-
>   drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
>   .../net/ethernet/intel/i40e/i40e_debugfs.c    |  54 +--
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 389 ++++++++----------
>   4 files changed, 264 insertions(+), 245 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index f1627ab211cd..1e9266de270b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -686,6 +686,54 @@ struct i40e_pf {
>   	struct list_head ddp_old_prof;
>   };
>   
> +/**
> + * __i40e_pf_next_vsi - get next valid VSI
> + * @pf: pointer to the PF struct
> + * @idx: pointer to start position number
> + *
> + * Find and return next non-NULL VSI pointer in pf->vsi array and
> + * updates idx position. Returns NULL if no VSI is found.
> + **/
> +static __always_inline struct i40e_vsi *
> +__i40e_pf_next_vsi(struct i40e_pf *pf, int *idx)
> +{
> +	while (*idx < pf->num_alloc_vsi) {
> +		if (pf->vsi[*idx])
> +			return pf->vsi[(*idx)++];
> +		(*idx)++;
> +	}
> +	return NULL;
> +}
> +
> +#define i40e_pf_for_each_vsi(_pf, _i, _vsi)			\
> +	for (_i = 0, _vsi = __i40e_pf_next_vsi(_pf, &_i);	\
> +	     _vsi;						\
> +	     _vsi = __i40e_pf_next_vsi(_pf, &_i))
> +

It would be safer to update idx to index of returned vsi in 
__i40e_pf_next_vsi() so

(pf->vsi[i] == vsi) in i40e_pf_for_each_vsi(pf, i, vsi) loop.

Will fix this in v5.

Thanks,
Ivan


