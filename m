Return-Path: <netdev+bounces-296198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /U6GBX07JWomEwIAu9opvQ
	(envelope-from <netdev+bounces-296198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 11:35:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5066F64F3B8
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 11:35:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OuEF+ZoL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296198-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296198-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8064F300E618
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C766329CB57;
	Sun,  7 Jun 2026 09:35:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23A377EC5
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 09:35:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780824923; cv=none; b=e2jq9q1h5sz0/zU7kSWIB/2R5QiKAVMreCXjE+pOjWeSpUeJpuQuGvJCuGy0IyCYbWujHz+wUbapSyhHN3hZwTsbqjosz85vVpKdL3FPzQVXbSKokQrbJfE1A07ePeD8q1qagsQNihMS+4pMVU2tvlM2wwHy/41sEAKu3V/SnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780824923; c=relaxed/simple;
	bh=qSDy0AfkxAYlNXnjkHbJOEepYE/1eEVQeyRmTN/eZDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnCK4hhqgAVbyxfwPWnrmyxPPwmSJ6Cp8l8ca2Wl9fPwcB8RZhZZEMcmlJwFhRp/WL3E84dj/2EsMWhQXhKfrXTrT64xqvcVlbMU2+J5VKl0+i+1Qot5vTl+92uPUsQ+9lqPsecM4mLGRGzwrG8//5zyX3BXFctJmc5/h7C3BMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuEF+ZoL; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bea7176c72so21295045ad.0
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780824922; x=1781429722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJ+nE3Gpnoe4Cp99JZ7VpoEQgM0qNrm472Qh8AEjSOw=;
        b=OuEF+ZoLaoDkgkY9w15XJ5nr9IhljCK7FNQLbrsLc4WgIPedvgpLQFubif8vTR0W5+
         pEtlrrmx5zJ0lmW/G+EF41Q97/hZKV/7I026N01vdXGlrwBpPNijf4EqD0uxcwd+e4/T
         /S4chwU6pAKanjADRTgE2o1Yuis+RZ3U7k9FTJy47e1YIOh1f5muo0hPVtO6dDmOJGdk
         C/v3wo9l85Y+8rq1cAc2DgVPEYxJDyny8LANvQW6/OraW6WFKCaEy+vJeHwBJch4Kr9/
         p4hHSQETE+rSMlvHSIRCFtBGNwpwWnaJmawfJzquckNQgwpZi05U7MjxyG0wQj93L5T9
         nQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780824922; x=1781429722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJ+nE3Gpnoe4Cp99JZ7VpoEQgM0qNrm472Qh8AEjSOw=;
        b=p9f0LsYJJqHxOvvdRyt/9SVNz9OqhiJMeXZm17+db3vt9lPUaKCe0U7EHEfdC5Ux5l
         w0uI3+ZpXtpc0mrMkzkENGs5/Fus6hRjRL24T+IKHhWJeUYMpu4hLkfsSOp5+fKmlmss
         fSm8DlGm2fLTaoJHXYmFEKKtuvubbTe28DusVhLKuZBTHhn54gkP4bB5jxKm64D6Nzsn
         tkI51GJ0WFiftVOZZ4cAPyAR3sE5NHwQ8F3yhyMpvzXhMcvYbt9KMJ++hIYEKe+9kBNj
         JbOhOPquOtPVACD8xy4DCDUXVpzzaBmK67+x9V+AIKetCL/gyFexeVzDt8N+DAS+sb4I
         W4ug==
X-Forwarded-Encrypted: i=1; AFNElJ+vP9S1yA0OPtUzy5lCdCcrekJBEKuUTwJnO2PTLbGbQ8hAjUzhkwQf49gc18tJYyppY5RwHG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6yvsJl7OXT9AXztpC1CnDnP65FuZasdoCyK9sGwXrbuXzr6W
	8g/G0HqUnJExHGWl3m/tWKyAmDAq37edlO0LxOvAaoxvqdZAfBnrQGRY4Su1/T2NZ+s=
X-Gm-Gg: Acq92OEtM7E+qwFhgKuY6HjG1PjjKDcEve+dFjLTIqH65nGelU1rXm9whbOs7x8f6qR
	WpaKGURoi9FVHcEbsZSLsO3q+/8SgJzF0njH9hRxAJS/6SQTtBykC9p+GbY7EoaBbSnghwKB/VI
	Te1eAKMEMKaEyBUTPLx4hUaVD4fM1SRSvtVGI68AtnSKbzI+th6qhJZwZGipppJIwXEr9/UsZ9x
	nNqhJGtbH6PVxOimozE9259ZmrcxHwsd9nRb6bivKhgsFTrMjhVFm1OanVH+FyhEtA9pnHmQ1Zr
	5ug+vAEcW0FEY8LoZsWsRyeZLhWiGxIjHnwtC9huRLaNwSuSTQvdjI3QX5WBbVLkKXa69hMlAyg
	KrCvrVc/1AW1CxjctkaGJCA+B3eLXunjo6TaM78xcOlIWVOMbCFpTLjtcZq5HslFHbyF9FUO563
	k6ChFpuNWEPX+owb78iIW5xTvcs1L0MukGqe+F2psFJB31x0b6p6N6
X-Received: by 2002:a17:903:1b47:b0:2bd:9c0a:32c with SMTP id d9443c01a7336-2c1e7f921bcmr127871045ad.19.1780824921886;
        Sun, 07 Jun 2026 02:35:21 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:5d57:2cec:64ac:50a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166396fa9sm145238635ad.66.2026.06.07.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 02:35:21 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] net: wwan: t7xx: check skb_clone in control TX
Date: Sun,  7 Jun 2026 17:35:15 +0800
Message-ID: <20260607093515.3-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:chandrashekar.devegowda@intel.com,m:haijun.liu@mediatek.com,m:ricardo.martinez@linux.intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5066F64F3B8

t7xx_port_ctrl_tx() clones each skb fragment before passing it to the
port transmit path. The clone is used immediately to set cloned->len, so
an skb_clone() failure results in a NULL pointer dereference.

Check the clone before using it. If previous fragments were already
queued, preserve the driver's existing partial-write behavior by
returning the number of bytes submitted so far. Keep the existing byte
accounting unchanged so this patch only handles the allocation failure.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_port_wwan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index 7fc569565..d2529df75 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -106,6 +106,8 @@ static int t7xx_port_ctrl_tx(struct t7xx_port *port, struct sk_buff *skb)
 
 	while (cur) {
 		cloned = skb_clone(cur, GFP_KERNEL);
+		if (!cloned)
+			return cnt ? cnt : -ENOMEM;
 		cloned->len = skb_headlen(cur);
 		ret = t7xx_port_send_skb(port, cloned, 0, 0);
 		if (ret) {
-- 
2.51.0


