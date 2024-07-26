Return-Path: <netdev+bounces-113147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFB293CE0F
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 08:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23DF1C20D56
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 06:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE3175560;
	Fri, 26 Jul 2024 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LRjO8shK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C90E57E
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974577; cv=none; b=HgLTko3xIiGi7W6S6CcN971eXZZqRiikZvEYYB1VKJ8p85+ip54MA3wXYXGan7MBaX9NBCwFtV8zsaHQ3fFqB/A3zzrh8/89KjlA+dt2DDVshua+/GucYeTnFUJb/DoTRi48U7VaRDSaqGXDf3+bsN8/ymJbCPS24m6AiRBU3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974577; c=relaxed/simple;
	bh=VN+zE3L3FnTCj/TzWE6s97DY8gK13TdLiIyxZznHv4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmQ2lvn/wGtCKLpO5RjwhlUXI/IsRAlLU357BVOLfpS3aXK7B7OmCtGtjsWZBIdEGWVikKMzKE3SDL4zXQP213fEgPLVyd9DxGfsbZlN1tmwvWIC1p9XQOa4qjQpefPTZNTvc9uKTGQSeqaPhITg+mNsMZ88+xRqHutgnmwopHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LRjO8shK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70ea93aa9bdso524743b3a.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 23:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721974575; x=1722579375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2eIMo35NYOe6YlLtuh1NOC5sHJSXVRf/NP7fv7zqc0=;
        b=LRjO8shKJEYpFRWtmEa0NUuQsDpiX8cHx3j22EnXYgQ4L3HvNekFpADvz/t5JtO/Lh
         s0gDCdcsqdGH1XbGZH2Qz32LMiza7kU/NDPeGQrD9+d0OgT2Zz7S5EGkfs1wHZuKummo
         OFXdChj7jYtvuLqCnPZctBGu+ibkatrGLvwk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721974575; x=1722579375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2eIMo35NYOe6YlLtuh1NOC5sHJSXVRf/NP7fv7zqc0=;
        b=Of6EnjGB+1+ezAi3qQrbqrYMwn47iGE8jjM9syRi+ggWIc5lvq8j+YLi4FDylaLRzj
         mwDRuhz0RiEq3vNTwxppB1L7yfR6P81MF1Lhz4fAxNFKAkLsw7BrzypF2nL7ZJH6B+ky
         D3pOigv6fTHx5D8QZa7J4lgtwBWNKwlWAvB+OtGxEQfZi9gwlaSyf5j+Fwc/6EL3ctqS
         HJ1E619j4W37OUFo4DNtnAMLjK2dB9TC4FOAEueuQ265KqMVIpJgnNXxymtVHJxGWeho
         5XFq25sVF625vUffoZDCY3Gf4VQ6BmSx95ZUCQJ+zLUGPHuGnjCVdc8SY94y9L85GolV
         Abdw==
X-Forwarded-Encrypted: i=1; AJvYcCWToTmurMHVYNHLqx4fV44CEcVqLKxUDnLqkcfYRPWPybgRTaC30BW7zQnFpJD8dCzfMrC9xUzvoO7E0Ldj5eIZtlwU0jMQ
X-Gm-Message-State: AOJu0Yz5u1xW0rXWz1mpprebgEmLZOKriCEJWGYMSfIHUMj6g72JwShm
	BevvV3llMWB9Q7BpECjYnRPZI57lBLMXdH2ZzbUEY91cldHroRPXCBFuMZWqZCsvX4iWehnxWgq
	eV8IEm4gj6ydrjkYzrGnUpNbG4QRI1Zu+sB1X
X-Google-Smtp-Source: AGHT+IFsgcqD6MoZGGyQ4vHcJOxcYjKWx65mFV44CE517UaZ3ToPI3JOkY9NCGZeajZ2i0ZTpNnpmhTn8Dk7wqhQCXU=
X-Received: by 2002:a05:6a20:7291:b0:1be:ca6c:d93 with SMTP id
 adf61e73a8af0-1c472c6a0c6mr6417112637.52.1721974575292; Thu, 25 Jul 2024
 23:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725222353.2993687-1-kuba@kernel.org> <20240725222353.2993687-2-kuba@kernel.org>
