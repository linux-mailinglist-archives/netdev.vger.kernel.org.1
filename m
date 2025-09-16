Return-Path: <netdev+bounces-223579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ECBB59A30
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAAB3B42F2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF252313E01;
	Tue, 16 Sep 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7lbGFNy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F73081BB
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032818; cv=none; b=MMKuPaPPX+eVOzyg2fuYBkvKaiZhMWj8agU5mAzrUc1lEPPW5wpLvd6XHN9GKm49MJnJBh2fytSQ86pQb5Cp4fHAN6+XRze0lcwkjl/3F3kYVMmUuw+obhhSJCSkMIGgzDKtL+9ZagSRv8DohOUEk8JySpSO4iUvSayvI5vvz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032818; c=relaxed/simple;
	bh=8DVyY2My2LnEPwUvnetRDblgxpbBgNNQrN4DCe9dGjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky8z0HGo4QYle/kzcrWb0OtE9ooxECafUUyNvm9YpeWi+VsTA6RQ4NENiIG9+PFYAiYo5Uzv9eyhXQT2cw+MNR6YcKjmNEctlVl/n9yKSe+54UdbXKlGGmN/8iyMnSkoYd4tvNCcYo7cRxmDbvytkv8v3UpVv90Amv95fQFc96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7lbGFNy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2fa8a1adso16022095e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032815; x=1758637615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCOQ1oM1+EGK4JaQrE9eg//uAjULVcI6A3Z+lM4I9Hw=;
        b=J7lbGFNyrMaFAMIAmdGhLK48dRx48unwiJwLS+l/miQhfgoAYZbeDRzFmA64IpTF8K
         eTvkjXFJOTBTBlrCaFwK+HOXPKi6P/x0HRuhf27pGpHpn8w0jC0JKudZHlM849pGae5U
         xwTEkwhUdmTWVw5o5N5T/Ead9u7hrLqqoTkDU1Q2t2REY5D8+sU4xWvhbbpB1c7VuvzP
         XZ5jAc1NzzFgOgzarsGeZdi+9n7KKMvfEBMGbBCf4GsjGI+EgPCYcD5gDIO0iZ408eeM
         bR7WVA6Wkd61PA7l4K+HarpEnIHDWQAO47fWk231J56APna7DJNImm5XflFOpmoNsKPz
         6CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032815; x=1758637615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCOQ1oM1+EGK4JaQrE9eg//uAjULVcI6A3Z+lM4I9Hw=;
        b=SZgg0kP5A6oOl7QGqTWCiFax1hauE5zEY3qTaxdiqLHq7+IudT9/ARVoHOUIP2HxKY
         W2VXpjb+iu+jL1gNB2MvUzNo0U8ywxNya4MKEMkvpuFidu+JQw+3dzmrUY8kFe1JZXCt
         SB+cUs8MCrRIfr6BwTkOe7+He9d+yjJRgLWwyozkHhv++Dqx9jzTJUEDW9wTGtMalJTN
         askh/uWecboDXPNRWAgao3OC9+W9Pg7ymhhLLdTh869MR3BF07JMfhsmMWrbe1Uq9+sx
         0okffu7jRyjs8Yz0yl835KQ2wPsaZbO/H4klpAMklaUYsw7eMzD755woaVPXqo8A0Ziz
         3naQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5immQM4FzKGCsGx9v9c7e8Fq9YLFf2nHFKv/VJ61HHRepKEodFO1jA0dW5MSCehCQb3qfia4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNI0ITBMJvtN2nljBa8IxC5teqaK+6cS8SJQPh5IE8SVuyls18
	xnrknmAIahIS2PlIH9e4D2Eh90X/lm3j0iz+eRyZgVJD74mhpIchuSgKlnoRHw==
X-Gm-Gg: ASbGncsKnTuJQGQjSYjikvDuQo2x8sfzoVJEVuQX+ikKaY+wUAMtq8z27pGBXr7mP4M
	A7G/394ui3ufeMCrkK0U+879Jc/mkfduGvQ+bSuJECCm+GvFh2rp8awklYVVkgoR0ZSxuBG8RvF
	n6+IUUpwITvM4TWSlvjEO64u6BJcKhfYtRZSIoDyZwxbo4RBn8dtx5nadfFHqtGF9GV/Kv7iEi6
	x0EYnBA8+7sO5Qd67LUdL0zmJsH1EglRPfm+5KmC172aQuHLZjE6nKn4ho056YG/xsxs9wuYqMd
	xx7+HSpoe46wgHF2g62Gbo5hrphCUc9oUTkonuUUnm7ynP4iehPFUEb2+gDbEl83BICTLI1l9ih
	OFC0BEZkac6deDZLB
X-Google-Smtp-Source: AGHT+IGepxlRfQhtbVssWq1YllEYEBgJiG4tc7DKoOR0KrmEboZOFgDrRjLS0dxnnFqn0l1l0E5mYQ==
X-Received: by 2002:a05:600c:1907:b0:45d:d202:77f0 with SMTP id 5b1f17b1804b1-45f32d16c2emr26029615e9.5.1758032815300;
        Tue, 16 Sep 2025 07:26:55 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:54 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 07/20] io_uring/zcrx: check all niovs filled with dma addresses
Date: Tue, 16 Sep 2025 15:27:50 +0100
Message-ID: <e15dea1bae569f620c28edc887596470f3f37322.1758030357.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758030357.git.asml.silence@gmail.com>
References: <cover.1758030357.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a warning if io_populate_area_dma() can't fill in all net_iovs, it
should never happen.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index ef8d60b92646..0f15e0fa5467 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -77,6 +77,9 @@ static int io_populate_area_dma(struct io_zcrx_ifq *ifq,
 			niov_idx++;
 		}
 	}
+
+	if (WARN_ON_ONCE(niov_idx != area->nia.num_niovs))
+		return -EFAULT;
 	return 0;
 }
 
-- 
2.49.0


