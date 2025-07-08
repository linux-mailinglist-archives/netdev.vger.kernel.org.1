Return-Path: <netdev+bounces-204851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04ACAFC429
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC0667B12C1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C7299AAA;
	Tue,  8 Jul 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd0vIGLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA812248BE;
	Tue,  8 Jul 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960110; cv=none; b=Gs9oV7VxSQdW8K714ljoHPG328hIMNuPrtyA4FUCtihAg8zyd3knvGIws5T+5fJisHxc/53wnnV1DgF9kOT7Xn0KsSsfK3JjA+4q84dLlAODKUQTEUxhxMv5iXCdTqOQFBGJ/LDKQ+PpKeujPZ4EwFeqairQDfZm8sBdHLyEsic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960110; c=relaxed/simple;
	bh=d/TYnIdUHqL1gDc+g8DMoegQnKp7oqD6k62XmTekfJ0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eFNnsrczj4pTRxN6fH7SmHKaMuHev2zdCvGxbkg5E7nZyH7Z8NviQWACnPk2Leqy/gzjENvhJfpgvWMZYmNDrkCvFVP4EGL5i/8IVKx8fYn6TuDuJs2RSFOdgz9WvHVYexiz8ty/N8iRqcewJ1VOZqLjFDjV8Ew16mCAXNfk71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd0vIGLO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso34787841fa.0;
        Tue, 08 Jul 2025 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751960106; x=1752564906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d/TYnIdUHqL1gDc+g8DMoegQnKp7oqD6k62XmTekfJ0=;
        b=Sd0vIGLOV/PeWm+KHxTydX21FqzCGUwHO9oVAjFwNJLBVgtw5QwwO3+cfKOFypWoXP
         Ove1LMru2rQpY2UB1Gsf9c6R5ANV4Wz3Qkaykn4+ymZba0OOva9OTrBLryizzN0mbaFW
         /RwSdEglTPLd7BCZFVv85+Gwsjqb447ZZI3LVxe7/E+MYoHrYlE3d4giOsS9Qxvwc9v7
         Dk//36aM2s5AX76gMFSyBj5zU5EYwkruJDgT6ET/4J3T2CVy07SR30fBIF7KBu+1t0f/
         5KPND4v/BkRrDfrEj3JrarIZ98TZA2bnGmjX7LXqTPe0t9SHCWeHEJvXBwEQHEyFUVE1
         wNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960106; x=1752564906;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/TYnIdUHqL1gDc+g8DMoegQnKp7oqD6k62XmTekfJ0=;
        b=oS/2merI+s1DjBr59ZxPkmod/kN/lpFcQ6MEOXFtcWNzuzTmX4GVfnc7om+yoB9dke
         xhs+AbsaT5H4Hj693ujLHbL7TsEN329ss4jmOqDwc5gSVo9rN7jl2Sbt+XCE7jU8+a3B
         ZDqHYhLtXQ5l/nIOplWMp/lX8KlIoEEUq/xfb1XSSX7mZv9jSYfBQDZ7p3qqDP9V2Yw7
         dMOD6NEahJVu37iFcjkgzAO5Xiuszy4T+ZcErJzKhzt/iGrXxUegMVsccCZeqRMz8XfB
         ungRCom9IsZ9PcQa8Ms40pvnctDtVekjP/06UTuIb/nivWGmQ5STKg2n7W7Z0k7SiX0d
         U/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDpW84ycuPu7P1qPz3TK39FzXk3jbG6FfauSHJjqeWmM/pYt6+P+GTY2nZeh4pCvIZoJoSEMr5@vger.kernel.org, AJvYcCWEEUIFF0SpqItxxbYYX19BmheheVXGjM+t3A3MhobSqAD+1MBdAlhDjMnFTXfLGhps39X0xobWrdb5I6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFw1JewBUbTTMyETpU/bAfW6FuPSc9k76Ad4Z4/Ed2oae3oUn
	OhJKTc6KHDS7r8k6EZ93cGBmW07hb31X7uHGbcLeTBpbLKE8MmxDZ0rOUxmBqdGcbz1fqMzszMv
	kMw2bFIiRz4mdPEbimavoyopIxEbKWiUN3RYk
X-Gm-Gg: ASbGncuAFxr+pBZArAzA1suDCrdzSZOIr5aQI7ufS9t5mBFX+qsomLvNJsAZjbTAQX/
	Z11KiW4jDJulQsrjQcoUJUeqAGf4R05B4cgIKg6RL1vKgjN8hXlpmfITiSQS0YS9G+QKUuiDZVA
	CS3uZV+LH0Fss6rSEOClUr0oYMic6boFC61zxfbNWvtbe5pRbCJKI11QeGrM9VuwTIXg==
X-Google-Smtp-Source: AGHT+IHS+VMFjSUs8X6ux2eYl9znkhvwsXo5ZIAh4FLzrK9ZCDjn/WiGLGNs9MnqxDl1RjYb0yFt8edcbkgxPegrPMU=
X-Received: by 2002:a2e:a7c1:0:b0:32b:82bf:cc45 with SMTP id
 38308e7fff4ca-32f39a96ba6mr3774051fa.15.1751960106277; Tue, 08 Jul 2025
 00:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Tue, 8 Jul 2025 15:34:53 +0800
X-Gm-Features: Ac12FXz9JpuwpqCTDKW5H93gDKXnNqqTelYiArdy19j81d19WlFGt8bSmy-K-Ew
Message-ID: <CALm_T+1zdfZ8Z-c6WseOfhrZBsZHHR-5ZFGefkGcxgUmxZcBdQ@mail.gmail.com>
Subject: [Bug] soft lockup in netif_receive_skb_list_internal in Linux Kernel v6.15
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.15.

Git Commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca (tag: v6.15)

Bug Location: netif_receive_skb_list_internal+0x2d3/0xc90 net/core/dev.c:6105

Bug report: https://pastebin.com/SfxZ8pRX

Complete log: https://pastebin.com/e0ZLhhr6

Entire kernel config: https://pastebin.com/jQ30sdLk

Root Cause Analysis:

The soft lockup is triggered in netif_receive_skb_list_internal() due
to a logic error during concurrent packet processing in the softirq
context. Specifically, the function fails to exit or yield properly
when processing a large batch of SKBs (socket buffers), potentially
under contention for shared resources and lock acquisition. This
results in prolonged CPU occupation in interrupt context, as shown by
repeated attempts to acquire locks via lock_acquire() without forward
progress. The issue likely arises from inefficient list traversal and
insufficient interrupt mitigation, leading to starvation of other
system tasks and triggering watchdog detection of a soft lockup.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
Luka

