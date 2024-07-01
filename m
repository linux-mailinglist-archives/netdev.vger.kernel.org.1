Return-Path: <netdev+bounces-108292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2937D91EB2F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 00:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3121C2158F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082017279F;
	Mon,  1 Jul 2024 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iGeZrQXR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CBE171E7C
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719874439; cv=none; b=PRlfL/RasBScr9+qgk3rNxgtX6/PIOllCIL0vCMTNeAcmdMwILscoC+h0k0qSQTx9Kzm1b16AR4SfEt+aJ8DKDuCbZRlQwiRI1ZZ6qOOifOXk2HeFSW7eXNbD73OnPK3bvBi13TWgoc8Iu8RfOAmPQMNcYm7JpkRpQGzeqBmKOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719874439; c=relaxed/simple;
	bh=Smc0aNxUIdjStnIr7RhacknbiF0AXfn+RG4Z4JpIvXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRaGUWQFnUmIs813k4CFHGqfbOlZSwRAkLI34Ko8GzVcMTju0Tp+xFmwEYS/EJeCcLFeh0rjug8M42GDSGhLxqxZ1k8w7tSKqLMo6mtblutV1kZBUpk0BZnrtQfYzR4NSC/zdgklepQ1RKng3nt5JnT3JNZEu2QNBK10GXsDCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iGeZrQXR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b593387daaso35214596d6.1
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719874436; x=1720479236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGrsZnTVUFPPpF/E8fcstNktKQvTmDHTgX9md/Cj9sI=;
        b=iGeZrQXRxFURLiuFSW4RGwMm2DiFSxUs7n63jJR6Qs8+6YzhcEOIfygUyhsf2olCyb
         BAxUPrQXYVulhrAwEtJgiZpSWqXPCDh3JRjTxeRKIXnlzmviuNrAbB6BnuqD47W0W7rM
         bj7UXE7hz0Fp1hzWDgUjbkTdkFDZ8G3ol3bSK31KHQ5b6fDxGm1eEAZHukxjuymhkqOr
         Lmz1AzZZ27jaJoTQty0pC3elOKkPsBS7GuMe/8hWMVd2raQ1DCDBAruVPacn0yj9wazY
         3uQafxcZvlb4Ih2Rc74K/EqbCWFjTYIJH3iIDNeyL9ef22TOeafG4r+xk9orY5Dzsvx2
         wpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719874436; x=1720479236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGrsZnTVUFPPpF/E8fcstNktKQvTmDHTgX9md/Cj9sI=;
        b=eIf6v37NwF5XSswKFxguoDj+ZVIy3Ed9OEqiFJJfqt/qcXqQTag8eLxGy/o7J5oP/8
         Do0m2o22c1TuhbR1EEFru5j1EgsyuPcXmu2wjPxGsDa8Ep1wVJt0HPhTcVG+UR+1E6qv
         dfVWhxAiyRR+qfwlBxwKBHkxs0xwraCXaP4MAHRJOyAaMnsKR3i9imqyQeUu8Pr3m9vD
         cI5uYQpcHZgQHIl0JKIaqUauLOetbNqkursy/TxVy72HrfHhkcjcUQhNuBWceRmdvtOi
         AEkKlMTYp5bFxnYdGsSmK7CpfL+dZKBWbn/O90phqA9QGRY6aEAHFEkyR/X8jzAYQn9X
         AeSw==
X-Gm-Message-State: AOJu0Yx0ofUukNpZuXmEsujl8NNkHzdbGjfQ78E+iiPQlQVa4C2vdYTU
	/THYo3+lo0xMGBFooGpKLq6WEhkHCCxUCkWo0/qFq0GAGWmU0hMXNwsDk1tjnXlDA3hDs4Dh/nl
	5
X-Google-Smtp-Source: AGHT+IFMGxWw/WWUSXJJ8Llfjdvh5SvxJrjm7wLTxPwx2Blxw5ir0jidoiY0x1sqbSZTHNJVAm33nw==
X-Received: by 2002:ad4:5bea:0:b0:6b5:81ac:6b84 with SMTP id 6a1803df08f44-6b5b6e96bc2mr124719586d6.14.1719874436643;
        Mon, 01 Jul 2024 15:53:56 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f34efsm37706356d6.90.2024.07.01.15.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 15:53:56 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net 2/2] selftests: make order checking verbose in msg_zerocopy selftest
Date: Mon,  1 Jul 2024 22:53:49 +0000
Message-Id: <20240701225349.3395580-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240701225349.3395580-1-zijianzhang@bytedance.com>
References: <20240701225349.3395580-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

We find that when lock debugging is on, notifications may not come in
order. Thus, we have order checking outputs managed by cfg_verbose, to
avoid too many outputs in this case.

Fixes: 07b65c5b31ce ("test: add msg_zerocopy test")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 tools/testing/selftests/net/msg_zerocopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 926556febc83..7ea5fb28c93d 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -438,7 +438,7 @@ static bool do_recv_completion(int fd, int domain)
 	/* Detect notification gaps. These should not happen often, if at all.
 	 * Gaps can occur due to drops, reordering and retransmissions.
 	 */
-	if (lo != next_completion)
+	if (cfg_verbose && lo != next_completion)
 		fprintf(stderr, "gap: %u..%u does not append to %u\n",
 			lo, hi, next_completion);
 	next_completion = hi + 1;
-- 
2.20.1


