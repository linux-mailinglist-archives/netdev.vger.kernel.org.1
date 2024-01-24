Return-Path: <netdev+bounces-65654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 532AF83B431
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FE31C24178
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF04135A6D;
	Wed, 24 Jan 2024 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThSkNuM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B9135A66
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132495; cv=none; b=NsOOgvq0Alml7D2KaFFKpCQxKfntVRHp93F1TUCSbOpwo3SRREE2JghuX7bYkoJzWUoGJ+LeLcgHCR44kupZDPLYMJz9Zn/sbGYeHmCykp7Fv8GrmJFo4YySLlLymAZwWrT4G8PcVApyxK4QZ7bOy5wjy5Jx5VSwJOzNlbQMTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132495; c=relaxed/simple;
	bh=L6wBSyjWpEkApiKdAKEQJMcpF9u2gtdAWdUQxFKV1i0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hzYq+TYVNgBbLovcGlQxtmJ6+wFw+daxHLh1C9o8q+Uq8GgY2t5PpUDrBWH5mvZM1NfaSqxVuFKMi8HhFnlJ9Sm16FbJtvHMTaD+pMXzP9FTuiL4tasnkeVt3R4atxPN2wTg2X590YkzDyR4obfSR07Qu4Y9kfWq75g2YgiVPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThSkNuM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB52C433C7;
	Wed, 24 Jan 2024 21:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706132494;
	bh=L6wBSyjWpEkApiKdAKEQJMcpF9u2gtdAWdUQxFKV1i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThSkNuM3jV+x/sUzwwZ9XsoS+aUl6WknNi9OgUUYgU+MLdd9UfuvjtiwSE8uIamRo
	 j5UPKwuz8E0Zu+7wgpl9PI09/D9MGKEvaQecPQPaZIZcOCyLvTO7TV+stsPMHiatNa
	 653FN9CLzRAfy5Np5G2KWOkcoPwwa2RIMPa/A0LsdLFqbcz+dfEx1hDUzsiqYGUg8y
	 JVhqphcvvPUscX6gSYcyE0I+ZWpUBVQ8ln+xSf/c6eNvysIEGyIPN0uWHVtsovG5JQ
	 LwzQc/YY+MQBtYZusEmmciK/Z6jXB2TojK7460sFxsacjMNhx+E0WyNWpj6VckqjGi
	 +J9hMFgWeQzwg==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 3/3] selftest: Show expected and actual return codes for test failures in fcnal-test
Date: Wed, 24 Jan 2024 14:41:17 -0700
Message-Id: <20240124214117.24687-4-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240124214117.24687-1-dsahern@kernel.org>
References: <20240124214117.24687-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capture expected and actual return codes for a test that fails in
the fcnal-test suite.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/fcnal-test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index f590b0fb740e..d7cfb7c2b427 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -109,6 +109,7 @@ log_test()
 	else
 		nfail=$((nfail+1))
 		printf "TEST: %-70s  [FAIL]\n" "${msg}"
+		echo "    expected rc $expected; actual rc $rc"
 		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
 			echo
 			echo "hit enter to continue, 'q' to quit"
-- 
2.39.3 (Apple Git-145)


