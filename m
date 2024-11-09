Return-Path: <netdev+bounces-143487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8DF9C29A6
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 04:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A245B213A9
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 03:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8AE364A9;
	Sat,  9 Nov 2024 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZlI4DKLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0324086A
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731121835; cv=none; b=mQX8120k/EUCeUnZon0eBl6ezhUPO2kHYbSUoiUTDJjvq6c9HIhuW9+Sb6M8MjPRdTo8QXJG0oNBIF3axJwQN+k3r4m1rEYYT2IGSOw16F8G9e02D2LOkAUGEIEOYpH7vY3oDvPnsiflilFht9vInDRLo0Xr4swY+Ai0hN6pjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731121835; c=relaxed/simple;
	bh=Z3WeANNl5OZnryBdUyGrwpNUY2RipbQvMMDu50SQiSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzU3+KlD8LDW/WLa3zFQA4h5ZGcTmXSDEHiCjDaDlgi9F757bBU+S3G4KITWLNwHlE+OHyRdWk25HvWjOsWjfHE0NtfPZHxOUuMqjogMPif104KWAn9UJdKebnM8yR2XQzbEBVvuG+YN6/SmrXb61txQb7r7JZahL0ehke1jJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZlI4DKLz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7eae96e6624so2009418a12.2
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 19:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731121833; x=1731726633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YBrkJJ9ecPx6kpN2meCpxRuHvDiulQL3QXDRTiOc1E=;
        b=ZlI4DKLzBgO+nFEDDmAYk/ZhmkglLV/I3BhjxpGDDoC1IAvYu5X4pjo815ewaxn/km
         Vgl29HbNi0Ms5okN57hgV8TcRZm7zOU89dqMNZyY/6JJOO1+F7Hs1jQuTZlhPOGxA9E2
         9lVcyyZUCBtCxd1MSD5mj1S1o1iGYXJ0XQYWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731121833; x=1731726633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YBrkJJ9ecPx6kpN2meCpxRuHvDiulQL3QXDRTiOc1E=;
        b=wEdBJJiKI4e0WMHUviyGhaxDb+t1jPn3cGZOdBzAzoJA7Y3le3jBDPYiULxZaqJU3D
         KLbnty64w6akSrr4tQRjGZanYdfHgj+rFLcl10yPzQbNeLZ9Wks4oXlHpVhJFwtQhNP7
         dsXx7vPj/Fv0zspMbT7KuCx2I1YJZSMR8LSUCsCC2KPY/beOGeSADBXDZYyitd61QPRZ
         aVL/SEF+qOlsYLxlV6X0PL3Vidd+NLQQc3uejkErCcuOuIQU/IOSwkIW8o52xP2/5sKM
         eeawy8Fkb7FQK/ibqoyBtJLUxA1xgxNGT8opaTrTpFLDbbAy1l9ka1haYb30x/xwueRR
         Kzzg==
X-Forwarded-Encrypted: i=1; AJvYcCX8SfXPbTqZsBHirfsb96UnrA+GG6LSnesWFC3ad5/+Jq+Gt7COh+Y2JdRcDzK+jgqyG+522RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCA+4hw9VqPf3dpKZ37qgWHm6budEm591sheuB7HnHeav8kMlv
	gdzOgGct4kKLTtuxqYuhcklhw5Q7P+sKZgqGdsqMGi1s72qOU32WwAmrF5X8Mgj08oNBNoOvVBP
	pVvqt746o1VlVw2+1meDiuw1i8DaYAG6dawVq
X-Google-Smtp-Source: AGHT+IEig191RL5Op4N3zNHddI06wyCis8+MhHZDJVeYsHlRxCy9FILeIDozc81OaHnED7TCdHvR/bImrZ+7USTkOfk=
X-Received: by 2002:a17:90b:224f:b0:2db:89f0:99a3 with SMTP id
 98e67ed59e1d1-2e9b1780b4amr7120147a91.26.1731121832926; Fri, 08 Nov 2024
 19:10:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <384c034c23d63dec14e0cc333b8b0b2a778edcf1.1731092818.git.dxu@dxuuu.xyz>
 <CACKFLimKe8Kp5f=RzvoDFmmjPv1ZvUjOG-8woEJ9XXLNSGtSmw@mail.gmail.com>
In-Reply-To: <CACKFLimKe8Kp5f=RzvoDFmmjPv1ZvUjOG-8woEJ9XXLNSGtSmw@mail.gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 9 Nov 2024 08:40:20 +0530
Message-ID: <CALs4sv0gt7stf+ADcsi7Yt-X8SZ=gYZuYfk9sQCLzPOjaabFvQ@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: ethtool: Supply ntuple rss context action
To: Michael Chan <michael.chan@broadcom.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net, andrew+netdev@lunn.ch, pabeni@redhat.com, 
	martin.lau@linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f0e424062672356f"

--000000000000f0e424062672356f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 6:19=E2=80=AFAM Michael Chan <michael.chan@broadcom.=
com> wrote:
>
> On Fri, Nov 8, 2024 at 11:07=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Commit 2f4f9fe5bf5f ("bnxt_en: Support adding ntuple rules on RSS
> > contexts") added support for redirecting to an RSS context as an ntuple
> > rule action. However, it forgot to update the ETHTOOL_GRXCLSRULE
> > codepath. This caused `ethtool -n` to always report the action as
> > "Action: Direct to queue 0" which is wrong.
> >
> > Fix by teaching bnxt driver to report the RSS context when applicable.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/driver=
s/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > index cfd2c65b1c90..a218802befa8 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > @@ -1187,10 +1187,14 @@ static int bnxt_grxclsrule(struct bnxt *bp, str=
uct ethtool_rxnfc *cmd)
> >                 }
> >         }
> >
> > -       if (fltr->base.flags & BNXT_ACT_DROP)
> > +       if (fltr->base.flags & BNXT_ACT_DROP) {
> >                 fs->ring_cookie =3D RX_CLS_FLOW_DISC;
> > -       else
> > +       } else if (fltr->base.flags & BNXT_ACT_RSS_CTX) {
> > +               fs->flow_type |=3D FLOW_RSS;
> > +               cmd->rss_context =3D fltr->base.fw_vnic_id;
>
> I think the rss_context should be the index and not the VNIC ID.

No, for RSS contexts, we save their index in the fw_vnic_id of the
filters. Hence what Daniel has done is correct.

>
> Pavan, please take a look.
>
> > +       } else {
> >                 fs->ring_cookie =3D fltr->base.rxq;
> > +       }
> >         rc =3D 0;
> >
> >  fltr_err:
> > --
> > 2.46.0
> >

--000000000000f0e424062672356f
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILXuouG4GDcX44jghMeFRN+9t/lIXUvC
nhUkjDTRn1QBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTEw
OTAzMTAzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAC1idk03EypRVVZ+KQys6j6jeh3arpBMUTe5Uwou6uL9rPCffG
FR5iMKbICiHNgfPc99kBd90h3ZHJuq6VMbdei1gAqN6EIV6/sI3Wp2V5HHWT3Vkkrnv4J862V9/j
Gw5UNKQl7fykoZjnBoqMOBKDYzpQ8qP+VtTR+hjNKxwutJzWLUYIRaLVPHp+FP1gQaqQ280JaqNq
hWPScyBR5CfIWs3yHJLOHYw8NXG2dZmjbF5TS3XatK31vbRwQiPIuaXcCeCyxK5W3k+/6XCBnUKt
uZ0VTUL+0uTWwHnaCVQiP5LvE5syqgn6t7trZUNSYTdZw9H9ipy3qEJEcAIXQB2x
--000000000000f0e424062672356f--

