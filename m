Return-Path: <netdev+bounces-278356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIGzM2oF3mlRmQkAu9opvQ
	(envelope-from <netdev+bounces-278356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:14:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B93F7B68
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 451B73020D21
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28FB3B95F0;
	Tue, 14 Apr 2026 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ey5DsDcN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788913635C
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157933; cv=pass; b=IM6chGxttW8lVbrcX4LoIPPKSSPQuUF4WVjTX1ddjnOhhg2OOCYioAgwJQ+E2ephMFLZXl7XRa1eEawdqQ959y7zsAq2SvZRgTSyrVN+ylppFW/Cd9+Rhs8aDb5QoB7wzHD+uG9x99TFWvfZj5U2XRmU/7wAfxxY3asAgYgxN9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157933; c=relaxed/simple;
	bh=6n2jE1drfkzJFgezgIYl6RNAD+lhDq/LwGHE3El0uzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqeyu+nhjWnd63m0wpceyuV/gmsWXSk+GVL8BBd2OWxOCEkIturgFQB9IGL8sW3rn1SeBIFa4Mr6E9JvqeD1fmgRsC2CqfHFELjRB1kqY3e9EMk1g2PKwvYf9Z4Lw7xnpopXI+dkkjAATuWHZfXfaMd2Fj2m7oCdVFUexeAKI+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ey5DsDcN; arc=pass smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8d424af6282so581132685a.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157931; x=1776762731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co8XQeiWyTIg1Vxxv6abjU+8xpa0RfMwHavXmT32B6g=;
        b=CePEC4z/iS/6iGyYaEzQZ5TWRa19VeTh7wSTZ9EsrOR1uumT8d8LnLJIo4a8oAEvB5
         D3VRdjIU9ZlqH7W6H25/zYYBqsF52lULtK7T+uOqzuAtaapjFElU5Q9r9t74OSj0Jgzo
         ObjstGNKOKND95i587hU1Zuq5exUgp40LEJfGRkLD3tSchN2MuDRxlcr4R0rPQXNMLir
         ALZ3AY+IriaBOfxeOP8PdrcxKH3z3DoU67QUzgJF9NNp0tCajMR70rqP04A1utUf91bv
         GJJMGdu5G+MlhnjT7SQ48EkioEaLV+pTtYrHrEwPc2snsfdOa95AJ8rgmmbQf7+b49B4
         DTEw==
X-Forwarded-Encrypted: i=2; AFNElJ9hXhw7KuNttZVEpzR6CxyA1vYfbr1lXZBo0Cb9ODoUJXFubBt10zSsZnHJqfmjYb+efzO3QnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvt46KgOPAgFjNck74BIQQXgFrGIpmDQgQkf+XZuikJaAK/J6p
	XEAZmxK6IPPPmrPWqearWOFAU9CWpyKiT6EEBSuEdSFESMHbH9N1cAVcVBlM+RWBppKv7V/vYxA
	f14eIBXR4EWamnPBxxieBBDUmk+nl17lZMFWjYGJ5NR4ul/GUErprBcHGSlv2VWCpHtQUrBgB6t
	fqwGG77U84xSJ5uQgw4Lq+zaN9NpAwtnqk8/7ziFd8jA7OOQ4njVxNtJ3J+N0wdJ4osYsao4rqu
	gkjIjhrHRGXEtP4xA==
X-Gm-Gg: AeBDietpMJWwv6X+HbcBgcbwaYgbeeYa49WjA6Gud8QxH5Db+H4eaGkQ/hw1Vvjgy0c
	HAmu/L8ze88GuyoHAhs23YSMfDf/EOWZ9tHRaDJuahncM8Uq/hguZqion8yhxPqejJF+Ifkuszs
	kclkBvAeOno+X3z6/Ermp5ksdpdW0+IsxydCHZ0v/fWWFezMC9/xov/Q+q+08pHZ64O4o73i1Cn
	EXwRspc1qyyMbSemnBYKMYrXIdZz91vKeGL/rQnw0CDGgQL09DYokXj6vYyI9Mj/3VD/KVcHxLW
	SEWl0VnwdNY/vSUjsR0FKy89UCMlrGo4ami284OHekwf5uDwiYLdulSfsA0j1vbIW+l3mE1Pu0e
	JvpMKVVMEqw5b5L98aJg4KLrfBD2Hm87tO9SBvZ6H+nMX+gqdUcZkAwoBGRYW/iLFIj4+he2osn
	dNZ9QMVImcpXwUPxNsorLmfNzYHTf4pX2DmVpplUKhHO5uTeNrau32T7v29sPG2oOE3gNBSWoDB
	Q==
X-Received: by 2002:a05:6214:528f:b0:896:fbdd:ef14 with SMTP id 6a1803df08f44-8ac8619177cmr242539106d6.12.1776157931358;
        Tue, 14 Apr 2026 02:12:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ac84cd0b5bsm9575426d6.26.2026.04.14.02.12.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:12:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2d889997495so7716827eec.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776157930; cv=none;
        d=google.com; s=arc-20240605;
        b=aEkYiPclVB3boVW8ssBjrUMDwzB81R+RskuSzioRm+BHRRy5mZ/trmju3nVZLAzMYj
         v5MuOxbJYxvulwv0OQfeEp3g6Rva3f0cxpJylUJSTSrniQT2fW/T8N6qsY2qLZgfbK8B
         tJwX7t56lfb/hgU5+jRkaZyZQJsJ6gz/81NL7fKdA9b8X+V36U/MvygkoFyZktO/wtqf
         L4eHTK1beXWkuKegLeculwtSiF10/CTDni5CREyAaDVDnoZOjjPH6lmaNyV4RMXPBXzM
         YcpnXjzbU1upzjypaVyPnDaN5BBqheA9MORu5suJwv7qns+6QRul7/aUaVL8SAoIXerp
         8Gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Co8XQeiWyTIg1Vxxv6abjU+8xpa0RfMwHavXmT32B6g=;
        fh=u+1uLsghanhBzar8+NLkPEAMZaIuLpIYjxKRPCzM8XU=;
        b=XhwKr5ODeSRPBP8bTG/kEKS5RrN1iG5hGlC/kTZZ4OvpXBlgzMDrLV4Oe+MW8QQ7jt
         hnH47h8Tvjg5O7bQKMNAYJB3JcM2u8m/5koFS8uL8991q0RDq3nV6Hf8B36XtuQaSgC9
         gZOqLEa+uRxFRXAv12eTXMaU8Gwfzr48H6PBsUuRG8lRHq6GI7x7WXsHXbeczwAcmAxU
         Dwvft5ayRLCtXam46OGoofSQcrMsP4f+Sdons7CWnqc5UaX4sMpUOrztI0x50wKKIE7X
         PXcbhfWuvWW0N9PT2PNax9cgI12yJ231XWnDS8ioJG1QmIn36GaHyqWy89itfLWubpXp
         DEJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776157930; x=1776762730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Co8XQeiWyTIg1Vxxv6abjU+8xpa0RfMwHavXmT32B6g=;
        b=ey5DsDcNKbixFDxSptnSCThKXu7R/Ns8hXOSAwXOWffI/SRtKNUgCeZKt5Rbs6nGfO
         /37LrJ9CDqhOIXyNT3/yNp+bm0SSPAWXV+gRBoIQ8aFwMhhjOKwsc7LUuBNhDLMhDXiS
         BISbAoYs1uKwvl1DevDx3slICRUlKJZXn1/nI=
X-Forwarded-Encrypted: i=1; AFNElJ/nUaMpmH0tZ0i8Ia9D7CpYi5Yb9DLgucrJITOCsbMl+I+fgn/UsJy/mMTVC9IZDditMM5GzIE=@vger.kernel.org
X-Received: by 2002:a05:7300:bc03:b0:2c8:409:a9bb with SMTP id 5a478bee46e88-2d5834e6014mr9213174eec.0.1776157930187;
        Tue, 14 Apr 2026 02:12:10 -0700 (PDT)
X-Received: by 2002:a05:7300:bc03:b0:2c8:409:a9bb with SMTP id
 5a478bee46e88-2d5834e6014mr9213148eec.0.1776157929615; Tue, 14 Apr 2026
 02:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
 <20260403073724.194360-6-bhargava.marreddy@broadcom.com> <3596a43d-8c8e-47ac-ae73-ee282f3be945@linux.dev>
In-Reply-To: <3596a43d-8c8e-47ac-ae73-ee282f3be945@linux.dev>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Tue, 14 Apr 2026 14:41:55 +0530
X-Gm-Features: AQROBzA4lFx8-wpm8yH5J7jSEZ1Fz_V_KgklTrfns2H2WXWK9DMATvBOd6YB4XA
Message-ID: <CANXQDtYCC6oFzh03Lj=s=S+6OnOoTcwXh48d_GSS-mH3D22vZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v11 05/10] bng_en: add support for link async events
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, 
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000083033e064f67fe3d"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278356-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: D91B93F7B68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000083033e064f67fe3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 6:22=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
> > @@ -190,6 +199,14 @@ int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
> >       req->ver_min =3D cpu_to_le16(DRV_VER_MIN);
> >       req->ver_upd =3D cpu_to_le16(DRV_VER_UPD);
> >
> > +     memset(async_events_bmap, 0, sizeof(async_events_bmap));
>
> bitmap API has bitmap_zero()

Thanks, Vadim.

Since the subsequent version is already merged, I've noted this for a
future update.

Thanks,
Bhargava Marreddy.

--00000000000083033e064f67fe3d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCWNw6n0xTZtHyPv/T0H6QiAC9UuJwvslRNN1zEiyVsfzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTQwOTEyMTBaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCEjPk1
hPb48pwPT8hy5+gm2cAIIMGhlp4Vf0Y9YcimEI6VGhTjY14qv3fjO3gUCD+vV25XwMmO65LPkKex
j8oHB3w/5gvHOU2oodBZAF1k5a6CyV1MIQWvz/hFR6ZZ0MSi7dQwx35kaIWrcI+gYksO0DP/i0uz
ipf2bNUPjVFLJAzTAvwypyul/8WcLg/XOwb3qsMlgPSuPNFf5IZMEVNOE2raplpclE4M5pYU4oXM
t/DyXrt9INzIa7nYt/yqmLW3F8XKaYHPAxRmfk1+x9YQHE7Q2m8xRZR10gt/ixdkTWwHWvuBgZDU
CQYwGsdweYpl0gUIuw9s21VPviWVDdLJ
--00000000000083033e064f67fe3d--

