Return-Path: <netdev+bounces-284007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJrDBAzr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B9B4C2C48
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C921F3009F06
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F883E714C;
	Mon,  4 May 2026 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="QNg6Y7fJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B63E715A
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920771; cv=none; b=tEoNYSp7LTHmwxfSO+rsVnumlAJ95ZtqB2R8XMvUUZpD1ec1favlbF1AAwHdCwtZXrgQVYOmxAMq/y9o7qZE5ByVzcuKWd+3g9d+bc4yORs7Jj+95rxDKRyIJE8Rf8bJRk4PS7e1U7+9RFP1y6QYaAJMxUNgALJwI7EHiwYenAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920771; c=relaxed/simple;
	bh=1uj28uXDPm4d/YyIyCo0th6eWGueQtLEiAXTp/kD6ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkmNMwHTT+RR+Tf5h1AcP0oCOT+ZGRweOUwUD9RfM4rvI1KnlLZZ01YkdpRj1l5sFL9aSq1FAgARTPUGfxY+kLCnlVyn3gtVBZiXtf687Txe9gq8Arpie3NMBopvLKyQRXYRUUezEXRe4oaocRybF1xC2EAT5iFDx+GBzXL30ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=QNg6Y7fJ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso5809418eec.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920769; x=1778525569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+jLQrzTo+GImKajyAWiqiv0Ms39IU2MH3D4Z0piRFs=;
        b=QNg6Y7fJjQshfjUFATHmESdh/YcAFAArw1r7kk2v/zdd754m/EB9ES4PcYQjFivkcS
         6mHpjEwmJ/fzjPGhpmW2fMHpoRc4vF1Y17DcFirW0s5GGzU/Exjba1+/A8TBbWJJz8sF
         F4NvluQX/09vo94qhaSSBdM8fPrBovRjfj3YWbRWy9NmftI4jTAIdM7mjzSo6mVSiSgu
         wEu9dzxTR0PhF06xSF6rJ7RiDN5xKHdycrcVSEkKDRCn/70kb6TJMnyZRc2PJG92PuLN
         d0y+iDjF97GXbCoTkqxAtGrG6NmzzsmdedPOyIW/qMc6Ps6gyyWRD1b7q1g3k+qAiCI0
         /0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920769; x=1778525569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+jLQrzTo+GImKajyAWiqiv0Ms39IU2MH3D4Z0piRFs=;
        b=mvAHEh9NJ7w2U+T0SYyRm2anReLAKgfh3fSBM1r+3lbV/qtspzhfwWheLEdKpZKHGH
         ODzNFPjhTDpf7FsyugEezQssyjP87XtJH6yQA7O0N1KbiqSGVpCsLwGI9kCHqghc1/E9
         cva0xPf45nbwYS1L++GqjGnweZICtgUs0683hb2iOwab4vz7XdhWIJ8+c/MGN7iko0lb
         B4nWVqzelUtVLWcW7Ajl15K+Ji3n/VTTtluX3xbIXloCUTuIAc20yP3n/Q7PzBx0gf0V
         hWF3584Agn/xfCXgn0cCpW2bxfLPi9tJVicImjVPPZldozeFM3xaEzPFtHSn17YacF9R
         uc4w==
X-Forwarded-Encrypted: i=1; AFNElJ+AlY9qwlE+CflL9fdXFWB9lATgVhef+jr9Xwj0syVghrl4Rh/xxbP7PLdit7mxXcZ2rFLmPlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7O5fCyh/J9FmOmTKjgBFAfPgXjk8/O8xbPVOPs3dVoGtKY3A
	kquF5RBSFfmK4F1yxm40iG4dlh7b3yb2hEYIW4CeS6dfyCbNzwwuDc8mQzPhc0v5tA==
X-Gm-Gg: AeBDiesxRi+PDDWZKDiryKt3GOUdwxrQpugLvCnhkyiJjU/w82OxZFWaWM8laU5SCUk
	UtYs9VHDNRkTYb9V5k1FAlxCueCMERkUWgawy1EIIGMQRBztCAHsxo0Fy022SzXlfQay8dV9cCl
	lcu31P09Tm++CC0sMShJ6gVk+0vK/4jj0tR3n2Gbg8huQuHBqdYK3PTQX2yilcGPbQ74KtGeM3O
	a46wx0LAVZdQ9WOR8FTQaeC4LiQrV0iwMdbl1YvJUfK52bWKUU2uNmHfTn2jg17+H7dbLwZ1Gn9
	519feLPa7wRsUymb/F4HPDZrTWQz3vwRqFb7s8tu69HxkoXspQuIKvBMAFxG6gvEzd+H/2XHvB5
	WBwN6i+/of4LUiiuRYW5G3oJgyWIqfRynFn8EoVsK744iPN1D3lENwU7LZ1O8DuE1N2qUoT4J+f
	//GuHgzOPqx3oi0j8PeLCthavBqvq4NaY1Wogz+7hwgf9HLrSLJ0bC57/ucMfraTO13pdmlk4L
X-Received: by 2002:a05:693c:2b0d:b0:2c7:2c0b:f33b with SMTP id 5a478bee46e88-2efb9e84999mr5308928eec.20.1777920769061;
        Mon, 04 May 2026 11:52:49 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:52:48 -0700 (PDT)
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
Subject: [PATCH net-next v10 02/10] ipv6: Cleanup IPv6 TLV definitions
Date: Mon,  4 May 2026 11:51:14 -0700
Message-ID: <20260504185122.50642-3-tom@xdpnet.ai>
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
X-Rspamd-Queue-Id: 19B9B4C2C48
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
	TAGGED_FROM(0.00)[bounces-284007-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,herbertland.com:dkim,herbertland.com:email,xdpnet.ai:mid]

From: Tom Herbert <tom@herbertland.com>

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


