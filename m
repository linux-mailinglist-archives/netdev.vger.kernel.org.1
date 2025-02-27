Return-Path: <netdev+bounces-170083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD2A4739A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC1316B9E3
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1141CAA79;
	Thu, 27 Feb 2025 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JsA0Pies"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003F1581E5
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 03:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740627353; cv=none; b=mYfJn1k8hy29yNC5WvB2yy/Kvc1PzV2J7ZnPKvHlN0JR6+Nd9wNcN8pTJR0ayaEFYJFLFcilfWPaoyLS5A9l+aVf8UDvjPwlw5o+/CiwdTp3D5GpyMkbabxQsatrQnq7jM2LNGXcsnD9JkML6aFq+eKk5hWC814TXEeFG+0GyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740627353; c=relaxed/simple;
	bh=vNZ9Ee4PEn1a18l1huNLQOlDV9Hhfp5VcnAjeroI980=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JskEFwp/VUF1pTyvLTReQn6d1fN5xAZABwZwIRNG4jqUS6pIJSZyvy6hYNyRlwrc5PiYeC5HRU60VmLm7Lei+7LPLCTcruSQCg5C9DuLbkt122Y0cBSqJ2Bdk+deXPiaV0aFECo4jFPe166+sGjMAGsRNiuF7BQsV79yNHQXoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JsA0Pies; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so696013a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740627350; x=1741232150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gC/oYDbLFCR/RsHSPIQ5lQ0nQLQGsUaLMRnzMepPDsQ=;
        b=JsA0PiesBUQp568HcE5DMdKMAfk635EHSeyLVst7keqN9Ehl+xwfNzgdxYOxCemdgK
         k6vUzF713OgItLHxG3f8A0NzUtyVvlagORUirVvTp3XkoJlS0V7gVWiikEsOTzHFsyI2
         TXyRa1B0dLJEb1YYlSaOkGtyTSAveA4p92mBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740627350; x=1741232150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gC/oYDbLFCR/RsHSPIQ5lQ0nQLQGsUaLMRnzMepPDsQ=;
        b=TGIl1cWmD79r/ArxHaBedJEfRUQbrGBNbZNHUyz3qYJc7tb1IUUNCnBjM5U7O5RIOc
         Sma8kk1xq7hNxAcgipfCZAyzT5EZm9+ISo//sjaJdh3KPEAoS7qdcIFZ81oyZ/9oVgBg
         cs1fYko0L8OXXRQoc8MlLEy7emg61qSq7K1fTKqJPs3mQbJDxBqB4JTJKbBGI4nGT2QO
         DiK4aB84rxIS7IfBr0/+cch622btX4AZDTvXaKYxJ76Ysl0t2Vl7G4/tK1PrKOo3aF57
         dOeW5HUPj/nMF0wGAgpR89c4Lt4KZpMLKETRmTeIGiL9tRMakfvZFR3XWad7d0Qu92A2
         FrSw==
X-Forwarded-Encrypted: i=1; AJvYcCXJMYcUyweATlC7t/ZPb+BTZ0gIlTW1YBHoVLKTgwIU9mRAxh10po2TkPs8ReKTMhEsbExlXQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylVU1QCphPH3OLEYjV7rk8puf3ym1HmX/Y7WwuabzQNzBwVBHa
	wne9x15MNSC4sStUaUGvQ8qNueFqk40mDwtbz4tf9OGQgnx1csX26lxo2ZrBtA2ZhbR4ImnJViN
	3KcPK36gIgAJX7mW53g7BJ58ZYgPPyCK2OBnc
X-Gm-Gg: ASbGncuwDAOXAkjtXQ/6RjA/77fZ5cfCyLecRmX9b6K/rC8x8DJdjvgw7IshBmjFq8T
	yw+T0gY+nFMGCvsGq+SKaUHWej47i9g1KKIF/GXhUpgiUNukBiwS0sdieJylafq7w3BTMEN/mQG
	8otfHBfcY=
X-Google-Smtp-Source: AGHT+IGh4Zw815ePwsSALRf69VStvGcJVqgd11+D1bXTCpgK8e5Z71qhoEfWj6f6phfELtNHo1fbtHCa5u37SltaPMw=
X-Received: by 2002:a05:6402:448f:b0:5e4:b874:3df7 with SMTP id
 4fb4d7f45d1cf-5e4b8743f06mr4260437a12.25.1740627350322; Wed, 26 Feb 2025
 19:35:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226211003.2790916-1-kuba@kernel.org> <20250226211003.2790916-3-kuba@kernel.org>
In-Reply-To: <20250226211003.2790916-3-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 26 Feb 2025 19:35:38 -0800
X-Gm-Features: AQ5f1JrQww6JW757JNX-qvweZbzcICqI-Wnl-LpEROEy2V3NDGVTDzQU3OAu27I
Message-ID: <CACKFLimf=8QnGvtsRkxf1YbYheXpdWJ=vzyEH=+vfgPPJ7c6KQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/9] eth: bnxt: don't run xdp programs on
 fallback traffic
To: Jakub Kicinski <kuba@kernel.org>, Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ec892e062f176286"

--000000000000ec892e062f176286
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 1:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:

> @@ -2159,6 +2159,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnx=
t_cp_ring_info *cpr,
>         len =3D flags >> RX_CMP_LEN_SHIFT;
>         dma_addr =3D rx_buf->mapping;
>
> +       dev =3D bp->dev;
> +       if (cmp_type =3D=3D CMP_TYPE_RX_L2_CMP)
> +               dev =3D bnxt_get_pkt_dev(bp, RX_CMP_CFA_CODE(rxcmp1));
> +
>         if (bnxt_xdp_attached(bp, rxr)) {
>                 bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
>                 if (agg_bufs) {
> @@ -2171,7 +2175,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt=
_cp_ring_info *cpr,
>                 xdp_active =3D true;
>         }
>
> -       if (xdp_active) {
> +       if (xdp_active && dev =3D=3D bp->dev) {

If we skip the XDP program, we still need to do this check in
bnxt_rx_xdp() because we may be using the XDP TX ring:
         tx_avail =3D bnxt_tx_avail(bp, txr);
        /* If the tx ring is not full, we must not update the rx producer y=
et
         * because we may still be transmitting on some BDs.
         */
        if (tx_avail !=3D bp->tx_ring_size)
                *event &=3D ~BNXT_RX_EVENT;

>                 if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &le=
n, event)) {
>                         rc =3D 1;
>                         goto next_rx;

--000000000000ec892e062f176286
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMFaxj4HlB5Z9H5IdSMoOiEnJOLHjJKg
Q/u8xaDMFNEwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIy
NzAzMzU1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA6c41hzmZbwjodsAF//Dy4ysqrBYNxDHG27o4t16YLLDIi5r6u
sVq+bBQftVuGBpB24l66rXm6f0A6BLTOB9gAxOv1WHWw+w/RzE26x+WqBWJ2JwCHDqXY0pED7wHg
9n47wbiDjPWjFhlJ5Tsju8QdYSlK7O6wgQuwLIRCSYwjjIJSzJEcF/LxicNnLyCKwZVYaLCZoJ2G
E9FhCugq4x/crcJ0OslWWNdSliASh2VB49bpxd90Ebl/a68RlRKFRIc6hdcpTKXSpGpPe/51VuJo
Fq0gr1NcF7pJ39NY3tY43T7scEH30smUC0mzlDLuzBqXC/vTj7H8okjplWl2BZIZ
--000000000000ec892e062f176286--

