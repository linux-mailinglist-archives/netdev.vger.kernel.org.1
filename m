Return-Path: <netdev+bounces-296254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Et+jKvWRJWr/JAIAu9opvQ
	(envelope-from <netdev+bounces-296254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 17:44:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3E650E5C
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 17:44:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="CYivNc/f";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296254-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296254-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 078853002D3C
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1DF2C236B;
	Sun,  7 Jun 2026 15:44:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E425274B23
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 15:44:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780847081; cv=none; b=rf5AGblo1BxxEb+0ByzZF86wMMvo4qcBQ+irRKhYyxDGHPfA3eCbENi3FYzEGp6Ojpz/VFfKhhWqkA4PIhvS5IelQ9axbJJKBmJljjr/B4HYwkmTisqh92Iouqt8VAqUKpx1/74fYHlto6r3YNqTM+nyM3Spb4osIK0Dsy5NEkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780847081; c=relaxed/simple;
	bh=idG7Ku7uJl0jqp6TckTuNiL8B/wD9Z/s9hlLWpvXd90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ej0B4GruU4kAWsTN2H066NmvFiYuJLw8DziSdmmVj/oYOcr2TdS6bcZjvBxbdYIxaN183e15oK6S/sA9RtBh+m+XVJQVIhiMbbgr4/sFVkcp9DahDM7cP0+YbP6BD2PqG9bWp11gCVEu3uouSs6k6Dt/U3HvoUw9cUgKOnFe8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYivNc/f; arc=none smtp.client-ip=74.125.82.195
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-304fb780deaso3455377eec.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780847078; x=1781451878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWU/xwt2CG6wA3LDuejU+B8XKg46XhnTEXFr0yiHocU=;
        b=CYivNc/fNhkyCC0pCZiRh++gOjsHUs8+YIU8Yaci2MBLGrjqMcOUXE+Id21AoP0JGJ
         3ARpOYQkHtCKX2NJxJ5+RjgBkHomtj5fjIWsudxthEEn2lnvzIr9rW2as8hAXxcaXbaQ
         U7f/4BfD37qHI65fiYO3eIXL3gH1XxMPH79CVtNS18xFT4RHpc4sHeHUqfolxRfxvlj7
         BL0owzMR0WFv0jehrC+3LvO1Jfbo39Fod5/8ZrP+ebGIJhaqFDjjuP247+nk2af99+TX
         6R2MPPYFhEo62rAYpbHaMH10iueHXNEPUZpXPIHrPaFW2DxSuOeMS0Z8EbO7DjTE6x4V
         AfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780847078; x=1781451878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWU/xwt2CG6wA3LDuejU+B8XKg46XhnTEXFr0yiHocU=;
        b=WpOu8Kl5X0kO2obx1hFwNARHVfF1ZG4FZhHn3ByGuPceC+vHNNkUPBlnd4uJNQ4feI
         pbdpZqPuRNkQsmDHuLr4AW5cyXTOu8mOuOW4gem3NxSeO/1qUfZetnns1ffr9f8UwHzz
         kOF5rOGFJ8HyVyFJDRtxjdPe/WkyLOGEue0lHg1UatRqH9Gfmgs/SREiV3yB2kgl29Ri
         AQaWGvB+mtbd+JDErUcREZ3y285PJxO0DNZ/mb3RDMvwWrT+18xBcJfe1cha4RTQa2tp
         1gBNneYlxeTQsWFA7aTHTkaxtzpw4Ztji2XjQCzitxHZN6UZtm1AkljkVgwbc8ZYC22a
         LmkA==
X-Forwarded-Encrypted: i=1; AFNElJ/ioU623tybjdGoDz+4gArDnaVAbegKp8Tk4kj3U7W7kD2MCWN0ocOmUdwssl72ToLhm4p8iiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtpEEMtbcmIh0DXqhFols+XVY2adHktL5pev9fmmj0GfgoXyC
	DuJPoL4yfXaboY0vuOtPQE3st0dcT14B2mgJFsn09d0asmzNCO+GZuWu
X-Gm-Gg: Acq92OGtMNxlZIIh3lW8ZqlSsdulPmp8GWtSyGWbBec09OA/3aZ7dBkU6P0MGFfWp85
	FwGQUtQ9e+MNjOaLPHLun1tC/DHbplAxQB9S1ibtQkqGDGSDqXROEebNdmvLS7uBffHPmNgRKOT
	kyU3Gz5qiTD6Gs+Z3tU7O/TjxQDVu56FHDSx2B+RCGn4Wvw3OE79nGAqaom7/TPwMpRB0Qc1N+y
	CP1Ms/YZ4QXtznkbHz+FMLJOjUba7lqIOAdxG3LUruzISnQad02E2/ilCcLeLoe9kCIks1xojyY
	1lXJ0AzFyN8xtDZdEaFXHJfs7EjOX/97DmyEWKGlYJ7lWT32rZK7/dNO76FFjPsBk+tr6vywvlv
	pVpxONTAUqFuP+sLbSh9gzR7W2oTpPI/Fef30/Abc0cE0rSYEAUUPOjigLWZd1/ihBC+lMbOX7Q
	4qXUMnhMpGlAy7E23HUdDh9r/SvadMrR3MEukrifJqElektm152FhUeOeu8ORGcMKAgg==
X-Received: by 2002:a05:7301:5f12:b0:304:2e00:5fb5 with SMTP id 5a478bee46e88-3077af0e98dmr6535455eec.3.1780847078197;
        Sun, 07 Jun 2026 08:44:38 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30777ecf9e9sm8811765eec.28.2026.06.07.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 08:44:37 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: timur@kernel.org,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] net: qualcomm: emac: replace strcpy() with strscpy()
Date: Sun,  7 Jun 2026 15:44:23 +0000
Message-Id: <20260607154423.67146-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296254-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:timur@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:dennylin0707@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dennylin0707@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennylin0707@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1C3E650E5C

Replace strcpy() with strscpy() in emac_get_strings().

strscpy() is the preferred string copy helper in the kernel and
provides better bounds checking semantics.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/net/ethernet/qualcomm/emac/emac-ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
index f502db9cdea9..ffc300641aac 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
@@ -95,7 +95,7 @@ static void emac_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_PRIV_FLAGS:
-		strcpy(data, "single-pause-mode");
+		strscpy(data, "single-pause-mode", ETH_GSTRING_LEN);
 		break;
 
 	case ETH_SS_STATS:
-- 
2.34.1


