Return-Path: <netdev+bounces-287041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOHGKqX3AmqvzAEAu9opvQ
	(envelope-from <netdev+bounces-287041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:49:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 154CB51E0A4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A7D3011F20
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660D46AF3B;
	Tue, 12 May 2026 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JrLQHsrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF783B7B84
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579343; cv=none; b=foez8sJKYrzntgCUL6G3CRij5ccvdkcSzP0GJ4FBpP7VWOFgcmg0mAQndIIDKFttqcP7m/voyT+1yrug/n8bPnMmTDXHjbocTYPLo9gC7qnecwMydVLVt3K/T7ZB7+O4BbIZ+zjN3gPK+GN/F97M2LLmmIqfbPh1RTxE3yZBtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579343; c=relaxed/simple;
	bh=UjODPSl3ahMoXcNwNg/KcqX0FDL5WeuFcS+niaC6gCg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qXhcynW7r2w9jdirv938kSsC9i0ZAN2KA8uUYngLtRa/I/8J7TGWcl4z8QsjazvpUA/W5xC1NqMRfhYlKNgKebD3Lh+2oaAND07INNJ7afc0OAbgX9AD2mXf4zcncmdpcwVfNo46T1tEP2G91nxnERixdGdm+0bffR24IXFL5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JrLQHsrb; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8ba9baef44cso85728156d6.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778579341; x=1779184141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C+iIlCQlOcbBSotp5J/1BzZ9anzRatC0/S9SqtR3TiQ=;
        b=JrLQHsrbxlsCccac6YcgqIW3plZWrAhkoJXbJgS+Q/Bvy91KrI7ZCtaU0BW/4C+5dl
         RFw+KGb3DESMZ62LsANZBZQ1q1saXmcQA0qF8FnV4CA2emyZlEN4wsrScmijbX49oXMm
         5jQTXANoA/1fpwaiIGk3uvVCqbdtlhalI+8AfJeFhYpmqz44nJse7G9cGPED249XcJ1+
         a03zpn6Q8UqdzpYwop1LoCxxHT5hzdVb3Fa1mIMAozvSEa7Bkxg+KPo9eTYcMs942O+2
         eDcGwSS8zi4f1yZ0wZ6zkkaq90OB5vfM5Z29fYGvhcLCt64wr4URthtS8cbAzRLmC9Rj
         HwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778579341; x=1779184141;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+iIlCQlOcbBSotp5J/1BzZ9anzRatC0/S9SqtR3TiQ=;
        b=Trv5VVYQR7h+LmR6An90akLZ12hQPyAMiiiwff51jrwdLiqowmhL05aBuiuQ7XWRuv
         8Fqe91N577XhMHaMnMZjRaBoyQAAFPjsCuwlWKZizC1ii9JzfVe4aCveA9EYNJiSv34c
         wSAJ61xREX0AQEgAIJGLNNyHaVc5blvf9o2D08aXXt3FZqWdlVmmIZidIvVhHE4dT1Wl
         TO68wf04t3zp+GL6J2oXzdjOxESx3dBCa0bt7h3ZIWUU78KWzFs+03Aa1uEUMqtuaZUs
         BLG2X9vMTpWDJ9XsqpAK5lpKPh407sWC0Z93kOQitdZJG1Nr2ap5nBsxit8e8Fa/fB2f
         1yRw==
X-Forwarded-Encrypted: i=1; AFNElJ9AlCYOooq80z2zh2i9S8jO8VZuJrMPIB3JI4iZOERg4NPOEd0Q9PZrE8/2sF32UV1kiA1pink=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHuf2od/+qmVYG11VyVTZzEHXmy1dS6D/3lhjDscPDss+kfl/b
	+iLc3WAapBClTkfFJNB4bNn/xcNXuhiHo29Ij/uN0hpxDLl7yklPKjISZOXmu9ZQVUOjDgNdCKO
	c9HN4hJn7LfVcGg==
X-Received: from qvhi4.prod.google.com ([2002:ad4:5c64:0:b0:8b8:73a2:ce36])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:29cb:b0:8c4:7416:1b6f with SMTP id 6a1803df08f44-8c474161d4emr122577316d6.35.1778579340961;
 Tue, 12 May 2026 02:49:00 -0700 (PDT)
Date: Tue, 12 May 2026 09:48:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512094859.3673997-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net/sched: refine fq_codel memory limits
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 154CB51E0A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287041-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Packets that are associated with local sockets sk_wmem_alloc
do not really need additional memory control.

First patch makes is_skb_wmem() available to modules.

Second patch uses is_skb_wmem() in fq_codel.

Eric Dumazet (2):
  net: make is_skb_wmem() available to modules
  net/sched: fq_codel: local packets no longer count against memory
    limit

 include/net/sock.h         | 12 +++++++++++-
 include/net/tcp.h          |  1 -
 net/core/skbuff.c          |  2 +-
 net/core/sock.c            |  3 +++
 net/core/sock_destructor.h | 12 ------------
 net/ipv4/inet_fragment.c   |  2 --
 net/ipv4/tcp_output.c      |  1 +
 net/sched/sch_fq_codel.c   |  2 +-
 8 files changed, 17 insertions(+), 18 deletions(-)
 delete mode 100644 net/core/sock_destructor.h

-- 
2.54.0.563.g4f69b47b94-goog


