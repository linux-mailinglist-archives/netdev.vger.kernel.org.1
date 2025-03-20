Return-Path: <netdev+bounces-176521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151F4A6AA68
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35B83B0E7B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4361EB183;
	Thu, 20 Mar 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="POoCBnAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1614B08A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486176; cv=none; b=sOANClthfrbW81Dl5U8gGo8/juJyigbbq73hJ0texorN9buvj3i0Fr6Knn7tnVjORexlcKJqQTXBjoaPlsnmcun13ddxZBnyVrMOvUh/fGA4TS/d1dv1DvyYsZhAOH03g/kfaNt79lBURFGamjYtRXub1GH6E0rT8YXxmznAQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486176; c=relaxed/simple;
	bh=yQhTHfwy2TR+iogDrZNrsVLrrnFDmnTzQKovH+2w89o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltonY+x84wsfpvP/0FI9PQ+9FHOPUuFnAX5CIujzU6zyYRCQ1GzgJgEWrF7MfoxsuEB721bOxHcbiRC7ssur40+MCvhBe1XZw38EHWBIFy0htaIlsJV4j5H0KjrT3bPBRHQ/mc74D9FF7lwjk/lX+w+l2VGWVxYwnBishh2UCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=POoCBnAV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2243803b776so26367725ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742486174; x=1743090974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yQhTHfwy2TR+iogDrZNrsVLrrnFDmnTzQKovH+2w89o=;
        b=POoCBnAVG772u9mYleFuF1FFcWbYJSB3quryDvvMx2zeAEgaMEQN7ITAbDSWTBcjPr
         w2DbK0nAcsXwGrjcIx5s+OlDkKK36I314qZs9s8QdvOFRT9K5nHcsUea5JDy2pwYyYmN
         yPDOExDgrqF73VuLMcbFQUFMOG8NLjPkYkmuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742486174; x=1743090974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQhTHfwy2TR+iogDrZNrsVLrrnFDmnTzQKovH+2w89o=;
        b=KnVatJ2eQZgiiknCVhlOst3g4Ou1RH2Za71tVE4zGnbZRHeDjOQf/qopsKQuWzlH4+
         OMnW2mQhw2JFdmo6RxoatVg/OUfG8OfPzyEdueaygC6MQxXqr8pb9JESKEQMzM9z2LM8
         Gzo8S8IsLV2ne4OTqk7LeoaLqYxhGiAur31faaHYIpcra0USDw1dx1Olm2E9ZV0vNciH
         /Zx9tS4VH1B3vLjJnsrP3LXZ24aw1eIq0gEiRO2EhwyY6NTkpxt8sh+5u83RbvGOJsSf
         du/OhPhyBmNWK83s7aX7PHiw6g1tfWLDTaeJ4Qqa2bSs6djAF2ixZZbfvUYJv27U94kZ
         012Q==
X-Gm-Message-State: AOJu0Yxr8n6oVNd0U65JvvQ7WeXphOOmUDYBrNa/F6FJpKbzqcccxYVi
	mWGNLpJ3jpXRovKwV5dsaR9WzbqTMQXKcKbx0oYCvKMqg0IQsPZNyzNzfTsVY0MqyO0a7WUZst4
	DFDDFJBMOy2fnW3XKkA+asf9+mr8442OwN6TXlGpFAjZ5VWUcRfFJ
X-Gm-Gg: ASbGncvsz6hp5RnFHbJG4n91MhreaB45gZKmuzcZzEg+Ka6G2Q755XdyMOaU7ZeAzc7
	JBSqhFK43TmZlLtksVD/Dt6jwa/3+8wkpcHQBq3zAQQQToiTBeE1gdlxz2bdZW3rxeKYFqegDza
	rMdWWh5t04/OiHz/bLLveDOVpPCI4i
X-Google-Smtp-Source: AGHT+IFbF/BzU8hXbatywkRUEU/FICQU0faoXfKGPLmHrZmYnAzQOB12BQSU5+dZenT7Ca0imr5y0LAqYpPG+QVyGjc=
X-Received: by 2002:a05:6a00:ac4:b0:72d:9cbc:730d with SMTP id
 d2e1a72fcca58-739059c80b0mr39417b3a.11.1742486173897; Thu, 20 Mar 2025
 08:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
