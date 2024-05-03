Return-Path: <netdev+bounces-93236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF448BAB29
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 12:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A111F22B6A
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A8153503;
	Fri,  3 May 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jl4ORSgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674011514FD
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733919; cv=none; b=JKiZZdOtMjqitn92uTd6UvxQYEZpAxVrW+BIcGBEcQEDGyaHcg0y/VLWccBmuJRW4LxJshp5mqYkhrNfNmXAjk8DD4Yia+rLURjDLe+N3MkZDJV4Li52px7yZ0826SGhgi/EcbnXvTXbL/qfxZbol9ePcCZYNbXWro2xPV5v5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733919; c=relaxed/simple;
	bh=YYgJGzqiQDWk2U/jpEaS0iynxyFT/ValkUI+CWeo/nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZnTbflMpDnBqpbzgxFSnVn8e9hsrCM58pGiAvpXQj6meQbgZ1qFLE6PKbLA10p37emt6KfsigG3+Q4OUYll86ot9MGSONT9MvxcweyHGIOHJd/cUyks+997/nJuyRftRWZ9qfJWYvLHOfTB9wecyOZPfAePUfrRU0aIf5VKkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jl4ORSgI; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VW7891MNDzFCh;
	Fri,  3 May 2024 12:58:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714733913;
	bh=YYgJGzqiQDWk2U/jpEaS0iynxyFT/ValkUI+CWeo/nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jl4ORSgInVzriZlyH8Fh1bZt7ELq+4U1b5bQnofqUODUhK7HZsjSBaqC6uKAXU1mk
	 LfXwcAvdjTv/k0iDazNVeEIKEAbrvGk+jsXNa5b2UtxIxtcEeWmvQ33q6vlzlZ2lTv
	 ZJTKtV15YMGTt/Bdgw1F4RLtoloQlit1UTh/KRhU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VW7884rhrzRXm;
	Fri,  3 May 2024 12:58:32 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 02/10] selftests/landlock: Fix FS tests when run on a private mount point
Date: Fri,  3 May 2024 12:58:12 +0200
Message-ID: <20240503105820.300927-3-mic@digikod.net>
In-Reply-To: <20240503105820.300927-1-mic@digikod.net>
References: <20240503105820.300927-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

According to the test environment, the mount point of the test's working
directory may be shared or not, which changes the visibility of the
nested "tmp" mount point for the test's parent process calling
umount("tmp").

This was spotted while running tests in containers [1], where mount
points are private.

Cc: Günther Noack <gnoack@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Link: https://github.com/landlock-lsm/landlock-test-tools/pull/4 [1]
Fixes: 41cca0542d7c ("selftests/harness: Fix TEST_F()'s vfork handling")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240503105820.300927-3-mic@digikod.net
---

Changes since v1:
* Update commit description.
---
 tools/testing/selftests/landlock/fs_test.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 9a6036fbf289..46b9effd53e4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -293,7 +293,15 @@ static void prepare_layout(struct __test_metadata *const _metadata)
 static void cleanup_layout(struct __test_metadata *const _metadata)
 {
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(0, umount(TMP_DIR));
+	if (umount(TMP_DIR)) {
+		/*
+		 * According to the test environment, the mount point of the
+		 * current directory may be shared or not, which changes the
+		 * visibility of the nested TMP_DIR mount point for the test's
+		 * parent process doing this cleanup.
+		 */
+		ASSERT_EQ(EINVAL, errno);
+	}
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, remove_path(TMP_DIR));
 }
-- 
2.45.0


