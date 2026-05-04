Return-Path: <netdev+bounces-284009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKclKxfr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CABA94C2C4F
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D88D30095D6
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4664F3E6DD6;
	Mon,  4 May 2026 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="WYjl0Yxh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034993E6DCD
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920777; cv=none; b=C+fY1VdaM3KZuLUKHfL0cCMPBFepNU2tiRCkIomyXpHGRE/DKGGAK3R8eOv/AMtjDwrDsPE9n6a5P9DwpDn+wrtysgPbLUZieVfRZNgxy9Jt3UyRExvH6G/R91srVSFWo7reb4jKin8RASNELNVFIDzWTBzjdGSqKG0gvO+ha+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920777; c=relaxed/simple;
	bh=T0wkSayywqKJUbJFS44MALmqxNNt13lNTN5v0zdECxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr2n3A1bwyMZlZJNBRYFryOCscoX0zH8whpVGMVcM+YUXtyy5O/PwNGp/7+yCSN3h/KZrk8hUvl0AsvvEV8Zsi7aHthdvDHTGjLQ2HiMBXDMNzQkeSfB9xv4+XZsclmcl3PLKR6aHJNjrMWGWWISqIYWoK4AMcDwh/nKMQIxh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=WYjl0Yxh; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso4859666eec.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920775; x=1778525575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX25ymGA7z4bZ9NzYxnAK/h/p1xB1/VJEDOQALn8q/A=;
        b=WYjl0YxhWwkcHSf0INjTRStLgiCcysVPiT3VBhxItRat8ND6avxCmwh7uCAsqIgZUW
         1w1yRsCacifjtEqLiXYZor+sOrdxzDV6IXX+5kpJktS7f9VruwUtz21unCfadNPmonhp
         SDiYNa5PoMBvB+jpJEJuRUk9tJsNyKIk1YMFGigJ9OCkpbvZGHWvGrrXnZd7Ggl746aG
         zdfm0ZNmLOlEcL78pFE5yUZwVBC5y62u+Gy3LsJZ5tO+61Vkvlo/UNdtnAFLFzVTO85Z
         HQWxeV6WUOgRjmFTZoD8JdGI6Np0KJyfMUPuDBvg/Dh2W/I2hjqCm/GoaBhGBj6dytKZ
         cs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920775; x=1778525575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aX25ymGA7z4bZ9NzYxnAK/h/p1xB1/VJEDOQALn8q/A=;
        b=ECm97onk1CTm9P1pp5Y4NPkkqYibZf2Dm4W4eYWqfu9Smj5fXCqkI1orhUeTLoUgYc
         eK77Z2oDTdhX3VsRO0Bcp8AtY16kU9KN6998n/Xr3SsNFu9Lk0609ujgwsQbRq/nXrwz
         59bbHstPgqDS4SxlNeMGo0vTPJ+xHxs9BKU10hZjA3HC2RnSWIxvB63LhERl3nBlbOFC
         HqdVQDiM82N3lYV3DDYk/neXb/4ecr6AvdQjzdASJgb7vyIIrFDJ10Knd5lq6zJ5vQxO
         8D+NX79ja0DtKYdJKRIdgJu2BcB1RMBUkZjZzg9v5B+t7dftBkmVRLV1kO3m4r9ohXIm
         sx/g==
X-Forwarded-Encrypted: i=1; AFNElJ/dbkU3OfZk50OpUfBQyHLzjV8TUwa5a7V0ehUbkSz7GDUGPdNvAoqaCJRVm7rHvgwmhTvsxd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9wR2pZGG3hIHGlEeMfB1URPYYwQkpkmsryfzmQ24htrD7pfOL
	yEkKcNTHTFQKEpQ7MNXGO2h2QzMSp0cPNz2J//j6YJzNdIKH3JnwpGYNJAYT9bBT4RpbTMzdFlZ
	Ri9Kazg==
X-Gm-Gg: AeBDiesb6L6EPFY/3C5uxYtwmkQy5uFWZbDt91Jsq/VTHu1IH6+oAwy+FctBjh6Z1Ss
	KQjHx8M3WGuoGtf5/SiZCT8rzCSTHjkTNzJk8KiF9hWx1lXBJKeXap+/Cayg2GhVKezaf8y/aek
	NKKf5beDEt0GrQdhQWqGMr6ZWpSGCUyiXvr4iERvioGuIpkPy0Wdw1cU4vkor2cStr3ibc4EzTU
	LD/1uP0KrtGbla3A1e5qWKyWN/vbuNxP4nwn0fvPt31k6TcgZxVCv7DrjnpfzVDGejMqj22KSC7
	lWytjJdLZXzSiGgRYHjNUBP9xLFFbogJ9fDRBNDeLiboZwjn2iN50l2ui0UhvO297KBHsbeG1To
	0tv+gTWHA1n+1bKXuVwzlsA8WYhGy/3gpKNvurm7Yc4BUs4Xjf85FqMQj1NWNxIYkCNKZT1EGKX
	YEUseWPbq+66mshSNSDH5WCfcmuKaBYfscGndybbqLVJy5y/zpLD7On+U8tAr5nyTQfMu6nMmUi
	ya/wIAto8A=
X-Received: by 2002:a05:7300:e8a3:b0:2c5:220c:5670 with SMTP id 5a478bee46e88-2efb7ada7femr4743013eec.2.1777920775062;
        Mon, 04 May 2026 11:52:55 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:52:54 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
X-Google-Original-From: Tom Herbert <tom@xdpnet.ai>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v10 04/10] ipv6: Set HBH and DestOpt limits to 2
Date: Mon,  4 May 2026 11:51:16 -0700
Message-ID: <20260504185122.50642-5-tom@xdpnet.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504185122.50642-1-tom@xdpnet.ai>
References: <20260504185122.50642-1-tom@xdpnet.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CABA94C2C4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284009-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[herbertland.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xdpnet.ai:mid,herbertland.com:dkim,herbertland.com:email]

From: Tom Herbert <tom@herbertland.com>

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
index d042afe7a245..28448189d2e9 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -84,9 +84,12 @@ struct ip_tunnel_info;
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


