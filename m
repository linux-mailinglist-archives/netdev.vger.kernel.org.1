Return-Path: <netdev+bounces-191356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF2ABB22E
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 00:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B5216C210
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 22:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB11DC98B;
	Sun, 18 May 2025 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgRmrRYI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E795EEDE
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606869; cv=none; b=qxXAuFJuQAz6C5NaFuxKHbhki/HuV/XC/Zb2d8AaR84MwxX27vq7GZaM8b5ltczgXSKm8jNejRkhIiJTkweVxPcQlLPxCVMUA36rb7SX0PTTvIromW6l/AsA5FL8DHSO5gSSKfGP9nnc0b9yNa4QtQS13O8v7HNUtoNgTGK3upQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606869; c=relaxed/simple;
	bh=Q4EGLwVLhtZfbm77OAQ37OdoxfEzBMbTMWBO824oIfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cmtaj26r/w5gb6FTBy+tt5kn+oIt7bmHf33CGcnajAVCqxg2rPrXWbiluWl38kJHerMO8KDCeBDIkb+4GMcrXt5dBwKzy4maBh7jjv+yNcbcQAD59T48pDIp8WLEj3ou65AAKZ7Ehvk92wTWug5nwULYrh2oQhMu4HXJklyUatE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgRmrRYI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b200047a6a5so4258058a12.0
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747606867; x=1748211667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAMfQO7KMI9oliHbiBvSRiPnXxdhje9ilLF9y3Jn9Ho=;
        b=dgRmrRYIVH1PSS50AgvtoHyzR00n7vinQjJ5Wfg3OnLLvoz2NBpAVmKSSj9mqcHFC0
         9mreCdKYUa9+xchLtFOZtoKmg3Xy5LWkBXZS4Q3yCB7vCmohric3NXP48NsJGKTUnn9J
         Q0JYtPDSOq0gHt+5+vvBdcRlHk8zkqNXHxP3QsEp5qMcYVuQDLPbhmeHacy8f57L7TkF
         snoO5PrVyRT+FQVvCcnmFjW76k9Ji6edeJaWNqOOMMr78bJQRoryRHpln2ju0OpTit8Y
         UzUfLhKrh04bFNJDZxkDX1iAWBvpFfh9nhOovtP/GE6wV0B/RHrAcHOSQH7yNTD/nHF4
         v2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747606867; x=1748211667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAMfQO7KMI9oliHbiBvSRiPnXxdhje9ilLF9y3Jn9Ho=;
        b=ulohzc3AtWv485hCvJxwHT9fd9rWkKGu5Dk8+9AAk+65Jw4LxFWumI5P8I6C8jSmA/
         khMGG36Za2knbG93Nqq/RRpiX1Pv2QFz31Lbrpd74gwHeBDDifN77rM1Ih05Ig1jY4Sw
         Fo+qBaiyPXHEYpxBz5nOckZIqJD4FnvH10AxcroRNQXzBqL1x+opDOnt9PuuZJPjMPa0
         qO2FVgitOvhgOjQWnHPjj4c7nBYpHcPN/XOO7yC08upZWyX7gcLoWwPBa6gLr/DSFNI6
         NfwxUxi1MIym3xE54Zi2C0aIz2zbSETEk0Smrjo7koBS6ImW8CcsO5D1GX6MeMXg0LQw
         YnGg==
X-Gm-Message-State: AOJu0YwjNRD5ciGSPcGPg1p/a3FwitOCMtrD8sQDjHyvTnPYDtDkwfak
	AhMman5OqL3S/A0lFI6QoVK3hRwa87OuQaj6oRIIqx9kZJlKdjPny9tfTHVbLQ==
X-Gm-Gg: ASbGncv87UcFtqJUhYp0TdpBMs6AN/F5w7A7rsDAeJMs8AuBwOF9a6Dp7SY/K1lnfIh
	dldYCATB9zW/S3G3vDnEPu/ArlaRlGZ10O0k//xMmbN5FCz9+f2qsDrN6nR1EwOpp/Usk8zd/Qs
	tSqL9oQO7nRyAO04uL70V7WBqJyFC4ZLKwjfilrSoFum259Mu5h9qsQVekduGtKnKbjuZF/h+Bh
	6/7zZiWGnxP4lZckWwKOByymRiZ5NcvOfFh+K/7SWE0gUqjNi3iNKPsymkqFlGDbcfAEdOhWDq0
	a8qiNImHn6xV04fQjUlwAR/GEb1/cszsYsp+nG2TvkzUCOpVatqDUTlM
X-Google-Smtp-Source: AGHT+IF5RyNKaiPE7mLv0bAqp1R10PUYeRliIgVA3CIXHPbuT3D2HLg5n2FcWoFjRzqz7RNFl9rBIg==
X-Received: by 2002:a17:902:da91:b0:215:a303:24e9 with SMTP id d9443c01a7336-231d4ae1de4mr149405185ad.3.1747606867330;
        Sun, 18 May 2025 15:21:07 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b16f:3701:bd1c:9bc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed4ecfsm47360005ad.234.2025.05.18.15.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 15:21:06 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 0/2] net_sched: Fix HFSC qlen/backlog accounting bug and add selftest
Date: Sun, 18 May 2025 15:20:36 -0700
Message-Id: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses a long-standing bug in the HFSC qdisc where queue length
and backlog accounting could become inconsistent if a packet is dropped during
a peek-induced dequeue operation, and adds a corresponding selftest to tc-testing.

---
Cong Wang (2):
  sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
  selftests/tc-testing: Add an HFSC qlen accounting test

 net/sched/sch_hfsc.c                          |  6 ++---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 27 +++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.34.1


