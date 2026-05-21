Return-Path: <netdev+bounces-290434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLIjIzsND2p7EgYAu9opvQ
	(envelope-from <netdev+bounces-290434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:48:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2215A63EA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2003132C6781
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0283DD50E;
	Thu, 21 May 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHTKX+kr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098573CBE69
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369568; cv=none; b=jwv472cOsAJFhRfAcvKcOY9/mx2jmQq876f68kG3NhjvxpZVZTciZM3eCM7WrCxhQxl7AHsE7fXqXS7TiKsByvs/y4l+BvacwwooDlKha42keszVLm9RpNGa5Fnxq2sWh9T1lbyMKp8DLsbvlqXVTdHQepGukPC9VWBLHADmsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369568; c=relaxed/simple;
	bh=OoFGuLUd2tkNBbXFcQJUzpT7hjCT7Ocksx/u0YUB35A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sKSuj1k0jwDP5UVHHGShPcxM8GDfupHoqC+R7Aka1DlIlrCCBbfGt6dbdJdmSexnDHqXEDrl7CrMpxdaOz11GDxLHUbvW+DaXyxFCfZvZ2rp9p5tvnf/IIsE/pEo1Gy3bqzMYTy7f4pttgelhn2H6mTKXgm9qjeJRFnNSgS6vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHTKX+kr; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-631289505b8so3191418137.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369566; x=1779974366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XrXa7oLw561e1yfRozQ64g6UosDCCrr6GWOyzxmYFH8=;
        b=WHTKX+krbjyHXyEmd4YDoULhNVTfGSxINzwi9TCej55eie3DtjFsnIhwC9E1OtZWzr
         ipPTSIVVktdfHnJ0qzNK33aG6NljxIaw5o3YGZJCjQ8h3QcfZ2apFFbLps2bl4ErlAxb
         X/cYvcchU2/O5pzcBLnl2+S/q2A+9T2qP+4yCAr0A+EtsNr9dmIilmFVrykLECdzawNC
         i7nHf0HWooZFE8/29VHJgRT1q+llVdx8kjenPnz8xK3PofuX5zUfPv+I4OI027S6MCWL
         sHEo2Sd5rdWAy4O/8YU4jfMRlrV3miCcrFaOrmOFVUIROmVFLX/WFNERuTyyUWEhuuWm
         HJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369566; x=1779974366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrXa7oLw561e1yfRozQ64g6UosDCCrr6GWOyzxmYFH8=;
        b=RR2j1Ve954VGim0g0DVrh9ZFpEMXFSCrXjqlr5wgxZizrByxm9ttqL+bHQL5f3O9EF
         nDOFGs2ZQwg+DQoHxubVBD5I3Hcy1OyOXLBP6X588Qeb/5qrlI9jFnkr/kLGhEcqlQXi
         3c5zqsW8zVDTIZGJE1yjqYzSFQYymT0eO1sUPfMNFQpF43y2IruwEnr3sF63SFXSP7iH
         7eq/fne+WfFVVOlAjSoek9SpVfdJrzrBwrxG0mUgArrnex9zKcknLHsfJwh8cuXHeS75
         htvrMKRDKb80whTfSRpMy/E5+5VYzEspRjtYRkAWF+vScRX9ilDyfxu0oeDXSXbC52Fj
         Xc8g==
X-Forwarded-Encrypted: i=1; AFNElJ8YvPTmb66oJGj2sYZjPpvYwsLSVjcU/QdzvJqXoLbY/5GpHH1ifLsDQSBb926rJGjoxp4JmmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVs5kDEewsRUSaMUVGMHJeQCq+E9/YTb9eso/chap9fbcTguR1
	XzebXWMfVN6vGTYLdjFkdPBLHbhIxcwhGtFRgh5XF9Ipczmtn4hEs2dfwojFEdiULie2Ebq2UEM
	1tJm1WCtLwBtgew==
X-Received: from qvhi4.prod.google.com ([2002:ad4:5c64:0:b0:89c:eb9f:c69f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4a85:b0:607:5cd7:d7c0 with SMTP id ada2fe7eead31-6739878b93emr1298120137.19.1779369565579;
 Thu, 21 May 2026 06:19:25 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:08 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-4-edumazet@google.com>
Subject: [PATCH net-next 03/11] bridge: use BR_PROMISC_BIT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290434-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B2215A63EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use BR_PROMISC_BIT and set_bit(), clear_bit() and test_bit() lockless
functions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_if.c      | 4 ++--
 net/bridge/br_private.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index d39571e13744431f5e4c67f34ee7de34eb8bb6b0..3169fab686a534cf2a6458ff228eee2b6fc7e7e4 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -110,7 +110,7 @@ static void br_port_set_promisc(struct net_bridge_port *p)
 		return;
 
 	br_fdb_unsync_static(p->br, p);
-	p->flags |= BR_PROMISC;
+	set_bit(BR_PROMISC_BIT, &p->flags);
 }
 
 static void br_port_clear_promisc(struct net_bridge_port *p)
@@ -133,7 +133,7 @@ static void br_port_clear_promisc(struct net_bridge_port *p)
 		return;
 
 	dev_set_promiscuity(p->dev, -1);
-	p->flags &= ~BR_PROMISC;
+	clear_bit(BR_PROMISC_BIT, &p->flags);
 }
 
 /* When a port is added or removed or when certain port flags
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 02671e648dac7ab6fd59b80e044f62b00a8e4a8a..d55ea9516e3e369bb9e0045fca5b8d034ef5a45f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -452,7 +452,7 @@ struct net_bridge_port {
 #define kobj_to_brport(obj)	container_of(obj, struct net_bridge_port, kobj)
 
 #define br_auto_port(p) ((p)->flags & BR_AUTO_MASK)
-#define br_promisc_port(p) ((p)->flags & BR_PROMISC)
+#define br_promisc_port(p) test_bit(BR_PROMISC_BIT, &(p)->flags)
 
 static inline struct net_bridge_port *br_port_get_rcu(const struct net_device *dev)
 {
-- 
2.54.0.669.g59709faab0-goog


