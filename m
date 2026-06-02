Return-Path: <netdev+bounces-294423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id urnOAZBLH2oDjwAAu9opvQ
	(envelope-from <netdev+bounces-294423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:30:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E963217A
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:30:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bgkajCfw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294423-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294423-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C64133005151
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C1630C37E;
	Tue,  2 Jun 2026 21:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00F243367
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 21:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435850; cv=none; b=kW1soBES5efc1YxQlI5z0JFc/uOJgT2klIv5afdOvsuoVK9BhGr3+9QCj8xU5XdkXtU9jODrxlEcOSMKi5u57Ow2HtqQR6h0Lmf+jOS9QrkT/Qkyvv1+/n+Hg7R3nu2lSbkgTjMeTFo0/H+HWS/1jbjxesKsjVzUV8Iszjcd8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435850; c=relaxed/simple;
	bh=pVHXPnf2awyDsuRcxpUTyRqWYQ3ULRucbK4CyhxJ92o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HNC20PzL7a82+3HOSKJhwwfaiWx8hMXAKAE9dCG964hMiYJp7xGC3MvfLitgvMrjCr5vMjCx1Ty8ci86GygNiNij/jBK4sRU0gMRtw/VtLwVb6PY25xnAhxHR0wvH6VBWkiaHQjepNI5VZUo3XIFlN2k9R2phUAhbsXi35FR8ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgkajCfw; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eec22fab7so3114911f8f.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780435847; x=1781040647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a6gCmH6/QnRHQRTDotoxt/bXoxx40603qOiiGXpMilo=;
        b=bgkajCfwyAhW3AjZqEFwrxQQIKGZYN2pi39A0iTAf6EzsdB3KbrS/r3vGdPhB6W4Cq
         60JIPNL6rzAsRlRN1I6FkWEByvwBIGB0fSANegxDQWrfXKhRBG+CYPrs7e5rMTI498vR
         wHNTx7rPo6iVRakTcszRdOJYPswdJ+u/u6BsALT+wVZkDaoqMnNu3AjZptmg/p06wZNt
         62bJfhBtvEOK9kjjzfd+AHdPB4vKoyOHWqli71mEtF2XNHmOGcQrVeTyP+I951QOOToi
         s2ip4aCcVbBOPRVxaisXYG+vW/KRecXumZL9UVvfETm5W3RaNbWPrsha96c+APr8xuXT
         IV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780435847; x=1781040647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6gCmH6/QnRHQRTDotoxt/bXoxx40603qOiiGXpMilo=;
        b=qi8y7CK9r/W7UWCXg0yy3/fhARzMeWH8vauU7UtLhE4SiZEbogG6JriwFu61VORSwb
         eT+QQZRn3c/Otjn3pdqbeAFUhQCWIFFLt/2SGtpV2+27yuGCX/lOj7be4BIi9FyCObzc
         xx59jbUGWrgqvxhUNSLwk5zfsAy1+LT7JZbPJ1R45nF/oD377FU6iUyS+Hi8ogp9uB8o
         Q9P+LkwAIcFXLNp319v/qiRCTI0SOv2nY65LaYqZwaOmolWm0qiWmW9S9zdnru5h+M/z
         LREakgEQNxz2J6b4pp1wruv7NI3PTlB6U/x5isVQX2F5JFadRmlKujK6VjlINHDVZEzQ
         W/EA==
X-Gm-Message-State: AOJu0Yz2ZKVLsZljLBd9gFnqeQUpVlyI5R8AThDMYZE/YLJkSVguVUj4
	+BO33FHfzQ05n5HgDBbjz+kNy7latzColOjQkPyQOTh0R9Khg8wVMofSgpWRcA==
X-Gm-Gg: Acq92OG+AbGVXOUP+QzGcUXUoU64LHVK20SqibOAWbyccY++HdqtvYaeQTCtkzQ9F7L
	GN2ybA8XrU51IKLHI8dAp8vk76wWi6R8X9YSwUn3Nn09Rg7Upev41N6ZRQOHwPbftZ7kqbSiFRJ
	+l1i7L/y3/EMrPtTfHB3mTBFejU7n1j9+4jIz26QDRNtWo6SnuTlrpiKtOMTjuUPbG/Pb0ylKsE
	5HkFe7rvOgDMMW6J78ovE5yv7q97pfL/u1DhrXTro0IhoPeNyLNGJlUDrt1ElQx+mndw23zTTTM
	JX8ELItUvI0GD2CtPB+1h5HsdSIKqCvhxFzXGk0dO08rM+NLMsuE36gmARsq2axQh1GZr071BO4
	YoKcNq18pvdDAbfrHLgrPJN56jt9A3y/5ROCpt6UkzO89xqbPK1j2ibWQggLpTGclzGnEegow+P
	5fBn8x930oRFf3/kihKIf8EqJ3kjzMeyGx/esdUov0HgpXcFXfzAnHfZc=
X-Received: by 2002:a05:600c:528a:b0:490:ade3:59c8 with SMTP id 5b1f17b1804b1-490b5e51d49mr8575555e9.19.1780435847416;
        Tue, 02 Jun 2026 14:30:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a75e:9a00:6acb:a249:e58a:8630])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b57452a3sm6925625e9.2.2026.06.02.14.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 14:30:47 -0700 (PDT)
From: Justin Iurman <justin.iurman@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	idosch@nvidia.com,
	justin.iurman@gmail.com
Subject: [PATCH net-next] ipv6: exthdrs: recompute network header pointer once
Date: Tue,  2 Jun 2026 23:30:33 +0200
Message-Id: <20260602213033.12244-1-justin.iurman@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,nvidia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-294423-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:justin.iurman@gmail.com,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D94E963217A

In ip6_parse_tlv(), recompute the network header pointer once regardless
of the option processed (Hbh or Dest), as missing recomputation for
specific options has caused issues in the past.

Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
---
 net/ipv6/exthdrs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 43f46ef9c53b..9c677eb1d1a6 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -178,14 +178,10 @@ static bool ip6_parse_tlv(bool hopbyhop,
 				case IPV6_TLV_IOAM:
 					if (!ipv6_hop_ioam(skb, off))
 						return false;
-
-					nh = skb_network_header(skb);
 					break;
 				case IPV6_TLV_JUMBO:
 					if (!ipv6_hop_jumbo(skb, off))
 						return false;
-
-					nh = skb_network_header(skb);
 					break;
 				case IPV6_TLV_CALIPSO:
 					if (!ipv6_hop_calipso(skb, off))
@@ -203,8 +199,6 @@ static bool ip6_parse_tlv(bool hopbyhop,
 				case IPV6_TLV_HAO:
 					if (!ipv6_dest_hao(skb, off))
 						return false;
-
-					nh = skb_network_header(skb);
 					break;
 #endif
 				default:
@@ -215,6 +209,9 @@ static bool ip6_parse_tlv(bool hopbyhop,
 				}
 			}
 			padlen = 0;
+
+			/* recompute the network header pointer in case it has changed */
+			nh = skb_network_header(skb);
 		}
 		off += optlen;
 		len -= optlen;
-- 
2.34.1


