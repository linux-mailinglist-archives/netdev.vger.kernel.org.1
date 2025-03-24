Return-Path: <netdev+bounces-177102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C5FA6DDBF
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C9616AC80
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F404D25E45A;
	Mon, 24 Mar 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NU+NgxxL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322FB25EF8E
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828673; cv=none; b=L30W5vMi8014ykXTc+9daiz9Qwodj+Uyg5AkRCYKUsyNiAi5qsNoEIYZ5/MVWC+xVu2SGh/Pu8aEUCTSVIiF4m6h5Jj0R8x5FyFliFoMNSPtG4N15CerRxN+lwDXK6j3KHOi/PbvK4HSDl5aRy5FD+y/hbCx5VlgVa2XYziupNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828673; c=relaxed/simple;
	bh=U+psBP5MNEUMkO3yW8MWBYHandIg+hGRs1+aKgXoCTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqyCh4yMbhxmrea+NlzxiM6CW/bgRLXvtxmkH0WN4AStSyOVc7AKdtmstYBwlcOCoGrVbGb3fRtcwiyAowzF+OzlTH6J0QUo9JIdzdAfXR82jZBClCcFMmOQw6YYZuMaL7KlhVLklOqMEcF0gKuYKcZ7LrW1WKucRXGQP5UCYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NU+NgxxL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224191d92e4so85354545ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742828671; x=1743433471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nsWSzFSgzFUGqnS2HAk2LiFAzLMIzrNuok5qPb2hqv0=;
        b=NU+NgxxLYLmdExGst0FNWxC/dxPZQwJR4r+llsXZK+xVNmkPUnYIbsaNIqopCRBE9Z
         i5SZi9tPiOzQOGz9yLT14LSlxGcPMS/Bdjnf2YOcWU99wRbYdNkGlvKVhg8V/GT4D6rP
         LdRB/P7rAEQazdZcam52syXCRdmhDeZvcPN8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828671; x=1743433471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsWSzFSgzFUGqnS2HAk2LiFAzLMIzrNuok5qPb2hqv0=;
        b=CXouH8yhs0vjrDHvKuaLE5n2rfYS4JaBog9hlpDcYmmx4fccmj+AWLMM6MxU7zSCiX
         NUN1/fIsocT4Oif6Kz3TjkuyDvN0Cb0C/srtfJzk0XYS3QMvRhIAJhAWMh5HlpbpaK0S
         qUhMdYpwcGSSWNbVB8HGvR6mSUt4mY3G97ZEPLYHZXc5eDmi0Dg9+mNJDqVAyjIL54zn
         Ui3vAWZMzLJev6yhZEYDaGPIKAHQ6oHgORG2OdIzQ6jxfJsfuHlcWEk9tEIqbUw4zd3o
         CczQyF7o4WqcVOaOii9HIGIPO8nh98wjZjNM8IiIYU1wbsaOQtuRYSc2gkHVC4+D5quV
         BnVA==
X-Forwarded-Encrypted: i=1; AJvYcCVwAjx5tzbb3iPrlyRa9nXyecjdco5DJOwjqoYnhKZ3+aLJRmozlNKdzKOZa59wtV04SFXIHW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwDefMFQkB0DF6r4NAZw9y9XMGMKis01UabHOFq10MA/15Rq/S
	3GVw+ddFEFlxGpfZ1+rj037ufqta3C3jjsPi5D+1EUUMaqihp8oqqztpv9gyWAORHBA/AT/SKml
	z2Erkw4Yk30s3M6Vbu0yql5u+BlFuO4Lz0LrLZXVIxoeFlqo=
X-Gm-Gg: ASbGnctZIYCJGfHmjyd5i4Ej+NAhvAi1JhO1KCo6p8Dwmi3stBwvzhkhaG8jGolGehM
	whDrz51fdnsVptR4ghygp86HPctHxfPALrOT6qVSCjs/vXW2+XaCWcqPfl03nFQGj7etS2QVZm9
	pf/sTslQCjP71eghZebGyNWpS4S85Ksie7+Jd2/Jv6+nTxiS1tl5IMwlBBujg=
