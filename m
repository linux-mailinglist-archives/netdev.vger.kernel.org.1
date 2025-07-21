Return-Path: <netdev+bounces-208607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E17B0C4B6
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668803AC88B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43DD2DAFC9;
	Mon, 21 Jul 2025 13:02:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7B2D8798;
	Mon, 21 Jul 2025 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102941; cv=none; b=nEZaHiVrGgvR/21XBmmTxppGhL/BJRoaQogRbYUMQy/ZaTTyotSdCSM107guPii2EG/MumSpr87tvdelABTuqQj/PBx9rAOqutoU7GKc9m5nY0p8H65pl+oORe3fIg9lg03bKy20hgVPIEJ0UwtHjDyCt9WqqwVNzTv7D/L27Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102941; c=relaxed/simple;
	bh=4JN0ATgLpCma7eYapT/JB0yvaXsB9QCd/f7n1PA3K/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEfsKwvDeByhpGMpzyj4Qk87+1jtbBsAiE0v5H7Uh2JGxIJU45X7BH8ro8Y43dvtrxDXs9bmS3HJFF7x5HkVGTz1CPIlPZ7A7c+szikWgTav03ff7w+tFcZEEukPc7hGvcOe0X1OneUOy68u9Qfj2BGUG1Um7t7YN9ZP+THmntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso32968571fa.1;
        Mon, 21 Jul 2025 06:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102937; x=1753707737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkOlTgVZdIpxOKYlGwV4g8bCfrBjHtQtpJ5LGJBlJ9g=;
        b=O2ENEkThBkP6hzL22gPgdV2TWiyzQYY2t998wo9Gth/guj0wlrge+3JPAfTUbMMp/y
         P2wokyVvrUVuZZoXAyXM40HLuudzmWs1gUUp2PVvIC72TotFzO43Uw8KDeCFXFu0HcQ9
         MgtNV2oSGf+N6v2URgTi1eJrepG22oX0zZxZcidGgCMWJGqRAx+wAWH1dn0jULgfxzol
         D5dmSZpVALV0OoMp6NiGRareeqI8H45tTf+VgNtYshFtwBRACGMsz34wiL9ZECZfkTxx
         YJMJTTTvjBmNyeksqq40x96IbQ17tH5TN23Rqh1byM7BhXP7cKRCjhfuIcy/dJgEVAM0
         Vehw==
X-Forwarded-Encrypted: i=1; AJvYcCV2K1D8lPFhizqjmG/cowC48+oQUTkND46kYZZXs+DHsBGErpoTHm1kYA+MO3tz0uBQZxIcR3jZFAOQMqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybAK5Azi8tDcYKDpvdhmLNUf9U9TddRMSSVLQdSyoACLELtBN3
	TpkKERQzykLl3IbcWTLA64JMm8MsykKzktAJIE6PqLMmSvI0BCmZ52E7jtoMxA==
X-Gm-Gg: ASbGncuLmYZ4OCegPtro5fPpy+K6p+l0onJbkeZLX46X+4h/yC4UEVrCt0zo0nctOkT
	2M/ZAhrBZFT+nt9pqxxNBFmBf5dOsFO2QhzAwpy78c4E2KJMZrswXiC6spTiYNEnt4LBV6SicoC
	39haYotxjJLiueFLsritwubaXXSBBJVW1w13zjE0o4y9mHI3Z54+Ejmegwx3DpkLNNZqkJ6G/Eq
	y6Lb5cPo+MsH8jQ0fDSXqGyKaqw/POrW5L4STRwkC10jaiB9c5hTaZ6x23rGPCCyvCHti3WxtPd
	H79RQS3fPLKQ5putXjdfRrJmFA12wfZk+cRY0PTxpBkxTee+Z6UATJ1sNBYZQxZhldEYKoXxgFo
	rI712ePQeNEfk
