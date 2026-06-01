Return-Path: <netdev+bounces-293754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI3hIWqAHWpZbQkAu9opvQ
	(envelope-from <netdev+bounces-293754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:51:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE2661F947
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8476D30160DB
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F25376A1D;
	Mon,  1 Jun 2026 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxW852yx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A7376475
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317721; cv=none; b=GVHa5zc/GfgMJhua69Ec1k7bc5yPnpXia5L7Dm6kNCrO7zEXinDKjB3IUpEzQpKYuiPsTaDEbR+5h2eG/iU2XvMjMTD3KAntdZQhTkMUC87lKGaG7hVm2NWeC0FNgZIbDpcAJDlyGTe/8Kv1j0xqEiH71O4r7V5pggQnAeRpN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317721; c=relaxed/simple;
	bh=lLa3R1dXbm5jQVRZkNq5qJhDciR4UCUXX39+gkdu37w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nl86SiJk9LLCprJv3tWpsftg3nAaaiam7bjVz67GZsTCpk5UCCzrZZQdikmMAgT3C+Cu/awLei4KxgCQHmmfcqAGtmGN2ovyXxMEw4IOCatqA0Zbos1YF0vl+8M6VbIRbQKjJH/VUdGjxE/r1YUqGqHgQ9YmCGjtiMslLGFQUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxW852yx; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-516d1a8a6c8so141353141cf.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 05:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780317719; x=1780922519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UnvMslafJ5nxv8uIMxjIZm5Li9agPko3XsO8opZtERw=;
        b=bxW852yxmGJpz3uMxk1YwOM44po6wuizhjCc7EB+DsKjzO6y0SsJRgdcbXTLlEXki4
         /ci55/drdzCTW3Y9z4E1MiE3GG27pwnAWLjzxICTUcBeNZtFWvfKwKaLRDCI1lIiCkVU
         nQ7U/qjlH4/EthvjcZ8u7+ELxONagVMSDaczA/YQ+NEmuYVUo3JmtweSSquCxAra+xPV
         oM7d1iQV6W6RgPfjNXMgVt5cuxryest8KX4eGuBSFzNnord5dxuc2fv682Rx8wQn2qbu
         EvN31/SijhFu9p/ov9UwbElFPjMsmHEODBctkC1ve50MxKLbolK8oGjKVwJrjwAr0rzV
         M8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780317719; x=1780922519;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnvMslafJ5nxv8uIMxjIZm5Li9agPko3XsO8opZtERw=;
        b=aQZSzvcnXrn8P5VsRyP6NBJ599wpnubYQq2sOxF2+d4nGQmDl7U1xVb8cz2+SY5tBW
         2U7zAHcrN6jQ8DTYxwYia22OSCwCjJXObGyYMGWw6bgSbRz6oI2nXEdM9uu/8K4at3Qw
         X0kdQkM/z5aICCiyu9pk0Ea/5rFRzwl7PP+ug/xvdzynm0xFFNDiuxFwspT7S14ob+r2
         xY+GeO0D9xRJSWh+Ftl2rgOU+mdn2488Xv+OLlNXgj4glvffbZPwOd90B2uWD+HF7trf
         KrASq1e5l3pVxMnTUcaRievc7NCLduWtyQJuIuNNQL1mXP/XH4eHQzZmhVJzVCvSZEcx
         2rsg==
X-Forwarded-Encrypted: i=1; AFNElJ+bjRvxOxiPCr93d7+/HbwTcHaMaxnvia7FBGSiequAjTsOZEkPUl2J1XoR4OnziEZibkPoIWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVroXtoXM26gcazzeQ2oT6lCJZwqecwbzVZZ99Q17xL1Y0/+FG
	Qb+bPVvhygfgTTTJXJJY56c2R6D54tf/UKk8U4C5pd5whifvUnvKghqaK5K6qzNXx8uJFnJWzF9
	qPnhSWulLVGK+Rw==
X-Received: from qtkk8-n2.prod.google.com ([2002:a05:622a:a948:20b0:50f:efca:a17c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:790e:b0:516:e033:f5a8 with SMTP id d75a77b69052e-5173a8daddcmr112780591cf.59.1780317718284;
 Mon, 01 Jun 2026 05:41:58 -0700 (PDT)
Date: Mon,  1 Jun 2026 12:41:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601124157.699463-1-edumazet@google.com>
Subject: [PATCH net] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Tamir Shahar <tamirthesis@gmail.com>, 
	Amit Klein <aksecurity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293754-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DEE2661F947
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch restricts setting Loose Source and Record Route (LSRR)
and Strict Source and Record Route (SSRR) IP options to users
with CAP_NET_RAW capability.

This prevents unprivileged applications from forcing packets to route
through attacker-controlled nodes to leak TCP ISN and possibly other
protocol information.

While LSRR and SSRR are commonly filtered in many network environments,
they may still be supported and forwarded along some network paths.

RFC 7126 (Recommendations on Filtering of IPv4 Packets Containing
IPv4 Options) recommend to drop these options in 4.3 and 4.4.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tamir Shahar <tamirthesis@gmail.com>
Reported-by: Amit Klein <aksecurity@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_options.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index be8815ce3ac242372eeae4a97091cda26d40ceb0..ac0d147c4b8cc347839a044adc43897faffd95c8 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -283,6 +283,10 @@ int __ip_options_compile(struct net *net,
 		switch (*optptr) {
 		case IPOPT_SSRR:
 		case IPOPT_LSRR:
+			if (!skb && !ns_capable(net->user_ns, CAP_NET_RAW)) {
+				pp_ptr = optptr;
+				goto error;
+			}
 			if (optlen < 3) {
 				pp_ptr = optptr + 1;
 				goto error;
-- 
2.54.0.1013.g208068f2d8-goog