X-Google-Smtp-Source: AGHT+IFEdu+Wy39sOvTIwFNXKUrPdctGYkCVfZDy5K57Q/jLUU68otOrTk7uw5Xek/I7hYZAQTNuVXsi5n2S2txBL1U=
X-Received: by 2002:a17:902:cccb:b0:224:18bb:44c2 with SMTP id
 d9443c01a7336-22780c7e14dmr188814335ad.6.1742828671248; Mon, 24 Mar 2025
 08:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
 <8f128d86-a39c-4699-800a-67084671e853@intel.com> <CAGtf3iaO+Q=He7xyCCfzfPQDH_dHYYG1rHbpaUe-oBo90JBtjA@mail.gmail.com>
 <CACKFLinG2s5HVisa7YoWAZByty0AyCqO-gixAE8FSwVHKK8cjQ@mail.gmail.com>
In-Reply-To: <CACKFLinG2s5HVisa7YoWAZByty0AyCqO-gixAE8FSwVHKK8cjQ@mail.gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 24 Mar 2025 20:34:18 +0530
X-Gm-Features: AQ5f1Jo-Faer9iRE0hxe3x54datJgP0gVILB9H8u-4UQFtZP6qW5nFmXvO9Xu9A
Message-ID: <CALs4sv1H=rS96Jq_4i=S0kL57uR6v-sEKbZcqm2VgY6UXbVeMA@mail.gmail.com>
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Michael Chan <michael.chan@broadcom.com>
Cc: Kamil Zaripov <zaripov-kamil@avride.ai>, Jacob Keller <jacob.e.keller@intel.com>, 
	Linux Netdev List <netdev@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e33fe9063117ebea"

--000000000000e33fe9063117ebea
Content-Type: multipart/alternative; boundary="000000000000dad400063117eb88"

--000000000000dad400063117eb88
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Mar, 2025, 11:03=E2=80=AFpm Michael Chan, <michael.chan@broadcom=
.com>
wrote:

> On Fri, Mar 21, 2025 at 8:17=E2=80=AFAM Kamil Zaripov <zaripov-kamil@avri=
de.ai>
> wrote:
> >
> > > That depends. If it has only one underlying clock, but each PF has it=
s
> > > own register space, it may functionally be independent clocks in
> > > practice. I don't know the bnxt_en driver or hardware well enough to
> > > know if that is the case.
> >
> > > If it really is one clock with one set of registers to control it, th=
en
> > > it should only expose one PHC. This may be tricky depending on the
> > > driver design. (See ice as an example where we've had a lot of
> > > challenges in this space because of the multiple PFs)
> >
> > I can only guess, from looking at the __bnxt_hwrm_ptp_qcfg function,
> > that it depends on hardware and/or firmware (see
> >
> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/broa=
dcom/bnxt/bnxt.c#L9427-L9431
> ).
> > I hope that broadcom folks can clarify this.
> >
>
> It is one physical PHC per chip.  Each function has access to the
> shared PHC.   It won't work properly when multiple functions try to
> adjust the PHC independently.  That's why we use the non-RTC mode when
> the PHC is shared in multi-function mode.  Pavan can add more details
> on this.
>

Yes, that's correct. It's one PHC shared across functions. The way we
handle multiple
functions accessing the shared PHC is by firmware allowing only one
function to adjust
the frequency. All the other functions' adjustments are ignored. However,
needless to say,
they all still receive the latest timestamps. As I recall, this event
design was an earlier
version of our multi host support implementation where the rollover was
being tracked in
the firmware.

The latest driver handles the rollover on its own and we don't need the
firmware to tell us.
I checked with the firmware team and I gather that the version you are
using is very old.
Firmware version 230.x onwards, you should not receive this event for
rollovers.
Is it possible for you to update the firmware? Do you have access to a more
recent (230+) firmware?

