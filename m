Return-Path: <netdev+bounces-83634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307168933A7
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D870F2893AB
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AABD14D436;
	Sun, 31 Mar 2024 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPl6KWXQ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA7B14D2BA;
	Sun, 31 Mar 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903109; cv=fail; b=oRq1cmNcZooe6PVFVdQQK8y7rgqKyJ3TMrHAkb9zN7E750Tq6uk7hdYnd91KEqlrTuvwhApSokcEx5PvmjKwytboAURRC2+FgnlIMYe2TSlb99p+6ztwanjiqnV2fM4u30Tyd6nUOwsDa5id9RMZPCiUvIR5PoP/dwCr+AzK4gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903109; c=relaxed/simple;
	bh=ZK80YF2MwXB/lf6liIrm/cY5iH4dmEpHB/UVBgabddA=;
	h=Content-Type:MIME-Version:Subject:From:Message-ID:Date:References:
	 In-Reply-To:To:Cc; b=Kz6aCNuMk1elcVEqeVwJjG2vdBM5HWXRVU1fzAy3bTeD99J2DO53YWgDJEbXkQk7KjeZwPi03oVIAouzNjXvOjNS/KuE78cgO/WH3toHSb8spPf0uoV0hW20cI/n2GH62FOGA8LODQ1HrTsUwZMKE7b8VvgVMLq4HoPw2GiRaKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPl6KWXQ reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A075820844;
	Sun, 31 Mar 2024 18:38:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ldEZmv-kkqqs; Sun, 31 Mar 2024 18:38:24 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 52B202083E;
	Sun, 31 Mar 2024 18:38:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 52B202083E
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 461EC80004A;
	Sun, 31 Mar 2024 18:38:24 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:38:24 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:17 +0000
X-sender: <netdev+bounces-83480-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAWUmmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgBhAAAAzYoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 11362
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83480-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C852520883
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752630; cv=none; b=biBVEMUQ0pD3FmSkiJ9sxBbHb4wsOhsdC/IdJPvSVut/O5ab4dGWb/JB4h7/kIEea7Isbp+0JWXbQcGvdHqbf32MGnBZgKI7LTgHmREL4Pk2n46xU4OUudeIhI1EVYcsawHRF/XjZfg9gyAd5m3VwiZcrlemZWbTe6IRaYs1fSs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752630; c=relaxed/simple;
	bh=d6GYHZj1nwm/xAWq38KgFLCAjeu3oj6MG7PKrVN2dik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=epB2fowdHfquABx1fTbw/pWYcb7zELL1S85TXQhbSuZrEdOy/Iw4/M0mheG84kZyq9ge+0D74lr7YAuOo4SHQnxknXl0v6xGY3rGARafXBaZC+G0Jox/R9OWJYbvCTSHCwEFwQljA768dYbO0avYQLgSYa/IHcgODQ4U7H9VZMo=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPl6KWXQ; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711752630;
	bh=d6GYHZj1nwm/xAWq38KgFLCAjeu3oj6MG7PKrVN2dik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QPl6KWXQvu8etNRRr+r8OMKyD6R97QbdR9BUKsTPtOE7Kqjbj0Wzwr2xkLyiUBOCj
	 EhPM3BDLS7sB3nqz8OwL4C5r4EVrvhikxo71yksyhl6g8RZix/5BP7LjrYPeBKOfUp
	 wBDjGqQX99DbyBqqEiSjvjL/oqo3Zl0up2BrkC0QCEcbAAzoAyb4Ht/h7gmsISUFFH
	 bFa5SbbqTmqpeirrBBBF0jFPoiF2SQIFEgVHTAO0enqA8UJgc7iNjAzyhoGYr0Io7u
	 qqFGr/qSOegSrVvqT6lM2WA3H4zZrrLtdkBIK1J6oKBNL/j7HGWNFywkVMJdW0nwTT
	 vR5M4jXKxAarQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: pull request: bluetooth 2024-03-29
From: patchwork-bot+netdevbpf@kernel.org
Message-ID: <171175263013.1693.13688049482640225166.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 22:50:30 +0000
References: <20240329140453.2016486-1-luiz.dentz@gmail.com>
In-Reply-To: <20240329140453.2016486-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 10:04:53 -0400 you wrote:
> The following changes since commit 0ba80d96585662299d4ea4624043759ce90154=
21:
>=20
>   octeontx2-af: Fix issue with loading coalesced KPU profiles (2024-03-29=
 11:45:42 +0000)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git t=
ags/for-net-2024-03-29
>=20
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-03-29
    https://git.kernel.org/netdev/net/c/365af7ace014

You are awesome, thank you!
--=20
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



X-sender: <netdev+bounces-83480-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAWUmmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGMAAADNigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 11513
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 23:50:41 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 23:50:41 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id CF6E5200BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:50:41 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.399
X-Spam-Level:
X-Spam-Status: No, score=3D-5.399 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIMWL_WL_HIGH=3D-0.099, DKIM_SIGNED=3D0.1,
	DKIM_VALID=3D-0.1, DKIM_VALID_AU=3D-0.1, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dham autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FcKgo2F85RVu for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 23:50:41 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83480-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com B8CFA2032C
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"QPl6KWXQ"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id B8CFA2032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40612844F2
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0E813D248;
	Fri, 29 Mar 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"QPl6KWXQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.or=
