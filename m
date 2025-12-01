Return-Path: <netdev+bounces-243042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2114C98C8B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70D1D4E1BD6
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C302309BE;
	Mon,  1 Dec 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="cOp8cmsj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE32222AC
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615518; cv=none; b=kmUhWSuFZ5jbxPYlscZa+H4kKALBgMqrHu2OcT/IyxboPmKO1iQKhQwMA6/CgpKR4jhJvyHDUYYmPOS/jKyBDt9SE023QEadwTVNmPQR0KIgWbwyrE0jMU/lW3pTAh5jzm+Qlv6UNf1xltsSHosL0/71OgkFlQUjPi2LdgAK9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615518; c=relaxed/simple;
	bh=h/vw6doqfwu2LN3gevJzezu1ud5SOaKPjmul2GX4J9g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aVbBOqs9gqYgCLffl3TTQG2TZrhGo66G2XlFsWA+AUnQQu/vnuhJxs8qLBr6s6jwGI3KGvd0AdDCNP6Mu950eD5hlqKBqSdLA2Km21P0Ia3vPG+Ip134Id2IEFjI+BFiEaeefAjr6arcPCv5HVouOw2fxujWlohxTSHu2PCa/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=cOp8cmsj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso3250230b3a.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 10:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1764615514; x=1765220314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JE6ju+09D4WtC5XpKr6GAfPhsraGaLT9IrlrOYPzRiA=;
        b=cOp8cmsjZuv5U2MkzQ1Cr2mz0oEjGDQvXpmfhvHCE3thn1TuHrB3QgahG5iKIjPgN8
         rVtcpNFC8ZEQca53y3AyE2fOP3Z/Cs4SOyovonzzCyKKw69XC0pL3PJTKsJu4XqLrN3i
         aMXPEDjca7zCEgor1FzHbCKRekx2mYBEHOu0NOfA/eTYDVbWtuD2FIGuVomibNZp7piA
         syQGEek2dZnfKcaksCJpL4PZ+eDwxkq4Q2ayrSYcv9m9+lwUnrJqT/xB6dYw4WFCWuOB
         /7kwxG4k+nFnHXypRQ8IPUbXw4M0oO+vY32+jQrIm1+vixvpTw8HnMi3SclYHgepsTJ8
         GMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615514; x=1765220314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JE6ju+09D4WtC5XpKr6GAfPhsraGaLT9IrlrOYPzRiA=;
        b=mhUhAODfXBLbbMP4c6waSiT3+hHIBPFLHztTl5BDvtsH3uc/ipT8wZ1cg9IxwCr1mx
         l0woQxX8Wvw4KECGuTO5UHhMK/NhfYLMUyU7rBZ498n/83Q6LE3hP1X3r3XzdPJWWSCz
         KUAhWGbrijQ+9yw3VUGk3ZI8pP2hXvE/x5jdz1QvABhdBHgKt8vWKkroNRQ1t4o02Ka8
         siNhXhqlfSjCMu396h1GmrJZ7mExTrlFUVGb2wH3aUklI52p8QxHYedpSuL/ve4vLUlS
         UCEvCvcxbNFLFCDKR8ROvY/onj/U7uGwzrjreIRQ+e3ROFuUu6pXqeyiDbgSfZnNw9l9
         /LqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJHctFrzTh+rqdLdUG4nmaQxBGBhzIW9bDvyAjwV3Qe4L9pptYQTXIH1p2XNp06n+8PtU7SxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi677+QCRjFdz0305qlEIzBssfQRzcbaKfdY2oxOYY7dkHrjEs
	oB73uQbuvWY/CftNa5VVnHToaK8pbHvQAFFgtyNf9Rck1ZKnl+63dZehdW33wCYYZg==
