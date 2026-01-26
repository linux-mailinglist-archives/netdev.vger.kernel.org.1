Return-Path: <netdev+bounces-253581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGGIJiHFd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:48:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A6B8CBEA
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D3643007493
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E38285C8C;
	Mon, 26 Jan 2026 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="R+Zx0lJZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642024C076
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456926; cv=none; b=J2sloDutHC0f5W3EzfBOEX4Xps72UAOdfUDL3lj3siZjP0IEq71AhWkh5KunY9zrteJyvhXzshBCg9h+/vnQdhpLcFBlya2SJ7kNPySIpNItgVef7CBSwIvYMgpspJBWtevESvrvaVy5NfmNd+ilPMHxWSfsvocvUcyO+bSJRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456926; c=relaxed/simple;
	bh=kFaghT2H7tJ1BwrObUnxQvEy0mzh7/k55pG57r2jf7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7XWsUVk8yXxaOdtzEK7/lF+Uc0yqdgFvwAP8OQ3+haGVcNe3rNn3LR8bjKtw3arJKowqFEF6B8ZW/kmxFLUypxQRFikzXRneo1ZqWXqTy7+Z5oXu2kvnPR1FBXd7yqxkuDHyOOQe+Yy4Hs7OJBQyki0rB/PfjrY4IgnUe8BwFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=R+Zx0lJZ; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b720bb90d0so4441993eec.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769456925; x=1770061725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lpL9W2IkDNOp2tsGVFMqoBQsFkJX7KM0IfxKUFgOzM=;
        b=R+Zx0lJZEix0BhFgs3aSR9wHYrwW6+VHDQ3T34F0rAgVbHm13s/Ei3cQIzD3QGA7TT
         Wc/muXtwqTeqv5Frygx4/TOWpn+lMjWbk9PckZq/xmnEYq4ISeFjqLZI5Wly8qfRo5Ba
         99sdjaceqQL3qLyqNHAn+6wzseyvMYw1qvklS57Fm1BqIzJPAAYnUeUMNtdw3/79qjKA
         C9Mob8M1ciOEi1JfgOoYWfro99+Ge8MGch8yzbobmL1yNi7WgARreWD5bqA0hKXuta7e
         BJcWjCOq6DjcopK6sDi324UctN2Nh4NWhOhI8/BZ0pdpB1E1bGnG/GHFLFwwd2ktSWh4
         xhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456925; x=1770061725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3lpL9W2IkDNOp2tsGVFMqoBQsFkJX7KM0IfxKUFgOzM=;
        b=ALVo5Mdsh0MjahSGQ9saRuC3odermJvKWVMWEw9NGsKVG+SHpz64SfIievZiTKymGL
         1Ccciu8AKUctC65YSkmQ34d8zO+b+phnAjXf2SB0LuCdn1ht+KEO0evf1PwBpQb9KBnu
         wQUiHqhuRFjtZpejdfvHK7gqz4k44ziLttPa84J7XgmRccWY0vnd3AWSNWgEsPdPApKe
         a5zDFKhznhmQVpi4Ag1EmNXL4IxjVAxbpF7FVwKEasiBx3roqQBbJMDZm3G+lh1vrzjC
         QLg5RpGXn/xKf+VsqLKeN2MDcVp9lTAu/IGU3y+cOtoiRba9JhNCuLai3Xss9PKEKbbi
         IYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlsrtjZnEIRyIhixC0wpxlxo42cYK2VGvs9V9OzGicsv0gZKFc9A7sWNiAbj8e6EjYJayaCEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSEnPcEi6t7RdRyh+Sw+bi1G80sHzCTYT0Uyquwrx3vlH+YZK
	9Vq3PV4AKdfc0DfIDL178bmjdf5IpzgDmUdVCu8rDUzymxQzRqkUi25wBz0NpAgFOQ==
X-Gm-Gg: AZuq6aIHhDF+KOxbMrFHC3ge2UrXsQ6vLbu0stEbFmsGdc1YFRZrs0kSX4GfcKWTC6Y
	9St4grNik9b6vU93X8a1rjc1iAW4G2GJlJr+uBpm5oriFHXTX8vo53YWucPXiuDgC6Aq/EnnkPI
	1E8xVsIrrvSSGXTYRY+Dc83KQwPuO+d5uPEj96o9H8w1y2c3wDv19DQtIciPm3VLS0gzpdGaKq4
	aqRiVVBSTLF9A9OOHj/nIbY865O1upDNlcXM7xjTJ5h1WvoItdJBkiD4q5qknlj3pzjV1lq5KAd
	V0Gb+NoKC1Z8/I63cU5hfEDzBjL7qDZllRcYWOeE+D3ct3K7FzhqTMMoi4PXE+AMMrntCrtQ5ol
	FgYBsaX7Uy1x+FkpEOY787OEqQ5Kq79uc9NVUGlSZIHh94o581+k99drMDOUx0+sAjty0mm8JcW
	phgP4+/NBrNymAn02qDpiBPcB032TWwf4LCP88uP8/QAgc/Osoy6jOork=
X-Received: by 2002:a05:7301:4e0b:b0:2b7:35c8:32cf with SMTP id 5a478bee46e88-2b764508e23mr2031864eec.28.1769456924763;
        Mon, 26 Jan 2026 11:48:44 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:1485:5851:22a:4c2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d99804asm21121295c88.12.2026.01.26.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:48:44 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v5 2/7] ipv6: Cleanup IPv6 TLV definitions
Date: Mon, 26 Jan 2026 11:48:21 -0800
Message-ID: <20260126194826.236075-3-tom@herbertland.com>
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
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253581-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,herbertland.com:email,herbertland.com:dkim,herbertland.com:mid]
X-Rspamd-Queue-Id: 40A6B8CBEA
X-Rspamd-Action: no action

Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
of the TLV definitions. Label each of the TLV definitions as to whether
they are a Hop-by-Hop option, Destination option, or both.

Signed-off-by: Tom Herbert <tom@herbertland.com>
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


