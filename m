Return-Path: <netdev+bounces-118559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36299520EC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22CD1C20E24
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F6D1B9B2D;
	Wed, 14 Aug 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fC8MMMKF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABA111A1
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655883; cv=none; b=QSDYpsSHgk0QeZFgWHdE4tA7f4pzgRA0Pv+rkoJOPCrf8SZ7aQpx7zhjVgJZMOaDmw6/AoWQYAB/P0Ov5wT980J8tdvzG4JbqigcqHBuAVM+S9w1izmXlG4z3fNyWv7AsVO0HH0GzWzOldVkKvsXWrhpFwnEEWS556BtA+BFbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655883; c=relaxed/simple;
	bh=wBGS1kZ214WhpSoFS2TADAlbNh1/j79BFE7cW0FJoOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAATnqO9B7DWuCEXKxn964SCCfpNTdAzlaIPC8BLB1rJVzwgERfI5l3scpaQE5zGz8gq7kHFZh7tDuL+Z9f2p/LlyT6V6zbwV1m3SiNjuYteaYyIlbCbzYu7K/uE6JIH/VXEUI8Au1kMDD3dbzsCKWTvsVYoK34F2qHUODQgLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fC8MMMKF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso119852e87.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723655879; x=1724260679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B6X3cWjNxRcFyLkGcxfLhKd2m/F14r6u4PTV3IPkGAk=;
        b=fC8MMMKFikiypVn4f9H9ifkBD0GL1hlm8pHvu4hNPiHs7yxAKQ2r1FP9dFK70aIa1Y
         tAJhA1MFPekm2q0GLg/PDZcuFElugdx6txhDZmYUtxkGovoMiRvZqEb9GCD6x1pdVCyB
         HHwX3KPWCrztPQUhTqpZpqP4AitMojXr+2hWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723655879; x=1724260679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6X3cWjNxRcFyLkGcxfLhKd2m/F14r6u4PTV3IPkGAk=;
        b=oh+4hzm0nGkEO0QVFbsbGi1ZM+Az5cSmcbMId8TsWlTcv0k9LO/SuQmYeZw4bEewnw
         ihFqgAjVNPkAiBItwd5WCBGNE/z7oLBirbmxgNQHQeh1OrNHHvgTXfUEQD7tNk3DGb3G
         4VRURkiN6rQT8UlKJuD6BotDCmVryV/9AxjcJyGNOTs+YuuwL7Y62oR+zD0/RXXFaMpi
         N8zYr/5DTSeII06laOxZxWuxH3/4SFAr5ooampJTH+KuT4SaXgb/gb5H4Vo87MOFMtlD
         rBK3cioxVOu7LkNVRG/KpEZEOvQ7IJPfJdfu9bFCNooA2cMp8d2kLvUdllXjb+Dhirxg
         /0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUvd7kIw5vmy4Jx+H5scAVt0dZ2qYyLh+fF8jtuZEkTVtMiQoDmKafv1benxOMHzPMmJHzHhvmtdz8bZ7kgRvDiwqsCsT4u
X-Gm-Message-State: AOJu0Yxq7v64JXiMyRKhiXcdP8OYtK2ikO3lckoWygP7DDqQhU4Ig9m+
	glyIJ6uf/ADU2rVeO25gM7GnXbn1iLCJ5n/KnHDcbTb9/PeLwqwRw3AjlEW018vjcqRn8TisnRD
	fWpN48TJSd/c8kH+dSMCRdvaKT2AtX9PxDh1X
X-Google-Smtp-Source: AGHT+IEjAvIdMG76uUzSXbKUrSTF7ZMXC+0JLXtB0nQku2IAWk7ysPtR23Zk6PU7rF+GXJWWQwpQLQmafcL2RO3qFI4=
X-Received: by 2002:a05:6512:1092:b0:530:b871:eba9 with SMTP id
 2adb3069b0e04-532eda6732fmr2931721e87.1.1723655879108; Wed, 14 Aug 2024
 10:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMArcTXtKGp24EAd6xUva0x=81agVcNkm9rMos+CdEh6V_Ae4g@mail.gmail.com>
 <20240813181708.5ff6f5de@kernel.org> <CACKFLimwA=P4M8UEW5cKgnCMCRu99d5DBX17O6ERriUkC=NxMA@mail.gmail.com>
 <CAMArcTW2yvEJLr_55G7FDsGtzKjTa2zMndOrAOBCshsW7UUj5A@mail.gmail.com>
In-Reply-To: <CAMArcTW2yvEJLr_55G7FDsGtzKjTa2zMndOrAOBCshsW7UUj5A@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 14 Aug 2024 10:17:46 -0700
Message-ID: <CACKFLikxTXW4xg8vz7-NfModfn-ymf=a4pL6BtM8LebOmPsdfw@mail.gmail.com>
Subject: Re: Question about TPA/HDS feature of bnxt_en
To: Taehee Yoo <ap420073@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Mina Almasry <almasrymina@google.com>, 
	Netdev <netdev@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006d70cd061fa7e876"

--0000000000006d70cd061fa7e876
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:51=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> On Wed, Aug 14, 2024 at 11:08=E2=80=AFAM Michael Chan <michael.chan@broad=
com.com> wrote:
> > Yes, the rx_copy_thresh is also the HDS threshold. The default value
> > is 256, meaning that packet sizes below 256 will not be split. So a
> > 300-byte packet should be split.
> >
> > TPA is related but is separate. There is a min_agg_len that is
> > currently set to 512 in bnxt_hwrm_vnic_set_tpa(). I think it should
> > be fine to reduce this value for TPA to work on smaller packets.
>
> Thank you so much for confirming the hds_threshold variable.
> I tested this variable, it worked as I expected.
> For testing, I kept the rx_copy_threshold and tpa settings unchanged,
> but modified the hds_threshold variable to 0.
>
> BTW, how about separating rx_copy_threshold into rx-copy-break
> and hds_threshold?
> If so, we can implement `ethtool --set-tunable eth0 rx-copybreak N`
> and `ethtool -G  eth0 tcp-data-split on`
>
Yes, we can do that.  I have the rx-copybreak tunable implemented in
the OOT driver already and can be sent upstream.  tcp_data_split can
also be added.  Thanks.

--0000000000006d70cd061fa7e876
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICoEtV3rNastDz6Yzt8mt5E+5kxOjx/9
Cv536Ziag/49MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDgx
NDE3MTc1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAcMXWecdO1zvoKOZacYBbC44XEorJkE7u/jMjXQYzT7if9PXlF
nGmG3oP01OKaVpIsR5S8kav2bUfq3w+PxATiNIq1bNntywapByaluQ4cgoi9lVQdwtGd5gyxImAL
0bfWcrGtVsGzvb1EoH2NFTsLQuXO0ABzSH+C0JdkaixkfZJqXhOGtVRWPNcpP1Wo/JmSM6oXYQeZ
TTi70+4DE22dIRDMXUeCRLId+WsUvwmGrHXSeQBa9OMoNwmVD9mMEvMgdvGYe1wC6dOma6WRFCbM
9agdIBrWv+m321/qmirTvLScDhjKpjzhy06LzGnLQ6Q2f4BaEGqwM1etzINHuEhb
--0000000000006d70cd061fa7e876--

