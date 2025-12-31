Return-Path: <netdev+bounces-246442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CBCEC35D
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 17:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9627F300B92E
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EF41E5B95;
	Wed, 31 Dec 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dwnXgXCp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CD1D6BB
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767196874; cv=none; b=bw6yzTjj5eEJyFvbcrKXC91hlFEHleRSV3zUPGkAGX03lKjQf9+P9+L5u2lZemrVxm9UrV+mhDo/wTDzmCH58TeAx8+5E16Dg9oTqdiWYt9uj6Ox6kZtUyrVwYQESrwf9SqfJHXd9GOKkRwW/Y8tUg8/bBFWE/BitIzTo1AlJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767196874; c=relaxed/simple;
	bh=9wzupSMaeXbDHpeRO65zn6oE3aPlKfwj4rW6Xkyqw0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBRwvceLYlXTkw0bPjXOoCMz2dFJjmmw/EmqP01GNdm7fTCCtySye47h1PXQd/NJ8WqtfHh63dpklq1Rpn5ze4s8/Q0xomIP2Ho8Kc7xFYgFKmIiKh5Xlfmkg8ejSdGJYmaHZt+Jq5Mj7OxMS9QC1pJH8UbgG31cuhBXxtXxYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dwnXgXCp; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-78fd0cd23faso76882527b3.2
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 08:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767196872; x=1767801672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMStzXK1epWXymgIMFfy/NLEkfueARsRpdZNcHB2h9o=;
        b=Bgvbhv5BLYXgujCDJZ1CaW7pY3Un3l9KEaGFBdQo5EdrXe3mdgKEOBeUe/SD/vscB2
         yIDwB6YXYxT2lnMW2kKcHS5OVyMCJJkI5kFQLj3PbPO46pmX56/e+umuUF6JHiJuChj/
         lfmD8NdHxKGBkrL5NERJFuHzKTfGt+B3/E7HWthhK0DG/liK3uBtFyPRfngh3p0RtDXC
         iA3kcD9lnWnpl5uiCcWPIXrDFFdW9IuH6jZPfCCHUYm2qr9/3DvbgeceDlixiaX6xn1E
         22xHUEYbrFUz53Y7Uzzx1VVjl8nHM3MFYuemBBl+hAR7SramNQocIPC4FrBpdIZmItu0
         enSA==
X-Forwarded-Encrypted: i=1; AJvYcCVdZHcgCQwezLNeESvkAxqPU7240IQE3Xr5H6yJx43ihHsgmXMBeZYmyfFHKug9iTI5c/VxCC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgHgiZoeX7ZQsLMiyWwGBrgQFFWFWfnF1OIVl7p2aPTSsvXoZ
	3xyAc7AMTbxLDgMBa7rK3hTdJCeazHXXgDkNEr7gCCntstHUDgH4lJBgGefJt9h2lhyf0J0u39R
	5faggkJTNrtySVqR5J0RlEj3PDMOYnzXwffTDPxXU0Sa+AHGjsxeVq6ulHjm/ahOFfwdz6fZPZm
	puN9tDt2g4wVwAKtq7hp/Tl99ZsMYjmsOdBoGHhyj9HGmg0hPlMfNijI82HRYV2Cdt6XBbnFVhC
	zmG1RDvPXU=
X-Gm-Gg: AY/fxX4uTvduhqXB/59byKrMKmkiSPd1PGoVg53I3le+eRPS0FcQHPm+y8TnCvuIEQh
	DBazUcAt9RYTviwwYDMo1plAJ2H0uDdOAJbNkgyH746veE2O2IY57heQ+o8+Folzb6EaFk41O4Y
	uZyySob1+XAbppcVzk6aqpzqd0ZRYiuwi4cZxK4l+M1Cgu36HW1Jj9cvMeo4YHXMCVNTsHds0Ki
	9BYxEtRVXZsam33geaC9kqJutL5U9k6NWNm/Oe1SEBkweLCv5f18g8eQW7bIrSdLy8obThY7pB2
	XpShaZCuI2jjEeYkMyDkI88vLknm8SToZdkUQ5A9RmIYU2/DgyHbtDBc9TOWuBmpCz3uGFCQ1ay
	IIKtTRUHXsJ0jkYtP3kx2v1FmMaBtBCVI7tpHKwPTdym0BrxWQudTwZZ0LXTZj1iWGJlgk+ycRK
	Gol5aBArZUN4sL+md0aSWH5ikC1Y9SyqoGRNmtm1WqOhEOWCE=
X-Google-Smtp-Source: AGHT+IHKgo3krsojMqd7j0Xkpl3/vg3KBQJuUHPl6d4sQKD7uEitxL7XpfZBICZ5BHgM5YBLXO470aF3LJrP
X-Received: by 2002:a53:bdc5:0:b0:63f:2bc7:7074 with SMTP id 956f58d0204a3-6466a8aba62mr23275303d50.60.1767196871839;
        Wed, 31 Dec 2025 08:01:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6466a91dd41sm1865454d50.9.2025.12.31.08.01.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Dec 2025 08:01:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c5d203988so23006331a91.3
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767196870; x=1767801670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMStzXK1epWXymgIMFfy/NLEkfueARsRpdZNcHB2h9o=;
        b=dwnXgXCpLOJ1y8gcAlncKnpJj99wdvk5+2Ed4nKtF5/RAsTQ+nk8W9UMoIn7Ada/tS
         CdsJ0bQSvTDEJ67xKGYI2WkTVAu0RtDEX7oD77T6HX95PT47Cx8oMLgXK9ivuKTFT9z+
         ZfHfsRYwwH6/0A5wOX+r9cBR29btfP+m1ZMbU=
