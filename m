Return-Path: <netdev+bounces-88162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00578A61E1
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 05:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74AF282EAF
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9551CD06;
	Tue, 16 Apr 2024 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT0crxME"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625831BC5C
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239578; cv=none; b=geUWNukF4I8oRJtopv9L7DDzpB+jx3ukHNlOjlfSqXhmHeK3JvOwCqDa/0PL+67jRG8dbQuFSGERgJyRdnxlA0+O1XTqNeZFrST6Ds2hhFbIFV2g9/CSW27XlbXxC1EAbO9o8F3Ha133APMxLjyblf7RWK6OAY2sVSn4QKsfcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239578; c=relaxed/simple;
	bh=2sgJxnJigr8wcFGR1iwhSNcT2nBcK5Eld3s+LF+X6uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smU7gH1m/QC++OehN9zoPnIq/+ILiVg1n6T0uy2VsbdHwX0TitgLVdCaqVCR6TvirCP+hlOVbncRICD8Ot280okZHwkLqauet01zQNGTjWw69gwF8m3RuEvyeVkIG5BHYFUCHsrZilhydVeq0lg0dlYqcOnBAUqfdIu6DwcHP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bT0crxME; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713239576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbgF6/U11epiwGC99e3x/yP6nFxwSBfWiCFk3BvgC/U=;
	b=bT0crxMEj4jGu9Quc3xdrTzwN6x849XvSdZkXjNIIFZmQEUTvCV40MjxbfnVs3C4DKaryQ
	P9yMvfUJC08H8iTFPnjcCe8fZH2gmVL9PHJNzzT1hHtJ2cOfAZynilNLblZokr13aX3T3G
	btLrDNV3YjRg2A1I0f/14sj/OQi8exg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-bbwgo_eNOPqTxQeDaIdMtw-1; Mon, 15 Apr 2024 23:52:54 -0400
X-MC-Unique: bbwgo_eNOPqTxQeDaIdMtw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed25ed4a5fso3852754b3a.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 20:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713239573; x=1713844373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbgF6/U11epiwGC99e3x/yP6nFxwSBfWiCFk3BvgC/U=;
        b=CBETbWDq7IRc5JZdiVB+qnnElPXAhuYl/AWi6dm/hDz8HEC38tnaP9j8Ixs0YuWS0w
         ++GbwQX64cX33Sn/gGyOe5i49r+lndoAFaNHbM74muB3XyZuye4IVBXMb2LQJf/vPWir
         gTNNfuL4L32C8f2r2gxrI2ZV+lWxhMKO8BYdQLAoQ3uNg88atRkz70UaUnjHYM/tXloc
         glc6g2WgV6yCube6Qk5xtelWll1DQwnWsAHuQFj/rDQeic//XObUCyyCjxuOsyjcCf80
         00a76J5AhOYpAU+q84NwlM6HlyOgdpO/2IrS2IZS+lKYCcFhWyuGGFXtq1EHx4mjQiHY
         Y7Kw==
X-Gm-Message-State: AOJu0Yzwb40//+wEmFc0AHxDovfCTSE3QfrghszWRojSbo0xl+jLBS3/
	fLvZxACwc7IjOYjkP+UzVD1pKt1ObbbQsARtC9o717V0iSUtHhXJgbYKL6BB5gtLt8CQ3rCkJoN
	6Wy9w9c+931YEkIVHSOsqKI5UuMxQ6Mrm+N4ndIv2BgKY4r1aebiN4eHZhY/rI9bkAD/sxdSiTT
	AiR/fDSyaHeNk69xUx8KVRGAxq702U
X-Received: by 2002:a05:6a20:1a91:b0:1a7:802d:f67c with SMTP id ci17-20020a056a201a9100b001a7802df67cmr12232025pzb.53.1713239573413;
        Mon, 15 Apr 2024 20:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHoyAP1wkJw/DB1EQ793IhrBgwbVmMVVgNjLcjYO082GE/+PThXolxxzYq5LJiiJio9HBvdJXNAxfQ9evpVQ0=
X-Received: by 2002:a05:6a20:1a91:b0:1a7:802d:f67c with SMTP id
 ci17-20020a056a201a9100b001a7802df67cmr12232013pzb.53.1713239573117; Mon, 15
 Apr 2024 20:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415162530.3594670-1-jiri@resnulli.us> <20240415162530.3594670-2-jiri@resnulli.us>
In-Reply-To: <20240415162530.3594670-2-jiri@resnulli.us>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 11:52:41 +0800
Message-ID: <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>
Subject: Re: [patch net-next v2 1/6] virtio: add debugfs infrastructure to
 allow to debug virtio features
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, shuah@kernel.org, petrm@nvidia.com, 
	liuhangbin@gmail.com, vladimir.oltean@nxp.com, bpoirier@nvidia.com, 
	idosch@nvidia.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 12:25=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Currently there is no way for user to set what features the driver
> should obey or not, it is hard wired in the code.
>
> In order to be able to debug the device behavior in case some feature is
> disabled, introduce a debugfs infrastructure with couple of files
> allowing user to see what features the device advertises and
> to set filter for features used by driver.
>
> Example:
> $cat /sys/bus/virtio/devices/virtio0/features
> 1110010111111111111101010000110010000000100000000000000000000000
> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
> 5
> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
> $ cat /sys/bus/virtio/devices/virtio0/features
> 1110000111111111111101010000110010000000100000000000000000000000
>
> Note that sysfs "features" know already exists, this patch does not
> touch it.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---

Note that this can be done already with vp_vdpa feature provisioning:

commit c1ca352d371f724f7fb40f016abdb563aa85fe55
Author: Jason Wang <jasowang@redhat.com>
Date:   Tue Sep 27 15:48:10 2022 +0800

    vp_vdpa: support feature provisioning

For example:

vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000

Thanks


