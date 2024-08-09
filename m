Return-Path: <netdev+bounces-117184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881A394D021
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362881F2217B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DEB19408B;
	Fri,  9 Aug 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtwvmRGi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3633A1DFF5
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206508; cv=none; b=YGrLzF69YeDJYsrxpacPnb2DyTdH6NfVXY6Vvx8jW/3V0n+TMpju7V/csHs9OrvnNeX8YrTmSOkh7qpmQqtcKfdfUK6OwZHKyRNcgb46ahaFyjTkFxhbj6X0Nk+bRBxQggR91wrmS/R0k2y3yxEdMUqd5MGdpklZO9Cc2k16pCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206508; c=relaxed/simple;
	bh=5BP+4KDV491eS2hTDPWl3HuFqonvue6QF2vMAsmE4yY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oNYls8QeNvYWEnrgr83f+AuaUQJKxYsjg8tf724zdNwqp5OE8i/9XzXqD8HfvzzMgsANYWK/qNmBn24Ldvpl/It/GVPf1hXLA8p3B5CGOcrZUDw5Ki8xlAglw1EjpQV3sS7ELAAZ4Li3cxRu0KVK9p4Mlnls0LB7cp7oJDUZdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtwvmRGi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so2360811a12.3
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723206505; x=1723811305; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5AZK4QEEzfr3VuQ9dg4uACWvhzBvDHYYGEqO0otKoi4=;
        b=DtwvmRGi44GbEiZQjn8zrgDJVAJR2+UWxcG9QLe0ASXRp6RHcq4J62y9ELlKh889CY
         Z89OJoy4yUzYbONhaysKarYd/pGI352dlP27+y7tAEOJylwoT1aYufy3hbfTAPlks1iP
         iIZyvTio0by0A3edYCHyOA77c93BhbJ1kpJYX/ijVRAxvpACSlPxp/l5CWI6S0siwgLO
         YuNN+jWHxorhHCiXas9XqZzAkDD8KtmpV3XV8OvievOCrjQve9Kuk98TpTPVTgooE3+Y
         DpL1aQl8596NbBo8jsYvnNn0DdnkGWIzMmseZsow9jYJ+lkW8ViL9NeFOK72cyT7RaVJ
         at5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206505; x=1723811305;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AZK4QEEzfr3VuQ9dg4uACWvhzBvDHYYGEqO0otKoi4=;
        b=SIC1zoZgA3RbBxYMCw2UF0nJawj/wjHJim4obUhdAPhsCrTvnrA6itsUhS7XWPVV0Q
         VibLx5/OOr/QY0EZIYbTOJBTTjkjl6PTKwwzu8m5EU3i6sGjIZtSQ0JNjT+UyiJj+7PL
         yzfeL5/rtYUw28mRZL2mb62albtiC7TnT2LuU/dn3cC/+1hvXThZUtmyuxUhBzQoLSvl
         0sbzjbJnKZGBQ9nK8NcG3EOjfrNr8dV8ET1wLrf9X+tkdSnvBpNViWoG+MYfI2zkfyDq
         dg5KldS8ix/MgZbwZfDbvaagZz6r+IkGSxeGYvzqEw31uAB9NZqoC1aQ4OkDoaSELv9z
         076A==
X-Forwarded-Encrypted: i=1; AJvYcCVjQhl0TKn6AA4Fe7K3poENsONxbtSAj/VSCN0xB3OQ/gFSzyQss9dKMohJoUOjRD+oLd2a7HX7UEQh0z7MR8Qmgi+OYpF6
X-Gm-Message-State: AOJu0YwtASL23AmtTmkJYTwOBnpAsIGO7Jv6KRyjbdiTK8g2e0emca3j
	Tpdn0IUeVJBJyUiVsw4BKj9rw2AgiO7mDxYDZkVuYxR/0QRsSH1WoRygodzjjhQ=
X-Google-Smtp-Source: AGHT+IFdxwfMOb+uW5xKCVPLH9JUrE4SNICMJefKUZ7G5xbhHBIaa/0KrZwOPjgt/ENPK7SHJZvrnw==
X-Received: by 2002:a05:6402:909:b0:5a3:64dc:33a5 with SMTP id 4fb4d7f45d1cf-5bd0a568955mr1076316a12.17.1723206505396;
        Fri, 09 Aug 2024 05:28:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf8e78sm1478959a12.3.2024.08.09.05.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:28:24 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:28:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chas Williams <3chas3@gmail.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-XXX] atm: idt77252: prevent use after free in dequeue_rx()
Message-ID: <cd0308ff-fda4-405f-9854-6a3a75680da2@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We can't dereference "skb" after calling vcc->push() because the skb
is released.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/atm/idt77252.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index e7f713cd70d3..a876024d8a05 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -1118,8 +1118,8 @@ dequeue_rx(struct idt77252_dev *card, struct rsq_entry *rsqe)
 	rpp->len += skb->len;
 
 	if (stat & SAR_RSQE_EPDU) {
+		unsigned int len, truesize;
 		unsigned char *l1l2;
-		unsigned int len;
 
 		l1l2 = (unsigned char *) ((unsigned long) skb->data + skb->len - 6);
 
@@ -1189,14 +1189,15 @@ dequeue_rx(struct idt77252_dev *card, struct rsq_entry *rsqe)
 		ATM_SKB(skb)->vcc = vcc;
 		__net_timestamp(skb);
 
+		truesize = skb->truesize;
 		vcc->push(vcc, skb);
 		atomic_inc(&vcc->stats->rx);
 
-		if (skb->truesize > SAR_FB_SIZE_3)
+		if (truesize > SAR_FB_SIZE_3)
 			add_rx_skb(card, 3, SAR_FB_SIZE_3, 1);
-		else if (skb->truesize > SAR_FB_SIZE_2)
+		else if (truesize > SAR_FB_SIZE_2)
 			add_rx_skb(card, 2, SAR_FB_SIZE_2, 1);
-		else if (skb->truesize > SAR_FB_SIZE_1)
+		else if (truesize > SAR_FB_SIZE_1)
 			add_rx_skb(card, 1, SAR_FB_SIZE_1, 1);
 		else
 			add_rx_skb(card, 0, SAR_FB_SIZE_0, 1);
-- 
2.43.0


