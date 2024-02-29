Return-Path: <netdev+bounces-76242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F89986CF83
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D3728288F
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DB02A1A5;
	Thu, 29 Feb 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IYkPYZIe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6216063B
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225034; cv=none; b=J7vnGUYHQScbzfY3rPdazJ8SMtYQvQ9ldxASQHa6eNQj/Js9mSHkJmTFrmEHxgPXbG9wHzFOJOw08qzYa3CssVdx/tvz/s3luIh6i2uaJjsCEpl1vQFaHF8UEXNhQtmvWdGmZ6qJoeVJG5ssRN5/7QBs8Bj7vViMZs67wuZpWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225034; c=relaxed/simple;
	bh=0SDgOlH1hO8SxTBJswXVSQRyMVbeboBb1hLYDxzhFSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNphWY7XhIQOnCTPGKGEQI6cbh8TJ41R4OrvBuRX2LkJZf7Boqez9xhqsBS0Ztah7rE5KVqa9u3pgss/4SgsVn8LgWRAM9u5HsU/zYkCrBLODhVjlleAJnzACQfaPbq29q51XNT7/W6IZ/9FR+AlJe62MW2Sqz1LoYAc3wBX1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IYkPYZIe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-566adfeced4so913137a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 08:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709225030; x=1709829830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e0iUrTDYc118e84FCsTnHXxvRtRIfqsSCcMVEY/D7+c=;
        b=IYkPYZIeC9SY2Acd1/HP/gXAOGG4A1KS+Kz/ujR+GFLT4ECN1duHN6GtuzJYN2V6q/
         YaRyYLq3psxwu56wRvZesHJ6upvteijhn4t9y1S6/6yoY27+QX5MrKEpvL32oaFk0kL7
         K5e4xGtCROflJpscChAT5kb2vASmXGh9qluwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225030; x=1709829830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0iUrTDYc118e84FCsTnHXxvRtRIfqsSCcMVEY/D7+c=;
        b=Xh7J4kDaN09Zu/j3mdq9gyzh91+EoUCXPzXijDjYIjNPH+zTaG6phkG0ZRZLPlxrba
         viElhT6GaY4zU0F5/RgMy7EK1t8BKPNuBcxVIGccKPnXl6t9F6Sdm8TPXY709QQT5DIq
         z8qxBm1JJhwlZx7IKS6Qly7LcZ+8O7x6BZWee0CbMKVPoLmo4TWLjAmSfG3t35nBUKHp
         CL00pK3BpCpvdmghmRWajU0brxTW/EkeSWxMWGkf6O44R03I6qx9uCLW85Hn+HuSgE27
         TYRzc587aVgUCcQhu8wk9iiG7IouiAS6GS9+qs2ed2YnkMw61P89Iy64DL7XOYRKTWJf
         z6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUHXwOy8OmfN5Q9p93A/tQfx1GFWWldxnv2vMhjY1ZZ7tUwd1Ogv2b0GbolBSiYth+5KysdO+pU8Vzmv5W5Hb5VFIm6801v
X-Gm-Message-State: AOJu0YztJ6pkOjBeeUblScxIHrQyjrObiS+fJn7ld7WaZ/KY+NPNmaIg
	k2oe1jDInxeyhBg+OK9jcZmmQpRA2RN0RhbWcZhJ4r14TKKgrHExl/cJkChKhTc6sU601PdhpbU
	AU0Tnx+DbgzguxC/zCck4V5aR783mHkCugwVv
X-Google-Smtp-Source: AGHT+IEpAZhzE2pG0Zp4t4Sss8h4hX1rgqqwLkZQMOErkTggNk1pwe78ohQjn9fYnjlyHGqQuh3oR80HD2tc99eUBj8=
X-Received: by 2002:a05:6402:2227:b0:566:8054:562 with SMTP id
 cr7-20020a056402222700b0056680540562mr1897826edb.3.1709225030484; Thu, 29 Feb
 2024 08:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229070202.107488-1-michael.chan@broadcom.com>
 <20240229070202.107488-3-michael.chan@broadcom.com> <3c38627e-b9b6-43a3-ae66-628976c41247@linux.dev>
In-Reply-To: <3c38627e-b9b6-43a3-ae66-628976c41247@linux.dev>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 29 Feb 2024 08:43:38 -0800
Message-ID: <CACKFLinRYCuiN6Oz08s=X++ueVjvH2P4VnD1eD6H83Zgd0Wq+w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] bnxt_en: Retry for TX timestamp from FW
 until timeout specified
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew.gospodarek@broadcom.com, jiri@resnulli.us, 
	richardcochran@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d00eff061287f674"

