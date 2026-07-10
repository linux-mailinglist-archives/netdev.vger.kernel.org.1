Return-Path: <netdev+bounces-306459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tOr2NvuqUGqR3AIAu9opvQ
	(envelope-from <netdev+bounces-306459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FE67385E1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:19:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yahoo.com header.s=s2048 header.b=nspkYa+H;
	dmarc=pass (policy=reject) header.from=yahoo.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306459-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306459-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5F81300146B
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FFE3ED3CC;
	Fri, 10 Jul 2026 08:18:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-56.consmr.mail.ne1.yahoo.com (sonic307-56.consmr.mail.ne1.yahoo.com [66.163.190.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073BA3B42CB
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:18:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671505; cv=none; b=CyIoYfKNPWIarhL12Xi6fsd8SpotOwwI656ouCcGFUGeci9Pp0ZJB4B5FCYaaZIT7RhcPkAhDZGZcx0XfByZvQ4PLnjp+l5+iWasiXKw794DHoxUACNh4+7UfjSQdjDzrFerSmHprs1dbeC5mAjWufbiAJWO/bg2egm6jy23VSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671505; c=relaxed/simple;
	bh=efnpitq5MLIvEzz5Ii+8iOQdc2Iv78JmanN5b1AUISY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnrRIONBiP+76SSOoIqD4FZMOXM/h6fo9TPWvau4iOs32Fkeveu/o9xaAIPgE4FsmO8/H5AOGP2idqVMoXNMtoZ+qRmDo3duxRLf4Epa/P8Rr6XOPJSzuBIJ26PcgN8q+Siqf+USMxRnqKsGTt6wXVrKgubMZvNHHX5icLA7oK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=nspkYa+H; arc=none smtp.client-ip=66.163.190.31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1783671502; bh=HZTGzOSblixKNwAEbOA/HMVyQbV865BjFJWEFec0xA4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nspkYa+H9mibx+FbLeGeu6FuQtJXJlmG2IBVEnAQaeVEE1zniG19sf3/b9pP9yL7UsBfDpJwGmWhnU8MRnemj0tKMD3ug5HV+VCJraiCoS178Hkca9Xuy/qbxQiisnvHrkJ08vFk1yXKt2waeZznPEPQ/1kEw2KDJVQDOnoqy+RVtu+nY0/0/s/bdLdTtmig0X2FVK3C9ppulzP+lJX09TWIK8YZ1YUzttL7z5+e+Q6EkDNixLoF8FeZf88PJ4bW0mNDo5o76mgagENLCOkM3kwxCfHv5CEVNIb+5S9uwOOtonPAg9mZ4dK6EXe4lv7kM8yxoWPSwelukAu7EPhZtA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1783671502; bh=bwSHf9R6W32B/TlyxLCj4pJcUVnulRudbGUB0364gZb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MZDIKFBAOa383q4L5/xxR3pmhhZ6vFf7kVxGKf3W4mXNe3n/LZwCS+FcXC5jF/+ASxCccgHwyAunUt5Qopxkla2EzOMfuxLehkxd2en/EO2wK79blWK59r7us5dFkcJCNYqM6H8gonRVhg4gyhHyKkytiI5yPj47d/FAMachWvc2H83wyUuvFefaujkeIKIcQc5nEaCSSVIZAD1OBCaeiW957Vz3o8hcsXSDfIScqUY/moEGMgjgiLQj2A1E1LblOH3a4oniY+ys6hipWirbtoPb2PQzrRKuPL0TO1XgKR3Pn7cLJYXOaxHyuU6cUVe/5efa56vosVsoZcEeIhUbgQ==
X-YMail-OSG: lO8ndqQVM1n3XJCb1bAzEAspjdEEVzRVUA26Lq6dWL.cUyIK1IfcXDAu3Xiv1G7
 ojslMpBxhZgZRUriyBshd0LSaUI1yPaSTp6cO66EeECue5v8JPLtKIEsmWVfjbuLj8aQS7mmPVQN
 vd02ueFQ5.GCVGpRYOZYtYuizW.aYjBCIIE8vWVHorTphJxDgLeXbVLkWmXgJyb3niVe6B1rzDfi
 wcZGQO7HhlN3i09V1J0ifukDxbo454XEzM5O9VUtUyeANcyCF0CTQLphvqKejh8hINkvOjkBXIjz
 VJ07eYuCRkUQm3POw_L_qI9AK.l9n6RYw4yhnrUJ9OcHevxXz0Q2t80K6r0S4K9aHIbUIWmRGQS6
 qQo2JdqsvklPfpI7asgaahb_ofo7OGabBUP1QR9mLHBNNdU0GJR6oiSHiAJW9oJ3Vsu6Wnm9kpc.
 QcR3jgeCyta2TrsFo1oo60lfgsFYPANgOBCH5hqgV_zMvrRHfuf_g9MrfOSmjpF9Lg_9kUp6gy84
 wqvBrdFIVCf8y1l.1tcCOiJrI5h1oZx9aGt8c7tkwBxB5ayEalaxPaF6OObfx.nP6Bc9NDu4PSdL
 GPDkJ8HaYOjjj_g2GIjtcNeRsYDoh5eqD8yIWQP35u_xvgrsizDBsxC52bgvcvJLxBE6GYUQ5bCH
 EQwVw54giGYSh9SYsKBo_dNUS3p4toK0NU_l_.64_N36WEkwJUHeS72v.v4lJ9zn9JZs5cnvTl5c
 WqCQNDvwbDbh.7RYbXoizAea2NjEUhLK6IDLMcv38MBathmk_pnJNUQaAAO.a4q29WF2Wf8cO1.D
 sF.MkTf8I.4KFRULjSDJBnHDJMRUytTg7aHxTQZnxcgnUCZqKwskBCsm.BJ1nWjuoaMo7BLay91o
 oAd1D4bZ9afgSGnRj2l36XDfMDdjaQB1sfy4Dt7aG6OX4X3Hj700G6JvskL_mXIYZl6idLkpEnfT
 h.mCP0oLOjxj9A2ldzBC_gjObBcx65AuIh90iPGTXPd3RcL5q.pqXfeMmr93uD9KNi_yTiDiovUG
 ic0jMLzVzDWPKyGauti5MBz2TfrlR7Oh4dJC8ayzpgArBYEg1bFhT.9z4B5C.TfWb3SWZwWZMiV1
 reaWUjEkhDAEmV8rtGOpEDpjFldiAehgdZYE8pkB1AlnQReLOdJu.iluT0qEZvgJ.rbi2WPXHceP
 SYbHSFeHCUOvFPIJ49_epIJyc6XHLTEMfmEA73mkgyk.ST3mNREvfFAFyvPkQqAqN.MD_rM.cvRa
 4NQuYb8iDokyHUjcCSktSpWy9puDeuPgVh3Fuk0bf8lVsDc55ZAOsDTFDeMc8WeY_iSDtTiYJk8s
 Vi_xZKtASDqL78oZEu0OBq8sGF9jP9pbOusfOe9QGbLhqshSbi8TnbicAH7cqGAAGrjQaP_wEqaj
 IkcPh34C63_ttu9uAQn._L3q9_mh26S25DelA9JTHijHGnU2_VnNRxYo6IvHaugGG0AEXcwaEMCq
 KC2jXokjmicIrMy._MCr0kcra5RPTPjPSdUPB08BNVYKDFHhegYiyKmgjyzlT3XbqWvEZU6zY6uP
 Ho8sSR7AXYgR2h5YruOjZnwo6wFgz1szsP3Mspn4hEe.fKn0Lbwp9Sa1i6M.5.vxD5xpwx1lwo1R
 Ikbt7u9ib824QUWSzj0CoDSSS84TmXHn7PlcKIpxU7wPxyaqTa3Lf7z0vtI.AFtyUJn3aMFGLnUo
 cwD8RK5RYRuXjRyeOh_OBFwRufjIbpXEJ.yQfLhndPfrRF4XIWqunl8baEo3BoWG9bOsL5K.rjEG
 9K3op8daNtoz4WU0qSXgWDgTmI2iTNKkDBZRAOyC7a5g_xMQcMi2lxpPm7jaV42Y3ieujXmJ43ZS
 Syop8_SAytrgYNBbWSd02Wuye_KZnzsvlid4dgcZsipR4TvXgGp4V4i1X5wcjJH0ODukXyHiertF
 Lk0v6FgRprswYGmJ.2onmh8Z4rSMTKf4fwIqKWUnHh28vnpXGGxALbH6hswihz_YGLMZzSVM3sNE
 4XTEsJ6iSeCl1gsm67NFfFAZLesFvMmIS1K7e9dR9wn38ISNyrBJMOzbwqh96ndONh27TqHLPyoh
 rBQ5nH7EWgEaHOflxlfBq7WAEG7uRUckAT018vYWtnIB.idZz5uxfQgoIASoL0EUukLIiszzk4Z.
 sqbBq4dhsGusw0q5UyzxHCo57qbjh_C4V7HHiZ.5D0oyC.CrYn5bUVcV8cZs.YqhzhQ4dpMXOEO2
 fY0_Qg6iXo9FrxTCPRKXD4LYI7EYl5RgNLeTRxIjz00kVtBnwE1bZSgvQS5iVsOsJxNPKHsRogne
 p
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 81049a42-6c6e-4c47-8498-ef83ae1a6501
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 Jul 2026 08:18:22 +0000
Received: by hermes--production-ir2-7b48fcd765-rd79m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2ca45d0c930fd1f126e11ebf0f3e9a28;
          Fri, 10 Jul 2026 07:23:33 +0000 (UTC)
Message-ID: <be5c2567-1b1a-4155-8577-cd9ad50500bf@yahoo.com>
Date: Fri, 10 Jul 2026 09:23:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/2] net: dsa: realtek: rtl8365mb: add
 SGMII/HSGMII support for RTL8367S
To: Johan Alvarado <contact@c127.dev>, linusw@kernel.org,
 alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk
Cc: luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0100019f488ec83f-cd82d418-999a-40de-b58b-135b4b2aee51-000000@email.amazonses.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <0100019f488ec83f-cd82d418-999a-40de-b58b-135b4b2aee51-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26136 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:luizluca@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306459-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[c127.dev,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82FE67385E1

On 7/9/2026 10:25 PM, Johan Alvarado wrote:
> The RTL8367S is a 5+2 port switch from the same family as the
> RTL8365MB-VC already supported by this driver. Its chip info table
> entry declares SGMII and HSGMII on external interface 1, but the
> driver so far only implements RGMII, leaving boards that wire the
> switch to the CPU over the SerDes without a working CPU port.
> 
> This series implements both modes. The configuration sequence and the
> SerDes tuning parameters are derived from the GPL-licensed Realtek
> rtl8367c vendor driver, as distributed in the Mercusys MR80X GPL code
> drop, and cross-checked against the real register sequence captured at
> runtime by chainloading a custom U-Boot ahead of the stock firmware
> and logging the live SerDes accesses on hardware.
> 
> The vendor driver brings up the SerDes by loading firmware into the
> switch's embedded DW8051 microcontroller. Analysis of that firmware
> (by Luiz Angelo Daros de Luca) showed it only performs a SerDes
> data-path reset right after the SerDes reset is deasserted, and then
> runs a link-polling loop that writes the external interface force
> registers -- duplicating, and racing with, the link management phylink
> already performs. This series therefore keeps the DW8051 disabled and
> performs the one necessary action (the data-path reset via the SerDes
> BMCR register) directly in the driver, avoiding both the race and a
> dependency on a redistributable firmware blob.
> 

[...]

> ---
> v5:
>   - Raise the port 6 ingress and egress rate limiters to their maximum
>     at setup time, as the vendor switch init does. The chip resets them
>     to 0x1FFFF (~1.048 Gbps in units of 8 Kbps), which caps the
>     aggregate HSGMII throughput at roughly 1 Gbps; the cap was
>     confirmed on an RTL8367S-based Mercusys MR85X, where raising the
>     limiters took multi-client throughput across the HSGMII CPU port
>     from ~1.02 Gbps combined to ~2 Gbps (link in patch 2). The related
>     HSGMII scheduler line rate (LINE_RATE_HSG_H) is already set to its
>     maximum by the common init jam table. Pointed out by Mieczyslaw
>     Nalewaj.

I think you should make limiter initiation dependent on whether
the port is assigned to CPU. In a loop, check if the port is CPU port
and set limiters for it. 
This way, newly added systems with CPU port 5 or 7 will also work.

Regards

