Return-Path: <netdev+bounces-85064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56861899336
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 04:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1F61F2245A
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 02:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD8714A85;
	Fri,  5 Apr 2024 02:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khmU1G2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44E12B82
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284773; cv=none; b=NwlOukkpSlqSwQOeVXVMP640WrHrB5kDhjuP+n1f8tKBLk+YS4Cwk5ioJNsN4dFuAqw/OAfcRJRkNs8MRl5EOkb9Cg4GRKTk/ickpFAvy+baFaIUpqgkL7Px8+hJSsaDV4O1dZycRHiTaMc3j9SBzGkz0UqH39dB6FWB+uxYPac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284773; c=relaxed/simple;
	bh=yCrgtIEyJaXtaIIO80fltYjSfsjjoKuT7F4mKQ+FKKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mzLXZquoqKCeb9IIG7XWAQAxhUeJlzHZ5GaJ7MLyGVajBYMYWTYqaLCBq0VYbqapyjfidXpCZeJGvd0tWGokxUe64XZU4L4nL5Q+MHeUP2lcWTCDiAWtaihJypdbBJhxNdly1PkcjLml45C1kLXLTopPQtrPz2MXnlAi54DS9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khmU1G2g; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e9e46f1e03so1080244a34.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 19:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712284770; x=1712889570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru6gzWZMnxJpSoX+oWtJXQs1aqt/q+okaky3Vgyasnk=;
        b=khmU1G2gn2KyWAvTsQdSoG6wnxpRAS7BPHEHqPIMqNCkqkjJGD87LkeEzfWsGBO15Y
         /L8GxDGFzDJXoGFWm/hrTk8bYrxDmOyXs36TxxJIrnCHCdvu8YIrAb4DSnMHGoggFUvh
         wrEBA2pFTKfafkSgIahIzIWsZ+10B45HanGKAm15+G6hqo/a5qLykDhlM1pTg7MPrmz0
         QPgfPJ/0XHmjLPtc/hKOgeWusnDLjYyr0zuKhkgPpdvR3A41MifXYUhe9X2oVJg5WBUl
         EHswIiswvZI+i0wuS1XCYN1G/oHtMFn6p1V+JQ/axLLv+/n8NhouKIj5BVmwFx0vCANG
         fGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712284770; x=1712889570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ru6gzWZMnxJpSoX+oWtJXQs1aqt/q+okaky3Vgyasnk=;
        b=akxh0WiJzAUzoIZkJyR1l0v+QFXn9nsYmi5104IBGOdmanjTJJTruogTfpGDEhrrHI
         N/dCwJ2Imf1ksBAj6wPBBNeBrH6qg6MoSNYQbI1RsRDoA69fu2RS3PYLQH9RBarx5/I7
         rhG06UYy1w3Yh6+DJpl6T1tRGZBIo6wxgsjmN7KTlnemjeJPzhNG+J8djRKL9hEXJlVc
         4TUYW9XzABT4rkdug+geR7uFnshlx6l75zjuKqXaSHWUuU+4m3U7Tf3kiwM2bBDVHCps
         99U19GcT+CI3IrtrJkRV7j33C/GvIwifK2FO1Lua3uBS0nl2fo+GMTuOP+QWedk1mEdn
         5rWA==
X-Forwarded-Encrypted: i=1; AJvYcCVPs9FO+g2vt/pYdqJKQ1U8GhDvRDjpVKayyqksf+i1KxXRu892sRexz1ylXVSatxmr6ua4oo0bYetvuuWnJqBnjjbkbZZC
X-Gm-Message-State: AOJu0YydU8LuF663YZzemUkcYhvIaM2IF+h3yATQuIZWTp5eSkvFJk8p
	sCKhL03Qqkk3d3u141EO/6+hLF7vK0WuGOztIi0/ptgJRE3qb0bw
X-Google-Smtp-Source: AGHT+IEi5eNI/vjTMu+2orLSL75cx2jVOhRKt1mlpryze+uU3jxlB9BUvsiYH4ZfXhti36YHx5oiGg==
X-Received: by 2002:a05:6871:80b:b0:22e:15d2:6773 with SMTP id q11-20020a056871080b00b0022e15d26773mr280798oap.32.1712284770467;
        Thu, 04 Apr 2024 19:39:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id g27-20020a63565b000000b005d8b89bbf20sm366494pgm.63.2024.04.04.19.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 19:39:29 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] mptcp: add reset reasons in skb in more cases
Date: Fri,  5 Apr 2024 10:39:12 +0800
Message-Id: <20240405023914.54872-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The first patch only removes the check while the second adds reasons into
some places.

Jason Xing (2):
  mptcp: don't need to check SKB_EXT_MPTCP in mptcp_reset_option()
  mptcp: add reset reason options in some places

 include/net/mptcp.h |  5 +----
 net/mptcp/subflow.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.37.3