g [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0D849C;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D10.30.226.201
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711752630; cv=3Dnone; b=3DbiBVEMUQ0pD3FmSkiJ9sxBbHb4wsOhsdC/IdJPvSVut=
/O5ab4dGWb/JB4h7/kIEea7Isbp+0JWXbQcGvdHqbf32MGnBZgKI7LTgHmREL4Pk2n46xU4OUud=
eIhI1EVYcsawHRF/XjZfg9gyAd5m3VwiZcrlemZWbTe6IRaYs1fSs=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711752630; c=3Drelaxed/simple;
	bh=3Dd6GYHZj1nwm/xAWq38KgFLCAjeu3oj6MG7PKrVN2dik=3D;
	h=3DContent-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=3DepB2fowdHfquABx1fTbw/pWYcb7zELL1S85TXQhbSuZrEdOy/I=
w4/M0mheG84kZyq9ge+0D74lr7YAuOo4SHQnxknXl0v6xGY3rGARafXBaZC+G0Jox/R9OWJYbvC=
TSHCwEFwQljA768dYbO0avYQLgSYa/IHcgODQ4U7H9VZMo=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dkim=3Dpass (2=
048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org header.b=3DQPl6KW=
XQ; arc=3Dnone smtp.client-ip=3D10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3013CC43394;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dkernel.org;
	s=3Dk20201202; t=3D1711752630;
	bh=3Dd6GYHZj1nwm/xAWq38KgFLCAjeu3oj6MG7PKrVN2dik=3D;
	h=3DSubject:From:Date:References:In-Reply-To:To:Cc:From;
	b=3DQPl6KWXQvu8etNRRr+r8OMKyD6R97QbdR9BUKsTPtOE7Kqjbj0Wzwr2xkLyiUBOCj
	 EhPM3BDLS7sB3nqz8OwL4C5r4EVrvhikxo71yksyhl6g8RZix/5BP7LjrYPeBKOfUp
	 wBDjGqQX99DbyBqqEiSjvjL/oqo3Zl0up2BrkC0QCEcbAAzoAyb4Ht/h7gmsISUFFH
	 bFa5SbbqTmqpeirrBBBF0jFPoiF2SQIFEgVHTAO0enqA8UJgc7iNjAzyhoGYr0Io7u
	 qqFGr/qSOegSrVvqT6lM2WA3H4zZrrLtdkBIK1J6oKBNL/j7HGWNFywkVMJdW0nwTT
	 vR5M4jXKxAarQ=3D=3D
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.loc=
aldomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2=
2B38D2D0EB;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
Content-Type: text/plain; charset=3D"utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-03-29
From: patchwork-bot+netdevbpf@kernel.org
Message-ID: <171175263013.1693.13688049482640225166.git-patchwork-notify@ke=
rnel.org>
Date: Fri, 29 Mar 2024 22:50:30 +0000
References: <20240329140453.2016486-1-luiz.dentz@gmail.com>
In-Reply-To: <20240329140453.2016486-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Return-Path: netdev+bounces-83480-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 22:50:41.9112
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: ef744b4b-f054-4f0b-f6c5-08dc=
5042a95a
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.401|SMR=3D0.323(SMRDE=3D0.004|SMRC=3D0.318(=
SMRCL=3D0.013|X-SMRCR=3D0.317))|CAT=3D0.076(CATOS=3D0.001
 |CATRESL=3D0.032(CATRESLP2R=3D0.018)|CATORES=3D0.035(CATRS=3D0.035(CATRS-T=
ransport
 Rule Agent=3D0.001 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.032))|CATORT=3D0.005(CATRT=3D0.005(CATRT-Journal Agent=3D0.004
 )));2024-03-29T22:50:42.328Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7100
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.015|SMR=3D0.007(SMRPI=3D0.003(SMRPI-FrontendProxyAgent=3D0.003))=
|SMS=3D0.009
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAckCAAAPAAADH4sIAAAAAAAEAGVS23LT=
MBBd59bEjYHpFy
 xv7VBf4jhp42E6PEC5dBh4KA8Mw4PiKLEmtmUsuWl/ly9hZQdCwdas
 Je3uOWd3/bP/jmeZjB3bsW9TobCsswwr/qPmSuOOKWRlmQm+Qi2x4H
 rF73z6eBuh8TRnojhz7OUDfmDbeok3IhGF2gp8SSf2asurgmeerDZX
 Df6nAq8rcY7hAj+yCsMgjHASxEEUz6boBlEQ4IOscVdJzSnhCm9Tjm
 tJ8nai2GCSsmLDFSpRJBwTmeekIViyy2C1mM8uZ/N5GC4Wq4izaB5G
 QTS9mC0SvggmsyicGDwDiSgTzWWh70OXrWO8FvcolKo57oROMZNs1X
 BJlnGVUNk3n79gWcm1oDOeGs1uMHWphMkkjmZxFOKLgJ6zPT6rOLI7
 JjK2zDiKAjXV8JaEVryUSmhZPSDTBzXUx9j3yXqHbvllvfRVkvuZKO
 p7v3WYGH+Z1VxLqdPDrpmEZhvlr2Xl0mjcg8Y9yzfP876bAbzjpI5m
 bDSpOs8ZiWnLFsVWkShE99EPEOMfHvwbloRjqnWp/td++Ef8xJ/OZ2
 x9wRIeTCIj4CuNt+nQjiuZ83NSwoqtmfpzx3Zdx37NqYAV8ZHR5/ge
 WY4Ml1J7jv2bcEs03kom6lHLmE7Snay2frkz4anOM8NoXoA+2D3o0z
 qCYRd6ZDvQHVjwBI7o2DWuI7rpw2BIkRY8hf7AuEZ0Sd6OBce0zL7X
 s/pDC4YAQ2vUN8gDuiR8siOwCZluKPcUwpEFY7A7Bp8CBi37qIlsWW
 xaBA7djtV9jOm0aA27SbfhuAPjrgVvGrrBXvYeuT1SfAtORBR5Ql6L
 9kCCOwBEYSyc9BrGtgm078O4ETYa/SOJCrEgaNrV4rfWgs4YnrXUlN
 WUbxKdpr3UKwqgdLJdGNBh0rD09v00Ik0rfgHXvbdCdgQAAAEK1QE8
 P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCj
 xFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+
 DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9Ijg1Ij
 4NCiAgICAgIDxFbWFpbFN0cmluZz5rdWJhQGtlcm5lbC5vcmc8L0Vt
 YWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQogIDwvRW1haWxzPg0KPC
 9FbWFpbFNldD4BC/UCPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGlu
 Zz0idXRmLTE2Ij8+DQo8VXJsU2V0Pg0KICA8VmVyc2lvbj4xNS4wLj
 AuMDwvVmVyc2lvbj4NCiAgPFVybHM+DQogICAgPFVybCBTdGFydElu
 ZGV4PSI1NjgiIFR5cGU9IlVybCI+DQogICAgICA8VXJsU3RyaW5nPm
 h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvbmV0ZGV2L25ldC9jLzM2NWFm
 N2FjZTAxNDwvVXJsU3RyaW5nPg0KICAgIDwvVXJsPg0KICAgIDxVcm
 wgU3RhcnRJbmRleD0iNjgxIiBUeXBlPSJVcmwiPg0KICAgICAgPFVy
 bFN0cmluZz5odHRwczovL2tvcmcuZG9jcy5rZXJuZWwub3JnL3BhdG
 Nod29yay9wd2JvdC5odG1sPC9VcmxTdHJpbmc+DQogICAgPC9Vcmw+
 DQogIDwvVXJscz4NCjwvVXJsU2V0PgEM6AM8P3htbCB2ZXJzaW9uPS
 IxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxDb250YWN0U2V0Pg0K
 ICA8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPENvbnRhY3
 RzPg0KICAgIDxDb250YWN0IFN0YXJ0SW5kZXg9IjY5Ij4NCiAgICAg
 IDxQZXJzb24gU3RhcnRJbmRleD0iNjkiPg0KICAgICAgICA8UGVyc2
 9uU3RyaW5nPkpha3ViIEtpY2luc2tpPC9QZXJzb25TdHJpbmc+DQog
 ICAgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgID
 xFbWFpbCBTdGFydEluZGV4PSI4NSI+DQogICAgICAgICAgPEVtYWls
 U3RyaW5nPmt1YmFAa2VybmVsLm9yZzwvRW1haWxTdHJpbmc+DQogIC
 AgICAgIDwvRW1haWw+DQogICAgICA8L0VtYWlscz4NCiAgICAgIDxD
 b250YWN0U3RyaW5nPkpha3ViIEtpY2luc2tpICZsdDtrdWJhQGtlcm
 5lbC5vcmc8L0NvbnRhY3RTdHJpbmc+DQogICAgPC9Db250YWN0Pg0K
 ICA8L0NvbnRhY3RzPg0KPC9Db250YWN0U2V0PgEOzwFSZXRyaWV2ZX
 JPcGVyYXRvciwxMCwxO1JldHJpZXZlck9wZXJhdG9yLDExLDI7UG9z
 dERvY1BhcnNlck9wZXJhdG9yLDEwLDE7UG9zdERvY1BhcnNlck9wZX
 JhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJh
 dG9yLDEwLDE7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJhdG
 9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVjZXIsMjAsMTI=3D
X-MS-Exchange-Forest-IndexAgent: 1 2021
X-MS-Exchange-Forest-EmailMessageHash: 02E9B2CA
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 10:04:53 -0400 you wrote:
> The following changes since commit 0ba80d96585662299d4ea4624043759ce90154=
21:
>=20
>   octeontx2-af: Fix issue with loading coalesced KPU profiles (2024-03-29=
 11:45:42 +0000)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git t=
ags/for-net-2024-03-29
>=20
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-03-29
    https://git.kernel.org/netdev/net/c/365af7ace014

You are awesome, thank you!
--=20
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




