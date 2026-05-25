Return-Path: <netdev+bounces-291258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIy9MukJFGrVJAcAu9opvQ
	(envelope-from <netdev+bounces-291258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:35:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D235C7D4F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A14F300DD57
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072A3E2AD7;
	Mon, 25 May 2026 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTmgKUNw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3A3E2AA8
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698146; cv=none; b=LWE3oGTBdQ5qcZobp4rlZkFrwDIpJ1jWxkttiDVqmes4DtHaRookWgah8j0XZ1NmSM2b8tu2YPnlxx2UY6wDc2OOAH4eW8BecD4IrdEUQ7Ldo1eW0LuLkRw3AHmDYCnUUw7v3IQIZ99lYzGwX0JmRs3Fm4K3I5ieGynrFWxj6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698146; c=relaxed/simple;
	bh=Hz/U+w/bfbT0XX2UvjExjjhQtUYaYujBjGBMQayqYno=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sINUxbD4QC5ZC72Lfuw4uLNqADQ2XdJgcclb37q6pOG+3IFJrm+MwysR7DU1ptLGInSEe+QwaphgrxJVh2YKEm6fPnFjWZQ1o+hCaRmqrHaMtSlry8UNzS6rx7hqqvgvacjrLIZxvhrQ92O2WcSk1GPAjpJqGlo/HoAw0yIcqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTmgKUNw; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-514cbe73d00so269354361cf.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779698144; x=1780302944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RoV0DDmUWFgT4WUnFmjFVNS46HTfkVA4M94IpXl/et4=;
        b=CTmgKUNwPUqXIG23CCBXxAGk/j5pCVI2f5lcH/jali7zmY6dmCceKTXpgHCfOMMC4B
         xe0fmmL0Rg++Oh6Dmqnw1ebo/vPLaxfLAKfRE0ziX0JtUgIAkjNCgKuG1UtrdAr0IqDd
         MJWxRRlE8OZJbFfNo6uVTmSL+mpYe/2IDNjaGqgkhmEF/5QhQj1LRE+WW6m2gsd26g5o
         jcasLm+c3Uq0JlLIxpSCo+pmm6dSXWKWojgdWx+HZb8rcncamirXF+C9pLHE00JUXk9i
         QoebgsQu2u8rHn81PIzKw4GQUzzLRIuXvXP/OGeeqq3hT+PC3cnO86Zy8asXIIJSQk1d
         ywgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698144; x=1780302944;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RoV0DDmUWFgT4WUnFmjFVNS46HTfkVA4M94IpXl/et4=;
        b=Q3RlfTPVIPzSsTZONzSp+xiU/vLY0UKFwel1AW1TakcwodSLL5Nj9YmJzDwybHuRQt
         pmFW7vVE+QHQjrk3w822yYOJiyVlmOCXmr8fbQdTycSlhyYySs2jr40dufMyIyIC6Iy9
         3+dA5TSlLDtqr4T4gWBuP+MdVwSyLVSzyoVSMvUfQIYPneUOunjc/pS7NBVOni5cXCYo
         4mIXWPcRJJ6A3frF7i0quTnbVghz9QcO9dhl9rzEbjoqVxH5Iimrj70UUSW8hwzPuIky
         YjmR6iph1xiOSwbkH/FGUn4NBCXyjDQ+J5y/5Ht18NuVfVT6eCvw1hyy4bLXhr1d4VTg
         KpOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EWQuLDqXjR1vQgzOwaKj8uI2OKhOoeXJ8KRxSkOY4EurScciZXvdxvHUTj1yrRGsWWDf7tsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT++QA1fuHhg0wqzopyaG4AtGlUF2Gawg+pEBhupMVkfWFk+5L
	UtqKqRP52QICsRIy2HPx9XXLwiKvgahR+siAKKMYyiOObD9ScLOyQhdgADBZBg2FbICXzaOKx36
	0kTkufbrg/VAdSw==
X-Received: from qtiz3.prod.google.com ([2002:ac8:1003:0:b0:50b:4963:99fa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:18a4:b0:510:141d:9d03 with SMTP id d75a77b69052e-516d43dbef5mr179283141cf.7.1779698143762;
 Mon, 25 May 2026 01:35:43 -0700 (PDT)
Date: Mon, 25 May 2026 08:35:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525083542.1565964-1-edumazet@google.com>
Subject: [PATCH v5 net-next 0/5] rtnetlink: RTNL avoidance in rtnl_getlink()
 and rtnl_dump_ifinfo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291258-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.951];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 48D235C7D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Many shell scripts invoke iproute2 commands specifying a device by
its name.

This series improves their performance avoiding RTNL acquisition
for their (repeated) name->index conversion.

v5: fix rtnl_fill_prop_list() return value.
v4: Addressed Sashiko's feedback.
    added 2 patches for rtnl_dump_ifinfo().
v3: insert patch 2/3 in the series (Jakub reported a KASAN splat)

Eric Dumazet (5):
  rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
  net: defer netdev_name_node_alt_flush() call to netdev_run_todo()
  rtnetlink: do not acquire RTNL in rtnl_getlink() with
    RTEXT_FILTER_NAME_ONLY
  rtnetlink: do not assume RTNL is held in link_master_filtered()
  rtnetlink: add RTEXT_FILTER_NAME_ONLY support to rtnl_dump_ifinfo()

 net/core/dev.c       |   4 +-
 net/core/rtnetlink.c | 130 +++++++++++++++++++++++++++++++------------
 2 files changed, 95 insertions(+), 39 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog


