Return-Path: <netdev+bounces-78225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AB08746F5
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 04:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C621C213DC
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 03:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C26AD7;
	Thu,  7 Mar 2024 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A0ezZPUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E5FBE1
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709783459; cv=none; b=W9oJFHkFWC5AZB/XmueO2oHRm3ufDrYiNVp6YTi+vTEA+jqBHSYYR119aYqxKXE3oJihJdexLlmteIXAJzEAJUuZFEWqIWGaNj55LBC6X2jrbSLXRc6qAUL5CwVZ4YPuLMOoFBkS5Qjoc+0Ov7cHVlMQPk9qcapaGFP1lS/U5eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709783459; c=relaxed/simple;
	bh=Dah0vu99XJKLMjph26Tki7e9OKd/FAkK9PjqhJgnlbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpddRZ/uY5p7S14MKdIObVEfLlTTZZnByeruwTbHnJEPk6p1EkkwF2qg6UBhwkDawukL4kuxQKWQ+DDmOHuL73q3I5h8yKvjviRS80vYAjzhyxRn1WlQv9V5HDZns/sh8GoqzS1XgXw3xBN6bo802Z7VUaJSPM9JgQMKt7ZpiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A0ezZPUs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6092a84f4so352045b3a.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 19:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709783457; x=1710388257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dah0vu99XJKLMjph26Tki7e9OKd/FAkK9PjqhJgnlbo=;
        b=A0ezZPUss6ZauhfTFIQwxfT0ekn6CQ3rSGJUWooQelP1quJMhHzucJOJVZR+/LTW9w
         R8mbLD9iuSVObZGqJm23nSF8whYGYW+qo7JsTXrtxmmTvKRw4UvF9MKrTZCHTisbEemD
         roTt/odDKgsLUCWbmt3Go49dHUutBnGEBwcE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709783457; x=1710388257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dah0vu99XJKLMjph26Tki7e9OKd/FAkK9PjqhJgnlbo=;
        b=HdhN742a8W/HekmL9MJ5lEPPAgNHEU61WWxA4RsIyzmXfFAzAw/2lnAzSd9iKQWsk5
         +fY7VDk72bHK/yDtPjs4RcTSpeHI8p7mKJdGE2LYtu7pT0hLhruXzad6JvG26sMi7m4k
         rgaNsjOd5WB/6tNBsuFQwem7jc5pNffRFSHZJLQS91Es9/MfqULXiP+fWRvyOlZpbhMc
         c0+j0qFPLoGtHIr2+6J7Pd9QItHXmyDnmleGS85PT9pOdemiCrYA16iu3V/gxEN/Xdjy
         1mHSUR/aCrRI60uQC0Y9sk+077iBj3MI5IRJzQ2ZKQKF3d+jrA4TradipmIJwHXvC+8i
         f+dA==
X-Forwarded-Encrypted: i=1; AJvYcCWXd0usqOGLgPf41LjnelyKJGrlIOjp4pnGksBcN7izi7rd69og6lTK+ujDNal65oGZ6J7QLPJ+KNB1GI79BeYQuMVApteZ
X-Gm-Message-State: AOJu0YwoJsmPDCfYSVvyu+DBY/PBrEi5CcE3AdfZ0WmBvyWaCkEAcGwZ
	9NDsep3XvTBm5/m3e66m4/GBHkUu7XhVrseflv0F3ocxmgvsczclwaXpojXwPRizoM7NMiIfO3L
	Ml4tjSWgnif/KYSBXmtkUIFxNX7gKTXCLLM6N
X-Google-Smtp-Source: AGHT+IELFgyv/ib/vcWIxiYER0M7HMfnWNuzfQEeQ6Ovj6RFPBa290grxv57yH44/iQGFo2XKkCc0La7SRJXhStpWRA=
X-Received: by 2002:a05:6a20:160e:b0:1a1:e2b:d26f with SMTP id
 l14-20020a056a20160e00b001a10e2bd26fmr7949888pzj.7.1709783456950; Wed, 06 Mar
 2024 19:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229070202.107488-1-michael.chan@broadcom.com>
 <20240229070202.107488-2-michael.chan@broadcom.com> <ZeC61UannrX8sWDk@nanopsycho>
 <20240229093054.0bd96a27@kernel.org> <f1d31561-f5b5-486f-98e4-75ccc2723131@linux.dev>
 <20240229174914.3a9cb61e@kernel.org> <CALs4sv1WSJSxTM=cJ84RLkVjo7S8=xG+dR=FGXmDHUWrj7ZWSw@mail.gmail.com>
 <20240301091857.5f79ba3d@kernel.org>
In-Reply-To: <20240301091857.5f79ba3d@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 7 Mar 2024 09:20:44 +0530
Message-ID: <CALs4sv123NSvtprMEqTxhHVjS6i1ZDgfOrx4z_cEnUyYuQP1Zg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver
 param to set ptp tx timeout
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, 
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew.gospodarek@broadcom.com, 
	richardcochran@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a424ce061309fb76"

--000000000000a424ce061309fb76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 10:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 1 Mar 2024 13:09:30 +0530 Pavan Chebbi wrote:
> > > What I was saying is that in the PTP daemon you don't know whether
> > > the app running is likely to cause delays or not, and how long.
> >
> > As such timeouts are rare but still normal.
>
> Normal, because...? Why do they happen?

Excuse me for the late reply.
In my experience so far, it's primarily because of flow control and
how stressed the underlying HW queue is. (I am sure it's not unique to
our hardware alone)
Hence we wanted to accommodate cases where the expected wait time is
higher than what is default in the driver, for the packets to go out.
But it's disappointing to know that even private devlink params are
discouraged for such purposes.
I'd think that non-generic driver params in devlink serve exactly such
requirements and having such a knob would be useful for an advanced
user.
Not to mention, in my view, such additions to devlink would make it
more popular and would help in its wider adoption.
For now, we will drop this series and try to get back with a different solu=
tion.

>
> > But if you've an environment where you want to have some kind of sync
> > between the application and the NIC, as to when should both conclude
> > that the timestamp is absolutely lost, we need some knob like this.
> > Like you pointed out it's for an informed user who has knowledge of
> > the
>
> Let's start from informing the user why timeout happens.
>
> > workloads/flow control and how (badly) could they affect the TX. Of
> > course the user cannot make an accurate estimation of the exact time
> > out, but he can always experiment with the knob.
> > We are not sure if others need this as well, hence the private devlink
> > parameter. For most common users, the default 1s timeout should serve
> > well.

--000000000000a424ce061309fb76
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA+/4ODdQ1yUONWWyEk//y1+ZusNGIuK
Jq9gEKfBiqo3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMw
NzAzNTA1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA5axp/0Nwlt2MoC9ZCcTVoPRF0tWNxrGuzR0f+KwTiuX6BWk+5
1St3WCEf99mrtVx/OC/y2U0uNd8+Hqa/ypsgFOVjYavnp63wVNAnGOeaoT7ARj6Lunwlqu44oNSE
JrDghffEOP2pC8Zs376sk1jU8nJUCewZNzJzQj9IrsxklBF39wUEAEuW2DNZONyQHy0XRTYKTcCG
Ry2u0K1Zq2XoxZPFsuGl6tvGAKkHsQenfF9ilV1lXJ9zaAvAQfdqVVI3uo6bnwi+qekANHnOwWsK
tWZr83Jb+nkvREv5tUepTFeYUqnsGKfcunCSMYWa9fSrX8QiMuRTee5w6xFxHrXK
--000000000000a424ce061309fb76--

