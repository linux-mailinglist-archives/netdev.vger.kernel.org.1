Return-Path: <netdev+bounces-43499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A92B7D3A9C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85CA2814ED
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301131BDE7;
	Mon, 23 Oct 2023 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB0+8x7k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115951BDE4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 15:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDCBC433C9;
	Mon, 23 Oct 2023 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698074628;
	bh=qPMLaEqiz+BsehEip7IIuXB+D09DhBM8PlMHh50DJ3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dB0+8x7kcu9TZX72MA2dcHIntcDHAbvZgiTKZDOox/edH8UjfTnRIvVcRI7zMVLcQ
	 vBAOX8gwskeeBQTGzOpVQGMH1YqLOUQHJaGDGYVGL68ix1/k7RptXrBpACd7wojvBR
	 8S8QQKuV4kU/pQf9jMGWdh4zx1JdBMN7oynFnyaPGZEIryohEM9BuCIeaiCSQHSN3u
	 j4tPK2/T+HVH6xVcdFUlUJMNleAOtijbNhTUzq8tQlT2MiH5xK1Wz+XZQRmkuPK0jj
	 VCMpSDdQCpgPapUlzqaMXsU+du/gGe84Em00oOQ35+SMhNqyVN1ctS9Yv3NkcoZDRm
	 X2+WMBFZ+O8/g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next v2 2/6] net: make dev_alloc_name() call dev_prep_valid_name()
Date: Mon, 23 Oct 2023 08:23:42 -0700
Message-ID: <20231023152346.3639749-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023152346.3639749-1-kuba@kernel.org>
References: <20231023152346.3639749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__dev_alloc_name() handles both the sprintf and non-sprintf
target names. This complicates the code.

dev_prep_valid_name() already handles the non-sprintf case,
before calling __dev_alloc_name(), make the only other caller
also go thru dev_prep_valid_name(). This way we can drop
the non-sprintf handling in __dev_alloc_name() in one of
the next changes.

commit 55a5ec9b7710 ("Revert "net: core: dev_get_valid_name is now the same as dev_alloc_name_ns"") and
commit 029b6d140550 ("Revert "net: core: maybe return -EEXIST in __dev_alloc_name"")
tell us that we can't start returning -EEXIST from dev_alloc_name()
on name duplicates. Bite the bullet and pass the expected errno to
dev_prep_valid_name().

dev_prep_valid_name() must now propagate out the allocated id
for printf names.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 874c7daa81f5..004e9f26b160 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1137,19 +1137,18 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 	return -ENFILE;
 }
 
+/* Returns negative errno or allocated unit id (see __dev_alloc_name()) */
 static int dev_prep_valid_name(struct net *net, struct net_device *dev,
-			       const char *want_name, char *out_name)
+			       const char *want_name, char *out_name,
+			       int dup_errno)
 {
-	int ret;
-
 	if (!dev_valid_name(want_name))
 		return -EINVAL;
 
 	if (strchr(want_name, '%')) {
-		ret = __dev_alloc_name(net, want_name, out_name);
-		return ret < 0 ? ret : 0;
+		return __dev_alloc_name(net, want_name, out_name);
 	} else if (netdev_name_in_use(net, want_name)) {
-		return -EEXIST;
+		return -dup_errno;
 	} else if (out_name != want_name) {
 		strscpy(out_name, want_name, IFNAMSIZ);
 	}
@@ -1173,14 +1172,17 @@ static int dev_prep_valid_name(struct net *net, struct net_device *dev,
 
 int dev_alloc_name(struct net_device *dev, const char *name)
 {
-	return __dev_alloc_name(dev_net(dev), name, dev->name);
+	return dev_prep_valid_name(dev_net(dev), dev, name, dev->name, ENFILE);
 }
 EXPORT_SYMBOL(dev_alloc_name);
 
 static int dev_get_valid_name(struct net *net, struct net_device *dev,
 			      const char *name)
 {
-	return dev_prep_valid_name(net, dev, name, dev->name);
+	int ret;
+
+	ret = dev_prep_valid_name(net, dev, name, dev->name, EEXIST);
+	return ret < 0 ? ret : 0;
 }
 
 /**
@@ -11118,7 +11120,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 		/* We get here if we can't use the current device name */
 		if (!pat)
 			goto out;
-		err = dev_prep_valid_name(net, dev, pat, new_name);
+		err = dev_prep_valid_name(net, dev, pat, new_name, EEXIST);
 		if (err < 0)
 			goto out;
 	}
-- 
2.41.0


