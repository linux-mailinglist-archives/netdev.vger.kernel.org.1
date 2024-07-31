Return-Path: <netdev+bounces-114525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B2C942D32
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5141F215A8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F7C1AC439;
	Wed, 31 Jul 2024 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dwBoUTxR"
X-Original-To: netdev@vger.kernel.org
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B31A4B2D
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425039; cv=none; b=mUB3Kt0+aNQzUxL8AXixuTHKIAazuKKgui36w8vjzExlw/yf5apXx87RQxSqk5ePyzpFvOO+wqfpElBwV4EisRJbF87n1iv0pDS2DVccGyOKX3LqBdSp2mQSCA370ALUMKBKZpuNjjzsuYtfbtPDCv2JBlXhDLHAT6vqssMZXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425039; c=relaxed/simple;
	bh=HATaWdQZWZIzAvM9h+SZ6bUQcK7RXstln/FD6gO0xe8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=ClmO+5Pw0OIVA2WdjPmz6PmnSLzNe5g8xjQodwYBiHmBElC26mTTyiQ+ctwrr10vSG3QD95aMYWnhZY4QMfStJDDjRxHzK8z5PaYO6c93iJ2Cf9JTexmq9GhM3DOQHBgYenOOWxvOG+VLl77jlmbXAlM+2dchxHz6uYve3XHklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dwBoUTxR; arc=none smtp.client-ip=47.90.199.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722425019; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=HATaWdQZWZIzAvM9h+SZ6bUQcK7RXstln/FD6gO0xe8=;
	b=dwBoUTxRNOSwcbTQbEu6KN7Wq5XARomarnpFG/AFPq7CAeqqC81FVOCx48eGiPBqg8V2kEigWqPt9jh6NBNwel+zRy6yH0chmzpxlTxXVbtgk4QFZuxEK0MU0tPisqoBACsEkioQgZVcud2+M0IWUGw87TU07hS24LpHi3Tvx74=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBjLas6_1722425017;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBjLas6_1722425017)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 19:23:38 +0800
Message-ID: <1722424933.7532778-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
Date: Wed, 31 Jul 2024 19:22:13 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
 <20240730182020.75639070@kernel.org>
 <CACGkMEuxvLVLuKCLNi2eBy5ipzNn+ZGM+RSRBXk-UA0bJCKgZg@mail.gmail.com>
In-Reply-To: <CACGkMEuxvLVLuKCLNi2eBy5ipzNn+ZGM+RSRBXk-UA0bJCKgZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 31 Jul 2024 11:13:03 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Jul 31, 2024 at 9:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 29 Jul 2024 20:47:55 +0800 Heng Qi wrote:
> > > Subject: [PATCH net] virtio_net: Avoid sending unnecessary vq coalesc=
ing commands
> >
> > subject currently reads like this is an optimization, could you
> > rephrase?
>=20
> It might be "virtio-net: unbreak vq resizing when coalescing is not
> negotiated" ?

It's great.

Thanks.

>=20
> Thanks
>=20

