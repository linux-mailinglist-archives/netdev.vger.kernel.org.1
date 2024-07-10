Return-Path: <netdev+bounces-110568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA80C92D2A1
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7024E281021
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B1193444;
	Wed, 10 Jul 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlKyh+ip"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03F19309D
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617610; cv=none; b=SuvmpkFDaHiLwS2xH/pQPdTHJ1ZlvFzNl1AfSsgNZxgsVKE0qfme0sz8PXY6jZ+y82w5wRkFrQwGp14yQly0qhsHFcHYUugXeG2MP0gmGhvuQxKyHl7eFKkCaK5PKCMmzIDg69Aw3ngVk8DWdFzzkxjpPBxmZwYjxmu7EKEix38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617610; c=relaxed/simple;
	bh=dFbM6ZZNaNJTJc/hu58GylGEas9WF7KLmK0/E37+HGw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JiCoiKGePWYbowMKGb3xsFqTVW5I6IMFam6Om5AlWgMx2mQ+derBrpUd76tAHU/HBiR6kyTgVj6bTCyvXzkN02MrpHtmAjCzry90s+bZT56AyEgIV4bjOfdaGJjCn0fXg9QMZ0n3hgZyBngMkSFZPn2z8MJfgTqq/Io0/9xNXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlKyh+ip; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-380deeb250eso22433265ab.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720617608; x=1721222408; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gwJHNmTbTMAI9lKo4rIL8BAk7Trx6mjszqonJhjObl8=;
        b=IlKyh+iphReairzG1HiK/xgauqU4iEbfXXpGSWOswbGyhfTIe0usXVMK9/qxV+p4Tl
         IoSHOIYe6G/LmQwXX/eKanESaIDb0lCBSN6Meg1Xlsy+V1JP6gHf9UMEg6MxaxR5Oy5K
         8TKsieSTqB+q+/RiPVJl67ZxphVaj36YTUsIuv7wLsv/cseWIW9BL/HNpSQSN1T1XcOr
         FIZLIT+iqmNAUxr3BlfBnQTFlUBDfKli/Z7QzcDj/M4XF0fF9SwW0mtd0NiZnasfLDY4
         90R6F0G2XJGl0LKRv5fkKH2w+C7ILk20WVNl9rZ5VQ/Hfe42sETD0bJB3wDljQsA1l37
         /FpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720617608; x=1721222408;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwJHNmTbTMAI9lKo4rIL8BAk7Trx6mjszqonJhjObl8=;
        b=GBUV+gBKGic+qRqDa75r7tfBFos1Zf3Lo/K4d3P0FZvi76cCr4tYkZcf+DDEH5Aobj
         F3TIZlMWHuw+f6qU3sELGG+IAo3G6hwN6CTx2zXk5kIVqqnOe+2CN7hp2WP3kQgHKpuU
         lUCJxjiSDRf6e65NsXoNoDJfdo2kTY05oYtGX1CAyCoytrPYutwhV5L8JPiq01CL14e4
         PyEqhI+xoJW40s+8Z9f7IHe2oZBanN3RMByxTJWiwWLAJrYy1NoDanvcbCdpS92DBCLv
         u5wgZhgfuWD7j+IX9Eg88Ct2lcehO6JsKLYct3UWcwrFE2GGribBoSC7jeqKWPXGfUGy
         9tlg==
X-Forwarded-Encrypted: i=1; AJvYcCWFD+B0MC48H4DXWwV0kc1F5Vy5GjuqM6UNjhS6uqLFNICDu7V1DfSN43IN5wV5nIZtEMJnip1TI8B6UlYW/1xq95R4wLmX
X-Gm-Message-State: AOJu0Yy2yn2F+QQHvFbQT/yjPSxQTvUOXx60AU+BlAcR8nyml9nJL6G2
	N755hDjLtHZWuyhA06OF8iW8fS/q6i2MMINnI7IMVmPcnTu4/k2ZfmuXQNbxjq99TLWsl+dlNWP
	rJs+xj0IltyQCV7f+2KWHq7eCQJU=
X-Google-Smtp-Source: AGHT+IE96SEnPOyhNImye5gJEumO61NK/sZYO4PPkyKswo4fPr8kJ33IRQ4tGYyehfubiduTozItIFx5S/AiD5+7TSk=
X-Received: by 2002:a05:6e02:12cd:b0:382:c731:8d0c with SMTP id
 e9e14a558f8ab-38a56d0c2c3mr64831855ab.5.1720617608079; Wed, 10 Jul 2024
 06:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Niigee Mashook <mashookniigee@gmail.com>
Date: Wed, 10 Jul 2024 21:19:57 +0800
Message-ID: <CAN9Uquc9Ji2o4WA-Bo6JCY-4X4G54KaLPS1c5VOcCbhWMkR0KQ@mail.gmail.com>
Subject: Questions about the chelsio/cxgb3 Driver - TX Stall
To: Potnuri Bharat Teja <bharat@chelsio.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone in the networking field!

As a learner of kernel networking, I came across the following comment
in the t3_eth_xmit() while exploring the chelsio/cxgb3 driver code (in
drivers/net/ethernet/chelsio/cxgb3/sge.c file)=EF=BC=9A

       /*
         * We do not use Tx completion interrupts to free DMAd Tx packets.
         * This is good for performance but means that we rely on new Tx
         * packets arriving to run the destructors of completed packets,
         * which open up space in their sockets' send queues.  Sometimes
         * we do not get such new packets causing Tx to stall.  A single
         * UDP transmitter is a good example of this situation.  We have
         * a clean up timer that periodically reclaims completed packets
         * but it doesn't run often enough (nor do we want it to) to preven=
t
         * lengthy stalls.  A solution to this problem is to run the
         * destructor early, after the packet is queued but before it's DMA=
d.
         * A cons is that we lie to socket memory accounting, but the amoun=
t
         * of extra memory is reasonable (limited by the number of Tx
         * descriptors), the packets do actually get freed quickly by new
         * packets almost always, and for protocols like TCP that wait for
         * acks to really free up the data the extra memory is even less.
         * On the positive side we run the destructors on the sending CPU
         * rather than on a potentially different completing CPU, usually a
         * good thing.  We also run them without holding our Tx queue lock,
         * unlike what reclaim_completed_tx() would otherwise do.
         *
         * Run the destructor before telling the DMA engine about the packe=
t
         * to make sure it doesn't complete and get freed prematurely.
         */
        if (likely(!skb_shared(skb)))
                skb_orphan(skb);

I tried to understand this insightful comment but found myself unsure
of certain points. Here are my main questions:

1. Why is not using Tx completion interrupts considered better?
One reason I can think of is that reducing interrupts to the CPU can
improve overall performance by allowing the CPU to handle packets more
efficiently. However, I am concerned that using skb_orphan might cause
issues like invalidating autocork and leading to bufferbloat(TSQ's
functionality), which could negatively impact performance. Would this
not cause a performance regression?

2. The comment specifically mentions skb_orphan, and not using it
would cause a Tx stall. Why is that?
My understanding is that when sk->sk_sndbuf is small, it might allow
only the first packet to be sent. Without skb_orphan, after sending
the first packet, sk->sk_sndbuf becomes equal to sk_wmem_alloc, which
would prevent subsequent packets from being sent. As a result,
sk_wmem_alloc would never decrease, leading to a Tx stall. Is this
correct?

Looking forward to your insights!

