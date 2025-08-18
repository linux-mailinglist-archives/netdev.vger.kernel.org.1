Return-Path: <netdev+bounces-214500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42250B29E9A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FA21896215
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD8930FF1A;
	Mon, 18 Aug 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb29xwR4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFBF30F55A
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511119; cv=none; b=O8a3Bw4eDu3JWUafQa/52nAzKzfeThTY596Ilmfv/UY1zodChz7Q387H4z0QDQxvtBqmOYv0uiOeKPqQPpdeArp8jGsrPHCF07tn+S4n/5/RIsyyzRUU7iuDw4+Ch4zVP3EdbprndCyqFMB1YrVg8Bdneu/h3zRTAY+n17meh7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511119; c=relaxed/simple;
	bh=IVmYnonridwoQ6jxBvPZC4yerBdgroDgBZFPopy1r4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nMupzkZ/ZZhGKNt5+lAI17XtDkbHbPdpWEXiHRyuUHod76bEd73smuQrw6BgbZNrr+GzBQ4tAU4NBgVyLXIEvTyKCPofisAoCfEw9O/nw4gxm90G8YxqX2hzIrneIvtIlC5anpNrOa6itwattbsf+QLYXgUa0dxZNswBpMmu+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb29xwR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446B2C4CEEB;
	Mon, 18 Aug 2025 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755511119;
	bh=IVmYnonridwoQ6jxBvPZC4yerBdgroDgBZFPopy1r4g=;
	h=From:Date:Subject:To:Cc:From;
	b=Nb29xwR4T10F6R7bKovgIT+ZChFem4oFqrrSeKarqu8BltJfcqsKclZEQmv7Hih1X
	 JWpstzx1AnSCQ1wur/mxxVwjheTkLnXd+DDywd4XnNzbUPqAemGb+/PQKe9Ez3SuwQ
	 +2fsH2idrkM2Ssw9zcAS7ft6fl5x4P+UiXcgbM2xBXH1kkRkWJEPFKyn4T6cDczVvL
	 mOP5pnQ4m2HBG4jtSv/15lT4lT07wjOT7LcHQIpGQANBwaEsyY5fOMU4o/jp00TMut
	 7Bkn07TCGqvEKxhLHASHCWBDre+/ev2Dpcm3weav2nLhXG5WMusdSBTvhilIyqxqaf
	 aYYMv4h5bKBjw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 18 Aug 2025 11:58:25 +0200
Subject: [PATCH net] net: airoha: ppe: Do not invalid PPE entries in case
 of SW hash collision
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-airoha-en7581-hash-collision-fix-v1-1-d190c4b53d1c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAED5omgC/x2NUQqAIBAFrxL73YJKpnSV6MNqzQXRUIggunvS5
 zyYNw9UKkwVpu6BQhdXzqmB7DvYgksHIe+NQQmlhZUWHZccHFIy2koMrgbccoy/iJ5v9F4N62j
 MLoyCdnMWavOfmJf3/QAi4fK4cgAAAA==
X-Change-ID: 20250818-airoha-en7581-hash-collision-fix-ff24b677d072
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Kubiak <michal.kubiak@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

SW hash computed by airoha_ppe_foe_get_entry_hash routine (used for
foe_flow hlist) can theoretically produce collisions between two
different HW PPE entries.
In airoha_ppe_foe_insert_entry() if the collision occurs we will mark
the second PPE entry in the list as stale (setting the hw hash to 0xffff).
Stale entries are no more updated in airoha_ppe_foe_flow_entry_update
routine and so they are removed by Netfilter.
Fix the problem not marking the second entry as stale in
airoha_ppe_foe_insert_entry routine if we have already inserted the
brand new entry in the PPE table and let Netfilter remove real stale
entries according to their timestamp.
Please note this is just a theoretical issue spotted reviewing the code
and not faced running the system.

Fixes: cd53f622611f9 ("net: airoha: Add L2 hw acceleration support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 47411d2cbd2803c0a448243fb3e92b32d9179bd8..88694b08afa1ce232b34c64f605a151aed137b6d 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -736,10 +736,8 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
 			continue;
 		}
 
-		if (commit_done || !airoha_ppe_foe_compare_entry(e, hwe)) {
-			e->hash = 0xffff;
+		if (!airoha_ppe_foe_compare_entry(e, hwe))
 			continue;
-		}
 
 		airoha_ppe_foe_commit_entry(ppe, &e->data, hash);
 		commit_done = true;

---
base-commit: 715c7a36d59f54162a26fac1d1ed8dc087a24cf1
change-id: 20250818-airoha-en7581-hash-collision-fix-ff24b677d072

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


