Return-Path: <netdev+bounces-102694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27D0904547
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67371C236A1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919CD155C9B;
	Tue, 11 Jun 2024 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egf8ggWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809E155A5C;
	Tue, 11 Jun 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135476; cv=none; b=EpsaUkSmEGNNPyNafpZussI+d5qiraayu2GxadB3th0CDpNG03nfJxCiyJ6mX3zIcAZn1cpbQPauj1SyNptxe0iNcD+7bdL6krYWh/Vinw6CLXrRgKuAnOaJN87pb/vXxNHKHjHtdhakLnKfA53DjrTwQMHJolPes6G6aYvGcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135476; c=relaxed/simple;
	bh=5/D4BQ1WBsT6GU2VLzpbbHXzFCv7BFu7hzKEmRicHmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6c3LatqLyfQOSz6V6FQvp3WfTVmJgXHjFiIgVndlZYOMJZsyvr2RbS8F4/bJjucfva3B1y83q1tVWqUsNxTdq7uyi3cEUo/aaMlKmM2YI35q25PsPuTPBtD77NxsUUFFQv4PLOs14+F+47Q0M7ZhlHIta0G5gLZn9Cc2QaXtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egf8ggWe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c83100cb4so3094495a12.1;
        Tue, 11 Jun 2024 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718135473; x=1718740273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjWQ6m5e09n9wr/OJFVwEPXmlpK+mE24iUfx3PoRLCk=;
        b=egf8ggWeEpo4QEyqSAycZU1gpIEU1pwVluQAZAb8IKodVgr97Rjggadr+kn3KPHphq
         CO+B1KFx4VYIZDGaKO7WwoZjKCl6pTcLUTDhvZssncfRF9V+y00+9HXED3ZkJ9OinzfN
         njbC3X+zVKyjahuvJw+DAIucn8V2nHeUCHw037EDYm0Yt7gQraEFCCPAB2Gl8iVhumKB
         n8heP+iUTJ7ZUBiynGFc5+kbsBsDizL3DITX6OP7ICdD/oXc3cqecxAYuO6g05wV/ldW
         c6yJUKCxNrFDCAwqSP9ut0bxeYEQnWFvegyD3TUMdCc+lw5RXdSEqI+t0wCPDh88Avbo
         MOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135473; x=1718740273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjWQ6m5e09n9wr/OJFVwEPXmlpK+mE24iUfx3PoRLCk=;
        b=ZKe0BONrzKH+C+R/2N6LLUXjbH2wFYEPGJoIgwmE3gobe8hjUY9XqUhah02FYvjAde
         smd/kthpowppNBXGtVGO6C7AgPEeDcDC8qBiIeV1Umkckenrb3INsdJ8dhbjbsfkwZLX
         sjK774QoT1jxOkLxvO/Yp/xWgBuUbisueVt9T/ZwkYYGar0Wvfp3oXdfEpTyVa2d+NN2
         4lcFl92BYswp2/oAFMjd3USmPScVlAgQc+oSVxx/F8xR47vBs+8VosH4+8hTUIymfsSu
         tNprE6UmaLSttK/dLRMopKRLgk0yTNvY1vG/gcJgCt7cidOMmHHpo1lIpTF/fOHFcdoE
         yiUA==
X-Forwarded-Encrypted: i=1; AJvYcCXoiIrGDws1gYBFq1Ay1OR3SnpXNojCvhcAUqLmZydFU/meqXPwLIJZC5Ta7wisTKOGf0JYV4u6yYwaGJfuip0unwPLgXmHIn7rXaRP
X-Gm-Message-State: AOJu0YyRDe0hh/SljuYHAB3JWLGNwpKzciUQv4qKsrzuOYOhDEppfYMy
	vGWbfJBuY2/Q7Tq1YiYxzhWaKBrtpSWQae1bBdMgkM5eIcHgDdvejuEFIhzXMuo=
X-Google-Smtp-Source: AGHT+IHkXYq/Ss6+KK9itjakY0DDtOx3bnqmqMYtddtdV59++6y07lw3Ptj7eB645bKi5vd1jRFyBQ==
X-Received: by 2002:a50:bb07:0:b0:578:6c19:4801 with SMTP id 4fb4d7f45d1cf-57c81afdca1mr4126722a12.22.1718135472828;
        Tue, 11 Jun 2024 12:51:12 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7650b371sm5286737a12.76.2024.06.11.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:51:12 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 05/12] net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
Date: Tue, 11 Jun 2024 21:49:57 +0200
Message-Id: <20240611195007.486919-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611195007.486919-1-paweldembicki@gmail.com>
References: <20240611195007.486919-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Now that dsa_8021q_rcv() handles better the case where we don't
overwrite the precise source information if it comes from an external
(non-tag_8021q) source, we can now unify the call sequence between
sja1105_rcv() and sja1110_rcv().

This is a preparatory change for creating a higher-level wrapper for the
entire sequence which will live in tag_8021q.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8,v7,v6,v5:
  - resend only
v4:
  - introduce patch and replace 'slave' with 'conduit' after rebase

 net/dsa/tag_sja1105.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 7639ccb94d35..35a6346549f2 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -652,12 +652,12 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
 		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
-	if (vbid >= 1)
+	if (source_port != -1 && switch_id != -1)
+		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+	else if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else if (source_port == -1 || switch_id == -1)
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	else
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1


