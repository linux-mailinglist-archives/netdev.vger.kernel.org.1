Return-Path: <netdev+bounces-276568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OzbJXJn1mnIEwgAu9opvQ
	(envelope-from <netdev+bounces-276568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:34:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F3E3BDB5D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E50AC3041A41
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6036B3D3CEA;
	Wed,  8 Apr 2026 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="mjeHsqKb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E199538C40D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658619; cv=none; b=mdEqlsfQdwK5rup3kArhstOGLzyAjWLn2eBDMk4EUp3U09MoHIFECSt/A73Nwv6TC3nmnGqD/sixQ9hfPzXLE8R8p5KwkkbzthOPmVn+NjnXm8Rmw2vzNETXGsze//ngc0WKzvxPufqzsl0YXOstGISrg5LbGBBlabDUrj96Vjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658619; c=relaxed/simple;
	bh=Dst2DCgKMi9ug9DAPIQMYn4cHFxcuH3mfRheLIsl7gY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tg/LQExwSlVaeUVrPrKVWm8DCoOCV6tdiH5piIrLdqPv5EEfFWSeHhfmFVDgLXHb6RK31JqA3ZmYZJaH1OyVr6uvMVaRonA4m+WMtFz4JKlhIsX8+pBFDzXkRvj15WkQdVvkvN0FShTaCspsvqGGqOJ6/H0Ntla+8Jh3gQ38SE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=mjeHsqKb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso42449475e9.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1775658616; x=1776263416; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh5X8CvslI3qQg5feFgewpvEGHoeE9cEEW9PZC4zSTM=;
        b=mjeHsqKbdymy5MFtoqLGSd9ngD1vnwXZcxAwsPzBIs5VVdJC3M3SSC//cqc2Y9i0kI
         7k6R3egyKSMvR/5PkSQJWNJePGs7uTci0qJXLsY74sxzF/fyPwB7u0GM7b/TT1NUHA2X
         0GWYAhe9WIzNzMBhFRhxMnnJRIQba3QpjAg3fB52xFmbbEPg6YWv2TSPT6XG92ykSwMe
         sPuyex9IuTPciIPUysoZeplk+1L/jZjeX4Wm2aKPPqtdy+NrfrHwICk6uA5rwXXssy/M
         A9vj2xBh2HKJ/jXgZpHY6Yk0dxNJVYUihWW7h6kFIUG4Y2xeQiq7ngxkH23VdWOMqJEa
         2soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658616; x=1776263416;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kh5X8CvslI3qQg5feFgewpvEGHoeE9cEEW9PZC4zSTM=;
        b=dnn8s2UZIrIF3WSZ21xxIAfJWH9gR2lApRR45z0xMjy/5AMOf/NBi50KZNPp/rkXuo
         TWkMsmsz4/mAlqUrZ5bb4zjiaG+IDgTPyWgBHBDxqaKdX6KIY5e3heE7aVPGYp48d1WN
         /qTXJxhT7DtXYPy1HKQM/aif96JvZaF/sYefmROUsCWEwgUar3SYhbBJ1MHGF6JCfr+Y
         9KlTXePN56Ln49ccN6cqUKyeqpxoT/kIa7Nt6b4v84BdVXnJb5EQ58iml1fcjxfkS9A5
         YKgJW4DpTV52tgay+RbcwMX44PRLi7vIizdwIR4BDAvhjTt2HDJdq8uo27jet5yw3B11
         q0Yg==
X-Gm-Message-State: AOJu0YyFGr7CmbDdvCU99RBCpTcjle6VXQMpCFtl4cqZrHqCjRfHTKSR
	gLYsrttDkuAUby1kyanVWWmJz52jDd1jKdp6gsCpq8qCwnGfzhP5bE49i7aKfS37BqzI8gOhe4Y
	OZKOjsfBc
X-Gm-Gg: AeBDiev4VJw9iRiYnugfRNO83s9iABU//MyCZqClG2QrLPkqai8ArN6GxX34FQqfOBn
	3qEeHfeq01neButSXyDKN9His50ye6l1V2CdfTEDBRb996Y1wKb6Qr79QXFGRPebC2mS00SrHcG
	LmzzW6LX38RczrBALbwJJ+VZAeao9UFewcmwl1PzzxPOe6K4pkHbk9ns4ghPxpPAMUaVDZHqGSe
	g2iN9s0fj9GI+Pm5J42kfmDS0i2blhi5F/uLwwSts4O72TQBiz1WfvnqkP+3xgQJ+wcoRwGn/l1
	sBxvTbqFGbe7n5P/EHxvaDZ4bmnbCQsVUmf+uREsNcIiYyGlKdAJ5yFjcXX7LpyssHxfxCm4pY2
	wytGuMyjnWpZEOW9lCsac6C+DSIe3TgmCRKKApdP6Ulx989Pjr/7w/k2ObYFgRqKWiqgeYnKDAE
	j9E33ZXTM7Q+4A9rNcdVH+nwz2T4Be6ZbRW25tFtC71OIIPQd233SEu4HH
X-Received: by 2002:a05:600c:6216:b0:488:b9c6:11ba with SMTP id 5b1f17b1804b1-488b9c6139amr109175725e9.28.1775658615754;
        Wed, 08 Apr 2026 07:30:15 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c76c6205sm29691985e9.1.2026.04.08.07.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 07:30:14 -0700 (PDT)
Message-ID: <26ec626d-cae7-4418-9782-7198864d070c@bynar.io>
Date: Wed, 8 Apr 2026 15:30:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: netdev@vger.kernel.org
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
From: Sam P <sam@bynar.io>
Subject: [PATCH net] can: raw: fix ro->uniq use-after-free in raw_rcv()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bynar.io:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276568-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bynar.io:dkim,bynar.io:email,bynar.io:mid]
X-Rspamd-Queue-Id: F1F3E3BDB5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