In-Reply-To: <20240725222353.2993687-2-kuba@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 26 Jul 2024 11:46:03 +0530
Message-ID: <CALs4sv1jFBQugb8MXny09Qu+xUj5o+GFnWveh=G3g6-GMsPNow@mail.gmail.com>
Subject: Re: [PATCH net 1/5] eth: bnxt: reject unsupported hash functions
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, michael.chan@broadcom.com, shuah@kernel.org, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com, 
	andrew@lunn.ch, willemb@google.com, petrm@nvidia.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e8003a061e207208"

--000000000000e8003a061e207208
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> In commit under Fixes I split the bnxt_set_rxfh_context() function,
> and attached the appropriate chunks to new ops. I missed that
> bnxt_set_rxfh_context() gets called after some initial checks
> in bnxt_set_rxfh(), namely that the hash function is Toeplitz.
>
> Fixes: 5c466b4d4e75 ("eth: bnxt: move from .set_rxfh to .create_rxfh_cont=
ext and friends")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index d00ef0063820..0425a54eca98 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -1863,8 +1863,14 @@ static void bnxt_modify_rss(struct bnxt *bp, struc=
t ethtool_rxfh_context *ctx,
>  }
>
>  static int bnxt_rxfh_context_check(struct bnxt *bp,
> +                                  const struct ethtool_rxfh_param *rxfh,
>                                    struct netlink_ext_ack *extack)
>  {
> +       if (rxfh->hfunc && rxfh->hfunc !=3D ETH_RSS_HASH_TOP) {
> +               NL_SET_ERR_MSG_MOD(extack, "RSS hash function not support=
ed");
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (!BNXT_SUPPORTS_MULTI_RSS_CTX(bp)) {
>                 NL_SET_ERR_MSG_MOD(extack, "RSS contexts not supported");
>                 return -EOPNOTSUPP;
> @@ -1888,7 +1894,7 @@ static int bnxt_create_rxfh_context(struct net_devi=
ce *dev,
>         struct bnxt_vnic_info *vnic;
>         int rc;
>
> -       rc =3D bnxt_rxfh_context_check(bp, extack);
> +       rc =3D bnxt_rxfh_context_check(bp, rxfh, extack);
>         if (rc)
>                 return rc;
>
> @@ -1953,7 +1959,7 @@ static int bnxt_modify_rxfh_context(struct net_devi=
ce *dev,
>         struct bnxt_rss_ctx *rss_ctx;
>         int rc;
>
> -       rc =3D bnxt_rxfh_context_check(bp, extack);
> +       rc =3D bnxt_rxfh_context_check(bp, rxfh, extack);
>         if (rc)
>                 return rc;
>
> --
> 2.45.2
>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

Thank you.

--000000000000e8003a061e207208
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHUPFuHZSW8TsJtQhY9LxqBUI2Z7nFGD
rrsR3XVISfJKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcy
NjA2MTYxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAGTvatDzR1a/uV/VaQq1/m/mE60t8iVD/S1Lhbj1TuXE0ixdPL
aHsAx9Zs71ztuw2dirMgmxBpOoLi6gHeQ/0ALaLfcN0zhl1lNAKCEMq5Nbx5uEnEYyfbU0ca6Hwe
rS7zxmqF9sgsB0n6RZG730VOnahZRwiExw9QgLjRc3+mXZ5HUjIduIkEMJoNb6e8qmIBYjhZYuSn
YsWRi9+y4v9CQF3foq+TXWA6hqXtHTwTZR61iRZ7yv5vhXACHAwu4YA88WCHtTuZVWsKIeMXgwfg
3w/F1UH86GdOtHdasBvX1+mz/j9Ct49Rime9eiqCcjxVxgirMpvSKEKEmWRrtEHS
--000000000000e8003a061e207208--

