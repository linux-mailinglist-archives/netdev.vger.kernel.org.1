Return-Path: <netdev+bounces-302372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5vh0NbtjQGoVfQkAu9opvQ
	(envelope-from <netdev+bounces-302372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 01:58:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B2E6D2D6C
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 01:58:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ml71Fd3d;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302372-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302372-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D6CA3016CB1
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336273803D0;
	Sat, 27 Jun 2026 23:58:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5935C181
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 23:58:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782604726; cv=none; b=P6GuP64VXBRREg4sib/CWlBLuylbJDUAaP6BuIchuSsd8hM2d0dffdaRB7sF2JWMth0xtriOBPry/Gxz5R3/oqbPhgvgaL6YoydrGOzsdZ50ePmlsFG76XWAeCNXSvNFdPySnQZ9WEV/yiI6NXbW7bNESn0+tQEv+MURQB4lUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782604726; c=relaxed/simple;
	bh=t1c6ZkEqo/5nbeX5Y37JbyRiMyH/PLMuUEC6tLqOZMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSTALFV+XWSMBnZOD/uzVBsYjY4MN8zmUAu0lfwI/H2wR1rx94MZW/hWyL0nPA+a+rkvTEIz5QpTXP7eua1z6P1AwD+mEc856JGoAPXE7P1uK9nx0oDdU9MC2jo19wK25G199e6JnFYtPbmFgtg0RIJku8tocpx+mS+cXIe2jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml71Fd3d; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-470174001a0so592161f8f.0
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 16:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782604723; x=1783209523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=skDXyZAJq24/qIOZkzrlcPyP6eRzwfs+LL2sC9Z2FWs=;
        b=Ml71Fd3duV1vI6zM10YZHcg6HyOIuenZTSsfAoDutffzyyGHUyzVsdOt0W+RfAglBa
         E1ER2BeOLkAEVCG8I2p2hugupwPqVqYUjS8BrjTyMSL4Z60J+AsrlvzbqXHjS8nXrfcM
         ANF7zRqKWIUmfWi4SeH1AgjK9a0q1dGSgHn700ULmNSFaGU9zdWfhs3KLyZhaCgRct73
         6HNRqRoHtqytA5KixJOmpVlS3k5o8ZjjDVsJTABIPIayhJQ9y6dg1gPALi9JUDRqfNAb
         BW3zJPSCTC3RqQiJJ6Hb60p0symHMSP9KU12RyraBqRCaiUore1VE0f3TbepDuGqhBuH
         J+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782604723; x=1783209523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skDXyZAJq24/qIOZkzrlcPyP6eRzwfs+LL2sC9Z2FWs=;
        b=lhhyd+TC18c80PhQ0k/sKBORlrg5pu7bOSfRbOBG4CSKs7hZAKmf+tGnisU9pxztlR
         WXPcmgQeLU1tkg+qvLFVoPpLKRpPIqrz1TmU/HmLNsOAHoK05vhqvfoHwwXz55f49+yg
         T1lzWpxiY328r/Z2vltr0GKNPgCdX5EdJLx+Eeqh/JrG6OaU2kP/xv0o+tCDLvse3VF5
         3BAi6meWPk6Qp1UcWWhanKk2sDgCUvu94/VQg0RiOiRUj5fDcNwtxcBY9WEpcy4P4deS
         pGs9PotQFbokHKmW9YfVXZC64ftjfbBKVkqTx2j4FsJl4j8RBMyefLGTyJGuvKEGlL6t
         qYew==
X-Forwarded-Encrypted: i=1; AHgh+RrZn2eKGt8LpCrfuz+8EKxGdX6pSsThduoa+VHQLhg+/Dz4ny7vyP2SIuElKYTTPBeRJY7rMcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAmbZlmvMQYGYMUzKC/1LHeXekpvmIcgph8ugVX1KvOwUA+2c
	DBmqZygDYSlxhSDckQjF0gMxMwpLBOECXB9PvgJnFF07xGgNC78R1wiW
X-Gm-Gg: AfdE7cksQYWFtykJeFiuR4AOqYx4G66Q/IIZmfhETqnMOVfN6SOCIMjdFNUyyv1a6OT
	cfoYKgiuH0096FvaMllAgnR4Z1eiCTH03YV5KNiQ7C8poi7fNSzrm+/DYi1hGUii2Jjy2fz7OCK
	T4+cqjGgp+r1Kt++RCSw7zKWhSG4/FpTW9PXPnSLPm8pwXSac9TFinR51/rilhfF1VVCEdtbWTy
	eMF5DAjevcpHqRjUixBkMIwj83P36isfaZJBjJ4mZOIubJSB0YSAttvOF7/6f1phLOqpo50kEJI
	CE+WV+66FnuJSpN5fzPqZlqTaCAGdiJoYdR4XE3XQIl1GbeEnAnt/RIBsv7RYKq3AU+x3K1LBu0
	5Q9Ersw3+O64mTv3KUWzt3gh0crSkqrMWB36uPFdVFwZNfKjEpUVaEe9r9WU7hSpgu+yB5D0U9i
	2npmNZOSFkHqbQlmWvHAtuF9IX69c7hNO5S16R
X-Received: by 2002:a05:6000:470b:b0:46d:28a7:3ce7 with SMTP id ffacd0b85a97d-46dbed35effmr17819314f8f.7.1782604722940;
        Sat, 27 Jun 2026 16:58:42 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm8348957f8f.23.2026.06.27.16.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 16:58:41 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net] ieee802154: hwsim: free PIB after unregistering hardware
Date: Sun, 28 Jun 2026 01:58:05 +0200
Message-ID: <20260627235805.17310-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302372-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:miquel.raynal@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:alexaring@gmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,4707bb8a43a42fca2b97];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35B2E6D2D6C

hwsim_del() queues the currently published PIB for RCU freeing before
unregistering the hardware. The unregister path can still invoke driver
callbacks, including set_promiscuous_mode(), after that grace period has
started. A callback can consequently dereference the freed PIB.

Unregister the hardware first, then fetch and free the final PIB. This also
handles a PIB replacement performed by a callback during unregister.

Fixes: 1c9f4a3fce77 ("ieee802154: hwsim: fix rcu handling")
Reported-by: syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4707bb8a43a42fca2b97
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 6daa0f198..2a2d8a9eb 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -1004,12 +1004,11 @@ static void hwsim_del(struct hwsim_phy *phy)
 		list_del_rcu(&e->list);
 		hwsim_free_edge(e);
 	}
-	pib = rcu_dereference(phy->pib);
 	rcu_read_unlock();
 
-	kfree_rcu(pib, rcu);
-
 	ieee802154_unregister_hw(phy->hw);
+	pib = rcu_dereference_protected(phy->pib, 1);
+	kfree_rcu(pib, rcu);
 	ieee802154_free_hw(phy->hw);
 }
 
-- 
2.54.0


