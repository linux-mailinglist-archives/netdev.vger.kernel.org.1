Return-Path: <netdev+bounces-266181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OzYMY41sGnRhAIAu9opvQ
	(envelope-from <netdev+bounces-266181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:15:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DC8253122
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7321132E528B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CF32E1758;
	Tue, 10 Mar 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR+gHcEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB328504D
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153603; cv=none; b=PeV8soHnq12NHlSMyHcR12j1elaMuS/q/RQDUccc3g9yVZIsE2xht3lft56W7HVe9LNKTt/SjAHupgRme+6N9i9zys2VNST4/2EUOpcEpN1qy8sU7sVaYNL7SGREAXNpAeDcxxVgixosKFZ2ZjIgzCgPEk+mURxgt3xbaeKDcIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153603; c=relaxed/simple;
	bh=L4xLAL1Yd9N3tf7b58kM25ffJo7lGhOKBxE7vOJgMGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZlGRt3MR8W2VYTPS4zOGASpNGkmV/THvUpOggKqeiJoMzm9EfCopTE8StSRpCPUrKctIii2+z8TJ6oWzbBuY0LbDaJIdFLRXWAyxT5p9ftSPIVksQv3qN8maNP9YEbW+WXwTJVoB0yDAUW/8maW/6rhU7cvoIcWrjvvm8Mq+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR+gHcEq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-482f454be5bso130929655e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153601; x=1773758401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6ngMfURTFeoJUMi1m1ZTvPPLHw/F0vZbiU6NfPRFFo=;
        b=nR+gHcEqMEwBtPPMDP9VdBn5olqPA3h2iTsGpSbG+OCEzNakqnedQA7mjUjmVb3dPM
         Y8ze5S9XSFx48NGt5z873lrWput+EpP5djD9qrGkWYn3Dk6K6Btm0PFMTWuCrhf/Z0X7
         D0dbPWeh7eqh4zBf8lyvHtzBgOrqowFngy2gzj4gDoC4VbHLHxfDnlPlHiUfIEr69SOW
         iVKpsXPcNFZxyBEr5LIIqYdXRBtC7+midXqh5T0Cxgghs8qjKb9vN7XwDKmgTFVuJm1G
         A725hGvYVPTS+3S4drEBiHzPMAIzozaLafWOWyYrIN1mMZi9LGAXXAus/xgF4gvqEXQj
         ezcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153601; x=1773758401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6ngMfURTFeoJUMi1m1ZTvPPLHw/F0vZbiU6NfPRFFo=;
        b=Bz6JoBOSHKD4BAh5hPFYaADy/H+ADDhvMcjobGVpG4mVQVHgtJtoZew/ovYNJF1RA/
         iC/BJrVSVy6wazqsy2AIrMrZbYuWAd4OzoFVzbdUxRbYyK3WKNH4B0RmVnZMCqt0i7Hs
         VNBSdlMQaGnY9xxIMB7IhMTNBuUX0gISS2RtckhyEkcYpDqjhdLHl1rWBBYbxtfXKQFo
         ECnWjRsyuRLhCYTXtKZTziReh/HKokftR8bkltXbAZK3ccI9H8fi4iKHMyLS3PUpgOT5
         E/jI4r8clwfiba4FIID22dTAr8poVI4ma/03dO623Qkhr8y+i9lR9Ltba0QcqvZpeVcP
         YKgw==
X-Forwarded-Encrypted: i=1; AJvYcCVa1yDcoNHSxqsIJGb/Bq9dJG/a1iFoMDRz364S1BlXkMcgSf9wQIMmLfrpCTayrNn+wBNnL/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvpZAgOFkkXUvZL/BoTDQTLgYFu4+g3w9et39D/JQizFO193Q
	GH7SS+oJSRi2l0ghyMwf78JpmwRUNHf30vFm67sm6yT3KOcKq0yvAr4K
X-Gm-Gg: ATEYQzzTxJ2YKdXCfrrg0R1iG1Oi1vZhC+DRKz2kE4EWYpvVS3Nj8NhpD/nZZd0UUp9
	sqRDbIBnc30Sgx7jRBNb4RFJ+ZW652092YkjN5cfDTUcr6CExnE7/VGJJHL6e0GCgMnpevF9fNd
	cguVYPi8YrR/QMlWJjd7B/6/ncc4Uo3wzVWgLz2UUvPVJ3JfY93J3RFQ6TEMZ7yJjYhhVI5OOJz
	jjmoHtWDrlhbD3WA7Oeo+xtO9ccs7WfFrQpU8IRureXF0ptKIlr/F7lQ1QOtW+9CLgun8WSc6vi
	i2U4w7N0h+isoCr1KHkgoKwIbT3g/RvyMPZx8kPM0hf26NDZ9j1Nww0MvZWWqQIUs91qYkI799U
	zdRmk/oHCRlT/HKyI/bl2qs8I9BRspKEQl8tP1qVqprKD67ltasyqNGHfmzedM5sc0P1v8YFX3C
	T86xICKJHEB9rGV8p5O/qNi2/AMb2XVfjpy3OsjCYzyDy7PKRRf+9PzSxlbvnprfZMMyLHOIKNe
	vWpuskxBNbd0n9aOLLf0WtyfaIqHXj/PvlNRnnPjg8v2yYHQ7MjMlk=
X-Received: by 2002:a05:600c:4744:b0:485:33b7:573d with SMTP id 5b1f17b1804b1-485419a2810mr58456235e9.1.1773153600816;
        Tue, 10 Mar 2026 07:40:00 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485358cd26bsm141661055e9.8.2026.03.10.07.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:40:00 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH nf] netfilter: nf_flow_table_ip: reset mac header before vlan push
Date: Tue, 10 Mar 2026 15:39:33 +0100
Message-ID: <20260310143933.354257-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 29DC8253122
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-266181-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

With double vlan tagged packets in the fastpath, getting the error:

skb_vlan_push got skb with skb->data not at mac header (offset 18)

Call skb_reset_mac_header() before calling skb_vlan_push().

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

This patch replaces:

"netfilter: nf_flow_table_ip: Introduce nf_flow_vlan_push()"

 net/netfilter/nf_flow_table_ip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 3fdb10d9bf7f..fd56d663cb5b 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -738,6 +738,7 @@ static int nf_flow_encap_push(struct sk_buff *skb,
 		switch (tuple->encap[i].proto) {
 		case htons(ETH_P_8021Q):
 		case htons(ETH_P_8021AD):
+			skb_reset_mac_header(skb);
 			if (skb_vlan_push(skb, tuple->encap[i].proto,
 					  tuple->encap[i].id) < 0)
 				return -1;
-- 
2.53.0


