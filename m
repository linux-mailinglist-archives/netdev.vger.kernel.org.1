Return-Path: <netdev+bounces-199104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B49ADEF3F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723074067AC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1772EBDE4;
	Wed, 18 Jun 2025 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeYHhd8K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50452EBBAF;
	Wed, 18 Jun 2025 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256671; cv=none; b=KASgIdFirOag0eC0K08oEdftWbDCD8Bc39oblAPI3jPItkjLyac6IeKqttlO4ffY5OWdc9dBC2nJAeO7mlJVkd7xFaxTh5CsiEhF7mkCNuHN22ywWfQtjWyIdAQIK7EdqDoiSNfBj+x+Az9tl4YuYAuRJhlWo60kiG4eQXDuEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256671; c=relaxed/simple;
	bh=kh/qFeLAyxVm0bBT3X1rDJqrmW5QgjHwPovsCE5exFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikLzffhGRxYhw2t4mWuphQYzv/n/mTNZxFIXYg4VmAFoMvcLzjUgGp7HZ4qRvYeNgy2d7XHDnjBdvT9ggXZc3545t0+/peEefvvS2I8bgHqKShHJVu83PFoBVYL1SpSZmTO4KswPutNmGqlzFFulVIdOz7QE4S9pUz0641u6W+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeYHhd8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2C1C4CEEE;
	Wed, 18 Jun 2025 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750256670;
	bh=kh/qFeLAyxVm0bBT3X1rDJqrmW5QgjHwPovsCE5exFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SeYHhd8K/hFco9+lYRcTpt66O9BjObgzowNlvoj3KmtmFvujg3XruhKOmfVPihmgP
	 jctolrK2B14PRoyYqqfOhNIblA7iCyKNSzHY1CmtNsb3sXfYw14FUw4GVitkmwulgx
	 YX0h0DWAL9t1t3JRxc6Any2guq1okolisdG+4dKJZpy1Flm1culXK6LhdHpkw7yvpR
	 K5oS9NV9IFg2vs5vrtrk3itWYyDkiWDrdcFT9Tw1HuniGjcA6l2xLn/Fq4QLqazlYL
	 IQ+W5WcUfdxhSJUodTAqDrlKfSeSd3G7QMjgBp+WB2WEy0ywARW84jXOz8q/gAJ9BL
	 15M2uUOycS9xw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Jun 2025 10:24:14 -0400
Subject: [PATCH v15 1/9] ref_tracker: don't use %pK in pr_ostream() output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250618-reftrack-dbgfs-v15-1-24fc37ead144@kernel.org>
References: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
In-Reply-To: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoUswYN2rs6NDHd9438ugrW4Z7qYomJgPSuFUi1
 3zE//5ATvWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFLMGAAKCRAADmhBGVaC
 Fd4+D/9d5Vtsrf3RTCVGKQEKvSsjosEMkf3NkCqT/wXPr5ws2ZGBx5dj1E5YIDRWLc72sVxMJz7
 NmCCZusRTkT3ZmqUsEvNZ5asQPAku5xsTY5cAzpfof5upiz04SiCoFs8Xms9RNBMbHJXCE3vivy
 3IeDmLIcgLTXbzF+fQ2eF4iIz+wWd7NfOIHjpEgnpFDUm3u0a6C1Uh3PpjRbYf75hWn4joCerzV
 7SfhZbYL4fz9BMjy5RNxeqdb62f5nkCRQv8myG2FtO2DtARwby4LXVfV6bLPztE2PR6bfPPOBO7
 cyGwtI1plMKnulaKyPkg5bdXIkMZ+tQ3dfT4bnTDq+z4D6cFwbFjeRbGOKDe3EktgpiLjnA3Rso
 Pzn8wtGCBUXBbTN/yRvGOyZ1/e+QZ241mzBjCRuwIjcqyyywRB1pB/roczuEMSO4EwOQ1fa/alK
 NawKSJrqZqJgTH7ReYZYCyv24Z/ijM56/PX5hxlpEuxSFSW0j1wWwWUAfzK+pWAgHmYRdwCC0c1
 Qnc5IoFPIK4GHGXd2X/7b8Q3TfYS3UXUmWroKwHgAmsmrUSAUNLOXhJLU2YRz8hQwmq1imlHWnL
 SaAgskaZdW+dsvfA9lqzHfZNnoeVWxmNS+d4obEabATkKvu2rKY3QNXY+WnebI9o1N7vMLwaGY8
 v6YzS+9/u1VRHrQ==
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


