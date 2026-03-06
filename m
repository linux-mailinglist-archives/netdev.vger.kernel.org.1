Return-Path: <netdev+bounces-264638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGbmAohGqmnxOQEAu9opvQ
	(envelope-from <netdev+bounces-264638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:14:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E821AEFB
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A9D33027D8E
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7184C36AB6C;
	Fri,  6 Mar 2026 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+iQM0m1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC7366069
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766851; cv=none; b=FRC+t9uWKq6unF6xr5C7jiKmnNNLens9QGIiMRF5rqTz2+jNRnFWI0U+rAlxc3oQi6Nfqc/piRaswHg9RbP6mxQ9/wdZxxfTSL4jWk2BPHxmlM4aJaeO6mhoGJ172WogFIcRfRCb7IpZEVamoFDw4Za1i/aKlLtBio/N2oV4bZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766851; c=relaxed/simple;
	bh=ckTCUOoiVNYeEw/M1IXNtDeSz8draygJacRfDD11QLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pi6aldHOMuHScI77/XgD783yU638OWrGX/GD9CwhOGR/Jmyq2Lg5Cu7R8zg/DBcrF6ktTVhK2i4wTFn4fFuL5g3ol0nhUWX7ojnuzU5ARtRv+vcE6sanfz+byiIZjNG4om71pT97VHq71zusJ/kD18r2j5INCqEVVXEviGMhQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+iQM0m1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c70d802cc05so769390a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 19:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772766850; x=1773371650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAKk9BLlPBGd+3xOdk2XRyvunkKExwApsKu0QsVvEfo=;
        b=L+iQM0m1bH7knQFT+BgbZ431B64R2E99qTPmefwUADWKexlN2vSd6NBSzS0p3lA2vN
         72cHxND6nHIEMwxhcN0nmZ84jpv4+4DLA/3wvA19VSwRCdNZ4E6sGc7ID/bZQUua71gQ
         18DhBJ5KRd860pT5uxVJ7e7YBo7Jok2FZFbbOoraxqD5JWzPRif1BnwJc/tH99Elb/Ew
         gKpcM+vCb5d0ii8/6HQDkt8J/CvTs0cQWu4CLha1J0AbHvuq9d3tD+7sAS0uykfRiurR
         t2htM4aNEg4qU39TtG8KLdSKSes5mgKv9NU95iPyuyyul7ANJCGpzWA+TuQ2VA82Vygi
         Zt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772766850; x=1773371650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAKk9BLlPBGd+3xOdk2XRyvunkKExwApsKu0QsVvEfo=;
        b=sH7TmiaEu7dOeLgEjrKqnAwLZpkC6xOE2pT3lnW+v72IjqdvZBz5aZucwDoikgQmmK
         I2jjR1c+UJlGn/0treSIKf6Zs8HxmfOOFtogRVvBFRIp/o4Z7qnM4wXLaSA3YLVkRmnD
         J0nslTf7FfPHz6h1WpF4tUU2eL7GcSaqWS5UOWHjpFA8e+5Um+7MnMdi3PgC1fPZphyg
         U3w6Nsrrfz7iHVGmYT5S+udFAP51A6mrckZ9HgRzpmgEW/JyrwKhkfu9XAnpqlzVVhvK
         XVuPhvdLssejIblYqLksP3x6thuY8hMoKC0RzlH3d3cdR57rYdg1PCJU4/yHpFve8pZb
         am1w==
X-Forwarded-Encrypted: i=1; AJvYcCXq0nxXrQoik/78XZPw1FnUEZX21QgUNWDHKo/dRLt39lQ8GqbBwNZ0zVF4F1nP+wE+JnFpEV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymkhdXpaoUFhpf+5KJkG5IfmlQtSrgXdGYPYpfZiGgxKSVa5jo
	gt0q8aUO0R7Ocnuq7sSN94TF2KX83dhCUJ6mm3GEvOafwXAc3iNfj2FD
X-Gm-Gg: ATEYQzzWLzeNmIYbDsJZkxpyc+lf1Y+Omz2Gh8vHLZW2k6M+82M2mdIB9eFCghdExz6
	A0WEa4umxaI0JtLYhqeXdFKieh9sFigyWhfjlhKyghrfUb7ButoiKvU0EQ3Qj9xc/R/NJrAbUFc
	Dtu+0ItYWo+lIN3FirmCZtyoLS6RZQc82qsQFZWl1/yLwM+73IjIxCmIat2FR7pcZr2lSbrX0rN
	TmFoixWHYPbcbjWpwocYLIZL3jdKC3o40aE/rxcjPoVmK39ZeYd+50PXLcG6RD7a/DD66xOAdOx
	gF3pDSlXk5wvGnQDCaWoLKl1ztlzgo4vdo+d+p0c8ZAH8Es4JMpAYEyzwDfLGGybbsw3vvBOz95
	lggY6p7iXSUNCo4rua5Jm8kWAzYjq6XTCitT5k1nqjUFyRhjvRKD8EYBq9NrpXZh9mHi+TZF1+W
	vs9DaL199JbYj7ql4uWTNeBx9WjqbrzjLIzYGWkB4lbFeLV51+mjN3jGIQAT1Nsmb2Q5/hzvw=
X-Received: by 2002:a05:6a00:8d4:b0:821:8145:6948 with SMTP id d2e1a72fcca58-829a2f90d65mr429767b3a.7.1772766849425;
        Thu, 05 Mar 2026 19:14:09 -0800 (PST)
Received: from 3ce1e5d2d1b2.cse.ust.hk (191host009.mobilenet.cse.ust.hk. [143.89.191.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b6c7sm144405b3a.25.2026.03.05.19.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 19:14:08 -0800 (PST)
From: Chengfeng Ye <dg573847474@gmail.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v3] mctp: route: hold key->lock in mctp_flow_prepare_output()
Date: Fri,  6 Mar 2026 03:14:02 +0000
Message-Id: <20260306031402.857224-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A5E821AEFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-264638-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dg573847474@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

mctp_flow_prepare_output() checks key->dev and may call
mctp_dev_set_key(), but it does not hold key->lock while doing so.

mctp_dev_set_key() and mctp_dev_release_key() are annotated with
__must_hold(&key->lock), so key->dev access is intended to be
serialized by key->lock. The mctp_sendmsg() transmit path reaches
mctp_flow_prepare_output() via mctp_local_output() -> mctp_dst_output()
without holding key->lock, so the check-and-set sequence is racy.

Example interleaving:

  CPU0                                  CPU1
  ----                                  ----
  mctp_flow_prepare_output(key, devA)
    if (!key->dev)  // sees NULL
                                        mctp_flow_prepare_output(
                                            key, devB)
                                          if (!key->dev)  // still NULL
                                          mctp_dev_set_key(devB, key)
                                            mctp_dev_hold(devB)
                                            key->dev = devB
    mctp_dev_set_key(devA, key)
      mctp_dev_hold(devA)
      key->dev = devA   // overwrites devB

Now both devA and devB references were acquired, but only the final
key->dev value is tracked for release. One reference can be lost,
causing a resource leak as mctp_dev_release_key() would only decrease
the reference on one dev.

Fix by taking key->lock around the key->dev check and
mctp_dev_set_key() call.

Fixes: 67737c457281 ("mctp: Pass flow data & flow release events to drivers")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
v2: Add fix tag
v3: Shift mctp_dev_set_key() to else block and invert the branch logic 
---
 net/mctp/route.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 0381377ab760..59ad60b88563 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -359,6 +359,7 @@ static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev)
 {
 	struct mctp_sk_key *key;
 	struct mctp_flow *flow;
+	unsigned long flags;
 
 	flow = skb_ext_find(skb, SKB_EXT_MCTP);
 	if (!flow)
@@ -366,12 +367,14 @@ static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev)
 
 	key = flow->key;
 
-	if (key->dev) {
+	spin_lock_irqsave(&key->lock, flags);
+
+	if (!key->dev)
+		mctp_dev_set_key(dev, key);
+	else
 		WARN_ON(key->dev != dev);
-		return;
-	}
 
-	mctp_dev_set_key(dev, key);
+	spin_unlock_irqrestore(&key->lock, flags);
 }
 #else
 static void mctp_skb_set_flow(struct sk_buff *skb, struct mctp_sk_key *key) {}
-- 
2.25.1


