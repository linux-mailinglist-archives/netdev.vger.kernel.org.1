Return-Path: <netdev+bounces-112591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CB693A1FA
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5309281915
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D3B15252F;
	Tue, 23 Jul 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="wHsNp/KJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A178F70
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742713; cv=none; b=tMn7WTAteXJw1z2kicg/gTeup4OdgUNYQUDZ7K4wncmGST11vpFPOkKkF2X/68RMgo6UiBDYM+rV9aeaoXMw08pk8ic71jutLfium3q/E3ay6Ig3eFwVhJBSZeqZ363d5U0KKts8Q8LH7H9xBLOiOuAIdC4UjzDmpLmxC7hvKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742713; c=relaxed/simple;
	bh=VkIc8hikVA7RDTmY+VUiu2J2hAERnotG+D6NR7dKZqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/UnqW6hyJyB7QRkBQDKFDqDqz7ocnrXQXlXmvtT6rPHKfXG/A35bh0MwW8h5ZQPS2MdUQW3IL9y/4nQPcdgNHn1loNxp5fu35awDvJJfRBFQC9mHl7VIGSfH4kMLE3I02W891eFRapkfzY7J141NIgbSGkZhULk9u+9GNtjBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=wHsNp/KJ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 371F87DCB5;
	Tue, 23 Jul 2024 14:51:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742705; bh=VkIc8hikVA7RDTmY+VUiu2J2hAERnotG+D6NR7dKZqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2002/15]=20ipv4:=20export=20ip_flush_pending_frames|Date:=20Tue
	 ,=2023=20Jul=202024=2014:51:30=20+0100|Message-Id:=20<3506b4e72666
	 2dbbd6f447be054c68e31deeaf47.1721733730.git.jchapman@katalix.com>|
	 In-Reply-To:=20<cover.1721733730.git.jchapman@katalix.com>|Referen
	 ces:=20<cover.1721733730.git.jchapman@katalix.com>|MIME-Version:=2
	 01.0;
	b=wHsNp/KJClLN7rK6jQ3Vrw3grB5gimNJ0YiGnWOmZv2w/VuPFK7Xlbcvp5jtFhYs5
	 7SteljmF8XlJB9ThygkPzMNJFhwDzywR1pwCgQ46kvWZMpadoQe2SUWonr3qCa6K3A
	 UWKuT7k2JfEC/WOBBuFo4rIfkuWOCz8bbd7K3WGkYjDxwmur6cdPw69VGtrdiAB07i
	 NR3Pql9rphTuezU/WZJ63Z54cvc5dJHf8IpxZUeof1pA0SQzhoW41Dc79cp1wOKjzW
	 3CrMN24xMFUjbkh1MpcF1MLcmzv4lHYrxJVNaTgQ1WpUepa9vWiNQnfhhCRQnM7Hyv
	 84FZhU4YZD44w==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 02/15] ipv4: export ip_flush_pending_frames
Date: Tue, 23 Jul 2024 14:51:30 +0100
Message-Id: <3506b4e726662dbbd6f447be054c68e31deeaf47.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid protocol modules implementing their own, export
ip_flush_pending_frames.
---
 net/ipv4/ip_output.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b90d0f78ac80..8a10a7c67834 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1534,6 +1534,7 @@ void ip_flush_pending_frames(struct sock *sk)
 {
 	__ip_flush_pending_frames(sk, &sk->sk_write_queue, &inet_sk(sk)->cork.base);
 }
+EXPORT_SYMBOL_GPL(ip_flush_pending_frames);
 
 struct sk_buff *ip_make_skb(struct sock *sk,
 			    struct flowi4 *fl4,
-- 
2.34.1


