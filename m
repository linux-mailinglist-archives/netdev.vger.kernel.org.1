Return-Path: <netdev+bounces-256862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIeUAFnOg2kFugMAu9opvQ
	(envelope-from <netdev+bounces-256862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:55:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDBDED1DD
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CC4303AF10
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7876C37AA7F;
	Wed,  4 Feb 2026 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="D3fK0w/P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BD393DCC
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245594; cv=none; b=I6deJNqGLZgAvJkcVrWr+Qj+SsmuuZ02ynPHLhNZR+6pq/uw39ldEewWuS77gYwfhBwU2XKOKao2EK302ySJdzupke7xAOV9PM+4h14SBPiWf7hZrb60TKM5VBdWafbpdUSnZFysxjSDP7Fty2BeL7os/i2g4WcFxO2+QeWhUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245594; c=relaxed/simple;
	bh=iQWwgljwr1RRsiOig0/WfPLiZ44flSWLD6HyM4gMhNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7XuMWPcIKcEG9lQiqX4aMy8Jiy/50KjgCIQwOS/2HevsW0xWjrseWvEVObxULjOZ+qtU86azsyFKZ0FAEU5rZwaE5v1nalmAekuw+w97NiMhyTIW3SB2NAEnQXYDfXOp9tIlmGoD4dhHPwLqZAsiaOZ774bw/z20WCvTuN+k4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=D3fK0w/P; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b74f839bdfso950984eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770245593; x=1770850393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKkUU4BynVy9fquUryVqVDVgz0nkKtkxg2nD7MvFHSU=;
        b=D3fK0w/PJfSUs+CQv7RiViBujvlCfbz1XOMsiPn1GdJjSN3vZK8xEkm8rpKoPMwuHk
         1Byp8IxJnX19ZOLZOW8ytD092TtRj4m3ZR4/o/TcROfd/R7+Xgz54xexCxlJZXNT7O9J
         +MX86MS0J+RymXCCxwNrr4IwPznxD39UzQzGjYLUtAB3i+KqaBHuvEtPlrSVFJXmia7o
         XaJjmlOS03mf7d8IAcha/sLtkD/pE30RRrhGkcx4xQv0+ySZnpYFdEBzbo3m3KqPofXr
         Q1C9bgJHdcyK1HPqHbAAxpnlZpWg6jH/CxVM09lyn4bbIMX1DOqFbq62EX3O1gJK0cZB
         G6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770245593; x=1770850393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aKkUU4BynVy9fquUryVqVDVgz0nkKtkxg2nD7MvFHSU=;
        b=l6PCLNzNbj6Sane/z/LicRf59S4scC5xYtIba56umhsPGjEu1EUuHeGYWgzeYZ1vfQ
         BKTSrVxiAyGzlad1Xm6WeJK0Mn4AY2M/NknhO8vfV5dBIH/oBaKyMG/DXpdvdH36XXbg
         4jQ/MV/AxA+h1bl+1Heq/U7CtbbNH+jkxeo1H6yaOLLRJ8p7YeY9GzFyrpOSK31zkFHO
         lRw1fZVh6eh+B2gNSAB0oktg/ou765qhwMrn4M3nwcNMgarZC6PuS98yAzvbzrbrJrjg
         WJc5crupR/S2tVJnocKLn4ZhImFN6o32qqHzq0adUWp/iJOd1FjXDj6bUtnh7fzlGWBZ
         yh0g==
X-Forwarded-Encrypted: i=1; AJvYcCXTHKpATzTb9QeXgW4NH7R5h7JIukhUkQZGnj4oFx3ZFihx1E3+ut4SgGoKu1frfbfPBopB/VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZXuqTKoaMSSwioRq+uNDs9FcCycSO0R1D6MyGwxzTgC4y3wXc
	EPz6brIxDOMFJgOOHz14PCZUzSa4dA/ezH8lqYz6GO4bBR2wPKWuH/pQW/HIw8HYKjaBekjqRmX
	624s=
X-Gm-Gg: AZuq6aKyX0+lg8tGtSi7mG29xS1AIYlKZnIgT+sFa30wwcSTqM4ihPOCDL+8eltQ/dX
	vblgE0dshQjUBvUsAd1Hb4ww9sPqeNlrdnk+7VFu3ZGYJuxemZaQvBiYJ9Y5a+E5ypqcbuEkFyq
	IxZwND2wn5Ll7ApSxJQXoN/yRIgjuP3fR4dSojZ4RiLvZibioRid+jEQRmNHji9eouQ0B02WRF9
	DyvglaZ2M5DqBQfo25nIfgLG5npLfT9uwih1/SWu8/FuA9uPWV/xOvy0YI1frYgnV5M7DP00n3N
	I3b0qbV5cBdfhvj4eSgFFgZCyAEDwkC6vKp4esCNrBEUam9pBpv3uFDqSB7LyY9B+GOFjbvlQ+4
	U0RF5Kw8AiVpqX57sknM1mLenBJNXEQ2ODpHeIU+Sm3vjpzxSrfIYc74eU+hFp2WRWDbje/JC8h
	Aq7Jnr18B9pZrE60x3/akIpB6001pRifyiDwUtaKl+RhlMglhea3ckx1Lle6RdqZLn8MU=
X-Received: by 2002:a05:7300:e790:b0:2b6:e793:caf7 with SMTP id 5a478bee46e88-2b845c8d911mr331678eec.18.1770245593358;
        Wed, 04 Feb 2026 14:53:13 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:5ee7:5720:1d16:9b50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832feacc6sm2587040eec.35.2026.02.04.14.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:53:12 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v7 04/10] ipv6: Set HBH and DestOpt limits to 2
Date: Wed,  4 Feb 2026 14:51:48 -0800
Message-ID: <20260204225154.58245-5-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204225154.58245-1-tom@herbertland.com>
References: <20260204225154.58245-1-tom@herbertland.com>
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
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-256862-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FDBDED1DD
X-Rspamd-Action: no action

Set the default limits of non-padding Hop-by-Hop and Destination
options to 2. This means that if a packet contains more than two
non-padding options then it will be dropped. The previous limit
was 8, but that was too liberal considering that the stack only
support two Destination Options and the most Hop-by-Hop options
likely to ever be in the same packet are IOAM and JUMBO. The limit
can be increased via sysctl for private use and experimentation.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
 include/net/ipv6.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index c27b9d7aeb7c..29aecd8e9617 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -86,9 +86,12 @@ struct ip_tunnel_info;
  * silently discarded.
  */
 
-/* Default limits for Hop-by-Hop and Destination options */
-#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
-#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
+/* Default limits for Hop-by-Hop and Destination non-padding options. The
+ * default value for both is 2. This sets a limit at two non-padding options
+ * (see sysctl documentation)
+ */
+#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 2
+#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 2
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
-- 
2.43.0


