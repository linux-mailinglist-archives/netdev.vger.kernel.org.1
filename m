Return-Path: <netdev+bounces-92335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FCF8B6B21
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F2282A90
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 07:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0582A1C9;
	Tue, 30 Apr 2024 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="U0bOlbOx"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD420DC5
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460963; cv=none; b=D7SF4K0tVg7V+or//tvvBtbfcfZ9QlsCe7UFQEP1YghlQFaHvw2GiItzWtRWwxODJBEGHJYppz91aFOfYDnd+FzeVVR5n8wFpbZk8/PNIHRHylvrH1LNAgoS72e4gJLJTh8Br05KEjUDE84fecgyZzh2eLByW2DlOxgF0f9H46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460963; c=relaxed/simple;
	bh=g1MCXV9idRQXhB5Ht+0Ufh9CoEOKhlthCmJCOMfwwPc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tpy5wtUanT1aSeENRgXGJve8wwirToLnazrWl4pRlzp3q5/mBRbnMUvk8YEFqkossJKNVu9sIVo5rpgagxuto0qISQNr7NNb3aVzQMJQXAQseIOdHZvSkraT2iOkw3kNJwvTwalCX08GgWeOdrSH7ZLZfjycxnnEUsuvWUKh+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=U0bOlbOx; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 36C26201E5;
	Tue, 30 Apr 2024 09:09:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7Fqr-nx71iA; Tue, 30 Apr 2024 09:09:16 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 095D4204EF;
	Tue, 30 Apr 2024 09:09:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 095D4204EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714460956;
	bh=EX0jva8W+BBJUsl7trMMHN+wJweKRlADEU10tpwvwcE=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=U0bOlbOxCk8vPvFhpTUiPUAGzoR5JBVzsrQCM9Vmt2f2T3yogyb7ZJeRw2Lk4pTW0
	 sN+hFAyNtk7Ngz01xkeV1YpZl8LE3Q4Me2Cfu590hWaG1WuOY+QqyMztDzCHb0S0/o
	 LDcWY+22XYvc8c3XsC7o3YoClgYs8IRoL41CwmNTe311fKHcowEZJeggFz15dwYm2q
	 ZW2GDDqtm+XyYb92qGSIhP41mB3kMThnVAeFdIsKJtllgxfrYpStXbP5mFVts4kD5J
	 oD8p5iT0XjrvVS2yihdofRbEqBzikgMp+MQSi4ECnLSYJEmZlQICgPEK7imTKMyYCE
	 jR3VLYp9Lw1iw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id F07D380004A;
	Tue, 30 Apr 2024 09:09:15 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Apr 2024 09:09:15 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Apr
 2024 09:09:15 +0200
Date: Tue, 30 Apr 2024 09:09:09 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v14 2/4] xfrm: Add dir validation to "out" data
 path lookup
Message-ID: <fe3efb96a5902ed40ddcff7d92076fa2f316f65d.1714460330.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1714460330.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1714460330.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Introduces validation for the x->dir attribute within the XFRM output
data lookup path. If the configured direction does not match the expected
direction, output, increment the XfrmOutStateDirError counter and drop
the packet to ensure data integrity and correct flow handling.

grep -vw 0 /proc/net/xfrm_stat
XfrmOutPolError         	1
XfrmOutStateDirError    	1

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v12 -> 13
 - improve documentation in xfrm_proc.rst text

v11 -> 12
 - add documentation in xfrm_proc.rst

v10 -> 11
 - rename error s/XfrmOutDirError/XfrmOutStateDirError/
 - fix possible dereferencing of x reported by Smatch
---
 Documentation/networking/xfrm_proc.rst | 3 +++
 include/uapi/linux/snmp.h              | 1 +
 net/xfrm/xfrm_policy.c                 | 6 ++++++
 net/xfrm/xfrm_proc.c                   | 1 +
 4 files changed, 11 insertions(+)

diff --git a/Documentation/networking/xfrm_proc.rst b/Documentation/networking/xfrm_proc.rst
index 0a771c5a7399..5ac3acf4cf51 100644
--- a/Documentation/networking/xfrm_proc.rst
+++ b/Documentation/networking/xfrm_proc.rst
@@ -111,3 +111,6 @@ XfrmOutPolError:

 XfrmOutStateInvalid:
 	State is invalid, perhaps expired
+
+XfrmOutStateDirError:
+        State direction mismatch (lookup found an input state on the output path, expected output or no direction)
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index a0819c6a5988..23792b8412bd 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -337,6 +337,7 @@ enum
 	LINUX_MIB_XFRMFWDHDRERROR,		/* XfrmFwdHdrError*/
 	LINUX_MIB_XFRMOUTSTATEINVALID,		/* XfrmOutStateInvalid */
 	LINUX_MIB_XFRMACQUIREERROR,		/* XfrmAcquireError */
+	LINUX_MIB_XFRMOUTSTATEDIRERROR,		/* XfrmOutStateDirError */
 	__LINUX_MIB_XFRMMAX
 };

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6affe5cd85d8..298b3a9eb48d 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2489,6 +2489,12 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,

 		x = xfrm_state_find(remote, local, fl, tmpl, policy, &error,
 				    family, policy->if_id);
+		if (x && x->dir && x->dir != XFRM_SA_DIR_OUT) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTSTATEDIRERROR);
+			xfrm_state_put(x);
+			error = -EINVAL;
+			goto fail;
+		}

 		if (x && x->km.state == XFRM_STATE_VALID) {
 			xfrm[nx++] = x;
diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
index 5f9bf8e5c933..98606f1078f7 100644
--- a/net/xfrm/xfrm_proc.c
+++ b/net/xfrm/xfrm_proc.c
@@ -41,6 +41,7 @@ static const struct snmp_mib xfrm_mib_list[] = {
 	SNMP_MIB_ITEM("XfrmFwdHdrError", LINUX_MIB_XFRMFWDHDRERROR),
 	SNMP_MIB_ITEM("XfrmOutStateInvalid", LINUX_MIB_XFRMOUTSTATEINVALID),
 	SNMP_MIB_ITEM("XfrmAcquireError", LINUX_MIB_XFRMACQUIREERROR),
+	SNMP_MIB_ITEM("XfrmOutStateDirError", LINUX_MIB_XFRMOUTSTATEDIRERROR),
 	SNMP_MIB_SENTINEL
 };

--
2.30.2


