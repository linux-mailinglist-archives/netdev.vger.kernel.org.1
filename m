Return-Path: <netdev+bounces-18688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5287584AF
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687AB1C20DE0
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECFA168A1;
	Tue, 18 Jul 2023 18:23:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236611640A
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:23:17 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A442135
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:22:51 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7680e39103bso338758185a.3
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689704569; x=1692296569;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8AccF1SH0Y/JdOIILtRJfpt1KSbJ1RJLB1Gr9T87MgQ=;
        b=y55DQ0ccRWb6COUVaYx73KAnztfT22L6tm0bmuaM50598rvJ5Y6eD7a8Et8Mvnxr4v
         2apMRynnMF1C3N9iuaHqnlHa6dMxDpRuPJiaxWWYtaPTgV+e9kUf5Pfjg0bX6xK1Tt91
         KlUrfzFAwy2kOwP3ylFCArl6WDG/yTJx2SdJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689704569; x=1692296569;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AccF1SH0Y/JdOIILtRJfpt1KSbJ1RJLB1Gr9T87MgQ=;
        b=S0kFH3JdnJQdccGJDBnxMqn1eHeYIvCsx6fHePyUt8M5rougDzHWFBO0JyuaeHzEGy
         nhR2BO+lN3sxHhcsi0FQ482HNuCYddGFiUn2csrGkStlCTVT94D3mI5QPaB9VfzQM3i6
         aGmPwictw0n2nW8VVf2J3JMD8/WWsgyU9ypKHs7MLR5yKmBhJNR8qA9ODLwv30af4vAe
         d0itiylG4afIvQdmqBNjsA/99OdQErpq1PcLikHAor9Kyu9h+d79+GmjegAPpLGYs+eU
         CXdp++lTOrfX9lridhFJfBRrAZlYBYJeZStIEvs5/Eosfrfgeufv99Ho9lv+S+6/Mrwy
         Pmew==
X-Gm-Message-State: ABy/qLYqPIsZeviauoDRw2AONgvx81u5N4RQp4P5Z3GU78AU06p+RVUh
	CM25n+ot6DjZIVmkReOrjYyMjQ==
X-Google-Smtp-Source: APBJJlEteunjPjWOeYmnXJKjAGsOAYEHHNQfxFRrs9W3n0YlOAsgaxljr7z5c21XZHsvYlbYTc+FTw==
X-Received: by 2002:a05:620a:4512:b0:767:1938:93c7 with SMTP id t18-20020a05620a451200b00767193893c7mr682655qkp.43.1689704569008;
        Tue, 18 Jul 2023 11:22:49 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id pi30-20020a05620a379e00b00767d572d651sm762073qkn.87.2023.07.18.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:22:48 -0700 (PDT)
Date: Tue, 18 Jul 2023 11:22:46 -0700
From: Yan Zhai <yan@cloudflare.com>
To: "open list:BPF [NETWORKING] (tc BPF, sock_addr)" <bpf@vger.kernel.org>
Cc: kernel-team@cloudflare.com, Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BPF [NETWORKING] (tc BPF, sock_addr)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Jordan Griege <jgriege@cloudflare.com>
Subject: [PATCH] bpf: lwt: do not return NET_XMIT_xxx values on bpf_redirect
Message-ID: <ZLbYdpWC8zt9EJtq@debian.debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

skb_do_redirect handles returns error code from both rx and tx path.
The tx path codes are special, e.g. NET_XMIT_CN: they are
non-negative, and can conflict with LWTUNNEL_XMIT_xxx values. Directly
returning such code can cause unexpected behavior. We found at least
one bug that will panic the kernel through KASAN report when we
accidentally redirect packets to a down or carrier-down device at lwt
xmit hook:

https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48

Above bug is hit because NET_XMIT_CN is returned by noop_qdisc of the
down device, and it propagates from dev_queue_xmit all way to the lwt
logic. Although skb has been freed by the qdisc, it still continues to
neighbor subsystem and triggers the bug.

This change converts the tx code to proper errors that lwt can consume.

Reported-by: Jordan Griege <jgriege@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/core/filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..c9cc501ecdc0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2129,6 +2129,11 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	ret = dev_queue_xmit(skb);
 	dev_xmit_recursion_dec();
 
+	// We should not return NET_XMIT_xxx here since it will conflict with
+	// LWTUNNEL_XMIT_xxx values. Convert the return value to errno instead.
+	if (unlikely(ret != NET_XMIT_SUCCESS))
+		ret = net_xmit_errno(ret);
+
 	return ret;
 }
 
-- 
2.30.2


