Return-Path: <netdev+bounces-286304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G+3HS6jAGqTLAEAu9opvQ
	(envelope-from <netdev+bounces-286304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:24:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDF504D0C
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50F5D30015B0
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480583822A1;
	Sun, 10 May 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LGwWWtbK"
X-Original-To: netdev@vger.kernel.org
Received: from sonic314-20.consmr.mail.ne1.yahoo.com (sonic314-20.consmr.mail.ne1.yahoo.com [66.163.189.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53D36654F
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426665; cv=none; b=TYv3HBGKKM3y2qKfFhZwL4xzrzQc1vqE2QxmmhPR4bK6XJ47mAiQv4IVoPRsUKizsnkjQJai4+PPxcP+hgriCKrNCG4sI90ekNUmcR3qlqj4rUyFNDnRKjMiruLdkFnPvm86OljcrrtsKAn/u7lrJ4aUZyfDdH9QviTr/1AmUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426665; c=relaxed/simple;
	bh=8sHFJaSgDlaC8CzgGGCreeRg1+wsVXqeMmKY3IvKkqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2LeVCphIGTr0YYUeJbCfsVXZa8L/1Cm9SMGdD5fjL5LEKxnl1594Sl64o1Wgt2EsTbYhMIKuQ1q6xx5qc8T53HFz59DqV0w+qlr4/CEIAbyTjF8iHWB4hKt34c6ZNPjC14t1hNARFQlndNIl30tUykBYWW9KhEr9U+cg8C4jIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LGwWWtbK; arc=none smtp.client-ip=66.163.189.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778426663; bh=l+1QEi/Mva+3X4theDqFltvXMsW45Bosop6RAImaxRU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LGwWWtbKS+p120LpwUfR/vuJVxLGpeUMChNFJzpZkW/+Dw0KQKpQn4uS+cvmoA2Yv5KzLiauB+N9CmxUpkEkgWp+4BNWHyv+GNUiInFf8LDGtH3Lrx9ZrWwkiZM7diuhx1VRKHl0OTplJ4rP8HgCWxGJkTvRm/vg804d2qe/XFzLYWo9H/0vQi+IfHA5bYMzGSx+li+DFcXKXZL3Icob3V9/GPwXT8y9OzLOb/e//72Ahidmt/5CDbUrrqMkHsmUGjfRUeK/XL/1Q6fTFrAJY+QL3bSseRTAPBNzYTLhqUQXEkB7hqyXpdLsqJbmLV/27bz1leRKF3zQc7kFSKEhKA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778426663; bh=bS55AGuA5w/I0RKcLYEc5wmlRpfecPlQHf+ZpOLWGmW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=G9XGILlEIGpsCtqjsKhbtYLHksMTM/q5vAUQZM5EsHonOkLapST8Fm9gLjdgdE6RQD0zAcxuEaliRkZTX/W4bUr6S0lCC5GwByVdwl0d5egoG1t3iuvI8nLSBQDfXRUHQHRAodCw1ixgJ5vIsJ5bEFKej6/NDEiohrqI5HjCQFoymFAFup26WcIxPzT5qLf+IZ2+jL15yc4IJiHn93FU8+kMEyg5AqdI/srQ29kiJzETzYndlw/kmam0StnrzImHDGB9hTbBLDe2nr79RCN0inIfPLdUfDlic7Y6fvthKnGGmMqJLQyVuDsDkN8+1i1Z8B7LGyBk/HT/CL05QXTdHw==
X-YMail-OSG: _UukBQMVM1kOkI9sk1.h1S0vSh2DIoMBmvcenpFMx_odtyI.fXx8_zP4biC0jIt
 a7.7RDO4clKBKHFRb1E0gsAQkNojHqJZ6cUn8zyQp0.l5Q8FurNksvJxu1MOsn_gvWCpPVLtYU6_
 rDkFAuRjklzOEpe78.r_18GKiTah3PvUS8WxHXZhM9kYM.WgFbZ8bIpsxvU3.R2LVDkXaoTteXhK
 NgvBR_LRPtoR9pwkjtBDhz5YMA22z8KzLEzQkswtbF0dCQlly89OIaWHvMnSrxu0p8ZwBGUU.ghh
 YZ8Adr.YUkEIX75Bdq4iQXLKK.IlTdlw92E280YVBZ1T9N8z8kvWOlvYSUx1Fh1f4w2xGdPSGS8G
 eRXGIJO.FH.nkkb4.8AYPQnbqWpizGu49kD.FK0BxuZIzbpYJzEA_nKSwXtDaJ4.qVX3FLVxs.Ii
 GDSGED8_mYwOlWFnD6xgomLnWDdRRAZSOlHObqgcuCROq4nMTqG6nyM2D2SvA15xeonyO.Oisv.M
 3kYgPivNYOK_NZ.mi1QQQyvkeL2JLWc4psU3ClvqWiRxtFFuj1jgRz.2JsZztkLwOeUBXzd8oNBo
 n_JRzeCwSaCRqq_QReqgmkbsGVjDKeuIaQeNhyXXjuIkaCMWwDdbJd2lmzthIR2Nz2.mnA_oNBmb
 6Uq5gUj6dMDnyZP2p_eo9XxPRQ8vOn3FFIvxtyGTNy1drNMtGUVrlhpyFYAo3zlXIcFlvzeSWzvm
 sVqt.lZIqo8Lockusln7notR7rm4Fv.oy3L2IG5hvWT8cPquOp3SuPNBXw4_Nwg4aZ_5yLimxHut
 dZ38wdxpw9PpHOebGcPZdjthSBA7yQiSY6bh0GqoEbA63E4m2JwqFkJ2felhjFcmGjsxsO90HKrJ
 YKcA_5JcTszn4y6rJlRFgXVHvG8ZdsywRq6hxu0Ll4xdW1GWaFrIFayQM_GhDEegoHzr5E3BgzPl
 BBK8vZsI6qGFF5rTT31mQcKfFCNbA2V3h9mxi6rlw8rBDlkrbKb6WbARKcoB6ZI.ESYhyNsI6mOu
 kBQvBShyckmgBEXSG.ITN7m7iY11UOIaxjsq9pmdCx5qCUJSpQ0o9TPCExEtgUD0_G.f7XT0otTv
 lxi4okf6ZzZ4wQNf1uQXD7Ejny5OLKghOdMjaVxAScP74GsJwKeBGGcE_MNdcVdNyK5BnvYCHcyZ
 .90i2HQEbOFbXxA7ILCR1vrFXsbtQqntOZ8KfKSAHaRZUKxAom.hReTwztC.xdMXfajpKYYFZldH
 z0Ndy2YkQiilE09mYQCDrlkDv_Gs0golMW4NlA1JAFo0Wm_4nic1IyY91uUV6U.gzCro48vD9n08
 ZpCDqZsbLBGfrWZ1lJJm9kt0vT9Vikm1qgiCgOP_Z9oLUwUcodG5CnujPM2I7fIzBXbg1a4dVTeG
 wgsVej02P4bCy0dfaoxWDYQ2s_GmG_QBWZhGvgQ8SHhmJ4HW7x2y07viJRXxTMAysdrhrqFiMEJU
 WbABJdlwW6SG6Z_ejAjnyztTewSreOAl6xxH9YMF8TBQHVOVyQK9HWG2SGmHG97BdpstYBhYrxxq
 f9.471FrFtBg6ZAE4z8AmyUC_Y2eE9hEBpZ0wgN6Vmd4DtIBVOf4Wn1tCqtSYPCIEXhiDZ5wigXQ
 FBdW2TqD6XCJmy0TCKETsBttROGc0NfbSEWw4_8sUa.a5yqzArI8cXen1aPA3znawCYXRcDLqN95
 XKO9VeSKrhBDpte5e7vLcNFAtkoiHw_4rrFisdu4IjzPIq9XF7hGbtESrRlYSYkzEWA7oL9iZ.v7
 ZRUGsPYOj_i9rPgD.aPXob1GXMSKQxEjgXXmbbhxzy8BkXYRbGlJCCtyA2jIeHTW1UQkYRVG06R5
 ySzoYpHyZUX6cbuPaqaAFktHWaK8nPlHixpeqk0Qod.R5dDVdv_2JzQVF3J5or5GcfqyNLDi7SwR
 p8d.WEIey3qGDMLbkJpaI3uMPKGVbXaw.LgnftbgsVae3zrJBxE4M0eqRFSwnLHQ7lb1hBl56pYG
 clhLwcbHO9XOfQ6fy.VzR.VxUD0GbZmilsCJ4UvXAouHfnz_YMXLGy3aBG_3Iv.BK5mO5ef3KNuf
 bAE7HzINWh1wPDQTXdueRwhl1BASKu4rJfRG2Au5Qbi2M921l2itOSpvAEjtid_E4mnsJ1wd_BVD
 JIr0QJkzOynX1qRP5dbwJ30ALvpKhYq1f2OD5etW6ZSC_qnVvrO5DGL0uW4Kk.gEYcxd_Bjo2_ks
 LQFvAB9TEOyEojB._SuLt5IMKEE.jH0cysqzKmOWfc9rAwZVB0usz8WHqiQO9cfWc0smD6cymcFa
 AHHCokg1VfK6WvzqluE48wV_6o4KYe0hB12MdCjuuOptipHOmcB0-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: c2a5d1d1-f6d3-475f-9727-9a02a2de2b3b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sun, 10 May 2026 15:24:23 +0000
Received: by hermes--production-ir2-89844b765-z964p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0acf49e2957b7929d0ab6747174a46e5;
          Sun, 10 May 2026 15:24:16 +0000 (UTC)
Message-ID: <03a6a16e-0510-4c99-84cc-a816f96f7617@yahoo.com>
Date: Sun, 10 May 2026 17:24:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 4/8] net: dsa: realtek: rtl8365mb: add table
 lookup interface
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
 <20260506-realtek_forward-v3-4-1d87c5f85a3b@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260506-realtek_forward-v3-4-1d87c5f85a3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 74FDF504D0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286304-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/2026 4:58 AM, Luiz Angelo Daros de Luca wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Add a generic table lookup interface to centralize access to
> the RTL8365MB internal tables.
> 
> This interface abstracts the low-level table access logic and
> will be used by subsequent commits to implement FDB and VLAN
> operations.
> 
> Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

