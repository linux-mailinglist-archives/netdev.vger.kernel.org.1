Return-Path: <netdev+bounces-284246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOApGr6i+WnR+QIAu9opvQ
	(envelope-from <netdev+bounces-284246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:56:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B614C85A1
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB4330D53A8
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1000B3EC2E2;
	Tue,  5 May 2026 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+ZKe6df"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5E3EAC90
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967263; cv=none; b=czejTWwRkqSkSNeZ6RN0I6kGDIPZlzMkmiDfF5O/KZ//AeUH0NIP0mmf48e3yXs5lwpzpNx1gRT4yHRT7gY1+bkf4SlRFYXmws5eDpsY62VEkbplM3GsK/R7b2X8sDEtiB09fl1ppmeQlOKKfOJFC1twcpNktxlm852o4PHw6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967263; c=relaxed/simple;
	bh=YHsc3xQ1QDh3wysRC+94d47hYC5ygS3eQHirSNAVcO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AeuJGincesnQNYOhLnvs4Z/DX7KhaosN1TjcBy339HIGv6ea2n/BdYLnX3e6CmBKWpxi1uVorUKI5JjcEmXdNx2nJgqPAy3eHJwt20vhiBUq3kBdKeVDN9zYZdUWRh62ZdSH5LWZ9epdusmZ2duaFP7WkKrDstxtoUAtZH/wHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+ZKe6df; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1639418a12.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777967262; x=1778572062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrXH8YnPwNKHXnbJs+WEopyj0kRSAn4kPV0vpzyDE5Y=;
        b=J+ZKe6df00DRPg7+sJzbUxFSwB2Xjus3t/kYkUEenRSskzf4xx1Gm1B3NRbQFH/d9/
         KQ28XdacvVwygva+ZAcyE70ERBbXLoFd4udxW2+8SgLIPOvpz5Ko6DfPL6T3cBDKAhCs
         mveA227Mp+NHu0+XnUPdq0WGIVsUcGsWxpAyt3OS5ROvM74pJ2OngPFmXt+3EI4joOFo
         Z/aZgFC+xqSvuyK3AKLMwskwnmrywyNo+z0A6X0mxXgik3HaD/GRaR6cqUK/4yHuOxRJ
         qtibbisxXjSEZyVt6TmrqBb7QbpaIfrb1E3cjtbv6RDAT3KCd4/JKPvAX25/UYQolO9Q
         6FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967262; x=1778572062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrXH8YnPwNKHXnbJs+WEopyj0kRSAn4kPV0vpzyDE5Y=;
        b=oUtrT17gq0FGadp4DBkw3Xk1NkMn1jchH3hoPb2rBNUzDp4LQi7j20ZtLOxT3IrEzV
         cbAdsuISf7x1+U/j44GFmMmICMdlLjthhySu3ALh7XeKLOCJpoBn8ki8ti0DOj/SeaxR
         2zLDXhQVJeX1+Ifhhvhw8G0f+Q2thT/QihbozhjLV708I2wThI2Yd/SLaEtahiZhkGi6
         zrjJYixYJm/9XcXDgxuIDIHnT/V6x/rFFJM+DX/RTXEKwmp9ol68Kn/4gyMebHslgc8N
         idYqk5oi4bUC+hCDTYYKopG/+XtwJJcf1OldAotKKvh+ZDZ/N2+qbO1XB2pzKu/zrTol
         8Lng==
X-Forwarded-Encrypted: i=1; AFNElJ/F7DTqCWH79GB0pt1fxdRSKIUf944IB7mL8GFRCb7I7sH2qa0g2vBxdSRglPxrmtOj5m5JMxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyexNrRUfFEob9aknaxi2rDzWhPUdlg/ncEojViRBTcXIYYE1cr
	0SEAhEdKHXioKtZ6A7s/RH8oIaZ5DK+oGySrqDLf60QdEKuvTN6Zhfmb
X-Gm-Gg: AeBDietfw1cQp5fraprELKstYB4wLalbckM1WQnOZyqpXo+QUuKjrOkA8NK+e1BmzCm
	pOgUMdpyk8vGwsQXBEQaTO7BAa3YfwVyFSlM8OymKiOpoggqV97aKn7S/bg03kSNM2tEitfU0Ho
	f0ELoEMHTT0ktkHMYXQJpg+v/7o0ab90BxO8JonabiXAqWd6weL57aGKOoPiGYqFOzhw/aWdNyo
	/2Eo1rFpFVNgQB6i218ygVaC1je7FLOE2tkIeEHNT21W4Rsde9qsm3cGsbY4t4DcLM1wWNCBdlX
	ky3l9UWvZKnQVrJAFsJyGY6q8NBCRBDxWwOIr1kDAKlN4dq/iOaSq4PjpE2r53pKbc8Q4hpmJMw
	7/nI2w1sH9iMFpSAWbNFcYRbDWUzNwPNYQywCtBBrDC70A9oTx7ppXlB/fusPFkCPpTBn6SBdYg
	pfhb51cBgORTTlqA4LNSfehWrX++Ih/6XWyOCxElCWxPFPGvq8NOtMgbPwV3PAo39U/vUfBSTMY
	on2+Cs=
X-Received: by 2002:a05:6a20:3944:b0:3a2:bd1d:d67c with SMTP id adf61e73a8af0-3a7f1f1faa1mr13682082637.46.1777967261529;
        Tue, 05 May 2026 00:47:41 -0700 (PDT)
Received: from arch.lan ([2409:40e1:3007:cefc:472f:1ad7:13a6:92d7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbca2c49sm11833960a12.26.2026.05.05.00.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:40 -0700 (PDT)
From: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aadarsh Chandra <aadarsh.official.xz@gmail.com>
Subject: [PATCH net-next v2] net: bridge: replace simple_strtoul with kstrtoul
Date: Tue,  5 May 2026 13:15:15 +0530
Message-ID: <20260505074515.636244-1-aadarsh.official.xz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D5B614C85A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284246-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,lists.linux.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aadarshofficialxz@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The simple_strtoul() function is deprecated. It does not handle
errors or overflows correctly. Replace it with kstrtoul() in
brport_store() to ensure that invalid user input is caught and
returned as an error.

v2: target net-next and simplify by reusing the ret variable as
    suggested by Nikolay Aleksandrov.

Signed-off-by: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
---
 net/bridge/br_sysfs_if.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7fc0..cdecc7d1260c 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -318,7 +318,6 @@ static ssize_t brport_store(struct kobject *kobj,
 	struct net_bridge_port *p = kobj_to_brport(kobj);
 	ssize_t ret = -EINVAL;
 	unsigned long val;
-	char *endp;
 
 	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -339,8 +338,8 @@ static ssize_t brport_store(struct kobject *kobj,
 		spin_unlock_bh(&p->br->lock);
 		kfree(buf_copy);
 	} else if (brport_attr->store) {
-		val = simple_strtoul(buf, &endp, 0);
-		if (endp == buf)
+		ret = kstrtoul(buf, 0, &val);
+		if (ret)
 			goto out_unlock;
 		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store(p, val);
-- 
2.54.0


