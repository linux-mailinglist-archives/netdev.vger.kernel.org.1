Return-Path: <netdev+bounces-300894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y0EJCkoyOGoJZgcAu9opvQ
	(envelope-from <netdev+bounces-300894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 20:49:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F496AB75E
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 20:49:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eW03vsjK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300894-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300894-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73D04300DA61
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E67A370AE5;
	Sun, 21 Jun 2026 18:49:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77840D57C
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 18:49:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782067781; cv=none; b=MQRgT2dAup2T7clWjFJdgB46J8wwakbMDEhENdoqs5Ct8AN3QmSGQi0Ek+PpuL7Pe1rpeskhjm382jAA48xwNXimmgocYd/JbseseM3eaC3h/+wbLMT0kE7y2bEkVp/+NybXry9VfLAlz7fNaBGu0fD/iOXxcz3EtueKzapfB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782067781; c=relaxed/simple;
	bh=fg2Z5yWsPrCVVJ/sEpZZmfaN50vF39KwM6Wf//qFPP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQ8ufhZuEm4fi01uZjtaj3iEnJRrnMy+0zoJEbM02ki+BcPsBcWX6eHiIkobQvozjHJ5JWoz86/eUsySvj4UuK2gjNiB8wPkoF9ekIfE37wNz2CaMgNuivZGP/+v6MiFvuhF6lAcjicivjTEVj2pt4gKvsApV8gc1jbBidVirEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW03vsjK; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b7866869so36048955e9.2
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782067778; x=1782672578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQS8YOQaAmDtiitnaliN5fbm65W+3tVHNnmASlMo0A8=;
        b=eW03vsjKPSSwlblgNf+XI+zQGrI6Ba/pNV1W+smnKqqCCTA2LjVzi+yRXGP2qGSiL6
         dalDweebDvIP//TcuiA40Nc0mb5TxX81WfbAi0C5jDVyIWBvWIDlzWEiVMVQkdj5R1ek
         h0+9ZL3psyx3Xd5rFYFF8trG74njfwisjy2big8K9TqWOYqlurg5El/IwZ6lxv12P1Ks
         qkJ6vI9eOcKUvRrpDAV+Am2FMfa9oAiPOD9QNIggLSkXgbQe2JyrfgW/xvlY9Bdriijw
         UakY1u3+hgz+A3DhHxrKE/k+VJN7xUioZw2fcvqVJkcTIM8cYWX4iGsg54dt7k/Wb6dw
         pjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782067778; x=1782672578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HQS8YOQaAmDtiitnaliN5fbm65W+3tVHNnmASlMo0A8=;
        b=ehldKzZLPCbQYtkewwVBNFv/9GBpSyNg5aTKDjD+MyAKdzs3/W3ChpsALOYdewIjMc
         IQODpTvr1gU6L8TjU7IqBXclG9Hgoc/Ys6+YWZA58a2UimPAK8onkIcdkGtuVwNoar5w
         65e1ZxVmuSEKhNb56VFuNNQ3v4WdqH9PiY+cuAe/tefR6d0iLvzj12Q7ubAqpBSNXQma
         vg5es6INJACF5WeuPtHv3puiKJ409+3rYytx7bn8ESu/H07J97G1rkaTzZYPaFvw6TZA
         eTU8f/6WgmdNsdPQ53N0e6SA08tSbfccItjarp7dM9k00TzSnmayV6pK3GXlZccEw+k7
         LDVw==
X-Forwarded-Encrypted: i=1; AFNElJ867gtYhPOoh8882R2ZBt3jubn7Y+FIi6aARgLg2fG6ELgBkyRITQs7xcXumY6cxERnvCnGIac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOU1IBmLCToaAXg45cmdOIS+TAsmhplIb7/353H6CVyeXVMFF
	qo3cwV72wO05DWJcEjAVMjv24EVHGk08xL5LkceS/HjBibr+XATNI+C7
X-Gm-Gg: AfdE7cl5tOHHTXlbhVojvmSB49iPX7ULJJSeIpI1Dey26m8I6l2g029mdRX8iOhLwAV
	RUYfiUIEp+nK+xXFYRcc8KgpZ4EOnBHyx0zTbWKNnf8tM2KkYn6DjQieNDnBBxt1vPli9+xtSOm
	29Mt6GCSA0Po6YmMEzCnudLw0oo+F8LYnajOI1Vmr6qSDcvWFvJboRRkK2NCRn15rYDoLhZQiPI
	dqo4gOrGx2i3GSavYukunmoQ6LGL1oMdyG6s0XqPG8QhuyfneX2i8gYFlzV6kU8W7Ob9J2I7802
	XH0kkNs+VG/MacQ3QAmf34fp9P8mBxQ+wInVZOTNH4HP+lQwbreEJyMfMP8CWBjV+v3B69/TdKo
	uwMacK6HTDMvuLSPDeh2vN1DkhNDEM9J6Q32CJNBADiCQqeyXtSms0DmlAxGFKnO/MgN9aQi81e
	YgniTIWySVv3aXu23pAUYF4SWeahMNJGlwu84fzaFtvuD81ZM2odlob93E0Wh2ih1oXJsoKzxYu
	k459Q3qb+L+kG+QCmcWzLgQ
X-Received: by 2002:a05:600c:3f12:b0:492:40f2:4d78 with SMTP id 5b1f17b1804b1-49242326cfemr123932785e9.2.1782067777843;
        Sun, 21 Jun 2026 11:49:37 -0700 (PDT)
Received: from britney-pc.tail2180da.ts.net (host86-132-246-30.range86-132.btcentralplus.com. [86.132.246.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5397sm21085938f8f.13.2026.06.21.11.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 11:49:37 -0700 (PDT)
From: Kacper Kokot <kacper.kokot.44@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fmancera@suse.de,
	fw@strlen.de,
	david.laight.linux@gmail.com,
	Kacper Kokot <kacper.kokot.44@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v3] netfilter: TCPMSS: handle packets with unaligned MSS option
Date: Sun, 21 Jun 2026 19:49:33 +0100
Message-ID: <20260621184934.75832-1-kacper.kokot.44@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528223412.27311-1-kacper.kokot.44@gmail.com>
References: <20260528223412.27311-1-kacper.kokot.44@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300894-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:kadlec@netfilter.org,m:fmancera@suse.de,m:fw@strlen.de,m:david.laight.linux@gmail.com,m:kacper.kokot.44@gmail.com,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,m:kacperkokot44@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kacperkokot44@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[netfilter.org,suse.de,strlen.de,gmail.com,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kacperkokot44@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4F496AB75E

RFC 9293 permits TCP options to begin on any octet boundary. Padding
to a word boundary with NOPs is a sender convention, not a requirement,
and robust receivers must handle unaligned options (MUST-64).

The xt_TCPMSS target's incremental checksum update assumes the MSS
option is word-aligned. When it's not, the modified bytes straddle
two checksum words and the resulting checksum is incorrect. The mangled
packet may then fail checksum validation and be dropped downstream.
That said, all mainstream stacks emit a word-aligned MSS, this change is
motivated by spec conformance rather than a bug observed in the wild.

Extend the checksum update to handle unaligned MSS options. When the
changed word is unaligned, the modified bytes b' and c' straddle two
checksum words w1 and w2:

    | w1     | w2     |
OLD |  a  b  |  c  d  |
NEW |  a  b' |  c' d  |

The two-step update C' = C - w1 + w1' - w2 + w2' reduces algebraically
to a single word incremental checksum update with byteswapped operands:

    C' = C - w1 - w2 + w1' + w2'
       = C - (a * 2^8 + b)  - (c * 2^8 + d)
           + (a * 2^8 + b') + (c' * 2^8 + d)
       = C + 2^8 * (a - a + c' - c) + (b' - b + d - d)
       = C + 2^8 * (c' - c) + (b' - b)
       = C - (2^8 * c + b) + (2^8 * c' + b')

So the unaligned case adds no extra checksum operations.

Signed-off-by: Kacper Kokot <kacper.kokot.44@gmail.com>
---
v3:
 - Reframe as enhancement, not a fix (Pablo/Fernando)
 - Rename subject to xt_TCPMSS, drop "fix" wording
 - Reword commit message: packet may fail checksum validation and be
   dropped downstream (Pablo)
 - Target nf-next (Fernando)
 - Use __be16 for csum_oldmss/csum_newmss (sparse warning from
   kernel test robot)
 - Reorder local variable declarations to reverse xmas tree (Fernando)

v2:
 - Use get_unaligned_be16 (Fernando's suggestion)
 - Fix alignment check expression (David)
 - Mention it's a theoretical bug in the commit message
 - Drop cc stable, the bug is only theoretical

diff --git a/net/netfilter/xt_TCPMSS.c b/net/netfilter/xt_TCPMSS.c
index 80e1634bc51f..037add799d41 100644
--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -116,9 +116,10 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 	opt = (u_int8_t *)tcph;
 	for (i = sizeof(struct tcphdr); i <= tcp_hdrlen - TCPOLEN_MSS; i += optlen(opt, i)) {
 		if (opt[i] == TCPOPT_MSS && opt[i+1] == TCPOLEN_MSS) {
+			__be16 csum_oldmss, csum_newmss;
 			u_int16_t oldmss;
 
-			oldmss = (opt[i+2] << 8) | opt[i+3];
+			oldmss = get_unaligned_be16(&opt[i + 2]);
 
 			/* Never increase MSS, even when setting it, as
 			 * doing so results in problems for hosts that rely
@@ -130,8 +131,25 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 			opt[i+2] = (newmss & 0xff00) >> 8;
 			opt[i+3] = newmss & 0x00ff;
 
+			csum_oldmss = htons(oldmss);
+			csum_newmss = htons(newmss);
+
+			if (((char *)&opt[i + 2] - (char *)tcph) & 0x1) {
+				/* MSS option is unaligned: the modified bytes
+				 * straddle two checksum words. Byteswapping
+				 * the operands lets a single incremental
+				 * update produce the correct checksum delta
+				 * (see commit message for the derivation).
+				 */
+				csum_oldmss = htons(swab16(oldmss));
+				csum_newmss = htons(swab16(newmss));
+			} else {
+				csum_oldmss = htons(oldmss);
+				csum_newmss = htons(newmss);
+			}
+
 			inet_proto_csum_replace2(&tcph->check, skb,
-						 htons(oldmss), htons(newmss),
+						 csum_oldmss, csum_newmss,
 						 false);
 			return 0;
 		}
-- 
2.43.0


