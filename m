Return-Path: <netdev+bounces-183438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB38A90A8D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143235A33E6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E550207662;
	Wed, 16 Apr 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VFeId620"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BC14B950
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826063; cv=none; b=fAjuSpKkhIZNI3bE4rtEda+8MqPEdBpIgGXwa5l33lxcZk/JDp2FIGmvrivfBxHXnQaVgMLoJx9bqxZc3z5DXoIfpHslxlJTbsZtpEthVfCfJkP4Fi8v2OrChFJkhWTR5BrDg2FD7DdCWHJKssLsC+Nbw9Xg0SDYjteiLh7ewo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826063; c=relaxed/simple;
	bh=q/8u4RWo/ELSWtENoWL8sOvAeK4g9GwilOyCEg4EfeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvLGomjY41JHdzfsltksf6IOnudjjJT3nIM8eeBfPdHMureYNnLsrgTcKCcIPEtKkE6HEjnle5Gl5NklKo7q+hXHxFJ2Y6LnNuJTFN8pXPg5AXfV1ghj2IUrSGglsJ7aaXD6lnz4FI1nb5PgZ9DAdljz9m7rzyhUeAjHQpJHRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VFeId620; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so11500184a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744826059; x=1745430859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30jCyYsWhlAJ2tlzJZ8lfb1gG0QkhAGA79N3hBY6DhU=;
        b=VFeId6203rCa5tbEN7OMzKC+fR5c+Pxn5oVYpuyNnAERP92KZzAs9aeygIOUnc4MbM
         jrCWG8/ZN4SkwqlnN9OuVLtlfTy6JCsekIbo+NGmWEhTq5Xyl3xe1JmqQ4aKq1t3AETI
         WAVaSX6BJg49uq1HmJ1m9+J4nEYUL8QeOyKjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826059; x=1745430859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30jCyYsWhlAJ2tlzJZ8lfb1gG0QkhAGA79N3hBY6DhU=;
        b=k7wECaT4tFHKSOLtRw4T/1tdfn6tKIyd1Ah2dMwxklrI/SJPrW8dVpe9P++dgG2o/q
         r6E/ernDwOpz3HvLfcfWILh0vj3ZkZlGZHNcJjCL6VufSdTni526c3upPFmAQwZqc/Ph
         nBCkuM1vMPBWSO/fn5lx3SYtUZFDDN/tUDbSc8kZWGcG4IRrLe5qAyg4/Q60USxxs8la
         bNGOwMHY408uwWvAuPmhKoX3pUW0w+JhGq/Z7S7sn4Lmp+Dox4I4nlI85ZGcTfEfHdmU
         uG54PMl+lVFrW3cjkkXA7H/dHcpPVXSqNRlnb7/ZzO5dwtLxZUzqYfkuxkUxK2/bZxZT
         /rxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxVaapGyohHUa31h+CNet+u+HaSYw8GBjGaOjpA+bgFYgg5ygBNUYuEp9Ho0wu1BMv59gNfSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySaR3ewkNUbRnC9breGzpLz1rpZjwJUQfE18Vs7B1KRJr+1/lv
	TjuNohFL22rMcUpxcsn0i7Q7SM7kwonOH6xWUw5WMNNUMRLyQ7ivSUIKtf3pStAYHzb2f7Co2tf
	VbvQ6WGKXwlGjhpvdNaGg+wvoVuNPDPmQWonY
X-Gm-Gg: ASbGncttCITTtdIy4crhFuO/pdmSeLZPc/IJLKeC7HUjU8+aWLhs4jaD04Y9wRuGeZ8
	9Rma1KezTf/3TKjGeySis7rP3nUcaJl2QpwzwgeULV+xxBSw94ytwS5dQhPwwbqIOUZZOOY5/yw
	lz7tF5oQzmByjFpCt3OST/SDM=
X-Google-Smtp-Source: AGHT+IEt13fLgOpX4NA+tUfLNDHzVooudnI4Wt6D/GZWk05ocEAXG8+6cJU813SmkLcQe6XJneMEkBrXThT8btPzG/s=
X-Received: by 2002:a05:6402:4407:b0:5ec:9685:e686 with SMTP id
 4fb4d7f45d1cf-5f4b6dff85amr2870727a12.0.1744826059232; Wed, 16 Apr 2025
 10:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416150057.3904571-1-vadfed@meta.com> <CACKFLin8=vm8MBBFpFgJv2Jw4Vn_m43cvXZUEMTfhgFnjZ+m1w@mail.gmail.com>
 <d39958c8-4f2f-4aa9-94db-e1f5c3a6b615@linux.dev>
