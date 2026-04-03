Return-Path: <netdev+bounces-274988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ5PDlqez2kTyAYAu9opvQ
	(envelope-from <netdev+bounces-274988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:02:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D53FA39378C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DF053021D2B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88B3128AB;
	Fri,  3 Apr 2026 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA7zDbdd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2632DD5E2
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214165; cv=none; b=mPxGMYM48HhLTc/3JvkqaI8sE4XBYGsGMPIJPGw74uUx8N6uA4ecPPiik++WW0Gf05BXciZK1TcKpaGeVmhIaJ2btkkUxIBWcrWqfnzC+uZZihh9txzPLNB3+wcRPncvW8BY4ok2lYFTQCoEb0zkvWcbojgsMiAMxr6l85/3CO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214165; c=relaxed/simple;
	bh=eedoNAwJwYaHwcpnoaYa8ahQY44WwzEPaEBlIDppj6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KilfrZSXiw+sjH2Idgnr0TuesnUAfFjULuCELw6mBgd3DCMsmygSDNwraGxfRViO48ug6nqAR6+EOgMdD2jWvQIYyTwdEPQ1/tqB5Nrf2kXzd+niDhaLNNaKunvbaAcm7oncgrEEp0EfZMBeJcZYLzm3Hkaz7z7DOuSsOyyRh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA7zDbdd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488971db0fdso7685725e9.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775214161; x=1775818961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Adrct6pMYPSwu3pxZgxpJsWW0ral4Y4beVwmsP0F2Ys=;
        b=kA7zDbdd/WVQ4Xx/q55U/dn1i9eFgYKUiJ511MB7LYzhsrkw/nZk5aDMbW33rP59Lk
         EVmBdMyA05nLQSe86QRJcLwMrHkBtoB7k5mnNic2toVIA/5uGSFZgP5tvkW65J2Q6Q7G
         OPyRx4bL+xDFcpII5yvbJ9XQNXiMVFbHB5EJB3acnlKSygiMhudrkv8LhbYLnwt12LwK
         tKNPanZEXE477mtVoXzCmkLVNkprcaIblo8uEEOrkNgAK78bHKCXkCwUAjFVFIkQC0Pa
         ed2r2ofVdWTtgvn8h/easI5qusjQBsuo4ieTgaCJMz2Qlb4VnpwPhLD4j5b16LGw/KnF
         HOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775214161; x=1775818961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adrct6pMYPSwu3pxZgxpJsWW0ral4Y4beVwmsP0F2Ys=;
        b=cdx7ZDqpN4vDOqQLmx01UUP/ady6yCeLah+w1Sr+/3Ju4CnRZTXkj68Y5VteKb8XoJ
         KtFUfPkCh+eBPdeaQUDdevPV54r6+JTLO3tYQLaUc8Ocd5e1ivcH9Gab0ZrnUx1P6W13
         62VkOmp5tnWPUg8hB35Z9/HjzgbCtnQLOKqLKUKNoO+1BiAsMAfJOFwqd2Ic37kvhyNN
         NHJATEZqzNrEVV2Y4dRUrL7yVUsRa428iKG/hj01QPTFrlQM0M4L16tbF5WI2C7KkPd6
         1icRLg/7oE4vuF06qBXzppAXOrhYAesvjwhkx/7x/z+EpdA5qIuZXsf1MUmosn2kuc9+
         qCfQ==
X-Gm-Message-State: AOJu0YxMB0C1cLLPn6BBBe5mkYYWv3wcfSzeMs0vBDp78B0ulpLguvXY
	nZcsLr/poPTHqP2BK/f9yYYD6MXS0sP1yhAhsnVqYKkf2jO1X5HP+6OS
X-Gm-Gg: ATEYQzyZWZ63SGQumLRolZ1aSwlv4aw8ifx9fCVgrmZu5wqFVRgtqwdrRPgpTiOfGg+
	VnCQTBcpR2ujZCXtygfIslAug1SFcdQle2lA4rYmDsf8MvsQ5Za11Nq0IXgc1wN/pYIVC3gT8BP
	arJjvR/znKEnYAvFeUkFmmw43UfQYwsLRAxqQ+hPNLbK4CIeBVO1iSMHxumvWGONVcjyeMKRIR1
	mrrxUfHyJl9bszPBwxN7TlKyV9sloVur0HbAuoyzv8I4eFqkfWJGtXI8P64PKQPizR0Pwuqe2xj
	jFvm5kUZ48HUpYzlNTUxsaeQQv2J6caw97B49DEBsh1Z2UGrcmFE9oMfHZqwXoBrnsVD4Lj+qjR
	4FCGQMr/GigCO/mI3m0qgTgmJUTX6V5oVNNJy+U9jQcDeF7tokbwg6pHrA6VAMNg4z4vzdiz7Ty
	0lYFbLdso0BKtA7az4ehGy+wEwSzIdfQxLNtGsPBIFp94kuZsAt4YH20uK7yX9IQzlg7lsURFqD
	iGDR1k3Gpyug1fZuxGDk4I=
X-Received: by 2002:a05:600c:8b33:b0:485:3fa9:358c with SMTP id 5b1f17b1804b1-488997b2291mr46130995e9.17.1775214161385;
        Fri, 03 Apr 2026 04:02:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm18108325e9.12.2026.04.03.04.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 04:02:40 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: "'David S . Miller'" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net/sched: act_nat: fix inner IP header checksum in ICMP error packets
Date: Fri,  3 Apr 2026 12:02:38 +0100
Message-ID: <20260403110238.16596-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-274988-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D53FA39378C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the inner IP header checksum when rewriting addresses
inside ICMP error payloads, matching netfilter's nf_nat_ipv4_manip_pkt()
behavior.

Fixes: b4219952356b ("[PKT_SCHED]: Add stateless NAT")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/sched/act_nat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index abb332dee836..cd1d299da57c 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -242,7 +242,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
 		new_addr &= mask;
 		new_addr |= addr & ~mask;
 
-		/* XXX Fix up the inner checksums. */
+		/* Update inner IP header checksum after address rewrite */
+		csum_replace4(&iph->check, addr, new_addr);
+
 		if (egress)
 			iph->daddr = new_addr;
 		else
-- 
2.53.0


