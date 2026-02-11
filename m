Return-Path: <netdev+bounces-258198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QjGRC30QjGlvfwAAu9opvQ
	(envelope-from <netdev+bounces-258198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 06:15:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7251F1214E9
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 06:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA0E7301FFA1
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5540D17B425;
	Wed, 11 Feb 2026 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZdGt7jz5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F83EBF01
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 05:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770786938; cv=pass; b=jYzd17Whv1AK1tcdcO8Moh1uzskE8cbFjemhwt4edI8Cwqkb6jFoMDagFMRTF1NygmjblRhTDqFlHZFZ0Sgf5INzpQ3GDNlKcUEM1jpJWzNVhQUP0lrGxOCCs4+8mOnB36WLKzHz+Jhg1aL/RyPOmt3JjMmb1/4wlMHkHtg50oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770786938; c=relaxed/simple;
	bh=n3mFa2/MDVnvc4lnCcao34TMTvdGsRGdlhmJddtAd/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMoQAWhGNrRgcmGvR6RLE710RWqg6zC/MNh37o4ginOIFyVrcSSXkC2itJBvkKAG6AZ51mQLT6I+zoZINdxzbuMbxmuEWM8M7Wp9KVC0doe/+LdjfTMbUjpm4ihVJW7cdv0ZiGRsCJDSnSgJk3pz/ZkXLweAywZhvAnyIqFKe7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZdGt7jz5; arc=pass smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-7950881727cso11016057b3.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 21:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770786936; x=1771391736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzQ0PeSYmoSvicgW8lG3ShGmQxNtV8Z5jP/rUl0CxN8=;
        b=N7/7lz1sAPv647dYi4bhslzwBQDSAWfBKHZPJ74eOC8shRSXtnivMjFsX/R3YPScDI
         T+moMdFPo7V+xhJclLysI9800RADTiHE7E9YXSm6hzOyV3JAOzPUJoUr5enQWEHl8nDF
         dyu9JhFUXoBiimRV50EFimduPqmsPMEo1qNGvo6MzhW+CaJWpzJTIUsV8hLIgOYQn7U2
         rfks1cqNhLtrexVx6rcs6FCx0u9Wc/Y14SxDTeoEKdgKQCgqaD2yupRoyM+2oyHeV3Cy
         TZ9laskRXywj4wQ6kX2BECjvQyMnDTH5J00nE2L1yFGZIR9d51lyqgsS6k+GxcBGWxWa
         Q6zw==
X-Forwarded-Encrypted: i=2; AJvYcCX5TTCK2ETlXAusYu2N/VwDqJIAx2qbVLI+MUnzNNE+qtezHB4iDpQXAv5BEwgOv2mGG8WkMeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyre1cRhdBirf6T5cCv3Y1UveoGE7M1y2ujWQw5Rfjv2Hc1/0TQ
	oB29NLbWXV6XM7rJLhILU2AV6gY22CN17O948bUUlfiENMgKDIw+/LPRjxvC4Ql6kEAkgHRfzQP
	oUWXD5AhEzCeIxhfQRxhmCZ1i+/pOfKiKGFpObGxIynzyTFBQ7u3TEBXRJGQapLr07+0bqnDvpr
	lkP9z8OMhb9FylbtiNxQlHkm1DGZVMA7ehgdszqwVsLQQZN5tczYvF5D01xMaFvz+11kBWYWjnt
	kvIPZct0K4=
X-Gm-Gg: AZuq6aKJD5PXWvD/EpfW4Qq4OVjx4m/attMKztnr8RWgIL8NXtbeLSW5whyctYOqlek
	VkW0rLK13sSo7sQspVVjZHo3edvJwxRBi14ossjc4/MN2jj1EueyQtlWp6O9xEZ2a5SV2gC19UX
	FNyu/NaCy/LLeYtSuUBOK/l5JGeDHZoEMRCiH/wB3A0LpuonfGm9P1aSwAUfrm6+t7qcWkJVKOF
	CLYntbvHiFjHOC5jAi1LShRLIkbQB7OKcvrxGgwt41au3lwjvgrjODAoIXwkMJz++0ZgJuJcTFk
	4PYJSATlyhYIX0uU72I6KVqr80KvLg7fkIoqvtbkfPjeREvE67NGkY3Wepd/o3EPH7f5cLEE3G6
	fB6f9zdCbjJ1LDuow+DrZDsh1+eM1Qx+yfhX3tbYgju0/o74J9k3gs/aGPnHOhIIV0LTtmIcKGt
	haMgWPVSBKPVg36+/JRgoFudnsAs4TLSWWFJko/L8CXYT2PXOPP/Fp8NDVZCE=
X-Received: by 2002:a05:690c:39d:b0:794:cf56:5bf7 with SMTP id 00721157ae682-7952ab2482amr332655907b3.33.1770786935759;
        Tue, 10 Feb 2026 21:15:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7966c232917sm698147b3.17.2026.02.10.21.15.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 21:15:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c0eb08ceso4257593a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 21:15:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770786934; cv=none;
        d=google.com; s=arc-20240605;
        b=WQoREEIFIWxFKRUrfHM5NVJLxSw+IVL+p67yFiG+7QTpHKxZI4zoBIl07aoMY1/999
         BcVC/euOcwfMnIc0IeAgKE8AGtFzXcgPzM5iTKNydtKVRo1XepECrcn1p2srs1bOUDHt
         bOgnCkRJc7r6tnxxo+VXW4PZ5IdxnOLjksyYR54i3PGkxhkJOqhDtwwKfgTnek53RclU
         Ux3AatkczrJvOB5CR/VDnnrBooQ3a2TpM1V6NZ7O/hXJGxbBHwH5aUJxRf2QLx4GDDgn
         OY1MumSMm8IYg7Awb+PexoKtTdUyUNvzRpa1rJd9BgbYGDhwXmhSrc2lDsAZRi95LlBp
         ZZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FzQ0PeSYmoSvicgW8lG3ShGmQxNtV8Z5jP/rUl0CxN8=;
        fh=ped4xErdwVEUHS+LESedu/THCcEyCXuIKNt7oL5N0hQ=;
        b=lqSPoW3VXZ/K/xpJ/5+gp7zdsWDSH6hOrhqxG331CudTxzf95epnLjNx7ySGodOHhB
         XhybPwlGv4Ug8YIdnFjuFT+mpM0Yyc9TA/ar/pwtWnYmtYFx3p2mJ3KkNAzXUBgdxRaj
         4pAtJb/NLNAoeZGg1NE9dqEGivC5yXG0+MOU0kqvSa44NRc5GdWwsWxac5qIWjGpoADA
         AwbvKg1g43jt04lIKvc3PFihFc0beo6Uz/P7RMnzNtxV6hvnEw143IQxLoI7lLJD/DR1
         zcAcBrPBDMl1FiLv1jQGP/60wtXpn12Mx7xJmqDaBu56ocjp1ox+4N6pmyx08QY/TIAl
         oidg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770786934; x=1771391734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FzQ0PeSYmoSvicgW8lG3ShGmQxNtV8Z5jP/rUl0CxN8=;
        b=ZdGt7jz5wMp9OrwN5nnEgFAwrOVP3vXbyx12WSJpS2BEqVxm5mkTC91LLo1Ygr5wJk
         h5zM5BAsuUynGk24g4f1gaxcXOUZuCPG7vKqpHKeVJn77YFkvDuVuBo8D8kPnAHpkZtd
         nxNzp7NYNc8UhbejscIoMtNf2zosdteUriBhQ=
X-Forwarded-Encrypted: i=1; AJvYcCXotU9jIICq5i5MeH1ziG4YfnjG0D2bZYtBsoBuQW/ShYgaB5WY4cEF/WezUMyXeHjQrdFlo6w=@vger.kernel.org
X-Received: by 2002:a17:90b:3809:b0:34a:b8fc:f1d8 with SMTP id 98e67ed59e1d1-354b3e7644bmr16290300a91.37.1770786934295;
        Tue, 10 Feb 2026 21:15:34 -0800 (PST)
X-Received: by 2002:a17:90b:3809:b0:34a:b8fc:f1d8 with SMTP id
 98e67ed59e1d1-354b3e7644bmr16290277a91.37.1770786933958; Tue, 10 Feb 2026
 21:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
 <20260206052930.1882740-5-michael.chan@broadcom.com> <aYY2sak4adKOGRSv@devvm11784.nha0.facebook.com>
 <CALs4sv1Z+oWNT5myaEr=LyZsLCGUYfOKAet_bc+fmw7g8PbaxA@mail.gmail.com>
 <20260210174627.2360a03c@kernel.org> <CALs4sv3hca2N=+w9A81ZLMz9QCHqA7OzGFOzKGswd2sy+9zt7w@mail.gmail.com>
 <20260210201706.1da13881@kernel.org>
In-Reply-To: <20260210201706.1da13881@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 11 Feb 2026 10:45:22 +0530
X-Gm-Features: AZwV_QhxzhoQ83TvHXq8PA6F9Hp8XlnJJzKo-6Ma-tG2-HEM9uJfGCQN_C_bTUE
Message-ID: <CALs4sv09qKxtHri6ydEh9QGAcZ=aET3ttkZue88O+X44BA-N0Q@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Michael Chan <michael.chan@broadcom.com>, 
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000350db1064a8576b3"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258198-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7251F1214E9
X-Rspamd-Action: no action

--000000000000350db1064a8576b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 9:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Feb 2026 09:28:22 +0530 Pavan Chebbi wrote:
> > On Wed, Feb 11, 2026 at 7:16=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > > I checked and tried using the cmd() and it indeed eliminates a lot =
of
> > > > lines here. But the test itself becomes a little unreliable.
> > > > I often see TimeoutError: [Errno Wait for file contents failed]
> > > > /sys/class/net/ens2f0np0/carrier from the wait_file (Jakub asked me=
 to
> > > > use wait_file)
> > >
> > > Does the link take more than the default 5 sec to come up?
> > > wait_file() has a deadline param that should let us wait longer
> >
> > I did try with increased deadline. But I don't think it's helping.
>
> If you check the carrier manually in a second terminal while it's
> running -- do you see it go to 1? The helper keeps the file open

Thanks for the nudge. I think I get the real issue now. It's not the
cmd() but ifup.exec()
I am using :
ifup =3D defer(ip, f"link set dev {cfg.ifname} up")
and later
ifup.exec()

I see that exec() takes unusually long time for carrier to go to 1.
Upto 20s and sometimes still fails.
Same with both direct exec or deferred. And this explains why I cannot
ping for long time after suite exists. Thats because I rely on defer()
to bring the interface up after bnxt exits with carrier 0 for the
second test.
If replace the exec with direct call to ip(f"link set dev {cfg.ifname}
up") I see it works reliably.

<-->

>
> cmd() doesn't do any magic, it basically does:
>
>         proc =3D subprocess.Popen(comm, shell=3Dshell,
>                                 stdout=3Dsubprocess.PIPE, stderr=3Dsubpro=
cess.PIPE,
>                                 pass_fds=3Dpass_fds, env=3Denv)
>         proc.communicate(timeout)
>
> So pretty much the same code as your subprocess.run().
>
> It has support for communicating with extra fds to

Yes, sorry, this was a red herring for me

--000000000000350db1064a8576b3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAyKtpU
cpAE3Yfu9O9kwi2Y2fE1inoxOJTYqHhmDdnamjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMTEwNTE1MzRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA3Qi0Jo4DxR9KQ8fszPJWY7TS6hmjriXqpV02HpHe0
sx6g1PWAELee9FoE/giAkVoDUTED7Wa4dJwG5acKvg96vq/QzmQzPnY15uWq/3f7hn4GTZHd9jfM
7miPkZxLyu3IW0HSzNuNyo0phQkgkdWVrJ6QqhZYSw7IWvJrKo0ToQa6qJhHDyhYJwJ2RTJ/42u8
SBF6dW6QsnKl+CJntaMppqbl6GngqW3CUoiGx6S4U0I1RL5+322taiQ9j/d1mEgL7ObggJcXebHI
10Mznsm0XrLMWroGXSOMa2FAB7mWhj/esWsd9GAHQeSF2TPg2wu1MhmawG56yJxrjUeVo3yn
--000000000000350db1064a8576b3--

