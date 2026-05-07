Return-Path: <netdev+bounces-285518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGyhN/QG/WlLWwAAu9opvQ
	(envelope-from <netdev+bounces-285518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:41:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BBB4EF6BB
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F03C301A42E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B534678E;
	Thu,  7 May 2026 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA6L877h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E06344DAC
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778190066; cv=none; b=KKJVfG8HnUQB/vCBkkn2/ynCRfhCtBFuDfduAkj4I3mSCTNckVTeDrE1nFaWnhmzAG0Tz6I3kJZskGjzJkD7Bzso9nXhHLcEyIjYkkb9Ydza3mkPzP9oCBxolPgDe/UWrUKBsnBrwOMBVIhGJWZPwSxAMlCGNOL/JrCZ2A+Oub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778190066; c=relaxed/simple;
	bh=l4Cwqf1WV1AVTTFPvB83ZJLI9IpA+uYzFu+EOnoywQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iTp05R0DnoXNA4J0dmHVp99VISiqtpmHiWke+/N47yEaRUz2L3Kfd7ZRCHHYlMhnF89RtMDZPxlAn6q45D8/xCqaTXev6iycbo0/V6elUx+kD9+JoE80LPQIZVnqIu65bEVixOLykr9Q37e/j8YRyu741UA81i0ckWs/97g/I54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XA6L877h; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-83659d38e38so596318b3a.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778190064; x=1778794864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNSrsGH5CXJKVq1mz+bpnFTmvM9AgPiDCo4M5eglpto=;
        b=XA6L877ht2SYdIkZAZMgfcCni5wdLIB3dNMoff3bVk2opeSKpr/Hko19MzM/MkXi08
         YdfGOOuzxb/qCsUpt5/nT7jFybEDPkdYkqyddJTnc1yYd0Cu2QTE7LaZJrpwaleKTfFR
         tpVBMZN9g/OtWR1T1Sqd6svxUlPpnQ3oM2Lx1xC4ozQClaWYzBGg7tSgbmAc9S9xPbIA
         Vmv4Req8ac0uG51XedVVfuWp9n1f9hhmEZxWWM89LgCbLedgXMiif8Wa4QIgczzuFxH5
         hk3YV0OLm3WaSmhW5SQJfTBFl3Nrth4P+2YjtO/JKusnTUVKPUX5JTO7ctSjLqRzdpQv
         UQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778190064; x=1778794864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNSrsGH5CXJKVq1mz+bpnFTmvM9AgPiDCo4M5eglpto=;
        b=RcFHY6B8DEYoXZJhMLq3ln9/V7yVX9egr/OuX1MCI813UjCqgQTuO0WQKoR50AJMWn
         3mOejFEqs3qUd+YhDcl6cGQhZJml4huQk64TW6G3RnYZ9ThFBrGCJlQq70iqtpRoZkn5
         GAzCx/kFjmUL5BBh/aLXQau0MfJpSfUxwz9svuBUoC3eASaPZDounyY7vT25141oYyiK
         J8ww16u7GbC7z69BTdf7jVYUPtLZSELgqKFZq6Vhh2QJRfKEbhg5/rH44YdOaDUV5+WL
         0p9EcmtN+GMJYqnILBAfitE1UJPeqmn3i/jlTQnLrA1By+xVepQiS5MyztrZ0/D8UqTI
         n9ig==
X-Gm-Message-State: AOJu0YyjN4bqh+MsVBuYO0cU2lJ8ZY7j02TuBqlJRlN+AFSeMmk+E3uU
	25mOpEN4o0SfyvT2YdwTQlrOePs/xe40GMcDuCorwKPvEMTNWlW1JKKEmbNyJTpN
X-Gm-Gg: AeBDietk4u96ia2PgC6AFEHmX3hAVsM2Z0KQvZFxrDAMO3xC/bAYHXVkqbsyLRD5aR2
	SKIf+FjMCZlHF/MXZggoQc9xYrFB0fUnSQUmzcixghnKMOsmF3+lTD0J/u3dOnA/fRRIoHXgpH9
	nozZXHFpj74Exjj7gohGzUJmf97WXZqFhzjNkW9hzUv20lrLRlKJGDnKLc2dF9lgxH/80ZMsj/D
	TVYzxezJkha8jofwiuTFgUaXvWsHexW/JhgUBSNYWvdP931jJMCTVH2FkvZaJNaJu10RY4C8grZ
	miFJGE8vdiQpKQBeczKsiS50qV9+Ffv5Pru8SnnIWBi2gjdTZoMmQh3ULI76DnHuhRYLErueCGq
	EhPk/cb588m8fnIOMsCkkgjlPTRV/bCCLum7FOu0d6F4kdEQTg5Z009FxEOE5qAOnUplQAJ7V+0
	nfQjCI7D0QwjVkrHLjpp7Ab0fi/9qtwUidiQ0CVYJBsIiIQHAM8zjAzR3fNnApnw==
X-Received: by 2002:a05:6a00:1407:b0:837:eaa9:381f with SMTP id d2e1a72fcca58-83a57c7782dmr9400352b3a.0.1778190064259;
        Thu, 07 May 2026 14:41:04 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.247.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d38ab5sm12029408b3a.26.2026.05.07.14.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 14:41:03 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mention the convention for .ndo_setup_tc()
Date: Fri,  8 May 2026 05:40:51 +0800
Message-ID: <20260507214054.2539790-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62BBB4EF6BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285518-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

qdisc_offload_dump_helper(), originated from commit 602f3baf2218
("net_sch: red: Add offload ability to RED qdisc"), is designed to that

    Whether RED is being offloaded is being determined every time dump
    action is being called because parent change of this qdisc could
    change its offload state but doesn't require any RED function to be
    called.

and returning -EOPNOTSUPP (for dump queries) does not mean "I don't have
any statistics", but "I don't offload this qdisc anymore". At least two
existing drivers did it wrong, so it is worth mentioning.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/netdevice.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 744ffa243501..b18a6d917771 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1223,6 +1223,12 @@ struct netdev_net_notifier {
  *	tx queues stopped. This allows the netdevice to perform queue
  *	management safely.
  *
+ *	NB: Returning -EOPNOTSUPP for whatever commands means "this qdisc is not
+ *	offloaded (anymore, offloading may have silently stopped)", and the
+ *	offloading flag is cleared. This is especially true for dump queries
+ *	(e.g. TC_*_STATS commands). If the underlying device does not report any
+ *	statistics but is still offloading, return 0 instead.
+ *
  *	Fiber Channel over Ethernet (FCoE) offload functions.
  * int (*ndo_fcoe_enable)(struct net_device *dev);
  *	Called when the FCoE protocol stack wants to start using LLD for FCoE
-- 
2.53.0


