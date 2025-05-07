Return-Path: <netdev+bounces-188602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C44AADD65
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5821317F529
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A187C21019C;
	Wed,  7 May 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+vdEhdA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8B1865EB
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617524; cv=none; b=NhCk2HtBSSra1uxolYC50a9qXBQspC46pi2gbb6L/pCW423cT281sF19YAVZJzVQ33EiVw41CWO7uFXma7w18KqoghlE8lZSYSphXT4rvo/TA4i1YX9vndBeZ+aexTwI39j/B6lWhzxwN2i3NHH9OIBh7Z6rcTVMQM2eoRdyh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617524; c=relaxed/simple;
	bh=as0rfWFd8spshSXXBQv+TjXoaOY74zNfn3PlNiDtd/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qLj9GLDms2NM5tzOUArPdLPTn92ZUNrtb19FWv1h3ogIBefijnRJXg444oXhONwPyMVLmg3EsY2mCpez4etKYS0WqkImR2kKfEldiekOeHachgdwxSe/6EEmyz4MgtyQFQLkk4J+yw/JAARCjrjhQG/cV5nDFwS51L0pi1ZYNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+vdEhdA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso42404495e9.0
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 04:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746617521; x=1747222321; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AK3A7jwAAokKcfzlNWNLa5c0EB8Ivk+5l3sSHrHeGRI=;
        b=R+vdEhdAbCsqgJMIibqGwkjtjTwHrJ6Qjai8+Ded/SXBJRkij1iA54QTlIAVbylrt1
         OjoOXmArXpEwtcxhn8c7RyWfbRPsFMvcOL6/u9RupW+yjkHgpmXJcECV7L6T6VeUalHW
         nQTF8uqVz2F7uuW2LyfJj0ZSJ8E2r5w+zW4Em4754rg6de76XYKAQRaH8hKm9QALoXZy
         u51WGB6DS1kLubaBzCzZa2hJ87nZb+x0sz9czVInHaDlXhBkcHosFcm9zyAcQvXF8yI6
         qnvPF7XQ0mL3FJIhTO3aH8RhMF/mITT49l1O9nM8c+Z/eUvhBX07tl6ATCDp+92X1vEB
         aSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746617521; x=1747222321;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK3A7jwAAokKcfzlNWNLa5c0EB8Ivk+5l3sSHrHeGRI=;
        b=ugsJh/bkePtCS5hoSOCwqPDgte0S+cC4QTaWcPdfGfeGctvr9hiRDpSv+6B9O820VD
         +2yrym+FDS2Zf1BEIhdXJP7adCR4CF2Klli38EkNhdjSheLev7woZQpzTffvNb2A6r8j
         yRAY42eWJPMY963EX8zwxeg41oQxQeTnznZ4rlLgUeDPvlewMG+4SGl7GRmbZF9ghPkc
         p+vkDMF7Mw7UhlQFdzL8/wJP5JBRHt5BH8bWIlDxuv3TISISX5ferVSXc/i9bYN44gpZ
         Cbi9lDLBRbY4oUjndm6hMFBRk2Czi2syIagntR7kn2Y2Ivi3COvu8V8xJOJItrHTrNq3
         Rmtg==
X-Gm-Message-State: AOJu0YzvLU8aOImthDkgumsWQRxo2TSy5S7Nvxu2xg/W7csrCZFFvOI1
	GAiK8wSLlNiVZJOrjYJTQWYIMpYwFYd44Ma+wgvcBNzG/bL7fWr0/ZGz+ijI
X-Gm-Gg: ASbGncuqubxGqSV++xJscBNVp9J38Oxp9LWNBvAS5S/puTOgaB24ho6WZ9gMYvqZuKp
	/rUlz6vAevP3cf2jwG77puDb4a1ocNhGU8L2nL8TxzVQmQAZSI5myYO0iQhlUrCPNYZUxUiLOp4
	T/SZw20KA1LclKiu1m3CenlGe7oZhqATYzs6o8BjXzHns/ORTQgewzljze/ThD0ENiLT7W7VTa5
	XuHRegDtsC/tTbFyY+f9deBu+7yU8sEU59Xx8toFdcL25rYaDmGxPoDTHyzuei08BNC83k+HDaV
	7M1L7NFnsXMml9geeb1b3n/MN/wqHionLhP4OkMT98JTNmjI9m8HWZwi27UPt6aUGlCPM1iVKVQ
	xY6vKN749cj1lKMLleKG2kueWK2PV2ZwZ4uUugg==
X-Google-Smtp-Source: AGHT+IHnDhst9XG73Ye9yEhWnD5faVamk84UQyQexARnv89VG0xwByyDP4ZALlmIBLHvI8rvc1OZAQ==
X-Received: by 2002:a05:6000:2288:b0:3a0:9f24:774d with SMTP id ffacd0b85a97d-3a0b4a19227mr2872570f8f.45.1746617520867;
        Wed, 07 May 2025 04:32:00 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0081c477e20d988853.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:81c4:77e2:d98:8853])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d4415995sm28780965e9.39.2025.05.07.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 04:31:59 -0700 (PDT)
Date: Wed, 7 May 2025 13:31:58 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com, fw@strlen.de, pabeni@redhat.com,
	kuba@kernel.org, Louis DeLosSantos <louis.delos.devel@gmail.com>
Subject: [PATCH net] xfrm: Sanitize marks before insert
Message-ID: <aBtErrG9y1Fb-_wq@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prior to this patch, the mark is sanitized (applying the state's mask to
the state's value) only on inserts when checking if a conflicting XFRM
state or policy exists.

We discovered in Cilium that this same sanitization does not occur
in the hot-path __xfrm_state_lookup. In the hot-path, the sk_buff's mark
is simply compared to the state's value:

    if ((mark & x->mark.m) != x->mark.v)
        continue;

Therefore, users can define unsanitized marks (ex. 0xf42/0xf00) which will
never match any packet.

This commit updates __xfrm_state_insert and xfrm_policy_insert to store
the sanitized marks, thus removing this footgun.

This has the side effect of changing the ip output, as the
returned mark will have the mask applied to it when printed.

Fixes: 3d6acfa7641f ("xfrm: SA lookups with mark")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Louis DeLosSantos <louis.delos.devel@gmail.com>
Co-developed-by: Louis DeLosSantos <louis.delos.devel@gmail.com>
---
 net/xfrm/xfrm_policy.c | 3 +++
 net/xfrm/xfrm_state.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 143ac3aa7537..f4bad8c895d6 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1581,6 +1581,9 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 	struct xfrm_policy *delpol;
 	struct hlist_head *chain;
 
+	/* Sanitize mark before store */
+	policy->mark.v &= policy->mark.m;
+
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
 	chain = policy_hash_bysel(net, &policy->selector, policy->family, dir);
 	if (chain)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 2f57dabcc70b..07fe8e5daa32 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1718,6 +1718,9 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 
 	list_add(&x->km.all, &net->xfrm.state_all);
 
+	/* Sanitize mark before store */
+	x->mark.v &= x->mark.m;
+
 	h = xfrm_dst_hash(net, &x->id.daddr, &x->props.saddr,
 			  x->props.reqid, x->props.family);
 	XFRM_STATE_INSERT(bydst, &x->bydst, net->xfrm.state_bydst + h,
-- 
2.43.0


