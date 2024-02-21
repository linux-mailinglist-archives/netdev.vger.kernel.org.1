Return-Path: <netdev+bounces-73732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2262385E0C0
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AE01F26EEE
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601C80047;
	Wed, 21 Feb 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="CyWIDyIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HX1B62mY"
X-Original-To: netdev@vger.kernel.org
Received: from wflow7-smtp.messagingengine.com (wflow7-smtp.messagingengine.com [64.147.123.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5697BB01
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528610; cv=none; b=JH96biadB3fWYDCqGcXxEflMtTeBCgBzG0CC7wWEXZa0UGDrjAsqgk2I6Ut4j+z74rJFa35CFtYJE/6R3q/RPrkyiA9u3vUNZt+hMItzYbzs6AUUqben1qmda3Zq3G78LwHcjJzW0a0ypd+Z6KrOCPny2t7mlB2EyOBOwwZ2O/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528610; c=relaxed/simple;
	bh=ZA3sHTASnkjgflK4HbScBfXGKGRg9QFqF+tqdOtRiEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/2C6+zIaTF5C+v6G1GQGp3Cjay6upAcXL4r8Xk8ofMbO6tkmaOGKE2p6qRzIEzg/+ajGkxkDZJPY2kakHnMBUPS5+EZzhqqy69uW13791pTjcDM9prnwYajwujyt8jCxQoWrTgWAefjHnbtCrLXMSspZmGp9HCoN3xeezCmteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=CyWIDyIy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HX1B62mY; arc=none smtp.client-ip=64.147.123.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.west.internal (Postfix) with ESMTP id A772A2CC02C4;
	Wed, 21 Feb 2024 10:16:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 21 Feb 2024 10:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1708528607; x=
	1708532207; bh=HvYAnhRYVc/y2fO5Xmrwnxy3U2Hynx/TN9nYAt/+XhM=; b=C
	yWIDyIy8WZ/wqNWEGl3qtHIrd+b6N2L97wkdMawxwsZg6NEWiQxZ6YzOD/7yFVq4
	3sd/JydPRpuBQmGBRus9MvLr7vYs8k6PArWieZM/ozvg/MvpwrzSaXUKbJ991+eD
	Elgpjo+cTMtmo++vahW5oO2c+hkbuuKluzD5BIbxmpX6lLzT34hlxaDcgZCO1f5H
	tJS0xrzH0/QmvQFlOOIRDeLqFYe9DHF6zEtRwCwcEu3FFMbpYmPDV9iZ1+Ukh3SH
	eFntgKr/5ZjZK4V2xXjtWeS6TM7BJowuFmyWssSdVWFvpGVxf+5lWD8Du9zgfeE7
	vnLp1qrZQSiY9NIBneYdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708528607; x=
	1708532207; bh=HvYAnhRYVc/y2fO5Xmrwnxy3U2Hynx/TN9nYAt/+XhM=; b=H
	X1B62mYHwiW+2i4bD8vRT+fBkUI6tIX/SzxlNzSaeAOkFeJEGjBOXkXNwXduKESR
	E1vuL6WYK0Bj1htqCdI9MGm//+x5x66Cvhcp9QDFizAV210nLXHIgmuP4UDU00W4
	PEKxlSozDGPg3IVgw29/8U+4E7/WF9iWTYdzeqmQulfJBxsWEJjGl57LchCrlR7X
	VmJqiMVJUKAnSZFWW1kjfBEkbILjjAac2yXxV00ALXO9kL/zpjelpsfqgIiitmCK
	8sETu5GnndC7LjEpiwY9KyNAp1vAfw9oMvLKM4NhL5apclgNq3O6G23b2A8Cs4yv
	0V6lalU0IhSz1A+bOCovA==
X-ME-Sender: <xms:3hPWZUuaQ5od6xMfz6WhFyhwa3P9X7nMc2cqsCF1Gi7RYvr7vt8g8A>
    <xme:3hPWZRcwgvqeIV54ARzVahHgv6uC_q_71Z0KYzVzTl-G6VB6plwOxN0WvSYAa04uC
    bdwj05_OsiLzCo20d8>
X-ME-Received: <xmr:3hPWZfx7N99r2jAamav-DMbQv80ff6-hhjA57kj6YlzB0lhbsTS3f3NbePLoF1ooGUdPe-czi9TvTGRzSlLIORAjFqYqFlGDjwELSo3u-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgvnhht
    ihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtth
    gvrhhnpeevieehjedtveevueeujedtveehtddugfeukeeffeettddttddtleehudehfeet
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehqug
    gvsehnrggttgihrdguvg
X-ME-Proxy: <xmx:3hPWZXOeN_2HyuGB4J8LmN8_sZ6mJpWoljxmXc6aM6IFLhcKniTTig>
    <xmx:3hPWZU-NUdF75A2K3t3td4MmueDNjPoyztGtICEBWiC77SoUWUBtdw>
    <xmx:3hPWZfXAaKxTsVHdZPXkRN-nyxtf1FHAq1opjsN6a1ynwbrtvr92Rw>
    <xmx:3hPWZUwoyGeuan1k0MdOGlPj4TuQWAWInUfL5y9BmQoMK6_D29cIhTH8mxWoXIP1>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 10:16:45 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v9 3/3] ss: update man page to document --bpf-maps and --bpf-map-id=
Date: Wed, 21 Feb 2024 16:16:21 +0100
Message-ID: <20240221151621.166623-4-qde@naccy.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240221151621.166623-1-qde@naccy.de>
References: <20240221151621.166623-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document new --bpf-maps and --bpf-map-id= options.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 man/man8/ss.8 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 4ece41fa..0ab212d0 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -423,6 +423,12 @@ to FILE after applying filters. If FILE is - stdout is used.
 Read filter information from FILE.  Each line of FILE is interpreted
 like single command line option. If FILE is - stdin is used.
 .TP
+.B \-\-bpf-maps
+Pretty-print all the BPF socket-local data entries for each socket.
+.TP
+.B \-\-bpf-map-id=MAP_ID
+Pretty-print the BPF socket-local data entries for the requested map ID. Can be used more than once.
+.TP
 .B FILTER := [ state STATE-FILTER ] [ EXPRESSION ]
 Please take a look at the official documentation for details regarding filters.
 
-- 
2.43.1


