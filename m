Return-Path: <netdev+bounces-113146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C1593CE0E
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 08:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D8D1C20DBB
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E72D17334E;
	Fri, 26 Jul 2024 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ShphM2P0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5BBA2A
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974546; cv=none; b=XDP9q8OpPgaDE5AA97shkFeUEQZJgtI9uzGKeHuGDglZKV2ZdEL5xFCyhoWa3pdPLEZXLT5oVeUE2iTRbROsgB5xOMwpQMqcnxbVedGjFs0sSOvm6eXW7Rt+eZqw0kkyEJ8J4subZCYoMFcvRappEioDJQBdJS9LSfdINI+N4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974546; c=relaxed/simple;
	bh=pDuftObZdHi/Pz9ALL5dOqDyERZ51xmOA4XnItAdY20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOkwMGt+FJUC4CS/ixNIR3ewzzKmS4T8iYb2WnCcdSNHSozfLo+AqDPlb/wNI4XmJlAUzs/snxHxiSw2PdKYB6HBU0fefntrtGnbHC+/CrkyExwY4+VQVDrlAumXk8oVMIxC1ON4tvXF3DR+x9dkCLQJ8qJXVB5xqDoQIj6C3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ShphM2P0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d333d57cdso518776b3a.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 23:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721974544; x=1722579344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tOwOaWXkKDN+ye88S+GTFlH/FASrNbhfoNo3ONjRspA=;
        b=ShphM2P0bD8lpgzGtFeWlaOYZJtqvCcTCYSqyiglqPE9OwE8CqJEMzmuh8DtVSr2vN
         a75lkuAaiKD2PRb7FNXCmUODb7F2Ng++sR6NfZi2OqXDcyZTMcl4Fm27BvLYr9eQFYJ5
         51cKMzr/QB9QVHtNKBrIjW+NmFCKG5UKtAoOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721974544; x=1722579344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOwOaWXkKDN+ye88S+GTFlH/FASrNbhfoNo3ONjRspA=;
        b=UH5TzxNlS/jog3gbkDREZDTrQB1KJ/vxqo5a9E4RRyN77fI9/QnoTcJ+3QGaWSLPTE
         MnZJh9Aaooppuzm3wgjEUuYAFPlI7C5qjKIBjr934zUeZQkstp3QtgXwGBC1viitJ0wE
         FvU9ovWEp3zyIde0qnCWv17L+pdu1N8MqtQaYeNmMzkdkAgyEM2IP3q4VwyxNSF/912N
         JqNUEOW57VLYqqL29wI79DsjvDmOcMlzRCJfp7NN9u0E4wXXu929L3JXvn7w6VYBoROJ
         uOQoNQEt6qQmApAAcO+oLFeSGwWh/C8EbWXzkfpH4o5jtF075gF9MAV1Y0iRX0rVy7rg
         ukfA==
X-Forwarded-Encrypted: i=1; AJvYcCULBnopw5PSc+135rOTOpHfu+jzo7leNhNdhXGCB0e35eqrGJPG30ioYUERgeNgrMAWlp65aiySszb+dpijuqyxFaGlS7ya
X-Gm-Message-State: AOJu0Ywzcp0XimZ0VXIYtkzNg8UBWdk//iQpbJHB5zv8lPRqC3fQvA7Y
	L3kKJltFKaZJqJBdYbFsZWPFVsRLd+hm/ZtHIaU6ARX3xN5zDDQhGsDjJYK6Omuryd8/ilYGfhH
	Lk5BqCK9+r9UXEqlVzyZFAqJJfAVNlGRN+R0x
X-Google-Smtp-Source: AGHT+IFlh/0hBNJy8GPpfjMAQv+N6znmMsirTQczDnnYuN2qQaxKs9MXEsViJKhfpNw0vUzweEybgdHO0++2H1W2Uek=
X-Received: by 2002:a05:6a20:12c7:b0:1c3:b1e2:f826 with SMTP id
 adf61e73a8af0-1c47b2d2d7emr4468577637.35.1721974543458; Thu, 25 Jul 2024
 23:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725222353.2993687-1-kuba@kernel.org> <20240725222353.2993687-3-kuba@kernel.org>
In-Reply-To: <20240725222353.2993687-3-kuba@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 26 Jul 2024 11:45:30 +0530
Message-ID: <CALs4sv1osSgvgHysDTgR=d=6cLGNyn-ha0y9fh+=wUpOKR3m=Q@mail.gmail.com>
Subject: Re: [PATCH net 2/5] eth: bnxt: populate defaults in the RSS context struct
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, michael.chan@broadcom.com, shuah@kernel.org, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com, 
	andrew@lunn.ch, willemb@google.com, petrm@nvidia.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000008d6b7061e207124"

--00000000000008d6b7061e207124
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> As described in the kdoc for .create_rxfh_context we are responsible
> for populating the defaults. The core will not call .get_rxfh
> for non-0 context.
>
> The problem can be easily observed since Netlink doesn't currently
> use the cache. Using netlink ethtool:
>
>   $ ethtool -x eth0 context 1
>   [...]
>   RSS hash key:
>   13:60:cd:60:14:d3:55:36:86:df:90:f2:96:14:e2:21:05:57:a8:8f:a5:12:5e:54=
:62:7f:fd:3c:15:7e:76:05:71:42:a2:9a:73:80:09:9c
>   RSS hash function:
>       toeplitz: on
>       xor: off
>       crc32: off
>
> But using IOCTL ethtool shows:
>
>   $ ./ethtool-old -x eth0 context 1
>   [...]
>   RSS hash key:
>   00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00=
:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
>   RSS hash function:
>       Operation not supported
>
> Fixes: 7964e7884643 ("net: ethtool: use the tracking array for get_rxfh o=
n custom RSS contexts")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 0425a54eca98..ab8e3f197e7b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -1921,8 +1921,12 @@ static int bnxt_create_rxfh_context(struct net_dev=
ice *dev,
>         if (rc)
>                 goto out;
>
> +       /* Populate defaults in the context */
>         bnxt_set_dflt_rss_indir_tbl(bp, ctx);
> +       ctx->hfunc =3D ETH_RSS_HASH_TOP;
>         memcpy(vnic->rss_hash_key, bp->rss_hash_key, HW_HASH_KEY_SIZE);
> +       memcpy(ethtool_rxfh_context_key(ctx),
> +              bp->rss_hash_key, HW_HASH_KEY_SIZE);
>
>         rc =3D bnxt_hwrm_vnic_alloc(bp, vnic, 0, bp->rx_nr_rings);
>         if (rc) {
> --
> 2.45.2
>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

Thank you.

--00000000000008d6b7061e207124
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
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGIxZ0FD+p0NL6PLF10OU0mtemX2t+Ha
igEKW9+SQpcAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcy
NjA2MTU0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBUfvqhrO+PJyY63vMUQPvr/efimTdMVRy99BK4UCWpg4zSLHtA
i+HVLYFuG3HXDkPaoWBMXGT8qt4nuGPYyz1didCdIpbchn+MK4mP4r2yl98841CNAVe9dJIVGBju
2zffdVrpUNk3l+Aj0mlNETEH2JBvNlNqCPdrlDSt+JE3C9al70G/8KNGOvDxPW0E1G5VMsnvxafH
Br0LEPNqyDyWTcA34L1kBzanSFDNHUapCvn/mY9NMeVAF+Q2+XxgFY00/90747GI20Mn2NByzTfo
0ltdrOBoXM4muyIZJzuQfupZDD9CPH9KdhvWqvEcvy8EVyUR/XcySHMIXw+RAgJy
--00000000000008d6b7061e207124--

