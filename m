Return-Path: <netdev+bounces-280530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JfbFmIQ6WmiTwIAu9opvQ
	(envelope-from <netdev+bounces-280530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:16:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E72E449A18
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A16B930D3C9C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1153C4557;
	Wed, 22 Apr 2026 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eKbZLDwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04C3BED76
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881502; cv=none; b=hA1HxNHdpPyNtgs5TcJ475IVOlJp93Rnx+USBO3hXvLJUPTH3mJQQVIaJyViGQhwoFptFUO2QFypIcdOdUn3jnXfOZt9XXWDZvGzuXMuchiO+WLWBKiIUugnIM4z46NUSq92ruW7wKiVEDPoKxB0IQ9Bbz8iv24LZDREvfWOYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881502; c=relaxed/simple;
	bh=kJ6SnXMZuz9AEQvU7bExiPMTIWCij4s9BSxbx3q7K50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwVUDAjn4uNKGa3pzNjogYlMQZcrroVZdAEjbcXXnK7+FVyORnJmgLKXS6vWF/aZn5cnsTBvxYbEfXyDbeZn8pDIF2PDaC1yn8f6DRmjGP32SNtWU9OL7rj15thAMVyxaJ1Eiq1qMF0Z2GggUFC+RSdqtyEAuh1R9numXkyjeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eKbZLDwt; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so2701486b3a.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 11:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881500; x=1777486300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qT0jxCrA040kI6196iRS21pG9IoWaBGboEW0YzCmftM=;
        b=YfH4iTT5brC0AKwTdw+PH125+k96Jjm/LnwNEVP2whcUCyN3mqr6Ycj9oFOvmuKimR
         mSIbXr6YlNqargIwAaJPzhxGvLr6/dDl4q7EmT7SmLzgDJkWu41UsJQ4rlgMCYbxR1kf
         oBKcEBPua18WfiI+HkX4DKAsXrCc2hhBmll3xNkCvQJeSdlAFXtURX0ElXgrv8kyFodk
         TdEmBQvBSB/f5Z3fMXJAOi7EIgDpbvLXkTpFIq7yVM2MCQPmDNOwJx+TPO41NNtEfnos
         9ZpJtsKjiqOreoPYxVlRotY1qd9IKLOV4N741lRpx71r56MuxQVOoECctHKJMXtqGZAY
         RHkg==
X-Forwarded-Encrypted: i=1; AFNElJ/f9dhw6tKXltyALK5Y8zIq7/ldyPvRReadTAZN+BxDfdh66tnZCENyQjj3oT331Wmuhvpk/xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIqoK5YJEaZFyqB1/2qTZXzlHfcPRvfcUZyQCQ04H1A0+cd5Tx
	ZlurNlciw+HF0g3EnYosF8XusELnZ7TB0scO3Hoyyj1JdAMec4H9lFw13nd25fMhTrHjYJ92pk+
	jUx8J0sAznZhxqLk/MXEd4gOcfM7pqH7WN+c7GRztISKBRMJ0/s0urb0cFjSRGMEU+Hg4neeg0y
	+qL2zoWfjqkv2YLvjBB3mUxm/4kYq8OJU5Ik2QNJ7DCsj5waM65uqaFD/rRrpUGa3N5dUbqQd2Y
	NcsIbKtnA==
X-Gm-Gg: AeBDies6sBwnXK3ghwugOcjuIKEd48bpLzXuxvPl4Zw0FjQFUvlP3XyZi6rBNbyWZND
	UpTXJxpcyMOpx4MxdA2M9t71vYx2ugN/JAHhNofG9t3A8emTJnGpVuEmellnskHemdir9D5Vxgm
	W4FnPb7910Ufs7HGJbpQwvZbhPCQAUzSGOIF4UqAWG+t6s8nQMLknaqqcEjEMrmqfW5YMir5KGo
	POZrBmm908t92Q5MhkQl/+DUN0OVEURtfTWsU/mR7xyGEhA6QvoyHPeCZS03JRJlRr5/0ebYL7J
	wHCFFQ+MNyfikg/xwAwSTWI5hHZOCDRVFEUPLPW321cBrPK7KurXYW210q6PIJM6ez13rqDnu/y
	P9srAEelXuhpBwyH1W9YjxzuA2TZlEtlSoi5iNX8tDQWaBQOhNF0Dho/IbOW402gwDCeDjmZXRw
	8iRIJY/iCxvpdnf7F5gprKRo/JUAgjF9Hyi7iZCuH8eCON65pA5wRo+ksErpJQEvb16b8Q
X-Received: by 2002:a05:6a00:4b4d:b0:82c:6b46:271d with SMTP id d2e1a72fcca58-82f8c93a983mr25059638b3a.48.1776881499881;
        Wed, 22 Apr 2026 11:11:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82f8e965820sm1300536b3a.2.2026.04.22.11.11.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2026 11:11:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b9c0bdea9faso516181466b.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776881498; x=1777486298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qT0jxCrA040kI6196iRS21pG9IoWaBGboEW0YzCmftM=;
        b=eKbZLDwtM0Gh6PNgEkGY++pRATZTGuobmBYetM37xcBomfbYLRvhs/0Vz5tbOBBAYz
         Z6oc+DuHbauKI490cELkQ+vowMy4JgMEHS1RoU8Kah7iFVErpWG+U9ZY1kUWIfmntc9N
         YIwEPP+daEmhxxSygIIHCAPoaUv+3PuSfKzx0=
X-Forwarded-Encrypted: i=1; AFNElJ9u+zh4Xy/80ibH5XbkGoQKLqg9f3dt/b/hmMNCwW0nSpb/2kEn9gvdjDU1r0KO6uo9A+RXzVA=@vger.kernel.org
X-Received: by 2002:a17:906:4796:b0:b88:5158:d10e with SMTP id a640c23a62f3a-ba41965503dmr1161248666b.21.1776881497604;
        Wed, 22 Apr 2026 11:11:37 -0700 (PDT)
X-Received: by 2002:a17:906:4796:b0:b88:5158:d10e with SMTP id
 a640c23a62f3a-ba41965503dmr1161246166b.21.1776881497061; Wed, 22 Apr 2026
 11:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418023438.1597876-2-vikas.gupta@broadcom.com> <20260422170641.846322-1-horms@kernel.org>
In-Reply-To: <20260422170641.846322-1-horms@kernel.org>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Wed, 22 Apr 2026 23:41:21 +0530
X-Gm-Features: AQROBzDnaG_f7LjGqV4O4XYJt2CQwthoIZg5O70Ixhb8MZ7t2ohvn841oELygkg
Message-ID: <CAHLZf_tF53V+uTk8z3VKdGywEnmDcErFohWMQZbyYOWwqJ_M4Q@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] bnge: fix initial HWRM sequence
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vsrama-krishna.nemani@broadcom.com, 
	bhargava.marreddy@broadcom.com, rajashekar.hudumula@broadcom.com, 
	ajit.khaparde@broadcom.com, dharmender.garg@broadcom.com, 
	rahul-rg.gupta@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007f4d7c06501076f3"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280530-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 9E72E449A18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000007f4d7c06501076f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,
