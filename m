Return-Path: <netdev+bounces-194792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AE9ACC884
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24821890C6E
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D5238C0B;
	Tue,  3 Jun 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc01L22q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC08132111
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958843; cv=none; b=jeujudzFxLarUNr1EYv010Lig+7oId+U3ay2pXd9PkeVWB6Rvp6m6hPtOsq7y/hURlMl8tVB5CvRdTqQrFTDQkfQEL+LPwmAjZYCZdMkQeyMBk6MY4cWqdX38vOQfl+YWCpF/ULvxAbr57DdQNIypOC4aCWxYJA3zlEHhWKLJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958843; c=relaxed/simple;
	bh=oGEjJrbt4wFhAeBb432vuTjndFwMq6uCxa5o+T4EMeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqjPW34Cy9I4I+1MXRBq7ElchKhoVkydZNpmeapl+9M61q4g7xSkYlGuWTs+7IUhdagGc+cqLy6GrlJO9SeYhhrlbhKYozSkB3yZvKCFliShtQctGmVy3MOhepxWLkGFBUX5ejwnRNUa3sKJ/cBPYBuI1t+vQQ93LQIrwS7P1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc01L22q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB02C4CEEF;
	Tue,  3 Jun 2025 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748958842;
	bh=oGEjJrbt4wFhAeBb432vuTjndFwMq6uCxa5o+T4EMeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tc01L22qeDyw2M7mDkhySi6rpKJbCjdtl++VpDUgh8cko0KY8JdkcD7dsQtikrHzu
	 mWz5MfqAAwo8wmtM5qcpgClvw8bIgGyesxSH1J3J4qg3MSpJgxfrAtHpwg2ymZTGR1
	 8gZhzolZ81D084dOxA0jHE5nixPwWIHhkynjQ6KxafnGu6D9uN85V1g0X63LlGqpF0
	 UfaCGyJ0iMjeQYYSFpLVnqjXswgWRVgdQto6bhZv7bk5/lFAB7Jd10OPCzXBx3CmNG
	 3oOlqBtbrc2h+5dNpaE8+Tv949mpyritXIResCHizkfwDeLON2gTXbxOkxpDKMtiRf
	 i/nF11XK1BC0A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/2] netlink: specs: rt-link: add missing byte-order properties
Date: Tue,  3 Jun 2025 06:53:56 -0700
Message-ID: <20250603135357.502626-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603135357.502626-1-kuba@kernel.org>
References: <20250603135357.502626-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of fields in the ip tunnels are lacking the big-endian
designation. I suspect this is not intentional, as decoding
the ports with the right endian seems objectively beneficial.

Fixes: 6ffdbb93a59c ("netlink: specs: rt_link: decode ip6tnl, vti and vti6 link attrs")
Fixes: 077b6022d24b ("doc/netlink/specs: Add sub-message type to rt_link family")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 5ec3d35b7a38..6521125162e6 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1685,15 +1685,19 @@ protonum: 0
       -
         name: iflags
         type: u16
+        byte-order: big-endian
       -
         name: oflags
         type: u16
+        byte-order: big-endian
       -
         name: ikey
         type: u32
+        byte-order: big-endian
       -
         name: okey
         type: u32
+        byte-order: big-endian
       -
         name: local
         type: binary
@@ -1717,6 +1721,7 @@ protonum: 0
       -
         name: flowinfo
         type: u32
+        byte-order: big-endian
       -
         name: flags
         type: u32
@@ -1729,9 +1734,11 @@ protonum: 0
       -
         name: encap-sport
         type: u16
+        byte-order: big-endian
       -
         name: encap-dport
         type: u16
+        byte-order: big-endian
       -
         name: collect-metadata
         type: flag
@@ -1764,9 +1771,11 @@ protonum: 0
       -
         name: ikey
         type: u32
+        byte-order: big-endian
       -
         name: okey
         type: u32
+        byte-order: big-endian
       -
         name: local
         type: binary
@@ -1816,6 +1825,7 @@ protonum: 0
       -
         name: port
         type: u16
+        byte-order: big-endian
       -
         name: collect-metadata
         type: flag
@@ -1835,6 +1845,7 @@ protonum: 0
       -
         name: label
         type: u32
+        byte-order: big-endian
       -
         name: ttl-inherit
         type: u8
@@ -1875,9 +1886,11 @@ protonum: 0
       -
         name: flowinfo
         type: u32
+        byte-order: big-endian
       -
         name: flags
         type: u16
+        byte-order: big-endian
       -
         name: proto
         type: u8
@@ -1907,9 +1920,11 @@ protonum: 0
       -
         name: encap-sport
         type: u16
+        byte-order: big-endian
       -
         name: encap-dport
         type: u16
+        byte-order: big-endian
       -
         name: collect-metadata
         type: flag
-- 
2.49.0


