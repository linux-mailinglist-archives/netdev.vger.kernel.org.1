Return-Path: <netdev+bounces-214019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15980B27D35
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EDE3B62B8
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2F52F60DB;
	Fri, 15 Aug 2025 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uY1vdjJS"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66A2F60BA
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250254; cv=none; b=MhWsuJH768n163f8g2mr+pK7huMc0VOOe2qZfp6L6S/zewVCuZoJ8Pepc10J+Y5PI79zRKd2c70ADxmCd5snK53qJvwuioHqA5LDRMgWjFDovfSoYCT8O+BVy1m3zZmP/NRKE9YSp3fQinX3JgOy2lXrM7cKbSaYufVm99yPFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250254; c=relaxed/simple;
	bh=t7UlHOuN49CWXLyZpNuOkb/8d+QezXZ+35enZ0R4o+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=WTCix1vzcGyOJzTpvotNb+SkxbGDmdr6wYI3VU8t7SKEtgJ/nJy2fRIwd8KV5wtGXZvk6P8O/ghXmY7J/01dcLA45NqlH82Zct4GQHlyj7ItoHn9DDLsiT0t1wxiaSpYfd3SNMdBKY3JflszWjiVJb3W1A7rF5Hx7V4d/TYBZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uY1vdjJS; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250815093045epoutp0179332f019996e2e9ce33f32156ff443b~b5sxUE4Jj1751117511epoutp01H
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 09:30:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250815093045epoutp0179332f019996e2e9ce33f32156ff443b~b5sxUE4Jj1751117511epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755250245;
	bh=oDZNru6EzrQYE5oyYm0kJ/e5sm/ukK+OmYVVJ+YMNcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uY1vdjJS9VTBYzP1zDxKLuv+ySD+vKZmm8MSJEM7aYxI4qXVCWJKj8ekLWgvW6zzs
	 NKHgQ6t9w89vb5j2YdtGdKEo264PPsDAnYa6HJtkPYjmutcamYg57M0xJIlGc7R+oP
	 wrqYe4qOdZ2ZWjvSSlpaOYzmFltR3Im9k50zgkTQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250815093044epcas5p2a2173e718c713bf1d49e0eeed3a886ff~b5sw3Knp_2650526505epcas5p2f;
	Fri, 15 Aug 2025 09:30:44 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c3H0M4fTTz2SSKX; Fri, 15 Aug
	2025 09:30:43 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250815060604epcas5p3a6856bcd64ee4ed80abb43b09aab8a42~b26D626KY2237322373epcas5p3c;
	Fri, 15 Aug 2025 06:06:04 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250815060602epsmtip2645ad38253d82a680344ab48d7efd956~b26Cb0GMD0801708017epsmtip2Z;
	Fri, 15 Aug 2025 06:06:02 +0000 (GMT)
From: Junnan Wu <junnan01.wu@samsung.com>
To: jasowang@redhat.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	eperezma@redhat.com, junnan01.wu@samsung.com, kuba@kernel.org,
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com,
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	ying123.xu@samsung.com
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
Date: Fri, 15 Aug 2025 14:06:15 +0800
Message-Id: <20250815060615.4162-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEtakEiHbrcAqF+TMU0jWgYOxTcDYpuELG+1p9d85MSN0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250815060604epcas5p3a6856bcd64ee4ed80abb43b09aab8a42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250815060604epcas5p3a6856bcd64ee4ed80abb43b09aab8a42
References: <CACGkMEtakEiHbrcAqF+TMU0jWgYOxTcDYpuELG+1p9d85MSN0w@mail.gmail.com>
	<CGME20250815060604epcas5p3a6856bcd64ee4ed80abb43b09aab8a42@epcas5p3.samsung.com>

On Fri, 15 Aug 2025 13:38:21 +0800 Jason Wang <jasowang@redhat.com> wrote
> On Fri, Aug 15, 2025 at 10:24 AM Junnan Wu <junnan01.wu@samsung.com> wrote:
> >
> > Sorry, I basically mean that the tx napi which caused by userspace will not be scheduled during suspend,
> > others can not be guaranteed, such as unfinished packets already in tx vq etc.
> >
> > But after this patch, once `virtnet_close` completes,
> > both tx and rq napi will be disabled which guarantee their napi will not be scheduled in future.
> > And the tx state will be set to "__QUEUE_STATE_DRV_XOFF" correctly in `netif_device_detach`.
> 
> Ok, so the commit mentioned by fix tag is incorrect.

Yes, you are right. The commit of this fix tag is the first commit I found which add function `virtnet_poll_cleantx`.
Actually, we are not sure whether this issue appears after this commit.

In our side, this issue is found by chance in version 5.15.

It's hard to find the key commit which cause this issue
for reason that the reproduction of this scenario is too complex.

