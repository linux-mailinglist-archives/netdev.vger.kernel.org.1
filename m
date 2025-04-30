Return-Path: <netdev+bounces-187104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD66AA4FCA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2982189215F
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C1825A33A;
	Wed, 30 Apr 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAnlNUFJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B847259489;
	Wed, 30 Apr 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025624; cv=none; b=qMoTD7MbksVFkmjJxfZV06smo42HcOaiVV+30MSU6IPOC8Z6sFwjCKudMa+vX2VB4xzhdtjjXBQDJiHPebKbQgfG4FYDHtL4ILReNISlhO3b6B6XvKGQw/TGd+MZ0JMKGkXNt2NLhewl+9G0m+txjcCPRAWDp8bd2mCABhmYgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025624; c=relaxed/simple;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KRPsGMTQ0pbXph97cck2C0lzQrn3GPoazgwA5qBNBD/LBeKP2xerX/qRgbRwhfLZzOMPqI0Dpj/4VsvQ0ImggccmZnDDTf3effOgyNbVVJZgeHxznXTam3xLZEIhvysvrHtfLgVAp5pTZBMVpCbIAj3kQHTsgH9vxTchZMBIgao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAnlNUFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC1DC4CEED;
	Wed, 30 Apr 2025 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746025623;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hAnlNUFJndPQh2uqoHNAyXklxak3fPYowFrEv8KguTD7kOEZTqvsQbwCbsVC39suP
	 z3P+/u7vRuVeqB1rCzIWaeExYIOWR2dVPu7zOCU4Q52U7mi4f0EO++QeY/xrGLjeHC
	 4qRI8uswoGrUJsyaAdVYn5G0kYpzpQfAx6SW5S3bo4sOTF+5tQ3DXjg+g/JO2shO6E
	 3F3tYS+xfAV6YGoIi8W7eLTtcI86AgU5shW5GfXoETmn/e9YpiB5JyS8FBTUkyXZQM
	 Ov7qbae63qhPCaWsztB4SftgahdSHZS1n8WQN2EcNGpNZVX7daP8ci8DX7jXzxRSA7
	 wy1RFJPNFs7iA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Apr 2025 08:06:47 -0700
Subject: [PATCH v6 01/10] ref_tracker: don't use %pK in pr_ostream() output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250430-reftrack-dbgfs-v6-1-867c29aff03a@kernel.org>
References: <20250430-reftrack-dbgfs-v6-0-867c29aff03a@kernel.org>
In-Reply-To: <20250430-reftrack-dbgfs-v6-0-867c29aff03a@kernel.org>
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
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoEjySxG6cMlx8Pj7RBaQswqPAeiVGnzMELcZQ6
 nQmh3QPQFmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBI8kgAKCRAADmhBGVaC
 Ff6MEACZvwFZgDa8UEtM2MyAwP7PKxEgphAbGXuulQI40KhvIV8pqXqUieV/nVxRvDs5KcN23RT
 9sk80fL7PCbRJkaJgtbFfobqK6nuk4Z6PeI7CAui3dCFwQVzWw9RYPTt/Y6tYIhWIDjYCZUIS80
 ArSzfaiv1rx9XKk5tXj5VcNnPmOoHrauILQb5gV7hAFzUxbqlortdzPo13ErqoYbrQGXb24svop
 WZjSBvqU/MU6chuvrP2XXQf+3ZCMJI6KeK3MpzRIxYdwOcTjUo9sIrh0fg0wkiPl5W8wQ4wEphN
 NGwJ8RXH3CxXuCWY8jxAOOZHeYbg15wYncIc3KgDsRdmH0VfZzQHdfvFOuKl084Qma29XR7e5ai
 tYBa0epFkMNbM68aHvbumUpbtR9a3o0zVu0aOlTqRC/Bw7LwkbfZK9Jak8o1fd459dw6qoCCmBC
 KB3hetK5nLNu5bW12GV+Sas9ij1y/P7iYvGtwsDB4bA34PPMkOPbekMZ8aoZ9ZbtoxiW2PuUvvw
 M1xWIkJ/YV78IvBVFNF5bEZeUX2sqquOs6DxYuhJdUu1c1f6B9Tnm3vuVtkDuZ/jfOM+hFy0CDq
 5c2s/q7LlF5ob0mDrtPdHim8sqkiUw/1f8w66NShdH+AFheES+0XuXBmIUYjRmisUp/zEx+kp4G
 GeQQSlkCrhyIAcw==
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