raw_release() unregisters raw CAN receive filters via can_rx_unregister(),
but receiver deletion is deferred with call_rcu(). This leaves a window
where raw_rcv() may still be running in an RCU read-side critical section
after raw_release() frees ro->uniq, leading to a use-after-free of the
percpu uniq storage.

Move free_percpu(ro->uniq) out of raw_release() and into a raw-specific
socket destructor. can_rx_unregister() takes an extra reference to the
socket and only drops it from the RCU callback, so freeing uniq from
sk_destruct ensures the percpu area is not released until the relevant
callbacks have drained.

Fixes: 514ac99c64b2 ("can: fix multiple delivery of a single CAN frame for overlapping CAN filters")
Cc: stable@vger.kernel.org # v4.1+
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>

---
  net/can/raw.c | 11 ++++++++++-
  1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index eee244ffc31e..f042c4316890 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -361,6 +361,14 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
  	return NOTIFY_DONE;
  }
  
+static void raw_sock_destruct(struct sock *sk)
+{
+	struct raw_sock *ro = raw_sk(sk);
+
+	free_percpu(ro->uniq);
+	can_sock_destruct(sk);
+}
+
  static int raw_init(struct sock *sk)
  {
  	struct raw_sock *ro = raw_sk(sk);
@@ -387,6 +395,8 @@ static int raw_init(struct sock *sk)
  	if (unlikely(!ro->uniq))
  		return -ENOMEM;
  
+	sk->sk_destruct = raw_sock_destruct;
+
  	/* set notifier */
  	spin_lock(&raw_notifier_lock);
  	list_add_tail(&ro->notifier, &raw_notifier_list);
@@ -436,7 +446,6 @@ static int raw_release(struct socket *sock)
  	ro->bound = 0;
  	ro->dev = NULL;
  	ro->count = 0;
-	free_percpu(ro->uniq);
  
  	sock_orphan(sk);
  	sock->sk = NULL;
-- 
2.49.0