--000000000000d00eff061287f674
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:23=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 29/02/2024 07:02, Michael Chan wrote:
> > From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> >
> > Use the ptp_tx_timeout devlink parameter introduced in the previous
> > patch to retry querying TX timestamp, up to the timeout specified.
> > Firmware supports timeout values up to 65535 microseconds.  The
> > driver will set this firmware timeout value according to the
> > ptp_tx_timeout parameter.  If the ptp_tx_timeout value exceeds
> > the maximum firmware value, the driver will retry in the context
> > of bnxt_ptp_ts_aux_work().
> >
> > Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> > Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> > ---
> >   Documentation/networking/devlink/bnxt.rst     |  7 +++++++
> >   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 19 ++++++++++++++++--=
-
> >   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  4 +++-
> >   3 files changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/networking/devlink/bnxt.rst b/Documentation/=
networking/devlink/bnxt.rst
> > index a4fb27663cd6..48833c190c5b 100644
> > --- a/Documentation/networking/devlink/bnxt.rst
> > +++ b/Documentation/networking/devlink/bnxt.rst
> > @@ -41,6 +41,13 @@ parameters.
> >        - Generic Routing Encapsulation (GRE) version check will be enab=
led in
> >          the device. If disabled, the device will skip the version chec=
k for
> >          incoming packets.
> > +   * - ``ptp_tx_timeout``
> > +     - u32
> > +     - Runtime
> > +     - PTP Transmit timestamp timeout value in milliseconds. The defau=
lt
> > +       value is 1000 and the maximum value is 5000. Use a higher value
> > +       on a busy network to prevent timeout retrieving the PTP Transmi=
t
> > +       timestamp.
> >
> >   Info versions
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/ne=
t/ethernet/broadcom/bnxt/bnxt_ptp.c
> > index 4b50b07b9771..a05b50162e9e 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> > @@ -122,10 +122,14 @@ static int bnxt_hwrm_port_ts_query(struct bnxt *b=
p, u32 flags, u64 *ts)
> >       req->flags =3D cpu_to_le32(flags);
> >       if ((flags & PORT_TS_QUERY_REQ_FLAGS_PATH) =3D=3D
> >           PORT_TS_QUERY_REQ_FLAGS_PATH_TX) {
> > +             struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
> > +             u32 tmo_us =3D ptp->txts_tmo * 1000;
> > +
> >               req->enables =3D cpu_to_le16(BNXT_PTP_QTS_TX_ENABLES);
> > -             req->ptp_seq_id =3D cpu_to_le32(bp->ptp_cfg->tx_seqid);
> > -             req->ptp_hdr_offset =3D cpu_to_le16(bp->ptp_cfg->tx_hdr_o=
ff);
> > -             req->ts_req_timeout =3D cpu_to_le16(BNXT_PTP_QTS_TIMEOUT)=
;
> > +             req->ptp_seq_id =3D cpu_to_le32(ptp->tx_seqid);
> > +             req->ptp_hdr_offset =3D cpu_to_le16(ptp->tx_hdr_off);
> > +             tmo_us =3D min(tmo_us, BNXT_PTP_QTS_MAX_TMO_US);
>
> With this logic the request will stay longer than expected. With
> BNXT_PTP_QTS_MAX_TMO_US hardcoded to 65ms (it's later in the patch),
> and TXT timestamp timeout set for 270ms, the request will wait for 325ms
> in total. It doesn't look like a blocker, but it's definitely area to
> improve given that only one TX timestamp request can be in-flight.

Note that the firmware will return the timestamp as soon as it is
available or wait up to the timeout value.  Yes, this firmware timeout
value will be set to 65ms if the devlink parameter is > 65 ms.  And
yes, the worst case wait time can potentially be +65 msec in this
case.

We can set this FW timeout value to something smaller than 65 ms
(maybe something like 25 ms) when the devlink parameter is > 65 ms.
Thanks.

--000000000000d00eff061287f674
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA30mIkwpZK+60qJzog4tu4umKDfJnla
f+x+jVP9eE/vMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
OTE2NDM1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCx3yMlk1DbmW003CCftEseRm0shMpQDJM8bg3ojZ2n/n3UnxFW
0smVxQnhFenlhyJICxn2D8R6MySeYz5Tj4UHc3EU1/JSYWs6nPT01+SV+TDOK5vM0fu4AVHID1kr
Bx4k6SW8BwAcKknfD5N1ipVkYF0Qa4Sjp2+/scrFSWq6MIexeVtG9O1LZlA5zTzGDJ/KoSVmNAlF
08mu1G8wzxpPFI4IdACo2zVPmIWgrEuw9R1MLr8uv5cA+mnBQvDHufhIn5D2XI26QK7zDHkdzbBk
ZTIGfhDy6/jsRYmaJwb51rhOFixJ0AaSiF5Ci500iLu4zFWCImirSTVznVmfYKj7
--000000000000d00eff061287f674--