In-Reply-To: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 20 Mar 2025 21:26:00 +0530
X-Gm-Features: AQ5f1JpwfwQ9koIezf2YlAmkyPde8D3HBnku4S8nm67CQIeR9941aTJ5Bpn3MeM
Message-ID: <CALs4sv3DtyBSqx0v_FHFUPrB+w7GOsheNOEa0pm6N4xNf-4JUA@mail.gmail.com>
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Kamil Zaripov <zaripov-kamil@avride.ai>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007285df0630c82d5e"

--0000000000007285df0630c82d5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 8:07=E2=80=AFPM Kamil Zaripov <zaripov-kamil@avride=
.ai> wrote:
>
> Hi all,
>
> I've encountered a bug in the bnxt_en driver and I am unsure about the co=
rrect approach to fix it. Every 2^48 nanoseconds (or roughly 78.19 hours) t=
here is a probability that the hardware timestamp for a sent packet may dev=
iate by either 2^48 nanoseconds less or 2^47 nanoseconds more compared to t=
he actual time.
>
> This issue likely occurs within the bnxt_async_event_process function whe=
n handling the ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE event. It appears that =
the payload of this event contains bits 48=E2=80=9363 of the PHC timer coun=
ter. During event handling, this function reads bits 0=E2=80=9347 of the sa=
me counter to combine them and subsequently updates the cycle_last field wi=
thin the struct timecounter. The relevant code can be found here:
> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/broa=
dcom/bnxt/bnxt.c#L2829-L2833
>
> The issue arises if bits 48=E2=80=9363 of the PHC counter increment by 1 =
between sending the ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE event and its actu=
al handling by the driver. In such a case, cycle_last becomes approximately=
 2^48 nanoseconds behind the real-time value.
>
> A possibly related issue involves the BCM57502 network card, which seemin=
gly possesses only a single PHC device. However, the bnxt_en driver creates=
 four PHC Linux devices when operating in quad-port mode. Consequently, clo=
ck synchronization daemons like phc2sys attempt to independently synchroniz=
e the system clock to each of these four PHC clocks. This scenario can lead=
 to unstable synchronization and might also trigger additional ASYNC_EVENT_=
CMPL_EVENT_ID_PHC_UPDATE events.
>
> Given these issues, I have two questions:
>
> 1. Would it be beneficial to modify the bnxt_en driver to create only a s=
ingle PHC Linux device for network cards that physically have only one PHC?

It's not clear to me if you are facing this issue when the PHC is
shared between multiple hosts or if you are running a single host NIC.
In the cases where a PHC is shared across multiple hosts, the driver
identifies such a configuration and switches to non-real time PHC
access mode.
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/com=
mit/drivers/net/ethernet/broadcom/bnxt?id=3D85036aee1938d65da4be6ae1bc7e5e7=
e30b567b9
If you are using a configuration like the multi host, can you please
make sure you have this patch?

Let me know if you are not in the multi-host config. Do post the
ethtool -i output to help know the firmware version.

>
> 2. Is there a method available to read the complete 64-bit PHC counter to=
 mitigate the observed problem of 2^48-nanosecond time jumps?
>
> Best regards,
> Zaripov Kamil
>
>

--0000000000007285df0630c82d5e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAqaAGWT1M+EgKSD0zNbSH+r3APFqXTO
ve7JCKIYrd9GMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMy
MDE1NTYxNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAFybR/QsUJqBUKxa9K/FpMub4+eHeRWLmLz9SVWlkUsfppg0tRI2fe68a4L7KAD0Nqq2
xtP72iI7L66rOJnGLrj0d1PbMUVmBSKpolm0Bx97JznVoLHBkpS5jTp9keIuJK3tjR9R4fEfk/Y/
731wIlnIWzw2lrOvfr4ii2MSmDH1Yj50Bhlto+gVIDSDw/gFfda9qG+ySprc3eSYDRovadZZp2dZ
zT66njewBrokm3BVWOa7fL26Sl2MDKmAeZtz8nGSAIlApbtTw9Z96r2BhNQdVjvrVg1kkM3FCwwP
kejcAP8OWW8tLlUnQAPuIyo5mWiwyLiDzvdYPxGiXP1PS74=
--0000000000007285df0630c82d5e--

