Return-Path: <netdev+bounces-116902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE3D94C043
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273BD282143
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AEA25570;
	Thu,  8 Aug 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGMfbf3Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BCB674
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128854; cv=none; b=MaTPlJCJN446dWSk7wG+qCLNNgpFyH8oGdT55uHpzVEdnA3BOFNZr0tJ/lSMpa1HiF+Uig4Zd9u3y0fbOU7Ug7iwOEtGoq8iKTFam4XXnv8abiaTghohjHwBsHuPTYleZGgMnyfry0F+PL+/LciqClfknuILJEoizEUxBrCk56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128854; c=relaxed/simple;
	bh=vSBah+evTMuxM9A0avD+4ug8pJ+qirUUI7wvzaMNa50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWxjx/N5SwVuuHD0DD/aKZmXdzlM2AqMmpMKvEiW7asQN1BJV3rL8H2mm5LweDtmbLeBDJPdeAI6rKLwIIcx2mmx7EWLkJsGDDl6Nsfr0A+ji/fLy5xeiIhoOjP3aD616lvuq4MF/1Q464BtbLlA/JF25TDur6l1VSBNUU8ajcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGMfbf3Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723128851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iWn8ugeEIshJ5ioXe17o+i564FVBusnrR+y2i09Z3wU=;
	b=KGMfbf3ZNR+BKGSCOo+i0F1kPfyZUvUMfY287NK/zyFYsUMZpyxFQj/x/9TdHurbGt8EiC
	gBHWKyPRa6FbnVn7nbRI5FbdAIPQ5zg6ODG5O4pZANeEV+8IT2Ttd7rPU/os4ea+zSKvCh
	W6zk6sXFu+sehJPbXD5PAW0HqgzMEEg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-e3mGTPFcPEWu-sA9ii-lrg-1; Thu,
 08 Aug 2024 10:54:07 -0400
X-MC-Unique: e3mGTPFcPEWu-sA9ii-lrg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED5CA19775FA;
	Thu,  8 Aug 2024 14:54:05 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.194])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ECDC19560A3;
	Thu,  8 Aug 2024 14:54:05 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D3613A80E94; Thu,  8 Aug 2024 16:54:02 +0200 (CEST)
Date: Thu, 8 Aug 2024 16:54:02 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: christopher.s.hall@intel.com
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 2/5] igc: Lengthen the
 hardware retry time to prevent timeouts
Message-ID: <ZrTcCrwBSo4RtYjj@calimero.vinschen.de>
Mail-Followup-To: christopher.s.hall@intel.com,
	intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
 <20240807003032.10300-3-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807003032.10300-3-christopher.s.hall@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Aug  6 17:30, christopher.s.hall@intel.com wrote:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
> Lengthen the hardware retry timer to four microseconds.
> 
> The i225/i226 hardware retries if it receives an inappropriate response
> from the upstream device. If the device retries too quickly, the root
> port does not respond.
> 
> The issue can be reproduced with the following:
> 
> $ sudo phc2sys -R 1000 -O 0 -i tsn0 -m
> 
> Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
> quickly reproduce the issue.
> 
> PHC2SYS exits with:
> 
> "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
>   fails
> 
> Fixes: 6b8aa753a9f9 ("igc: Decrease PTM short interval from 10 us to 1 us")
> Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index ec191d26c650..253327c23903 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -564,7 +564,7 @@
>  #define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x3f) << 2)
>  #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
>  
> -#define IGC_PTM_SHORT_CYC_DEFAULT	1   /* Default short cycle interval */
> +#define IGC_PTM_SHORT_CYC_DEFAULT	4   /* Default short cycle interval */
>  #define IGC_PTM_CYC_TIME_DEFAULT	5   /* Default PTM cycle time */
>  #define IGC_PTM_TIMEOUT_DEFAULT		255 /* Default timeout for PTM errors */
>  
> -- 
> 2.34.1

Reviewed-by: Corinna Vinschen <vinschen@redhat.com>


