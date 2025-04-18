Return-Path: <netdev+bounces-184160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B51A93898
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6602E19E6819
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F71991CD;
	Fri, 18 Apr 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syoq3k9B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525B197A8A;
	Fri, 18 Apr 2025 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986278; cv=none; b=DFo+Z9KkoVhBOI1xUTZSVpBDLjajgWwSrVyXWPyOmSSxa1XUax2ksByXDLcTUS9wMJnrOKQJKdHZ7OCeSCdpORNlDEFEMZkfqcD6o2OsPBy6ksxoW2As4sElLjb7S4POwZXgmpTYSAjUcvR0AUk4KkCK13gnGHDS1q6Yz9GkbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986278; c=relaxed/simple;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O621Dh2Q3mn/tD3Uj11uqIkue4dKfX3dKtmbQbBY/KmjEAKMhTWcJ4jLerZ4uPJxYjsTfXMofSo2+tR0Tf8P1TrLp3cJnvM15E2AaUPH1l4L4LE6y4KE2JX3mmztCK9fag0B/X70R4WcYBV9s7UY59CXtxHhzloKW6inbvQX7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syoq3k9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DE1C4CEEA;
	Fri, 18 Apr 2025 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744986277;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=syoq3k9BRd0Q7Ee8tcLMgcmvp9g141bsE91iVixdyLURQ1fCOH9A1XIX5rS56LzW0
	 sAIXO/uN6O+nV/Qf1PIuLMO7bRk8+Ga8XxFqYtg/lxGTuVV2ZbdlTAOb7WhvBiMM7o
	 hXQ1nd7EttGTmpHK2tTF5whFbcyiyPawogIfaRxGoELrl/tMihDqnKjI1FQTZpSuNM
	 dya7BeDXh4Q/NPrVPPR0kK6FobXDewSDfvJa+DYnonA5RJYxrKjzjjYTry98zdS/Cc
	 JCj2QtsSErspRXmfoqXwbejooFRm1BAgrWGRqKKo8TomRgeYkELipwQj7VxiLsrTul
	 qhPE2vyXULqtQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 18 Apr 2025 10:24:25 -0400
Subject: [PATCH v4 1/7] ref_tracker: don't use %pK in pr_ostream() output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250418-reftrack-dbgfs-v4-1-5ca5c7899544@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
In-Reply-To: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAmChYeaymIo4L+Tjw97Yx7kPt1/Rf9d9QRU7o
 1vRDEKdfTCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAJgoQAKCRAADmhBGVaC
 FazqD/9y761uiGFWmUq0MlOwKlrsglEqDzSR9wq/IrEo17NXhe0jkmnOSu3lOqQys8uKQ1dpdkr
 uGABVDP9ZQr8m+xPDXDr4bMxtR3JZ0lKw69s+fBAODevCTsfjZHNFrkPeJsoVz1DfiaNOsi8fmc
 71Sy28KG/sfhs1vc2WMwWD6DwU0rXzsst65aginMNVNfhN4WBIlmgaPd3V5CexTdIPaxqKZmApT
 E1DCUIWRlf7TCyF1Kx2QoGd3gCraGUD8Mw/VGts1uQi+qWk0MsbQFmybOHrNnafDFvhotwwbGfZ
 e5692kwVw1EF02oJ0pE8bx6CLdts31VJ7vrAphyEBmAxCaUPYzaUlQBWf6+J51/rDQAQAxW2KYB
 VQoUJVC/MEAadu//0G/t1gZ2h3RqivYHuxY7yhAYe8hgYPfjwLyh6WAdy5imUKnBZ8OF6lyhynU
 jlvSZOkILMkgYnfJNNR9mKMhmQTD5TPEFge2ugYQ3KhieLqeLKRqnH1FYw+nrpd6ccoqdykNxWG
 r9X7j+9fm5BEfhLBvzdg0j0RiiBjNR/FkcsVPB227WcZrY4iIwf+XmGqTqjHdgpOgUugWu6r36Y
 v02sOSxc4nWSqbkhGntnw0x8v496IJ89RuS+KLktauzq+j7qOx1NxuDPvdaBrfvaCUj2SdQ1EBz
 QOtvUTBW3hFAUqw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Thomas Weißschuh points out [1], it is now preferable to use %p
instead of hashed pointers with printk(), since raw pointers should no
longer be leaked into the kernel log. Change the ref_tracker
infrastructure to use %p instead of %pK in its formats.

[1]: https://lore.kernel.org/netdev/20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de/

Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index cf5609b1ca79361763abe5a3a98484a3ee591ff2..de71439e12a3bab6456910986fa611dfbdd97980 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -96,7 +96,7 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 
 	stats = ref_tracker_get_stats(dir, display_limit);
 	if (IS_ERR(stats)) {
-		pr_ostream(s, "%s@%pK: couldn't get stats, error %pe\n",
+		pr_ostream(s, "%s@%p: couldn't get stats, error %pe\n",
 			   dir->name, dir, stats);
 		return;
 	}
@@ -107,13 +107,13 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 		stack = stats->stacks[i].stack_handle;
 		if (sbuf && !stack_depot_snprint(stack, sbuf, STACK_BUF_SIZE, 4))
 			sbuf[0] = 0;
-		pr_ostream(s, "%s@%pK has %d/%d users at\n%s\n", dir->name, dir,
+		pr_ostream(s, "%s@%p has %d/%d users at\n%s\n", dir->name, dir,
 			   stats->stacks[i].count, stats->total, sbuf);
 		skipped -= stats->stacks[i].count;
 	}
 
 	if (skipped)
-		pr_ostream(s, "%s@%pK skipped reports about %d/%d users.\n",
+		pr_ostream(s, "%s@%p skipped reports about %d/%d users.\n",
 			   dir->name, dir, skipped, stats->total);
 
 	kfree(sbuf);

-- 
2.49.0


