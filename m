Return-Path: <netdev+bounces-189321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F13AB197C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3B4542CA5
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866823504F;
	Fri,  9 May 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g88zdz3q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0B238C2F;
	Fri,  9 May 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806072; cv=none; b=MMQXB+Ux32unRmGdM9PzMRkhwpOaJsl/aBbNOJ+r+6+EMSIIiFbUL3Rk88Es9pa1BRDyGs8psDmwlL2vVJxbeXYIjq5tl2vAVudO8KNXpj67EV+aPbHUmFw7xeHqFLl6kXG9TnapjjIrCI3VazLwmcxoIMuNG9SFt5SEn/WvGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806072; c=relaxed/simple;
	bh=LxLVRB8GvDbWgwRUBMxy60vYqqNKxSuBn+6jZzlFCL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rC15hrJfPI5X2DpkTKnmrQslMmhirKSCid64vgbfToPeFCWIPB1+nRQPwDwy8artvK4My9svDzFR2ht9vdKUISEiCACHYo2bhT4jozrH/WRpXgZClB0EE2JNMJnlhv+FrfLX33b3LfHp9dTURAMr2fji8m9L2+U+xft8wbLcuKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g88zdz3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1C5C4CEE4;
	Fri,  9 May 2025 15:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806070;
	bh=LxLVRB8GvDbWgwRUBMxy60vYqqNKxSuBn+6jZzlFCL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g88zdz3qfycUSPF8fcFoQsSFCGQrrZNGmffLzaoSaxHrtIuPahPUiW1lE9FeaFlC9
	 PVbycfySMPUtdOdkQHHzA0BdKodnvQWV2gKOI+oPpqo6BIBxg6H/knk+R45K3vsFft
	 yWf+7zUM8Y/QC8XMm33emK326dyqiqrnRIDumZDyeihtQZQq8tbziDXCDL3m0nwo4m
	 9ELl4zi08myvz4q04N4dhfwy9JGVoWO+MzXnnn5vgf1GnbicJ5JT8SoGOfs7KrzMoU
	 V7oYPZsZo0dCUnr/K3U4HnLgUG5kbX0FSDWtfeF6d5xnxzLoEcWNBxbWsb1k/vkswn
	 ZgcpWcngdGGbQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 09 May 2025 11:53:38 -0400
Subject: [PATCH v9 02/10] ref_tracker: add a top level debugfs directory
 for ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-reftrack-dbgfs-v9-2-8ab888a4524d@kernel.org>
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
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LxLVRB8GvDbWgwRUBMxy60vYqqNKxSuBn+6jZzlFCL8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoHiUuSHanXz7A1Ilm2bM/zNryrFCG5d5XssAi5
 bTRecqbRRGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaB4lLgAKCRAADmhBGVaC
 FWSNEADGUHGBJlbP+lSQMWSbujQFrxCQUQlG/XOq6ZeOfhBtZyD0pvT2smyjryOOhnPVbxk/kx6
 9CYmpuVNYBYkEREU1ucURtaS6i/VVwY3TnSxh2g0wdjmaaw3XXOJV1sI/lrveWg//k84fzB/pEt
 63mG9CqIrsPepCLTBHZA65Q3syMILqHYF0871uDGvv8ik8lsvAEgICprbeIWJ6GypVpjnIav5Gt
 VGPC3pn0MUAedmjFchHgoBqurqub4JMeo5VxH2JNu+0KZDbqAXS+0qmQlhM0j+uejoc/Hweneo0
 +bd3ejsBxmxSAxu1kjDyxZ92cA5n0N8eBr4XSv6VLVJMVgn166y8+XUbC+WJCp+gbJUGocRFP8R
 bZ+s2ic/BRSUCmSaCG0+y3thioU7MmmBXXoS3BDDLwIAgMUoWemTVmnCbhd+QpvpW/lZS3Tpw9W
 0IkDQbCY8wNjCUaESq/C5GfIVH+KYFeNmiCVPCkICJ58IgoXrBUv5qoh4ICYcf890JXr126q+Fc
 4+bJgyFXWY8Dv87xTZPTmCuC3lQ1mss8LQ54n9Pn1PgVVorVInEFkzvWhXbjH59sHeI3JO/Ogne
 e1hvr52FMKTmrrf2F/fmednW1aaoUhOSYDiSulw+wr/i57UXm04UWjbOZfKv6sKqy/1AaLQcupP
 FClonXePgeB5TfA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new "ref_tracker" directory in debugfs. Each individual refcount
tracker can register files under there to display info about
currently-held references.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index de71439e12a3bab6456910986fa611dfbdd97980..34ac37db209077d6771d5f4367e53d19ba3169c6 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -273,3 +273,19 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ref_tracker_free);
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static struct dentry *ref_tracker_debug_dir = (struct dentry *)-ENOENT;
+
+static int __init ref_tracker_debugfs_init(void)
+{
+	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);
+	if (IS_ERR(ref_tracker_debug_dir))
+		pr_warn("ref_tracker: unable to create debugfs ref_tracker directory: %pe\n",
+			ref_tracker_debug_dir);
+	return 0;
+}
+late_initcall(ref_tracker_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */

-- 
2.49.0


