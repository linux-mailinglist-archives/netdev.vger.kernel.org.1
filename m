Return-Path: <netdev+bounces-182483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF885A88DAC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC383B63EC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47091F4184;
	Mon, 14 Apr 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpGY6iGL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1C1F4179
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665603; cv=none; b=tl/PfK76hBpqj99e/rqT9BTHzd94szsytAREwzfELLvF1Fkc7kTdXf1hDtLRqwHCK7OaWDf8gJX+74jC+QpvEO+2PG6zlsTbuuz/+k8Trh8KmlKh/hrZWly6tT1tVTnqHezNjRfdAAZaN3V4CSNBvT3aCAQKZLbeyS/HG4ItenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665603; c=relaxed/simple;
	bh=Wg4+zSQMu3RkNTv2UhuNCrCshNH2c94Dx1tLG41MdME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/h3uMDveWIww6WLvtabEjEC4zKr7ASfM8mHpKknvil9I1u335JnG7hzsrlyozvIrLWQfJmrWctr11H6yBKbwWugJ4TXfZ4QhsWk92GQmIT4mheyNX33jmKRxdFjKP5nH15ug525+CyHRokCRsL32dROMR87uoBeN14YQXO3oYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpGY6iGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23D5C4AF09;
	Mon, 14 Apr 2025 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665603;
	bh=Wg4+zSQMu3RkNTv2UhuNCrCshNH2c94Dx1tLG41MdME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UpGY6iGL6pLJXZ+Va2VIC/lzasUvH0lMJFdPY88g8qGBLHpBbzBhgvZl7Hac3+Mmf
	 CyR/5AiGQxp9mfIiS+CVaqE+UMyd0RmDpPl7V353Jhli8ATQc7/FZ20l43ey3xd3lo
	 T09DwXbBFko9gwJaY7QW+0pAkGtxI29mChiZc502eThi0tX0nBAWU1DFbXExRH0ReZ
	 R+u6WGtF151ADyB1siJMYGceIa3mKDKgJgiY7FvJAAqGONpP3nnEJul9NAY+zDBZl0
	 kIsjA0vnCFkvLouUq5kuYevHF18H/t7AuDHIFBko5GjqQ8JUIzDmQRohz/K5rpJiDL
	 dLsz8vJnWUMyg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 8/8] netlink: specs: rt-neigh: prefix struct nfmsg members with ndm
Date: Mon, 14 Apr 2025 14:18:51 -0700
Message-ID: <20250414211851.602096-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414211851.602096-1-kuba@kernel.org>
References: <20250414211851.602096-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attach ndm- to all members of struct nfmsg. We could possibly
use name-prefix just for C, but I don't think we have any precedent
for using name-prefix on structs, and other rtnetlink sub-specs
give full names for fixed header struct members.

Fixes: bc515ed06652 ("netlink: specs: Add a spec for neighbor tables in rtnetlink")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt_neigh.yaml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/rt_neigh.yaml b/Documentation/netlink/specs/rt_neigh.yaml
index a1e137a16abd..a843caa72259 100644
--- a/Documentation/netlink/specs/rt_neigh.yaml
+++ b/Documentation/netlink/specs/rt_neigh.yaml
@@ -13,25 +13,25 @@ protonum: 0
     type: struct
     members:
       -
-        name: family
+        name: ndm-family
         type: u8
       -
-        name: pad
+        name: ndm-pad
         type: pad
         len: 3
       -
-        name: ifindex
+        name: ndm-ifindex
         type: s32
       -
-        name: state
+        name: ndm-state
         type: u16
         enum: nud-state
       -
-        name: flags
+        name: ndm-flags
         type: u8
         enum: ntf-flags
       -
-        name: type
+        name: ndm-type
         type: u8
         enum: rtm-type
   -
-- 
2.49.0


