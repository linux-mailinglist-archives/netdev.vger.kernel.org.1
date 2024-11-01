Return-Path: <netdev+bounces-140925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 693569B8A45
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 05:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D61F2290F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 04:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E2113D897;
	Fri,  1 Nov 2024 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBUfjTzH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0067139B;
	Fri,  1 Nov 2024 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730436518; cv=none; b=NSV9jzE6S9qHrXLPHt4Zzxe91AgRPrqNBEKo+5eS5Z+lJAPwqOVD/w3fosQQHRb3QsNA0TqctTzmJC3yjmL0rPv7rvrF5oCPYGA4UFJh3CjLvMcW7YGiKyMNcb0TqCP9TCdkNEtaXiearPasaTKDtTDr3UXpObRANMBwN8a5Nrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730436518; c=relaxed/simple;
	bh=goupBVKKF4uoCNiNKh9pKJyH7g/obcamc9uDsfjlrVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTmoTmbQ+hLG401452TJu3CGakcORu6UHPP42otpAywziUsgK5VSxg4Z317it42HiZ+2V0YC52F4zTvnvH0Ska4+uOxR8OFESgP/pq74qUvPPO+DfWHCNWOtdCsmaDFuyScBjoSl87iFs5wAhyL7xt9pU3ggSCTt90nnBoqPn5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBUfjTzH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c714cd9c8so17475075ad.0;
        Thu, 31 Oct 2024 21:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730436516; x=1731041316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx1RChMr66gIWYhPNL1PsqJ/YHNLAl0LYOv2JnnTM64=;
        b=UBUfjTzHEGH+NIJ5lsS9GaTx9UVqXt06t5gL27DlvwuUom6DX+VPkP2VszoTFDz3ho
         yL0glAFj5ROJ6WWkhSzAxZqDmGj00O8DTKuiKvfQzEDHFsItsr4ixaok9ajJJ6cEWJ9g
         tXGOZfgk2igCMfZ8wvpQAZvY8L8KRa7VrO9jKIn1ecQVHEIdesN44n3crM7+lYogPvlL
         MoxjkSAjZYykZGXw7Fchj/nlSzp6NKPgMqd2wE62Gf1BbVbl9NoZ93kBgxaL/7hu23vJ
         n2itPzwwnCBIih2vQbaChP3FwHaje87zC4CAwER14aZfXD/KY35a0rIx1SEjvLn1jjn4
         D+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730436516; x=1731041316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fx1RChMr66gIWYhPNL1PsqJ/YHNLAl0LYOv2JnnTM64=;
        b=pFDYRHCP13B766PBNH+9an1I+hf4FhoHWMaeR6UVuAockmmf/P1La2r9MAJYHt1tEu
         N4ZRjhJ4GK5TQQPFAL8+NZ+LeEYZUvz3pvfF7aydW9T4lGuN+aYDHhWMjMJmcqDjy9Uq
         JC2ZPMtQd4jMor1akTLh3ibnaNsSXe9yeP1bO9UN282bXmuD/wPdEhGZNGpnsdKw+3M1
         kA+vVEMYsYspNgr9L8GD+LmPcXt3nXsaFNRexVIvSWUoUl7Uzu+Umq6NIE18wA5Lk5Id
         W0ne7XNRJIB99nM06rTN6H43+cbwi6cZfL4aWNMg4m8pZqSkkGXn3jwPoNmX5ovBGVaj
         tpsA==
X-Forwarded-Encrypted: i=1; AJvYcCVIST3qmE7hFEtJZVQQysCF8xgVgLjLZK3juj9CaCLigQvCO9ABqAHG5FJ/o3fsMII832R6/oxt@vger.kernel.org, AJvYcCWkSmXDGx98+L8MnKqctIaSMCfqMdZHN4ylOWchPJvRla3ywIvomN0B7nx2j2TRcpjbAAJ8/S/eijnzb2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx78hCEZcb4fcozPrKF409uYCgyK6Dh/Ip5wH5/RMJaETDdEA/
	PPwDpEFfgyAg+VGJUxAAQ5zbHAS+jqjZVwkods416p4AV5CXGxDT
X-Google-Smtp-Source: AGHT+IEEMIk857bmmD7AVDexG2/qdpDowNobcbSPfjOQpeynHnn2y0pAVGvCRKS+NHwwh5UODrqXQA==
X-Received: by 2002:a17:902:ec81:b0:20c:fb47:5c02 with SMTP id d9443c01a7336-2111b01aff0mr23099375ad.52.1730436516122;
        Thu, 31 Oct 2024 21:48:36 -0700 (PDT)
Received: from localhost.localdomain ([101.94.129.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a59a8sm15890625ad.130.2024.10.31.21.48.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Oct 2024 21:48:35 -0700 (PDT)
From: Yi Zou <03zouyi09.25@gmail.com>
To: davem@davemloft.net
Cc: 21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yi Zou <03zouyi09.25@gmail.com>
Subject: [PATCH] ipv6: ip6_fib: fix possible null-pointer-dereference in  ipv6_route_native_seq_show
Date: Fri,  1 Nov 2024 12:48:28 +0800
Message-ID: <20241101044828.55960-1-03zouyi09.25@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ipv6_route_native_seq_show function, the fib6_nh variable
is assigned the value from nexthop_fib6_nh(rt->nh), which could
return NULL. This creates a risk of a null-pointer-dereference
when accessing fib6_nh->fib_nh_gw_family. This can be resolved by
checking if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_family
 and assign dev using dev = fib6_nh ? fib6_nh->fib_nh_dev : NULL;
to prevent null-pointer dereference errors.

Signed-off-by: Yi Zou <03zouyi09.25@gmail.com>
---
 net/ipv6/ip6_fib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index eb111d20615c..6632ab65d206 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2555,14 +2555,14 @@ static int ipv6_route_native_seq_show(struct seq_file *seq, void *v)
 #else
 	seq_puts(seq, "00000000000000000000000000000000 00 ");
 #endif
-	if (fib6_nh->fib_nh_gw_family) {
+	if (fib6_nh && fib6_nh->fib_nh_gw_family) {
 		flags |= RTF_GATEWAY;
 		seq_printf(seq, "%pi6", &fib6_nh->fib_nh_gw6);
 	} else {
 		seq_puts(seq, "00000000000000000000000000000000");
 	}
 
-	dev = fib6_nh->fib_nh_dev;
+	dev = fib6_nh ? fib6_nh->fib_nh_dev : NULL;
 	seq_printf(seq, " %08x %08x %08x %08x %8s\n",
 		   rt->fib6_metric, refcount_read(&rt->fib6_ref), 0,
 		   flags, dev ? dev->name : "");
-- 
2.44.0


