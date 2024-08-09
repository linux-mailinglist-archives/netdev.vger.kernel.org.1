Return-Path: <netdev+bounces-117197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD48394D0E7
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F331F21662
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41063194C7A;
	Fri,  9 Aug 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="VyAqTc8g"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB90194AFB
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209272; cv=none; b=i6yzOo7YkLyNBZMSSnj6/FnX8OheIgp44RdHTUnJiGiE6x8dY9Fpl3RXKlUnJq4RPsoGzs/ZPZ7cGaCv7mvAZgIoJtWZkaQmskGoI6WPlMXYtb9IfM+DvgsMfFE1vd6lvDk5O5HSEt7sfAuByyJzZJbgIqg4oVADKqqz0HWAfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209272; c=relaxed/simple;
	bh=erw+R1kjKGRctwnn9LXAlr8JVA/jIKECrm2CKtmOylk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RkAD3IkBvoe+1fxtJBVSXiOYmIeBsFF20fkSFly/Ok22HajbT4LjPfqWwlJyt/5uGOpVW0TOfxTeeaYXTtsowErmNvOYO4zlFLaaOrAmhwsj7WVG+NF8XeC3RzG6oYPjavo2Kj1vGyle3x6oQoWGGJ/HJbt+feqvb+22lMo0QQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=VyAqTc8g; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 95522200CCEF;
	Fri,  9 Aug 2024 15:14:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 95522200CCEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723209268;
	bh=y7ZVPN/EWbg8gF97pR4EKPOTDgcM0wlrD0hT+SU+x/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VyAqTc8gSOq23dTKJqVXQAz1XW2YWmRszasjzfc2v0iFHtPLpyUVkhDIafcJZfymB
	 oT4VLUPDc4koF1dXSbji84rpT9HyzqrETRn+Moa4i4R0dv/0VBmxhr6zLiZXNAzzyA
	 /JaNZO6oV7tiklkJKmGhuAXlBL3SRnbt6cZ9tjbJqvILBv+6UDVe2rUyLOkHhkCvLO
	 43PbbEAZ1+u0oBtexrwnUqTwNZ6BS3Q1hVDOOw/gW9dDDG8PU8mQj0Re7Jl2p6jSzH
	 i93ce5U0UxzW3nnl4xGMo1N9RgSJiTogFFtXvUzzxxTeEE3Gq2al0YmIf3JiAL9mCj
	 GOXJXMWP59srA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next 1/3] uapi: tunsrc support
Date: Fri,  9 Aug 2024 15:14:17 +0200
Message-Id: <20240809131419.30732-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809131419.30732-1-justin.iurman@uliege.be>
References: <20240809131419.30732-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for "tunsrc" in the api.

Note: either include this commit or pull uapi from net-next.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 include/uapi/linux/ioam6_iptunnel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/ioam6_iptunnel.h b/include/uapi/linux/ioam6_iptunnel.h
index 750357b7..9c6171ea 100644
--- a/include/uapi/linux/ioam6_iptunnel.h
+++ b/include/uapi/linux/ioam6_iptunnel.h
@@ -50,6 +50,13 @@ enum {
 	IOAM6_IPTUNNEL_FREQ_K,		/* u32 */
 	IOAM6_IPTUNNEL_FREQ_N,		/* u32 */
 
+	/* Tunnel src address.
+	 * For encap,auto modes.
+	 * Optional (automatic if
+	 * not provided).
+	 */
+	IOAM6_IPTUNNEL_SRC,             /* struct in6_addr */
+
 	__IOAM6_IPTUNNEL_MAX,
 };
 
-- 
2.34.1


