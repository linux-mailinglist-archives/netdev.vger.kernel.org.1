Return-Path: <netdev+bounces-253582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPsGC23Fd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:50:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F48CC4C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB17301D6A5
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5056285C8C;
	Mon, 26 Jan 2026 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="d+YNzA1e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9324C076
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456930; cv=none; b=DHXQi3B9sPU3hqw90egQMqbp1/aSnCKJEOApB+4Y/owHIeeQNvnSLZMK2FKZCXByD+8ot6GZ7jMizqotokDKhdwgEgx10/PByZoagsqBv6+Az4cQ7dIwR1ustdR9RH7TkkQdYR3Dev4HXsP1pIc3HGtjSz9QAPJjDts8QIE/okU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456930; c=relaxed/simple;
	bh=0MzsOqCVkp5QX5Wvj2w8/XnUh6cyhsoQAfz0g5FGhxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzMwtdRvnpjzoYd649HkvuWf0Df8tCAteRbv309bHetzkvgksgyRMCzeTrjzftdTx7f/0ElcnSJPg21AbZcbSX+EnlyTZUGV+6EMWGpQM27mUTpnDfHCyPOYmM+oxjGnHSlL5XoWHucapt0JsRmL3LulpSDJZl2OkHSTEbjQSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=d+YNzA1e; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124899ee9d3so1301764c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769456928; x=1770061728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSnInn4tVjQiilI25QhA1X/o9Nmy5C+8faFR6j3lB4M=;
        b=d+YNzA1egLetCVajIJAmi1pBkx8EfqZB/ZcH9Tozc/vL6t9MjrwIYWHogCzI8Qu3XZ
         ozdgxj5zS2Miu67M/OTjWSTZhlSAFbTVeymTgoDbsWEPQg6EUexO+nZy4nbE6Mif9wNQ
         lmCPNpG03pC3Jtx8lzuFtqcz873hUlZvsGXsKovsvgjptcRjwT8pFampCYps9lid4IqS
         kk4umoXso1VxoWXzC+BK8nYOdrlDhGThC77bl0/IWcduF3wXF05Wz8JEHJD5D8w3LBTp
         bqkdbzunurqGZGmWb6M3BI12MiihrnyIWgRHsNpA04gjRnegSGH0nPk68E7r3taP/L88
         9ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456928; x=1770061728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xSnInn4tVjQiilI25QhA1X/o9Nmy5C+8faFR6j3lB4M=;
        b=q+vU9KBDankHO1FfaX5JDveKzjjCLPqScj8t9teginAMPNIHR8dtfxUlSq718Dpgqw
         84Lk/UnxKBweEPqXGhHxp8uZxCbAjkNhkBXaazwj0kCgEThPoEXXjo6A+M6qcEUCkhWS
         VVKj7jt63XLP8dV4Z9EiOqCywWqdJrqbTEOUHO8hS4PUlALqWKRp8/vwmpP/BPCRiQxE
         NE+4TElx4a9uEX5l61QtmpBLmt0kkk5TZvk4Uk7MziEZnxjXE0bThQDakQpwZeFFPH9F
         V+COAfUrvrGA+iufo/RGrdDfkb5248nvMJeFZE+Pb8/BXPdVpFVBAUM2ez6tVcxNEJpl
         6RTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWrq7xGxU+5e4QHDeeINRFKx/Hphj+VXvC+XVcSO+xdcmKBOgfogASgPX80rszvCl4IO8z3R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxITt1KmIU+/5zIxX78AdjO94WR16gVXdr+8c6PK1qXbffZ79DT
	vWuXRXLXExtTMGliv5gqkHu1c8tMvitM3qszJyi5iLUBbnEuJTE5BJxf6YjYt1p1uw==
X-Gm-Gg: AZuq6aKrLikKHUlIK9lh0yB1Jr0PBDfuRKAzCjjNTsD3mSFfaqe1xicpWFtLNPr1smV
	ChaxHiTE5qsx1t1HIP3LkOug8cAAcMWETV0HeS07g5xA34Y9kdE7cXAC9ofY3fstnsEGkLKP3O9
	UV7O5623WfUjNfXEWskD48Tl+0lXQAcgs/i9Gtc4IO4QSbRmxSTjP1xc7lYu4HXGkJd1GsIeJLq
	LPq43QGSrlDcmyHNdAKvJr2XQqIcsFlr6MuQjXjc/yc6FQzgT75WdsgqgM8Q79tlXo8fSdS6JR6
	m0pCiz/2PnVYzFiiFm98Hja7IIG5xqU4dok+6bLSsGIjbCinHKjFnWq7Os3GnPXTHAgseRusrfK
	c4L2r81JdQBDOeDfqNWA5TOrkfYZjlp3ixD2RaaTRdtLd72V0Lcw2bv9mEejW0aFc4txYJSMpPK
	7bHV/635Ef2AkwpXWcDSPatk7Y7RDFj+eZfs4c3H4+JMzypAMYxqu/TK8=
X-Received: by 2002:a05:7022:6a2:b0:11f:46b4:449f with SMTP id a92af1059eb24-1248ede37d7mr2808308c88.24.1769456928416;
        Mon, 26 Jan 2026 11:48:48 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:1485:5851:22a:4c2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d99804asm21121295c88.12.2026.01.26.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:48:47 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v5 3/7] ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
Date: Mon, 26 Jan 2026 11:48:22 -0800
Message-ID: <20260126194826.236075-4-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126194826.236075-1-tom@herbertland.com>
References: <20260126194826.236075-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253582-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 835F48CC4C
X-Rspamd-Action: no action

IPV6_TLV_TNL_ENCAP_LIMIT is a recognized Destination option that is
processed in ip_tunnel.c. Add a case for it in the switch in
ip6_parse_tlv so that it is recognized as a known option.

Also remove the unlikely around the check for max_count < 0 since the
default limits for HBH and Destination options can be less than zero.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/ipv6/exthdrs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index b9d186784b96..6925cfad94d2 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -122,7 +122,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
 	int tlv_count = 0;
 	int padlen = 0;
 
-	if (unlikely(max_count < 0)) {
+	if (max_count < 0) {
 		disallow_unknowns = true;
 		max_count = -max_count;
 	}
@@ -202,6 +202,16 @@ static bool ip6_parse_tlv(bool hopbyhop,
 					if (!ipv6_dest_hao(skb, off))
 						return false;
 					break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6_TUNNEL)
+				case IPV6_TLV_TNL_ENCAP_LIMIT:
+					/* The tunnel encapsulation option.
+					 * This is handled in ip6_tunnel.c so
+					 * we don't need to do anything here
+					 * except to accept it as a recognized
+					 * option
+					 */
+					break;
 #endif
 				default:
 					if (!ip6_tlvopt_unknown(skb, off,
-- 
2.43.0


