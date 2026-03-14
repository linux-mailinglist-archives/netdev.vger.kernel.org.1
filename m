Return-Path: <netdev+bounces-267787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIxLMoietWms2gAAu9opvQ
	(envelope-from <netdev+bounces-267787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:44:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A3628E2CF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CF113029A58
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9372F12DA;
	Sat, 14 Mar 2026 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="R2uXFROi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0EB27FB0E
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510252; cv=none; b=rM1sEdphQa0pETVeTG293boE967ma5Ek9uieRm6nlYaOOsPR2DTA4J7h/zE/laZtZx1Fj38JpGNzYlRCnXcRY4MudQRZGYhh58OnCZn7fPfZaVaR2NFt7VH/Df3vpGwAZVPlHVV6Rij+apiVYwA6LdEs7QDdx9YwGTFkMvKvufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510252; c=relaxed/simple;
	bh=/W2h7qSrJKD95QsxjmbKLwHiCyH7RA6BX4Ejs6Czpsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rShBdWmMQI8bRUynrudQ+gnhvKgHxN5JiYq0YZ0hppgpauKYvwnPj6JPPwbcUXV3ATEuZW0BmvP7suSg1DEZziaNWaygjz8k+Eb1E5+a2pixTvsmpRqIN55JbskCLDptNMh0F+iSUGwqHN/KcgawJUXxYSh99Jom29IS2kBR1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=R2uXFROi; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1271195d2a7so3275130c88.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510251; x=1774115051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FstFq72HN4LsI2mBA0U2uqbzUPh2nVAMeGBt+tKiwDE=;
        b=R2uXFROiSZumpMxp/kJwqYhpvQiVcbBDlNzbLipo7fdcIXH8D7P7/ure/fK5HBAzZM
         EEMZUgT8ozrwgOPM2AtEh2s49YfDkeX2zobQM9orLVL6k0d3z0hofDx0sfhlz+r0Lxcs
         tWcKomHWdRh3OTSYpQ74yayGOp2N/yw0BlZpkZJ5Jf7jMZIWFCMFqhIoUfuwCHpaLT/6
         q5m/3kSD3l1WfXl9Vp9IS25u4PIE+3hMQDVDe2dFoqlzdg3rof/Dedo3iX8ODaa1Arm2
         W8pvLKiqEtQAqx32Y1bW13oCOykMXTcnRlU1FwejMnIg83eEoFmy0ORzqbljkXA6vKxD
         t4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510251; x=1774115051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FstFq72HN4LsI2mBA0U2uqbzUPh2nVAMeGBt+tKiwDE=;
        b=iAtSx531qK8dWxJjyIhQzyAMgUt9cuk465VZ21wBNK9+oxt45pJm5T+2XO+CZNDqwM
         upEuZL/W0ISqZaOmq8IvXfUZ3bZBlQe8I1bSNdppm8ymVfyUGu4+zElKM5tX5lePVkkT
         Clg72EEGCu+pooVZWbTSpzoZPkX9ut9sJPWeGtOrb9vMdSDo2Yk6//pI0SCqwH2/WuS6
         GDCTa/hHgTIB9pluPiY1xA1XpDWnQoL7I6d6Eea69R0fJcrlgjYeUgSP6szHdzGvJaXY
         iDY9HwAWaAVo9Iy/ZmNBLhFsgDtFAfJCWFlYV/7cGgEE3CEMH2WS/cC6ogqeZpaQFPZT
         zEyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8fsGO3HGzARH3ppeh6lE9o9T91yLcqCaFP6mXfxfhU+BKrafnHrms6BtmtliSrGt5QIdKnJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznw/Vc9o8Q9HmRed8Ewq3/6TyYEFOU+AvbH6twgL88DXFAtE8F
	t4jWj0YuFgSr6Fpy8oYmvyiokq1Bwol10qex1tRoyGb/2kJa+5w5Q0/FijeQ7udReQ==
X-Gm-Gg: ATEYQzz63h45gsoAsEz/0tC/jo1jUSbM6lm9c5AsSUm+o7WCue0veULup0emHApwEcA
	5F3bWt/E2s2W9rrvxMhvYU2qP8kwOs8PD2oASLPqK6sy51E7t99692i36WAYMVzV3U3Yv3WKpO7
	lOd5m2tF5M/YJqruPCqpzx6reVjbsj7o7iuMhih8REBKzL771G8iw3lR0PeU6EjY3/XYKs9KhTY
	4TzBftDUTtbE0ugN+BwuPLiKSTwNxzc+b9cFG3c2ldoca4P4Z3ECC3kF9hZfR8tWXH+n+5xlcHK
	FvPnB5Wn69MOdUcLJEfXJ8SZLu+90zZbs2a4ba9gTYD/78XtUBjJ9FE/M8wLLsCn5EG1RYlGwXp
	xn3undpR6pUAYPskxWFWSL8gnk+q7UTSTPfKc8tcOJAIsUL9QhvbNHItW21o4CYEWTAL+x/CzKC
	s3/r6Ba5zV8bUOBKtEzjTV2JjVTBw7mHHGQqutaTIoE4ubcUFe1Nm1YDaYhfD+GhvKQsr6ZZ/JN
	serSrMy
X-Received: by 2002:a05:7022:220b:b0:127:1492:e370 with SMTP id a92af1059eb24-128f3d193fdmr3529370c88.5.1773510250681;
        Sat, 14 Mar 2026 10:44:10 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm8326734c88.3.2026.03.14.10.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:44:10 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [net-next v8 02/10] ipv6: Cleanup IPv6 TLV definitions
Date: Sat, 14 Mar 2026 10:43:25 -0700
Message-ID: <20260314174333.46406-3-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314174333.46406-1-tom@herbertland.com>
References: <20260314174333.46406-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267787-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:dkim,herbertland.com:email,herbertland.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49A3628E2CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
of the TLV definitions. Label each of the TLV definitions as to whether
they are a Hop-by-Hop option, Destination option, or both.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
 include/uapi/linux/in6.h        | 21 ++++++++++++++-------
 include/uapi/linux/ip6_tunnel.h |  1 -
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index 5a47339ef7d7..438283dc5fde 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -140,14 +140,21 @@ struct in6_flowlabel_req {
 
 /*
  *	IPv6 TLV options.
+ *
+ *	Hop-by-Hop and Destination options share the same number space.
+ *	For each option below whether it is a Hop-by-Hop option or
+ *	a Destination option is indicated by HBH or DestOpt.
  */
-#define IPV6_TLV_PAD1		0
-#define IPV6_TLV_PADN		1
-#define IPV6_TLV_ROUTERALERT	5
-#define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
-#define IPV6_TLV_IOAM		49	/* RFC 9486 */
-#define IPV6_TLV_JUMBO		194
-#define IPV6_TLV_HAO		201	/* home address option */
+#define IPV6_TLV_PAD1		0	/* HBH or DestOpt */
+#define IPV6_TLV_PADN		1	/* HBH or DestOpt */
+#define IPV6_TLV_TNL_ENCAP_LIMIT 4	/* RFC 2473, DestOpt */
+#define IPV6_TLV_ROUTERALERT	5	/* HBH */
+#define IPV6_TLV_CALIPSO	7	/* RFC 5570, HBH */
+#define IPV6_TLV_IOAM		49	/* RFC 9486, HBH or Destopt
+					 * IOAM sent and rcvd as HBH
+					 */
+#define IPV6_TLV_JUMBO		194	/* HBH */
+#define IPV6_TLV_HAO		201	/* home address option, DestOpt */
 
 /*
  *	IPV6 socket options
diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip6_tunnel.h
index 85182a839d42..35af4d9c35fb 100644
--- a/include/uapi/linux/ip6_tunnel.h
+++ b/include/uapi/linux/ip6_tunnel.h
@@ -6,7 +6,6 @@
 #include <linux/if.h>		/* For IFNAMSIZ. */
 #include <linux/in6.h>		/* For struct in6_addr. */
 
-#define IPV6_TLV_TNL_ENCAP_LIMIT 4
 #define IPV6_DEFAULT_TNL_ENCAP_LIMIT 4
 
 /* don't add encapsulation limit if one isn't present in inner packet */
-- 
2.43.0


