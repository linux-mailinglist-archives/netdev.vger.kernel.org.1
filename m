Return-Path: <netdev+bounces-130962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0176098C3DC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F4A1C23525
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4D1C5782;
	Tue,  1 Oct 2024 16:48:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486227448
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801317; cv=none; b=SLK28K5rSo0Rf0QlXGzC6KMvW6Io6x4DH3AZrM+/xjwLG7u3IE1kJtsUXx5akK9kGy1KzwBuE1yhEu6C0r2l8nv/9FqdsrV+9AWQoQOrS70epcjNwyQ/a4KQs7bz4/uI+GIQGZE8EKKRxcs+7ISTe+IDHgp2p2cTopcuG/micfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801317; c=relaxed/simple;
	bh=xZhQBqI4jMIP1JfUHmCSDdWzXthuAjzCu2z6GPzs87Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1uEEkcb1SwNxw0Vmy8rMD/TeoFQ7MtWTi4DcQbTndm4sCf1p9yaZ7UySvJfFlf/SkvSsE0/baDmaeXEnO6F1Ei6u4geFsfDF82SXDc7bS2BdMA8laBhS5kqufV4lGjYCtCipRjXBVt1S6IV4jeKCFcTviCrydUm/j1MNMfXA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BEE020003;
	Tue,  1 Oct 2024 16:48:28 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	syzbot+cc39f136925517aed571@syzkaller.appspotmail.com
Subject: [PATCH ipsec] xfrm: validate new SA's prefixlen using SA family when sel.family is unset
Date: Tue,  1 Oct 2024 18:48:14 +0200
Message-ID: <c8e8f0326a3993792a65125fa200965e8a4580e4.1727795385.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: ********************
X-GND-Spam-Score: 300
X-GND-Status: SPAM
X-GND-Sasl: sd@queasysnail.net

This expands the validation introduced in commit 07bf7908950a ("xfrm:
Validate address prefix lengths in the xfrm selector.")

syzbot created an SA with
    usersa.sel.family = AF_UNSPEC
    usersa.sel.prefixlen_s = 128
    usersa.family = AF_INET

Because of the AF_UNSPEC selector, verify_newsa_info doesn't put
limits on prefixlen_{s,d}. But then copy_from_user_state sets
x->sel.family to usersa.family (AF_INET). Do the same conversion in
verify_newsa_info before validating prefixlen_{s,d}, since that's how
prefixlen is going to be used later on.

Reported-by: syzbot+cc39f136925517aed571@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_user.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 55f039ec3d59..8d06a37adbd9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -201,6 +201,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 {
 	int err;
 	u8 sa_dir = attrs[XFRMA_SA_DIR] ? nla_get_u8(attrs[XFRMA_SA_DIR]) : 0;
+	u16 family = p->sel.family;
 
 	err = -EINVAL;
 	switch (p->family) {
@@ -221,7 +222,10 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		goto out;
 	}
 
-	switch (p->sel.family) {
+	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
+		family = p->family;
+
+	switch (family) {
 	case AF_UNSPEC:
 		break;
 
-- 
2.45.2


