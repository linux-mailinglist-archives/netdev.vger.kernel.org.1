Return-Path: <netdev+bounces-130054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B40987D70
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 06:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE3F1F24B7B
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 04:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F49F170A1A;
	Fri, 27 Sep 2024 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RkQAbQ5c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21D15383A
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409846; cv=none; b=fJpc7+oAFACVnLH4k5PwdiG00fHQOZ/lZmcopc6JbtgLuLTD0yJdvblNe8EkuRerrWizhgUYeC7CJsYMIyQP3TOMeo4eFz2i+U6jGXVJ3mci4C0jz2ySxY5hH4m098ibY4A7sw4jLc3AXpLvNiw5Y3dC+Wms11J6c75kF4x6g0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409846; c=relaxed/simple;
	bh=9gI47288YLL5QudPloBrJTqweM/NKEX4Fplgh2llhhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OUXW7T+0ndmrqRFARhI4pbrzuLZitFDVYy8N29gbvS/KANsO1LBgWg6R/8CFsVQJ5rJLi3fKL1B2bC2TGJNLCPG4KwRCv6Aqly5xxzTBco1jVWT347a26B4iPLREhx5C6/vpBwjY7pMJCzmNZTiA+MwApP9YfGch4e7ENmWRtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RkQAbQ5c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20570b42f24so19484065ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 21:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727409843; x=1728014643; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+W14yFfeV9EzxuTiO4ZdYioN4XsyMtrapC7h3xBvIY=;
        b=RkQAbQ5cQqylq0xi5eKsfPfFdBkE0BLRVwvtbQ5n0ScPPOwKZBLzzsoQxFlK3gwqYw
         F4fTeidybGWteaa1YXR3Oe7Vx6jv+yQ7hoyi4JHlpjhFE9n+HYHEVgl86FLRzkEq9qfs
         UazlJceI+fLXqlVy2vOypMehBIy7w/s1wu850=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727409843; x=1728014643;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+W14yFfeV9EzxuTiO4ZdYioN4XsyMtrapC7h3xBvIY=;
        b=fX9zdd5KutnrXGwLzxQ0tq0opPT7Kpx/NXL4rz3ZNcofhLxuIiE1VEcopMEHs7KrCr
         jVtLjPMnqkGKTTxpV2W66LuKMpiXb5TnlIcHmyBpbYRA1zvBalFQAHcc/pkPmZzjkgeb
         pxTNAsWW/w0ZC+RzQ9yN3yXBW1tjU/SdIKRiboq9vsXi8yeKn42/YbFsi2tOSFhnyGdZ
         BhJZ0CIci97TFn1s3UcX24L6wKelBl09ecqsHP4FnFP+tgTXYaOwjqE+ZjEMzaF7OaH1
         hti9tplcaijMYiHVlDCF8zpzUAN1XTqbJEcZrx9X7IaEnMLkcSpjiOJUIVk7aqYtt0po
         B/5g==
X-Forwarded-Encrypted: i=1; AJvYcCVMbxBgazPyMfZs9NteJSlHR+B9q7Wj4AQ2wdsOxR7rvQbrm6efx1QygqABJ8GZHOt4s73khtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RVDj51IvcX7G0UCKKsWt+8ur/QKw84BeYqRU8h7t5ooEvPA7
	6LAzb9e9N+ogratGNzv9RM0XKPte/9uElblCtgiThsVwnp11YQ+h+zJFOYHSr40/o41g1pA5NO7
	5PlBlQBShhUL84O8JuN49nH9wdbFgomzVs3fa
X-Google-Smtp-Source: AGHT+IG4Wh+bT6waf4HGyuQAEPcmvfRMgaecrCyrXO/5Cnlp3LBESCQaj+KhiqsnB3RTZO3ILmrpf+gYmxIdDaaVcQI=
X-Received: by 2002:a17:90a:a88c:b0:2d8:71f4:1708 with SMTP id
 98e67ed59e1d1-2e0b8b1c5c9mr2358041a91.19.1727409842404; Thu, 26 Sep 2024
 21:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925162048.16208-1-jdamato@fastly.com> <20240925162048.16208-3-jdamato@fastly.com>
 <ZvXrbylj0Qt1ycio@LQ3V64L9R2>
