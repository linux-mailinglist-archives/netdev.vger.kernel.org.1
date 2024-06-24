Return-Path: <netdev+bounces-106024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9191440C
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB75C1C2149A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC93481D3;
	Mon, 24 Jun 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtDfckT8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FB47F5F
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215899; cv=none; b=qQU43Oe+3oMXLUJmXmqmoOQu+ReBNCtgUBiIV/ySVbz0/GXmBbfkzniX6R/sr/YgyXrs/eitHz2r0O8cYFYJs3p0rDQ8cEW5v2tyYr1ShZmIlZnZvhBv+zdR3w0c1BGRkiczrSwk1EnUp7HYD6COyM2xPpxFOhCG+5h/XUoGzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215899; c=relaxed/simple;
	bh=sRBD83XVdKk2tzXngBzDQ+f+yqoKVyaAG+Jkog3htHA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hUBjQgrIJo58msAVbSxjBrY5jDBE/MH6ngKyMw5u84WU/0hwjc1ek+wE7FauX329f7eQNTu9kQt/xDdd+O9HCcbOaGULgJLIEQwnJgWARMT83bINOZCosDA6vJMHuuFHM42HijcWdjw24U8L7DHQ2NWOTrZUgn/zLKBDDqdA+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtDfckT8; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48f5d1c2341so391451137.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719215897; x=1719820697; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QVUi7Vnbua7ydsjXZPeZQ+gs4nwuzuNizkh9ZhtRDDc=;
        b=BtDfckT8myPvxivHUiM4SP9G33Ro5L4vwCmYN3+O1jFrZHskK20gPqwi1W8m4z5wWM
         EbPDG4udxPgr51MRitlBqbHhBpOckaX4hkxv/k/Zghl912hXdud5y2yoK1k/go2R/ihc
         yTCe1RcK8u0h+z8WZbNAVjjbYKdofiz0M8WCZogbDHNV4X+WQtv5Wd8ibi3eWM1tHR8P
         VM6vsiAfVuuTl2+sQYYUwORaA9C4o2rPE1NMG12MlXyIeXoqeSUkwhD7RXYCHYA/cbgN
         0tJzcopux5sUGELxYYzSHomnbAzz0CtayHiLbRuhfQf2/7d/F8sNUrSWPW412xa/XA/7
         mrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719215897; x=1719820697;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVUi7Vnbua7ydsjXZPeZQ+gs4nwuzuNizkh9ZhtRDDc=;
        b=aTI55fYhmRug4tSlDPKCA9fpBE0lTYxmYlpCatWHG53IHz8LKmEAfZqXTNq443yhW1
         HodJu/VF7naMu0I4/gVJ/Z1YzXpCAosXPzEyzTayQ3AVnmrD50JOGnM6v82krDKYGN3X
         Xlx+9FXgXtpjx++iA/VnfEPxknG3utdjOk41stlMIYQOw2JdXHgNH1tZXDw1+RZF5s2P
         QVrI7M/t3D9uslBt6fHiHjJ7/mUZMMedjLwii6b4gOlKg6RdlvnSWrPIVlXIQec+znN7
         VzusjA2D0w6VUI407RjSnDDrjphAfgsCU4obZWS6lyYth5e0xjeoF7ho6+pEHjkB4rWX
         Bvrg==
X-Gm-Message-State: AOJu0YwmqtUPRif7iez5lyB0EPcV5S0wNDcJ6BOhogwQXneqVC543D5S
	njLQDW+ZJ3mq3tPkyaJHaod+on0jU23ksWFW31EImONvIy9BXQOMl88/RylRP6maZPmwPZQGhN7
	7WbjhXS15VdqKTa9menayYOPuPjEmZ/IuEyU=
X-Google-Smtp-Source: AGHT+IEmMldmXrp2rijFX8vRPFZ8iAoE8bxATKrlaAmff8unEVb1Yt7xHe/N3YGzVqTCkJfpd/1srv5O8pT32I4WuK8=
X-Received: by 2002:a05:6102:2921:b0:48f:62bb:357c with SMTP id
 ada2fe7eead31-48f62bb3601mr475546137.3.1719215896729; Mon, 24 Jun 2024
 00:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Gregory <czipperz@gmail.com>
Date: Mon, 24 Jun 2024 03:58:04 -0400
Message-ID: <CAH6RvXgctKWU0rdByDZgUNJ9k=6Wf6c=Tw_9ZzH7Un2mZbi-uQ@mail.gmail.com>
Subject: [PATCH] net: core: alloc_netdev_mqs reduce alignment overhead
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I was reading over alloc_netdev_mqs and noticed that it's trying to
align the allocation by adding on 31 bytes (NETDEV_ALIGN-1).  I'm not
an expert on kmalloc, but AFAICT it will always give back a pointer
aligned to ARCH_KMALLOC_MINALIGN.  On my x86_64,
ARCH_KMALLOC_MINALIGN=8 so this saves 7 bytes which could mean an
8-byte allocation is freed up.

I think there's some additional potential optimization for the case
where ARCH_KMALLOC_MINALIGN >= NETDEV_ALIGN.  In this case we can
delete the padding member completely.  I don't know if this ever
happens in practice though.

If this patch looks good, we should probably do the same thing at
linux/drivers/net/ethernet/wiznet/w5100.c:1091.

Chris
----

diff --git a/net/core/dev.c b/net/core/dev.c
index e1bb6d7856d9..73daa1573554 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10943,7 +10943,7 @@ struct net_device *alloc_netdev_mqs(int
sizeof_priv, const char *name,
         alloc_size += sizeof_priv;
     }
     /* ensure 32-byte alignment of whole construct */
-    alloc_size += NETDEV_ALIGN - 1;
+    alloc_size += NETDEV_ALIGN - min(NETDEV_ALIGN, ARCH_KMALLOC_MINALIGN);

     p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
     if (!p)

