Return-Path: <netdev+bounces-142650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB91F9BFD62
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 05:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44854283B5A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E423126BE6;
	Thu,  7 Nov 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hQww6Tlr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA26EB4C
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953828; cv=none; b=NHEr9B1/2wp40GnzypXG5+VC4uVxWelKj5U3L2J+l3q2ApHtg7okb5mVyWfGI1d7+sDkYDABjsSso0hDy8NsyORZXzYWDepukZ5rCpa1beR0pD+W52PrZU+Fep5rhOGfICse1U1OQt59NGK9S4lC0shPC10TG/aUPGWoOOzYfys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953828; c=relaxed/simple;
	bh=BZXtxa0Dfv8tH4icL+MEZM4y86NQkmuRzJBNKnre61U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSQ1zOShbfT+8Dr1Q6nmTX00JKe0p4EItgKOYJvQTJFC9YZbqFYLeCHNybZZ4M1zul0oNXhDyA6Lu7daby/sRyxfu2bv47Irk3jnHMZ81AubyeZoD3KQDeUv2X8Ln2zA/vsZH/Q1YyqOqguuN1Vcz7BmsANDhNfXJfefMix4uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hQww6Tlr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so423507a91.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 20:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730953825; x=1731558625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB1Kti8jMEbpz9q7dtae9qJar9NnZZP7KH4oAtgDEOg=;
        b=hQww6TlrHGcg08yeDAKo8npN4wrqDXJ3knZC3kT0Y/mzlCNdSuZqMuxz+ozissP9XB
         8Hpa605YMEVpcDQ5lzHkG4apcj2FubEQ+hZqUWr+4P+mmQzhvRjNGhxVws+NWjkwRW2/
         rGVy3h+IPkiFoouKBVerxkD8RLmBmWeFnZXl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730953825; x=1731558625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZB1Kti8jMEbpz9q7dtae9qJar9NnZZP7KH4oAtgDEOg=;
        b=jDqxHX7Yx4pCxWnXjK7IMsguYZPdK4mFrjjBPn7MpSaRD0Qfk6yNVFtjAR5fAOFuFu
         DjcD89mdahhRkNo/ejjb1XuKpDtJvj0ShDon6T2yy/Vh5bBDF9QRhbbil4tpf0V3WzYY
         GASIVQY6+3Y1K94IyT1X9VAxmzdsACRMo9DJp1BvjHzUcCmrN4PxW4vdk7EbsoazsclE
         aS38pE8lM2o5Ql4ge4hifIfEJuCX999Mgnr94DOHGNX5KqmAgFBkvzW7bUsTSr7YzRPF
         0LTCXh4eCwOpsnpVhfniDy4TAYBwHvHmohNC2Ki+OriZsBk2F5QuQ8wRek577YfgejbC
         womg==
X-Forwarded-Encrypted: i=1; AJvYcCXRlTpymt1FhvSU/71h/gFn7/8vgk+QRY/widMhurqdGhlvDrW2XxaPzP9mHji0dOBPTKBixNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCEgb4pM3BVuPuO4uBiz/YdOG/tsiZWMa+i+m/KeL4thUlmkqI
	C/hlD9na/iA+3FNVUdRz4VU3+GMDv+c9BfGxTM3Q+HNA548I8EHbdCB4LkNMbAFEL1EsWL6vYpv
	dXqNTAsaSRIKlmgKAG72k3Re1RljQnIisA8Ro
X-Google-Smtp-Source: AGHT+IH1slhJr1/HmfE4JEowe4xsCO5sJd+KTooyjkXWQP51iRfVq2bOT7u36kHzfpgtQgn6wS0b1eEJdnjHOoCDHiY=
X-Received: by 2002:a17:90b:1dc8:b0:2e2:af0b:7169 with SMTP id
 98e67ed59e1d1-2e9a7556153mr596246a91.12.1730953825125; Wed, 06 Nov 2024
 20:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106213203.3997563-1-vadfed@meta.com>
