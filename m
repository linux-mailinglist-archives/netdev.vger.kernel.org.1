Return-Path: <netdev+bounces-113878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEDA9403B1
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 03:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E60282308
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 01:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621E99479;
	Tue, 30 Jul 2024 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GT/pXWaq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBEA8821
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302936; cv=none; b=t6HIOKb0HJehFqMQqzSJJ1amGtZ4D37Unb1/6GVOcmmRcPMSYM4nWMstiIARlBWf5N2R7DRFdUyNgSy2lpq9FfrlxSsU9I+sgB710sorr1wWukqT21lRDzyTi2+zm21LbWnz02qEzSXVpIJxEg/q3EQqBPPTiyqELdJKKPMJSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302936; c=relaxed/simple;
	bh=1h6fzE7CDmV1O0t5HtGQutaiZcu3XDixPdfniPx64Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICWL29E0MtKo0+MJBiYWFJn90MCEdwrz18j8FrLOk6c1O/5UJN2b0R1E3HF94r5a7J+Pc7EamCuxmbNUUWHlR7NOwAoTd8ylHZsOPpss4bQd5PH8a6YKrzcX+31wHCp01HjZ7LdGojxe+Nngi7K0QkIU2GyBAZTXfgMb5jbm0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GT/pXWaq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722302933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rmIJ5vFT5Yjjbs7pVvMcPXGKtaSi+0yKhvgi7LK01Y=;
	b=GT/pXWaqHLcCLc1Bne/AMP3mTy+uaKQtGtcQTmfBxR2X01LnUhmht71Hcd+RpHp9TlfaRl
	L4j+U8tQx42VlZL7rqU3xySDQumitrtoYrpdhkfClsnruwejSSVMkGGYlrW3Uy4nC4U7xT
	2lhh5d44LagcGU0kya3Te9FCVg/AvfA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-OG87ry4mMtyld3lTwFoHKw-1; Mon, 29 Jul 2024 21:28:50 -0400
X-MC-Unique: OG87ry4mMtyld3lTwFoHKw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef3133ca88so39077671fa.3
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 18:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302927; x=1722907727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rmIJ5vFT5Yjjbs7pVvMcPXGKtaSi+0yKhvgi7LK01Y=;
        b=P87i+ppW+ShsuvGvlu8X+U/puhD/Mv+uL+5HEMQu/RtqX3UdczergtfeVzx9He3c/t
         NMoS0L9gt3xLW8GSat97uMTwfFnmSJ24HHAOtrWySmXJ4Ew5ifY+s3UvTXFM4Apj90Oa
         5XDWC2QNRfXCVertlm8wSsT15Ymi8h/Ag/PATcio7HMzEpNig88g9Pj5934ftrTHUBEy
         TBaYBMS8Lio16RGLH1nt8DCbLvjo+fN6WWVTnfiG1joEnzdy2d5McxsCcJAAP+h9JNZW
         3+uXxfWJHLSTlFHCTKsHCoVwnQrBVzcYtNYs3xyk+7gjAkEHkuogx0TN1s9m5YK1SdBa
         Lx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV5CDcugn9oopED7wV/GzSbTPf3a/3myb9oVCaZ3CWsA0tQ4QTIlcNpa/v1/pzDdwABBzUDG+swTlnLdwa5LDaqEYZpf7g
X-Gm-Message-State: AOJu0YywJIVg69p1uoflBUcUyOOyknbS7o0VMKRIn/5zN+JWNLhFQYMF
	EYlVZHzY8VTYo1Ay/Fd6hCuxIRQxTbfrsy5fhfTG/90pqxfuOx8tRvdVtG/a81QF8twkDxE4Iru
	Tww6tipHao+LSYL+iIm2dqzsEP8v5p3cKi1TI4ZddPzqavN2ZkygqX4CruwmgB/DVzCkVH1fnJS
	829+1ty9Yr9sSxlLo6QiEeJmRRigY4Ob/4WJsi
X-Received: by 2002:a2e:8ed6:0:b0:2ef:208f:9ec0 with SMTP id 38308e7fff4ca-2f12ee05f83mr63094061fa.14.1722302927737;
        Mon, 29 Jul 2024 18:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtzdiCpJ9XgLdCKEY4EksF7k+lVK2MjMN+/4Tci3YtSJYsZZW4stODQlF5ADRUckTfa0JhEthcKDqHdk90vQk=
X-Received: by 2002:a2e:8ed6:0:b0:2ef:208f:9ec0 with SMTP id
 38308e7fff4ca-2f12ee05f83mr63093981fa.14.1722302927388; Mon, 29 Jul 2024
 18:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729052146.621924-1-lulu@redhat.com> <20240729052146.621924-3-lulu@redhat.com>
 <a5898ab7-a2ad-412a-85e6-9c7ad590704c@lunn.ch>
In-Reply-To: <a5898ab7-a2ad-412a-85e6-9c7ad590704c@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 30 Jul 2024 09:28:10 +0800
Message-ID: <CACLfguUkEtB2cTBrsC_GaxxMdVk_kXjO-gokDUNdECSuCrsLoQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vdpa_sim_net: Add the support of set mac address
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 03:15, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
> > +                             const struct vdpa_dev_set_config *config)
> > +{
> > +     struct vdpasim *vdpasim = container_of(dev, struct vdpasim, vdpa);
> > +     struct virtio_net_config *vio_config = vdpasim->config;
> > +
> > +     mutex_lock(&vdpasim->mutex);
> > +
> > +     if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             ether_addr_copy(vio_config->mac, config->net.mac);
> > +             mutex_unlock(&vdpasim->mutex);
> > +             return 0;
> > +     }
> > +
> > +     mutex_unlock(&vdpasim->mutex);
> > +     return -EINVAL;
>
> EOPNOTSUPP would be more appropriate.
>
>         Andrew
>
will change this
Thanks
cindy


