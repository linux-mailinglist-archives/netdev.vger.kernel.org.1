Return-Path: <netdev+bounces-101070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACA8FD21B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B282817B0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5798481B3;
	Wed,  5 Jun 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAlaodU/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F127701
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602759; cv=none; b=tp6csAATkOXSXBbn05l2tE+kGnt7lcu2iuM4IqdbgtbKDcLUzcx2GqnFRxyZWRSlp32dvpDuIGu4t7r3u42L9MGc2OddynkPF2pU/pCoblqTLHj0vfY18TgJwcC81pH85WrEbvXWnoy6Fq0PUU2U1Wx47NGbVCEJSfW4wdn/hY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602759; c=relaxed/simple;
	bh=W2oKIm0GdlgwzHit2nJElcoKzROwGdhheGEDBU1Wnzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rHpY6do0VGOMpbG7uaQ5f99XyOjtOMej1DlyQTgGarPcuIrT2xo0MNTL3k0ghZLYQNCT0qGQGiCHhghoMtm9XVMgkvjlLQDdlJSMrcBWVuXwR+2xyG2LP0U0lbfTvgdYTHmec23SSRJJzAmWKtnluj45qETnygp6/hOVXmdhLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAlaodU/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717602757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o86yVAi5QDpJBuWopkILCsmGlzzwb59DBBI9s7V74wE=;
	b=SAlaodU/BRLHblRg7YRbGPVCRqBUFMH10+rJ3ODpx6g5xOmn2MbCP4aInWJ5Ko1/U9z2A7
	s+gY4kc/jVhRuJkoZRa6J5PI0CRyLHf26dl7A7pXdixQl1dxCYpCjN8j1cWDXK9GAJksJS
	N/5WmOdTgF2rz+0adsYPfB0Ezd3eKp8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-ViJ2rjHAMUOCL0HB0pkH1Q-1; Wed, 05 Jun 2024 11:52:36 -0400
X-MC-Unique: ViJ2rjHAMUOCL0HB0pkH1Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4214f7621e6so2712005e9.2
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 08:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717602755; x=1718207555;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o86yVAi5QDpJBuWopkILCsmGlzzwb59DBBI9s7V74wE=;
        b=AkZtTAPbUKm1mwORYVte6/Xe0PIuzXIGp3Tb6N9+duSCgIgjwsZAA2xR2ndtNMM+/9
         qgQnZZoNZpJ9aTTI9ijiR9lSi0wyWstXESAP6/g067y7D46QV+eSQillRPcviX/oCL3T
         K8c5sNcf0gUbI86sC2MBXW3jWIhg74JTmU6BjTZaWOb9+GejE+/Zp3zOWeQPNWgJJoxg
         kuxGd2Lf3O4eUXTUCEZWOPCAThUFaz46dK4Hise2lLSIE1PwGXH3gpNwU0w2IUTE/2sZ
         hic8/Bun+Gjj2Qop4S3aiAS07LhDEO0oRd6SzI2WuyFWUso8HH3CVQnTRwumqI03y9zp
         jYOA==
X-Forwarded-Encrypted: i=1; AJvYcCXQDOlyPqKCk++s2L6cUPpMHeTooH/42GLcwwQpTeTHDpeG44x+cPUf6pD7QIQi7IkUaCPD42CXIq9+NFsyNZAjmnFatpnn
X-Gm-Message-State: AOJu0YwvrCRfyd3sSFVuvvJa27ynD8XIyp29IHch82mB9RDVgE55IBLC
	gBT3We0GodfUEnhWCOHapvBHY8oIWsG9t8GIxmt7qpf+8ebAb/Id9iMdVI+jvuf6FgYAkUwEIe4
	RL9hJ+OKjZi93q72c11+OSJGGx0NkEkJ0E8QRAGW1y9jwgsUffDcGEw==
X-Received: by 2002:a05:6000:b41:b0:354:fa0d:1422 with SMTP id ffacd0b85a97d-35e84047079mr2188210f8f.1.1717602754831;
        Wed, 05 Jun 2024 08:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENrKBn6ER96mBbWTUhPE04jqYgOgMVO31t7eTuJP8zcs+0ahweYyP2O04AEJX2ffbmamHzJg==
X-Received: by 2002:a05:6000:b41:b0:354:fa0d:1422 with SMTP id ffacd0b85a97d-35e84047079mr2188187f8f.1.1717602754395;
        Wed, 05 Jun 2024 08:52:34 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b74:3a10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04caf05sm14827637f8f.42.2024.06.05.08.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:52:33 -0700 (PDT)
