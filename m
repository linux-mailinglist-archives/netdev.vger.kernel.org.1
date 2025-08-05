Return-Path: <netdev+bounces-211678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4013B1B1FD
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE85621773
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5526D4C7;
	Tue,  5 Aug 2025 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj9Vyzt+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFDF26CE30
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389621; cv=none; b=CgImaVaae/PPQBkD8HN8SbCZBG35L5pwvht29u7oHhmJ3HQavSMY4qCEl7VwlIIguRgpkOjWVQ0RFahCQox2gnymcUl1n4gy+n8lsMEkACtMC6PPgfdxVkF4I1yqWGE+Y4sAp8Q/Ptv68IsAvlnHeTWgKHkmGZZPHt7lt+g2b/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389621; c=relaxed/simple;
	bh=hzYsS5DQdNztbxEoCVzVeCZqeXnSoodRYsudHS2t45M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cRmYlvasDD9qzMIJsyzqyJdLSflbU8cT/9KitscdapFLe7HsiUdcCiV6szw4Qq7f8plJXwZym6Irgi00sXnReZ9M5qEfrAltghDgpan4tlBwXJVCWxpvexDLU7sinQmZ7CFYKR8sQ7jCf7/FOH63NwmPI3sWUN5mEpn7eTi7X24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj9Vyzt+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af92d6c7d15so86457766b.2
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 03:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754389618; x=1754994418; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hzYsS5DQdNztbxEoCVzVeCZqeXnSoodRYsudHS2t45M=;
        b=gj9Vyzt+1s5c/JLI3I6EfcqJhQWpuWLu8sDwKWBey4t7BoNENJm1xnR9Q+jc6vL1WD
         nrf/eYvbRQfKZ/JHTQyAvCjcbEEBDfPIg0dfo8QZwVG6nJkHjYDyC7/KyA7Y2x0asag3
         m4v3YPWBWnR4qG4WlIDC4tgocseSzMO0D361H0s+YrzyoRxQIB4ELrApM/bzNUu8vN1h
         +MEBFFSvIBAOItFoQba6JZOgwqVsTKD9CwlwfzoeQo9Dqptn9ay3aGOdqXoPr8AU2hJK
         bKVqG1XySq+mf7MnHUkZBokzR6ptY7/eFK6qJQHv0wMwdHSmWr2pFv6ZZKKUgmA0TO1H
         MNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754389618; x=1754994418;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzYsS5DQdNztbxEoCVzVeCZqeXnSoodRYsudHS2t45M=;
        b=c5BTXXuH7miXshnbyrjWqw2pmPtY2d/i4BOHQXTR7k0hP/xcs8Bk3kKrTrjyghpzpq
         Kcd1HVkU7+4LBKZQndBLIXmtUEVJzgvlYf+7X1IJTpwyjO8YeOeUGf7IfeYXvO9d9TcK
         hNrPWMr2MvnsIMvuZ0Ua9tgZyY6WA1t/EfS89EuIPEDQcCOYq2FCuTaHajmGU/HuQlEy
         TNHQpjJJmTukpYmPddROEut/vYcJU5vOwiy/09tKZP6XefncGcMjWvVDTRwb+FYIdiks
         45OCBgiJQFkmsHhKEsXiNJsY6oUJSwtItkFWd/91TPcvLf06z3mjv5CW0ucBN+A6lerP
         nNmQ==
X-Gm-Message-State: AOJu0YyrC846X+2VzWs6ryLVz2WekWj1vduIw4OdDy7n7mLai9zESUwn
	lvMYYipltx2K3B6HupU6M64TU5CT1i9GLl0ep5Qd4VxVsTUBNVdxQhgEWV4UGS4677VSy4/oo22
	kcv++2lbApQ/J+Rf4PfpWJphF+ErTm3m3au/o4w64Xg==
X-Gm-Gg: ASbGncu+HXUptRtTiFbwgfYrx8HeDhPkCodhGnaTV7uB0GD+lL5y48sN8MFr4bqWRH2
	4uzZVm98aNxX4eE3OUcoD36A3OqHLrh65bUz576URqQLJ2qj/6ByRXJnC2WaJJKiGvKYSRX22uI
	/QiiuHYWknh1g8YoqcByFxW2coqgZ6HGhwPZVJ6CTvqKOpzAv2aCaXcZubItg0aiw+FEQcVMNJF
	gH6UZg=
X-Google-Smtp-Source: AGHT+IGV3Jo/1myy4LFjJJYHZP94hYMKfmvn3KvCOO89uGVtzHoAz165k/E8BAoJR92Ej3vLF2ZsD0V7piTs8Tl8FEA=
X-Received: by 2002:a17:907:7f14:b0:af9:67ef:96d2 with SMTP id
 a640c23a62f3a-af967ef9851mr330198966b.11.1754389617872; Tue, 05 Aug 2025
 03:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ayushi Kumar <ayushi.03march@gmail.com>
Date: Tue, 5 Aug 2025 15:56:46 +0530
X-Gm-Features: Ac12FXy-Ir354EQNR4cXa9IFLzqDBL-4_3yViYvpoOI4tgBWkvHtvisrm2RvaRw
Message-ID: <CAMO+cuMFDHhZhD0Eo1iZzgov27EkXhpuh2H87ViFxntY9M_k4w@mail.gmail.com>
Subject: Soft lockup when posting skb to IP stack from multiple kernel
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I=E2=80=99m working on a custom kernel module on Linux v6.6.54. Packets are
received from Broadcom KNET via a callback and passed into my kernel
module. From there, the packets are posted to a kernel queue, which is
consumed by a kernel thread. Based on the type of packet, the thread
either sends the skb to userspace or posts it to the IP stack.

Everything works fine when there=E2=80=99s only one thread handling this lo=
gic.

However, when I introduce multiple kernel threads (to handle different
categories of packets), I start seeing soft lockups =E2=80=94 specifically
when the threads post packets to the IP stack.

Interestingly, when the packets are only sent to userspace (and not to
the IP stack), no issues are observed, even with multiple threads.

For posting to the IP stack, I=E2=80=99m currently using netif_rx().
I tried using netif_receive_skb() instead but still saw the same issue.

Any insights or suggestions on how to avoid the soft lockup in this
scenario would be appreciated.

Thanks,
Ayushi

