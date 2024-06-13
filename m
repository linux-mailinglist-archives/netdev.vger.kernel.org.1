Return-Path: <netdev+bounces-103296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E57B79076C7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB871F23AF2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B012D753;
	Thu, 13 Jun 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY63Ybjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B796A23
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293070; cv=none; b=r9aiLM92RCG1jhtA/NLN277NpnJJ+rZ8NA7lUCaOLrrUxIl7eGNQk+XNolEmpN7O6U29/Ori7VZc7J7QfdQEQKlqK44r8/fyC+Yrwp4w0CGDpz7mhua517lUUixDFBrOnvsrvEQc+6AOC8dv2RnGZBgRLHOSU4trBpxLaAsUa6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293070; c=relaxed/simple;
	bh=Vt7AxcoQO0/tbz+qhqgvsVOzK41T8BCPEpRHgRqYE3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjXszfrdsitcN5+Z7quGhlnGR1OgrLU51rFSYh6PQgRPhofzLGiG/IdzYKjxiFmdFaQBJqwja2e+5cSeMivk7dEFfrwOqAE3kc3m8Vj/hkEKTRDXkvMnc/TgJTIQVOA7LOXDwkNNOQkg5Drj+O90le8isYp/BWznv9D35mufoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY63Ybjh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso171620966b.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718293068; x=1718897868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gedhR/2fOtNvTg6awGc+mCq75ZJxD/hgE4iBN+hALE=;
        b=AY63YbjhZrFlznl7PX5+6z6/uctfEOX1g8CRVCE22pTXk9XU0xwa1TzN4hRP82sXK8
         toJRmPp/amG18JbutsyC9BPI9upYS9Cru3vNcl0KGlk4uDiWV5l/0NWXpCOY3s5z8B/6
         1tS8rr8VL0BADidld+LkRamaubnZpsYgdunwrDhHWfcYuQpZKIchxgMqP76zPyZGIjRy
         IG+pP3yZpnyjWNSmJAlr95RVINbvwaVHZJf5gn595LPNVQ9nIMCqTyPekgvUoRehI91z
         uWssHluXJrFexvXYqVd+b+AG+Te76HCCKQKV8gMYH+tdvENkVuMwFHG+Nq1w2jDqqoCD
         F6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718293068; x=1718897868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gedhR/2fOtNvTg6awGc+mCq75ZJxD/hgE4iBN+hALE=;
        b=eVYgM811oocvuvCIy9/mE32h1FYUHka7GI0b1JTeQtwrRHIood3RuDc152q2EuJOBK
         7+c2djgyMfOaLuDIZxHD+tKAcHRLi7f3+qtToDUUatxzMZUenvqmPBHYZmgMPF204XiH
         YYlQm+CDn3TwRZ3i2S+nh9HN1+zkKr3ZoG9EVAOZbfzRDSDCBZ6zPLWKwhT/LVJGT/8X
         9jCyHgnzjtYx85Ne+IOCnad11p52ntLCJ2TH86Aqwb0VyGP7KqtqNj2cBeu4kOb+Z1X0
         mMdEzrHaMyGIixFip1WDoEgABxhRHPDiV6KOOfGO5gsTFAguhWwU0H6hr3jCMlYXxrei
         /Wpw==
X-Forwarded-Encrypted: i=1; AJvYcCXC8SacelujKr3XWlpyfFEG63bfRiqVpxADNxr4Acl0B61f4He8d6aYYXzMlUiBGq0Wth+Jtw8uT5MtenYDU9+oipET3L2N
X-Gm-Message-State: AOJu0YxDYcndO9V7we4GeAB3g3YPC19aHUT23eFxmnaKJb+6J5MK70+o
	eMhmiB1XyP/5aTf0LEGM8uIHDTU4Vb17scpeat9azxm/mTkvK1HPbk72G721O/o54wYwKHUaky0
	VIIt8YJJr2Q1nBvynYZMeBikYYjU=
X-Google-Smtp-Source: AGHT+IEmMxlyi9/q7juZVBSnGPz+I0CBBKMRQ9Vg7a6lgesZWn/6ywy77ymtgF6aTnOMMd7balqTjtl46Nnb/ybsLbM=
X-Received: by 2002:a17:906:3948:b0:a6d:f339:f8 with SMTP id
 a640c23a62f3a-a6f60d296femr8814366b.31.1718293067476; Thu, 13 Jun 2024
 08:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <CAL+tcoAP=Jg3pXO-_46w5CbrGnGVzHf4woqg3bQNCrb8SMhnrw@mail.gmail.com>
 <20240613080234.36d61880@kernel.org> <CANn89iJj=ZBBLxgRQia_ttE1afxGSbJJxG_17NemZB_8OL6LaA@mail.gmail.com>
In-Reply-To: <CANn89iJj=ZBBLxgRQia_ttE1afxGSbJJxG_17NemZB_8OL6LaA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 23:37:09 +0800
Message-ID: <CAL+tcoDo0NYCGxLxJctq-9YNgvSKPr-5rRGkMamX7owQDGpmhw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:26=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Jun 13, 2024 at 5:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 13 Jun 2024 22:55:16 +0800 Jason Xing wrote:
> > > I wonder why the status of this patch was changed to 'Changes
> > > Requested'? Is there anything else I should adjust?
> >
> > Sorry to flip the question on you, but do you think the patch should
> > be merged as is? Given Jiri is adding BQL support to virtio?
>
> Also what is the rationale for all this discussion ?
>
> Don't we have many sys files that are never used anyway ?

At the very beginning, I thought the current patch is very simple and
easy to get merged because I just found other non-BQL drivers passing
the checks in netdev_uses_bql(). Also see the commit:
commit 74293ea1c4db62cb969e741fbfd479a34d935024
Author: Breno Leitao <leitao@debian.org>
Date:   Fri Feb 16 01:41:52 2024 -0800

    net: sysfs: Do not create sysfs for non BQL device

    Creation of sysfs entries is expensive, mainly for workloads that
    constantly creates netdev and netns often.

    Do not create BQL sysfs entries for devices that don't need,
    basically those that do not have a real queue, i.e, devices that has
    NETIF_F_LLTX and IFF_NO_QUEUE, such as `lo` interface.

    This will remove the /sys/class/net/eth0/queues/tx-X/byte_queue_limits/
    directory for these devices.

    In the example below, eth0 has the `byte_queue_limits` directory but no=
t
    `lo`.

            # ls /sys/class/net/lo/queues/tx-0/
            traffic_class  tx_maxrate  tx_timeout  xps_cpus  xps_rxqs

            # ls /sys/class/net/eth0/queues/tx-0/byte_queue_limits/
            hold_time  inflight  limit  limit_max  limit_min

    This also removes the #ifdefs, since we can also use netdev_uses_bql() =
to
    check if the config is enabled. (as suggested by Jakub).

    Suggested-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: Breno Leitao <leitao@debian.org>
    Link: https://lore.kernel.org/r/20240216094154.3263843-1-leitao@debian.=
org
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I followed this patch and introduced a flag only.

Actually, it's against my expectations. It involved too many
discussions. As I said again: at the very beginning, I thought it's
very easy to get merged... :(

