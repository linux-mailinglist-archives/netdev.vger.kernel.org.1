Return-Path: <netdev+bounces-74670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE78622AC
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 06:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AEC1C214B9
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 05:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E0314006;
	Sat, 24 Feb 2024 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8pwQJUv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8B4414
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708751220; cv=none; b=NbfZpnbRwVdCMiJabFUDFKI1wZxeWVSSqTBqtzo5RxnS2QF+no6eYKV+JsdsdobfuUZhZLIAyA7i7GEqirkdIrkRuEnt7E4s8pyXYBp1YLk8rkizVV5IaI8JC89L5ihgJRF/i39ZRGlyD3bsgau8QS1RaJk1bEWw3N+T5TSJQN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708751220; c=relaxed/simple;
	bh=Kki5Wah/npQpqATGLsHIYmIItPoUSAlS79uEPwm5OAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFb4xWzy6oojCyvEBGN7C8EquStO53JhaAnahDHrOql7Wow02rzstTmF54N4J/u3TDAy3J0FN9tDiRazUnlfcFjB8t6cU8AUo4Y1yvMefbHPbOydQ/YXUJusMniZ9Q0BItaUcsNQiN43ddmYU3Iin3jEhWoyrALfXhApr66pNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8pwQJUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7170C433C7;
	Sat, 24 Feb 2024 05:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708751220;
	bh=Kki5Wah/npQpqATGLsHIYmIItPoUSAlS79uEPwm5OAM=;
	h=From:To:Cc:Subject:Date:From;
	b=O8pwQJUvZl5q7hbwu9EcEzTmLGj/Mj5LnoJZDbALsbziKDcSv3tWSPDeJIe8wucA8
	 VMZUXsVc6zXhZT8SQoydVGQXjLDq1pQUeO0vGiqN4fYOXyZtCzhSjjbNqjpaYZ0OE1
	 b/T30JzaRs53j3WLZxO43h39Gf0uOwLvvFSEkD03sswAo1Oayd1a8fo9x+KkYH5oqg
	 a39whnFZ2u42tjsto4wzjUZHt+CvMMMuE56wCLSK95nrvhECGEdKEiw/JrvC/WuMsP
	 x5Hn09QWUs0Nbbd3tlJPig8sT2bgxJ80zYXRJSYXt50krDudF9JI833RIFMKip8mJK
	 es0RqqvZ8cDWA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] selftests: netdevsim: be less selective for FW for the devlink test
Date: Fri, 23 Feb 2024 21:06:58 -0800
Message-ID: <20240224050658.930272-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6151ff9c7521 ("selftests: netdevsim: use suitable existing dummy
file for flash test") introduced a nice trick to the devlink flashing
test. Instead of user having to create a file under /lib/firmware
we just pick the first one that already exists.

Sadly, in AWS Linux there are no files directly under /lib/firmware,
only in subdirectories. Don't limit the search to -maxdepth 1.
We can use the %P print format to get the correct path for files
inside subdirectories:

$ find /lib/firmware -type f -printf '%P\n' | head -1
intel-ucode/06-1a-05

The full path is /lib/firmware/intel-ucode/06-1a-05

This works in GNU find, busybox doesn't have printf at all,
so we're not making it worse.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/netdevsim/devlink.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 46e20b13473c..b5ea2526f23c 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -31,7 +31,7 @@ devlink_wait()
 
 fw_flash_test()
 {
-	DUMMYFILE=$(find /lib/firmware -maxdepth 1 -type f  -printf '%f\n' |head -1)
+	DUMMYFILE=$(find /lib/firmware -type f -printf '%P\n' | head -1)
 	RET=0
 
 	if [ -z "$DUMMYFILE" ]
-- 
2.43.2


