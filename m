Return-Path: <netdev+bounces-270385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH9lK8LowGl6OQQAu9opvQ
	(envelope-from <netdev+bounces-270385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:16:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A6F2ED63D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4522300E585
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C822217F33;
	Mon, 23 Mar 2026 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7w7TE1V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5D35DA68
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250141; cv=none; b=WHb74rvxYzU1XKs0/jIJMEY1VVbHyalvDyqq7W+zKuX4uqtQVnR7lAZ83aae/09tIwrHEqKSRA5zc5p8UoMgPwkOCiRu+x/D/lQED+JzKaWoTakCu/sjfA8zWETkorSthwrx4tefHP2D2KCm24KcrafzMeIpAyTdfLMcnL8MvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250141; c=relaxed/simple;
	bh=oBZX5oNsob2YIu+H4T5mZfN/nQNZqNp8MhN/QQd4wrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jvWqe0hfI+EnX7Ce63qIUbj9YI9EwHQBG7//+zlVhlstSCaFI4TPNAGrdZY/ZKqGQI51IUE2PfnJqhJ1UEncDbg9Htc7gM1sBXwDTGt+ayXyqCw7Gl5sY1M11NYNXaHbqk6wJTYmMq9PaDXTuwqp14YFqtHTBxbm0ZmpZXHgjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7w7TE1V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a9633ef0d6so6032275ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 00:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774250139; x=1774854939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G84ar5OFwPS1ZIDT1z7k87iUKtwKqphERZsWCCAaZV0=;
        b=C7w7TE1VLVMVEGiI00adW9Z0T/1ZHKDQAVAV6YCpLHLzLoBTVO8rsl/+pzbgat8+3v
         9liZfdspubV72O4cAKli/LQLFdDEtDU3u4pIRxUBlDNbw/q8k/gQRkeVk15IKyyttcb7
         XGR7xxzyGuS4iV9SCYSX9pnsZ/UG7rzEyLeuIxBjBm9v7Ffn8/IdL2LidBbguILeO3i9
         GUC96V/1WdyIN/kKYLOb8OOg+MYn2Ekq+5g/GdEU7dAsmcgp9NJqJii+LhP4Z9zjDtoY
         gpOMwIIVXj004gz3RTVzKhIIQAf02CHWBVxcMFR+3BKYKIlHArvsiOCW2VB8Vtgd7c0g
         N65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774250139; x=1774854939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G84ar5OFwPS1ZIDT1z7k87iUKtwKqphERZsWCCAaZV0=;
        b=k0WeIET+5/HnHmIKWvfusQGPBwqoIJx2DnNdu9DYK2AM/VzXc5ICNQ55UmeyTALmMa
         hQr5FbmsTMwi5R/PvLvf1gBxFWBVYhL7lFoT3TTU33MKewARikJYbbv6rhdXQv0pDzyN
         Aw+K5dDuiXiqCUg5W9YATNV3rq+2VaJxZDHKsle+HG66UBKaZFsi35iT2Ei+XzYuGw1k
         HJjJjPBRfYzth2FQpE1781vhlVSXa/Mqma5SUeyKqtTP9cMnIhTR/BaoKjR8iKddHH24
         hIqnpJ69Grp9odwpVEH3PVH1jyPSgqM0dkiXPWBN20vdjg/+mJu5ZeAhUPilWOYm1nzB
         sx8w==
X-Forwarded-Encrypted: i=1; AJvYcCWX7fBgGQAwcU52X8/rtq7hfSdyNS1PpszlaKOICn7ItjzHxc/sDLTAhuWxT8/XiGZP9ZGhU8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZujj7uVPwsJJBFouP+h68/Lr0YsTnDWlGxSODeX292vkQNTc
	RNLGbonRY/8R3CkmP/jsG5yaDit+VkmDvBmGUGbewQ6sZblq3LFki8U3
X-Gm-Gg: ATEYQzwH5Lu0zqpdPporEXWfDXsh/47qN4JsST536sYGTmvepsFZfnMVm4U/jMvTIqu
	mZLBa9Y2qzOYHnhmok3wLBaMJL/Mmp1DunKHQjS9b4PYBbE5H9K39eaFWIyKe+OIMfWvHizF41g
	qLAMOT6XHb65qi5WC/wT4fA9AWTVAjaQoB2FNVCpXORxLEwkYVfEFeOx0dnSqwhdjfyMqbCV5Tq
	jkBqO1skl5Qt5GcTd7eC7wV2TWGl1loXNtUGSl0I4BHTQJ7iiMJ9w6O3RgW2/BNrQZa6VmFuvDz
	VYBX7qpha0kUKFKqUoX5ehWO+8MlaFKZar0MWU4x0v5jIx5XaZMePA6FrobaniYPBdP5+EupBm4
	8Iv4FwRsC0rD4JGBAFsDrQWIxnXq0JiXIu6cSaIeIGhaebF6ThsE9LA+C8Q0pvlmk2lgMawMJxM
	/DC8926zryZNPl9kwSj0gMzIozmHx630NP
X-Received: by 2002:a17:902:e811:b0:2b0:4f82:74c6 with SMTP id d9443c01a7336-2b0828009d2mr73276475ad.8.1774250138885;
        Mon, 23 Mar 2026 00:15:38 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08369617dsm125119955ad.71.2026.03.23.00.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 00:15:38 -0700 (PDT)
From: sunichi <sunyiqixm@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	kuniyu@google.com,
	gnault@redhat.com,
	leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunichi <sunyiqixm@gmail.com>
Subject: [PATCH] net/mpls: fix missing NULL check in mpls_valid_fib_dump_req
Date: Mon, 23 Mar 2026 15:15:15 +0800
Message-Id: <20260323071515.1945612-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,debian.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-270385-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunyiqixm@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54A6F2ED63D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The attribute tb[RTA_OIF] is dereferenced without verifying if it is NULL.
If this attribute is missing in the user netlink message, it will cause a
NULL pointer dereference and kernel panic.

Add the necessary check before using the pointer to prevent the crash.

Signed-off-by: sunichi <sunyiqixm@gmail.com>
---
 net/mpls/af_mpls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index d5417688f69e..28bbea30aae3 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2174,6 +2174,8 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 		int ifindex;
 
 		if (i == RTA_OIF) {
+			if (!tb[i])
+				return -EINVAL;
 			ifindex = nla_get_u32(tb[i]);
 			filter->dev = dev_get_by_index_rcu(net, ifindex);
 			if (!filter->dev)
-- 
2.34.1


