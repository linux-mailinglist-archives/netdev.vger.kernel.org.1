Return-Path: <netdev+bounces-184048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64626A92FD8
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D63A068C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46E9267F6A;
	Fri, 18 Apr 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsVlLS4i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82843267F65
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942640; cv=none; b=oJN63HXLATh4edIGysASLPP+ewhRj0N5nKaiL5AALLHaJDd67vZfu2F4GKyK5kuL0t21mccNiQ9A0uvc/ntkbq44TEP4774frTU+zGgRcfJyo+nX7v/nPiK2Ol4lluMURamjGzpphsAx4M0uRJnHOuh3EVgDj5cCG1cTTPtIG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942640; c=relaxed/simple;
	bh=RDUh6uCCiTzArfUadb/u56Uacyn0KBCCBnvHHipE6hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJ18qaPioza0HbP2dl00114bBZJr6jiFG7+1E1I6Vt6r5bzVyHCaefOByZyYUNZdivVWGPgVi9S8r9ciSFm/qbWruUYSR3aydu15WAV/M/1bFVEJUijH0/rOqXTxsvMmwoP2BttEDFeezk4XTitI44PUQaVNmh4uHU48Zyi3JCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsVlLS4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC54C4CEF0;
	Fri, 18 Apr 2025 02:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942640;
	bh=RDUh6uCCiTzArfUadb/u56Uacyn0KBCCBnvHHipE6hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsVlLS4iRcZYyWIoeDltx2tlG0EYlDiuADEjERO2/8JydsUy0CODle7MJlmKKHMcv
	 EiQ3UBqBKwj9YGQR2V97gTYT9aToBmFJO0//FDhaEINflHUlQelJ3AtB9qgDk+dzzU
	 KAW9gGmRKlTASEoP4C6vQZKqjKChNpyvEr1JBwYfKLobekhRD7n6c1VLcNAZy+qgRw
	 q2bWP/Q7eV3p1ElHYniMxiLeSrxwvPK6K8EMHPayE7EozZm3Gp3g6Mjf+GyBwyaz8A
	 cZygb49HjrkB+PeyaosRuJgCiO44p1D4u3i0+e35vNnwpiZPPmRA/kIydnRANwUham
	 yfAqnNJ+H78dQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/12] netlink: specs: rt-link: make bond's ipv6 address attribute fixed size
Date: Thu, 17 Apr 2025 19:17:01 -0700
Message-ID: <20250418021706.1967583-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418021706.1967583-1-kuba@kernel.org>
References: <20250418021706.1967583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ns-ip6-target is an indexed-array. Codegen for variable size binary
array would be a bit tedious, tell C that we know the size of these
attributes, since they are IPv6 addrs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 6ab9b876a464..4b51c5b60d95 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1447,6 +1447,8 @@ protonum: 0
         type: indexed-array
         sub-type: binary
         display-hint: ipv6
+        checks:
+          exact-len: 16
       -
         name: coupled-control
         type: u8
-- 
2.49.0


