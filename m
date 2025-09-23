Return-Path: <netdev+bounces-225599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09FB9601C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CE019C1488
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3404326D67;
	Tue, 23 Sep 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXf1NiRq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA1D326D5F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633993; cv=none; b=dNfU7Jksor6ThV3Tp1wayRMm5uwlsPwsjmrbcXJWxsoc4dpc60KmjNn5YyfQ2WVG7IBVgISYN+UKdv+TlYjELvUyhyhE8M7s4aBeDe03LYBUPZtiHPclrjmX1kb9It2WfXwFB2Vcd+WHAoAAeUOcLWx1amus1RugngKdlvRV7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633993; c=relaxed/simple;
	bh=8V7qNMYmqmW763GV+RmYh7nchonJ2A54SiLgvLE3h+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAKzAZdmXidM+pXwVfRXcc8hMX7rQYUO6noG+nGZxO7D/GJHm0wgAmX/kYbtphFQm2wEnvookHnm4zFGiSd21hoCv2rlayoTexjfsmNk/QOmJlTKOgDu1diHB9xRfmgbSrZyEpfVPxmbbfOfeJ+L6so5f+lkmmYdFdH3Y476/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXf1NiRq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f3580ab80so2530032b3a.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758633991; x=1759238791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRIuI240VxoL1i6yBF368B0vqwfoxg8/jQr7RxkgoA0=;
        b=dXf1NiRqZm5ceWONxDSm25EuPbw2KJHbsQnPCRsI2vUf0VbunbmZrdYUOQzUJ2OO9c
         70jyDEc37O2UD5kizszvIjTj6Fxa6iJNHPX6UVtYWA/YT+uFMtulS804QxyE8CHrNuX6
         BjlLitVVMlm8WwXyWy3Dv+JFrzs1qxns/PZ1xkOVgKow6KM4EF7eBESj4sI2r4N9VKh/
         NyJugNi+8wfZE0tDsY5bBpBwmo5tIorC1yKK0VgEyi56ky00SS2WaFNsWYLxEo9zWcGV
         NEAZhyWGq5tjQnEmaR7m05j0bwqrODd/8EsEu6BAdoIipXTHjJqWlWc5yP9a5loVGh/C
         ZVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758633991; x=1759238791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRIuI240VxoL1i6yBF368B0vqwfoxg8/jQr7RxkgoA0=;
        b=gXCjpEmlKWQXNZIu/DUkUE4awdj17cSlyHz2vW8/Xkss6bJa6foClCEcN0+RDlysy0
         KL3d61NXJhOSMLnykYxlwx1Uh4Mj0IYIh8P7RetG5UhVDtlM8YBo33PIaw0wdd6JDeN6
         z3eucCwyjOWOhFQkObUC+c/NAvV0Cz70rjZ6OBY0Q0drdyg/MwD4PU3VEKxMYK+D1+0A
         dxG95ycmzaBmJKJKGaLGxEEl97cl82tZZeywIZHK/dS8FAOmHaxEohwdb0W5QUZKp5m8
         wVt26cXadK+tx3scqE2/x+c8bQbVY1RgdocaKA5p//qFXdQ0tX/OW2OcUCQAaa0Sy8Lb
         4Vpw==
X-Gm-Message-State: AOJu0YwaTb+VckZxweWxg/9C+hDDhhznzNX2E6wTWaYODFcC2Wnj7ZWx
	8gcBopsglPesWMpraoa6T9/1PaSeFkYA2sqxW9djOJwpNAfFbnrl1b7K
X-Gm-Gg: ASbGncsGTrqYPf1ZE0QROia5zc11/AJ2nXJt/pUAQ1rTj4n6n4/m9pLGp1/+FhPRDKT
	czCTg26/FFYqa+9HpZ4GW53xWj1mwDnAxiE93akSsCiEzVzhe8UdHzExNaZTa6NaZjMbnrmwjO1
	lwUpri3SMvWk9bL6jwx/Xv8kj4v4vlhvF4YG9s5uQJatJECLcbaDk0QVSrF6U9tGsKAHr2+Qoha
	J6f0XjhwthI3J47WyiSfLQgSJO7qUexoJuAM2vNQxioFEZ+piNAz6h7gRwDu50zLyjWe6of98fx
	N1FyWtqMh30pc3RjjGOo2+eTTW9o9N7KSdBiclwbA/KhT9Us6r6jiNgAlNoz5zEyYxO4UBNaSLU
	QTJrQK23nBoXpTtV2BVvmpsc8zfJ3VHya3JmAlNo=
X-Google-Smtp-Source: AGHT+IH+ADeNw+LNNzz6vR2v2zPzN/YX3R6hydhAz88R8isrPRyZE7v+WE0D/79/D3puHieDDLiHmw==
X-Received: by 2002:a05:6a20:12ca:b0:263:1c48:912f with SMTP id adf61e73a8af0-2cfd9cc9766mr3844189637.12.1758633991225;
        Tue, 23 Sep 2025 06:26:31 -0700 (PDT)
Received: from cortexauth ([2402:e280:2313:10b:d917:bfec:531b:9193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551f3ee095sm11417841a12.34.2025.09.23.06.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:26:30 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pwn9uin@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Subject: [PATCH] Fix the cleanup on alloc_mpc failure in atm_mpoa_mpoad_attach
Date: Tue, 23 Sep 2025 18:54:27 +0530
Message-ID: <20250923132427.74242-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a warning at `add_timer`, which is called from the
`atm_mpoa_mpoad_attach` function

The reason for this warning is that in the allocation failure by `alloc_mpc`,
there is lack of proper cleanup. And in the event that ATMMPC_CTRL ioctl is
called on to again, it will lead to the attempt of starting an already 
started timer from the previous ioctl call

Do a `timer_delete` before returning from the `alloc_mpc` failure

Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
 net/atm/mpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index f6b447bba329..cd3295c3c480 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -814,7 +814,10 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
 		dprintk("allocating new mpc for itf %d\n", arg);
 		mpc = alloc_mpc();
 		if (mpc == NULL)
+		{
+			timer_delete(&mpc_timer);
 			return -ENOMEM;
+		}
 		mpc->dev_num = arg;
 		mpc->dev = find_lec_by_itfnum(arg);
 					/* NULL if there was no lec */
-- 
2.51.0


