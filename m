Return-Path: <netdev+bounces-267803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPImLD+gtWn42gAAu9opvQ
	(envelope-from <netdev+bounces-267803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:51:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2609628E378
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9DE5301946D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D66318140;
	Sat, 14 Mar 2026 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="BSdHGcuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC515665C
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510703; cv=none; b=q6FTbOFMt7U1oIHzgRIwn0tkDPyGvsurdZpJZ4KOIebQDPLqmILVKjAf6BUYav8a16QjixShxT7lRuZwlerpWxZnLmOLsnVYADpEofnx3HpIR1DsQnjEch1CLi15j1mwN+o1gFkUbnlTboGKDO3k+SZmg0j1ShgwN9Iqg2qSiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510703; c=relaxed/simple;
	bh=/W2h7qSrJKD95QsxjmbKLwHiCyH7RA6BX4Ejs6Czpsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvSQDkxcEwq2BtuvYhN+GE5ndrjQpV65/Y20QA59bpXBh6KstPqdgsllJPhw0fVLV5cYz2kUapUmtqqHevURGcC132GylsdPABgrioEgkhu7v654ypy5jswuENR3IYwooukWXCU6GBhSpkScIqHVBiHioi5muzqiM73vMnr4uQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=BSdHGcuV; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-128d2e3082eso1967626c88.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510702; x=1774115502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FstFq72HN4LsI2mBA0U2uqbzUPh2nVAMeGBt+tKiwDE=;
        b=BSdHGcuVmAG0CSe/ZVpsI/whLkxmG7yaHnxJNfBVliPkQtWx/NgvVpPBm2cJo0w1sP
         ipnkzRvds+/wNFOAXGn2k62T8nvBlSGAATaRDMsf9xwO+sDdEnAq6QBezXCncci8SDcp
         iNHkjeNdLKGVgYvRIB9lwhXPi9eiUJHgYPi71iza0N+2o4B39AMWpLacIrSB9Puk/0U6
         gMlfu0qmEqK2oFcqUWOgq/g8gOqg+Q7EwvkezwHJkC0OLAvp6QO6aMos6VmvFxTplmQH
         4duS2g/7kgEzaGNcJa/SfutHNTjo7N5DFQVp7EyLhrUp/xzc8x14aBJczQPnW918YQyg
         wDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510702; x=1774115502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FstFq72HN4LsI2mBA0U2uqbzUPh2nVAMeGBt+tKiwDE=;
        b=eY2r33EdfYyWHal07K2EbwCo2Lg6fCN8ssJU9oI/MiWMWTObZ4Zlqxg6I9XvFBiB6q
         4OI/bgh5zOm853vuPI13k/8Ohqavya1sIA8xTJPANGNwP3VApsXXLKnE1/ukghGDty8I
         FsVsdLXftknR7cLM5jyFDl7S7dyexAl4FUgPw3CBqyilxHKiOhH+brYRwNYu/GQ9quAz
         /zt5nBd6BiIKlNEts4mgBQpJ+MTKsO49dB/9MxEFx03ohYJmZR4em278SzWhFGxl7Wuc
         sz7BcCxSdjDCbLkvEckl4yfQACsGDcnjcaY68FB09Hx4nUIoD8Wp1Tt8sDlRtCoI71Tp
         Vdvg==
X-Forwarded-Encrypted: i=1; AJvYcCUKHslHBKzR6xs4TxnYsIhcpKcmKiE20uDxrFXGLHJA1w616gs2U90TCRnU/rQ9Nn09fv8Ocxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRWl0zmFdJX3OZ7jtbZS3z8hHTlXyVCg8uMlKrhR3HqDQSUu8h
	dZJ7akvIvcrBLNQQScrGkZXOsFuJUyRfJqWCcQ60cJ11lnsswa/tt/2P1NyR6o3kvA==
X-Gm-Gg: ATEYQzym8EsT+PRDzSQGQtrI504EcwOAXWMbJj32wuMlLzLknlS7krBY69vv8rp465K
	9u4oi2Anaews+88oWIWnwIKYFU22w+YL8Cj1yeuNbIDpmS0v9rn3tYdCfkrZxvPYYHQ5c0TkiiD
	rp7G00RF7RgOGl+JlblXyxRHSCSoBtYJLb5mZy9hmOtR2bQNsaPa1ou2zLT10xVsuyZnoMBmVpn
	plGTwQDb6W1rdj2LWgEeEtYAu8SEdPiuhgFgkkHMYibYoXFLU0140ZRKeiFiU4JycaWg0Ys4K0c
	x20x4Pg4tC44WV8ISn6O/4gLZyhwQ7wAOxftb2RyMrivtydaKcD62o4p2vACq/FU9NzBkYJOETn
	XrFd1joHR8wJ658sinzhTQeBfog8SeLDQ4xCTXrdrSpWg17p7itFiMESvd6+xLZ0tUOmTXfL+aQ
	HWE5WJrRUXbhAW2dVezu6B9zquh5PGXr4Rznf8ogmja3yXL5Jy59iRE8VXUQsj0ZzCQBCgUg==
X-Received: by 2002:a05:7022:eacf:b0:128:bb7e:b5f7 with SMTP id a92af1059eb24-128f3e20421mr3561469c88.36.1773510701651;
        Sat, 14 Mar 2026 10:51:41 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm5917206c88.9.2026.03.14.10.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:51:41 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v9 02/10] ipv6: Cleanup IPv6 TLV definitions
Date: Sat, 14 Mar 2026 10:51:16 -0700
Message-ID: <20260314175124.47010-3-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314175124.47010-1-tom@herbertland.com>
References: <20260314175124.47010-1-tom@herbertland.com>
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
	TAGGED_FROM(0.00)[bounces-267803-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2609628E378
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