In-Reply-To: <ZvXrbylj0Qt1ycio@LQ3V64L9R2>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 27 Sep 2024 09:33:51 +0530
Message-ID: <CALs4sv1G1A8Ljfb2WAi7LkBN6oP62TzH6sgWyh5jaQsHw3vOFg@mail.gmail.com>
Subject: Re: [RFC net-next v2 2/2] tg3: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001554bd062311f2dc"

--0000000000001554bd062311f2dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 4:47=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Wed, Sep 25, 2024 at 04:20:48PM +0000, Joe Damato wrote:
> > Link queues to NAPIs using the netdev-genl API so this information is
> > queryable.
> >
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml=
 \
> >                          --dump queue-get --json=3D'{"ifindex": 2}'
> >
> > [{'id': 0, 'ifindex': 2, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 146, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 147, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 148, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/broadcom/tg3.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet=
/broadcom/tg3.c
> > index ddf0bb65c929..f78d7e8c40b2 100644
> > --- a/drivers/net/ethernet/broadcom/tg3.c
> > +++ b/drivers/net/ethernet/broadcom/tg3.c
> > @@ -7395,18 +7395,34 @@ static int tg3_poll(struct napi_struct *napi, i=
nt budget)
> >
> >  static void tg3_napi_disable(struct tg3 *tp)
> >  {
> > +     struct tg3_napi *tnapi;
> >       int i;
> >
> > -     for (i =3D tp->irq_cnt - 1; i >=3D 0; i--)
> > -             napi_disable(&tp->napi[i].napi);
> > +     ASSERT_RTNL();
> > +     for (i =3D tp->irq_cnt - 1; i >=3D 0; i--) {
> > +             tnapi =3D &tp->napi[i];
> > +             if (tnapi->tx_buffers)
> > +                     netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYP=
E_TX, NULL);
>
> It looks like the ASSERT_RTNL is unnecessary; netif_queue_set_napi
> will call it internally, so I'll remove it before sending this to
> the list (barring any other feedback).

Thanks LGTM. You can use Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.c=
om>
>
> >  static void tg3_napi_enable(struct tg3 *tp)
> >  {
> > +     struct tg3_napi *tnapi;
> >       int i;
> >
> > -     for (i =3D 0; i < tp->irq_cnt; i++)
> > -             napi_enable(&tp->napi[i].napi);
> > +     ASSERT_RTNL();
> > +     for (i =3D 0; i < tp->irq_cnt; i++) {
> > +             tnapi =3D &tp->napi[i];
> > +             napi_enable(&tnapi->napi);
> > +             if (tnapi->tx_buffers)
> > +                     netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYP=
E_TX, &tnapi->napi);
>
> Same as above.

--0000000000001554bd062311f2dc
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIL8gYtz1F+nImSeaIewhVZXTJ/YajHLr
Zv/C8a7x1AATMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDky
NzA0MDQwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCcqo/V8AdQDT+Et5WckkfZQn7Lz88Mh1/uJf2Q8heI7ARz/Rcb
sBQ5xjnTNoKPelp1+0tqJoiTUCLeOGtT73bueflpZalS0C6nGbnT7tA1kP0H0UXBxg43vvQ7Az70
pS1ne6yj5UFDxaTQN/zHer76tYz5x+Q+fvaCREN3AYn162BWV9GlnC3tyGhrnb2t5d0Xq9HqZI6f
fB6gpwWYGhwU/it8nxn189fBpdWqz+sGFnzBHMTnliPzI3fJFePYg+mZxa7sdsC2C5Rp4qNBfiS/
gR96QQTJYiYwDeMgOgOwcm722aNyYE1fb1C7k/D44EhvVZu/DBGr4yzgcDMNW2Ms
--0000000000001554bd062311f2dc--

