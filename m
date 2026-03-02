Return-Path: <netdev+bounces-262767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH4zJvnMpWm1GwAAu9opvQ
	(envelope-from <netdev+bounces-262767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:46:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA61DE017
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F132630421F0
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 17:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE8E42F559;
	Mon,  2 Mar 2026 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeCDb1pJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1B4266AF
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473328; cv=none; b=UOdCAJS8VkGRf2sAmm8iwwGASR1EfgpzMpn+Qt8MVJ0bLKoYzeq4yDDT2FFL09BHoeHj0WbUZwFHhVwO+sWaeM9Mx8VStrkcIspPHbXjHcIUEt8taFAJFmzrJ7+mzPHRBbs4ARKj/sG1GntmM1nknACBT99s7RR6eXxMoJ+nWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473328; c=relaxed/simple;
	bh=sw2wHKfJSAzmQmZwslpXQ1PpiK12/99FlnxDoFyZ23o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gk28HBM3z0cS43TPbmshMUXW1v8rv4fLqczquEp7g0aMiFgu1hdYor0YVXj6lYWNuqAgCYFjKjw9BHi9gGXAwJQEY15qKMNo4UnIVAeptZpJubqUo6PtkeTc1sar5TLoBW6Nl6OAFeFI/qZibhvXaqVfX2vUcVTNBar/J5KznOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeCDb1pJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c635d5d594dso872782a12.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 09:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772473326; x=1773078126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiKuG4Lyheqb/uyESaUUXi3kehpW/GfHJycrvtP1NTk=;
        b=GeCDb1pJOgkrHljEYcfz9WPtqj8MdhQa2vk2bgAVvH3W4H7jV/4/krTynqcBY4fjMy
         tEs0ANfy+usi8Az+ug9qJfY4vT0g/KUtxX8vI6t4Z1bGTOvX2HcWOnBJ4LancUXYSn24
         GPo99iKurVF/PRAoMBU07yFPxx8R2To0Io6pF1xmXghcxadhjrE7RuC7gnhJSmCFlSVY
         gKmjuAUoHu/vR29xjz3E0z2Oyv8T/M/4AvBztu/J48E4XLtKCjrg/KPilmr7xbaK7Mf2
         Inu2bmDp9dWqaept+5hU09QSQXaVZzmguOgGI7nqMEBHL1O0Z8ilR+hGsic85JjcIxLV
         y0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772473326; x=1773078126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiKuG4Lyheqb/uyESaUUXi3kehpW/GfHJycrvtP1NTk=;
        b=iAR/UsEb0Gwr7RjsbhrB6VrorvVQPOj71rM1s2IkVMzNygwJLlHfTsZKgkQTbauRPM
         HYgOpWIfJDQdu52awz5JGKgPUXzwCrvewor7Atu0UVOLZ6kchI7EjTkHon7tXGi5JhmL
         6dO1PImxwH09T5MAyDLsGDlbGeQsfbhkNr94Ij+qE2b5uqPBu7tc/QT7mroL8x18qUch
         uQwRoRzup2gpaFkWF36GzTEWLYzSHztY6yuMyms4rWuaTdSLc0wtk4k8QiHFbwsCcMgG
         xgCpA8AA/KC7S97liJjiyRKse01o7mKaAwrStUSF2JI5xGZWog0I+NnAP1F0n7eq7qFy
         QCPw==
X-Forwarded-Encrypted: i=1; AJvYcCUc5nWi5q8SN6NnVEmvWnNHq/Q/ShOLZd5qz8YmIbBmi+tyMdLbGhpZzpU6bCd2FGDND5FGEd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOqhaxV3Osk3DF2Xf4gMI7xrXd80E9U/IRKvvktEY0dqqpuZQ
	A4NF9jwwDqpQ63VqN9ffNlKv03U7k0X0QzZYi7nbBxasvjVkHqnciFNY
X-Gm-Gg: ATEYQzxFOeFTQWrxKGwVOBSMh6Iembqlu/4mKuwy7gCNIjBsdNWTjHfDYaA+EcV0BOV
	zeSgHx51VbMui9pkjQErh3AYXVnnBZPiycpR96rPbC/3gJvLNOg0/yoVVEeuw4mtuTYu+q1sV/w
	6NIVB5aiiMDg7zXDeXtFo6xNsE1L+iLyhWmnvPil+bTvQo7UJffDuYxCWN49BXDqLCo31lF8/KI
	OglmtwUQ46zxHdyQLEtWsWweqCai+vSzF/Yc+u4VWVZaX+GdofYHdl32yI+5pFbHCpM3z0QVpfN
	zde2W2aolASLa5hoSOntkOOIHbJ1iypY67HgYETTUg21VZbG9AYBtyPR4hUqatCaw9jnbEcPUeB
	s7/CNoN9IYMPpzzkTXUeVm83mu3DiDis8AnJP0FGgJLr7pivD15ZDTmuj9Bk9DA4to181VDBwvw
	qXjQvThGu+xr6O0wBxuOGUjmNYAdJJLteZEimvX3BcZSbtq1jPRuo6QQU2quso+YIpcIhysK0=
X-Received: by 2002:a17:902:e88e:b0:2ae:5d79:a163 with SMTP id d9443c01a7336-2ae5d79a4e9mr5067885ad.5.1772473326107;
        Mon, 02 Mar 2026 09:42:06 -0800 (PST)
Received: from 3ce1e5d2d1b2.cse.ust.hk (191host009.mobilenet.cse.ust.hk. [143.89.191.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4dcf80f2sm43115995ad.90.2026.03.02.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:42:05 -0800 (PST)
From: Chengfeng Ye <dg573847474@gmail.com>
To: jeremy@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] mctp: route: hold key->lock in mctp_flow_prepare_output()
Date: Mon,  2 Mar 2026 17:40:56 +0000
Message-Id: <20260302174056.796540-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01BA61DE017
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-262767-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 net/mctp/route.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 0381377ab760..4a1ac55ad31e 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -359,6 +359,7 @@ static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev)
 {
 	struct mctp_sk_key *key;
 	struct mctp_flow *flow;
+	unsigned long flags;
 
 	flow = skb_ext_find(skb, SKB_EXT_MCTP);
 	if (!flow)
@@ -366,12 +367,17 @@ static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev)
 
 	key = flow->key;
 
+	spin_lock_irqsave(&key->lock, flags);
+
 	if (key->dev) {
 		WARN_ON(key->dev != dev);
-		return;
+		goto out_unlock;
 	}
 
 	mctp_dev_set_key(dev, key);
+
+out_unlock:
+	spin_unlock_irqrestore(&key->lock, flags);
 }
 #else
 static void mctp_skb_set_flow(struct sk_buff *skb, struct mctp_sk_key *key) {}
-- 
2.25.1


