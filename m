Return-Path: <netdev+bounces-252881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM3xGKahc2lqxgAAu9opvQ
	(envelope-from <netdev+bounces-252881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:28:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7C787F3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0906304E317
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2732DA750;
	Fri, 23 Jan 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU4HGXoA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284030DEBD
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185360; cv=none; b=GPpMaZJUjMz4xUKNZNp3GQSSrTOgKIEQB9Ui67IaCSx21nrbE9P6cn2CHD8F11nPhe9zSVSvkS9RSkmbOjACkS90QQWkMgwfI4jwHDq0WzD3XLdnevEAKfC72uiJEh7q4NEycNlGElSK+hBLN0e2KlNiwvr2rLuj7h/5dZSEZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185360; c=relaxed/simple;
	bh=ebR7mnvmUk09kMYUV5Bt13RjTDGx9OqdO6kQwNpsnsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxVlSq+9cCbQTQ5DLsypbqnoZa/k4v0le5kCvhdoPIYuVynTGCXFeWXKjxmRwGJ0FkX18qZr58WTRwI4ttEasbD1wu88yLrzb0mCsnYpti6kuK/NrGhuAs4/yVmGo8cfqUFIw+1oBX1TEVwurauwlspUyWS/jUwDoNEoFzN+LWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QU4HGXoA; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso1575252a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185359; x=1769790159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLTS6NfyuP/b1KIM5s5ZF+t0Cp59fs0bP2npjwZuNoA=;
        b=QU4HGXoAkvWh07+y4bhKnwRk4r8nPWzQz4PHsXSiibw0KosIrDRYPTyjCb4VVIV3vp
         olD6NhVnbzbBDnrdTh9E1uxKfPr3yEjxsUT9nbjBz+UNGqT4i/U3k36NORs+0hJhlbyG
         SXcB2yfTV4taSQAYfHDQ+Ssw4E5S1s4TrQ2QrStRhjNXCSBV+UaBwQqJJ+YoUwYvJobS
         M7ndzv93OzGbBKy2AoJ9jwZ8PljxxifsR3O4LryYAT7OkNBkihMrunTYc7p+RTxyMQ02
         iWxrkQaW62GGp/yE9AtCzdJQEKgo3dZiCvM2r04CW1HUADSBb7s+bagPciFcnQecUxic
         iJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185359; x=1769790159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLTS6NfyuP/b1KIM5s5ZF+t0Cp59fs0bP2npjwZuNoA=;
        b=hIehhnHmRm7S3i94eoc/qIthZ1JZuLbuKrtGQN+luC54SL9obfDjrq10Hs+h1bMDdy
         ALbbGOQRVGxl2tQ5lv+/RHOHrEWMqEY8ZnnBxn2IIB4AmGB4CmxmDhFUyWzp+xiu5/FQ
         SRNUihaJq+U5fMPJE565jFVs0pKEIWBTeAL67053MPoIAzNfqJjmsZorAtaF2q4RiWSD
         aNmcRhzfXG+dnglRJF5PnWi8ux8Q691ylSZqoA49/DBeLQxj9k7iYDtjOifrzmHV/NQe
         YbdPLbowSSGPJiYHNEVmR93ZYVqzqHco0RWbuPkJ3eKBJkAjDIB5UB1DMr58DQ+Vj/FF
         zhWg==
X-Gm-Message-State: AOJu0Yz+g07ovz+Wo0mDUMlrn8ZXIzJ35PxC3XtgOnOrbIrfCQHVXSTZ
	desD2Ai4nkdsMQGrP0mcQLLCTMdYUtnDzN+avoyXmwvmoDd1OxkOJxxRpoHOlbu0
X-Gm-Gg: AZuq6aJ+zmIHkD4nJEkIytCyIn6kIvhch5puE9T0396BMxko/kqan+Tbm5/AItrK5cd
	+U/jU2mWNM5rk8dYnQ9BmmlD3rZQ1ZDK3Pr9Neb3D/DS2QsDf9+pqnUecRMbv0yJtCkJi6vVRr5
	wsMIHoB/EjekScF7VqHMFqD0MKM417pPDkicCF+gyvbow7TgrmFPV8a3pHCIrI1VS5eFseIVRvb
	tTuykyCiINQqoWD1hClaP7HsFJhMCmn1DNyr/VFKGkHAT+4BUCh4SrWRwe3mtfuMeZnl+vNQa8+
	5mglIKhIscP7MxitBLignLZEhKZuPCMW2F9lTeRCB0zs7w+SknbPJNtZ7EvzbSLSGBQ6V4R/zzd
	QrRzojadv2c0/sAEiWtBNHqutaXTp4lk6JrwhyRwFJb48hO7mhnNxg2sLDqt/bapRGKYBUtA1YK
	nnmZJgwqOPAMhozGoGlX8PpDuCaSRD/6u6JCkRATlyAgkVYKRkE/vfPA==
X-Received: by 2002:a17:90a:e185:b0:349:5b1b:78be with SMTP id 98e67ed59e1d1-353688574b1mr3491913a91.17.1769185358906;
        Fri, 23 Jan 2026 08:22:38 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:38 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/7] net: openvswitch: fix load tearing with u64_stats
Date: Sat, 24 Jan 2026 00:21:36 +0800
Message-ID: <20260123162159.2877941-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123162159.2877941-1-mmyangfl@gmail.com>
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252881-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9E7C787F3
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. struct copying should not be considered
tear-free. Use u64_stats_reads() instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/openvswitch/datapath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index d5b6e2002bc1..8ba94df7f942 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -770,7 +770,8 @@ static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
 
 		do {
 			start = u64_stats_fetch_begin(&percpu_stats->syncp);
-			local_stats = *percpu_stats;
+			u64_stats_reads(&local_stats, percpu_stats,
+					sizeof(local_stats));
 		} while (u64_stats_fetch_retry(&percpu_stats->syncp, start));
 
 		stats->n_hit += local_stats.n_hit;
-- 
2.51.0


