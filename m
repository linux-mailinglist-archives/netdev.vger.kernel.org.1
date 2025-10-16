Return-Path: <netdev+bounces-229908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BFCBE202D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16D1150269C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B465930BF66;
	Thu, 16 Oct 2025 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zBdT8jqx"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33843090EC;
	Thu, 16 Oct 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600769; cv=none; b=IuS64NHON+JYHkMY9ZJ+uk3uZy9+ZZQB4etFhRngreQaxDdtSWexSQxd6gkqqCP6cKBlsBjtcQPN6+il046exlSkwo/+Y7cMlKrNBCZVzTwJqO4G5ziewVPdxLuL6NQlY0xvesLg0Y8mC0ETSRLp81Vp6YJzeV6cMC1jTa96V14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600769; c=relaxed/simple;
	bh=15E47hyvmQPrJWkj4LYQAs5VLKJP00bGmfww35DXTcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3Q2FvpHGzUf7M6yjl9N0frEbLsLzv59ctwEmi8peQjfR4W1Lt3vJkuaNxGPRmzRE3jB1skg6/S2UMBnmyuymPnF4HiyglM0iJDiV51MMMyRiHsbY+EBF/ssn4x8fSwFK6+v0TzRMJrnyVxXXrCFJaE85x9eMnZP0w3q5Jf07Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zBdT8jqx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 367A24E410F3;
	Thu, 16 Oct 2025 07:46:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0AF5F6062C;
	Thu, 16 Oct 2025 07:46:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6AC02102F22AA;
	Thu, 16 Oct 2025 09:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760600764; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nw7naf5mx2NiW6CLXgmCEx5KgfTcyto6pFTnj3WONc8=;
	b=zBdT8jqx4LkanZF/JNk/N0qpmTZXZpHsKx8zYt78sgLhzW+cF4VlIoQBaW5dEFvnqvJ8Wl
	VsSsQbpcP/4xKrx91nMQR1IbcbkhqERy30BeIc8C0TIroeLI++e/K51cKWhub1T4OV/An2
	4+Wb+FLs73AAMGzVwDjQcoF+6jQD0M5kMHt93mnE3709sFtn9IWQX1hXmIk3assHc+VVV3
	328KRaaU4eQCtxr8RwNaBCcWe1E5JyuVjhMEKvLqYaSnQLqKaUArwmiKq+iXDifEYJo6fH
	OA7NCgTuPoOSWUFllPJmtSkVRYsx9f4BQisOQT0uIJhFf8lSMFdWda33MEse9g==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 16 Oct 2025 09:45:36 +0200
Subject: [PATCH bpf-next v5 07/15] selftests/bpf: test_xsk: Release
 resources when swap fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-xsk-v5-7-662c95eb8005@bootlin.com>
References: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
In-Reply-To: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

testapp_validate_traffic() doesn't release the sockets and the umem
created by the threads if the test isn't currently in its last step.
Thus, if the swap_xsk_resources() fails before the last step, the
created resources aren't cleaned up.

Clean the sockets and the umem in case of swap_xsk_resources() failure.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 84b724731e26d0c7e67131ec1bd562e223d3d09d..8fe75845d7a6aa5342229fa419fcbaa411ae9e70 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1866,8 +1866,13 @@ int testapp_xdp_prog_cleanup(struct test_spec *test)
 	if (testapp_validate_traffic(test))
 		return TEST_FAILURE;
 
-	if (swap_xsk_resources(test))
+	if (swap_xsk_resources(test)) {
+		clean_sockets(test, test->ifobj_rx);
+		clean_sockets(test, test->ifobj_tx);
+		clean_umem(test, test->ifobj_rx, test->ifobj_tx);
 		return TEST_FAILURE;
+	}
+
 	return testapp_validate_traffic(test);
 }
 

-- 
2.51.0


