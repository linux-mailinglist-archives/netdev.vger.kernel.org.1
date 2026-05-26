Return-Path: <netdev+bounces-291727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIb1MGe7FWrKYQcAu9opvQ
	(envelope-from <netdev+bounces-291727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:25:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA495D8A73
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66183307B25C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA992F7EFA;
	Tue, 26 May 2026 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxJopUR4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7EA282F03
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807333; cv=none; b=DdcFYExOnSmR41UayG01UuuZyOyH30pG8JD38vsiTuPFS/WvL4hu6MNhSD2wxdXBL5mbm+0BN/tZzz0QqPzH2tbVWT4tG1OeFxwCryrAYXTBf0nNzwEBDZS1Z7Pos9lhCZxRcSOffnzFEKhB/WaoWbiaJIV/K/9VT7BPF1QFPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807333; c=relaxed/simple;
	bh=v6L/dSrPM0rzhv8bhfzBUPfjayWMBmg4EkzMGqyNdfA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mOoZaIsitDRP6yI267R68jrHhZLUBl9+T9eu4/vUY2jNXMgsC5+NCg6PNkGJiwzf6JeFAKSEFOsVPlfEWWs8HuDXe0VkMZhJ/RtrAvSE62EEFPG4IoTNfXqspqbGtS6jkSU3BHoXtPr0P3GNARFAzv2jJV/FKcKgd3n9+ah3cKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxJopUR4; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-516ccfa109dso92701101cf.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779807331; x=1780412131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c2EPlHw48rODrmXF+15aHTZZ4V4iHpVYTIEaa0CoSqE=;
        b=BxJopUR4ngLCABMUhUZmfb/WQAEqgUuNeWUsBNfIpOtlMk3/JJVl+4zM/NaZq2mcM8
         LvE58s2oC+DG+awSE72dYUhdP0rB+eCVq6TshLnFzLN+IKAmjOqwMWPHJS7gZH5KMBoQ
         432P2QqNFteZpuz3iEBBHoslQobqSdPbNZIqalOGdlvCMlnyE7CEozCypuYsYlTxQdDc
         7aJIwzX7fPHHrUMJBdfw7Y3kZ0m9FWVWfQwDXWPdiJechiuiRcD9o25XTSAUUPUnuyRe
         CGnNzLUDU+Nx3ClN3IGEcisH3kSHXhr4CIkIUNQtoonZ93WyAFF8ft/KXAuhvaCqNihC
         jmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779807331; x=1780412131;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2EPlHw48rODrmXF+15aHTZZ4V4iHpVYTIEaa0CoSqE=;
        b=DffLb7TVoJwc9YpEMrY6ilRJ927pViB5cwWHe2x7IeCYC7zfD4MjwUJDAGd+C8MqJi
         kzY0DEcM2FpB1n1VTvg4oPfvpBGc9vLiqKUq86rCSN1sWdvnKmiO+p6IE0/Qj8Tp+ELA
         pKVjKZKcI5r+vjg0q4JfZ5nsg9khwjhCzEaX/quS5ItSUeeE4tCMLCP2ltbW4i04xn/q
         k73wv6QG6LYkUKTbP7Qgrf+DTrJ8uckHzOk9HtY+lciAHcgDFwIQJvAXWF39YDOOBVaP
         9j5N875Qtiu9OE/0JDiX1FfG7Ps9+gyjMUiuVa66AfmZr4tyKZtU0UxSZ58PR+dAj7Wo
         CZww==
X-Forwarded-Encrypted: i=1; AFNElJ8J6y1E1onFbQJgyrQwwP2Mki9Ui+WpV0+vkD7prYnVc4pxXr4vL+yezf3NoNJ+0FeDNFnZdMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN28RWb3V2dTccuXAKywc4AJAoqp4EM9eVfMxizF6sLCPggK38
	UKMdiPTK7IBVKLD+T+gM9qrWlcpJhLNz0kBPLFAeswdqPv7O/53GFe8+ZCtCdGl+k0M0yzGGMwt
	ID7K7UtKEgMZRRw==
X-Received: from qtpc6.prod.google.com ([2002:ac8:6606:0:b0:50f:ccdd:13f3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7c4c:0:b0:50e:631c:c390 with SMTP id d75a77b69052e-516d467ee64mr252253461cf.44.1779807331119;
 Tue, 26 May 2026 07:55:31 -0700 (PDT)
Date: Tue, 26 May 2026 14:55:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526145529.3587126-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/2] ipv6: frags: adopt __in6_dev_stats_get() a
 bit more
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291727-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.939];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CEA495D8A73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

First patch addresses Sashiko's feedback about a potential
NULL dereference in __in6_dev_stats_get().

Second patch adopts __in6_dev_stats_get() in net/ipv6/reassembly.c.

Eric Dumazet (2):
  ipv6: guard against possible NULL deref in __in6_dev_stats_get()
  ipv6: frags: cleanup __IP6_INC_STATS() confusion

 include/net/addrconf.h |  5 ++++-
 net/ipv6/reassembly.c  | 46 +++++++++++++++++++-----------------------
 2 files changed, 25 insertions(+), 26 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog


