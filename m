Return-Path: <netdev+bounces-261949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL1aD+bqoWkdxQQAu9opvQ
	(envelope-from <netdev+bounces-261949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:05:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0691B1BC63C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37A6A301110D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C58D38551F;
	Fri, 27 Feb 2026 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ms7EotEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D7C38552C
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219100; cv=pass; b=NE/ScUEIoPpFt74pEQVgThCGUXKal2AMqgnlMbntu/nG76o7bhqCSm9j47FtXs8iGCn+P0iIMCjapD0ySFigp6UHoFXKWJ4R5DEWCUODm61U/8uSSrt6WZtoJ9MMhW1Pgmh46pj0YjTaXtaJpD38X9S80jYJw+0agIpHZvjAzS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219100; c=relaxed/simple;
	bh=rC77ChL43BtI/gddHxB5t3I9Rr+pUPYQSOwZiFNltgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ub9q2xvAlSeEaaCMMxLqP1hktQD8c7/LEZ5XnoeQBNeURjI/Gixx1Mft3Axb/5N/Tly5weGYJte3JPJxjccoqt7Q3RmTZtlgHQ5+pu5c4XzBsGo3TuXhPo2qjix1jpS4HKbHtwtWdeoxhYRF0iamcURInGnBlkkkGbYd6BPXbHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ms7EotEy; arc=pass smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2aad1bb5058so23766255ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 11:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772219099; x=1772823899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSLjBYZHrJnoO0ZlBTj0d+8Z6eAtBPMolb6QFLa1rLU=;
        b=DG17t43nfZbFnl9LRQ2ehv1ZK/kU4MnqSIM1tIUNEyLSaX/9mNfF+pLs7G2z7/LYjx
         kYfrFpL6mC8A0aVFQv11V+n0eeTnXQK03QSUpb8vPRa8MbNQZMU5xaVAgjK/lZ0WOvjO
         oVFF+Af5fUeEcLH25s3ZGXX+W6d0OCTUfeemPfQa0TfxzHuVuC9Mgb8ftVMvCwxPUD89
         ADykaQAteko/0Hkig0n3dZbRiAdXJ89MGG1X8O3pXgN7NXzcdnCjRCvACq8LPqDXsrCI
         CWnzNRl2LyGUhCxiSjCsVv9NLUAn97QsV6mopxKBD88mvmWnYIX9jSH76p132G8PWP3b
         RKHw==
X-Forwarded-Encrypted: i=2; AJvYcCXMt6AlBG4cETcXVaraWqUde4cRsJd6AMtTPljoTtHwJhuVlhtmWHgAOrSeXCC6puZv7aF6pxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyouVUai58j9Hp/cpjID+LWOoU6Na7Nji5PZ0hqrZTuzT6gPZn/
	J+GRxY20OYa2BL27IOkfUrVHhp/cWxAgnbHjhaDkvduXKYCfz+lkRkNZWcqVnmNgjSDZQV5DSm8
	McNFnHF96M966c7IofTg8gsVT0njJ23wBXhWLkBucrs6slQKZfIffOwOhi9UAUz6hYhkTu9qbbq
	Cq/wPIyo67vKUtFJ0NO3IXY6tAddBk/FUHj31XudKDyr1M8UYbkWQl9PCTfA1Uh4X3lC5M+2939
	nSJkiBQXFAEzbqdHw==
X-Gm-Gg: ATEYQzxkLVbHK2tGRMuwlGBYUyYPYJLcTT5wvkOgwsoP9xaOaR8X6J96/gTQPsaoV4u
	eRTBAyuPLQY4JHbgnaJxkFOWpHkWvLMsUKgHmwqzQzaJDMKjsPGBk7eIbUnU5C7Drnx7veRzK0o
	gNaXzR2ezFAEqZ+Eh+c/6PnkK8fUVUDu0bDNU1HOQRRQK+BzDtt3az5kd8h+PTTPA9kWpDLOQsj
	oYEuXtgNCuXk6NB8IHHeVyrJRZmtLpWxCpqcRhB0Q0ttjkv0KwmtBKqov/wjjSsxZSWA1i83P5h
	x8YzJn310tWEhpJP+4x9rSzP5iqyLIksspa3Tx760dxDqn84DWM12i4AGc9C8itkFz52S49SJH+
	QQo1LvSiWjaSR61eatNuBJkoDxiNRKfxfWNg3+oQqeH4LbAExZW8HaPnfHhOO2rVW4Z3xsYkjI3
	BL3cJLfvQTwAleC1Y1MfyERKk4zI/pWR4HXBaIxgkepq20e339bS51yD75s42VplCE/g==
X-Received: by 2002:a17:902:d2c1:b0:2ad:9edf:7fe5 with SMTP id d9443c01a7336-2ae2e4bce9dmr45966045ad.42.1772219098625;
        Fri, 27 Feb 2026 11:04:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb61679bsm6931385ad.55.2026.02.27.11.04.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 11:04:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdee946fb8so6130eec.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 11:04:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772219097; cv=none;
        d=google.com; s=arc-20240605;
        b=LSc864GLAq09UnoeOx55loGanlAVv/jPBVmBsu0xj4cSEZ9zrKdjH+xU54HlB2gBy5
         EVb77zhTtK+nl/1WVf/Ubxv8BlMEFFAq4wI0fhHJeNGwYY7Wmek2StRJT6z47JHeN7nv
         j4x+JQy0f/GTB9UbnUFHjp5L47xrtYw0e+/d35hpdHx0/fA5kDZsk38Wft7iQt0XlF4I
         pPonbXsc5tIs0+D1nIAO3S2UGPULnnbLS/o/1sP/Ud4KOz/NQjBKecwT6Wtj9AvLAlmw
         XqpIKNpjspYc4CiuYZ6YgXGHekdrvfkEmuVFAMRJHLcydlBOwFIoWyDMajXQpO1hDtWJ
         iWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oSLjBYZHrJnoO0ZlBTj0d+8Z6eAtBPMolb6QFLa1rLU=;
        fh=a8KEiuWE6tEd8vakCoURY03zEIPwmKoJDj6xEq71cx0=;
        b=jDda+d3payR8OhInBi66zRx7YB3n1+8cX4/9695BTjelmZSlWTcO9EDgfy9c0MzQC5
         bntr+8TbGw7gfXkuXF8lJ5n4lazhaAzL7Slbv7oR3RradxafZAvadVhOkXmeDl29sjWn
         Ef0izV5C8yzPVgCG9ZhMC/XC8lyx/NG1gmjtU8u1CtB8DSJfly7mlrkTzdsaINTx6fP0
         VT2nV/jnGSGk8gjLjYGw0qrGSUrmBu6XoJboL0xGhy9mxZa6PjjNhe+R2MnYyVHkHsDM
         OoRVhXuwZFaHKrWzinC0+v5EEi9dYzQrPCBJYP1lMWZ8rTYKUqaM7+JFQ9q7qXMo17e3
         xV8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772219097; x=1772823897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oSLjBYZHrJnoO0ZlBTj0d+8Z6eAtBPMolb6QFLa1rLU=;
        b=Ms7EotEyn0jEQeqAlpN7/AOAjtFh1B5ZvS775fN8vawc0OEIoQurBmhoLWRhLEX/x2
         KzgqcsRnQwDBIls9fj3M++KFxCfARpUN2pELEoiKtLQvjEkbZHSSGiah2a6AILY5YstV
         WKcyLt/E6shFBPp0/DJI1Xc1hQ1Xvq+j28yx0=
X-Forwarded-Encrypted: i=1; AJvYcCUrJXrs/El4oyV8LhiDEg+/ZE25fICc+B+3to+H3+aYXbKUJ7OeL1KPz/6Ow4mvUAXsILfkWUU=@vger.kernel.org
X-Received: by 2002:a05:7301:1e96:b0:2bd:d157:6786 with SMTP id 5a478bee46e88-2bde1c99c66mr1753563eec.25.1772219096973;
        Fri, 27 Feb 2026 11:04:56 -0800 (PST)
X-Received: by 2002:a05:7301:1e96:b0:2bd:d157:6786 with SMTP id
 5a478bee46e88-2bde1c99c66mr1753551eec.25.1772219096415; Fri, 27 Feb 2026
 11:04:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
 <20260226182133.1566714-9-bhargava.marreddy@broadcom.com> <20260226172207.6810e8ce@kernel.org>
In-Reply-To: <20260226172207.6810e8ce@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Sat, 28 Feb 2026 00:34:42 +0530
X-Gm-Features: AaiRm50c7QXi63cwADdlVx-hl_Eq76eiEf-rsRkLC_5MD0CdcxdYLmXpoxBDSgc
Message-ID: <CANXQDtYef9-xNE4gFmG9ud6GO4TRa2GQYk95zvnsuZgUcOi4=g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 8/8] bng_en: implement ndo_get_stats64
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c18b01064bd2e99c"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261949-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 0691B1BC63C
X-Rspamd-Action: no action

