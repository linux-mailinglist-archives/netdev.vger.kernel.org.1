Return-Path: <netdev+bounces-258211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NOFZAd42jGlwjQAAu9opvQ
	(envelope-from <netdev+bounces-258211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:59:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84439121FD2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B031D30058DD
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF79B2882D0;
	Wed, 11 Feb 2026 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VcMAKwKA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F1221FB4
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770796763; cv=pass; b=N7cKU0aDT1/OrfhTSaQurOibUrdTvC72NblpMV1Zna8dm1wk9RYiE+iRRh1jLUIUC/FyMqRt8ufZcD0Uckd3fajg8hUG9mqMFxxgJs+JfOO1WPzQu9PsAwavbjVBr8i+5wWT+gaTNfutzAMLvIUnTmBkBvCqha4sdBkC9qAI16Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770796763; c=relaxed/simple;
	bh=FkOPT5AYOEReaXcKEnRbrmRkZxHFuu4Dcb+uA2633Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHlZSYwDiaLxhtidWc/1NVqmnIgh5RkrEo/9hsmQJ4POj9TVGw0zDyvVi9UnpYO1qaa714ZgYuvn8thNe7U8P887yI759SV9K2S2FDY7UC57/JNCrtCxaVRtdvpKCxS5tHC5M1svffA6UrY44gRhzIvJXuEKGp/BfBHgwj11GQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VcMAKwKA; arc=pass smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-35621aa8c7fso2541570a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 23:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770796762; x=1771401562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2yGmjZr94OApnSBrnDbSsPaXrSSmcAkkqAbPLCipb4=;
        b=QAq4Yc/TArhOwGHQtTOJQ0vC2ZwRAdBS0gh8pmIwyom6ZSwQQKuPbKgIRI3rObVtNX
         6UJmZuDThGiEnJkIm3tUwhpW9GcqSK9bw25JI2R5LfHltolpCPuX6zqgUPo1XkUuNEFY
         2cYDeRHxu0aqJvZxXTWpOpggCuFnT98C9bRci6DxDVUe1NF3KNHBQPauDDX+jCbk9ZzN
         g9JTCfxnIfhs2vJ44rcB6F3sC/Vhpd19Qs5nVim/Jr3RZeZXdlmrg/OO1gbrevfzWCv0
         qmqIEBT1EK27Eb9Eb3aA/c67+OJzYEFO0FCZMbKW+eOTocXlpyoWqsoZjlWq/+MZOrR+
         5fUg==
X-Forwarded-Encrypted: i=2; AJvYcCWVQbj9+qTkrXpTq/nc2c4oXb4qCS8dOnMpPotI4t6KP5Q7o5BMV94K1ipuaxkX+Jl0e2UeSAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0U+8kFTDfl5vjXCfHYFk05dxrFQHB/0RgwBt6fxdbqrm/TxTm
	Vbpz3T4TBLOCbR27I94MtGoi3cFvVPArLtRKKOrb2haXdkMse+x9UW+EtvVJyOMvjRxE/RlHhHK
	v7HR5yQy+jIzv92gXSg3+QaikCur7A6uCEo/1YLSm5bd4V9tMPFR9dmUHcGtAx+hNLz92ezopq2
	WfPM25APt51LqDBxf7mZJfTArz5WlprKKSJZJ2hcz4CN70iQXRC4Xqs9tLaOV5WvFz/r7BjKb/6
	6u048O30vA=
X-Gm-Gg: AZuq6aL+9BiuPmI9LknDu3b05vwe0YraR+S5TsdJvBw/sa6P1uxwlgAb0MStsatbzcF
	v6e0f3s0bC9EdQymgIDqnyxMy06Tt9obzrMGh27azAWSwvW+N/HeVMPeqgSab5IwlB1KCkMPZht
	/bezjVMwh6a68NRLiyE0W+GPYbVcnnhYZ8O3L/9O3ciJLUO6tkTxjcXXg8YTJhRb3878BHKJ4yi
	6mt5DPUpoLwF2D3msHzhV83ws+D1z0okAqeqGv8ScOlq3Q7eRs0Q1lryqsEldrhAxipBeziiDcT
	jYiw/eAwOA6vcs/9xpmK2M/61vaGJKp33QIdtHGzh/SS2VyEaxk1vUs2JegHEpKfz4fyVrkoKSR
	2yvguAg3Zrw9yNn9zx8W2B8pyMlUz5xc5QBj3rV8xJONoZyDyTFg/UEG8Ea3Phq9PqOWG7bvF8F
	ia7d8KtAMq6k4wqqrlnAxvFo2PQpBagqw9y+YjJtywEUlywy1EQBl8QBBCrQ0=
X-Received: by 2002:a17:90b:498d:b0:354:bfb7:db1a with SMTP id 98e67ed59e1d1-3567b0bfa81mr1608175a91.31.1770796761565;
        Tue, 10 Feb 2026 23:59:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3567c48a994sm42498a91.1.2026.02.10.23.59.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 23:59:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354bc535546so4754481a91.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 23:59:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770796760; cv=none;
        d=google.com; s=arc-20240605;
        b=eGLUDTG+Gjak+hoKGkYMZidjEwJrGI2mSv6cV6oNZcWVq3TIfguXnb4peTviDNz6iB
         aOEN05ofEsMlc1DbtYdkfhdao5n+92Fhh3BaRkM14SeFmrxAK6bGoXOtBEHVLPpHUbQ2
         0mZUf0Brlqhhg4WWt+Na2u1dTPYr8yVRlnsquRjG3Lg3pVJD+Ki22vvbZYDXdtUA58Jq
         +ZAzbSdBOpl4zxiLMRUK3N1snNauw0cN21LWL7vgIApj9k+fhPKSMwBadWm8eZM4nY90
         +MR7kSCIxwQr+ctJcluBnzlrlxKMB1NBNXP7fSl4kvCbN/UIK298XXMT2HN1uMUPEcJu
         P6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V2yGmjZr94OApnSBrnDbSsPaXrSSmcAkkqAbPLCipb4=;
        fh=og13MoYgLLdMlXawlN7Hv/wxd/bmH/KuiL2mogXw5QQ=;
        b=YWHCum65QbnE+GO82jrqaq0aZQyYYOWXemy0fOigt6odXNm/fu7yA36eU6W99i/5zx
         Rh+wi3ZTgc3qtRblRd8eTn7TlIXvgj/g8Y1zFQnr346OjEAVZ+q5lSyxDrVBFWMb9Nmx
         MKN6S+kKoUUv+RjDeIAQKylY+Zt6Q+DdNVY1H0RGAJ35Fnn33597xUTAf/0LAKhrTzQN
         RFQTEnZTk9htNs49TbnyiQz+63ITtJ4hkEq7qag88mpMpNEs2GMnan5zZJeRvqMyiDK4
         pngOJjtW4Nv5yjh77cmsj5uHitqTup4bOx2KXw/rP9IgQLPtM/85peBgt6hLNWdBdtXB
         hnPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770796760; x=1771401560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V2yGmjZr94OApnSBrnDbSsPaXrSSmcAkkqAbPLCipb4=;
        b=VcMAKwKA5MWP3lw9eX27kipBmd2WICVRe4uxVHfahIOX0r72JYxTUk7UiDmYvgRw3f
         9GEkmXPwArKhT4PKhp73or0b6TRanjLqFm/zYtoQq/SGoGIWDetBblbUELqYbY844ve0
         HTOfBCrul2unzoJ0T+Z/Sq+qJx64z+JA3gPtM=
X-Forwarded-Encrypted: i=1; AJvYcCU+xl2oSkAJdcX3Bnqg9cX9r/VoJ3/fsHbo6PDKg8ZMz5XGjyPPLN54W945cMfBvQwNQl40xU8=@vger.kernel.org
X-Received: by 2002:a17:90a:ec84:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-3567afb19camr1779548a91.15.1770796759649;
        Tue, 10 Feb 2026 23:59:19 -0800 (PST)
X-Received: by 2002:a17:90a:ec84:b0:32e:64ca:e84e with SMTP id
 98e67ed59e1d1-3567afb19camr1779538a91.15.1770796759300; Tue, 10 Feb 2026
 23:59:19 -0800 (PST)
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
 <20260210201706.1da13881@kernel.org> <CALs4sv09qKxtHri6ydEh9QGAcZ=aET3ttkZue88O+X44BA-N0Q@mail.gmail.com>
In-Reply-To: <CALs4sv09qKxtHri6ydEh9QGAcZ=aET3ttkZue88O+X44BA-N0Q@mail.gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 11 Feb 2026 13:29:06 +0530
X-Gm-Features: AZwV_QhlWXk5ximIUcAWR9fRWkObBO8u2fPCa_UBcJST_ZUf8vRCozyLasxqsSY
Message-ID: <CALs4sv3kG8kTt=VipR-=SzrLvK4ke3qj9Fe8pF=Mo3agd4X1=g@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Michael Chan <michael.chan@broadcom.com>, 
	"David S . Miller" <davem@davemloft.net>, Linux Netdev List <netdev@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Gospodarek <andrew.gospodarek@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d9ca38064a87bfcf"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84439121FD2
X-Rspamd-Action: no action

--000000000000d9ca38064a87bfcf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 10:45=E2=80=AFAM Pavan Chebbi <pavan.chebbi@broadco=
m.com> wrote:
>
> On Wed, Feb 11, 2026 at 9:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 11 Feb 2026 09:28:22 +0530 Pavan Chebbi wrote:
> > > On Wed, Feb 11, 2026 at 7:16=E2=80=AFAM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > > > I checked and tried using the cmd() and it indeed eliminates a lo=
t of
> > > > > lines here. But the test itself becomes a little unreliable.
> > > > > I often see TimeoutError: [Errno Wait for file contents failed]
> > > > > /sys/class/net/ens2f0np0/carrier from the wait_file (Jakub asked =
me to
> > > > > use wait_file)
> > > >
> > > > Does the link take more than the default 5 sec to come up?
> > > > wait_file() has a deadline param that should let us wait longer
> > >
> > > I did try with increased deadline. But I don't think it's helping.
> >
> > If you check the carrier manually in a second terminal while it's
> > running -- do you see it go to 1? The helper keeps the file open
>
> Thanks for the nudge. I think I get the real issue now. It's not the
> cmd() but ifup.exec()
> I am using :
> ifup =3D defer(ip, f"link set dev {cfg.ifname} up")
> and later
> ifup.exec()
>
> I see that exec() takes unusually long time for carrier to go to 1.
> Upto 20s and sometimes still fails.
> Same with both direct exec or deferred. And this explains why I cannot
> ping for long time after suite exists. Thats because I rely on defer()
> to bring the interface up after bnxt exits with carrier 0 for the
> second test.
> If replace the exec with direct call to ip(f"link set dev {cfg.ifname}
> up") I see it works reliably.
>

My experiments are pointing to 'self.cancel()' sometimes taking a lot
of time as part of the exec().
I don't know but I feel the new test code itself should be OK. I can
send a v3 and you can run it once too?

> <-->
>
> >
> > cmd() doesn't do any magic, it basically does:
> >
> >         proc =3D subprocess.Popen(comm, shell=3Dshell,
> >                                 stdout=3Dsubprocess.PIPE, stderr=3Dsubp=
rocess.PIPE,
> >                                 pass_fds=3Dpass_fds, env=3Denv)
> >         proc.communicate(timeout)
> >
> > So pretty much the same code as your subprocess.run().
> >
> > It has support for communicating with extra fds to
>
> Yes, sorry, this was a red herring for me

--000000000000d9ca38064a87bfcf
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAlylTI
fydH5pI7q6qFvqqeuvFbb74huSFM4Gl0PSx1cjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMTEwNzU5MjBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCSaNQrCtmQK8o8I4jWk3mHQT/PNX5k6kaRIpHfQnSX
7KzURk0jPjSt3AdMOqOCisltrnuvm9jlF57xAQRmqGJJ21x/mM9Iauslyu8FStv1wPgBxj6Z34nv
8mATNhZhmmCDpGZGb5yZ0HVkKeJ7xQj4qq6JIPQpTlPs7v+H+oi1KEF8Z8nj66pQDa6gWpVO0fj/
vCLeAs0NaApDpYfXkWSBCTcEF9j+h1tDgnW4tg/tdJxU/OvcPVXc24Kzopq5RHmtXjQxHEB2OedO
aEq9metTDlGnSqGc97vFfg/s/4VRY21V8eoEOfdmkilsBdZbcenobhR0mNnx2cv2se49Vuo3
--000000000000d9ca38064a87bfcf--

