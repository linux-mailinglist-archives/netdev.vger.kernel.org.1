Return-Path: <netdev+bounces-153146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5079F70C0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 00:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30650188DEC8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 23:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19761FCF53;
	Wed, 18 Dec 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc0X6dTU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7041991B8
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734564404; cv=none; b=hXExAEybmPPg5XiJdC8aEBzD8B5hKIHMAOWNfv7mT61alYuump0r/rzzd2aUWmSYk3jlqnkXXG6yYxjD13MCxXwA60Q2+L9ueYlvxEPupVbRql0OPSqCxCrgaurXxwYTT+pWUZqUZwhTywYokD8tQXlTfhUZHfxqy/mkZgYaGW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734564404; c=relaxed/simple;
	bh=wI4hBFxGgyJ1cwn0KLdx8nKFMDdYQMekDSYy0qT0SBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R5PgPx5awmEzEViv9E0OJw48g14PTAOZQpEAFqcUjBLrsr3MKb5Xo89cw+onEH6F7gVAis7Uv5o0InXF/9pdBpeTYfl/Pf+E6N3SXatHVhAx53kQ7kSaVnRWEruI5ikM4pe9wxtbIaCrKhCb7A1BDbQulW4s8QJv8v350vTnHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc0X6dTU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d6d5765so131164f8f.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734564401; x=1735169201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80vCacuzEw20qnXvUhvL669BlEftqdFkYVgud7RB8JE=;
        b=Tc0X6dTUDi0k7GPxwTH9SXUP18iuE9P67xj9/z33hr0tvKpwfzmtIcJqBlsdZ2dEUI
         Czf9gJnguiHAAXBwQIFMQCCHwq4N3jpCdg8MEk34Jdmop35lxsEA5MYzxRcKziI9nuS5
         pf+0Ii7IDD4vhmWe+4ExjOsKaQFMh6GGJr2tpe5z9alCfuKN9qOeBiqFaBbmUXMRBI0i
         yBPkcbcuW7KlQF01ntjEDXL/NLomkL3jr2y0UdwnVE1up0yfKfYwpwG+ePgEdM2AtdDg
         XfV7A4mlF2QZAUjAXnfUq5JC1hx995+5/hLyJdUXEiedLr0dBkUkyHU5u0Sb8F/OUJ0q
         sYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734564401; x=1735169201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80vCacuzEw20qnXvUhvL669BlEftqdFkYVgud7RB8JE=;
        b=VLS8vFia17JFueZU3I5JRAZ8yaTaiUA2WpkhGoxm8yLFd78M6Gv5nLxiCX/RuWexW0
         FMBSenhbYWFO/g5H8LUfDsHpnPRh0WpFL5szZaknNVaefjwic2FpFLLKoWRQRwDVTk2S
         n6VPScaTNqUiBYbhDtDIjmfjYZohpSccj6qyF7Pntah3pHP416jcu/ZfEQX9yL2PYwZD
         5YBa3tIYcsiNs2K++4AYof+jGxD1SrzUtGRyfhcJ1QZiGUP323+HhXu+2c2aqKTZT7Gt
         sptvBTGcfD17+/qojGbs5vMH+HknCqDlyqo8aHLIPHTnt7ceYgvvRukSyGryRcvbtYG9
         nzAg==
X-Gm-Message-State: AOJu0YxS486risnzjVQUuz6c05vRw4P2r+pJGODJNg1/8dc+tisGXwpU
	34ctFXeQlluLkq1Kh5AWSoMKFvBwwzX0QJhvAYXFJDbP8dniKHqpXAXmLx+x
X-Gm-Gg: ASbGncuh7/u8YAIWQIZQPpdJcVfIMZfjC2Gs9RcG/jnK+dAiQp8O0frz7HYgMj1nSG7
	WqIXqect2N0wd20kGitagyEp/+IA/BgLnNpAFQjd4nR4gtYVeFi8sEn8KQz2KE2atCrt6X0THy9
	pl3bKc46AE+CvID6x1riym2ODokA8tBU5/qjKChXR8km1IIgUxYhU5b8wWyb2zq18SHeUEQG3AB
	NPBs1B3hU1HN9mwDOiiP2l5ea65OCY9PwDn4gW3nmqfRPLdEDsDIA==
X-Google-Smtp-Source: AGHT+IGIRkIj1MM++egRqL16HKLNEqeoEECtr/uL98ngA2o8HUhO+VJl453lUZpFp6uvH/Dl5odMyQ==
X-Received: by 2002:a5d:6d89:0:b0:385:e1eb:a7af with SMTP id ffacd0b85a97d-38a19b26ef8mr1034380f8f.48.1734564400978;
        Wed, 18 Dec 2024 15:26:40 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1cesm51756f8f.64.2024.12.18.15.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 15:26:40 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next] eth: fbnic: fix csr boundary for RPM RAM section
Date: Wed, 18 Dec 2024 15:25:58 -0800
Message-ID: <20241218232614.439329-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

The CSR dump support leverages the FBNIC_BOUNDS macro, which pads the end
condition for each section by adding an offset of 1. However, the RPC RAM
section, which is dumped differently from other sections, does not rely
on this macro and instead directly uses end boundary address. Hence,
subtracting 1 from the end address results in skipping a register.

Fixes 3d12862b216d (“eth: fbnic: Add support to dump registers”)
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
index 2118901b25e9..aeb9f333f4c7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.c
@@ -64,7 +64,7 @@ static void fbnic_csr_get_regs_rpc_ram(struct fbnic_dev *fbd, u32 **data_p)
 	u32 i, j;
 
 	*(data++) = start;
-	*(data++) = end - 1;
+	*(data++) = end;
 
 	/* FBNIC_RPC_TCAM_ACT */
 	for (i = 0; i < FBNIC_RPC_TCAM_ACT_NUM_ENTRIES; i++) {
-- 
2.43.5


