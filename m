Return-Path: <netdev+bounces-194775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC54ACC569
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF51893D35
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ECE22DF9E;
	Tue,  3 Jun 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5QrsfOG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4B22DF85;
	Tue,  3 Jun 2025 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950048; cv=none; b=huGc6EnJd7Sx55qae5MLwQLHZk2NABeu9uK9wvSFe/zDgQgEQjhTXT5HSHMd9yucAzAtyn4PFZ+UUzzLyVXxJInRs0d2NgLMPnu8jkf82hCq/YCLsLQOYutgsityWR3rOtGM3gk3M+7UnjDTUERvIz7/FfCRM1ryVwKrdFwb/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950048; c=relaxed/simple;
	bh=kh/qFeLAyxVm0bBT3X1rDJqrmW5QgjHwPovsCE5exFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oul88L6hoRgBsfHG+A4PopdUQoiFk/Rul5KTzzk425Sy4bVC5l6K0c3CroIdIRCJ2Ap/KwDfnelqGTVCr5vTI+jkLMmyXziw4A0gwjhAz/R85PhFlbFZzQYHw6Zea272xHCC0ccitK0Eef10n7d6zuu6sPCE2u1gaC8WFfCt0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5QrsfOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DA0C4CEF2;
	Tue,  3 Jun 2025 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950047;
	bh=kh/qFeLAyxVm0bBT3X1rDJqrmW5QgjHwPovsCE5exFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c5QrsfOGQY+gEAwvbnNsbvn3UvRugqgK8a5A7iyVNZ46+pKJJafVSF1zWUTRQKfWm
	 ucfYMSzdhxQMy/dIuEl3LXcELGRNZvcUYdW4/ioT1VcpeYwXFVY7FKmRmw1dbuV1vs
	 /K7gaSjlVPGHYQADJOt5xDmhmrgANz4juJR3DWIg/eMMTnY/kt9NK8xw0leDfg1bf1
	 wCHHJGValI9zrfAHSaytAYnqoc9n4oeD7RXpUFuLejCFXK6fyB1ZE7bqeKPn9hp7WV
	 6SWZzgpFCfk6Nu5UKjMg6IFCUj8V2QGnubK9MRJPkTZlyhfYQoTGPjyEFizNu7SQok
	 FhLoXRkvsrrgg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 03 Jun 2025 07:27:12 -0400
Subject: [PATCH v13 1/9] ref_tracker: don't use %pK in pr_ostream() output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250603-reftrack-dbgfs-v13-1-7b2a425019d8@kernel.org>
References: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
In-Reply-To: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
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
Cc: Krzysztof Karas <krzysztof.karas@intel.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kh/qFeLAyxVm0bBT3X1rDJqrmW5QgjHwPovsCE5exFQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPtwZnmkzfGyqcDCu4qlCbcxajRFYjJSU/wuXi
 5lU4c+zT/SJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD7cGQAKCRAADmhBGVaC
 FStMEACYnCVo1JiKF1YdkJU5oZPfFXF4BX7UH51WUluPdvHF+un4833ejyLd3JUpMs8Nse3Z5Ll
 IOCON2LDTSV3vaRtqaxq9NF/uJerI9c9z++/F6YNUyPyPIZ+Pxrab79rPJIZT6Sfy4LRyD1GENm
 NO8eGXBdjxTsN4LxDoZYCj4MEpUVsRgyE7CVKYWc57Nefks/1d4xlDHR3Rw6RpPXnBEInjxnMgo
 RF/TG5iRYuCjSGieCqxBFFuWuOhCkOpdXBNKXf3KNuMidEkwe8JH9+gV2cWGKi4SzeM2BILOy1V
 w6YAM2eghUIcTyVssg1LauEUjWOal5gFrjmmJX1IspeHvPq/o9eJouljSeivVLOA+Bo3HLx3xef
 hexuO8L9xuObnTa4gQ0BL0PQDA9XvGqiHMg78gAYhwwdTDcTozlnOHCOvHCFxOYjUfcqP7MZVoV
 M5aSWNh5upcyYV02IW9o+LxdBPOP1tyypL90msJSadSUJqH1ab2a7XQyDKK5zS/lk/CO+9k4anq
 f6kvnesAxB1zU2kC+Zx36RfTw6NS1WgfrW+9Oixe4rRl0WhGeB+loJuStOZX/T/uj6n2s712k+X
 cyzff1pzXhtQRlcfvHyJ4f58RbBCRuaXrIDqoX7F+XhV841Yn3Va6eClJB8DvgkpNGHgN7wThnN
 ryZ52HNaaiXos9Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Thomas Weißschuh points out [1], it is now preferable to use %p
instead of hashed pointers with printk(), since raw pointers should no
longer be leaked into the kernel log. Change the ref_tracker
infrastructure to use %p instead of %pK in its formats.

[1]: https://lore.kernel.org/netdev/20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de/

Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
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


