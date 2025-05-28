Return-Path: <netdev+bounces-193985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE1AC6BDA
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A5B4A3481
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5430528A3E2;
	Wed, 28 May 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YemqRJbL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B814288C26;
	Wed, 28 May 2025 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442895; cv=none; b=uxtTkaFtIv+Re/gcWcbn0V+pFim6hNR4orTJxW9W9uQOXLith8b9dy8N88tSf8Ju1UQcyrru8d23f5Uf7Dj8rWBbfrmgNigv0FEiBLrAyeAW43oPhA7mGUS7zHGgXCCZpJ7zBYlIhOrw00Ab1DT7LfzsvwuHmYNpAC2mHhP+i8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442895; c=relaxed/simple;
	bh=LxLVRB8GvDbWgwRUBMxy60vYqqNKxSuBn+6jZzlFCL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EG3kqNr2Y/Ihlsi0XqusrKZkv+dssaLgy8cK0Z50UBq8sjW+Fdo7pSeubi0JvMHNFgU1Odkms2TGK+oWF1ktj3X+gs5OrZsQFcDtj5gjBQ3AuEd/8hbk6NiofZPYNl3e0q4gegLAwjQ0RuutVbtkzLWSP+NHxHYTuAW3Uv3uTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YemqRJbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CA4C4CEF6;
	Wed, 28 May 2025 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748442894;
	bh=LxLVRB8GvDbWgwRUBMxy60vYqqNKxSuBn+6jZzlFCL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YemqRJbLG4RaBxL/301sTdPNenZhSt2Mog5tm1ymhn1tTsbRq7gjonaBcQQszsVsT
	 tTYFCKzifPMCZ8KXfhvxx9DK0N8DdBlx55Ta+lt6REedUjVpAGLhrXiDfNI6RupUTZ
	 3wJ5zeI2B0hkLWijamgn2wlrirEYCIUE5lR8/1C3dNMhzBqVKOGeajiVyBCheVH4ZW
	 UE/LT2SeB1+oK/NP2WjiI0P7QMW+43Rj+8sNaztmmRWLxjwsJUxeZpUx8YtgySP3Ml
	 kvo8pDSuYm4pOv15JAIJRLbWMVEYMSSKjZhG7g0rUZ6TOfQuJpr5TFLkJaGHxgC1QN
	 K4JODSwTiI8bQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 28 May 2025 10:34:35 -0400
Subject: [PATCH v11 03/10] ref_tracker: add a top level debugfs directory
 for ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-reftrack-dbgfs-v11-3-94ae0b165841@kernel.org>
References: <20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org>
In-Reply-To: <20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNx8EIvxwwvu2Rez69XJFIEm8ehsmoMNYZvgu+
 go5k0V3q4yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDcfBAAKCRAADmhBGVaC
 FaO+EADEIFnvTcw6Nwx3C27bRQvHJHCMfcvXKPs5gkHanmnl7cFOF7k/qJJuuY+z2gKwAtMadU2
 S4zlTlXXF7kwaphIWiJIPc6R8oeCjisEOd4/ge1e2j38lmPdBPcxggMXuIhQkO7nDG7tF9ZW/F2
 KRPZk4a5jrcUYYErdmn0YXeuoPCrw+1Uf6LMjtI/VeUIQx/eQAurDBLDdM+9ClNHtoLKsz/M3gK
 b1t8RtoyUyCqlkOMl8/rHLlcGvwKh8iN8BsJlYztPGBEe4kml4vcPczfWtWXP4x9IQ0mGKLpQh+
 E6WFCmgIyEzyk3TWxvL5coz6cDPRT3+Ap91KGDGlsPR4KrOAJlCEvxsbFUZvlJgZt2L3uUcZC6J
 SV0qXv07AiDo8vbBj4S94UjMGhsLo3xjbMxZANpyzAhPAEnHn5PlibrpdwkJ1cNfcSI0FeZrrCy
 raxU3SfLdUUDZv3GRx+epyQGKTLvzkIMP7RpOwbxg4xHR9U3X7R2K+QaPvvYvuu0ZbobfNLxvYi
 yCZ76fIojCtdL9CPftqGZfbzepFV+vskaaCelS4YahquYOhbhGdB2RWHko7hVlAtzcm4xMrUOkd
 IUmY4ea80AUChnPpl4slnHrSxBth+vqcuFHNbWzKW1Kip/i1aJD9aMrzVSt+zziA5KelceJSzD9
 qZCW6MtA4UVYq1w==
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


