Return-Path: <netdev+bounces-257280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDQtOvHYhGlo5gMAu9opvQ
	(envelope-from <netdev+bounces-257280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:52:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A6EF636C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CF6C3001CE6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16B13009E1;
	Thu,  5 Feb 2026 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD/ao6iz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910AD3002D1
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313949; cv=none; b=svBvNoOV1jRcqUgdtx2wSKpCb8+7QY9ND6zc22eeiSs46BAlkPvz/b7OFihRjp3EdAg252QUNJGqqwuSfsSRbu7WS6NuOTlNBDyeXEkOI3GJ2BbsZCetqkrKzbpGZjbQ7GwNM0XMOlrWMq06PLfaS0DHZZw148Jr3oZanFpkqhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313949; c=relaxed/simple;
	bh=vxYkDrFAaTZJWu3rKXPogOp6rpdMDeIlZCzD1sWmeUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFAE0GhcMWjhuWYmNAE3blJNHe+JZgwEOu9r13tTjdTQj2BTmBBWv7pdLyplBi7P8X49yKQilcBV0MWT9Mcv/PcHtiyzMWlimcWqeyQJK8dCB9cstCQ2qARThrA5T7YIfoBbRjbVR4Cp7pD/aReRTDqaUHj+ksRilRLvNXKWIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD/ao6iz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso665557a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 09:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770313949; x=1770918749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=207A8puoH0ftYtzBLpugjXhMAo56KEvTEcSjW91zf/4=;
        b=LD/ao6izV3NXLFgJxVrWNjeG+u0nciLAq56jiu5cMnIAEO+3LYEDEeqXJU0c3c9vAL
         X9s/AD0UAMFSC+xd23vwJfkfeg0julH+jFgX5BPKLKWSc26yV6Cd0HGLLujf45bm6ypK
         gFMksGL3u4+aGq7BoVFTgGabrgtlLGz1QUI9sRnnlkVsM9o/BKoyfaHr5Z/fKujUy/KD
         GgOGb2n9OJycE5+x9QPm4HfO0Ttz4U5lsFhJAa1ojFgewZ6vJtY4CI/nn/S61WaZqcpo
         UEH5jWhr/WXfokf+fOtd4aGWVZwiW6hTh6cvLimVrRtN/2tadOUhLsh4duckIvu/p4Z6
         Z+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313949; x=1770918749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=207A8puoH0ftYtzBLpugjXhMAo56KEvTEcSjW91zf/4=;
        b=HRlEpAzTIcybrKvX/+tf6i7tkMxhITBpwq7iJv7aanjfCHVcQosQFwHA2PuTSpCrBh
         2nCATvPeUXUQnhrVhc4o+94onSBRrFDyDHk7OJIQWMaZz6hVDsIg0iE77VnU+GBoS/dP
         TSrx4NFkJPL+rumEueF136CxgsurjWBFutR/31sbpc2azCBcm3+q8pJQesPwFSn6QIdC
         +G+H76Tui+V+1vuZ7a2Bo+ErWHK9uhCCnHsQEHknJTAiVw0j+eXSP/2zS2bKLVUXpF+N
         oApwnuX9DcvJKP8m6MfoP1oXx3Mqi6/zupzkMT7EP6f8XF1gu8FGVOtk36WeKgGMDKlL
         dFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXftsVNfgKjf19LSd7Fce3teadErlxSB2jc/g3sX/ldTpnUL98qxIb5JlIyv7AIB3MRwsIuxVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HhFUoyevZO+cWoL+aLY91naWESf9A3PXFcy6TkkGU3EqIR21
	I87MaNe2cwxBVfLsMESwEMifZGfSzX/iFOe89DmOsBNnn0kwGeNSIUnl
X-Gm-Gg: AZuq6aLl3pA0xpeGbKGq3oDdiPaLQEAsdtbY5L7I+QFEtj+5+4fO+vv2qWdtx2TBa+z
	v+o+ZQIDNNyjUr4P/ioNrAopZDxTRgvpdQOrq1f9JLaBgXSUlSLZ1IUFoyYIlPccHOKMMIdz1yI
	n0jfg7pm/I0Fz9IJE8q2WviWOBY+8iflH0Zxpv7eh/wdYicH13ArY2Z07crRImoOh3gGRCj9/a0
	cSJt7WgTOi5jYZivDiTZH+YIdUvZ9TOn7sA5tUAhVLJLlqjdeEok6UKrezgGnePPqvPdT264iPH
	Rtg5DzqPZscsaRAamMtr4+IElWnFkIIrBMz90CdloSe6I+mn4UK2CZsoPNcEGTu3ny/ii7cGi9g
	QdR+biIMX60WppcaHZwfcA6hZ52c3SRoO6QPmE3i6IcmwPSM1KCfMBv7HjFeBZxn09ABBvn9K/m
	8nTCjCVV6UrI8O
X-Received: by 2002:a17:902:da8c:b0:2a9:db7:4467 with SMTP id d9443c01a7336-2a951643444mr862845ad.6.1770313948803;
        Thu, 05 Feb 2026 09:52:28 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:8722:5847:8ba8:5649:5c92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a6443csm136005ad.16.2026.02.05.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:52:28 -0800 (PST)
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
X-Google-Original-From: Dhyan K Prajapati <dhyaan19022009@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Dhyan K Prajapati <dhyaan19022009@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 wireless] mac80211: fix NULL pointer dereference in monitor mode
Date: Thu,  5 Feb 2026 23:22:13 +0530
Message-ID: <20260205175213.5005-1-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,sipsolutions.net];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257280-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sipsolutions.net:email]
X-Rspamd-Queue-Id: E9A6EF636C
X-Rspamd-Action: no action

Crash trace:
  RIP: iwlagn_bss_info_changed+0x19d/0x640 [iwldvm]
  Code: 49 8b 46 10 <8b> 10
  RAX: 0000000000000000 (NULL link->conf->bss)
wifi: mac80211: fix NULL pointer deref regression in link notify
Commit c57e5b974514 ("wifi: mac80211: fix WARN_ON for monitor mode on
some devices") reorganized link change notifications. This caused a
regression for hardware using IEEE80211_HW_WANT_MONITOR_VIF. In monitor
mode, link->conf->bss is uninitialized, but current logic allows these
notifications to reach driver callbacks, causing a deterministic NULL
dereference in drivers like iwldvm. Fix this by validating the BSS
context before driver notification.
Device: Intel Centrino Advanced-n 6205
Fixes: c57e5b974514 ("wifi: mac80211: fix WARN_ON for monitor mode on some devices")
Cc: stable@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Dhyan K Prajapati <dhyaan19022009@gmail.com>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b05e313c7..190222c26 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -416,6 +416,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_MONITOR:
 		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 			return;
+		if (!link->conf->bss)
+			return;
 		break;
 	default:
 		break;
-- 
2.43.0