X-Forwarded-Encrypted: i=1; AJvYcCWpikS0Va6f1BQuzBd6MrktojMJHBrSFSgWwpm49S6TcNM5VtMFke33qfsY1ypUgEHnxFn8MQE=@vger.kernel.org
X-Received: by 2002:a17:90b:2251:b0:340:ad5e:cb with SMTP id 98e67ed59e1d1-34e9212f362mr31347236a91.8.1767196870281;
        Wed, 31 Dec 2025 08:01:10 -0800 (PST)
X-Received: by 2002:a17:90b:2251:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-34e9212f362mr31347171a91.8.1767196869587; Wed, 31 Dec 2025
 08:01:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-bnxt-v1-1-8f9cde6698b4@debian.org>
In-Reply-To: <20251231-bnxt-v1-1-8f9cde6698b4@debian.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 31 Dec 2025 21:30:57 +0530
X-Gm-Features: AQt7F2qBxre4gEx9lPoKL50XL6gs5aq-TJTnGLJtW2nYJSF0T9B6CCzo6Tdrpo4
Message-ID: <CALs4sv2qQuL0trq3ZB6SczPK5BmFMF6p2Ki-3q+4Xqc_qzauoQ@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
To: Breno Leitao <leitao@debian.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bdcc910647419512"

--000000000000bdcc910647419512
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 6:35=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> When bnxt_init_one() fails during initialization (e.g.,
> bnxt_init_int_mode returns -ENODEV), the error path calls
> bnxt_free_hwrm_resources() which destroys the DMA pool and sets
> bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
> which invokes ptp_clock_unregister().
>
> Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
> disable events"), ptp_clock_unregister() now calls
> ptp_disable_all_events(), which in turn invokes the driver's .enable()
> callback (bnxt_ptp_enable()) to disable PTP events before completing the
> unregistration.
>
> bnxt_ptp_enable() attempts to send HWRM commands via bnxt_ptp_cfg_pin()
> and bnxt_ptp_cfg_event(), both of which call hwrm_req_init(). This
> function tries to allocate from bp->hwrm_dma_pool, causing a NULL
> pointer dereference:
>
>   bnxt_en 0000:01:00.0 (unnamed net_device) (uninitialized): bnxt_init_in=
t_mode err: ffffffed
>   KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
>   Call Trace:
>    __hwrm_req_init (drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c:72)
>    bnxt_ptp_enable (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:323 dri=
vers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:517)
>    ptp_disable_all_events (drivers/ptp/ptp_chardev.c:66)
>    ptp_clock_unregister (drivers/ptp/ptp_clock.c:518)
>    bnxt_ptp_clear (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1134)
>    bnxt_init_one (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16889)
>
> Lines are against commit f8f9c1f4d0c7 ("Linux 6.19-rc3")
>
> Fix this by checking if bp->hwrm_dma_pool is NULL at the start of
> bnxt_ptp_enable(). During error/cleanup paths when HWRM resources have
> been freed, return success without attempting to send commands since the
> hardware is being torn down anyway.
>
> During normal operation, the DMA pool is always valid so PTP
> functionality is unaffected.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable event=
s")
> Cc: stable@vger.kernel.org
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ptp.c
> index a8a74f07bb54..a749bbfa398e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> @@ -482,6 +482,13 @@ static int bnxt_ptp_enable(struct ptp_clock_info *pt=
p_info,
>         int pin_id;
>         int rc;
>
> +       /* Return success if HWRM resources are not available.
> +        * This can happen during error/cleanup paths when DMA pool has b=
een
> +        * freed.
> +        */
> +       if (!bp->hwrm_dma_pool)

Thanks for the fix. While it's valid, just that to me, this check here
looks a bit odd.
Why not call bnxt_ptp_clear() before bnxt_free_hwrm_resources() in the
unwind path?

> +               return 0;
> +
>         switch (rq->type) {
>         case PTP_CLK_REQ_EXTTS:
>                 /* Configure an External PPS IN */
>
> ---
> base-commit: 80380f6ce46f38a0d1200caade2f03de4b6c1d27
> change-id: 20251231-bnxt-c54d317d8bfe
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>

--000000000000bdcc910647419512
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMClwVCDIzIfrgd31IMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTM1MloXDTI3MDYyMTEzNTM1MlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEPMA0GA1UEBBMGQ2hlYmJpMQ4wDAYDVQQqEwVQYXZhbjEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ANGpTISzTrmZguibdFYqGCCUbwwdtM+YnwrLTw7HCfW+biD/WfxA5JKBJm81QJINtFKEiB/AKz2a
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAg1up4
mHRndmcHxBrnE/tmOpkSJTeYq0ao2c2XXUG3WDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEyMzExNjAxMTBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDOrQm5zBmBZ+Hf/4y3tOL1cddz+JpQsYlKnosWs/FM
xoPwqVADGPVsxsABcSJ4tnlOdosUeG7ur2vXj0svGRqLwQfYVb2SBFmowgpGQYx3//xNWwjZuV8N
3gdzwkt7raGNKktxr5zmhFOKxljI3N5TsPh1+ejFKwsP/+Rp7syRbpqbOc7E7MCZjVc08PEwWDYz
Xrcbuwvlf4qoU2rQ09d+nIbj7GEU4QPGaIybZ0WYI4/6sbUF0ZiNct/b5sXeuXT+twUIMSBHPUPX
gKdJeMZU1RFF2omzbVCOd+vEiL9wLsrVnVZuE5q35NjrFIHKJLx8390+SYayumY1wFiPCdmO
--000000000000bdcc910647419512--

