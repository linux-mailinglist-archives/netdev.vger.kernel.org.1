Return-Path: <netdev+bounces-167922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37FA3CDD3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E051892FF5
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2601DFD9B;
	Wed, 19 Feb 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0tk7XUw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F31D90DD
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009007; cv=none; b=VGhX8OPUbUhUpt4bmRas2TjzDJVSmrK5rEfJElR1tY9dMH2YppAXljbikA5loKAgkDCT0qXuCoTbbZPBwn9VofqoIzaooDjZxP8UNHCDJHfHsgKpmyx7rEuTphtt5x9QB/9KUGdWHbD2qoGVdtxn9m/SG/P3IOy2NH7mQCnUJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009007; c=relaxed/simple;
	bh=xRodrAo4PZVNtXrremI9YzEr1LLiubNcdKDAjvpmDPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b94RmSEgTBufYh6qFhL4GRFy51fGyEvFPMs44N0EnBiSfFnJuLLytamxnU6qds3VxE//QBqD6ex2CgpSpCyP4T1B5Grg3vsCNj+EullkZyV75XaBuJrvyZrTzM9+6aNLjIkTJsOCoOFrO3tiUj/WEKO2Fd0+9Emd9sfu48JFNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0tk7XUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87812C4CEE8;
	Wed, 19 Feb 2025 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740009006;
	bh=xRodrAo4PZVNtXrremI9YzEr1LLiubNcdKDAjvpmDPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0tk7XUwaMbOGWl8iQLfwej3L7qFUT37SEOhdj6qv2HiDeOv68fKZl7/GooS2rKpe
	 hYNryBdMw2iFA+/FsG6kxfcygK7sf3IJiXg86uegcPZMzrgBnd9/dk8UrTX1ihhTcq
	 6Oea2aArzkgR08jY0clFcla1UgPWyS1yFjNmhy8CGd1Ia2B4gL4je9qb+OQFdY06us
	 LboheZ9ZY+6hC5ij+0wnGViX0wYYyrYw6F/utr8k86FV6aXtyl1JnKi8LhP8LKHrJu
	 F1ClZVidS09d+x5uUPP6yywJ1SRno+j+5se/yAy8vSTb3BCKyMfvZa+mSGX62iLEmE
	 epnKhO7S5tfxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	stfomichev@gmail.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/7] selftests: drv-net: add a warning for bkg + shell + terminate
Date: Wed, 19 Feb 2025 15:49:50 -0800
Message-ID: <20250219234956.520599-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219234956.520599-1-kuba@kernel.org>
References: <20250219234956.520599-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Joe Damato reports that some shells will fork before running
the command when python does "sh -c $cmd", while bash does
an exec of $cmd directly. This will have implications for our
ability to terminate the child process on bash vs other shells.
Warn about using

	bkg(... shell=True, termininate=True)

most background commands can hopefully exit cleanly (exit_wait).

Link: https://lore.kernel.org/Z7Yld21sv_Ip3gQx@LQ3V64L9R2
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: new
---
 tools/testing/selftests/net/lib/py/utils.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 9e3bcddcf3e8..33b153767d89 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -61,6 +61,10 @@ import time
         self.terminate = not exit_wait
         self.check_fail = fail
 
+        if shell and self.terminate:
+            print("# Warning: combining shell and terminate is risky!")
+            print("#          SIGTERM may not reach the child on zsh/ksh!")
+
     def __enter__(self):
         return self
 
-- 
2.48.1


