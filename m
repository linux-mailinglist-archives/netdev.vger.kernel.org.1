Return-Path: <netdev+bounces-253231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA7ED42UdmnlSQEAu9opvQ
	(envelope-from <netdev+bounces-253231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:09:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FAC829FA
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B56473015459
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DAA30DED5;
	Sun, 25 Jan 2026 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYppz4s/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9002824BD
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378906; cv=none; b=oHUoJXmCGc7EvZimwqxDPr1iIyTM8IVJbTGNp1CiCsc0E7KmpVagzj72FNTUPTiBajjMpPzLc1CW0hv35WDftd1Eg+KIaHyci9fk4kQ95T4MpwNO7BV9YDXuMomy9QnqhsVzjCxBuxq/106USHs6eZcEYQXNYI/PgrjWi36AkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378906; c=relaxed/simple;
	bh=WR5uq6D5CL2+zYPX3ErQbINKVuF54ruQFnm911fVzGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwK1VN3lZt3svDgte0mWTUP5iPx1L7PhkXaJkTdy/dIIE5W2oubZdYLwMEhSNeYa1Cf2V/tdTcI1lEyj2+2p6C1y0dIK0EFKXttm3gD+rmbwE1AnNqrLwGuUgdupcEUwjX4e0WIl+OW4y3x1lZsWZWyM5ni2phoifxRFSiuSFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYppz4s/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-352e2c59264so2778409a91.0
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 14:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769378904; x=1769983704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3EJ6TxN7ZDz04YTrVqZvmwk994KH4aI44usL/+rv9E=;
        b=WYppz4s/OEmLIljPruiSeSOS9n2nTRmwCCaRnLHjPfZlXgYrUBdZesbMFOZS0nQFrP
         6ugnkOVCrIiyvR8cCRB/bR2Eql5aFhT/qQfPZTVOM15QtbboslPGr/kEe8oFU0ao/aV8
         8g1rNmODb4FFNl6yEPbC7WSvfpErrWjO6jqfNrLfkkOuYgKA4ZmNj/Atyvtzwe4Bk7gN
         kwXa93l4Og0yNPBY32IXyBvWeAmUFXkseAcNySmy7LE1awGL6UsS2B4urHKMZBgdT8Qt
         y3tYe4S1QXWANvzQN71by1kg1/y529rRuklvhfiSN2jlj7ic4Xsh+I1YukGN5ZEcm2RB
         aAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769378904; x=1769983704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g3EJ6TxN7ZDz04YTrVqZvmwk994KH4aI44usL/+rv9E=;
        b=PDoEBKMFQ4rvEMCOGYf0sdiprjBUyI6TZmcDVuVAF5+v/MBMe1lgpFZh6zJi4GbLQN
         WOcSJGBXgUlEIR2AlZ0f1nhrhnoW+akgxBRV2hiHizHzRScWhaiphWX1mHXqqirhkhww
         bL7hy0C1FBv6BJYhrUPReLzGSsB4PxhfhD5SwdfASFwvJ2E9WxtKV582Elw0w4qrxW2Y
         Iet05aGdl8nqbustozImATqQ1ifm92YbC+sOjE8keHnqkwS7Fp6RnTx9pPkHWvdDb1n9
         5R3r5uC0kVqaNjcIoLwgAmoeR2UlKrsZw6iO4/lDlrQpAaWdamnwU3j0bFn5QduHUiZS
         gLww==
X-Gm-Message-State: AOJu0YyeoIhB/juIR+I1YIZELQaYUNeYZjysHsaIyS7slAYNpvJfpeTR
	Ni8dCq/97bPFhwxhIo72tyXW+R7kMqjbirc2XUSB/qxG2EnnhbydXe0TIvG1mA==
X-Gm-Gg: AZuq6aI+pHYe8ZbcfJhg27+dcKWj33mnXWef6lTPN1N2l/4cbGuPXDkv7p/zECf2nxo
	fdXZhiBehc2DVxAF0kcuzMB3ZkEvgeU8tBSqaNOt35OwkjzyrY2YM6f0sLlFyZbAlzHPLtg+rw4
	Qm/e6y5244scG2c+/O1ewAdJYi/4v2GGAEQFhLM/4Fk8XJjUMg8Ag6lyhCfeDt8exbRycvyXGX2
	cAgJg7f9XrPLhI9o54lt/0P23LyRzDGRCpLdamGkX3nj6zzWGo+yuM4GTDlog9jagzPNU2WuyKk
	XvwLRjSm1yT3zOf6HuS58/OYsVVRlXeirzPEdi4D3D1m2WcZ63opc87oVsttwe/rQSEEA5GMwTL
	zjR8ZW7QUndOAdpx7Q0uUE27C4ba0SzfrpunZrsBiQpEpNe6hPrV1wiuC0vqT2FD4VZ8A3kWimD
	tJ+v10ajxIZZROfkviCNl0KTRpf/XUE93ZTkA3cuyBvO/cDpkRqdMxBW3zaeL5
X-Received: by 2002:a17:90b:45:b0:349:3fe8:e7df with SMTP id 98e67ed59e1d1-353c4167b7bmr2107663a91.22.1769378903982;
        Sun, 25 Jan 2026 14:08:23 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e60fsm7651286b3a.48.2026.01.25.14.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:08:23 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] u64_stats: Allow u64_stats_add() to accept s64
Date: Mon, 26 Jan 2026 06:07:49 +0800
Message-ID: <20260125220753.3984326-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125220753.3984326-1-mmyangfl@gmail.com>
References: <20260125220753.3984326-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253231-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94FAC829FA
X-Rspamd-Action: no action

The current u64_stats_add() accepts only unsigned long, which makes no
sense as u64_stats_set() accepts u64 already, and causes unnecessary
narrowing on 32-bit architectures.

Moreover, since there's no u64_stats_sub(), users may be tempted to
reuse it for decrements, which already happened on nft_counter_reset()
in net/netfilter/nft_counter.c .

Change to s64 to allow both positive and negative values.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/u64_stats_sync.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 457879938fc1..e77f2b30bac7 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -84,7 +84,7 @@ static inline void u64_stats_set(u64_stats_t *p, u64 val)
 	local64_set(&p->v, val);
 }
 
-static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
+static inline void u64_stats_add(u64_stats_t *p, s64 val)
 {
 	local64_add(val, &p->v);
 }
@@ -125,7 +125,7 @@ static inline void u64_stats_set(u64_stats_t *p, u64 val)
 	p->v = val;
 }
 
-static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
+static inline void u64_stats_add(u64_stats_t *p, s64 val)
 {
 	p->v += val;
 }
-- 
2.51.0


