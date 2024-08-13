Return-Path: <netdev+bounces-118216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7464950F8B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 00:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EFD1C21B2E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1A1AB503;
	Tue, 13 Aug 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+I2LiXd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F91AAE39;
	Tue, 13 Aug 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587306; cv=none; b=kiHiUd9+h+pZJUN+MXyEcfw3hm8fxiL1o4M0fcKtGVJuAmVr5f5Txg7j8SKHn4NcANLNLz70+vqgLurk4A86iYdLbBe1M8niMtBqNvwkDmwcrU7YnOAJOic2VGzf4Wkc3fKQsW0vqBtlSdi9EemAxGZMbE2E4r/34iZS+xRnS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587306; c=relaxed/simple;
	bh=vt6nsaewShD5afhtTMqHJ1S+APpB3N3wBMEHbNW3qUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPbHhdIQ955MlBwdPBUrb14vNSV9gp/W8kgCaj/M1XZPBIMALEfjZclApsF6dYkdP3x/6gyP9ZSnfsbEUnUIWS+e84QTZHIglGk9L+uvwyl33wwRmCYJdxO0ipB74YOFokLebPsk7cY+yTls289lFGEFkrDhoxnxqzc9bM+wO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+I2LiXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE195C32782;
	Tue, 13 Aug 2024 22:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723587306;
	bh=vt6nsaewShD5afhtTMqHJ1S+APpB3N3wBMEHbNW3qUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+I2LiXdxJ76KzfaGzu8o11VOrCk3Ib4xUrt0mhb+mfRGCammi1tl7M/cpfDgRRP6
	 kBKB/gODwylm/C3TY7hsdjP8Rr8huvrJtZ5AIuU1L+mv0Ef82M+scNjn2cTiapiBad
	 OAx8Tfk1z3tFeW5AiVeP+9EUT50rONMvpPagRXLDaAeNelgpVUUX0mTXORRaBwBadD
	 onQwzkncA4HPPX464R8dVQIOXB8TcnmpmkKu+IwaxUcB8sv0ibIeen6YcUBET8dvd5
	 vL08YO3RAHpQ7ik0U9zjpl4LbHVPJcD3mLXVdPMC5WQgsx/QsQeY8OFqRvHB1Ib957
	 h0HEOQj0rhsAg==
Date: Tue, 13 Aug 2024 16:15:02 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2][next] UAPI: net/sched: Use __struct_group() in flex
 struct tc_u32_sel
Message-ID: <e59fe833564ddc5b2cc83056a4c504be887d6193.1723586870.git.gustavoars@kernel.org>
References: <cover.1723586870.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723586870.git.gustavoars@kernel.org>

Use the `__struct_group()` helper to create a new tagged
`struct tc_u32_sel_hdr`. This structure groups together all the
members of the flexible `struct tc_u32_sel` except the flexible
array. As a result, the array is effectively separated from the
rest of the members without modifying the memory layout of the
flexible structure.

This new tagged struct will be used to fix problematic declarations
of middle-flex-arrays in composite structs[1].

[1] https://git.kernel.org/linus/d88cabfd9abc

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/pkt_cls.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index d36d9cdf0c00..2c32080416b5 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -246,16 +246,19 @@ struct tc_u32_key {
 };
 
 struct tc_u32_sel {
-	unsigned char		flags;
-	unsigned char		offshift;
-	unsigned char		nkeys;
-
-	__be16			offmask;
-	__u16			off;
-	short			offoff;
-
-	short			hoff;
-	__be32			hmask;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(tc_u32_sel_hdr, hdr, /* no attrs */,
+		unsigned char		flags;
+		unsigned char		offshift;
+		unsigned char		nkeys;
+
+		__be16			offmask;
+		__u16			off;
+		short			offoff;
+
+		short			hoff;
+		__be32			hmask;
+	);
 	struct tc_u32_key	keys[];
 };
 
-- 
2.34.1


