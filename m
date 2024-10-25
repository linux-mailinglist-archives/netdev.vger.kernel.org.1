Return-Path: <netdev+bounces-139245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B609B122E
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E1AB212FB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56A1C174E;
	Fri, 25 Oct 2024 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gghHNV0u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEBD217F57
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893627; cv=none; b=OxIbluRTJy+bOn62sM1j6+57axDD1pCMQsFrjqEdkX0/hgPrG+Qgsz/u6F3V+X8IbH7Xf9/k4FE5riMYoV+cXibn++QrhxwL52cSOM5fvmEXCYT+P8IVRnXCETnJP9bAUX9eQMkW2DYxW0ZoR6PnvB8G8LQ7klgpXBebEykYGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893627; c=relaxed/simple;
	bh=AS65C4KKH3Fa1/54w8ZwTLY6Vhl0+/yeeRBYENWU8lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOnmAmC4woRt3/oSHbYvJaFqwWlqV55xugXGlDu2jcI1gRZHXeeAAqj7S1H0aSFmndiqdjEwguD2gfr4iawEVpDGfn8Y2+USU5BLK65ODw3SKIAu9dvSI2FmXBpNN/l7jOk80QbIrRjvv9iWWihEUKydshe6C5QJ5VwPqnRNIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gghHNV0u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so24350225e9.2
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729893623; x=1730498423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHPJGTegLCCzyoC+zW/C6THQlanbJazcpZkIyGpilpc=;
        b=gghHNV0uK5CC9EZPYS4Y5bYsbuoW9NZqO1EViZzIwE5q9hIawZ6u0L3SIbCwbUjiTc
         qVJwOL2N7XXxWEMiF86uOxGMvUfhqHab14+GyXtiq9EwrbkITN74xoE0gGwh9P5CGt3z
         ujo7n4xK2zZH5orjdKxlAvg2rS/fSBQVr18as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729893623; x=1730498423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHPJGTegLCCzyoC+zW/C6THQlanbJazcpZkIyGpilpc=;
        b=bRA6b6QLVV9DP1a7fu93a+Fh9oqbtDfGGHwSY0oXKW0g+vBcZT8oGOhXPJH+Ze4H7L
         MTrEgNONcaWlaxzwaaa2PT2dHLGn7VMhSnPyS/0kixjYMKcMpmTFMBbdNs/i4lo8/v5B
         RKISBcgHU/xgvZ2KMgkVINd1MBR9b/p8wW9mTF0T95tGs2O+nPTwFIFm+6+TDDhXroKF
         C1qM6oKNGLR281XMfoLHJrOn/aQKfz0NAoxDWjcK4itJHiBfPV9Tnu+K/4hOZE/CNGIF
         0uU2WRZbnKXO+oYpchftUfyQFDqJe5/lETaXs6LlHD4IhyuPwxKJs9yUV5SRdTpwv33+
         HXyg==
X-Forwarded-Encrypted: i=1; AJvYcCXdM4z8uQaa/XcWvq5Udr146+QoDrBk+yv9PP2jEaXWttahZxZ+lhuSqIHXDKK/DFPuiVaOhcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjWtT8mfx23qnKBn5wH7YvyADzezOnSND6kjvxus/upCDxknq
	A+GQn22WOasCNrBYkVrfRyutb7qJ3u8V/4g7RT5DHcJBEFJCCAARH/Xr9/DtfLrYhgA4/ggFGqy
	wz5gTlRW5oFNcejTq2+bGNhV5paX6R637BcXM
X-Google-Smtp-Source: AGHT+IFzITeU8qyhbB4d9w/5cfBuhuszxu8tUWx8+nlxG28DwvV0d4xdtjrBddEBAtKT8lDNSO/mBcU7sMLrX0tRDDI=
X-Received: by 2002:a5d:4084:0:b0:37d:37b8:3778 with SMTP id
 ffacd0b85a97d-380611eec34mr612129f8f.45.1729893623254; Fri, 25 Oct 2024
 15:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-3-ap420073@gmail.com>
 <CACKFLikBKi2jBNG6_O1uFUmMwfBC30ef5AG4ACjVv_K=vv38PA@mail.gmail.com> <ZxvwZmJsdFOStYcV@JRM7P7Q02P.dhcp.broadcom.net>
In-Reply-To: <ZxvwZmJsdFOStYcV@JRM7P7Q02P.dhcp.broadcom.net>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 25 Oct 2024 15:00:11 -0700
Message-ID: <CACKFLinbsMQE1jb0G-7iMKAo4ZMKp42xiSCZ0XznBV9pDAs3-g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/8] bnxt_en: add support for tcp-data-split
 ethtool command
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, almasrymina@google.com, 
	donald.hunter@gmail.com, corbet@lwn.net, andrew+netdev@lunn.ch, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, dw@davidwei.uk, 
	sdf@fomichev.me, asml.silence@gmail.com, brett.creeley@amd.com, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f206ba0625543e91"

