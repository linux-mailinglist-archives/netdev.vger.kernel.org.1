Return-Path: <netdev+bounces-64121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436A083130A
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 08:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF3C283FDE
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 07:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2069475;
	Thu, 18 Jan 2024 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="UTBwnTsZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrXty0Ei"
X-Original-To: netdev@vger.kernel.org
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C6BA22
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562097; cv=none; b=qOVCPLlJJaPnqAXPCAq1VAIIGmOZMIg+aIHPeUpACYhY0HJ5e2l761AGhDCAUUUry01/xa3XsCT+S2f6ZL98SvpUsVO9UuOcRDACkxGyAvZFqZzbOl/mH6NDiwiklkZWQ7xfMpl3gedK4YEQBJhTno0fbpmsGj6jWF8jgxkmqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562097; c=relaxed/simple;
	bh=yzGd2DE8vejAu+fAQpL+9t8gQmz5fwSogpfMgdsMDPE=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=bThYBRc0LYtrUo0TotLk8fFja7CW2KrqPE8naEbDbrHlyt7UckCT5DSbxZl9Clw96h+lYVVSB+k+e+OMKryNez/c/w5ZpAl/lxBw1FzWwMYOKpZR01sNkjcNIqiIDIYYLm/Cz94tMF9sxTU87sUZSmq4rUKolPuvdlMlMxPYjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=UTBwnTsZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jrXty0Ei; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id 3150B2CC006F;
	Thu, 18 Jan 2024 02:14:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 18 Jan 2024 02:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1705562093; x=
	1705565693; bh=i64UbA6XEuCyrCBY5sa8M6iJyXjvSYKXnF1fyPI6Bx0=; b=U
	TBwnTsZ2Z2XBqhUakzIM5CZ3TeCRoIPUVR6f79ed1Fp1Y5fs3pwGbRO3oPOK/euu
	+atFnIwOt+07YNB7vkQNoSpLZXOLaRrRgLvfbbSgOdm2DFoqrDbuOqs5QGcTQF5u
	MovwaMi8YMz/xgUu6XfZm4Cb3qvJCX/m/zt04KhTt6QeWc44QPq7wMCZAleopzf8
	iDcqtzeVXzridKEB2j4kcveKwwFm2QT+3Kqg2X6/4ZK1EfMV/1//Ji7aEcHLed3o
	okwRcHqRnjd5EXR8y0VVEqy32FdzcZl35xcf293OcgSzYSvANAqvXqJk5RenDRhF
	iOhSQbUUR7Rmcl64sJefA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705562093; x=
	1705565693; bh=i64UbA6XEuCyrCBY5sa8M6iJyXjvSYKXnF1fyPI6Bx0=; b=j
	rXty0EixAcd2FFgOkTmzNZYSSFxCxBuasWnUWVdEb/EdyHNYsxTNjYSkGFKFpM6X
	YAfyNcWkjnY++izg26NQiZjBYplM/1ol8nvFUCp2w8SmVEjt7oxL2Ztj4h5nxlLq
	hO80+v7sE6nsSv80RUc8pmWyjZTQNfJ9ocNXKDUYVlSTV88cmPCjyQNxpCGl8V3h
	fDiUatAX/aRL6uWOspnYOi67Ll8040YvhXCZn/8D5cY3uh2yF6WluMCK+4oBIFgJ
	tQA6JChMZG0uyicYLj47QYqkJnu8DfrByICrjanA8JMaeWhrGRT02SU62WC9/KY3
	OYe3tzuxYdpmFJpl/uSWQ==
X-ME-Sender: <xms:7c-oZfP3jh9s3xKFeosaqOhXe4dgOOm4qtsOMR5Wt9J1MtvN7jdGmg>
    <xme:7c-oZZ8AnngvldGVZlztGBDYUuzX1xMnMlEKZ-W9C9eSJRr3ETIrxjh26mxXzQqcT
    FdjcFY66NUeJplQQHA>
X-ME-Received: <xmr:7c-oZeR1ybvmRcXpV7aRMlerxJjNmaly7JOs_ylLhaI6clO0wUX-pJ4rS-WpZUV-DbGgAGaTnrpDc04DORZfi_PeAmiHbzl2QtyTM7YM5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejiedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgv
    nhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrg
    htthgvrhhnpeevieehjedtveevueeujedtveehtddugfeukeeffeettddttddtleehudeh
    feetleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hquggvsehnrggttgihrdguvg
X-ME-Proxy: <xmx:7c-oZTt2xZ9obIkY8Lk2CJ4UZvMnh2wrnDdSLVzAzMxe6HFG9heo6A>
    <xmx:7c-oZXcd9NOOafIudcWaZZuYz_-zcfNk1q3GLkbp0zQmqGTTwtojjg>
    <xmx:7c-oZf0RBG5MaQ3pjHRjnL8bQWVcBUIchI2s8_UjGs1qhobXqPXZTg>
    <xmx:7c-oZYECW8P88Vv1MeSApyGIAOZyRb0umynw1JjTFZ5d6FcK3KyavnJ8UKeFzf-l>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 02:14:52 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>,
	kernel-team@meta.com
Subject: [RFC iproute2 v6 3/3] ss: update man page to document --bpf-maps and --bpf-map-id=
Date: Thu, 18 Jan 2024 04:15:12 +0100
Message-ID: <20240118031512.298971-4-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118031512.298971-1-qde@naccy.de>
References: <20240118031512.298971-1-qde@naccy.de>
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
2.43.0


