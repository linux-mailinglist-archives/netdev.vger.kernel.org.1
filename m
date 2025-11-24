Return-Path: <netdev+bounces-241292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB56C82618
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E86E634A4D6
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3D32E153;
	Mon, 24 Nov 2025 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Y+HB3zHo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670F32E12B
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014929; cv=none; b=NM/F0WYdrwWLDeLxtV2kBuu2ILRFCetXNawaHqvSvD31SmUkQu6ZV+gs54tZFkKQd0ANzcVuyerg8VCOiCOcvqpd6YiZQ5HbOmGM/2K6sK+ZUwAl9Up929FIf4wrHlAuKtBg3j8JERykNC3a7LaD4BeLkt7DKxvxJEnPaAPdbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014929; c=relaxed/simple;
	bh=lChGcFqZY0fxTjXAxFDuEargDMHeFwxNTjS6YeZ4Wng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IxwXFTQwcqVVcHALO2RlsguB+S/5lddvFyjzMc7wtSxTSwES+l4qwnwu4PEXop1ujDz5yfHW7lthz46E/ujvhh5QUFI7IqCuy+AVzIDM6E83WftlaNKVwDUaDQ8U0g5aYkji4ZORPHSgn+cvVAtTQU6xU5BnI9dYpE8ADVlzZsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Y+HB3zHo; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso47219841cf.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764014926; x=1764619726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/OeSvcHJmBNYWbxlm+UxnJ1I86MdUTBmmLneYzI86g=;
        b=Y+HB3zHoMk+x3Z5eznBYfY1TkaJJNPwH/bJdPHIMa+kU5byp/0l8TbXAtlk0PFnpym
         ULM8dkE1W7tU1CH2DFy8MQtQazAUbi2by2DCuMgL924Spmt3FpFcb7B2eeom9cus0zuy
         lyBVLYiPGqz+wdN9zRE+njbKWhDL9sMeYV+ptw+V4CmL5tRvJWhwuin37q2vFqd6auAh
         WMfDFzHp+aF6AcAlg57MK67jGCmQYFMXvwBALEKvFLDXoNXD/agtpzyI8kYhxZBZCNOT
         zIThEl2UBi9pT1Jxxc7TN6LttDahZBi8hP5ANyA5ztwXicp/VEdwG+31PZ62qvEGWXGn
         n5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014926; x=1764619726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/OeSvcHJmBNYWbxlm+UxnJ1I86MdUTBmmLneYzI86g=;
        b=iXKjFN8/HT7h5ut53nHIyNFoV4jrgPmP7iRvnTqBAdbCpeDjDS7HHkx6P8aKeLzAjm
         iap9CQIIRFnKdVHsOcVUBx1c4J8WfadYcQOmBf2J+zcYRxGdwMhLobUi3qO3pxvYJo+Q
         e4ukIqX14BA8IloB6swHxs1oDtAKdXza4MyQtVgJPewDOnWGiRwYh228v4cfVh4SDpRF
         mgTNrxsj+ZON7TIrutatzQHE3TFrRTpOgjLiwEVeBBXE6ad/0SBe4NSch0o+kQhjTWqG
         ckPARbo1AN4p1zryhQpbPb8Jjmbw+uD2a6yJQDf9mCz0rrDSGnrsfvz3xBpwPXlLW5L9
         OTJg==
X-Forwarded-Encrypted: i=1; AJvYcCVISlq0dSxJcUOQx9o4A5S0EkF+7Ae8pjVCgT4kdE0D0aCQ07mlBuwcW1iNQ84B4cUZyQDkT5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6R6HQB2ew/LYg5u8r/gCnLxkG+woHOhZAr17cdjUT/AdHs3II
	OsrHJ+6fjWrvg0kKCmYzTbT3GjwfjqIxeom0+0n68HYsN9FXxNIp9+YbEukqGHUd1LuO/VQv30N
	37nL1gg==
X-Gm-Gg: ASbGncvO4V3rjvO/+3R6uRoLOw+STX9McxzU06UbVbHGcfByzs7sGDxYZIeTLyPhl9T
	MoS3MDXvxmvyTUl+nOJcUZTyEwGohgFLjFEp38lOA2ggqXDpOP7PmALJICb8UsS9g8GsRlmzzPI
	qv801sQZgXN/CpDss/jSImvvpUqvMG5baGjmCG0hHYfW/YJf9wauVbXh0/JEtdcl+YP8eDrtrTs
	Ydio/SeewCTrRHGIwXiImYYH7C03Tbn7WQjew3Kl8uzubflPfaHejPl5j+JpjdlnFmnTvuoR00O
	PJBoYmHWFXDG4BgTcL3T8iNk8dYTamjaJqaENQ5PFKH3T7NG8FjKKH1Q9P5uG5a0uwFMAeFIuc+
	w8j48JSvbORZ6KKSLouzFCyLZg2Gx5lnML7rmk0ta3gz+HB6Up0UY8NNduy6ap+ViuCxbd45f4A
	typJY/NHlAuPk=
X-Google-Smtp-Source: AGHT+IExN2Ls2+Qxi4WH01dAMhgB54yvm9f+Im7RpnPmaNg/p543arMKvekfLWqxM2tXfFEbMSumJQ==
X-Received: by 2002:a05:622a:1909:b0:4ee:2942:c4fb with SMTP id d75a77b69052e-4ee5882d9d4mr187432211cf.31.1764014925612;
        Mon, 24 Nov 2025 12:08:45 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e90b62sm93195231cf.34.2025.11.24.12.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 12:08:45 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	dcaratti@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
Date: Mon, 24 Nov 2025 15:08:24 -0500
Message-Id: <20251124200825.241037-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When doing multiport mirroring we dont detect infinite loops.

Example (see the first accompanying tdc test):
packet showing up on port0 ingress mirred redirect --> port1 egress
packet showing up on port1 egress mirred redirect --> port0 ingress

Example 2 (see the second accompanying tdc test)
port0 egress --> port1 ingress --> port0 egress

Fix this by remembering the source dev where mirred ran as opposed to
destination/target dev

Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mirred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index f27b583def78..7315179197fd 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -453,7 +453,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		return retval;
 	}
 
-	xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
+	xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = skb->dev;
 
 	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
 	m_eaction = READ_ONCE(m->tcfm_eaction);
-- 
2.34.1


