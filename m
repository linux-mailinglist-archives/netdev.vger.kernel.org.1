Return-Path: <netdev+bounces-77771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13E9872E68
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 06:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729F61F21401
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 05:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5001D1B7FB;
	Wed,  6 Mar 2024 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1dv+Wcd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAC15E88
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703151; cv=none; b=PQJkLDK8uSNUvJ16VTepQfnbnVhwEsCueYlFZDJRAXwPcfAWAzgEZ56ByP4lLz0apFkPSLs7Zav2wQ2zHTeKZwyq6p83FebSDfvJ4SCpaUnjmk0icAb7kRHwSLxNsvTNgN72EiNhljpkPHqI1BPymQghN+X1S2tDHUaoLDIOfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703151; c=relaxed/simple;
	bh=TU6enkAGhxLVo9zYShsbcBwAQaBFKNnqNn+vF6qWndE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jH/dk5vtIcI8WpTKz8JUxP0lpr9uiSXunjK/kr6xskLEyjF5c9zhABO25oZaJGGdlvG/yJIFPdffeiaHEETueD2boZ8Udjv6FZlWCWUsv7b92CPyLTx+htyGOMRHfNwAHfVCY8NbunEXuiNUeLgyBibeGD1J5lZtwtdLwKY8zU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1dv+Wcd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709703148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TU6enkAGhxLVo9zYShsbcBwAQaBFKNnqNn+vF6qWndE=;
	b=T1dv+WcdWYKcByo0uJmYOsN4AmmTeXH7YGC3F0ki0PFx+Xc3mpEfRwAe8jSvTCqcrjWw7i
	dbPZy9vfhwAvHSvIp3hfYcNxVHpvgeUrQCOKMSbagSyzvkKPHQd5qB/9COAHF8/hRlViXP
	hNuXvaH39HUOZQ/MUIeoYJWT+hlGUJ0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-UqMUXn_jN0SO_xKLfCf0VQ-1; Wed, 06 Mar 2024 00:32:27 -0500
X-MC-Unique: UqMUXn_jN0SO_xKLfCf0VQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dcfc679d26so28447305ad.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 21:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709703146; x=1710307946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU6enkAGhxLVo9zYShsbcBwAQaBFKNnqNn+vF6qWndE=;
        b=hbH3lYDXZ225N90oJW3FK57eC1iXSO8RUUNJZsSPVJKr4iYxwt70BdPR5ceRWunJGf
         Q4AjRXpz0I9AHGm0ASV4+RVL8f6Kwvj5R8nXVDnOn+rG5bENP6vUEEgKTokt7cnp8Kid
         Q/meL0lIA8cYRCm92HIp53U4ApZm4nd7s040RKXvlhszfDkBVYDKWrErifVBUPVsNWGk
         8jwho4AWyqU5+Chif9GKBmLfx/R9hiPmc61HW/lfTN1aRr0S3Tez9YsSE3pm5HCCuv+5
         5PE+ALtV4Rgxe1Dwxn0g4QjANGPCQbpES3M4+KlLiTFT0VdxQQCN02bgOcyrt1AGrOzU
         sMJw==
X-Forwarded-Encrypted: i=1; AJvYcCVkmUdEnXZ9MrLzjUGm2p6wEoK54Alqsydr+RUC6QopmiWS5xez4NtIvCYOkfsgZ9OkAGOQ9u1sRkDFcmJcUVexK8MKJ9va
X-Gm-Message-State: AOJu0YzSw5hTnfwJ44BJhoFruP1P7pP9cH7Njt0dFq/8tyXmhuHqgZGD
	iXnE0CAID+eHT2CPyLrpPoGJxc0swiZ1B1Ny2704T8j2LIW9SD1YmcTyiYTep4kdrwyMf/WO/zb
	6FZmrtKXHXYoRdp23JYaMnzQ16MQ7RX74WR3O58afKxbOg7KASQYlHF7sHOmbyPTZFnvFVc29kz
	2xuSc8FhGVbf+m0n22C0E1PaJ5J0gc
X-Received: by 2002:a17:90a:d24f:b0:29a:e097:50be with SMTP id o15-20020a17090ad24f00b0029ae09750bemr11686567pjw.31.1709703146441;
        Tue, 05 Mar 2024 21:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFevY310UVbmpQFlUk/kqBWvaY92fb2a59CmZ2Hx22y1HnOSHWpHQhrAOQOaJV/YvhnP8j2q2riF5z5dzcbMWs=
X-Received: by 2002:a17:90a:d24f:b0:29a:e097:50be with SMTP id
 o15-20020a17090ad24f00b0029ae09750bemr11686548pjw.31.1709703146152; Tue, 05
 Mar 2024 21:32:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
 <ZeHiBm/frFvioIIt@boxer> <65e2212e66769_158220294f@willemb.c.googlers.com.notmuch>
In-Reply-To: <65e2212e66769_158220294f@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Mar 2024 13:32:14 +0800
Message-ID: <CACGkMEsd4icR3EDHS-4DjmKMeez41r2SnNP4j70gAdzq8O=w=w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Yunjian Wang <wangyunjian@huawei.com>, mst@redhat.com, 
	kuba@kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, xudingke@huawei.com, liwei395@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 2:40=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Maciej Fijalkowski wrote:
> > On Wed, Feb 28, 2024 at 07:05:56PM +0800, Yunjian Wang wrote:
> > > This patch set allows TUN to support the AF_XDP Tx zero-copy feature,
> > > which can significantly reduce CPU utilization for XDP programs.
> >
> > Why no Rx ZC support though? What will happen if I try rxdrop xdpsock
> > against tun with this patch? You clearly allow for that.
>
> This is AF_XDP receive zerocopy, right?
>
> The naming is always confusing with tun, but even though from a tun
> PoV this happens on ndo_start_xmit, it is the AF_XDP equivalent to
> tun_put_user.
>
> So the implementation is more like other device's Rx ZC.
>
> I would have preferred that name, but I think Jason asked for this
> and given tun's weird status, there is something bo said for either.
>

From the the view of the AF_XDP userspace program, it's the TX path,
and as you said it happens on the TUN xmit path as well. When using
with a VM, it's the RX path.

So TX seems better.

Thanks


