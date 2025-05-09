Return-Path: <netdev+bounces-189320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8DCAB1978
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8F54C5BB3
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE94C2376EC;
	Fri,  9 May 2025 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9cTpevM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426E23504F;
	Fri,  9 May 2025 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806068; cv=none; b=qjKo79CfvnOYxIU/uUcNxvASIEVfqYxErE8ziY3UbtREGKkOQp7MGVVOIa8bdAeltjkrT1tW+sxFALbe++j5YU0ybN+o5+Gql/4PZEFZIWmNoX/bjBe3r+LpM6o7g4jEmwm4cwntArH8bpzAAWZ9VFxJjJiCSZthyZpBS2LGhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806068; c=relaxed/simple;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVQTvklB/pOsZ9c5HvpZSLvdfTgv2TW+cEI/YuCTBEOX2jbPmMjZVBir8v8Dzpo3LhDC0HXp0itvENDNj8jr+Pu0GyF8NPZSpPXGo9xsnYoZ/ekGcPO1QTqvQ5QgBUR7kMoCj/kizrFe7umxDyOeJ979s33co6Jsm+IAPik0cqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9cTpevM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CA0C4CEF0;
	Fri,  9 May 2025 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806068;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J9cTpevMeE9DUwzeDhXL+BZPqj3KtV31YnVmEDsUK+1xpWfE/fYrAVPrcNW5iYXKe
	 Q9xy/GHJAe6UGpdJYqsygcA+Rx4G68+hzdhPgx3+2UfYdFcTaBQuXR4FQqZqABQL+M
	 gwEzt7LWUMW2WisEKveO1S6SSP/GOP0eDvdqVZfp+S4z1nPUwktPTOPSJAvqtp6u7L
	 gfUzpIy5H+mO8SQ4Ge1MiSjgdZDPGHv0vWCUVlZXQcD310VTEE+Dp5SnHRlZxvYt8h
	 W/3IidLvZSVOnf9oge3o2Kex1UZydrhMot7E3N9/K5hHbocRKsspHU5k4tC2pXlBKq
	 rk+1IVInwsS+w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 09 May 2025 11:53:37 -0400
Subject: [PATCH v9 01/10] ref_tracker: don't use %pK in pr_ostream() output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250509-reftrack-dbgfs-v9-1-8ab888a4524d@kernel.org>
References: <20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org>
In-Reply-To: <20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoHiUukOOKDIb4cF2s/YqNQegK/kh7hBPmE4loG
 newhUZ+3/yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaB4lLgAKCRAADmhBGVaC
 FX6ZEACPHYtl2ZkiY8k+RhHi4brer18Cm8cAOOgH/A+9UgPc8+IhZJFoG5kJKEFVTCyt8FpADtB
 +MGHt6m3HNeRsfPjMrHDfMpQ0w6j5tYsww5+7UEEErTRGPX0YAp62OHq5S0ZBokBrluc2VdxuHK
 awNvFgZF/fkuNF7VJec3NYTDXac3pSSqsz5IABuQ4HpGgZwENhzBzr166eOOlXFflEmc98N7Pyl
 YDiOjyA6oardTTOaWIgAD3jBcu3GnfcInCD2paXLI12KC9sRwLq6FT31a2PO+GcK5+liwuSgGaw
 MEKiNpEkTyy7eMfcMAbbLopp0qNZZlJPikul9xSkZ4/qxPiRFEag2qdFa134f52fr2w7dDyeCCx
 tx/9LNh58nEZn8677oXlFaw7ShI0uGCXEBD4ZNmko0vuYhbCL+WnGOpbev/FtU9gY8wpLGnaLBL
 bHanoDMqvaZ5curuuFXsz9GkU/W0Ns8fAc81w0a2IuB2e0IzECIyzygdv0bDNQpbVqWJmcwddSO
 7cGUl90IGikoohBQ95hwfN/+eCfvJXGV13b8JQSZTZ5bmJjOiBLpzh8qscEYLH+7+yM9aOAWeOc
 nz1fBiOHzWMWILY2K8S0g1Fjpi/M0ip+3wkUMqAyTfkzXt/eDG7Nz1fqili1vqlUVFqps5rnl+y
 yQ4SaCgy2PH1GjQ==
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


