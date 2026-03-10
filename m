Return-Path: <netdev+bounces-266140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDDLLVEmsGnYgQIAu9opvQ
	(envelope-from <netdev+bounces-266140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:10:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573EE251742
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A3534B9026
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1D3A169D;
	Tue, 10 Mar 2026 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+cOK+VW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48F39BFE7
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147253; cv=none; b=cZyqfR9VPcPnUfj5SNLzYKq3FlfGWp9FfOZzhrr9S0qzRqwgYLphz7pQd64S2GhazvIUNIe9Hpmyu93XdXP4jmSXZnpWU+NFX4z1D8NAWt1X3tKJqcYaEOyIKghhluEtAna3+0fAvpZgnq9s2NAWGkrfWtmEUKXKQRxQwb8SAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147253; c=relaxed/simple;
	bh=TgoJchP8+G/BTHDKgmEWupOwORUqE0/FZPIUEYu9Z9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esx56VI6jfGGaR880chngmmOgHQ5/lYhbqp2VccRVd17XIiyD0uN4VJtlK4RcJlyj965FDYu7/2fbYOi6ZS/jpfwuinx8NndAFq9DT/BgBLaHb1iSE+Dn73rdf+NND++OhA0MCi08xpo0x4wf2yUnMbLUCnMH+SPRc5qipdSvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+cOK+VW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aeab6ff148so1575ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773147248; x=1773752048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
        b=0+cOK+VWVXA7uE31Sh5y2bmP9hRSr0LFsM2f3kDgfCZ6lyHaVbAytIQCv+2vF+eTEx
         oUic6e9ZAVnZqnGzIPB8kHUyMA2zwpMw5U/9RUdKEhoG2/xX9/VKIHC9XNEBOVXeDKo9
         mU/QEMBf02iFKn4H5erDKYU3pW/pqjbI7j+6ZcB0Qt9z/KGqBlkshVJTzzKx2oXtAxlL
         E18h73O/s3dn+xBEwK308w7agQS5m2RYZzHNrLUdhfdZKeG/e+Dr27X21QpoIwd1KCAl
         PxttLdZl6PZf2goM/cRw6Bbw12/00xnTFdgSr8ytAWjU88JMxI5kTd4reOjRdKpNjh+N
         Ix/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147248; x=1773752048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
        b=Wn41boI7Ld1qSugJBrvOjSQEi1Wzw691Mtmrr+zss1MJcxK+ZUtoSfD/ko2CSUL0wh
         cEc9eabKIRoesX4FxRW4M7tW0/hGsv9mjFEP83oZ5ZnjKXnFZL+EFDzKjlrvijh3j7Z8
         nxBRfTAOUH0jBiZwnpr3vWNotb+TLLyMTj7hPWEeLfUagkJR5u0P1bjKZY5WJjwpSUSh
         KZLJWmoX5jhne9F74/YJxtxXRH0W29vWuAbJCuTd7UoCMD4WWQexEBA2FkXWQw0v7ows
         fLpv/TjhXWyfyV+A2MHuE6wgifZxL1A+gsNGT56puDjOFYmGp9uLL7Y0KX0Ei9E51TG8
         p4Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUBw7yvVEMvuvc8X+6RveOnBOKlGMCTwo/M68Xd0MNcOtz9W14AdASFr8GkBpG6Ice6TXWJM0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0g7CuQUUjDzQjqNrGzNBabQaYdcm75H0+PVFxDyNKQDqbIZ8
	iH3/SR0zq6obwj1Zuz5GC7P2UeDWjpeC1E2kHOsgkwx35N62X/v5rtrGpVC5hbmUYA==
X-Gm-Gg: ATEYQzzEpLBbaN2NRrEaWqke9ljszGcX7T1y6zhJM2xBxUoPZaw2Ss0UFSsHr/VEEvb
	TKCf8MItXHM6GrsT+m/eRW5z0SSAIuupXjCGWE24nxqZtAes2XkvNPgdc2MDAjJcIn8Nm61artC
	r/KK2mbjHyzhhCOjt5DSpqfRO8y03WaIpNobjIq6CdrG/BBiRvy5Aj9Bh5iYRFXJqAuLd2u9i+h
	S0WMAJPBXZt2W+e9/kdgfFxspmx53Ey1XZYYtiibkYSBKkpkCweVT6md88CEc+EYZ8mPGy3JmiS
	hj6OYo2pRAJ6So5MLOo+Wo7NwrQc7/d+b6zT8YHiYzGN0VD/GR4A0HaRMnrxsR5LmiYTQm/ojaV
	Be5pElh3SKjFeXd0H5x3eCESm/SAYxWrRQrZeWYy+c053SpuJPlrG+yG1nOp2O0x+CUwiG0qxbQ
	l3zSkj9AUSFYTmU/d8gX/S0yZy7gLSqbDpmoiyOZMqrz3bMFlUSWWKbmi6oA==
X-Received: by 2002:a17:902:ebd2:b0:2ae:45bb:bc4e with SMTP id d9443c01a7336-2aea30ebe48mr3008685ad.24.1773147247400;
        Tue, 10 Mar 2026 05:54:07 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0cb73dsm12445679a12.11.2026.03.10.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:54:06 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:53:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAUYvx6VEdSmInm@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
X-Rspamd-Queue-Id: 573EE251742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266140-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[55];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,avm.de:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:49:12PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/vfio/vfio_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15d4dbaf9ebcfb2e67627db71521e0..d71922dfde5885967398deddec3e9e04b05adfec 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -923,7 +923,7 @@ vfio_ioctl_device_feature_mig_device_state(struct vfio_device *device,
>  
>  	/* Handle the VFIO_DEVICE_FEATURE_SET */
>  	filp = device->mig_ops->migration_set_state(device, mig.device_state);
> -	if (IS_ERR(filp) || !filp)
> +	if (IS_ERR_OR_NULL(filp))
>  		goto out_copy;
>  
>  	return vfio_ioct_mig_return_fd(filp, arg, &mig);
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

The cleanup alone looks fine, but I'm not sure if the maintainers would
be happy about the tree-wide spam, since each patch might go through a
different tree. I'd wait for Alex's preference/ack on that.

Thanks,
Praan

