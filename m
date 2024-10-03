Return-Path: <netdev+bounces-131471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E121198E91D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 06:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E41428721F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480B45C1C;
	Thu,  3 Oct 2024 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="flbkAEob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836645026
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727929614; cv=none; b=jWHmAwBHD/E+BwMVxo27KA/DCdmMJHrsxdCff5neYaD5b+3WACSI6NUs0PuN/5jzctb/bLGOpkc/5upNuH0Ch9mPi/wtFeF0bw5D0vX6QXQYgAErPIswlttpkrZaLwx+R/SBwNviH8ahtwzlX82+DkRsoE94w+EAUziAh3dlw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727929614; c=relaxed/simple;
	bh=p+yPdlBeH5UEXyV5bc/CU/s2ck0RiDgZK8yNpJeDhUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CxJ2fLURKDHuJ6MVVxrKO9btH+bVn0BDRjmIZ983ygNFwMt5C8v5IWXOTwtWlTkRbkdHk4PLpUjvx7zuwuTLBbtgTuHE00SCyhmNy+9tT997HzS2W73i29qSmT7BqdGangSTndiJdJmZdJwkewopamJOjzn40jJsNS34zPtAMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=flbkAEob; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d7a9200947so278949a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 21:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727929612; x=1728534412; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsvFnWE44r99yKx5iYFGkXwwbxkeQnOtqyZ2ZHN8IvA=;
        b=flbkAEobxuw0sqGV5Kq7XND7GNfSxJdAi4M8bcBh+xCBLelNxfdgvL67FO4vpHNlgl
         WWFL5+hq+zUfRrE5D22NR7nwkkGoKye4nSd3oPOlNsOxS8TjmCs/0wR+fAyaFcxKl7aX
         7mL7+gINRbl/Y6AXx0YC8nq+n3CM5HqIdjAIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727929612; x=1728534412;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsvFnWE44r99yKx5iYFGkXwwbxkeQnOtqyZ2ZHN8IvA=;
        b=AsDWQ8mH30nvQGN1khlmP9Gxh2PU3Yx/xI2fPDavLEtzfb0qTXjVN+FdJR+d3eA82B
         SpFX8ulLfe/ULyNTCmnFHl2xUGfcFSqWdX/kB8zBmrcSy85DrD1zeFqEu8EvC6eQJ0AR
         vx3pyMDB1aTy4zpL28A4PzUzVxhuuXnF7+U638BU+9WMFWli/RqKm8JKJ627+obkDXtu
         lv0PLOEK+ziZZ7kQ80KwpWU9eQdOJH5xryMqWI54y+YTiV3Hz3z007aq+27Xlqp7GCB8
         pwMHUFQkQF2C6izXe0v9kGtsEA6PtLTvoUAXiT3E62mPNfP1l9a554eTbf5d0UyNhtRV
         yH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtF9Ox5d1Iu/+iH/h5sFMgOKQ0M6Z7rRiPDgBM1OTJB/rxG7y//t3GlJmny2sbAk+D0kcL+Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbHgxLYi3nHsuUfxAHiSCl9P1K7FJ1ngmihudaHa+UlRPs1Ke
	Q+zAjdhhphDAyMEgYVr9q8gL6sLDpEilBVuC/NW4JncRRHMSsh7g796JBWcwGCkT0DKYWkh4pCk
	oOpK/hxFJzKifQZHVWFsfzERD42vQQd0YWOo9
X-Google-Smtp-Source: AGHT+IFdnlJMZ6Np9URI4XV8Tia0G/N84u5hXxMijPvswHnRh7R7/OyNMZDEaU6UZuMVQ2+Go1eFfty5FLEvusmMvBs=
X-Received: by 2002:a17:90a:e64d:b0:2d8:3fe8:a195 with SMTP id
 98e67ed59e1d1-2e18453050amr6749221a91.4.1727929611630; Wed, 02 Oct 2024
 21:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925162048.16208-1-jdamato@fastly.com> <20240925162048.16208-3-jdamato@fastly.com>
 <ZvXrbylj0Qt1ycio@LQ3V64L9R2> <CALs4sv1G1A8Ljfb2WAi7LkBN6oP62TzH6sgWyh5jaQsHw3vOFg@mail.gmail.com>
 <Zv3VhxJtPL-27p5U@LQ3V64L9R2>