In-Reply-To: <d39958c8-4f2f-4aa9-94db-e1f5c3a6b615@linux.dev>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 16 Apr 2025 10:54:07 -0700
X-Gm-Features: ATxdqUEJ1WkrcaJ-Z3xPLJUEVFYz-kpIHMvJuwUriOZrL_4O41PCycA7VCQO45g
Message-ID: <CACKFLi=Hc9apfJTzJFGY7jOK6vJKvUbOM=zXhnYfNi8xpiHuJg@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: improve TX timestamping FIFO configuration
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007b1a220632e8f943"

--0000000000007b1a220632e8f943
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 10:35=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 16/04/2025 18:03, Michael Chan wrote:
> > On Wed, Apr 16, 2025 at 8:01=E2=80=AFAM Vadim Fedorenko <vadfed@meta.co=
m> wrote:
> >> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/e=
thernet/broadcom/bnxt/bnxt.c
> >> index c8e3468eee61..45d178586316 100644
> >> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> @@ -3517,6 +3517,8 @@ static void bnxt_free_skbs(struct bnxt *bp)
> >>   {
> >>          bnxt_free_tx_skbs(bp);
> >>          bnxt_free_rx_skbs(bp);
> >> +       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> >> +               bnxt_ptp_free_txts_skbs(bp->ptp_cfg);
> >
> > Since these are TX SKBs, it's slightly more logical if we put this in
> > bnxt_free_tx_skbs().
>
> Do you mean to move this chunk to bnxt_free_tx_skbs() ?

Yes, move these 2 lines to the end of bnxt_free_tx_skbs().  I think it
just makes a little more sense since these are transmit SKBs.

> I put it here because the driver has 3 different FIFOs to keep SKBs,
> and it's logical to move PTP FIFO free function out of TX part..
> But have no strong opinion.
>

> >> +       ptp->tx_avail =3D BNXT_MAX_TX_TS;
> >> +       while (cons !=3D ptp->txts_prod) {
> >> +               txts_req =3D &ptp->txts_req[cons];
> >> +               if (!IS_ERR_OR_NULL(txts_req->tx_skb))
> >> +                       dev_kfree_skb_any(txts_req->tx_skb);
> >> +               cons =3D NEXT_TXTS(cons);
> >
> > I think we can remove the similar code we have in bnxt_ptp_clear().
> > We should always go through this path before bnxt_ptp_clear().
>
> The difference with bnxt_ptp_clear() code is that this one clears SKBs
> waiting in the queue according to consumer/producer pointers while
> bnxt_ptp_clear() iterates over all slots, a bit more on safe side.
> Should I adjust this part to check all slots before removing
> bnxt_ptp_clear() FIFO manipulations?
>
> I believe in the normal way of things there should be no need to iterate
> over all slots, but maybe you think of some conditions when we have to
> check all slots?

We generally iterate over all ring indices in the cleanup code.  For
the PTP slots, I think it is not necessary.  Any valid SKBs should be
between the consumer and producer indices.  So, either way is fine
with me.  There are only 4 slots after all.  Thanks.

--0000000000007b1a220632e8f943
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFBH+eUrM9K7Qc359SiNLRSQehWaze5D
xio9CaEpq2scMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQx
NjE3NTQxOVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAErCUNVE75R0STgQ61+wk6P07wITlpUTsrewjmVCNYDHIG2jVMlCleizrkVXcVptjIBD
gIleZfLIsf0q7ZPepgaf7jjzr7fqJ/vrxifSOiQ5Z01TFqXEu4o3jngs55tGWd7c3cJ3en0EqBg8
+IxUcya7Y9sgWkbnh6IoycRE+u1fzEsFlhLjKtHBfF9KkDy/Aq9V8mKMqWY6pkzx1WUHTqvB4avh
jiGo70ddtGI5p95KtKVjII0Wk9GVd15chwNUvP1WJ2YjZ5L8MWTe6a6y8wCLSENU/6AAGPkWXAyP
dUPfEqou6eVkVEt6fCYX21NXo4G9DN6ql3SVLKsalbLv5GU=
--0000000000007b1a220632e8f943--

