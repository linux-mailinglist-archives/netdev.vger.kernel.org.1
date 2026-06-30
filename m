Return-Path: <netdev+bounces-303369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C+0/G6AyRGq/qQoAu9opvQ
	(envelope-from <netdev+bounces-303369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:18:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DF96E8147
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:18:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LbxG12rr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303369-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303369-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7526A3046CFD
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2182D594F;
	Tue, 30 Jun 2026 21:18:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57855270EC1
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 21:18:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854302; cv=none; b=KAzKNLorcvMJlklPBpx6KG5iUwV9/MP2VQ+rfg94FT8wCNYTjnZBXzMhjTwE5xqHENWIX7zlLi798/n5dOqGaT1tyV5cGf/IKeAgDy+4fYvZI65QQLJOJVASzPtpIQzx7eYaEUxv55J1N8dsgn5xdsbJ+kr6Shx7rFmCKOMfCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854302; c=relaxed/simple;
	bh=blmSz0ucFYiG8IMVfZLdaXb020QBlMaQczvCK7E15mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uriLH0jw+bepYY2ukUN2a5/DUYcPbdngFUq6v6AO020gUE9RCYsIk/gXkPqPeOW7rXmUnqEf9LNgqLwLwJCOMwOFxd5qLLkixQiAQcPI0DDRUYObM5+7uWrr+KZDaWX9jbNAF1XJvZE+v5G7n++44Ky/dyg37zFy3cCdnxo/ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbxG12rr; arc=none smtp.client-ip=209.85.128.172
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80d33d13a23so30128407b3.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782854300; x=1783459100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2poGPPDKuIRln5tPnA3S6uNyhm8S9MHlvQPEbWhmm6U=;
        b=LbxG12rr4PsUtTJ6Ojiajta+pwvBJYbTxn7OUS/ZnAF+3aw79w81fUp0c2Pmv6BofN
         vJrBYwYW393ImQXBwlfR42xMIi6RGxiwwJdR7ePdAtZrp+ewE7nFlSZ5T8LJpSpx3Z5f
         ZVuNS4IhUtS3bVUlENg+aw0AgSLfJgGxEwARhJBg8EX+JWG66/qxe2xZCdtkrw+Uh3ek
         pd1qbAWTaCOIQii9kPB/yHuVp2fxfrRw3jaoGPPBhB2Okn2zamhXL0cPlD583OGq3K4d
         CyFnSuK6BkA4kRJadHNKh2SZhwJytLcVwh8tRcJBCNMUlK3NCn/yU9kKWB1qvUWk0UyC
         kqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854300; x=1783459100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2poGPPDKuIRln5tPnA3S6uNyhm8S9MHlvQPEbWhmm6U=;
        b=MS4/jyPlrOLQPKAiFHt3khZe9cTUt+Xp1yKisVyHBKu/Ne6Auntkr6IjBplguazTBD
         mCdWnsZ258XGe69yuLiqV93w2rRtwVbRfgaK5CpEIYi3N6eYMiIIcjA5+gLUVeGUVw8r
         x81hvkdQFHVHEOCVj8TyhUU30yt7rrmxFtwh+n/DtJ/oNSxNGZdrvxIdoMGjELhnByjw
         GviYbNMnmtF2VXJWCjSOGwYinYT4LGZ3ZpOLCw0qzKBRCManphl5s2H3wp4ClgLKNo+c
         iPmfesiAl7q8+eLMENwVLwQZlZllo4qel8t4It2996MUsPe4BafxyPgtlaf/cEwR9x5y
         Urdw==
X-Forwarded-Encrypted: i=1; AHgh+Rpji0gGgQ6pmQvHyvdzL17ds2vSTYhyUKsrsphF2CD6X68W+f/D8kPDz1X0+5/bq3WNBI2SUiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0lSAPJwHdvCEom5eyDiEH/+0usG1a+ugpL9DNclhrYGuqtza3
	w09yskkiNRw8huNxAxABoS+zzm4C0mjil3hPu+yDnsmY0AcKKmfyF2Dh
X-Gm-Gg: AfdE7cm+CzbyhHTp0A+7w76NhXSFRpVy1bY+/nsEL1weyG95tjYgihA1uxgav9AotVw
	Kj07jEbLekM5EUHv8hFjSZWnHopXZwAwLBbeahKTtlvnKlKtE63juIwQhyBn3FOZ2TBUEDCWoCH
	1yj6+3upXyPquAEo/0/tSizk0cgQhquqTWmCrQX8FxfH+8krVNYWHpB7zXaiNYMrb20CvBpgM3w
	4DmHDgG0EgHjdkcr5TSJ+ajryDHwFlULLFMtMV9yu8fryG1wGinyJvYvpahuoRaCNFouXsdIpsC
	cG2MZtZxDW+qDKAeeXWusMVvAWWg/0tS+P5xFkJ/GALxN+2stP9bejF1JmGjHCBTcTUXFczoTcE
	fSoN/HS6TeA1bIBfEzbtbjTUWzm+asSMUvEonhfuQRQ5M28B5iYQVT0+mddF28SeVyYOVaVoawC
	vbU1Vs9F8A7EHNZCRYKy/eF92c6Q==
X-Received: by 2002:a05:690c:9c09:b0:80c:85c6:898f with SMTP id 00721157ae682-81204145786mr20454527b3.62.1782854300375;
        Tue, 30 Jun 2026 14:18:20 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8128ce56f3fsm29517b3.27.2026.06.30.14.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:18:20 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net] mac802154: wait for RCU readers when removing interfaces
Date: Tue, 30 Jun 2026 23:18:08 +0200
Message-ID: <20260630211808.50440-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.55.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303369-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:miquel.raynal@bootlin.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:marcel@holtmann.org,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:alexaring@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,holtmann.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,36256deb69a588e9290e];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07DF96E8147

Queue wake, stop, and disable paths walk local->interfaces under RCU.
The bulk hardware teardown path removes entries with list_del() and
immediately unregisters their netdevices, so an asynchronous transmit
completion can follow a poisoned list node in ieee802154_wake_queue().

Match ieee802154_if_remove(): use list_del_rcu() and wait for existing
readers before unregistering each interface.

Fixes: 592dfbfc72f5 ("mac820154: move interface unregistration into iface")
Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=36256deb69a588e9290e
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 net/mac802154/iface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 000be60d9580..73d82a015184 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -703,7 +703,8 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-		list_del(&sdata->list);
+		list_del_rcu(&sdata->list);
+		synchronize_rcu();
 
 		unregister_netdevice(sdata->dev);
 	}
-- 
2.55.0