In-Reply-To: <Zv3VhxJtPL-27p5U@LQ3V64L9R2>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 3 Oct 2024 09:56:40 +0530
Message-ID: <CALs4sv0-FeMas=rSy8OHy_HLiQxQ+gZwAfZVAdzwhFbG+tTzCg@mail.gmail.com>
Subject: Re: [RFC net-next v2 2/2] tg3: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	netdev@vger.kernel.org, Michael Chan <mchan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bb229a06238af6b4"

--000000000000bb229a06238af6b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 4:51=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>

> This is happening because the code in the driver does this:
>
>   for (i =3D 0; i < tp->irq_cnt; i++) {
>           tnapi =3D &tp->napi[i];
>           napi_enable(&tnapi->napi);
>           if (tnapi->tx_buffers)
>                 netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_TX,
>                                      &tnapi->napi);
>
> The code I added assumed that i is the txq or rxq index, but it's
> not - it's the index into the array of struct tg3_napi.

Yes, you are right..
>
> Corrected, the code looks like something like this:
>
>   int txq_idx =3D 0, rxq_idx =3D 0;
>   [...]
>
>   for (i =3D 0; i < tp->irq_cnt; i++) {
>           tnapi =3D &tp->napi[i];
>           napi_enable(&tnapi->napi);
>           if (tnapi->tx_buffers) {
>                 netif_queue_set_napi(tp->dev, txq_idx, NETDEV_QUEUE_TYPE_=
TX,
>                                      &tnapi->napi);
>                 txq_idx++
>           } else if (tnapi->rx_rcb) {
>                  netif_queue_set_napi(tp->dev, rxq_idx, NETDEV_QUEUE_TYPE=
_RX,
>                                       &tnapi->napi);
>                  rxq_idx++;
>           [...]
>
> I tested that and the output looks correct to me. However, what to
> do about tg3_napi_disable ?
>
> Probably something like this (txq only for brevity):
>
>   int txq_idx =3D tp->txq_cnt - 1;
>   [...]
>
>   for (i =3D tp->irq_cnt - 1; i >=3D 0; i--) {
>     [...]
>     if (tnapi->tx_buffers) {
>         netif_queue_set_napi(tp->dev, txq_idx, NETDEV_QUEUE_TYPE_TX,
>                              NULL);
>         txq_idx--;
>     }
>     [...]
>
> Does that seem correct to you? I wanted to ask before sending
> another revision, since I am not a tg3 expert.
>

The local counter variable for the ring ids might work because irqs
are requested sequentially.
Thinking out loud, a better way would be to save the tx/rx id inside
their struct tg3_napi in the tg3_request_irq() function.
And have a separate new function (I know you did something similar for
v1 of irq-napi linking) to link queues and napi.
I think it should work, and should help during de-linking also. Let me
know what you think.

--000000000000bb229a06238af6b4
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBeqrEtLduZ08i23m13ICN0+Ek6KNZom
kvQixb4NGUUWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAw
MzA0MjY1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAhsk1pr/UlDxQ2KdPUfvMXDx7bNHXcskmu6j5XdNzm92F4MfNB
yny9YDkzWUlexxToohQ4R/XfAXaQTXy9QYYEvmwjzFwB9HwfDZomV1ABNJKl7yAqxmPVVME6JQEi
XfMi38umraoR8AlbGsYjmDCp0qEHO57aptJJT96Ve2Lk4kenjZOQB48AgLdYiAgV7wsdIvd6ll9W
xNQQ7zww5m6Ukyj/VNz4OLQ/Ckbhi31GtU+kVf/iWpKVX1UtsH5Ud/3BqwnSRWXB3Qd5KtdwEOND
3RCQzle50zlb28azsXJPkUFf4NvRekzhS2xn9KPznXuwSDLjM/f72kubYtAYMGuD
--000000000000bb229a06238af6b4--

