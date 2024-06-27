Return-Path: <netdev+bounces-107237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F0791A5D3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B351F2282F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF7D155743;
	Thu, 27 Jun 2024 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="3ExhrygD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D35E14F124
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489366; cv=none; b=ZtSZbvAosDhhvZltl+nFF8Er0IPvLBxbi4jIEVfdPw+dXOTGD6D8o4aG1PrKltjscpJIz8cIaSoqCHDSmaVOwIqByZsFWmdl7rxrlsN/gMlSNiUa/SNPJewK6qnjd8GHLIQJrZLQISW4codP+gzeq/xjLs5ooLEhyZ6SFYfB5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489366; c=relaxed/simple;
	bh=FYwN9+WXxNL0s8JGZrDOOlC0+Oy/VpiVqU6F01gXKwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu8RVZHIZJ7utm8sEJN5oMkUkV1lrllQf8jyDL5g27YclhesiSnIgDppIrr3jSs2MxYwQWv2OgbJ1I4gUYS0IrEZxvUSLNVMmJpMRMmvZVACW/3RCiDm4xw0aaJ7t8I06MCY2g4pvT6u53DDX5t0fPoiwfi6iIbmyad7fx1x464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=3ExhrygD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ce9ba0cedso5867606e87.2
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1719489360; x=1720094160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYwN9+WXxNL0s8JGZrDOOlC0+Oy/VpiVqU6F01gXKwY=;
        b=3ExhrygDHAe3ZViPQGR8GKO/CNpSx7vvhN6oSw4yhzEFiBAvglmdNhd3tEr4Zyp8vd
         5HJlrIVfa8yCHDae2JmFxExJ9MKwKRNv2UNCzArhzyTfF2hUoAcNKGJJ3MsJPyBq48Nn
         kiaf7KKrfwtfi3g8HPHUHYdvH3ErbxCAnq2F8AQqynbftHdtdjoqoeMRwnkIoAHm9zf8
         zk/GVeE5rzRBnxKlKjMo+nFWUwMchFCneSpVBcsF+sJbggoCrfLXOFGxAVKVdMdQMfnr
         BaGMSrihD8K5f1zgqclrEYy6Cb8Bw1w9KpoKLNJJjuePbM515qHcHtMYlx0+c3vxt2uP
         ExOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489360; x=1720094160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYwN9+WXxNL0s8JGZrDOOlC0+Oy/VpiVqU6F01gXKwY=;
        b=Re4qmYsjAJvoukb38H+lF7g6W9kg98A6zblrC+9jtCdLpS2lNQ3pu3SM52vvNkjJ4L
         M6r6F7Kaiz1DkNMfSDCMZziLoH3Us0BtfAUHVRMxXP5Quc8TKegW+eFREnB6iMBs1iII
         X2FqxXEnFwtto7V2H6CRwMMgmsxsypLZKqk/RXe/aUCAxpSmq3gwYe40xgeRjWax0BSy
         rd6v4cQXdoSnYKtXfHL1pqbKPM+k2V0eKFqioFil82848uqcQ3RUcpG3aOSNEv9jOtbF
         LaQmyKgE1yYsNrIt2x7yVTy0QDEGdOldXQRVSpzX7aJy5SQDYb/qPda6U2xmaY5nIeKd
         9R4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsvTbgHeW6Ez7/KAYJFtuCuk3gSN0gIjv9h9k80Pe9BdNWOyMP6hmqs7+4mq4tyInPnzj1PEM50LMcXwuRSnZjfbSreXV9
X-Gm-Message-State: AOJu0YyF0gb9ge8QD0otICfG4lzL7sn3EgcP/oicfyG5Gag7IIyvV/tN
	xVOrauRa8xiKiEn89dXQdaJ9grD4jjuqXXivP+lr9fYSUZMmg+F7M2tf0sohbEA=
X-Google-Smtp-Source: AGHT+IE5dEqi32o555lHsYH6cLbWsYyak8HFjN733ejp92fah5sVWgpO97Hsp6G9Neyybv3KzqjyMg==
X-Received: by 2002:a05:6512:324a:b0:52c:deea:57cb with SMTP id 2adb3069b0e04-52ce182bccamr9414630e87.3.1719489360229;
        Thu, 27 Jun 2024 04:56:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a31a:e140:9480:20a0:e0ea:447a:fdd3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d779773sm52072066b.103.2024.06.27.04.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:55:59 -0700 (PDT)
From: Michal Switala <michal.switala@infogain.com>
To: kalachev@swemel.ru
Cc: davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yoshfuji@linux-ipv6.org
Subject: Progress in ticket
Date: Thu, 27 Jun 2024 13:55:44 +0200
Message-ID: <20240627115544.1090671-1-michal.switala@infogain.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZnWSHbkV6qVy1KHd@ural>
References: <ZnWSHbkV6qVy1KHd@ural>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am currently looking at this bug and checked your reproduction.
Unfortunately, it doesn's set xfrm transformations in the same way as
syz reproducer. The effect is that in xfrm_lookup_with_ifid, the packet goes to
the nopol section instead of notransform as in the original.

Regards
Michal

