Return-Path: <netdev+bounces-83658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F1893457
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E27B25983
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711E146D68;
	Sun, 31 Mar 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVrctO8z"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C3215B54C
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903349; cv=fail; b=PZeW+MsAyvSmnrwiAFU4KUPDSoHsysLha3bYHOcP4nRLnKjGIzZvsRE84QY+YHkPbNsNv2YwvKdNZrwvmu2PXdbr2J6NHWSvx8w8V79Zpu7qFnR2B3B0qH06cY1ASzOHBxbKp5xhEq5Q0xN7bGliKVI+dFaV8adRR5VQlDm+YGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903349; c=relaxed/simple;
	bh=s7d985nCy8XGHA6WexmCDeQ4pqhUXWDBwG3CAaUfuC4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VfRHOa8fa82QGb8xNHJSxeGFiYZPYhzWa/jXCNWYJNCW6Y6raz5bDCxpa+eC9rLQldWj041T05nGdLFtmTU8Yt8OBwZwYct7xGyAgBoJcDFn27IhsYFtkpvjkCuiODbgNBCHDDfyJHNH9rDkQxSB364lzbsVHtg0DcKQFQaHIuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVrctO8z reason="signature verification failed"; arc=none smtp.client-ip=209.85.218.49; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9E83F208B7;
	Sun, 31 Mar 2024 18:42:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0gRqmgAO7eD9; Sun, 31 Mar 2024 18:42:24 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4DD07208B5;
	Sun, 31 Mar 2024 18:42:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4DD07208B5
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 40FBB80005E;
	Sun, 31 Mar 2024 18:42:24 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:42:24 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:22 +0000
X-sender: <netdev+bounces-83501-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoApIumlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgCLAAAA2ooAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 16567
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83501-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 795F920872
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711799345; cv=none; b=lCb1yvKkqViLPgto6qBd7bGC1k4hY0gBevNa0w0YFCPxaUzW8VqzeHY1sgQ5A0FZh954+I2gvuR5n12hCQHsHJOgS5v/Gi9u+v3Z361912dKPC831fqJeSvjkjXuFTKai996glJw7AiXxRj1daS/+64xfEAH7nOye8R2uvW6qdY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711799345; c=relaxed/simple;
	bh=nBJiVvg3k1NRVdugpi2ZiNvoICXFmLmlgnxcSt64rsQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bOFOB4Ut6Pdms1hLzqrSEMPNdhBbNWKaAAO/AIGHweFGIPic6DdWY33YstMKOGFi2afh6TlvhZikb69HCwYX96G7wzEay625oRQ/C34wz6nbFOqbNShRgI98Jz9f9K3ZOz4Gj4T0WDXuPOMGLDx1ptF7wMke8KKKujk94UaGONk=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVrctO8z; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711799342; x=1712404142; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5NtRlwss60JP8pGsT9m1cDwtgx9pjihCANYuglI/hk=;
        b=RVrctO8zu+eAZG9EPTmxRiyu/calS/TqaP0F9ZG8PrZ3/Jo3xjwKLN8X4ZK/4TYU3a
         rSQrSlu5HqF0fNvrt30exFRh/qgp4FtByN+zrvfsz2PY2w3Gr8ngJ5x2tZjtG5ZMTFGP
         O+hxZuVu6OyqZAMPlhZY7bAdrR+Fpog76voQxreeoudyRHDCUenycUpIjHQ688fH829b
         UctP8Y1SNHFVQC6TWYhBVHegQXRMVRDB+0n3awk40INjMzoFJFdITZJ8LAR5MDUlDMtG
         sWqD8HXMN/HqLl0EJG70kLL1thNSTXta6DucUB+dtSrocDb+5bw7cOTLyWUiC8gKDJMQ
         wjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711799342; x=1712404142;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5NtRlwss60JP8pGsT9m1cDwtgx9pjihCANYuglI/hk=;
        b=r1PER1fL8VFDVe9SflApOYV2puqWqsBrWbxhnATCsUElFfPojXXpuUEOa7Cw6jlO1I
         Y/JOqFZgnx35/xPh2HfP2MdJbs5QrFiMuoi00FDdA5Fmy0vd4YL8Jdg8qGU+HAJV7pPB
         fbo/CEse2MLtmpmx8IHLfcaI/bGqZOMbEF/pjD237xpKFVhTWHH8q/4dXf/yFIdn/VYw
         eemYFXJJowd4CahQQc8ehoZX3mUioC7PbcpqYUjjt4QMoNrrnBqrMvrQtSCp8WHqvr8R
         nRiyYqoz3DibT21nVLN0U+Gz79hMyslNZTzHQCRzKNSPWINkqZykNuRS94/nfxghgG0h
         t5jg==
