Return-Path: <netdev+bounces-306651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n9M2GnA2UWp4AwMAu9opvQ
	(envelope-from <netdev+bounces-306651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:14:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F2973D465
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:14:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VxLCV63f;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306651-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306651-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF7273012C54
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F1378824;
	Fri, 10 Jul 2026 18:09:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047420C00C
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 18:09:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706972; cv=none; b=C77Mp0LMn++5rh2b+ZE0HNapDvALwUlzzXU6oK37ElN9Z75Ka9+Q/s4lNSLnDfspLI170QcseFm8HYSZ8P1768trHq6zrjw1RduDpRlp9v57F6cbDMuz2HEf10WuWX8NbXvLxn7HAyoxxSW6r2JVGq4ut/m5jh8k6t7hH7Ei9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706972; c=relaxed/simple;
	bh=MH9pMA5tBj76KKVaDsd/HxMdOB1/Yo5Uc23GxTClXWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BgA+zyrhA6H5cmeGBwRE2+umQyNBtWpIVixNRyx4oS5WcNlPmSLJzH6L0c9c1B/ZPutA553zReckrhe4mHk9UuY78dH4GMaOyY/RUWlyC9PtNP0606217l88GCxB1uDm/8CkiyB+ImpsqZN9oTcsUvOF76r6kKQCXsNbxZNjQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxLCV63f; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso4353515e9.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783706969; x=1784311769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=62LK1B4AP8fb0CoLCmSu1gxf8mNW3/RpPJK1TqUpKKA=;
        b=VxLCV63fpV6UX0Q6cfat1bbXyGFv3bg2nqkDfwWeg9/1cM1osXnrCCjqbbegCsEst1
         hzBj4jOzio1cFVtF428czlUV3MWrlzU/fWPF7qHuIL1Y5sgTfvPsfoDPkNVPiuohiOZp
         7vX111WWY53wMoKLVYZWDwHy6rOZcEtX13HIg94Sfw6mqt6KjFpajc4lO9G1gU/l+/8r
         Gp+4U8vsSiK0AdFtqo82U68Nw5r5hUrUKGssTCSREXUeWGoqnsxo2aTmCx/XkzcHYStB
         YtrHNymR+SGdsJThRaNvFVJ33ndAan5JCbssyaUpm+1oQIkmJuMwx3bSjuiGrtRSq9o7
         620w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706969; x=1784311769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=62LK1B4AP8fb0CoLCmSu1gxf8mNW3/RpPJK1TqUpKKA=;
        b=IRBbEaEoPRKbW04Q0g6hNYEUkJEIDa22l/7wbdA260ZpO1FqPC7VGsgRoRJNcMwkwH
         VO0pRaRggkzcgurrPtfljfILyxagIaSzbn7y8yy02jY3PxFZNFJz5CkYxLDcjl5K0j9E
         7xAPOgQOBynuHTEDAshacCFq1Ilv2MGX6J3AFMUBlMWem79WNWlNfcr8wj4KcBz5ZIgZ
         WjC+msVpyfyfSteZYhENmEt/EcAXkyVQP5sochyXUmfvJIXRZYj0xtGPb2SIXnLabt5r
         51qg4qD9Z0PGRIwmdUKo2kee0lwZIJlOmOhm2g2MkeyodVDJvfxriBcKqPwMwRGY/k3z
         joaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXS0k0O+uixL6XXnopiaRGRYH9ka4i2zbGAFdjpDFV/fTMOxbl5YuM6KD6PywSdchZ63mPdCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwY8MdFzJmORFUmAzD3lD/vaLZDOiZ9WUoaqhbydEzTF1+u5l2
	CTQlvPm12NwSW1TdHrq1asVXuorZkud6fRYRDvARGAuCt+lsEyNZetNf
X-Gm-Gg: AfdE7cmt55SmUEze+nBSiHNXbcFXfZow0npNxYpAN+0IOAfiqPYX8ouaXx8GbenTSsI
	kFBHA1E2ZV1rRzPnAXd29ZEu9UPZ7k0N/MWTv4I7KlxbY5Gl4tlFUFRd1vZAkZmN6BRA2yzKFBU
	Q4CK/KzQVlWbXpF85vJ5W8WIcMaDYa98KxSoTkA75pj4jc855766VSXXmxpe8Z2ub2KPF2Z/jlR
	pRj+iAHTYfQvceOo+yX6iF5S2UzTLJuf04TkS3yCx4Lp+5hiwSVSMGxzqfAJ3TASIa91+41cOBd
	YV8Hh8xMz996epAxEY7eW1vpYHfnBFpsZpz/VCEENF1RQRcudt2JTtZPEWMCSOpWeoE/FDYa1zh
	cpAJJMQEy5i4+l/XHDaVVhC3JoaTlZB3qj6yze5EfgZi7G3pOyVRnRcPL3Upqz+KIBmHAqGpfDr
	KjDuedWL5HUjyIl0oqfGfm+262bzsr5J0Wior5x0lMX21XNfzQbBSgpc6QpA==
X-Received: by 2002:a05:600c:1c0b:b0:492:4c2e:9613 with SMTP id 5b1f17b1804b1-493e6864191mr133210795e9.18.1783706969079;
        Fri, 10 Jul 2026 11:09:29 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb670a41sm148593095e9.0.2026.07.10.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:09:28 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Mahe Tardy <mahe.tardy@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Fix unused nskb warning in bpf_icmp_send
Date: Fri, 10 Jul 2026 18:09:15 +0000
Message-Id: <20260710180915.7105-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306651-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:mahe.tardy@gmail.com,m:lkp@intel.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jordan@jrife.io,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org,iogearbox.net,linux.dev,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,jrife.io,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6F2973D465

Declare nskb inside the IPv4 and IPv6 case blocks so it is only present
when the corresponding code is built. The case braces are intentional to
scope the local declarations under the switch labels.

Fixes: f3603df9aebb ("bpf: Add bpf_icmp_send kfunc")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607110140.JeJZ6GIa-lkp@intel.com/
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e4697036c67b..056deb9b3fc3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12575,7 +12575,6 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 {
 	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
-	struct sk_buff *nskb;
 	struct sock *sk;

 	sk = skb_to_full_sk(skb);
@@ -12589,6 +12588,8 @@ __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 	switch (skb->protocol) {
 #if IS_ENABLED(CONFIG_INET)
 	case htons(ETH_P_IP): {
+		struct sk_buff *nskb;
+
 		if (type != ICMP_DEST_UNREACH)
 			return -EOPNOTSUPP;
 		if (code < 0 || code > NR_ICMP_UNREACH ||
@@ -12606,7 +12607,9 @@ __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 	}
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
-	case htons(ETH_P_IPV6):
+	case htons(ETH_P_IPV6): {
+		struct sk_buff *nskb;
+
 		if (type != ICMPV6_DEST_UNREACH)
 			return -EOPNOTSUPP;
 		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
@@ -12620,6 +12623,7 @@ __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 		icmpv6_send(nskb, type, code, 0);
 		consume_skb(nskb);
 		break;
+	}
 #endif
 	default:
 		return -EPROTONOSUPPORT;
--
2.34.1


