Return-Path: <netdev+bounces-69660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7006684C1C8
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C49F1F24A08
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372565256;
	Wed,  7 Feb 2024 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaYCXPZh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49D15E90
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268745; cv=none; b=AFA4+NqsMILgff6KE8Gzuqgauhq/yQ/BMqxmHBWDDL5gX3cDkFBU5ICwWtTS900g1J54YKC9zZ9+FhxL70xWFoP/tkvjPwPKhyl9jwsBDe/0Uxo/viXt5H0Rpn2gdekGyoK5zaPM7Tvpi4ZAP2DfpGvKHALY8OAyTSEL8Y1zfj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268745; c=relaxed/simple;
	bh=hKWVPiCprX1ThKp2JfHWDdrHT3np2epZYlpcD6ozbV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWMP1r5OFDd5Phhb6knzAiM3Ux+BTZD+uIh3uW0VXzhKFmOpFz71QtXGErRCQlUIh7XSyL0bGq8sUOUoko/YB779kyeUsqd2CphmVAnDys4RM2I6Z51ZyQFBrZXrlkfsAK0nx0mUzGXZ4ZLg2gjZSupYZJb3/3tAvjCoRIux0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaYCXPZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401E8C433C7;
	Wed,  7 Feb 2024 01:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707268744;
	bh=hKWVPiCprX1ThKp2JfHWDdrHT3np2epZYlpcD6ozbV0=;
	h=From:To:Cc:Subject:Date:From;
	b=HaYCXPZh6+hGO7xRBJMFWe4tPI8F0sOkKPUHEFvsm+3Vzixl7SIJyXJG1/wIrQKCR
	 djcrZ+wGXVeOXAazLM4npJIilcZCeyKhyN12rUGbVjjFxuSSQyfHKfE6DCSxm7H6Bd
	 SY5uA8MuvDBuSLexp4ewsfMUL5L5rSegyL3iY3eRfL6R3frFWaf0NVguZUkqamFujZ
	 aLZQGFx/x+DIqVjxw5yrtkRmZAZJpZlnRwXg2EXuDuF04cM3xc8Me+i4rzhvB5FBzz
	 zpbsn5Sihl/euTUTDH9TM7DvVjUnIVCE1DqNlanZ2FSXBcGKkzWS1rKCVvq4KxE+Hj
	 wcDtrbMs/AIhw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	vadim.fedorenko@linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/7] net: tls: fix some issues with async encryption
Date: Tue,  6 Feb 2024 17:18:17 -0800
Message-ID: <20240207011824.2609030-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

valis was reporting a race on socket close so I sat down to try to fix it.
I used Sabrina's async crypto debug patch to test... and in the process
run into some of the same issues, and created very similar fixes :(
I didn't realize how many of those patches weren't applied. Once I found
Sabrina's code [1] it turned out to be so similar in fact that I added
her S-o-b's and Co-develop'eds in a semi-haphazard way.

With this series in place all expected tests pass with async crypto.
Sabrina had a few more fixes, but I'll leave those to her, things are
not crashing anymore.

[1] https://lore.kernel.org/netdev/cover.1694018970.git.sd@queasysnail.net/

Jakub Kicinski (6):
  net: tls: factor out tls_*crypt_async_wait()
  tls: fix race between async notify and socket close
  tls: fix race between tx work scheduling and socket close
  net: tls: handle backlogging of crypto requests
  selftests: tls: use exact comparison in recv_partial
  net: tls: fix returned read length with async decrypt

Sabrina Dubroca (1):
  net: tls: fix use-after-free with partial reads and async decrypt

 include/net/tls.h                 |   5 --
 net/tls/tls_sw.c                  | 135 ++++++++++++++----------------
 tools/testing/selftests/net/tls.c |   8 +-
 3 files changed, 66 insertions(+), 82 deletions(-)

-- 
2.43.0


