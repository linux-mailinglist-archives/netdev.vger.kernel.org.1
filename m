Return-Path: <netdev+bounces-71000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840DA851857
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406242877BF
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A023C6BA;
	Mon, 12 Feb 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="aM3HB/ha";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ifvOTZAJ"
X-Original-To: netdev@vger.kernel.org
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9613CF78
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752632; cv=none; b=FdwdbuxCuRMmf08tookf7mBfbLLcE+/KqSL/S8qbEbY4l/v+k/zrKjqIfuKZw3ZgE1omYvcZC35PYyJDiO67ZdXfEUXCoxlOCze0tTycdc12lgkP4j4ikwm7b2ZyAkLGqQT+FAqTzJ80yGb3LDngZTMSPNoCAvNkciLX+j5HT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752632; c=relaxed/simple;
	bh=yzGd2DE8vejAu+fAQpL+9t8gQmz5fwSogpfMgdsMDPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrXNrcjx54cEInIIKazHYTgSFqRgwe0H3lI8VQJU91s+g/ZJuTk/6W5pBeOqrKSm9fP/MtpzrOP/5oMH9dFa6k1XVRwqncjhDee9ozOEDDP3YwApL8fXobQ+c8BilIza9SQ+IkgawDN9s/VKx95IAKesURrSH9QRNlBr9FSHEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=aM3HB/ha; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ifvOTZAJ; arc=none smtp.client-ip=64.147.123.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id B27872B0096F;
	Mon, 12 Feb 2024 10:43:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 12 Feb 2024 10:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707752629; x=
	1707756229; bh=i64UbA6XEuCyrCBY5sa8M6iJyXjvSYKXnF1fyPI6Bx0=; b=a
	M3HB/havxO9wXyBjP5bv00C7Pak0Ut1ugVfqH7O5BG26NqtlPUNE+KP6+preRnIU
	3RbX9iluj7BS8SPMivM3XeXPhO1ngyVL0ob6d7+vP0syoUJxTNSqh/ZX1gHfTCQk
	CHL4sI3FCRbqKBa6FRO0Ys0v3xOYgkeUiLbsFX05ktwmJsyDUvkxG37hL6f5dJ0s
	oefP2qY1C/HEqw3thL11dzfjsXhS+94Qsvps8Xq1By0VjsWRHJMl92LDZCkmK/fI
	yRswbM8InHFUnSMDXbLIH6oAxC0mIZquq7vV3/UzMDxIKcpfVQ6ic+4MUphfzxB7
	c0X99sRWBTt1Ci/5FP0dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707752629; x=
	1707756229; bh=i64UbA6XEuCyrCBY5sa8M6iJyXjvSYKXnF1fyPI6Bx0=; b=i
	fvOTZAJf7UOUt8gceHQpMzuF95q/cn0t905Wbi2DJ5U/MSygoAJfTbsPdaI6GdV+
	YderQBYNQjkcAA5LlXptZVmveyZxbL5LICKjrzMRUGpCZD+N2ETmksYTCe6B+Je4
	wORbnFtdhlQqWbYQuhbSGzLZLA9qNJPquPJrqU3hP0EIidM+9wHNV/JbsUmm5/ms
	whg/peuCBbmePLZg6L2MXL3dJV8x1O7eIggJiwruPvNFF26RFIFOXBQRZjcf5EiT
	gRFekhe7GtiP3Slo+zk+HDtDbHQeFinMJea8RQDKJOkknLjxDcvU1DSeGPmkA8W4
	ZNXqx4RHm/O+3C0NtmteA==
X-ME-Sender: <xms:tDzKZYdkakAlSanbXXvkAl6Z0YzB_zCbC0SAOxJW4h1yv8HXJGPSHA>
    <xme:tDzKZaMzCAoSVA2BerDrq74qXCBZ0LwD1MOhqtnBBFzEFq60tkfHrGVqRlVoE3Cqd
    bvOvlZWydQGy-joPp0>
X-ME-Received: <xmr:tDzKZZjGho-LVSLXqp33OPNt32aWp1U0XXF6-2I_KIi84b4kAZ41NydzXXWfuLKvPWU_T06u7Fsfb3-d2uf-ZDlW8NvYjm5NAFnafd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgvnhht
    ihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtth
    gvrhhnpeevieehjedtveevueeujedtveehtddugfeukeeffeettddttddtleehudehfeet
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehqug
    gvsehnrggttgihrdguvg
X-ME-Proxy: <xmx:tTzKZd-K0lusURDxHWi0NTvS-GRI619FnAFchVSuobwaUsbT2kwI2A>
    <xmx:tTzKZUs_QeV0gd1QjYXcHzen4KHNUZq_v0S2JqpwFDnK8orMAPpbRg>
    <xmx:tTzKZUHxrx9XhDMRi4e2CFoTO_l9rR7_oTYQYZVNrxYxRFUBwepI2g>
    <xmx:tTzKZYj5ZQjY2bBE3gdtamfGMtJwL3jmHjwuE0aJ020XMTOsGy_mZYLTVeU>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 10:43:47 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v7 3/3] ss: update man page to document --bpf-maps and --bpf-map-id=
Date: Mon, 12 Feb 2024 16:43:31 +0100
Message-ID: <20240212154331.19460-4-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212154331.19460-1-qde@naccy.de>
References: <20240212154331.19460-1-qde@naccy.de>
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


