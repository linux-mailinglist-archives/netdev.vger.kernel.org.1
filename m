Return-Path: <netdev+bounces-178734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D84AA78977
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931513ADAD9
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05823371F;
	Wed,  2 Apr 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNrm1Mxx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72882AE77;
	Wed,  2 Apr 2025 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581199; cv=none; b=bUdi+cWg+BoEeHGSTOhPVHzmcz+BH7xJ/NX2m8n8LGFCYpZuyGsZNDcLYas+nG8KgfKVYui22lhOMBhYu9kMazbW+qS+6AIaDYEmHN6c8aPuNGORbVkD4IB5Trdp/lnv5YSW25u3alOK/zT90WmPFYFTOqbp2xbKDjUaQ46K83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581199; c=relaxed/simple;
	bh=D6f5qfHSttq12TI0udqYnPjm2YnIDSC+WM7ei1U/4ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=efjkq36OVS5MLjQYYWjVOZlID3Hn0lFzO5qhICa9fM18Ar3VVR9pyMRwcEhifenT3qgJe+ewl5V89tjUN1ZzTFwqIsDqw5Si8VOWxpVn083MEgRksDoTXS5UYWEOm1hSyX33+BYDueMlPkbfM4jPUX5lwK/M1Zx7TH3h5heK1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNrm1Mxx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fd89d036so137078175ad.1;
        Wed, 02 Apr 2025 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743581197; x=1744185997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TctbPlWNW+1db8BpaLa6088N/Evs8ifFgLk/Uk2HRoo=;
        b=jNrm1MxxJH6AIZE0rLma8/8LxOela2gBadaLvctB7HmJp1s7UJdV/y65eb7ynfHhEg
         5YLvelU+QLQ+vr98btVG6DgxByYo+WFV9StRKDFmgcWglhe6jVC1vyvSN92eXh3fPZtm
         kZbrunAG76MQxqw1S7DhqtF65euVONwMwj0fNBucb8QPDG1+WcB/skd8Q1jgT8A0o1On
         c86Jp8wli1zXPwjFb//cQyWfTwE10OzgNzmY7VvOxKSLf2rzKD/I4iwAC9U34XoQ80az
         zq4h5jgfK4sm8Efhy7l2QWyNdYBsH7zVmqcclhEMaJy884V2BK9+U+i/z7THsvOYGf2j
         wQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743581197; x=1744185997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TctbPlWNW+1db8BpaLa6088N/Evs8ifFgLk/Uk2HRoo=;
        b=bLYbM3R59VBaSNUqy/MJUanz/qOPWUJYU68T3cWsdIiMHPpocMz38Q8rvc8H9E4Mgs
         bolSQ4eWwGGQ++/TwftONQqL0AIp8kzcdLcMKo++fmb8ZWv9zrtZAy43XNWa+4NqjPiW
         WxwsN/WTHiMsTG/FijKcFjDaEYcKSuOON34E6Y0vjKpE6oiLssYTYXgepoB0ZKv37JbO
         yT8qAcM+4DCzGzmsfWKL5unXCHuHCbe4KXBo391/nuncpxq0nHIzNN8bhFJhD1MKx8Eq
         wgoYqWX5NAzKHuZgUoWt9mteq3uk21CF2aUW/c2PfhB1pDrCsKglQZBGStozf3wpkdef
         J4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG8kg+HlV6RcpQcUrnIAYeO6e8tg9QJIdn443sHX4nq35vS6OBYdU26t3mJF+NjwOPO87cNM8WEjEd@vger.kernel.org, AJvYcCWIYcbGHSoWLVx1Fnu5nPIKxsbaTNi7iUr0UCp6JhtVi7NLyPNDI+o+s6sIIpabz936yn8FWyoUu32mvbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3mVfdZhNuhW7Rb62cTnCg+vCj7qESxtD5mHWd/gcoSaWA7Ee2
	q3M8+RamKHatrSHXAa67uaB5a65VniUMOGI+lxLZVjUrzTdCgXOH
X-Gm-Gg: ASbGnctRVIkZ1c3xNnCsNR/37v24ICKib+KDObBZ+bsyoPdEJx/dNT6rAj9uHnjUB6m
	aGUkXrH+qP06rj0/NBeiknpeuG16DPWGMXMjQoSE56QOBGr8SohiaZmBgvSskZVBeLeuhAEuww5
	cEB3qepm0F/DaSQirE1NEnAR7rZL5zsLKO7yZF/Vmb2HAksUyQzffErL4zSPjya9OApw5gblCgo
	zx9RIwYr9xCnSe498S6W50z/Y/btnN89wCfCHg2dvCMZinSNyj9SJ1Q/D8zKQ5sKbNX//mbzRf0
	NzqahEpKYbhTLqaorMhy9ROfgOQlCv2Qxr4ocr0HsX/zkXY7Snt1nZMKwC+yJhY0395g
X-Google-Smtp-Source: AGHT+IGCfWQPMh5JGnZiKvKihY7PRZ2uyl6Tcm1X2cuNYeazBjyWbR5kXImnmpLo8uN9ti1T9U2JWw==
X-Received: by 2002:a05:6a00:4b05:b0:736:3449:f8ee with SMTP id d2e1a72fcca58-7398032560fmr25374651b3a.4.1743581196796;
        Wed, 02 Apr 2025 01:06:36 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710dccbdsm10639665b3a.179.2025.04.02.01.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:06:36 -0700 (PDT)
From: Ying Lu <luying526@gmail.com>
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Ying Lu <luying1@xiaomi.com>
Subject: [PATCH v3 0/1] usbnet:fix NPE during rx_complete
Date: Wed,  2 Apr 2025 16:06:28 +0800
Message-ID: <cover.1743580881.git.luying1@xiaomi.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ying Lu <luying1@xiaomi.com>

The patchset fix the issue caused by the following modifications:
commit 04e906839a053f092ef53f4fb2d610983412b904
(usbnet: fix cyclical race on disconnect with work queue)

The issue:
The usb_submit_urb function lacks a usbnet_going_away validation,
whereas __usbnet_queue_skb includes this check. This inconsistency
creates a race condition where: A URB request may succeed, but
the corresponding SKB data fails to be queued.

Subsequent processes (e.g., rx_complete → defer_bh → __skb_unlink(skb, list))
attempt to access skb->next, triggering a NULL pointer dereference (Kernel Panic).

Fix issue:
adding the usbnet_going_away check in usb_submit_urb to synchronize the validation logic.


Changes in v3
-use the correct "Fixes:" tag format.

Changes in v2
-Use the formal name instead of an email alias.

Ying Lu (1):
  usbnet:fix NPE during rx_complete

 drivers/net/usb/usbnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.49.0


