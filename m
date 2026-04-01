Return-Path: <netdev+bounces-274043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFdBBGD3zGl9YQYAu9opvQ
	(envelope-from <netdev+bounces-274043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:45:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9C7378BC2
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BCCB31680CE
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3CF3ACEE6;
	Wed,  1 Apr 2026 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOBRxeSS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65FF3DE452
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039894; cv=none; b=s04nIetHodPw5Qytm0MxVOrQuP0C0oKgI+ln0sQeQt8rAt6lVXZwC3cciC7Utrmk6wRKT+5wvNaArQy9xIXOuez/Wo9KkmnffHb75e3Gj3qYPuIUIKtVAR+rH5TWmsMYETG9PA7QxuyKbmrkDfL0gSgsVS0YmmNYAfDT0swZ5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039894; c=relaxed/simple;
	bh=ZQY0ZsTDJLtXEEqVgymubMBDilgcol19qa87fW2fFJY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=faE67VwNOpFDQImuC+kVA49QL2oUjUrJU6B8CLywDV5+NfiMD67BCBTzbBsVj5n/+E/X5RxaeVrXsSjw3wzi6pxtZNf/OLKJqLr6syaMNSOcP562XnsYHS6bbix52QdfVuBsRD02GrezW/JERYW78lmRxh+CSCEyUpbHFjWm3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOBRxeSS; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb52a9c0eeso2543935985a.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775039892; x=1775644692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MM7hnTcLGZoTV7tJl2qgT6kRbUgGV6GNMML/ykmn7YI=;
        b=eOBRxeSSXn3NwzIWwNKvdvBRiFredsteQE/c6n3r2sBfuh4MJpuS8MB8WDtRhnOv8q
         VZdCbe8AP6M3MKi9Fpc2dHesPh/09zgzB7loWGpVm/aoBqw6MNaBua8Lv56EkSy64gwD
         i3n5dToqWjD+bnTN4CGUfZ77VIPKUML/ObiRsOUJ2MsdvzWN0H5Xa11Lq/v1Yp4esbFO
         pcRuB1eu9CU0MRImiTX/gkYqiL/PFxwQibd1GGzbQQN609uyUmSGTRzv22MlRmgYSezm
         dp2POlIGOnASsGw59ftlJMzf2xFlod7pPydqP40llrPzYaWdScvcOoo3fI/MYiCBFnh6
         paKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775039892; x=1775644692;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MM7hnTcLGZoTV7tJl2qgT6kRbUgGV6GNMML/ykmn7YI=;
        b=By9uWyQhh10HU3Fbmj+VsaWbnojiSsi9Xem7yNYmTsr6+gQZWGrQe72fUZNVXY67U0
         mN3360jGBemY12hhXeP7fLucvhRjKoTLEEpzOjKxbAXd1e6Xt06BMZya+te22YSaJZ4B
         rbI4BQ3swsv6jUpJ4imhXqsImMlcxF/T222bW50xC1nGmQsbcWC5+Ht7ZmR66aXAOU1i
         JUT3vsnEgMRc/WHrn9/4Mg7kDuL5FCOzyxv0H8cAwOdApbuNFAR905R5xrg3ZI7OxEuZ
         OC17S3vSR1iqyAZwtW4xDpW0GBuHalrh6LRYu0eUquoI85AB01zpIFsDuLNjrXnT79pd
         yzgg==
X-Forwarded-Encrypted: i=1; AJvYcCW6nnx3qPSiBaUki22ve3ozO5qZVVhBPAlBWgdAAgPlsCQNXquVkcMiFT96m6TfBXuMt7xPO4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyY178/GOoFNhWfb3nzDL3VyEQquHuKHfUj66dJSjmUlxHZ7F5
	Op7qWeA8PUQ9SGReozY696hv18Rf3EUn5EQgd4pZMf91HRfqnpTJJxgkAU7gL04a1w0AEtJEl4s
	94PiegCuge0Umbg==
X-Received: from qvpu15.prod.google.com ([2002:a0c:ea4f:0:b0:89c:cf3f:7746])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4613:b0:8cf:e933:d5ed with SMTP id af79cd13be357-8d1b5bfde9amr460905085a.61.1775039891532;
 Wed, 01 Apr 2026 03:38:11 -0700 (PDT)
Date: Wed,  1 Apr 2026 10:38:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401103809.3038139-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] macvlan: broadcast delivery changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274043-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D9C7378BC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

First patch adds data-race annotations.

Second patch changes macvlan_broadcast_enqueue() to return
early if the queue is full.

Eric Dumazet (2):
  macvlan: annotate data-races around port->bc_queue_len_used
  macvlan: avoid spinlock contention in macvlan_broadcast_enqueue()

 drivers/net/macvlan.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.53.0.1118.gaef5881109-goog


