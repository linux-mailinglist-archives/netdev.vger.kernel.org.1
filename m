Return-Path: <netdev+bounces-256929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOc0Lr0EhGmHwwMAu9opvQ
	(envelope-from <netdev+bounces-256929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:47:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E696EE178
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8406300BD82
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC40A1C2324;
	Thu,  5 Feb 2026 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCz8lea8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B13EBF32
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259642; cv=none; b=ABrSyTgJd1IT2jUzzOrWvgqkSw36aaEZOgkbv0Pv9wZZ2NagLBM9kXuNLKLEBqHEUbH9YQcg1pgdF8tmpHuAQ4H2956xtHjFF6YyL8NnHv+GCQDqD/d4drOBO4uClgzQZ28RBmqnEpMewDq0/GYylfsGcap8Ltrclb++rqxFAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259642; c=relaxed/simple;
	bh=8Gg0Td2TnZxUw2O77jFwN1ILQNYnFw/fjFCDTq59L7s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IBA3c8U4Ot/wXEx0+PUGwwH2iuyTi4JVw/HXKgg3xB/NR5W2XZSlU9usFSsiQ8RWpB0eegmftwnBlGa8pYrA4MP70kolg2bavuDepc1zLdSmed1T2gTCcYBBpgtkkvOn54SgHlHq5eJ3G8lHjzSJDhwLRgQgO2NRXel2MqC+FNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCz8lea8; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8946f12b1cfso6127836d6.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 18:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770259641; x=1770864441; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nY8yM9Zc7+K73Kkfh7FYItubbQedLPsN6KpC2egtpVw=;
        b=VCz8lea8AO24AxguUZNZbQHcKsENy+UuqehHjyHuDnOmJGfUMnTBbtrE+3A2FN2Mcs
         /5yvx/4iXb4ir00o/Hj0jbCkVq8kK6sGBuo/MV0QujfbUxUJQgcSgcnwtef2uGS/ExU1
         Vo/Eter55UIofqEEJhSghxHifpr88MsDdZ6y6elB67y8khqmVCXnhEsX4ZX/AKXf4tHK
         L5ukdPJDL9BnviNJTiDhORFPL+cRlE0Xq/vqfNc0MFgM0DvsuFiDr3S7lHUUUEnOdEJQ
         srpxmg2Vo0hAkmHwvgwLTvgvdHp7QyMSAGs1AGh+Hm7J2N9YUVJt3Gy7ewnf9fNcskA0
         sJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259641; x=1770864441;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY8yM9Zc7+K73Kkfh7FYItubbQedLPsN6KpC2egtpVw=;
        b=v6RXvxzWeRl2yy+H7qf5oAIEuAVZKzbhmpvSsChWbVf10WkTtKxbUgfEdaBAHeoEjD
         IlzTb4POss7TvxCBYOdAEe2FJj5dxq+xGO05kWhn1Rh5jkAF1eECbuQuTMvFpYav6MiA
         rew3gXSG9sJzR6lwaZvEkX5s6o1YJgIyWPlwOpQ0BNOcG46TNkI8OJh1olq7btMkWyNL
         ntWxMHqPkwz+D1vFLSUs/Xmm/vBBS1j2f5yAyS/aRMqM5IORtS5fxObyZ8QxLbFTXj9t
         97MZ9btpQKf+5fAhskadkD4TNpSwseCFqZvbsFo9eGkaWn44sPI/dcLKStqWkhsoWzEJ
         +3TA==
X-Gm-Message-State: AOJu0YxexXonvq3jxgwPBi+Ek/ezOte4Ff7E4OtkjTj3zLVPF72xLEuo
	kfDoF6qUHNiQ/Z2Yw1qztibQcQYbYry+qqqQ38ntjaXL211a38ymv3nw
X-Gm-Gg: AZuq6aKf0fbIDAjVr3VVXSSxqdChusmUknhQUCRkRHCUCvpIPV4zPVauXax9MP/NqYi
	7fuikl65enL6YKEUGFw2S6Ma8cBXJEH/FC4VOGQAd7Wu80slwGUjVjaJmk+HmptKwQkJnOaKhp6
	A6GBsgBtfrW9XRXCnVP4hV8cYgEFT0wBeDYa7ObH583KUSI8/BFAWjgHjky7ubMtld5oEET1bML
	QaoZgrWcd4tuaxgI1TwWRWrhNW1KD0AamhWBf8Y8C9X9rtPjyhR6eDTMGmCiP8kCTRWA8JTeMq5
	z/xoWApoWBPkbUmqyKI/65HfDxF1UpwNaEorOlP4NIihyMRato7dOpWuN3Mipa1ZLULBhH+3Q8t
	KAkVnOVIcuqVJ1Q+yV8FB5awLMeN3hzqEGwGrakiuOinehs+htIvHkOw3QdgOB6SHaei6Su3iFA
	dGBYVP3dPOQtSgTcbvkIrY71UG2s/qFQg=
X-Received: by 2002:ad4:5ce2:0:b0:88f:ccba:8f20 with SMTP id 6a1803df08f44-895221ad111mr65849446d6.48.1770259641266;
        Wed, 04 Feb 2026 18:47:21 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2b5e3sm308193085a.25.2026.02.04.18.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:47:20 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net 0/2] net: cpsw_new: Fix multiple issues in the
 cpsw_probe() error path
Date: Thu, 05 Feb 2026 10:47:01 +0800
Message-Id: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKUEhGkC/x2MMQqAMAwAvyKZDdSCCn5FHGoTNUstqahQ+neLy
 8ENdxkSq3CCqcmgfEuSM1Tp2gb84cLOKFQdrLGDqUAf04OseipGdx1I1K9+tDSQc1CrqLzJ+x9
 nCHzBUsoHZMvzs2YAAAA=
X-Change-ID: 20260202-cpsw-error-path-dd5bc72d6daa
To: netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
 Murali Karicheri <m-karicheri2@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, 
 stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256929-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com,nvidia.com,gmail.com,6wind.com,linaro.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,ti.com:email]
X-Rspamd-Queue-Id: 1E696EE178
X-Rspamd-Action: no action

These two patches address duplicate or unnecessary netdev unregistration
in the cpsw_probe() error handling path.

---
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: stable@vger.kernel.org

---
Kevin Hao (2):
      net: cpsw_new: Fix unnecessary netdev unregistration in cpsw_probe() error path
      net: cpsw_new: Fix potential unregister of netdev that has not been registered yet

 drivers/net/ethernet/ti/cpsw_new.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)
---
base-commit: 0f8a890c4524d6e4013ff225e70de2aed7e6d726
change-id: 20260202-cpsw-error-path-dd5bc72d6daa

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


