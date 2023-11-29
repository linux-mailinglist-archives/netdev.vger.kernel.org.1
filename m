Return-Path: <netdev+bounces-52037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D746A7FD112
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 09:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1217CB2157A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6092F107BE;
	Wed, 29 Nov 2023 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEU0yful"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415671FCC
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 00:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701247145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJX93Tpg94woqfZUkMv1QEDU9HKHF+FZ0rIOC151TyA=;
	b=UEU0yful4qYwSSiFCoVJjpPYIXjnPqCiyZ4Wd2nCyklUfM2gbh9bJQQdFSOlWCiRa983Vp
	YH19ScB9t7r6lNsGXRMEA9nSfyhYhDsUNregi7A6f/TLS/B87XC7R3ZaZZPGir5a1Qishs
	9T1Yw5UitkqXxw50cbBRJf/RhCFU0kE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-N3n6YeDTM3eGVsVLDaEKmQ-1; Wed, 29 Nov 2023 03:39:00 -0500
X-MC-Unique: N3n6YeDTM3eGVsVLDaEKmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6287C852ACB;
	Wed, 29 Nov 2023 08:38:59 +0000 (UTC)
Received: from [10.45.225.216] (unknown [10.45.225.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 89F9D36E4;
	Wed, 29 Nov 2023 08:38:41 +0000 (UTC)
Message-ID: <63bd858a-fe07-4eda-9835-d999e2905860@redhat.com>
Date: Wed, 29 Nov 2023 09:38:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] i40e: Fix broken support for floating VEBs
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, Simon Horman
 <horms@kernel.org>, mschmidt@redhat.com, netdev@vger.kernel.org
References: <25111205-a895-46a2-b53f-49e29ba41b16@suswa.mountain>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <25111205-a895-46a2-b53f-49e29ba41b16@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 27. 11. 23 9:43, Dan Carpenter wrote:
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14720
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14721  	pf = veb->pf;
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14722
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14723  	/* find the
> remaining VSI and check for extras */
> 0aab77d67d37d09 Ivan Vecera      2023-11-24  14724  	
> i40e_pf_for_each_vsi(pf, i, vsi_it)
> 0aab77d67d37d09 Ivan Vecera      2023-11-24  14725  		if
> (vsi_it->uplink_seid == veb->seid) {
> 93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14726  			if
> (vsi_it->flags & I40E_VSI_FLAG_VEB_OWNER)
> 0aab77d67d37d09 Ivan Vecera      2023-11-24  14727  				vsi = vsi_it;
> 
> Do we always find a vsi?  Presumably, yes, but it's not obvious just
> from reading this function.

Yes, if the VEB has uplink (veb->uplink_seid != 0) then it has to have a 
downlink VSI that owns it (vsi->flags has I40E_VSI_FLAG_VEB_OWNER set)

Ivan

> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14728  			n++;
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14729  		}
> 0aab77d67d37d09 Ivan Vecera      2023-11-24  14730
> 93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14731  	/* Floating VEB has
>   to be empty and regular one must have
> 93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14732  	 * single owner
> VSI.
> 93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14733  	 */
> 93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14734  	if
> ((veb->uplink_seid && n != 1) || (!veb->uplink_seid
> && n != 0)) {
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14735  		
> dev_info(&pf->pdev->dev,
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14736  			 "can't remove
> VEB %d with %d VSIs left\n",
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14737  			 veb->seid,
> n);
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14738  		return;
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14739  	}
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14740
> 93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14741  	/* For regular VEB
> move the owner VSI to uplink VEB */
> 41c445ff0f482bb Jesse Brandeburg 2013-09-11  14742  	if
> (veb->uplink_seid) {
> 93a1bc91a1ccc5a Ivan Vecera      2023-11-24 @14743  		vsi->flags
> &= ~I40E_VSI_FLAG_VEB_OWNER;