In-Reply-To: <20241106213203.3997563-1-vadfed@meta.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 7 Nov 2024 10:00:14 +0530
Message-ID: <CALs4sv1VTT7L9t+BjuvW8naO7fm5Wq0qKgVkv2DW4nrNe1bucA@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: add unlocked version of bnxt_refclk_read
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michael Chan <michael.chan@broadcom.com>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ea797406264b1764"

--000000000000ea797406264b1764
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 3:02=E2=80=AFAM Vadim Fedorenko <vadfed@meta.com> wr=
ote:
>
> Serialization of PHC read with FW reset mechanism uses ptp_lock which
> also protects timecounter updates. This means we cannot grab it when
> called from bnxt_cc_read(). Let's move locking into different function.
>
> Fixes: 6c0828d00f07 ("bnxt_en: replace PTP spinlock with seqlock")
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++++++++++-------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.c
> index f74afdab4f7d..5395f125b601 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -73,19 +73,15 @@ static int bnxt_ptp_settime(struct ptp_clock_info *pt=
p_info,
>         return 0;
>  }
>
> -static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp=
 *sts,
> -                           u64 *ns)
> +/* Caller holds ptp_lock */
> +static int __bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timesta=
mp *sts,
> +                             u64 *ns)
>  {
>         struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
>         u32 high_before, high_now, low;
> -       unsigned long flags;
>
> -       /* We have to serialize reg access and FW reset */
> -       read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
> -       if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
> -               read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
> +       if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
>                 return -EIO;
> -       }
>
>         high_before =3D readl(bp->bar0 + ptp->refclk_mapped_regs[1]);
>         ptp_read_system_prets(sts);
> @@ -97,12 +93,25 @@ static int bnxt_refclk_read(struct bnxt *bp, struct p=
tp_system_timestamp *sts,
>                 low =3D readl(bp->bar0 + ptp->refclk_mapped_regs[0]);
>                 ptp_read_system_postts(sts);
>         }
> -       read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
>         *ns =3D ((u64)high_now << 32) | low;
>
>         return 0;
>  }
>
> +static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp=
 *sts,
> +                           u64 *ns)
> +{
> +       struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
> +       unsigned long flags;
> +       int rc;
> +
> +       /* We have to serialize reg access and FW reset */
> +       read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
> +       rc =3D __bnxt_refclk_read(bp, sts, ns);
> +       read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
> +       return rc;
> +}
> +
>  static void bnxt_ptp_get_current_time(struct bnxt *bp)
>  {
>         struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
> @@ -674,7 +683,7 @@ static u64 bnxt_cc_read(const struct cyclecounter *cc=
)
>         struct bnxt_ptp_cfg *ptp =3D container_of(cc, struct bnxt_ptp_cfg=
, cc);
>         u64 ns =3D 0;
>
> -       bnxt_refclk_read(ptp->bp, NULL, &ns);
> +       __bnxt_refclk_read(ptp->bp, NULL, &ns);

With this change, bnxt_cc_read() is executed without protection during
timecounter_init(), right?
I think we should hold the ptp_lock inside bnxt_ptp_timecounter_init()
just like we do in bnxt_ptp_init_rtc()

>         return ns;
>  }
>
> --
> 2.43.5
>

--000000000000ea797406264b1764
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIINm3aZA09mov9MnSAtBz5CB1UPP9O33
OO5qBJDZzjkLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTEw
NzA0MzAyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAHgYi+SPBBaa+5nYwFk28EhXLaRwtZF3Ic4yet/xT6ggOMFFml
KLVMtCYcPimCaWUa8eTo+Fz1x+99jy0zu3YDJvPJ6Mscb73X/8nhCZ+0tj80TUclUIr2sPIoiGGH
jfcF2n1Jd23GSXh0zikne/2ScNt0/C7NKEduUUoI08xEqFxAHwFcWVjss4MEgylya6xsnO0VaPXk
NJwINE/yl8VyxUAm1gMi6YRa9Rx3vWbdcrNJJ0aZ/zRH9R1CALf51y1QqtxUw2Fy9FFnJcEBe6Zt
ZaYTxnNnVfZQt/4mRinMkoVMFOHpDcNGlGRwG1pmsCdi+GD3HVMTdJXAFbcOdlqS
--000000000000ea797406264b1764--