We have discussed the AI review comments on the behaviour of
bnge_alloc_ctx_mem().
Please review the explanation and let me know if it does not provide
sufficient clarity.

The discussion on v2 is available at:
https://lore.kernel.org/netdev/CAHLZf_uARgZzoTPnnPjxRu5AGeHEOw3yyTEbNHYP3br=
fwuW0Sw@mail.gmail.com/
https://lore.kernel.org/netdev/CAHLZf_voEPTrfkuO6pJcchaQaOqJin8m7j-+hwMrjJc=
GFmJv0A@mail.gmail.com/

Thanks,
Vikas

On Wed, Apr 22, 2026 at 10:36=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> bnge: fix initial HWRM sequence
>
> Firmware may not advertize correct resources if backing store is not
> enabled before resource information is queried.
> Fix the initial sequence of HWRMs so that driver gets capabilities
> and resource information correctly.
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/n=
et/ethernet/broadcom/bnge/bnge_core.c
> > index 1c14c5fe8d613..68b74eb2c3a29 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
> [ ... ]
> > @@ -133,23 +140,28 @@ static int bnge_fw_register_dev(struct bnge_dev *=
bd)
> >
> >       bnge_hwrm_fw_set_time(bd);
> >
> > -     rc =3D  bnge_hwrm_func_drv_rgtr(bd);
> > +     /* Get the resources and configuration from firmware */
> > +     rc =3D bnge_func_qcaps(bd);
> >       if (rc) {
> > -             dev_err(bd->dev, "Failed to rgtr with firmware rc: %d\n",=
 rc);
> > +             dev_err(bd->dev, "Failed querying caps rc: %d\n", rc);
> >               return rc;
> >       }
> >
> >       rc =3D bnge_alloc_ctx_mem(bd);
> >       if (rc) {
> >               dev_err(bd->dev, "Failed to allocate ctx mem rc: %d\n", r=
c);
> > -             goto err_func_unrgtr;
> > +             goto err_free_ctx_mem;
> >       }
> >
> > -     /* Get the resources and configuration from firmware */
> > -     rc =3D bnge_func_qcaps(bd);
> > +     rc =3D bnge_hwrm_func_drv_rgtr(bd);
> >       if (rc) {
> > -             dev_err(bd->dev, "Failed initial configuration rc: %d\n",=
 rc);
> > -             rc =3D -ENODEV;
> > +             dev_err(bd->dev, "Failed to rgtr with firmware rc: %d\n",=
 rc);
> > +             goto err_free_ctx_mem;
>
> Does this regression leave the hardware with active DMA pointers to freed
> memory?
>
> If bnge_alloc_ctx_mem() allocates host DMA memory and passes the addresse=
s
> to the firmware via bnge_hwrm_func_backing_store(), and then
> bnge_hwrm_func_drv_rgtr() fails, the code jumps directly to err_free_ctx_=
mem.
>
> > +     }
> > +
> > +     rc =3D bnge_func_qrcaps_qcfg(bd);
> > +     if (rc) {
> > +             dev_err(bd->dev, "Failed querying resources rc: %d\n", rc=
);
> >               goto err_func_unrgtr;
> >       }
> >
> > @@ -158,7 +170,9 @@ static int bnge_fw_register_dev(struct bnge_dev *bd=
)
> >       return 0;
> >
> >  err_func_unrgtr:
> > -     bnge_fw_unregister_dev(bd);
> > +     bnge_hwrm_func_drv_unrgtr(bd);
> > +err_free_ctx_mem:
> > +     bnge_free_ctx_mem(bd);
>
> Since the err_func_unrgtr label is bypassed, is the firmware ever told to
> drop the backing store configuration before the host frees the memory in
> bnge_free_ctx_mem()?
>
> In the pre-patch sequence, the driver was registered first, so any failur=
e
> subsequently triggered a driver unregister, which implicitly told the
> firmware to drop the backing store configuration. With the new order, doe=
s
> the firmware maintain active DMA pointers to the freed host memory?

