Return-Path: <netdev+bounces-88912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759278A8FFC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 02:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0F41F225C6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 00:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6E19A;
	Thu, 18 Apr 2024 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaJOztJx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0566FB0
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399864; cv=none; b=ukl8HSiHXuDfXK9iyO0gUxGk0TFqR5akiuWBtPsM8oHDQ64R9/UoxMxsKtd+MYDzQereho+JYLrHbLEq+ADbjAVYmv/XxEcu9Mfs/Bg0KDU077IiZB+SW20Cm7pnhRkfhgbYCyQSxxCDGtYYpTvjgtI7UVYHOq9eelpxSDA7ozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399864; c=relaxed/simple;
	bh=6ygLYaCatgmj8esyzxPKSf1Vm5MNhsxUau+glf4fnUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfVMHsy5C6ssctLd+zC0RR81jxqE7WxM4Vt/TLJ4GMGJFNE2j9OD7hBOLyEuiMjlSAyyAmh0lNNsTaef9r5ODYbWARYMvGRd2xMWhrq+av24FFuLbwf3rsTF6c5Ihz4AGCpytVGPmOsd9rFO2VXZsNQ6kGtDE5YX3Jd50zucl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaJOztJx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713399861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ygLYaCatgmj8esyzxPKSf1Vm5MNhsxUau+glf4fnUA=;
	b=FaJOztJxWilrvGbId2OC0hGs66ADdtZJ3vDoB0dRTECoX8yeNI6Mgtvl/ybBVkP7uA1/QH
	lE79zXmYRH/+GhuxpwWbMZkB7KQ/44xmlbjr8WOfOiUdUyPA9f6hukZ+1prMU0l3XCUHIx
	kPZxr0BM9ypjF89lVpRVYqSpIf50eT0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-EeiwUPlkN42HN1NA0qOAqg-1; Wed, 17 Apr 2024 20:24:19 -0400
X-MC-Unique: EeiwUPlkN42HN1NA0qOAqg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8bff2b792so278749a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713399858; x=1714004658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ygLYaCatgmj8esyzxPKSf1Vm5MNhsxUau+glf4fnUA=;
        b=fDsjcqVZFOLP90GgK9/qLCitbDTL4tTh/SRahN79YeHLdQsSpZRljGaNVJQ23XbqD2
         QCDcwvApMkCkNJtwa8qmUN33a/E1TJfD7nhKlcPWyFZn2UJWCjWeOduW+0fUgy+YkhoD
         j5m3KXe3w4On8CdM5RtSeoOd4mnuj1HZRLJlWvSKxLbTQWjYT1QtDjIK1N5GeCYNP4Bj
         sbumm6mEbVUIRMs3N6k8uYWMkASDSnFExtrbvfYxR31NxXIvBtXbH2vx778kxlbynGUj
         CeWpFdPirWMQZvnWjZSTS0CZaD9hAnVwBGyejjCpUXBp4XaB2tqJgtjHKs8BBXAWAKvX
         cogg==
X-Forwarded-Encrypted: i=1; AJvYcCUlPdTzDEQD72ScUAl3xWxCllZeLCsC6g54p66pELGfn+Oq06Aw3S+6UWFxFdjqKofhZm1Gx0P/rC4jUBz03mQHc4fPKGPX
X-Gm-Message-State: AOJu0YwvKaxad8tDngYtdm4kviu2eJStKXfuIgjkN1x/m3w6XAAVr1HX
	Q8JogtGuVrM7mDDVY/xMex+fHhj3m5ni2EJEdcJzUjexeF6REtKUMTPAJC+Ne1PnpFSqxxCuEu8
	jFHINrBTEtrj4PSBIqChvOFoVTs06O/67YEBbwmgm3UxDmrrKr8K1MCcdAvu28d6Ac2Oz80qIbk
	Xbn4pGhrw28L+Kpf3/XiVExfzaaASH
X-Received: by 2002:a05:6a21:3a48:b0:1aa:9595:4261 with SMTP id zu8-20020a056a213a4800b001aa95954261mr870724pzb.22.1713399858441;
        Wed, 17 Apr 2024 17:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElOi+SwtyiWKoWx9Rs4yVtkTdu/i6pUpqiCyZiV2+/NEDFVMxkU8nklag1Drtb3Woi5q0BV46joIjy5ZPGPbE=
X-Received: by 2002:a05:6a21:3a48:b0:1aa:9595:4261 with SMTP id
 zu8-20020a056a213a4800b001aa95954261mr870713pzb.22.1713399858165; Wed, 17 Apr
 2024 17:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417071822.27831-1-liangchen.linux@gmail.com>
In-Reply-To: <20240417071822.27831-1-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 08:24:06 +0800
Message-ID: <CACGkMEuABgSn396Cfi1Pt42Q__fCsr-G3XJYZUH3CEOARZ5Opg@mail.gmail.com>
Subject: Re: [PATCH net-next v9] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 3:20=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing
> XDP hints through kfuncs to allow XDP programs to access the RSS hash.
>
> 1.
> https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.=
com/#r
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


