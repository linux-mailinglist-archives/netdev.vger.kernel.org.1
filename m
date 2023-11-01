Return-Path: <netdev+bounces-45573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598CE7DE674
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1804A1C20CFC
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 19:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D519BB9;
	Wed,  1 Nov 2023 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RgKkttjK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66911C9B
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 19:41:53 +0000 (UTC)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC4FBD;
	Wed,  1 Nov 2023 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1698867702;
	bh=6kOOEsQgA20o02ni+Bbcpima7j16ISpDSfIVR3lmAHo=;
	h=From:Date:Subject:To:Cc:From;
	b=RgKkttjK6JHbUkNCJEGKwSUQBo2D1LVV/CtJA/BRdiAsNkuvWgT6mc1CrYE1EBw+T
	 JDfPyoDOK7LpDXTsVsBEHmLc55HZpiHWgHv1Hg09HxHobbPMFTnwWzpJyyRkzOmBCq
	 H7uX0orZAkqBQSWVtQ1Rlo5aSIiV+UnbFeXwktDs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 01 Nov 2023 20:41:38 +0100
Subject: [PATCH] rfkill: return ENOTTY on invalid ioctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231101-rfkill-ioctl-enosys-v1-1-5bf374fabffe@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPGpQmUC/x3MwQqDMAyA4VeRnBdIqqe9iuzQ1tQFSzuaMSbiu
 1s8fof/P8CkqRg8hwOa/NS0lg5+DBDfvqyCunSDIzcyE2NLm+aMWuM3o5RquyGRdyGQn3xg6OW
 nSdL/fZ1f53kBxrK472UAAAA=
To: Johannes Berg <johannes@sipsolutions.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698867702; l=1027;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6kOOEsQgA20o02ni+Bbcpima7j16ISpDSfIVR3lmAHo=;
 b=PCouzUkWjCX8b4EyQv4Oh3mGh+icPABvcaSCwi8ZKWWfm0MN7wtPhGOZZZJDZDHZZRhHXGuo9
 tX5Sr1txgKVDl411lumTlUJq0mY1eBz57bA4bczvxT3dg+jVfF8vYW3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

For unknown ioctls the correct error is
ENOTTY "Inappropriate ioctl for device".

ENOSYS as returned before should only be used to indicate that a syscall
is not available at all.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/rfkill/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 14cc8fe8584b..c3feb4f49d09 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1351,11 +1351,11 @@ static long rfkill_fop_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct rfkill_data *data = file->private_data;
-	int ret = -ENOSYS;
+	int ret = -ENOTTY;
 	u32 size;
 
 	if (_IOC_TYPE(cmd) != RFKILL_IOC_MAGIC)
-		return -ENOSYS;
+		return -ENOTTY;
 
 	mutex_lock(&data->mtx);
 	switch (_IOC_NR(cmd)) {

---
base-commit: 7d461b291e65938f15f56fe58da2303b07578a76
change-id: 20231101-rfkill-ioctl-enosys-00a2bb0a4ab1

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


