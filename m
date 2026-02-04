Return-Path: <netdev+bounces-256860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INqyFjrOg2kFugMAu9opvQ
	(envelope-from <netdev+bounces-256860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:54:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1786ED1D5
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD253019F30
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0936738BF64;
	Wed,  4 Feb 2026 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Yh5gTH+K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AA2F83A2
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245586; cv=none; b=WrkfAP98clUHz6TdtHiLwh2DWvtj51t10ZVCk0ZaOPlwzJ3GnPy4PgjY9srenq3hfoUfXz6eqml7KHHVWbcsXuMi+Te+10GEfD008pW8k2dRCS/mAiuf+/+ejIinmOtkAEiLo68H/MAT7myQe8XPMVmtnxhJpBRNEWpK8dmDbjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245586; c=relaxed/simple;
	bh=/W2h7qSrJKD95QsxjmbKLwHiCyH7RA6BX4Ejs6Czpsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMHw3Le1pneNYlmgHGkw6otkljkTqYhn9wCZTym06vLy5LLV+11bK02sTjHJ844CXPrvbdA964BObzJwoUwfuGMuS/rGxFhwd3TN2484MXBS2qpLcFZ4x51gjZu17YliKxJyFVT8RnuWwujWA3jGkdYoRdv53rEH+UJIayPjHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Yh5gTH+K; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b740872a01so521371eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770245586; x=1770850386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FstFq72HN4LsI2mBA0U2uqbzUPh2nVAMeGBt+tKiwDE=;
        b=Yh5gTH+Ks1IgWtz1MBFtn44apV6VsMM9UzDJdjiEmFIXpKk+dJexm+bA5y10vU7tdk
         /kBm99MG6K5roLiw7ENxZpDda8VIWvvWeJUx77NNefM96bagcI1V3JQd4VPaF46XHLF5
         3iAmHvPGCciE3DOWo4xIMpPpyDkGmX4HTcushLa6bRcYFOGPyLBuI25DGrXg5Yw5DS6g
         9QrfGa1UJLR3iHVpOQC98W/PYwWNxzUBxKHdbhAwqT+/BsS6N//AvrJe4cGMHC7bgG1+
         rHddNtSy7aU3Gz1cN1+wC/WXLVMQthK3wNhLiLKdvr3rG0CMhhAmsKVONZIrXCad9CwF
         9tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770245586; x=1770850386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FstFq72HN4LsI2mBA0U2uqbzUPh2nVAMeGBt+tKiwDE=;
        b=tTJlvqT/smKQDCB/zMtn+8jMeMz4BU+Fha+zx/nemoIVqzr4m9bOIS7mtYpbdPPRWI
         GX6s4lyVTHsyjyhvPInMfYrJysHnPUFjaZxecbcnLIoqbDobf2HO9MuilmsGyPVcuvBX
         +fbXiepw02VBMll9vIVAljcETNgv6o5ochqod4JNEPQaYGJDuYhioopJkKu9QKzS/bdx
         CBcHYYzfMRSAo6ww5WLKsw3l9oqYUYF3w3cOMSW6g0ZFngZF7qcWKoXpEXIA2REPDcZv
         kY+6wCHL37rYu7fQ5BAjGJSpnIqYghuHVpZJGFk3ljXGj2paraPLyowypAjegi/r8+FG
         EEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV17C9QNtY+Xqfi+cqBkfiJVYCFJ2wBSQw9eB9AV3OPFoZlt2ZVVOnqnkGU+bBa/SfoWzl6QpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhgBSheHF4QGCQr/4pbW1Gx/naulKBcy+nRv/Nv/FUVFacmCtc
	wEe9jL1hJgfeOgFW5XXRFfhiOD9CnIoeM27fGG/nNgBUVUfHI4K6S28FWmishPPHk5ENidnsZuO
	9kfE=
X-Gm-Gg: AZuq6aJKqo1hpRhKP0shphjuI3oqBh8o/SrkVYqgeWr79jCXPqsGu1sTjp7UiizCBDg
	+4DwLxg3ivSLg6JBShGi0/wRdFAq9CzTU62F7eGEyrXMFcihmvAH6pYpJeBDf2EAdhdYUW7SqAs
	uFdb7mCpXGK0ToukihpPHTKwV+qbh1TZZokXCTdDTh7riK6waMjF5k17iaAeHHC9qvSwzGXZdgq
	Gm5T/KEcdJaCOUbwALkH3ZYEpxdwo5XdCXWhZ+L+CafQf0mZOigGaRbenzXYUwtPE2NG2SYzilA
	pZPkba2AEEm57a1k3RmGgJxZ53JAqZdOWqXP/qW4BhinA//Ea6RTF9RkLFuLbp93rxN6KqELwV7
	CHY7EhUwsF3zBlBhYIgFfJv590G11/I/mcyhMSFzKHhzwZozlmGEXLQFWXAcbQr9FrrmZOTDcey
	5QLKhf4ygHlUBhG4+4vUN0RxvBnjNWHKtFLkPQxOrm2F366LPi3NcPS5WN
X-Received: by 2002:a05:7300:6425:b0:2b4:5a2d:80c with SMTP id 5a478bee46e88-2b8328bb87cmr2141827eec.11.1770245585906;
        Wed, 04 Feb 2026 14:53:05 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:5ee7:5720:1d16:9b50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832feacc6sm2587040eec.35.2026.02.04.14.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:53:05 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v7 02/10] ipv6: Cleanup IPv6 TLV definitions
Date: Wed,  4 Feb 2026 14:51:46 -0800
Message-ID: <20260204225154.58245-3-tom@herbertland.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-256860-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,herbertland.com:email,herbertland.com:dkim,herbertland.com:mid]
X-Rspamd-Queue-Id: B1786ED1D5
X-Rspamd-Action: no action

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