X-Gm-Message-State: AOJu0YydR1ERlIv7pJ6TCclWGN8YIK/hLrH2VXj/ZXo3xo7n8pwnoQ2q
	ElWoxeTBOz/b7pIq5lCvSn4PtwgSN583DOnzQnq/FYwMHouK8T5Y
X-Google-Smtp-Source: AGHT+IGQ0cjHf8II8DkumlvWkLc84Qgd4pmaAGa35vXiFfYnufrSy6ERo1o0GCNl7Oj0HqwD+/Z78w==
X-Received: by 2002:a50:aa8a:0:b0:56c:5990:813f with SMTP id q10-20020a50aa8a000000b0056c5990813fmr3776712edc.17.1711799342242;
        Sat, 30 Mar 2024 04:49:02 -0700 (PDT)
Message-ID: <64f2055e-98b8-45ec-8568-665e3d54d4e6@gmail.com>
Date: Sat, 30 Mar 2024 12:49:02 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] r8169: fix issue caused by buggy BIOS on certain boards
 with RTL8168d
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On some boards with this chip version the BIOS is buggy and misses
to reset the PHY page selector. This results in the PHY ID read
accessing registers on a different page, returning a more or
less random value. Fix this by resetting the page selector first.

Fixes: f1e911d5d0df ("r8169: add basic phylib support")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethern=
et/realtek/r8169_main.c
index 5c879a5c8..3936db3d4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5141,6 +5141,15 @@ static int r8169_mdio_register(struct rtl8169_privat=
e *tp)
 	struct mii_bus *new_bus;
 	int ret;
=20
+	/* On some boards with this chip version the BIOS is buggy and misses
+	 * to reset the PHY page selector. This results in the PHY ID read
+	 * accessing registers on a different page, returning a more or
+	 * less random value. Fix this by resetting the page selector first.
+	 */
+	if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_25 ||
+	    tp->mac_version =3D=3D RTL_GIGA_MAC_VER_26)
+		r8169_mdio_write(tp, 0x1f, 0);
+
 	new_bus =3D devm_mdiobus_alloc(&pdev->dev);
 	if (!new_bus)
 		return -ENOMEM;
--=20
2.44.0


X-sender: <netdev+bounces-83501-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgP=
ADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJ=
jZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAG=
IAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IR=
jIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACh=
eZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJ=
hdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ0=
49c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhd=
GlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngt=
ZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmV=
jaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAA=
UAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPV=
T1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNl=
U3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGN=
oYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW=
5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAnoumlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAIwAAADaigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 16556
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 12:49:16 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 12:49:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 39B2420872
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 12:49:16 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=3D-2.749 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, FREEMAIL_FORGED_FROMDOMAIN=3D0.001,
	FREEMAIL_FROM=3D0.001, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dgmail.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VgkTU3fZwprz for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 12:49:12 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.199.223; helo=3Dny.mirrors.kernel.org; envelope-from=3Dnetdev+bou=
nces-83501-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteff=
en.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D81D42087B
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D81D42087B
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 12:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B3E1C20850
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACBA3613C;
	Sat, 30 Mar 2024 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dgmail.com header.i=3D@gmail.com head=
er.b=3D"RVrctO8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218=
.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F51FBA
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D209.85.218.49
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711799345; cv=3Dnone; b=3DlCb1yvKkqViLPgto6qBd7bGC1k4hY0gBevNa0w0YFCP=
xaUzW8VqzeHY1sgQ5A0FZh954+I2gvuR5n12hCQHsHJOgS5v/Gi9u+v3Z361912dKPC831fqJeS=
vjkjXuFTKai996glJw7AiXxRj1daS/+64xfEAH7nOye8R2uvW6qdY=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711799345; c=3Drelaxed/simple;
	bh=3DnBJiVvg3k1NRVdugpi2ZiNvoICXFmLmlgnxcSt64rsQ=3D;
	h=3DMessage-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=3DbOFO=
B4Ut6Pdms1hLzqrSEMPNdhBbNWKaAAO/AIGHweFGIPic6DdWY33YstMKOGFi2afh6TlvhZikb69=
HCwYX96G7wzEay625oRQ/C34wz6nbFOqbNShRgI98Jz9f9K3ZOz4Gj4T0WDXuPOMGLDx1ptF7wM=
ke8KKKujk94UaGONk=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dgmail.com; spf=3Dpass smtp.mailfrom=3Dgm=
ail.com; dkim=3Dpass (2048-bit key) header.d=3Dgmail.com header.i=3D@gmail.=
com header.b=3DRVrctO8z; arc=3Dnone smtp.client-ip=3D209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dgmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dgmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46de423039=
so155836866b.0
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 04:49:03 -0700 (PDT)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dgmail.com; s=3D20230601; t=3D1711799342; x=3D1712404142; darn=
=3Dvger.kernel.org;
        h=3Dcontent-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:=
cc
         :subject:date:message-id:reply-to;
        bh=3DF5NtRlwss60JP8pGsT9m1cDwtgx9pjihCANYuglI/hk=3D;
        b=3DRVrctO8zu+eAZG9EPTmxRiyu/calS/TqaP0F9ZG8PrZ3/Jo3xjwKLN8X4ZK/4TY=
U3a
         rSQrSlu5HqF0fNvrt30exFRh/qgp4FtByN+zrvfsz2PY2w3Gr8ngJ5x2tZjtG5ZMTF=
GP
         O+hxZuVu6OyqZAMPlhZY7bAdrR+Fpog76voQxreeoudyRHDCUenycUpIjHQ688fH82=
9b
         UctP8Y1SNHFVQC6TWYhBVHegQXRMVRDB+0n3awk40INjMzoFJFdITZJ8LAR5MDUlDM=
tG
         sWqD8HXMN/HqLl0EJG70kLL1thNSTXta6DucUB+dtSrocDb+5bw7cOTLyWUiC8gKDJ=
MQ
         wjwQ=3D=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1711799342; x=3D1712404142;
        h=3Dcontent-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DF5NtRlwss60JP8pGsT9m1cDwtgx9pjihCANYuglI/hk=3D;
        b=3Dr1PER1fL8VFDVe9SflApOYV2puqWqsBrWbxhnATCsUElFfPojXXpuUEOa7Cw6jl=
O1I
         Y/JOqFZgnx35/xPh2HfP2MdJbs5QrFiMuoi00FDdA5Fmy0vd4YL8Jdg8qGU+HAJV7p=
PB
         fbo/CEse2MLtmpmx8IHLfcaI/bGqZOMbEF/pjD237xpKFVhTWHH8q/4dXf/yFIdn/V=
Yw
         eemYFXJJowd4CahQQc8ehoZX3mUioC7PbcpqYUjjt4QMoNrrnBqrMvrQtSCp8WHqvr=
8R
         nRiyYqoz3DibT21nVLN0U+Gz79hMyslNZTzHQCRzKNSPWINkqZykNuRS94/nfxghgG=
0h
         t5jg=3D=3D
X-Gm-Message-State: AOJu0YydR1ERlIv7pJ6TCclWGN8YIK/hLrH2VXj/ZXo3xo7n8pwnoQ2=
q
	ElWoxeTBOz/b7pIq5lCvSn4PtwgSN583DOnzQnq/FYwMHouK8T5Y
