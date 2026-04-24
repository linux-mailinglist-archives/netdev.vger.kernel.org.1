Return-Path: <netdev+bounces-281040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELATO42+62ngQwAAu9opvQ
	(envelope-from <netdev+bounces-281040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:03:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC43462A52
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D45623007AF0
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD53364023;
	Fri, 24 Apr 2026 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heWT7L4n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7213F9F54
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057418; cv=none; b=ptJ4erKzKrCGxgPI3xFuwanaljsrXJktRyZzKJy8t2bGzuRxFkmKv74SZrcnDKhz84Ob/IjoXyEGpBpmwFVDd/XPTWz0AxxeKH05YoGz3KDrFN6pw/F/GjR3RC6U7RXp8/8e2aToj0h7aKaqjXtmq+02rxfn9f0EBnSyuEqqdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057418; c=relaxed/simple;
	bh=TbKzAKxcSUe8NnXwGkLYa8oxQYUI5of8nFXqsMfDQOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJS3HIbh7pG06arDhy5KGwIL2xY7pKeEWCCu/PzbLIv0bWkHjc1LzDufS0hwbm1iqBYR4gFwsm4VXiGdZ4Ik4egFXjch5nfBji2zg3eho3JDB5extP4MuAqIdJJ/2ReHPBXMScI7LqlHIsNOrsR9B3lNpIhYyuIbmCrNlQx6rMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heWT7L4n; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso6780324eec.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777057415; x=1777662215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKQY+wUxFz1qr4YidrTiuAid6P1a4VOteLmmLttjMCE=;
        b=heWT7L4np98DsMm2AwEVnWGGx7x9Zcu/OF6N6cpVuwicgybUx1SyPKt+gGWKjDI9SF
         ajSQxmjdD3Zt3rQQBC+w1PZLfkLEotDy7zpAijxI7o5/LzHF0Zk6Zn/ZbWJ32/nNE6GS
         ZmnFCYEJoKcj1FD+/KT16SRr7cWgmLIFuOvYXRxkO9gbd1KBIS0N7Fccr5daiMx6x++8
         Sw1hL1Iy3yJrURBD5PQzZTixHwB99F+TvS4xWtAaXi+QlykEdy9IQmuD7bSxaWrDvblk
         7ulZBlRcp791JzdFepkJYy7IKqUVKanx76JleCzSb/n4P6hn/TEQxGNAPYh+/xr0HlWk
         lrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777057415; x=1777662215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKQY+wUxFz1qr4YidrTiuAid6P1a4VOteLmmLttjMCE=;
        b=e8xGwMXBocHSxLZQIf8R7PUiTPdwiqqRGV0c5XXLIAJU3kLsnUzxlOzHZsHE+v4jBA
         dw8v6P0YwGA4Vl8P0QON7Umd9ux6pGDQn1sVhVMaSBwSIJOsscUylzZRwqk0bTHSgYnp
         djBLsEj1XcQ/PIbnMmGwqHNei1wCRlki6IM4mCAH9QZmiUVS/GTWxu/f42rON0fTciNI
         wLDD/SNwSbKDytt4rOgrg+f7A+woPqqIHhYk/YTEq7+VIot3LOvZMuW5e4X8kZnUXg7c
         acjp2o68cVr8LRv18DJ/r/IaeN3NV0OjfYwdiC/aOKgJN7AhVccOr2pRd/IBO0IT1N/6
         hPCw==
X-Forwarded-Encrypted: i=1; AFNElJ/fRwqDz+dDIUPjh/tP00i0S1RDI7I42FKtR9ljpdfoaa4xE3HXcr04pb3NwXa8B+U7lrU6Hq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLvHOYqPAynFQFdwCuHeJaVrm5+tgoMdVluOpjCs6ryM5VeLYF
	5IScJ1dT7DrJJXkSeEHF8KOjzyehP2bJs7C42nxIEc+Z/FZJsbnsgKf4
X-Gm-Gg: AeBDieup48wHlTSYBs8XCF36KWPdmfPZrqZqQCJo39VhGj5Jii2LV7qw99uOANgzGjG
	LQvGGnnf7UNt3PYKqBrkyDw5CIcQibskdRaeKbxP13kBmfiJflsT2QSMdDN7tnaWgDzX7VUC0Jg
	+b7jceB3e7tpQWLvH8bijTy8/eGZSBm6XnDWcOLnA47vEr6fyJR71h3GYZpyIlN46MSQ0FJr8eF
	f6O0YeDzkb0dHWMikt3oqH7POs7EO94HkI2tdfQ/nmLtKE3QtAYEcKgj98BCxATWd0yrR3Np/ip
	MMuHbXTdKIrL0V62A1kTXHsYAZFswP0DoIFjhQI1nbsJRu9fG8THZg6YrsT/be8NjjtSJzmPwvn
	dWf/FkVww7oM1JSBWFN9C/Fmehr7AwAaR12I0aq9pF8/kFy5s02PcJ1uGox2ihFmnuZnoHOixXS
	NvDoETw939fRjsE37tYLFfKPNiPYjrX8ohu+Ux+j2U41lnYAxMWiYVtNWpTr3mUKNadXcM7HDLq
	NkU56F0kGg4ag3sc5/c
X-Received: by 2002:a05:7301:3d19:b0:2d1:9b35:4edb with SMTP id 5a478bee46e88-2e41a1e3fb6mr13143549eec.0.1777057415164;
        Fri, 24 Apr 2026 12:03:35 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a7ff1sm33082081eec.9.2026.04.24.12.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:03:34 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Xinyu Ma <mmmxny@gmail.com>
Subject: [PATCH bpf] bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data
Date: Fri, 24 Apr 2026 12:03:11 -0700
Message-ID: <20260424190310.1520555-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EC43462A52
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281040-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,vger.kernel.org,asu.edu];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.668];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Spam: Yes

bpf_msg_push_data() allocates pages via alloc_pages() without
__GFP_ZERO. In the non-copy path, the entire page of uninitialized
heap content is added directly to the sk_msg scatterlist, which is
then transmitted over TCP to userspace via tcp_bpf_push(). In the
copy path, a gap of len bytes between the front and back memcpy
regions is similarly left uninitialized.

This leads to a kernel heap information leak: stale page content
including kernel pointers from the direct-map and vmemmap regions
is transmitted to userspace, which can be used to defeat KASLR.

Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
page is always zeroed before it enters the scatterlist.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Tested-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Xinyu Ma <mmmxny@gmail.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index bc96c18df4e0..ea02239892fd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2820,7 +2820,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (!space || (space == 1 && start != offset))
 		copy = msg->sg.data[i].length;
 
-	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
+	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,
 			   get_order(copy + len));
 	if (unlikely(!page))
 		return -ENOMEM;
-- 
2.43.0


