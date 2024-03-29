Return-Path: <netdev+bounces-83605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5238932DE
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D89F1F22CB0
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1414885E;
	Sun, 31 Mar 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7k6wgpO"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7C21487CD
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902389; cv=fail; b=TPFGKyVtxN1mphUE/v6T9xayONNHbE8t/wkX6nAi8tWeb5ZGZd93nvxjzzWxXo3ahv8LQkN04GoxtdA972zs3N4fyeSFV7y7eKMyxjiRMYVfeAW2f+t1AqKDxI/X6wydDF27D1aL6Y29OKZg2470o0R6SQlNmMuc7Kzx39w6h0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902389; c=relaxed/simple;
	bh=rDJtBZRV+HqmQ6845rWvgLj7s6rZPR9QR2+66q3nhL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9Hp3AqLT7WVuYEci4XBAOLPOaFuBq3iqQH1bMQuTmCO8YKkb0NvpfhQC8cbwCW2FVUvZ3OAs96qtfq87+hIjjYw3N95SH2AtsX8NgKgeGykDzIq2h/2ao1bUBKl47JJ5cRC2SPxbFSJ7XS0XBmrIrjghiJrE3dHac3qCVt4KtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7k6wgpO reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 999A220897;
	Sun, 31 Mar 2024 18:26:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wF3hfe9ckn_1; Sun, 31 Mar 2024 18:26:22 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B8A492084C;
	Sun, 31 Mar 2024 18:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B8A492084C
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id AC8A480004A;
	Sun, 31 Mar 2024 18:26:20 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:20 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:34 +0000
X-sender: <netdev+bounces-83472-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAw5Lp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAZAAAAjIoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 9397
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83472-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 0EA01200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7k6wgpO"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750086; cv=none; b=oV+q68HQeTF748KBPLD+dQjQdQpb5iJwQh/clFRJnPotjznqr0YLXyt7QSE+T6FgLWGuZRORpSZJrROJfDX8f97NCFff8e/YChchGqZFHLuRmHJBL/QM+5pc4teb6Jwkr130D1Fz+vv8dspH+OqTmcLuBaLOf/zP5w0hiFTWr0s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750086; c=relaxed/simple;
	bh=kWMETMXKh9pRUAzvZSWq7Bz15B/8zNSH35OZ7BKefWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0x6I1P/VLoP8CEBqZPizhsHJAFAxf5EuycvfYcERObgS0DnMShjS06JWH7y6nJ0asvwOgYM/vEoI2pOXKmsGpm29Zsaicn+5kmZq6LbhCJ5/PsnTfTfIjM4H+nPwK5lDNxVpcmDehQrpjXB7PwogkrcOVupvblyNA1PnqIgPMY=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7k6wgpO; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711750085;
	bh=kWMETMXKh9pRUAzvZSWq7Bz15B/8zNSH35OZ7BKefWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B7k6wgpOpYCMZtcHeZgurRFEn9jwJGxtaPhDeWWiz57ABGohoPp8cFuvxp3seywVT
	 i41cH1D3ebkuoAu6ufLjBgDQYfeitlzDYOUzXDZ3kBiORHqgtYjRP0uJVkR10UB5Ob
	 Lq7Fids2QxfuGxkMzqTUX4/a4sknbiCphzl/eRhmVuUBmF+tlk4qFf5BDiAA/nYn4c
	 5hAcpDR2aXLfShBWguJq/QpgsDd5X28Fd3ALXRVmAb865rwQALLZSqJ/K+PefRhJdO
	 8mTdDVfx1gqowAa5QH0Xx2rfwHeqBnB2HBEaTvME6QONh698m8tTEmNLy4eY9csIG0
	 ZcIa7WOCHRlQQ==
Date: Fri, 29 Mar 2024 15:08:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/4] net: team: rename team to team_core for
 linking
Message-ID: <20240329150804.7189ced3@kernel.org>
In-Reply-To: <20240329082847.1902685-3-liuhangbin@gmail.com>
References: <20240329082847.1902685-1-liuhangbin@gmail.com>
	<20240329082847.1902685-3-liuhangbin@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, 29 Mar 2024 16:28:45 +0800 Hangbin Liu wrote:
> diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlin=
k/specs/team.yaml
> index 907f54c1f2e3..c13529e011c9 100644
> --- a/Documentation/netlink/specs/team.yaml
> +++ b/Documentation/netlink/specs/team.yaml
> @@ -202,5 +202,3 @@ operations:
>            attributes:
>              - team-ifindex
>              - list-port
> -            - item-port
> -            - attr-port

I think you squashed this into the wrong patch :S
--=20
pw-bot: cr

X-sender: <netdev+bounces-83472-steffen.klassert=3Dsecunet.com@vger.kernel.=
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
X-ExtendedProps: BQBjAAoAq5Lp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAaAAAAjIoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 9409
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 23:08:12 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 23:08:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 83CB92032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:08:12 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.399
X-Spam-Level:
X-Spam-Status: No, score=3D-5.399 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIMWL_WL_HIGH=3D-0.099, DKIM_SIGNED=3D0.1,
	DKIM_VALID=3D-0.1, DKIM_VALID_AU=3D-0.1, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lQM26VSCzU5P for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 23:08:12 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83472-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com C00CD200BB
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"B7k6wgpO"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id C00CD200BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07830283CC4
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7947613CF86;
	Fri, 29 Mar 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"B7k6wgpO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.or=
g [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37C79DF
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D10.30.226.201
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711750086; cv=3Dnone; b=3DoV+q68HQeTF748KBPLD+dQjQdQpb5iJwQh/clFRJnPo=
tjznqr0YLXyt7QSE+T6FgLWGuZRORpSZJrROJfDX8f97NCFff8e/YChchGqZFHLuRmHJBL/QM+5=
pc4teb6Jwkr130D1Fz+vv8dspH+OqTmcLuBaLOf/zP5w0hiFTWr0s=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711750086; c=3Drelaxed/simple;
	bh=3DkWMETMXKh9pRUAzvZSWq7Bz15B/8zNSH35OZ7BKefWM=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=3Da0x6I1P/VLoP8CEBqZPizhsHJAFAxf5EuycvfYcERO=
bgS0DnMShjS06JWH7y6nJ0asvwOgYM/vEoI2pOXKmsGpm29Zsaicn+5kmZq6LbhCJ5/PsnTfTfI=
jM4H+nPwK5lDNxVpcmDehQrpjXB7PwogkrcOVupvblyNA1PnqIgPMY=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dkim=3Dpass (2=
048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org header.b=3DB7k6wg=
pO; arc=3Dnone smtp.client-ip=3D10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A4CC433C7;
	Fri, 29 Mar 2024 22:08:04 +0000 (UTC)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dkernel.org;
	s=3Dk20201202; t=3D1711750085;
	bh=3DkWMETMXKh9pRUAzvZSWq7Bz15B/8zNSH35OZ7BKefWM=3D;
	h=3DDate:From:To:Cc:Subject:In-Reply-To:References:From;
	b=3DB7k6wgpOpYCMZtcHeZgurRFEn9jwJGxtaPhDeWWiz57ABGohoPp8cFuvxp3seywVT
	 i41cH1D3ebkuoAu6ufLjBgDQYfeitlzDYOUzXDZ3kBiORHqgtYjRP0uJVkR10UB5Ob
	 Lq7Fids2QxfuGxkMzqTUX4/a4sknbiCphzl/eRhmVuUBmF+tlk4qFf5BDiAA/nYn4c
	 5hAcpDR2aXLfShBWguJq/QpgsDd5X28Fd3ALXRVmAb865rwQALLZSqJ/K+PefRhJdO
	 8mTdDVfx1gqowAa5QH0Xx2rfwHeqBnB2HBEaTvME6QONh698m8tTEmNLy4eY9csIG0
	 ZcIa7WOCHRlQQ=3D=3D
Date: Fri, 29 Mar 2024 15:08:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/4] net: team: rename team to team_core for
 linking
Message-ID: <20240329150804.7189ced3@kernel.org>
In-Reply-To: <20240329082847.1902685-3-liuhangbin@gmail.com>
References: <20240329082847.1902685-1-liuhangbin@gmail.com>
	<20240329082847.1902685-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: netdev+bounces-83472-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 22:08:12.5732
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 29ccca30-b85c-4536-b324-08dc=
503cb9d4
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.400|SMR=3D0.335(SMRDE=3D0.034|SMRC=3D0.30=
1(SMRCL=3D0.101|X-SMRCR=3D0.301))|CAT=3D0.063(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.010))|CATRESL=3D0.040(CATRESLP2R=3D0.017)|CATORES=3D0.009
 (CATRS=3D0.009(CATRS-Index Routing Agent=3D0.008)));2024-03-29T22:08:12.99=
5Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 6938
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.025|SMR=3D0.025(SMRPI=3D0.022(SMRPI-FrontendProxyAgent=3D0.022))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAa0BAAAPAAADH4sIAAAAAAAEAJVRQW7b=
MBBcKqIky5avBX
 Io9taDTVuS5dTWIcghKFqgRQ55AS1TNhGbUiQKqR/S/4ZUCrRBXCAl
 CHAwsxzuLH+5dwq/NHKK6Rp/8AbTOM0wucrTVZ4tcRKv4hi/crXbSI
 XfZYdPTaVFHoXXuJVliYztpEY+v62K7iiU5lpWaq6EPkj1MG9rUbRz
 LfhxduLHA27eV2fdpdqKn7iOP5fLrEjKVCxmsyJZLNO1iJOkWGMSx1
 dZZksZY+/twJZPJpP/aeTmBpkZytQMwx4LS1S1aPqLbT+JvxbXupGb
 Tos3CiJDa8xk2Wc7Ix9kq1ldNbpP9VqTWhz/pdlHf2tR+A313kTBU9
 Vh+9jxdi+2lmrNSHVlkLB/qHZYc13sMb+PQsaisH5im0rnWDTWBMCB
 iwugDoGh2Ra7LqEBQEAGFICC50NgSAqhC74BhMAncCIYG96oLlCzz5
 EWjGA8IpEH4MH4XM3oDEmGLphnKAEgxPmDgYZwGcJHl8AIqA+XBgys
 yYc3ICDgGDfTbQCDlw77CB4Fn4BvwnovqZ8BAwbm1xYDAAABDs4BUm
 V0cmlldmVyT3BlcmF0b3IsMTAsMDtSZXRyaWV2ZXJPcGVyYXRvciwx
 MSwwO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMCwwO1Bvc3REb2NQYX
 JzZXJPcGVyYXRvciwxMSwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0
 aWNPcGVyYXRvciwxMCwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aW
 NPcGVyYXRvciwxMSwwO1RyYW5zcG9ydFdyaXRlclByb2R1Y2VyLDIw LDQ=3D
X-MS-Exchange-Forest-IndexAgent: 1 650
X-MS-Exchange-Forest-EmailMessageHash: B7CBA98D
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, 29 Mar 2024 16:28:45 +0800 Hangbin Liu wrote:
> diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlin=
k/specs/team.yaml
> index 907f54c1f2e3..c13529e011c9 100644
> --- a/Documentation/netlink/specs/team.yaml
> +++ b/Documentation/netlink/specs/team.yaml
> @@ -202,5 +202,3 @@ operations:
>            attributes:
>              - team-ifindex
>              - list-port
> -            - item-port
> -            - attr-port

I think you squashed this into the wrong patch :S
--=20
pw-bot: cr


