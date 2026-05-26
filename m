Return-Path: <netdev+bounces-291486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AYrGPzqFGo+RQcAu9opvQ
	(envelope-from <netdev+bounces-291486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 02:36:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24405CF491
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 02:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CFBC30262F0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 00:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A275274B37;
	Tue, 26 May 2026 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9AIeJka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C782765E2
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755746; cv=none; b=EDmyMPYBCSmBM1Q/d3rKfKxlvakQATk3LAs30iG57NfSPwy/w4UaIJ4kgdb/0kDF4K9864UiyB2ytCR6l7+zmeumudYpXHfrm68kQxNjPILPhf19TX8yN0K2J/Yq7TVgNeI5Sb2KLcLLQ4Aie8LQs4Dilk7Wz4x+3pdFdXJXYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755746; c=relaxed/simple;
	bh=aI73dLAsoMnIz2OoRYSyNZeZBTVcQgWYmXKRdLg8hGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAg9+mC5+rrE+CJwCpvo2McEdB0OaMTafKeD9cTptJuvrVkeGSSy6cwDAW8fsFbqpxaYZDlsS2ciyYkKMYz6Q3jKniWKpZlGpvocwAUQBNhwPQteNhCAgnGsN6A4ab7fitHgfe96xG9zWnVio+93yMIw4Pr10+8VqvZZBErPPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9AIeJka; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5751a9020faso7539730e0c.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779755743; x=1780360543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBgWuooGCwcYgQ+uND+oHD3Fi2ceyxPTaalSlSWEF5A=;
        b=Y9AIeJkaDSlZBfKPPfNoVDKTiS0PN8NGFY8+O915yNrpd319YFvHQTSn0d3duhIWAD
         ptcE4C8ks+HFox+IgxdqhuTLWKrhwFZjF4eK+4dKlyEf4PlsYVLuVVItFsxyiMby7bqS
         XqXbv4QD2BkK6jqTtZLLX2WufPpVJ1OZQXOoNKPIV6hm2ltvD/uY6XiZg74AMfI7i+53
         mZdUZjTIapI3ULQLxbckjJKfPGVFZ1UE02Fd7s/JJhgew//5PMXJn4DRYdBBjKHHq9tI
         VdN+JmLb8QyS32zYvnq6SsHZY9BeJTsGUUnRc5FsF+Dlg7IFPhiUyVjwHkHdMUaNPqdR
         y9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779755743; x=1780360543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xBgWuooGCwcYgQ+uND+oHD3Fi2ceyxPTaalSlSWEF5A=;
        b=U0uaMFZCsnkJL9t+bIzoUQWSuJulvaplzANJ0B/L4ZIZO6YgG9DQMxXlwtRdaalHp3
         9sIq4Jibj5FaQgLARyVuauDzRXcU/eshWieQ7JLHWeYTJf5inoWAi3yL5jStBsde6b2i
         Ne9c1x7DvrERbdHUNIOpje3H6q1CTv5gPJz5MobHAU+mnCtLerMHu3ziRf+fXm+71ltE
         SCOrrdgxCs7PdUHUcadEOkmFgUbhKAfMbKfTWd4Xygbz9lbRjq/ZZ6S62IN/SbBekZpk
         6SZdofhYUwjxC88naBnk9BAPm9gt3IzqABp/CuwvEgxuTYH4cP95DqO6r85Jfy5pWW6t
         seMw==
X-Gm-Message-State: AOJu0Yxvi2Zb4xAawN7ubDfcD9pX29//eIcGjGWv/sHdMYHWHJBj1bhu
	Q6122aqqq4HD61sXQpsBrQj0Vj7JMh8sfoXfm+wCoIGqc2L2rApZ0szNF4sGoqSKwaA=
X-Gm-Gg: Acq92OGIsCC40S6ddOOqPXYxv202DotyNceDG7yU9Q9DyTVtVVgWetexhHfqfFb0UXc
	shnEuw7ewbouTCM5Xf0Jb2xg68YW+/MsQ7Ii+za00W9G2kKl23ARyvzTgLl6Y27UNLxhAZlyTdX
	Yt5CT0rKRMOW7iIHCtL1CpIe1wnRmUCkgl//q6qUFAClwGoHjY8cvIMcaOwEi+DnQDf9MTh7XPv
	Rj5T/zVboY9mBhFXfqLO+z6kgyh6MDN41okx86i2jwqv9HFe9digTNqv1l83G2ZkVkG0HaXvyou
	IupbniBbzsI8YgL5OsaGABYodWg6bu1GgTeEDhU+o2j1nEaiBt0R2jKAlbl/L5JUM51JynZUraR
	OUaD3ElhKMEtEzEVfjY2sPQBujZBd1Uf4Xo9wtQoRK1iB0+vZHXuYmoBfbZAYh+IQ00Zugd4DZG
	mIhl0obszMPENFrI5OPNLu1R8T34YVdEpQiO572GVYxp6n0ZIEu3mivRnT20uF9oWzlusOfTxUs
	qDZOiT/5IyE389jFxg3kXepHRXGWtZCA1tL5VXO8MwVG8AG90izOg==
X-Received: by 2002:a05:6122:e250:b0:56d:2ca7:fbc3 with SMTP id 71dfb90a1353d-5865fc0355cmr8472321e0c.5.1779755743551;
        Mon, 25 May 2026 17:35:43 -0700 (PDT)
Received: from sekiura-Standard-PC-i440FX-PIIX-1996.. ([186.122.244.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f791f719sm13955006e0c.11.2026.05.25.17.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 17:35:43 -0700 (PDT)
From: Takao Sato <takaosato1997@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	w@1wt.eu,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	chopps@chopps.org,
	pfalcato@suse.de,
	stable@vger.kernel.org,
	Takao Sato <takaosato1997@gmail.com>
Subject: [PATCH net v4] xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()
Date: Mon, 25 May 2026 21:35:37 -0300
Message-ID: <20260526003537.998848-1-takaosato1997@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522142504.1394864-1-takaosato1997@gmail.com>
References: <20260522142504.1394864-1-takaosato1997@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,1wt.eu,davemloft.net,gondor.apana.org.au,chopps.org,suse.de,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291486-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takaosato1997@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B24405CF491
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptfs_consume_frags() transfers paged fragments from one socket buffer
to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
the same class of bug that was fixed in skb_try_coalesce() for
CVE-2026-46300: when fragments backed by read-only page-cache pages are
merged, the marker indicating their shared nature must be preserved so
that ESP can decide correctly whether in-place encryption is safe.

Apply the same two-line fix used in skb_try_coalesce() to
iptfs_consume_frags().

Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Takao Sato <takaosato1997@gmail.com>
---
Changes since v3:
- Corrected Cc: stable tag from "# 6.8+" to "# 6.14+". IPTFS was
  introduced in v6.14, so earlier stable branches do not need this
  fix. Pointed out by Pedro Falcato.

Changes since v2:
- Removed security impact paragraph from commit message as requested
  by Steffen Klassert.

 net/xfrm/xfrm_iptfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e5..4db85e158 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2168,6 +2168,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
	       sizeof(fromi->frags[0]) * fromi->nr_frags);
	toi->nr_frags += fromi->nr_frags;
+	if (fromi->nr_frags)
+		toi->flags |= fromi->flags & SKBFL_SHARED_FRAG;
	fromi->nr_frags = 0;
	from->data_len = 0;
	from->len = 0;
-- 
2.43.0

