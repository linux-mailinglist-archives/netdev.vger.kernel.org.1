Return-Path: <netdev+bounces-90542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8D68AE6FD
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26DD1F25449
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E16813664C;
	Tue, 23 Apr 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Um4B68IW"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D6134725
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876592; cv=none; b=AhRAeE+ICQOcLRsr5pNhvOeH3V4EWZitWeESDM+VtciC0C+5UyZ58k+yCOCtxdmzKC8xGFV951kmcypaxe9/tYe+tBnddITQpbNxCRGgx6nFSnRfwxQJiVDYuaKRDEvA8bcSJeGOGrroCmRClZi+LAAMk2Da4LleYG7QJKnnGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876592; c=relaxed/simple;
	bh=0OCDerrfSo0jOq1S4jbrYZnVst8uhAQogWwJIwDmRis=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hktY+JYCItl8nWqpFYxZ0mHxPUclZsQnToJlKOXDPBQY3YJI34Wdg0q2/YEiSUwsfYjsx+25lVbHQTXbondTb9GX5y49czNMXbLxKlwIzNYbkcnIKPyVrb1SmDeWCMMhNVXVoMTxySDMAwrLB/nC/YwV9GfKCk9zfxLsErbqGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Um4B68IW; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D184B20518;
	Tue, 23 Apr 2024 14:49:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rhUs-uum2jbb; Tue, 23 Apr 2024 14:49:48 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 427B7207D8;
	Tue, 23 Apr 2024 14:49:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 427B7207D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713876588;
	bh=tDo0/6UXjgggxmA/3kwOPlN7+SpDisvrrCp4q7Djwy4=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=Um4B68IWk68hnPCqzJo8B8iM5nskgfzM2wBg9EdquiSsfU0pTzYejiftCgbemDwHu
	 nBEOfy6TFuYVi6jsjuNJlwraujPJWmLtFqt/DLh7Li+DK2aGGF1j4HoSxshgqMsjWv
	 Kg3hthf+JNURvkm9MNu9KXSwpf+U/VmV6hUsIU6UZGHGaigOsn0qnVR5nXF4gAlSfz
	 A6ZwVTyC9Mpsyhz0VZCh2flAAMmWELLB062EY+XNFWoFtGklBJaGRBVaC3x7njlwiV
	 QIkjIRcPE4YtFAyUsUKG1bHs43EBOHg+C11opej8UZrfdxRHeCiM1I6eHAC7UWF1FL
	 4SrpJ6i0Uvaeg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 32E4680004A;
	Tue, 23 Apr 2024 14:49:48 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 14:49:48 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 23 Apr
 2024 14:49:47 +0200
Date: Tue, 23 Apr 2024 14:49:41 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v12 2/4] xfrm: Add dir validation to "out" data
 path lookup
Message-ID: <7eaa5e0a18d7bfc40fbf02fd0a17a540967197f5.1713874887.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1713874887.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1713874887.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)

Introduces validation for the x->dir attribute within the XFRM output
data lookup path. If the configured direction does not match the expected
direction, output, increment the XfrmOutStateDirError counter and drop
the packet to ensure data integrity and correct flow handling.

grep -vw 0 /proc/net/xfrm_stat
XfrmOutPolError         	1
XfrmOutStateDirError    	1

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v11 -> 12
 - added add documentation xfrm_proc.rst

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
index 0a771c5a7399..c237bef03fb6 100644
--- a/Documentation/networking/xfrm_proc.rst
+++ b/Documentation/networking/xfrm_proc.rst
@@ -111,3 +111,6 @@ XfrmOutPolError:

 XfrmOutStateInvalid:
 	State is invalid, perhaps expired
+
+XfrmOutStateDirError:
+        State direction output mismatched with lookup path direction
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


