Return-Path: <netdev+bounces-286321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJX0M2+qAGrhLQEAu9opvQ
	(envelope-from <netdev+bounces-286321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:55:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF4E504F12
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C20283004DEF
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFC23A255F;
	Sun, 10 May 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qrmp+C5D"
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-9.consmr.mail.ne1.yahoo.com (sonic307-9.consmr.mail.ne1.yahoo.com [66.163.190.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B43A16A0
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428524; cv=none; b=IGrSwEEEIuRSLAAc1/0vXTPUwXKYxfNElqxBDdn8DyStttEJfXtemvkP8b/rZmBq1iewW2xJEKsE+C8H4i+1J05/TnglQs6ncrwEyBphC7JIhyfnhh0s7/b1++R9pI2gRBZLE5VqkkABSdSwrIaJyC4wjCKMWcXf0vurs0o2VQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428524; c=relaxed/simple;
	bh=g4k4u6m04DhUSjPh1mhPfzKvCQerd6paV22r9q400Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjJ13/GHCjluAIaq6qrAfk6T2fwsu6C81JcVm7OJi7xYROdItRXh9BJTXgdyNB0gor5sVDXMxRoMnZm8UR0mka1+qtTHSdDgP0P//puw9djYuWE3gI9uGGiVkKA59vBTIPuYG0vf4b9nSz5j7fxSyn9V7Q4ACuzwZpxsn3E300E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qrmp+C5D; arc=none smtp.client-ip=66.163.190.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778428514; bh=CLF8Stt78rXSXeACu+BeLNBQO3i7AY0m49DGgIS+Q+c=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qrmp+C5DELA7zp5+CLKwETe2jbMALsoF2IaT2qHmoR4l9YiN/efXBjWYQ/xtrQXl8udSLjj/L37VJr/EFS7fmufy9yI4JhRYtAgEF+7jeCBSS2vvJl6fWSplQXM4gVGTUraG23kTSdJQ0crt1a5zSDXHO9ABYS7PZOrZ32I41qTRTmo5TLVVH3UXl32M3mPCYV7+zsHcmpBFJGZ8ytZl1+9/jnepljGxsXXs2yE6XksI2uwNvCfD8Cl6cMhEYj7nA0WNRvXdAa7baJqbteQkgmIqsgqY8iNiYYZQqJdFnUgC4pFAUtklDqlKeg0Xp5QbKUQn+zdHx8/gQin5/jCkoA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778428514; bh=qA1FTVw/qvYNkz8+6LCs2CyxY5IOuE+n1mbaoy5GzW1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HSOTaq5rjSOMMyVTUeijq0X99SAgYFlCVp7S1SgIbRFN0xeU6N66B4ICd2EH80zP9BVUObK0Z50WQvdTQY/O5piEbXDmCrH4XjVYZO4gyiEspjJI7uJW9ORszRJJrcrp0fVD69lfxOD39zvTdV7pwzAoCEhfvBYRf48uEqYVy1a0Y5MJsOCs7dOZkHBQr71Jli9V2a6Jwyg9IZyM/+Tk51GU6rsvGMDdG3nwqIRviA5HgxZ3wE0KyKz8OU139NakCz5Rs2QB8gcnjR+4ZtQhLXj3/yGz/3DIF0V0JLhtByWYdDnLyhHlVQD7dPzQV0kF1nyaCbaaDddUBP75H2HC6w==
X-YMail-OSG: ocBdVXYVM1lGJHKGrYGw8OJpRzUOlEBLUhEO8FpLEEvCbH7r0dOT_yADAE9Y7aS
 GnB4qwZgRJzOcFJCzWorj7PihKMFdN2UZyuAT1InmXsbUKSziQdAd6kk8Xy3QbKmkYFd.ojRjPjm
 9lMPngx46.d1pkXluTsHImOB48B8HUjm93.jJtQZpmdZWhoehCltYc6GvpH8HgE79o3gpJ8Ogg6i
 oSEOHCKWy54RpvlMyBBpD5Sojl49XKwr2SkLG0hIBX0OHWK5PlCFq2XCB92ppbq7qucB.zTp6YyQ
 e4a2.vBmYVs4g60WJsXHAEDDZtOMFgzkxbROaAhJzbmpoGvNKV9eViE3PJayRTF8JptAFitqPvuj
 4FuaLHOYqB7RQi2UKX4pvUzcwqPgVSdTCvseNKUvtUDDIEOAiZlzgF23alR93Cocz0XawszDIKTn
 50XskmE8aMThlvP5nFXFJwxss7D9dq3p50LO4gSJKTgMV1e8bwoVk7QCuhz4U_.DAfXjqnjVaBWS
 laV.gGX6b2SLRmGN6QtrE4i2dn3t_srGWc8bnfBnvqL87Y8izXv.A40E4eRaNNWhMRj3PuANEzju
 mton9DgtMEIcdjlh9KMtoa0S9V7pm18C.L0Ne2GX95QJUDKHCMqCImxEXiPmKlYGV_JAkbhO5AEJ
 ..1GzrYVhln9xFbqvDnrCU20FI63ZIDCGpz8Zcwe5E9lphFa_X7cWHeC_Yn1SIhzmwKA8z2YfqXJ
 9RAVlaWa8NszHqqjtr7Je3wi2mAiRgyP0TyZqPElt40Qc_8niKPBMr.kLO0.tMqBC6TTCcI.cH6a
 hj3SO0N4NS_mTP1rZLGp2shdXSa7xfmX2u8Lb._xKKObTrm85NBU_aDtGVn_EzXeNUwb83MaYebA
 z9rKCbFou3gb8yBGyDoyHzgTenbFsGSlFsep3CprLVvzKI5qmSTd.MvfEcSq6K7_Cg1gx1o9CGcy
 ij00qEUbk3li_3tEYzL7qSTjIVd.lirXxQf1MJBdr7jzUohbwKMi8OH1JAxiXZCg1mXATKZon2m4
 pYNMzB4QkmtOL.OCYfi5xJytktWvNTYyZn0I7RXeghWsgfJnaM5QbnXNqG8xvamWFmBhyH4iO9wp
 9NuVI_SvseS8qWCNPyUf0sJLfH342fYP_yDr.AiuulLlfKDVoAoiX7bMlzjTcXxtYk5uuJc.AuFM
 9N2MfNSAWL7QRg2hNRu1Gya3zBuboxrc.Fet.zDR2Hh2NBxsTvlzdqthAW_eaf9_o3t0MGNVKXsa
 MRagwYD_lScU2oHj17z04Fllf2hNonYunO3H9srK4jeIGuw9dKG2bzFqdIXoDo9EuH.AYffoknMZ
 ohqqdrAJdz3Wyp7Q105lppD7LNm9H_OHpgHh4AIQeOlbZ0yjMzNYwa5ybBHIZb6peNf5IaGM75pV
 0Ab0rTTr.Y8huEXGZKmAbLrv3tZnrsMR6tGbddL7HlbdLwdWkJEUbSRDEP4id.zuf3OfHlzYl1rb
 2r1i_A0SmE7hJXsVIsv8JwcgS07RDOu.QIzFDq.hkXIYBxhMP2Mad5It82T9wth.s62UOt7OOHNx
 a9.x3UwPu2wjXL7yWxqp_hFiX.fHIc3RJ5noL4LLgTKWqSyTBn2JRKtOJ2_pYG2QhFXAGdmEl3Hl
 1gZYQVrZ9js7c9E7Jtfd0ADJfO.DRc6wnkmMWQLzpLzrb8qWoZt9GBY9O4HgsOTbAJCU.PeMccv8
 qbSgMbDGNH3tzBICqHD7uwvyh4eLbdQS6SyBfHnosUpHKnN8iVYBRKagGRR3uU25XxI5QKRtTTzU
 GT2bqgEjch5VJowYzsoZZr6ppCGQcrSNoOGP9JYozinrK.VLszbtiF09rXMMl8xabGxmyvpmK_rj
 QadQojBfOADXKPWfZKZSjiNSdpKqLnEpn_qgYMmmuCSsD3Fc0D_8nC0xir1a.TC_Oc.86jD7HEX4
 hZ8bdyG7yI__gOrQc1vvqXjb..MKJCSl7egsV1yZA_WycLC71yt.DvtPDIXNX_PHAnHkxxQldntl
 tlpRtYDphVZ5lauWvKKAu82UiJA4wmDtkN42w9kIwPb_EKIpt_CiolKBH6KjSgOkaG7igyPa4DsH
 RjhVh78OIeGBPSJB5lXKiBShm7dHTzmYqKEk.XILLk_L7yNXA3_xUbOAUTN4E2Y7z1xlWLyah_Am
 1smR9fHT0q2eb88E9RaLvanNdd4rHXb_2Fj69hpwPJqJ.RAo38.7NLnf5Is_9_mjUmdiHppzv0RQ
 gre_dgPFokA_wlXAW9B0IC1Lvm6FOahdGr3a4I7Z0SDTtF6p5hWAZc8xYkURnigVNz8N6vjAdWzi
 24ecezdWQPuwbxz2858ct.b1VyOHBrvlwYN9T3.gYOoN_n5TlEas-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 42de1e4e-06e0-4fbe-94c3-4cdea29ce3fa
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sun, 10 May 2026 15:55:14 +0000
Received: by hermes--production-ir2-89844b765-l4vp4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3c551618ddcd45599741f93af78935f4;
          Sun, 10 May 2026 15:23:53 +0000 (UTC)
Message-ID: <1c4596b5-a4c2-49fc-a774-bc1f38afaf8e@yahoo.com>
Date: Sun, 10 May 2026 17:23:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 3/8] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
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
 <20260506-realtek_forward-v3-3-1d87c5f85a3b@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260506-realtek_forward-v3-3-1d87c5f85a3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 5FF4E504F12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286321-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/2026 4:58 AM, Luiz Angelo Daros de Luca wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Rename rtl8365mb.c to rtl8365mb_main.c in preparation for subsequent
> commits which add additional source files to the driver.
> 
> The trailing backslash in the Makefile is deliberate. It allows for new
> files to be added without clobbering git history.
> 
> Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

