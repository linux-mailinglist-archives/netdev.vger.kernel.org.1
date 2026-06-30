Return-Path: <netdev+bounces-302953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PKB+E7FGQ2qEWQoAu9opvQ
	(envelope-from <netdev+bounces-302953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:31:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1026E045A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:31:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=hq1pefMe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302953-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302953-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65DA2302A045
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830B32B131;
	Tue, 30 Jun 2026 04:31:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BC27727
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:31:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793902; cv=none; b=nBhko4ptusQpEhyhQPDQskCBACEot+55qGvOHtRUh3tn0qHcsoMTzv+Zl7DE2BeloNdNEQxhlXNENe+DNYCHkSKMTSwbcNtXRDIfobF9WIvW0kxdlzXAczIwJO6VRO8O5d6D2KLFL3fjeL2EAhi5w8A8h1ytDc7ZJjbQF69kvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793902; c=relaxed/simple;
	bh=zA6RG2sToz1mTqcjUg4cNbO3/HWBsYBGEJWOdCRRcbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE45t3wskyQs8NGolRl53ga9dLiBEzxdGIjcvODX1WC2n99PwNvhM8lkkd9zcw38cX1Li+M65vhg3X7XdOS87MSGSF8s3k+N7NhsdN4bp/aH37KNHT7qSsrX4uXXasXXjKAOxz1QtgLr8t4KBlf9+QtNROt440awJ7IdJMOnLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hq1pefMe; arc=none smtp.client-ip=209.85.215.226
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c9c80265bd7so7028a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793900; x=1783398700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW4mdKf9/2NIzRGJ6+0OeJ+wfQOTg5gtxikMQQwSXBM=;
        b=RdvZ0dHCNqVT5sHWfLzDoi76fipepL0pL5TTB6TkeiLv5VucppMEGbyt7HR0UGqYtT
         V2COfG0eM3RRkfPbG9ENdBauCZfC76WzBks9U9m01X0F997inrgU9/D/xbs+fB3ipDPR
         GRixcfrOUK35Rzh6JjntKqmxQZoYyCRcLxKuZ0aYrh5tEMJGaxpeFFvwS3jT9iEh+78e
         dg/Q6RtuH9B4FAQPkqCpDTUfPitmnAya+wpe+LtWze0Sh0Oio9w2CsIh+zZ2v75DIXEi
         TnkuN4YB4rndmloow7tY/GTeB+oAn6dtTQOKoLoAtjNoBkjjgzSX0fitjfvKGjar/AmT
         L0vg==
X-Forwarded-Encrypted: i=1; AHgh+Rqg8hY2MeY9gX/atWEyHzXcK64I6pzqurm6PaCFbFkOqb+nEZFsf6+mzcnbuaINk4SqjQxo9mM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv77KS90LWd8njYmmy6TCfMJ7JK0dOnaAKBiWdygP/r7vEEtgv
	CskO1WZefM6uEL48yzILx9O3Nwu6hgtbDUawLUNvGLEUXvSsEgSMN/ZYOZ8tb+110H3e/Fn2mH6
	sU51AWBuZYa2huxxfNiea2xW8R7g8TnBM49ybfZH/f8JWSTbMpf35L566tN4AMQUZdRJeX+ptmK
	EC0ICmOU9kyflerIHux9XQUr+WKEMwM0Lbjyiv6Bn0u+8CpumzQqKKMqxznosiiLzIV/58YhLmq
	y3YHvWnwoo=
X-Gm-Gg: AfdE7cmVxEMvjCi3EB9a7e0QL53380UQsvs7Ftvsso1qdOyJ7CysmUTFTZdWh4Ef8xG
	VUeKLj4rMHkQ9lKIHqlIaiwndF5jzDLIx6Cd4J1b0M7T005KZhuRP02WCnhcwj3CiamDHaN/cyJ
	9FZVL0e1NBGUcws0z8qsmpxfh5MeoI22iZRBBX60PD3wHn5IE0dfkcIlF6b+IqqGUgjX3I9zrGH
	GRCPHO/oIdBpw+MMGIGzc9b5eLoiLqpvzpmpUvyxa4OUFEfFMtD2jVd57oueZmMU0mryxX3rory
	9O+Jgjhb03xdPgM5jkGHH2BwF3Qhhu/TG41sjaoS+8ubLCaWQiO9xG74kPNPrkXoysOktXh6uMg
	F/uYrMMz1nSlT3XAeewQdmFH8s5Ft40AxtmJyPzcyXTHyv+rx/9O51pth+KK2pwCKR9r4O+ISiW
	YCldMEetETz4+r34RpO0s/Owr91ccpGisPPeeT6godF4faGg==
X-Received: by 2002:a05:6a00:1397:b0:842:422b:259f with SMTP id d2e1a72fcca58-8479eed8ecemr1813957b3a.10.1782793900316;
        Mon, 29 Jun 2026 21:31:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8479fd33f17sm136375b3a.0.2026.06.29.21.31.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 21:31:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6983e9f38e6so2306946a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782793898; x=1783398698; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kW4mdKf9/2NIzRGJ6+0OeJ+wfQOTg5gtxikMQQwSXBM=;
        b=hq1pefMeTElY/JnAnxz0edMD6dsYOiE67IH80lw4xA1DwHRPNUvFGwLa4OpBWszKzg
         yw7tsxCopNEaAXvpf87MmcFGCtTS+w8ZIBPTcH7snnGmQLJpTieNgIcNsnBcpqj9HRYY
         NDoBIW7j75uxUWOGfjXXgcfxAGiOivUvMTMGA=
X-Forwarded-Encrypted: i=1; AHgh+RozWOVYnEDpyJIHuce+gXv3ydLrAvcmTlycxPFHcqMz8tS8jWI47E1hbmSF+q4Qayq3wH9qzpk=@vger.kernel.org
X-Received: by 2002:a05:6402:2691:b0:698:415d:318b with SMTP id 4fb4d7f45d1cf-69879df07c4mr672069a12.13.1782793898143;
        Mon, 29 Jun 2026 21:31:38 -0700 (PDT)
X-Received: by 2002:a05:6402:2691:b0:698:415d:318b with SMTP id
 4fb4d7f45d1cf-69879df07c4mr672054a12.13.1782793897677; Mon, 29 Jun 2026
 21:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629233348.2145841-1-kuba@kernel.org>
In-Reply-To: <20260629233348.2145841-1-kuba@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 30 Jun 2026 10:01:24 +0530
X-Gm-Features: AVVi8CfRLLsnj9zlHdf1wcrNR43YR60Ru-2g7lvVSiSDV3gegxLlN11CBky-axc
Message-ID: <CALs4sv2UE7uYQ9v+-Jid_d2NfJR1Ub-P0EmWvLaz_G8Mpnagvg@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: bump default cmd() timeout to 20 seconds
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	petrm@nvidia.com, leitao@debian.org, dw@davidwei.uk, noren@nvidia.com, 
	gal@nvidia.com, linux-kselftest@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000006b6960655710d8f"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302953-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:petrm@nvidia.com,m:leitao@debian.org,m:dw@davidwei.uk,m:noren@nvidia.com,m:gal@nvidia.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davidwei.uk:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF1026E045A

--00000000000006b6960655710d8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We always used 5 sec as the default command timeout. But soon after
> it was introduced, David effectively made us ignore the timeout
> (it was passed to process.communicate() as the wrong argument).
> Gal recently fixed that, but turns out the 5 sec is not enough
> for a lot of tests and setups. The fix regressed regressions.
>
> In particular running reconfig commands (e.g. XDP attach) on mlx5
> with 32 rings and 9k MTU, on a heavily-debug-enabled kernel takes
> more than 5 sec. The XDP installation command will time out after
> 5 sec but since the sleeps in the kernel are non interruptible
> the command finishes anyway, leaving the XDP program attached,
> but with non-zero exit code. defer()ed cleanups are not installed,
> breaking the environment for subsequent tests.
>
> Since "install XDP" is a pretty normal command a "point fix"
> does not seem appropriate. 32 rings is a fairly reasonable
> config, too, so we should just increase the timeout to 20 sec.
>
> There's no real reason behind the value of 20.
>
> Fixes: 1cf270424218 ("net: selftest: add test for netdev netlink queue-ge=
t API")
> Fixes: f0bd19316663 ("selftests: net: fix timeout passed as positional ar=
gument to communicate()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: petrm@nvidia.com
> CC: leitao@debian.org
> CC: dw@davidwei.uk
> CC: noren@nvidia.com
> CC: gal@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/=
selftests/net/lib/py/utils.py
> index 308c91833239..9b40049e2dbb 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -44,7 +44,7 @@ import time
>      Use bkg() instead to run a command in the background.
>      """
>      def __init__(self, comm, shell=3DNone, fail=3DTrue, expect_fail=3DFa=
lse, ns=3DNone,
> -                 background=3DFalse, host=3DNone, timeout=3D5, ksft_read=
y=3DNone,
> +                 background=3DFalse, host=3DNone, timeout=3D20, ksft_rea=
dy=3DNone,
>                   ksft_wait=3DNone):
>          if ns:
>              if hasattr(ns, 'user_ns_path'):
> @@ -113,7 +113,7 @@ import time
>
>          return stdout, stderr
>
> -    def process(self, terminate=3DTrue, fail=3DNone, expect_fail=3DFalse=
, timeout=3D5):
> +    def process(self, terminate=3DTrue, fail=3DNone, expect_fail=3DFalse=
, timeout=3D20):
>          if fail is None:
>              fail =3D not terminate
>
> --
> 2.54.0
>
>

--00000000000006b6960655710d8f
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD+pgTD
F88wViO7hA9ZSzt3ZE+cQXXr+WzS4XcT8aygLjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA2MzAwNDMxMzhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDAniWDS1kRclle/1k6oqa8MCwGcU5REq3mG4fhhdi8
GwfPKVzaZNGIzBlosYX5cL1K4jtXqKTQGWu2dFeQ8990Blq+SDH5DkyircBkkMOp+16qvxeuHwst
VXY2PaICOOv6fLZ+4JqMmzeqkLqX2/YRZGjLR2otHy6mpQCTX0SiVrLOpKbD+ew7A2FtqShtOqMI
LVa7CQlcERfAmbTtCDp23t/F5v/hkpBd2/l9gpZPICV0KoDi8tRe/HJyj9jbBpLFqKY+ClEVdKIP
DKrWBySc73fWO1CbhQPuzWfYwikB8fxtpFJ3zWTOBw1qcemYzYW6zQ6AzOBUMVpja3+fP/Pq
--00000000000006b6960655710d8f--

