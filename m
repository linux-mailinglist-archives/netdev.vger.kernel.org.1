Return-Path: <netdev+bounces-273458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMCwGSxGy2nSFAYAu9opvQ
	(envelope-from <netdev+bounces-273458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:57:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9363D363C86
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BD0A30148A6
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC12C11E4;
	Tue, 31 Mar 2026 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj20Yv4V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5641EF39E
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774929428; cv=none; b=hIdarpIJ4iiNta8F0L+K8c7oQGdoqLDN6mhgbi3jHb1u5ZyhDjXN9ENurYlabsVMbWP272+8etsNMiDXUVIgIFn9hgok01TmhmzwjjofYh/DMOPF9v/ZGw7mOdMb8iXSGjOnrH3xk5PqjIKnqnW4D7nzPX31Cobv+B9oU3k7XJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774929428; c=relaxed/simple;
	bh=MKlnOkMzX+oq1WW0maV3Su1eTE5/Q6WgY2md3Hs/x2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nr1gF4d3hVwN4eYlXqRtVsaK3EyPkSDOUsLTnnpeSHoZEDiNrdZp8MaiYRFaVDCnBis/hZYcpmKrb3CNNhZIy2kQUqH2zXmVINWXnk5O/aSr8sMJN7EQOX9d2SA8Pt8WyLMQVkBULxrV+CzUzwS1oO43mW3FGBldplcH4b0cJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj20Yv4V; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0afa0210bso26516475ad.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 20:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774929427; x=1775534227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqQrrFc2/Gtic83J7TRLhKhXWW3jOenRMDXaQ79Hua4=;
        b=Sj20Yv4V/5L3DMaRt3mHC94faIpMJDaXNTRaSMsLxmgUqrh+ifiRwNf6Its2ndvXza
         NMNv/d4Sv1+QZzCjjd/O1jYmgiNiBKaLyejEzC7BiUAppB+rItiin48cBdNav6YIeD5P
         zLfwiZKOYC7aBThN3igokIMLq9yq1y7J2tIdpLWLHCbnPFN9BJ1QKIQT5fJhA1Jv73qg
         mQq6YDyKzE4ME0FvsiHC9e6x1hf+CWnr/j1j12UnoTgs0ATAdT3PvWpDGz1S3u3QdTYJ
         WKaUOgdyYCVD+gAj1JesFpeIq0VZuXfR2n8BVK/P/ysQwNveE0F0UeoBTJFd2Hfoo93e
         IrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774929427; x=1775534227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XqQrrFc2/Gtic83J7TRLhKhXWW3jOenRMDXaQ79Hua4=;
        b=l3LD431HapKyOvXZbvhCMoNGKX+lDk604J2IsHtNCdHncOVE97Xgb7YDG58KcSff38
         mKcMOlnoeXM5EOeAj43p88hSNXmXbrrDEFHA1ofL0yzhFgFMFwYHbFoixoVILUz8PyO/
         lOyfnQB7K6mnLYKPbJ2TBwPvAP8AaxN46vp8yjA9vArP++PM425cUGEBwFGmhxyD9mRO
         cCypy1q/rNqAuuaTmqvZeN2NMvnMgPcGPPqIBn4ES5MqB6pWu2UA73JFg23Q5sXjcEFd
         lPTsOuVmR9GtNZvH4QXL8ITHWQB+4vvJynAvnKtWn3dSsVJ6oVQd8P67Yvqc60LNVZtD
         5j8Q==
X-Gm-Message-State: AOJu0YxTcSQQEN07sA7SGRCRf1mSMe6W3RuyWfDNt/6JQmLt0ra4Hvgx
	acRPdmB0qs6d8vCTwChl9ZiDKZOVq/rwAJKV8cNMgpMPRCS+w5Y+QAZT
X-Gm-Gg: ATEYQzz0GvUPb47PLEOITmCah26BVHZhUfxJCmGOrf8+gRlIbXfbuhSv7NFYCoj4upd
	7BE2PNfmpS3jtI57uwLq+YyvaKHMdpCetFsR9xQ/kYh3plyBEyKuKIcR/I4spf4hIWp5ytSHuMc
	QPWbNg3fZ0QldPPC0VYaHPuWjbhhoJFAEKY2YjyGa5UWsT2VqVLi/6Fq5ZPb7giM49WEOHxnasQ
	wA5DWz84tPQSLVVMjx8DZus14Jq2TjqoC3+ChwBwIZhsPV0jeIbyJbX0m7ImXkIVb5GrNfTS9m8
	B/qSSJCs3LvuWWsFxYfsf7oZ9SKzSyiIuSX6df8tb1mNOoEMJLyGJiS8G2wAgEwkq5AB2WPY8L1
	3ZJ/q/dt53/t7lT645uk75cLEnfyvicRo6wML50rniWQKvZgXuw/NSGiFJeiFR54ValoTm7pz0n
	kghgxh+YDvs3V/LYMLEGkJnGip8Qb37br3Ulj8w773oAFfCjO+bv8e79yvL7S7kwSitPsjVtYyy
	itebxDmN756W6dYxqn8fDB6I1COXpOaI+lBc7KrjAq6t/YNowo=
X-Received: by 2002:a17:902:e54f:b0:2b0:65b8:b5b4 with SMTP id d9443c01a7336-2b0cdd830d7mr150042965ad.39.1774929426743;
        Mon, 30 Mar 2026 20:57:06 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:500:c92f:4f4e:9953:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266e487sm94680625ad.24.2026.03.30.20.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:57:06 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 31 Mar 2026 11:56:14 +0800
Subject: [PATCH net-next 4/4] netlink: warn on nla_len overflow in
 nla_nest_end()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-b4-ynl_ethtool-v1-4-dda2a9b55df8@gmail.com>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
In-Reply-To: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-273458-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9363D363C86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The nla_len field in struct nlattr is a __u16, which can only hold
values up to 65535. If a nested attribute grows beyond this limit,
nla_nest_end() silently truncates the length, producing a corrupted
netlink message with no indication of the problem.

Since this is unlikely to happen, to avoid unnecessary checking every
time on the production system, add a DEBUG_NET_WARN_ON_ONCE() before
the assignment to make this overflow visible in the debug kernel log.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/net/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 1a8356ca4b78..00ea52dc08c4 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -2260,6 +2260,7 @@ static inline struct nlattr *nla_nest_start(struct sk_buff *skb, int attrtype)
  */
 static inline int nla_nest_end(struct sk_buff *skb, struct nlattr *start)
 {
+	DEBUG_NET_WARN_ON_ONCE(skb_tail_pointer(skb) - (unsigned char *)start > U16_MAX);
 	start->nla_len = skb_tail_pointer(skb) - (unsigned char *)start;
 	return skb->len;
 }

-- 
Git-155)


