Return-Path: <netdev+bounces-291587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GLFKsNcFWp7UgcAu9opvQ
	(envelope-from <netdev+bounces-291587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:41:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC55D291C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FA553009F24
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4236386572;
	Tue, 26 May 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="HlAlxkXk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C43CCA05
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784868; cv=none; b=pjGjfRkpdmIhbKtgTGzDWQc68fi62QT0qDznNLzdpvWV2gnBbe0VymiXBJaAjkrJtUxadlcDuwp6vzgrXzjYC4JKPiDgcVb8QZcphATYSBo6mPgSbTev7sPt2TwJu1b2qLEf72yKPch3QVq6syWUWy+Mwf4Oq/poBDF1GgrQPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784868; c=relaxed/simple;
	bh=G0FN6kA6Tea78nrlCADVDkW9gVxo/7otmN92WP8pM/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AYEP4ZtvGwZWgeuB/R6LP6biSrshPzDNZOR/1ih6NGy9cZZEKpqq2p9odqXogav/d1kxmM0lz611olCCRQL/tehdMYmwturP7B+XdQjdvYEYcdTzaQhfxOquTlCAZOUzrOwETc2uwOmAT8xg7BzYBlJdhqDC1ocXmyeqQtxTfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=HlAlxkXk; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-6870a365c77so11655527a12.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779784865; x=1780389665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBCQDeRY4EmCQ0kla5Ex2x+xLWc/2PXpf9maOMSgAy4=;
        b=HlAlxkXk11+RmzsSwWzeOP6wHqLu1JXCIRbBeA0ME926Fr4AFZHDYfLQ7Kv+bR2yq/
         t+AS1Z70PI+2t21ohfzZDMbhXG5NAOgnrqkW1GoosiKgtHLFXgeI8DaGDxf1xUeDu4oZ
         gwrDRQ/TQZtOuFAp4AG/Q00lqijGW9WHc3b20p0yg8Z76RQj05oWuX2EB4zYPeQjK6v1
         tzhn6P6Htvd9HjQ2JDKdTXwx+2IHwb7pJ+Xp+HInMhfUBJPhFSQ3BWj/wGBkJvXqU2gy
         oj6vrsHvcUttAV7mln7i1NCrq515pCgcw1F+XJJgxMksomNr4I4d5Bm8/nb4RLKEDV87
         o3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779784865; x=1780389665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBCQDeRY4EmCQ0kla5Ex2x+xLWc/2PXpf9maOMSgAy4=;
        b=f9h472z9pv1jgaMR/B6tMoZnt3Ulo6ZdAaLbazKqL35FSYhYnZCRVoa7t3S/5e2hGl
         QTTJBmU4/U9vwOXmFzI+ld5Ba1FZhHkTty89P+ZzntIgUFkXXJhNbrQVwJdDOKOxgwVm
         soBRFzQBRaxaTO3RmGVwaqEsDrES4wwQs3ApX7QG7eUTTvgsWrxhAScw5JhFpHNgRdXd
         ltB5CO5CvWHiwGJTXUUkA3PEaie3bCcQMkoXgeEMHm+Yz3hjCVRVIg8m5PMa2DkhiyUf
         IZNrWUURLcYDkEErJsoZGK/cwteRSQf+owgGOzIvBxRNNLhxVXN5eUcgkyv3IJ1PU7PY
         Oc/g==
X-Gm-Message-State: AOJu0YzcUxYQoOF3VzICti+1TCKBYszG8wjt12eUB+TnnggNTN2jbC/N
	Fm1NG9QXA85hWkb50wpEXy3jz7Thf3uv5xEn7py6LrVFQoHq/OaxkX6OC0c1qvMHRuO8u3IOhcn
	KUWDEie2OJmiYg0pKaQ/2LlNXRW5/qdM0QAu6
X-Gm-Gg: Acq92OHPYHevlYnQ9djKgaXJNGFOiqZXW1QZmMMVxKu/tk5m/Z93bY8EE8dkgz8MXcb
	epN4bM+TNIcIojE67uANgXZKaTm8c+akCtJPppNsevqDpUjRX+wGiGSLlSoqj6xHqdBxNBBqdx8
	5miW/woHybJQUQZGNSUQ7SiDWU481sPGs2dqZRh1Ev+SL+RHvLKZWHjumGPv6vjgBcVDrhIcOZX
	Bu5CU2jvj48zh9kIzLx4p37IM+lJ+Njsgg+3XIHmc56ozVVn2L/OseSu41QIowaLxsEyrlNUzaw
	Qx1WrwJ/np23H4eEN6fxH3y6LBLwnfuTLWWBhUXDZFFKddwyCLSqwDHc6/Pc0psHmMTYK0Fewoc
	ZTZbVi5+PJN6ZQuCYetmkrVnpmSag1uZkVpTiRuLTdxfTaJqLEQi4
X-Received: by 2002:a17:907:1dec:b0:bdc:fafe:bf66 with SMTP id a640c23a62f3a-bdd263c9230mr775348266b.33.1779784865327;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-bddc274f009sm68250666b.25.2026.05.26.01.41.05;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 1E83C124AF;
	Tue, 26 May 2026 10:41:05 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v7 2/6] netlink: specs: rt-link: missed broadcast-neigh
Date: Tue, 26 May 2026 10:40:44 +0200
Message-Id: <20260526084048.1696544-3-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260526084048.1696544-1-louis.scalbert@6wind.com>
References: <20260526084048.1696544-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291587-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B4DC55D291C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missed broadcast-neigh.

Fixes: 3d98ee52659c ("net: bonding: add broadcast_neighbor netlink option")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 Documentation/netlink/specs/rt-link.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index f23aa5f229c5..484e0a97b653 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1351,6 +1351,9 @@ attribute-sets:
       -
         name: coupled-control
         type: u8
+      -
+        name: broadcast-neigh
+        type: u8
   -
     name: bond-ad-info-attrs
     name-prefix: ifla-bond-ad-info-
-- 
2.39.2