--000000000000f206ba0625543e91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 12:24=E2=80=AFPM Andy Gospodarek
<andrew.gospodarek@broadcom.com> wrote:
>
> On Thu, Oct 24, 2024 at 10:02:30PM -0700, Michael Chan wrote:
> > On Tue, Oct 22, 2024 at 9:24=E2=80=AFAM Taehee Yoo <ap420073@gmail.com>=
 wrote:
> > >
> > > NICs that uses bnxt_en driver supports tcp-data-split feature by the
> > > name of HDS(header-data-split).
> > > But there is no implementation for the HDS to enable or disable by
> > > ethtool.
> > > Only getting the current HDS status is implemented and The HDS is jus=
t
> > > automatically enabled only when either LRO, HW-GRO, or JUMBO is enabl=
ed.
> > > The hds_threshold follows rx-copybreak value. and it was unchangeable=
.
> > >
> > > This implements `ethtool -G <interface name> tcp-data-split <value>`
> > > command option.
> > > The value can be <on>, <off>, and <auto> but the <auto> will be
> > > automatically changed to <on>.
> > >
> > > HDS feature relies on the aggregation ring.
> > > So, if HDS is enabled, the bnxt_en driver initializes the aggregation
> > > ring.
> > > This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.
> > >
> > > Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> > > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > > ---
> > >
> > > v4:
> > >  - Do not support disable tcp-data-split.
> > >  - Add Test tag from Stanislav.
> > >
> > > v3:
> > >  - No changes.
> > >
> > > v2:
> > >  - Do not set hds_threshold to 0.
> > >
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  8 +++-----
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  5 +++--
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 +++++++++++++
> > >  3 files changed, 19 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt.c
> > > index 0f5fe9ba691d..91ea42ff9b17 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >
> > > @@ -6420,15 +6420,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt=
 *bp, struct bnxt_vnic_info *vnic)
> > >
> > >         req->flags =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_=
PLACEMENT);
> > >         req->enables =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JU=
MBO_THRESH_VALID);
> > > +       req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
> > >
> > > -       if (BNXT_RX_PAGE_MODE(bp)) {
> > > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size=
);
> >
> > Please explain why this "if" condition is removed.
> > BNXT_RX_PAGE_MODE() means that we are in XDP mode and we currently
> > don't support HDS in XDP mode.  Added Andy Gospo to CC so he can also
> > comment.
> >
>
> In bnxt_set_rx_skb_mode we set BNXT_FLAG_RX_PAGE_MODE and clear
> BNXT_FLAG_AGG_RINGS

The BNXT_FLAG_AGG_RINGS flag is true if the JUMBO, GRO, or LRO flag is
set.  So even though it is initially cleared in
bnxt_set_rx_skb_mode(), we'll set the JUMBO flag if we are in
multi-buffer XDP mode.  Again, we don't enable HDS in any XDP mode so
I think we need to keep the original logic here to skip setting the
HDS threshold if BNXT_FLAG_RX_PAGE_MODE is set.

> , so this should work.  The only issue is that we
> have spots in the driver where we check BNXT_RX_PAGE_MODE(bp) to
> indicate that XDP single-buffer mode is enabled on the device.
>
> If you need to respin this series I would prefer that the change is like
> below to key off the page mode being disabled and BNXT_FLAG_AGG_RINGS
> being enabled to setup HDS.  This will serve as a reminder that this is
> for XDP.
>
> @@ -6418,15 +6418,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp=
, struct bnxt_vnic_info *vnic)
>
>         req->flags =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLAC=
EMENT);
>         req->enables =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_=
THRESH_VALID);
> +       req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
>
> -       if (BNXT_RX_PAGE_MODE(bp)) {
> -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
> -       } else {
> +       if (!BNXT_RX_PAGE_MODE(bp) && (bp->flags & BNXT_FLAG_AGG_RINGS)) =
{
>                 req->flags |=3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_H=
DS_IPV4 |
>                                           VNIC_PLCMODES_CFG_REQ_FLAGS_HDS=
_IPV6);
>                 req->enables |=3D
>                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THR=
ESHOLD_VALID);
> -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copy_thresh);
>                 req->hds_threshold =3D cpu_to_le16(bp->rx_copy_thresh);
>         }
>         req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
>

--000000000000f206ba0625543e91
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIL/KrRYacg5SUEwm++sozU03tvddGrAC
eO7emsJ9iZM3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAy
NTIyMDAyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAeqGMDwcfSOAB9wYwWJuMyEssaW6vEKKqBYZOFIOhPVb19qeHF
oDB+al83LG6ru/tHUhrmONqN1BMYeaUhTg9xSeDblvFGTF+7Bsr9P8Qc9DpZ8K0JJUQhfxiZ9/tQ
rGwS3xKfv+bRP8O/AtB94G79WR+QHm/+/EID2REt1TnXNbwBCVKDeNtzHbb2Wf1AwekD2e3a+KZr
xcpgsUTRHZyg6Dtb8n8sxbv29ibRmLtRZaztZW+bLJA63I/fWl6TqHMX2hVTWi96ZybKssbPjGRw
Gjm1G0oDU4b084/1ZwV7twcAT54RpWKo/y5yDiIEoeaPhUpqPHTA4/uupPaeJ4e2
--000000000000f206ba0625543e91--

