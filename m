Return-Path: <netdev+bounces-257821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FoVnEYZ5iGlTpwQAu9opvQ
	(envelope-from <netdev+bounces-257821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 12:54:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92904108940
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 12:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F219D301050E
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 11:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FF335503D;
	Sun,  8 Feb 2026 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQwxfzqY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3VFoDDn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931934AAE4
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770551682; cv=none; b=nwbSyxHd/8EjBre18j4IK/hS4pMFdUlWx/njK/SYoB+vBxxkYgrUOOrg3v9Pl1JRNAHYt1sSPlCLJcoq9XMJtbZG65YpMTx6Eafspwk8m1miXdOfp77pDKP4jneZ4t9IYZddqeEvOPtoX3vrf5u8ArjzjbMWSCoYvdknYuQVzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770551682; c=relaxed/simple;
	bh=TvWEngvMoPQLfKVyDs4XmVBpluDLYqdvpBEeahZNGvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGlbVAoP3qw4be8OLry+ERxERTpOpsPfhGW4xp2smhQeR5SwSRybNogzyj2LQo3EDqcjG1tp4oBG5tF5NwWfgeN8ANuEPXahPCAPaizNSd3y79GqfM8RpJWBcaFTMaLg8mTSngFDWTWeXdOVRSRQTPAIt1rjLt8LPi07e0wvAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQwxfzqY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3VFoDDn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770551680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nvl4g9KclHkA3GKW58oziSPsnURrFzYwrfY70D3VSlw=;
	b=VQwxfzqYcR3kKibPxqo9eFTDDqPOOH8gO3NQ2oLFnVQsTeJr+vxQcqekIAFRmSVJxZ8Drn
	sJq5S5pKq/1pF1d2Si4uhdnjlNjL31VuilyUWGWPFw0DUv/e2VsaKEE46+M5nCI1WoWJQe
	Qp4GgQ00pv7wXTgzZ5C0UxZhcDFy7uA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-sYJ5cP4CP7yLgqUhcRe0QQ-1; Sun, 08 Feb 2026 06:54:39 -0500
X-MC-Unique: sYJ5cP4CP7yLgqUhcRe0QQ-1
X-Mimecast-MFC-AGG-ID: sYJ5cP4CP7yLgqUhcRe0QQ_1770551678
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435db9425ebso3186565f8f.1
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 03:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770551678; x=1771156478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nvl4g9KclHkA3GKW58oziSPsnURrFzYwrfY70D3VSlw=;
        b=F3VFoDDniAPrEVypecX1isBotOSIAqHHOA/3Upj1Rj30I0yTLdQ9c3wrwy693/RZ6/
         CjjpC5ne66/LoQoncHcYLpq76NRW/24sC7abfvE/2aeDMjLlp0a1/mZa9iUA3O8qrm2K
         w5n1B+FwwzBgwt/wktWNalaa4XJh8AEnu2NTqu4Lvph1Q/VePT2UhVvfLeCEmxi8Wxoq
         dpFNpfX+3pYu0GuFbjBpySYjtYF4eNVv4K88qU1EjfzWBJKMhR1jVZkb1c2eF8AN+1DU
         /Dh1zAcDEHwfOK2t0QqLo5O6g7CxOOapn1NpzquOrGSnT8pL7dIiL6p8xy56cTKUamKS
         CxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770551678; x=1771156478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvl4g9KclHkA3GKW58oziSPsnURrFzYwrfY70D3VSlw=;
        b=AAPLVDPKA8qz1dPXCZhHkPq66It/UxyqiMrgxD0ZO4TZ3qU9aX57zwE7SaUbjHPR9W
         IrlezsTe9bawvOWjLI3INRNnaeET3mehQTrhSLjYrzY7xZ+lQiBFS285T0xs1MLIVC4n
         4qpVRbLBc/ZCx8VyTFAoBM++enNFgTC20z2TlZp4dL7xvpzruqJufNxBtBtVd3MgyXBI
         6WeLocPPAnsIUdPaxL+FRfQ+0b7eQXsQMgiBer9rIauT18bAN5srEuTbEUZqClQng33K
         Xm6G2RReTVvhhr3NIrdbp2nQU/5S3dydiBHAwPcrby1ThjhSACjSO0/LH6N0hUXf2Vuk
         TrXw==
X-Gm-Message-State: AOJu0Ywg9aC6dTCDvjYyT1EU9UPhCzQ8lUQznfGuiTzKMHAGn2FHaNnw
	NUbbNp+8yR64HApGLO0J6QVxCbGdC5c56mdKq04h+1GCNBkdZq/oqfZvN4ioyvdpDOJBXQQFEKh
	BBdL5arl/jIinGr/AwzZsU3zXTNk4FJ/6QtwmCJLWZ4aSfO3G+VDcKX0DHA==
X-Gm-Gg: AZuq6aLA2vkuVdVNdMY8CWgqe59Ir3SXEGP89X4XrV+h2Hfqw3D06AVIwtxmdQgR4Os
	Le/KTjfA6IYCYYYh+PAoQaptr+RezzCmxozGyoEqvd89ocrWPXRop68Gkwf1EzhbJqW8iBvYTj2
	7xseb549HjNNEcN0RYFB/TVW8xt4wD4odo3d1Kp99m7YIGc2kh6pCrTGe4/glpSIVbheIheE9y/
	VCu7+AQ+Mk60jOQzkmKgk4c/g2OXebpNwhY0UegNlFKgXDhMSwqSMSXzG0CVBSAQEka1b6b42Wg
	2MM2001SXmSVfBtrqBYIUeHmmWDaGo9rZ/vlRAmozDUBBYDHfHMBh708kOcjtiObQuXfSMDw1F0
	ySBDHaXzMKwLBZRqPp2iJZe9R6/5hj04I7A==
X-Received: by 2002:a05:6000:26cd:b0:431:1d4:3a71 with SMTP id ffacd0b85a97d-43629345e67mr12971514f8f.27.1770551677851;
        Sun, 08 Feb 2026 03:54:37 -0800 (PST)
X-Received: by 2002:a05:6000:26cd:b0:431:1d4:3a71 with SMTP id ffacd0b85a97d-43629345e67mr12971487f8f.27.1770551677323;
        Sun, 08 Feb 2026 03:54:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376accfc58sm3853360f8f.16.2026.02.08.03.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 03:54:36 -0800 (PST)
Date: Sun, 8 Feb 2026 06:54:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20260208065146-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205224707.16995-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205224707.16995-8-danielj@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257821-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92904108940
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 04:47:02PM -0600, Daniel Jurgens wrote:
> @@ -295,8 +301,16 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_data *ff_caps;
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
> +	struct xarray classifiers;
> +	int num_classifiers;
> +	struct virtnet_ethtool_ff ethtool;
>  };
>  
> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				       struct ethtool_rx_flow_spec *fs,
> +				       u16 curr_queue_pairs);
> +static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
> +
>  #define VIRTNET_Q_TYPE_RX 0
>  #define VIRTNET_Q_TYPE_TX 1
>  #define VIRTNET_Q_TYPE_CQ 2


btw reordering code so we do not need forward declarations would make
review a tiny bit easier.


-- 
MST