X-Gm-Gg: ASbGnctRDdmvUKtJGEAlHhJMh8JyuyJpDW+m1cZPwzEO2RNMatL2mPkP89zyOSK9v0H
	L9ACE0OcSmJYwMWmWSQo/JKe1YpNWZTcXVLactZgMqs9IJX9bh8A+RgJVx6IHY56hScChsgr3lW
	pU7c6Cv3MourXcM+FqfV/QM9MzDLY2ACNbYTNnrHiwEmIgaQs0ieEEpkdA84HdEuf2hamHOEp/n
	Aw/xoh7lnj6dm/qNi9BX72wxFT9r/ERi670IpSKjzMbFq8ktc21SkuVdFvNXzW81UcIiIRAGMWy
	IKn6EFKN33QGz+pql6lmj0A5Lz3Tdql4oiKvVICn1JCXO7HoNMJskpuwKDF/gb/E0qDu83m8UL/
	JG1aTSiEduQ+m9bzv41cLYM69hzOoX5fd27NF8Na+UrOQZrVM2sgveQn0EOOC4sdOzWrxKS8/oT
	K79x6aEWBJKlE27dA8s1D7OiGWObtC1u1rD83NiT66PAhnZSLmUmY2umJt
X-Google-Smtp-Source: AGHT+IFzWftnrX8LBNKAXRWK7plG9n3JLmlq0o4KlN6gEPAsPokKNKetOBP5cByfBILo6+ry64M+zw==
X-Received: by 2002:a05:6a00:4f91:b0:7ab:2fd6:5d42 with SMTP id d2e1a72fcca58-7ca8abe60e7mr28204850b3a.16.1764615513924;
        Mon, 01 Dec 2025 10:58:33 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:14e3:ac6f:380c:fcf3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1520a03a3sm14522852b3a.29.2025.12.01.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:58:33 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: tom@herbertland.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/5] ipv6: Disable IPv6 Destination Options RX processing by default
Date: Mon,  1 Dec 2025 10:55:29 -0800
Message-ID: <20251201185817.1003392-1-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset set changes the interpretation of the Destination Options
and Hop-by-Hop Options sysctl limits, net.ipv6.max_dst_opts_number and
net.ipv6.max_dst_opts_number to mean that when the sysctl is zero
processing of the associated extension header is disabled such that
packets received with the extension header are dropped.

This patch sets the default limit for Destination Options to zero
meaning that packets with Destination Options are dropped by default.
The rationale for this is that Destinations Options extension header
can be used in an effective Denial of Service attack, and Destination
Options have very little or possibly no deployed use cases anywhere
on the planet.

The Denial of Service attack goes like this: All an attacker needs to
do is create and MTU size packet filled  with 8 bytes DestinationOptions
Extension Headers. Each Destination EH simply contains a single padding
option with six bytes of zeroes. In a 1500 byte MTU size packet, 182 of
these dummy Destination Options headers can be placed in a packet. Per
RFC8200, a host must accept and process a packet with any number of
Destination Options extension headers. So when the stack processes such
a packet is a lot of work and CPU cycles that yield zero benefit.
The packet can be designed such that every byte after the IP header
requires a conditional check and branch prediction can be rendered
useless for that. This also may mean over twenty cache misses per
packet. In other words, these packets filled with dummy Destination
Options extension headers are the basis for what would be an effective
DoS attack.
    
Disabling Destination Options is not a major issue for the following
reasons:

* Linux kernel only supports one Destination Option (Home Address
  Option). There is no evidence this has seen any real world use

* On the Internet packets with Destination Options are dropped with
  a high enough rate such that use of Destination Options is not
  feasible

* It is unknown however quite possible that no one anywhere is using
  Destination Options for anything but experiments, class projects,
  or DoS. If someone is using them in their private network then
  it's easy enough to configure a non-zero limit for their use case
Additionally, this patch set sets the default limit of number of
Hop-by-Hop options to one. The rationale is similar to disabling
Destination options on RX however unlike Destination options
Hop-by-Hop options have one common use case in the Router
Alert option. 

Tom Herbert (5):
  ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
  ipv6: Disable IPv6 Destination Options RX processing by default
  ipv6: Set Hop-by-Hop options limit to 1
  ipv6: Document default of zero for max_dst_opts_number
  ipv6: Document default of one for max_hbh_opts_number

 Documentation/networking/ip-sysctl.rst | 38 ++++++++++++++++++--------
 include/net/ipv6.h                     |  9 ++++--
 net/ipv6/exthdrs.c                     |  6 ++--
 3 files changed, 37 insertions(+), 16 deletions(-)

-- 
2.43.0