--000000000000dad400063117eb88
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"ltr"><div dir=3D"auto"><div><br><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 21 Mar, 202=
5, 11:03=E2=80=AFpm Michael Chan, &lt;<a href=3D"mailto:michael.chan@broadc=
om.com" target=3D"_blank" rel=3D"noreferrer">michael.chan@broadcom.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, Mar 21, 2025 at =
8:17=E2=80=AFAM Kamil Zaripov &lt;<a href=3D"mailto:zaripov-kamil@avride.ai=
" rel=3D"noreferrer noreferrer" target=3D"_blank">zaripov-kamil@avride.ai</=
a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; That depends. If it has only one underlying clock, but each PF ha=
s its<br>
&gt; &gt; own register space, it may functionally be independent clocks in<=
br>
&gt; &gt; practice. I don&#39;t know the bnxt_en driver or hardware well en=
ough to<br>
&gt; &gt; know if that is the case.<br>
&gt;<br>
&gt; &gt; If it really is one clock with one set of registers to control it=
, then<br>
&gt; &gt; it should only expose one PHC. This may be tricky depending on th=
e<br>
&gt; &gt; driver design. (See ice as an example where we&#39;ve had a lot o=
f<br>
&gt; &gt; challenges in this space because of the multiple PFs)<br>
&gt;<br>
&gt; I can only guess, from looking at the __bnxt_hwrm_ptp_qcfg function,<b=
r>
&gt; that it depends on hardware and/or firmware (see<br>
&gt; <a href=3D"https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net=
/ethernet/broadcom/bnxt/bnxt.c#L9427-L9431" rel=3D"noreferrer noreferrer no=
referrer" target=3D"_blank">https://elixir.bootlin.com/linux/v6.13.7/source=
/drivers/net/ethernet/broadcom/bnxt/bnxt.c#L9427-L9431</a>).<br>
&gt; I hope that broadcom folks can clarify this.<br>
&gt;<br>
<br>
It is one physical PHC per chip.=C2=A0 Each function has access to the<br>
shared PHC.=C2=A0 =C2=A0It won&#39;t work properly when multiple functions =
try to<br>
adjust the PHC independently.=C2=A0 That&#39;s why we use the non-RTC mode =
when<br>
the PHC is shared in multi-function mode.=C2=A0 Pavan can add more details<=
br>
on this.<br></blockquote><div>=C2=A0</div></div></div><div dir=3D"auto"><di=
v dir=3D"auto">Yes, that&#39;s correct. It&#39;s one PHC shared across func=
tions. The way we handle multiple</div><div dir=3D"auto">functions accessin=
g the shared PHC is by firmware allowing only one function to adjust</div><=
div dir=3D"auto">the frequency. All the other functions&#39; adjustments ar=
e ignored. However, needless to say,</div><div dir=3D"auto">they all still =
receive the latest timestamps. As I recall, this event design was an earlie=
r</div><div dir=3D"auto">version of our multi host support implementation w=
here the rollover was being tracked in</div><div dir=3D"auto">the firmware.=
=C2=A0</div><div><br></div><div>The latest driver handles the rollover on i=
ts own and we don&#39;t need the firmware to tell us.</div><div>I checked w=
ith the firmware team and I gather that the version you are using is very o=
ld.=C2=A0</div><div>Firmware version 230.x onwards, you should not receive =
this event for rollovers.</div><div>Is it possible for you to update the fi=
rmware? Do you have access to a more recent (230+) firmware?</div><div><br>=
</div></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
</blockquote></div></div></div>
</div></div>

--000000000000dad400063117eb88--

--000000000000e33fe9063117ebea
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
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIMn7g8YN022QjLO/7RCFwMbmovO97IVh
BEXSKcoqFEwyMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMy
NDE1MDQzMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAIPy5nkUoua1NSzVjYpnssU/9lDcINA/Z2RaB6nYXSlFZw2eB63dCe9wDKhxL8ZK4vuB
u/SpRN/uYHXgCeeeYkPzxxSb6PCSLyyo4KWKFhYuXEPW4sHy5eHrPnvBsAzRIDwMPLhPoZiRw+t/
TRhWvW83fRQh6H4aBdGJnZlpFTq5x5ZvOBB2MqHkTf8DF8n4tg7mEA6idVowtucn+00B6RB0uNqy
bfoS6mChMC2lIf/QngZlicKjTH/+xRK251XnqZE0vJHfnPW4UbPoWNzhOKKJTObBMzm4YeJdR62K
o/5qiH3ghURjG0WDfLOSy9j2nkGISi5l40ANjKavEmrfzRs=
--000000000000e33fe9063117ebea--

