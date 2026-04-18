Return-Path: <netdev+bounces-279521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN1+EsGz42kQKAEAu9opvQ
	(envelope-from <netdev+bounces-279521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:39:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAEF421A50
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 720FB300C5AF
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E562F745D;
	Sat, 18 Apr 2026 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To7DAt54"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB02609E3
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529941; cv=none; b=U9E6BNsagk70HzavR1/Ltn2i3ijj8SBwlCFlFwUaGK1nrWQDhaWhxLtLJoVDv4yfyQ74CopjShjKFiIXV4knxRO8MhrIUCF6HkAw/GUqO0QSIUvxmB4Jn/Bbsdd8cFvDFQnSUhuWzVLhUl07O3tJK+r8+/g8Nrxv8dXtOiqotIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529941; c=relaxed/simple;
	bh=M7B2FiAQ68bmq17gT51ms1yjCM5hrhJ8ivTJGQv6vmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fge1boC2mUWz/1jphfsap27/AqWv+34SBGMYB7MG+5qQlcS1xgsefIjWgqCjRZIRUmhVdV+uYcr2BntC/f0GufA811O8xly4uZEtUmPWWA7TwSvAi2POcQofZoC+9ORnQyFdKBWo7yhoVF0iVDytHCBrz31aeMxF81CV4lWirMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To7DAt54; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3502765eec.1
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776529940; x=1777134740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kxoQx5x6kYpwthdIyOArHGCLCerv98lrw2KVJASpKc=;
        b=To7DAt54CBNFikgfoMwt+Ya3cmFxCxyD2DJ+v0gEiFWAKqQr/40RXAYp4UXnokoipq
         IvRQPVJJ6uDmPe1b+7gQ8p25CwcVYdG1iUcHWOLDfN9DtSjsBCfz8+0AfxhCzsqA4L1s
         9p0FmEj1ddfNcl8m0/cbT5EEdqe8nvTMVdEoNDix/b8Hp1SZVD7d5EVuSsM6tzMBYSHH
         3Yqyt/b+IDS8b6vcmmj2edgVDr5DtFbhhyGBaStBfNh7/xocyY6Fnslep1MdxcZ7g5Gy
         2boB6h1Pw/Nlj7A9250L+4IpiitDzpmdzmK/cO8W9LB8x9xDmaNQ3r5xDNGWR448CJax
         k28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776529940; x=1777134740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kxoQx5x6kYpwthdIyOArHGCLCerv98lrw2KVJASpKc=;
        b=Ec+b4GdME29ENSM8X4xz/Z/FObvEfQ5KRT79EPoaYb3axJXa4YjGA752Gzng4C8nvu
         F0+3XGM9RAc5eY9YQJKlbFlO8t1fF0LlrRQ6sYMzA+Ip+nB4TZ0CYneT9YSX7q8fbHGi
         nTMA51lrs6DFK8sQuM6d0/8KapCcuvppmq0hwCOTeDNrISbHQTtKmakL8nfMFn73dMsd
         7jac5KqRgJrcFlrD9LnLKgdZ1URAVMaFun+YuhhXRBYJpuU/91ITiiadnUH6z5sQ9vWj
         1UMcYuIQZDRUqhBfjo24ySaSkslYzHp9Ir//K4IbgX71AtYBiDWwpsF9YUViwFFkwbK6
         zBeg==
X-Forwarded-Encrypted: i=1; AFNElJ8clvlZaijLl/YYqWIwoBnkxZv+nvH1KHL1SBUFFYd7v4qOhmnkakoZMzFm8Uu5OnBykPz9Esg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8ZHdHVqxpT5RlXJPapEKY1mYuekdGFNCvugF539ZMSTl62ar
	r9+rpXY9vexdnebYw0r68RSeG5aR2xBLcs5DoXzCYW/vxdL74TRMDoTB
X-Gm-Gg: AeBDiet/ar9V+b46I2Ap44BI2TsHv7aU0NWCmdUeJ5VbcDAc7ZT099cIrs6bibBWVe8
	km3Zoda235YzDzMkllgRfJ/0yvheERRG1sHN3AaM4jy+EtQZnaStUzglBxglxTpgLbiqbM0ryKG
	lSo8fh41WCCeW1ZEVzw1oDy2rJV9WEOshzt/N2YV2EXZLVq9q7qWCIRgsA5BfK0/3865E0jUi/i
	y5ACuNq9kAQ2nHzaRQghZ66PJuX5iZmC0w56kDD7WP6oluNIiIkN9COXTp9OVAw7cLQRjV9wt6A
	7VJghz1eDU1QI2QoFXpuiTygCw4rqG86Q9JjrYORXtdtosiz0sJGOIykKTZzeLOo38ct/a1FP0X
	4MsOas1QG3flkz2CVvbeBOmEiMuhPlotOIeqyWO70B0YDY+BPK0+MOOXFzVy3TX0OO8es7JdiKO
	QpJhfboEnZLJrmwBJYZyVmx0ntcwxSDc2SWQFFCD9NW4CjDU5EBetT/5kbo4U+4JilAvpcTmoiO
	xBju4izL9m90PwtbUDF
X-Received: by 2002:a05:7301:5784:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2e465293dfdmr3688244eec.4.1776529939859;
        Sat, 18 Apr 2026 09:32:19 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e536e54562sm6894368eec.0.2026.04.18.09.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:32:18 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH nf] netfilter: xt_TCPMSS: check skb_dst before path-MTU clamping
Date: Sat, 18 Apr 2026 09:30:58 -0700
Message-ID: <20260418163057.2611503-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279521-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nwl.cc,kernel.org,vger.kernel.org,netfilter.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.657];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 9BAEF421A50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When TCPMSS with CLAMP_PMTU is used via nft_compat in a non-base
chain, par->hook_mask is set to 0, bypassing the checkentry hook
validation. The target can then run at PRE_ROUTING where skb_dst is
NULL, causing a null-ptr-deref in tcpmss_mangle_packet():

 KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
 RIP: 0010:tcpmss_mangle_packet (include/net/dst.h:219 net/netfilter/xt_TCPMSS.c:105)
  tcpmss_tg4 (net/netfilter/xt_TCPMSS.c:202)
  nft_target_eval_xt (net/netfilter/nft_compat.c:87)
  nft_do_chain (net/netfilter/nf_tables_core.c:287)
  nf_hook_slow (net/netfilter/core.c:623)

Check skb_dst() for NULL before calling dst_mtu().

Fixes: 493618a92c6a ("netfilter: nft_compat: fix hook validation for non-base chains")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/netfilter/xt_TCPMSS.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_TCPMSS.c b/net/netfilter/xt_TCPMSS.c
index 116a885adb3c..79b5e475e23e 100644
--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -102,7 +102,12 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 	if (info->mss == XT_TCPMSS_CLAMP_PMTU) {
 		struct net *net = xt_net(par);
 		unsigned int in_mtu = tcpmss_reverse_mtu(net, skb, family);
-		unsigned int min_mtu = min(dst_mtu(skb_dst(skb)), in_mtu);
+		unsigned int min_mtu;
+
+		if (!skb_dst(skb))
+			return -1;
+
+		min_mtu = min(dst_mtu(skb_dst(skb)), in_mtu);
 
 		if (min_mtu <= minlen) {
 			net_err_ratelimited("unknown or invalid path-MTU (%u)\n",
-- 
2.43.0