X-Google-Smtp-Source: AGHT+IGQ0cjHf8II8DkumlvWkLc84Qgd4pmaAGa35vXiFfYnufrSy=
6ERo1o0GCNl7Oj0HqwD+/Z78w=3D=3D
X-Received: by 2002:a50:aa8a:0:b0:56c:5990:813f with SMTP id q10-20020a50aa=
8a000000b0056c5990813fmr3776712edc.17.1711799342242;
        Sat, 30 Mar 2024 04:49:02 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c54b:5400:d8e5:ac12:4b1:6e15? (dynamic-2a01-0=
c23-c54b-5400-d8e5-ac12-04b1-6e15.c23.pool.telefonica.de. [2a01:c23:c54b:54=
00:d8e5:ac12:4b1:6e15])
        by smtp.googlemail.com with ESMTPSA id n24-20020a05640204d800b0056c=
5d0c932bsm2043917edw.53.2024.03.30.04.49.01
        (version=3DTLS1_3 cipher=3DTLS_AES_128_GCM_SHA256 bits=3D128/128);
        Sat, 30 Mar 2024 04:49:01 -0700 (PDT)
Message-ID: <64f2055e-98b8-45ec-8568-665e3d54d4e6@gmail.com>
Date: Sat, 30 Mar 2024 12:49:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] r8169: fix issue caused by buggy BIOS on certain board=
s
 with RTL8168d
Autocrypt: addr=3Dhkallweit1@gmail.com; keydata=3D
 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3D
Content-Type: text/plain; charset=3D"UTF-8"
Content-Transfer-Encoding: 7bit
Return-Path: netdev+bounces-83501-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 11:49:16.2529
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 5ac4ac28-8a33-42e3-af14-08dc=
50af6d45
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.178|SMR=3D0.135(SMRDE=3D0.005|SMRC=3D0.129(=
SMRCL=3D0.102|X-SMRCR=3D0.129))|CAT=3D0.041(CATRESL=3D0.009
 (CATRESLP2R=3D0.004)|CATORES=3D0.028(CATRS=3D0.028(CATRS-Transport Rule
 Agent=3D0.001|CATRS-Index Routing Agent=3D0.026 )));2024-03-30T11:49:16.44=
6Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 12890
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.016|SMR=3D0.006(SMRPI=3D0.004(SMRPI-FrontendProxyAgent=3D0.004))=
|SMS=3D0.009
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAcsDAAAPAAADH4sIAAAAAAAEAK1TW2/b=
NhSmHFuO6ahpl7
 VvA876MMRxJFuN7dXJEqTrsjbY0hRtUWBPhi60TESWDJLOBciv6y/b
 IWXHLrCsLlpCoA55vnP9Dj/VzzOQ+ZhBmAcilnDF1QjUiEuIRnwCl0
 xInmd4w+D30/P3gIpwmiQ3EGQxjLmUTDpU5SCYZMrA3r7+ByZBwkCy
 lEUqFx580P4QMU2VBJ7dwU7/wNsgdmgQRUxKniV4TrhUGBUwagAxHw
 6ZYJkyLndRraYi08AAxrlgkAuHpmgLAhPKx3AZpFPmwZ/8uqgivClS
 U9pGx/0sNRhyIZXnUIeiBZP7MPRZ3/fjbtyOh7D9VDz3e/19COIYwk
 DyCCajm5SHIKeTSS7U04ZDX0b7IFUQpuz4MmHCu2AiY6mXi8Sh73mS
 sdjNh0M3vNmH14xnTMBfQZpeMa7gt9HFTPSPk3HAUy/Kx0cOdV3XoR
 ALrtvfyphqMUxdaAH7lSp20TKJDdAm8yK4hT405wstfawrZchgkCUs
 3kUtzyQTCpmU282GLlc3Flw3wSyC1uqRwtWxDuVZzK6hGz3/tR/g7n
 l7/b1eHO7FHfDb7V6nYyr9mvgOxQK/LonjY3C7fsff7UHT/P0u4B0y
 ppBOjpM1w8c8H8ynb1sqMY1QpVKjnGC8QDHYURPsHszWDDTmfBBOJe
 xk7EoLBwuEcc/Uge54c3bX2oHv8ebm7mAHvvn5Lfn6tpe45Og7PMqF
 t9biwPFZqol7NA6iwbxTh4fw7sPfg1enr14Mzl68HHw8eTd41oXb2y
 UfuFYy6zU+N9JraUKuBFcME9iF9rU/xL2B5DYXjM9mAA4hZpdjY4PH
 AT7zPNr+ZYKX7hFujeUhwYp+ntktTdddcNNocE/enJ+dnB3oN+PQZ1
 6n47X1WDmUkBJZK5OKTaq4F1+VrK+RMgqoqhAbZZus38mFap3QAon3
 xaXxY9cIxQ9li5RqGqNvUDbeykWgCqne+Uft3GGtQiiqNshmAcBwCK
 6SOhraFnliMrS1qoJHx2C0ilQxGYzxI6mbDDeK/NEhChWLUGKjoWWV
 LUIs64HeTT5Vq1bIlDwqG28o/7ctKd2v0m2pkXrNojYhNtm4H1m9V2
 XZFYI/22RYKuSSpsa2i1ZYZMsg0VD3xCKbZL1KaiXiaAC61hRU5sID
 w8jWasxurcbso/9ldvNLzP5UMmShcZ2UkdM1XZHW6hBW2RS79SXAY+
 zDQ9MHTFiPU9Ex8nBeuI0U/mCSr+iqsajN0qItT3CMbcspmqwdWmta
 /hfUqMARxwgAAAEK4gI8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW
 5nPSJ1dGYtMTYiPz4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUu
 MC4wLjA8L1ZlcnNpb24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIF
 N0YXJ0SW5kZXg9IjMyNSIgUG9zaXRpb249Ik90aGVyIj4NCiAgICAg
 IDxFbWFpbFN0cmluZz5zdGFibGVAdmdlci5rZXJuZWwub3JnPC9FbW
 FpbFN0cmluZz4NCiAgICA8L0VtYWlsPg0KICAgIDxFbWFpbCBTdGFy
 dEluZGV4PSIzODEiIFBvc2l0aW9uPSJPdGhlciI+DQogICAgICA8RW
 1haWxTdHJpbmc+aGthbGx3ZWl0MUBnbWFpbC5jb208L0VtYWlsU3Ry
 aW5nPg0KICAgIDwvRW1haWw+DQogIDwvRW1haWxzPg0KPC9FbWFpbF
 NldD4BDs8BUmV0cmlldmVyT3BlcmF0b3IsMTAsMTtSZXRyaWV2ZXJP
 cGVyYXRvciwxMSwyO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMCwxO1
 Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMSwwO1Bvc3RXb3JkQnJlYWtl
 ckRpYWdub3N0aWNPcGVyYXRvciwxMCwyO1Bvc3RXb3JkQnJlYWtlck
 RpYWdub3N0aWNPcGVyYXRvciwxMSwwO1RyYW5zcG9ydFdyaXRlclBy b2R1Y2VyLDIwLDEx
X-MS-Exchange-Forest-IndexAgent: 1 1551
X-MS-Exchange-Forest-EmailMessageHash: 740C8317
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On some boards with this chip version the BIOS is buggy and misses
to reset the PHY page selector. This results in the PHY ID read
accessing registers on a different page, returning a more or
less random value. Fix this by resetting the page selector first.

Fixes: f1e911d5d0df ("r8169: add basic phylib support")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethern=
et/realtek/r8169_main.c
index 5c879a5c8..3936db3d4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5141,6 +5141,15 @@ static int r8169_mdio_register(struct rtl8169_privat=
e *tp)
 	struct mii_bus *new_bus;
 	int ret;
=20
+	/* On some boards with this chip version the BIOS is buggy and misses
+	 * to reset the PHY page selector. This results in the PHY ID read
+	 * accessing registers on a different page, returning a more or
+	 * less random value. Fix this by resetting the page selector first.
+	 */
+	if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_25 ||
+	    tp->mac_version =3D=3D RTL_GIGA_MAC_VER_26)
+		r8169_mdio_write(tp, 0x1f, 0);
+
 	new_bus =3D devm_mdiobus_alloc(&pdev->dev);
 	if (!new_bus)
 		return -ENOMEM;
--=20
2.44.0