--000000000000c18b01064bd2e99c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 6:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 26 Feb 2026 23:51:33 +0530 Bhargava Marreddy wrote:
> > +     set_bit(BNGE_STATE_READ_STATS, &bn->state);
> > +     /* Make sure bnge_close_core() sees that we are reading stats bef=
ore
> > +      * we check the BNGE_STATE_OPEN flag.
> > +      */
> > +     smp_mb__after_atomic();
> > +     if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
> > +             clear_bit(BNGE_STATE_READ_STATS, &bn->state);
> > +             *stats =3D bn->net_stats_prev;
> > +             return;
> > +     }
>
> There can be multiple concurrent readers. Two enter, first one gets
> stalled second one exits clearing the bit, close frees the memory,
> second reader proceeds to hit the NULL pointers.
>
> Again, please don't try to invent synchronization primitives.
> You can probably use RCU here.

Thanks Jakub.

RCU is a good idea to handle the race.
I will switch to it in the next spin and drop the BNGE_STATE_READ_STATS bit=
.

Thanks,
Bhargava Marreddy

> --
> pw-bot: cr

--000000000000c18b01064bd2e99c
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBvdE/7q1UBgKlxKXSmgPs8QFFEgjQVAgrP2MbFT9YWhjAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMjcxOTA0NTdaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQASHQNz
oc+opCkx3k9RLgDhPKicYpevAml4PnGEdwV3Vajw72VFcCeGLVmxui7pHGrQe6ic6i0s5BOg2V1o
PQbWaEvX7aWsory+Nn1Dd7YC4ig87oebFtjPCqOwGH+arOgUln9L0WvFBWiSuWztDBFJtR3udbw7
/FG6RUWEdEsXLVD6918VWiNkOvNN/OgXYTDMmZ+IjfaSo4CO1CgRVZjxwjQpO8ZCRWvWWUD4N0BW
f+4TbbLdAfwm3PvXPHwx/3KgpZYuyl8ECfKQ8SC0QaumD2CSkKD4L54BHRi+0xx4R0Nr/GIDR8z+
IEevN2C1LUFJebdTzw9kMPosABtiPyGH
--000000000000c18b01064bd2e99c--