Message-ID: <ddfc4da97408f6c086a9485d155fa6aa302fac88.camel@redhat.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
From: Paolo Abeni <pabeni@redhat.com>
To: Cosmin Ratiu <cratiu@nvidia.com>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Cc: "jhs@mojatatu.com" <jhs@mojatatu.com>, "sridhar.samudrala@intel.com"
 <sridhar.samudrala@intel.com>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "madhu.chittim@intel.com"
 <madhu.chittim@intel.com>,  "jiri@resnulli.us" <jiri@resnulli.us>,
 "horms@kernel.org" <horms@kernel.org>,  "sgoutham@marvell.com"
 <sgoutham@marvell.com>, "kuba@kernel.org" <kuba@kernel.org>
Date: Wed, 05 Jun 2024 17:52:32 +0200
In-Reply-To: <abe35bb09ff1449eafaa6b78a1bce2110dee52e7.camel@nvidia.com>
References: 
	<3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	 <abe35bb09ff1449eafaa6b78a1bce2110dee52e7.camel@nvidia.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 15:04 +0000, Cosmin Ratiu wrote:
> On Wed, 2024-05-08 at 22:20 +0200, Paolo Abeni wrote:
>=20
> > +/**
> > + * struct net_shaper_info - represents a shaping node on the NIC H/W
> > + * @metric: Specify if the bw limits refers to PPS or BPS
> > + * @bw_min: Minimum guaranteed rate for this shaper
> > + * @bw_max: Maximum peak bw allowed for this shaper
> > + * @burst: Maximum burst for the peek rate of this shaper
> > + * @priority: Scheduling priority for this shaper
> > + * @weight: Scheduling weight for this shaper
> > + */
> > +struct net_shaper_info {
> > +	enum net_shaper_metric metric;
> > +	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
> > +	u64 bw_max;	/* maximum allowed bandwidth */
> > +	u32 burst;	/* maximum burst in bytes for bw_max */
>=20
> 'burst' really should be u64 if it can deal with bytes. In a 400Gbps
> link, u32 really is peanuts.
>=20
> > +/**
> > + * enum net_shaper_scope - the different scopes where a shaper could b=
e attached
> > + * @NET_SHAPER_SCOPE_PORT:   The root shaper for the whole H/W.
> > + * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network dev=
ice.
> > + * @NET_SHAPER_SCOPE_VF:     The shaper is attached to the given virtu=
al
> > + * function.
> > + * @NET_SHAPER_SCOPE_QUEUE_GROUP: The shaper groups multiple queues un=
der the
> > + * same device.
> > + * @NET_SHAPER_SCOPE_QUEUE:  The shaper is attached to the given devic=
e queue.
> > + *
> > + * NET_SHAPER_SCOPE_PORT and NET_SHAPER_SCOPE_VF are only available on
> > + * PF devices, usually inside the host/hypervisor.
> > + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
> > + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
> > + */
> > +enum net_shaper_scope {
> > +	NET_SHAPER_SCOPE_PORT,
> > +	NET_SHAPER_SCOPE_NETDEV,
> > +	NET_SHAPER_SCOPE_VF,
> > +	NET_SHAPER_SCOPE_QUEUE_GROUP,
> > +	NET_SHAPER_SCOPE_QUEUE,
> > +};
>=20
> How would modelling groups of VFs (as implemented in [1]) look like
> with this proposal?
> I could imagine a NET_SHAPER_SCOPE_VF_GROUP scope, with a shared shaper
> across multiple VFs.=C2=A0

Following-up yday reviewer mtg - which was spent mainly on this topic -
- the current direction is to replace NET_SHAPER_SCOPE_QUEUE_GROUP with
a more generic 'scope', grouping of either queues, VF/netdev or even
other groups (allowing nesting).

> How would managing membership of VFs in a group
> look like? Will the devlink API continue to be used for that? Or will
> something else be introduced?

The idea is to introduce a new generic netlink interface, yaml-based,
to expose these features to user-space.

> Looking a bit into the future now...
> I am nowadays thinking about extending the mlx5 VF group rate limit
> feature to support VFs from multiple PFs from the same NIC (the
> hardware can be configured to use a shared shaper across multiple
> ports), how could that feature be represented in this API, given that
> ops relate to a netdevice? Which netdevice should be used for this
> scenario?

I must admit we[1] haven't thought yet about the scenario you describe
above. I guess we could encode the PF number and the VF number in the
handle major/minor and operate on any PF device belonging to the same
silicon, WDYT?

Thanks,

Paolo

[1] or at least myself;)


