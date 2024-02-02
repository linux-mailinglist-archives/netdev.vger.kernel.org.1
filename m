Return-Path: <netdev+bounces-68339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C80B846AA5
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF892880DA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA142077;
	Fri,  2 Feb 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7Heaf13"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915581865B
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862143; cv=none; b=vENWieTnf2Wp5wysiE+2e5TOu4DSUQY+PnLvU9q7NVTOp8RnhzKv3X7nbZJLr3MdfzeBx1wMX1nREgaPJnDBD/eFlrVmVArUMDzlJ2tpboS3HJ9e8vjBzuCee9b5W4yrUvyqlRmMIH6Egzi9/znMUnChEN+p9RbjOeZBLwq+2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862143; c=relaxed/simple;
	bh=HRqkCqxtBKrUms3XCHQMXqP+vqbRKLRoHOHl89isBsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5qK+4OxE6cHF2gnIZuEkrSFnkGOcr+AIhzHsY0qP3TNuF+lixA2Z2qgIyk/lFdKOw3jU37LXUlgY5fG8z4Bu8xah1iDdJtdwir+TAo4aLsa4KUXwlm44d4Q+/VhMpcPu/1Twh2VfxbkcGlVnjLh/2txDAhc5d+UkJ/b4yTmTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7Heaf13; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60412a23225so18359457b3.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706862140; x=1707466940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h17ojUPSOJID+Qge95Q9ZnvyDNG+2fV6vU1bRnAO9Q=;
        b=K7Heaf13HAOIYJaTRrdwOPHQZ4hxsNXtie8fLRDwlCSXEX3SbVwzdlnR4IotwAwKN4
         K6g2UthG0nNuaMiEaWctLH9O2ZhYLZPP1pv9xvPxJjZoigx+NVM8F/92rX6qOnYNH64/
         4/CAK+bEQAFySeMD5XEdOi7/212rRbGQ83/W2KniA6fKR/nX1gxyiu6J9u2d0+EeHDRD
         +hsku+H5EisBLcFRcOxu/Q+MxtmoSY4CYqdGOVRdRIvg2BIwrm7H/OT3MDUjnxT9V7gY
         qCqL+xy65Dhmup5opxuePjPAeP+5hh44PFKAsVpWYcLa8XIAt8KKv0WBdURd4pe0QWWm
         loJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706862140; x=1707466940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h17ojUPSOJID+Qge95Q9ZnvyDNG+2fV6vU1bRnAO9Q=;
        b=ir7942vewogHwruG32BgmteMDOQ/UE16LMtu05qNJ7gQzq/BkwM/NH/3RhIZIp0IB+
         ul6vsoTFwPCaMJBqNCBsRPWGscSimOtKf5/ughKwhJgI6jtv3ypSQLiLdfLn6viqG3kx
         Khg/tVddnJbJHE1j5CVN75Wib5PYwt6zheVaSQyOjCMjaJAuUvxxo6iTPDjYTGu/aP9A
         cQAahqiNGuCCjZnbYPjUV6ZUPF7skC6ZvZ87M0s9DPtC5ypwbYNpW6fpMtj97zmCOsNl
         2xevF8iyM6URtViUZcVudYsip799X5cW1ZlzpxIawOmiDht7eWfWhAilJM+THjLF7TDs
         Gv6Q==
X-Gm-Message-State: AOJu0Yzo/ASOu1vomPWpIvT1gS9YY2LbHZrcaaCSARbddcLcFiFYGRON
	83FESIutcadZEE6D8doNfjsCSpr5WqNa1M9ieIjK/Y9QLVlJTYHCqnoPByQVk0k=
X-Google-Smtp-Source: AGHT+IE/OUPSCu510+rCF9uVuCFaNKDK1p3sSv1KIRLMucmaXcVXIArFbU2oKeg1q83jX3o4eQIxVQ==
X-Received: by 2002:a81:ac21:0:b0:5ff:5fda:fdae with SMTP id k33-20020a81ac21000000b005ff5fdafdaemr1583313ywh.42.1706862140002;
        Fri, 02 Feb 2024 00:22:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUqUozuLKbetg5pwcTiFbQlkMxeIgcJtR3aMkq2S108iHhOK2mPliCNVUSjKjAUsu5JWcOudlknuarwLR2Y9MNIOaFMrHSZhiPxHnJaFq0zlnAj6FraoMYuJ0tn3LQwl11+Mgz/QcX4f9/TmAOAtW+RQGTrlMAJB7RP3NswnDcxpCVVFmLvbJ/xLCUS8wmLwMJXMXLCZroVYPt/pCwDHkArXnVXsyt4ERRLnWZrgwqtU5JQDO1AdYI64CeuWVDG2d3myzFa3S3atoF9H4za20cjv8xHglm/WPeC0BPGjR/rsdGi2IWE6I95t3MsZ1e6TYnfe9MBjuDC5Lss884wNvvELVlZF1eC6jrJ+A==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1486:7aa6:39a6:4840])
        by smtp.gmail.com with ESMTPSA id w16-20020a81a210000000b0060022aff36dsm299679ywg.107.2024.02.02.00.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:22:19 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v3 4/5] net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
Date: Fri,  2 Feb 2024 00:21:59 -0800
Message-Id: <20240202082200.227031-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202082200.227031-1-thinker.li@gmail.com>
References: <20240202082200.227031-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Make the decision to set or clean the expires of a route based on the
RTF_EXPIRES flag, rather than the value of the "expires" argument.

The function inet6_addr_modify() is the only caller of
modify_prefix_route(), and it passes the RTF_EXPIRES flag and an expiration
value. The RTF_EXPIRES flag is turned on or off based on the value of
valid_lft. The RTF_EXPIRES flag is turned on if valid_lft is a finite value
(not infinite, not 0xffffffff). Even if valid_lft is 0, the RTF_EXPIRES
flag remains on. The expiration value being passed is equal to the
valid_lft value if the flag is on. However, if the valid_lft value is
infinite, the expiration value becomes 0 and the RTF_EXPIRES flag is turned
off. Despite this, modify_prefix_route() decides to set the expiration
value if the received expiration value is not zero. This mixing of infinite
and zero cases creates an inconsistency.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 36bfa987c314..2f6cf6314646 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4788,7 +4788,7 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
 	} else {
 		table = f6i->fib6_table;
 		spin_lock_bh(&table->tb6_lock);
-		if (!expires) {
+		if (!(flags & RTF_EXPIRES)) {
 			fib6_clean_expires(f6i);
 			fib6_remove_gc_list(f6i);
 		} else {
-- 
2.34.1