--0000000000007f4d7c06501076f3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVVQYJKoZIhvcNAQcCoIIVRjCCFUICAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLCMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGizCCBHOg
AwIBAgIMbfHmsZjcB+HruaVKMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDMzNFoXDTI3MDYyMTEzNDMzNFowgdQxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEOMAwGA1UEBBMFR3VwdGExDjAMBgNVBCoTBVZpa2FzMRYwFAYDVQQKEw1CUk9BRENPTSBJ
TkMuMSEwHwYDVQQDDBh2aWthcy5ndXB0YUBicm9hZGNvbS5jb20xJzAlBgkqhkiG9w0BCQEWGHZp
a2FzLmd1cHRhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANg8
iuIMIJTRhFElF5kiGA/iibojGqPcfDgZCPyMvuucV7LpWj77dMx05lOtPOr5ol6QoQf3DzLny2Fm
ZKzsTDzWEhPsCM5DcbMg/B7eD9n+rBWHxsk+yKJKdkLpkpTKdxxTd1Y5Ln+k5KCTjxlCUQQ7Q2Zz
qYU8bfRq5ZMwUVJD3NZCqEKbEIgSX2vXFS61zdPwnLyHyaC/erAWmgHLu4kzpk/V10NcnUjX9FYK
f/Ggi9MeMNG20gEIUbCg3RgYf89YLXUJDOuoz/Yajw/VuiVlwS81wF44DmJhAVcGzrI00uydpksG
oQY2qVlhYsvNTqU2V/uaBrKQnyM0PkU140cCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYdmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQI6pBWVwIN47wGrC1m7lYfqN94QjAN
BgkqhkiG9w0BAQsFAAOCAgEAOdSnSEyuTvTtsnmEilB0JfgRKx1MM7kNdv0pfWcINJhssfHD8Fc5
wm+JzenYR9yJAkntX0Lr9yv+OG0Jqhvy7u9gKljfI4jXO4qxZ2jf1YvI+fDK29/NV3JAQuipT3Vs
IxBI73CQO11VwMePOTsUNM1s+9cWT5zLuqOEEu+95jRo5KEtH1/4nahrToLU1Y+flylsBaAUhB72
KoBBzdewa+psa32lY8X23AWDoczIlUBmPt0hmApBvHOUCYszSiBu4/VhVDuq2iMBtnYAj2j9Q7Ct
pZHPj6fQv247S9dTDDym05r8arHAsUw7B29KvPfxeaqexL4gwQQjIsfdZeh88XYLXA+mvEej6OlO
YO3546G7bczFxIjO6V9RrvYEeAb+n7udXYymuIm02XtxIkr/Uk0gRuFoOpG2Dw1OH8xsOUER1+16
qGb2QKMgaKL/IIM3gXAuCxNVBOT+Fj/wh5hw7MFvTTXPFA8IKusoHZYpxdrr9xjoJ/wt6j4/E6K4
IO/WuSc4nM6kshiwIu5c6r97213ZtJFOrjoITiBIYFP0WQsTsEbWvaBX/7daT5IVr9rvCOCk2JA8
bOWwP4OYXCKJY5nZOntb0ECSI7RM0kGelGY4MAD42+OBWHxKU1Qvt5WK4kIXdKpdFp9Drv17PyCU
dR4AvAJyWnkqZyi5QuRg/hMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEII+eh+2a15mK
9VQy6v5xamfZMyRDJxYsNLyi7PRmDF9JMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQyMjE4MTEzOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAEvFssVXwDaF3R5gPnesupw03uujYHE0QX6WQmPvL+lbrAHI
jIYtlex+nSrsu9qn3GlXf2VDQEVXu10y8dluuQvVgOaN5TSlX+c7WewURJjbn0FeLBJdq2ZXVmfp
NGUE1lL5Z+nEus2S55nQsLBCf9DGCVGR0OsFFRT32NaLLTz+5fbfB5Dr4BZ/h3Q3dAO+NuXiu4ls
Wi/a01EAqxSYA4rubKROtKK2IRDrYJKh7wafuSnMO9KF7ORfWhYCSGQRHRMgCqCTj10Ku80XRdjk
dOfJKvoPPYqIwmUMr7HyyMrB/avItSqpoyhd0++jo/ItT+sGkez7hutF0z44D42PrG0=
--0000000000007f4d7c06501076f3--