X-Google-Smtp-Source: AGHT+IGlgtXEcUO519UxUQeLhFSjYFtZl4JRfRX+I9/QfVF+ZoiJ+TuyoBIaVPBdEbhS0IIaiIit6A==
X-Received: by 2002:a2e:a7ca:0:b0:32b:7111:95a7 with SMTP id 38308e7fff4ca-3308f65f8d6mr60856511fa.41.1753102936873;
        Mon, 21 Jul 2025 06:02:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf7e78sm673456366b.158.2025.07.21.06.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:02:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 21 Jul 2025 06:02:05 -0700
Subject: [PATCH net-next v2 5/5] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-netconsole_ref-v2-5-b42f1833565a@debian.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
In-Reply-To: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=leitao@debian.org;
 h=from:subject:message-id; bh=4JN0ATgLpCma7eYapT/JB0yvaXsB9QCd/f7n1PA3K/I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBofjpOItlTbQ1fnsmnflHZwrqxfL7AqqCqylI0E
 HRPfRUxkwOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaH46TgAKCRA1o5Of/Hh3
 bbPJEACTo3JD8fIsSgevIhoiywuZoUxI4jePTwbBibl5B4P81BOhBhl9kJxA9P1Msx3dg1XMmSv
 anAUhSL0KbV/E0IrSZRW4oaDaIq4y6q77oghJqvVY6WxDUngmvtELFySDV2joJRmVCexJ84tPr4
 hlnl7G5paxHKDiM8hpisnUuF7A/9jZygnjQzgSwE6zJnHs4M6FKit0pfVIWT+1RkKS5NI0DeDnI
 mtpSk8N8zrlr3JYRfT3beNq5C3BQDh3WxBRbaiZiEYZT1wCzdUIQNx+5MHUIag6fz52zigi4gfZ
 wnvRRJAMLTqKcZXTsGZ2lB4cPOIXlVtVZqroOCrc8HjsNReWzSBVZxXXBpagmGUSZ8llOHOEyUz
 FjaafhsBrrnVW1wUI9XFBMc5SRmLXkXGfPvVoLILU0UXWf+16tvca2r3zzdccX4fjLvMUueIOP2
 VSUmOHer0PGXBwBA7JniIFo1CibpkYRavQ0a6TP01hLwIJ6Vg2Ng6kRu3L/XclitgE4bVsEE93U
 otlG1TqnSBRe5GM+7sl19nynPhfxdTxDfzJQVUX9s0tYQjwj4ZjN5WUvysKFXX7DOwNtVAJxYH6
 C1m4uNS9gpzK1mxqmuAK/9qAAQuNFKviOhlc4Q+gcc6598AQVD4ocfWJm2HeQYHyUiSbIRiRnV0
 v3Uk56elxvw9QMA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace manual IP address parsing with a call to netpoll_parse_ip_addr
in remote_ip_store(), simplifying the code and reducing the chance of
errors.

The error message got removed, since it is not a good practice to
pr_err() if used pass a wrong value in configfs.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b24e423a60268..7b394488384ea 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -776,6 +776,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
+	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -784,23 +785,10 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	if (strnchr(buf, count, ':')) {
-		const char *end;
-
-		if (in6_pton(buf, count, nt->np.remote_ip.in6.s6_addr, -1, &end) > 0) {
-			if (*end && *end != '\n') {
-				pr_err("invalid IPv6 address at: <%c>\n", *end);
-				goto out_unlock;
-			}
-			nt->np.ipv6 = true;
-		} else
-			goto out_unlock;
-	} else {
-		if (!nt->np.ipv6)
-			nt->np.remote_ip.ip = in_aton(buf);
-		else
-			goto out_unlock;
-	}
+	ipv6 = netpoll_parse_ip_addr(buf, &nt->np.remote_ip);
+	if (ipv6 == -1)
+		goto out_unlock;
+	nt->np.ipv6 = ipv6;
 
 	ret = strnlen(buf, count);
 out_unlock:

-- 
2.47.1


