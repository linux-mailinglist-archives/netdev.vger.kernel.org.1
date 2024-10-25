Return-Path: <netdev+bounces-138974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE11A9AF903
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 06:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18631C2175E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 04:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0618DF79;
	Fri, 25 Oct 2024 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JwwLmCdr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CF18D63C
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832106; cv=none; b=PFLgjQpH6kBF1W971QMX99lo4mrY7/0T5vvnU/lCaSh748k5fywhGshhPRIO7o5qGmew+D2oyZk35rJiWX5Cx52/XrJatHL7gOZU8zdRsRE9ebfyW62i7B6ON9gynPJu+L28ldm1KlpfvlZaNYK6h4WL4toVY9sjgiUdpoRcfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832106; c=relaxed/simple;
	bh=Molie1np/S0FKwHHy/KvOXgFrKkVNA6ownLmkKv6WrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWzZ0dZyaSpeRtO9hk4X22i4EQoAjDMsIlkSRyn1nPi9jWATySI3leHyXgWTpfdsKWDm4g0zKYQhI3I4s5ADvPp50IJX1q59+H4j6FPPFJAxQvEfAN1pQTzniVCiMPiTRmtjG3YmXXe/RmlCerC6HGCDnLgF7HeD1rlVH5j/Rvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JwwLmCdr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso2590296a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729832102; x=1730436902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4DITI/69yPRHNbDfe9jzGq+j8IFcGBEKcwto0gtJIoE=;
        b=JwwLmCdr5f3J+GClKcFa+ep1FvkdPH9mxBW+tnJg7DdpHmjvP5T+O/vu8v42uqBO0P
         frZtVNRo5uMqC5l6fyU6+eD5/uNlbNVTVa+vpmpG4O86YNFK2wBbvQZQX+D3npRFe1rw
         0uiktD/bYho/OvIbMclFASU6038CANADQ043Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729832102; x=1730436902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DITI/69yPRHNbDfe9jzGq+j8IFcGBEKcwto0gtJIoE=;
        b=ue9LWU6d59oeLX91WbfhjmFgoBjTCUBRt7Y1LVrF4ec+NHMzlP1kuzzq8vsIkHh1wa
         Jbst2/3X7AYRK4oI0yV3ZkFRvUz2nO5vusuL3VR/1piJ+/80m3n3P9dzJmI/C1/x3z6L
         OMzHAVTg9b7D0vrF3IKSFFEZHa24RjBnx/ajMTGAwAaVAK8sDcc4VpgWD4IzLGwIOmS+
         Wr2o4u7UiRbhhun9bLtTfm8rmV0acC3rx9y3ZMuantDPFnDBZjoORhl1EW1LVVYy7jV9
         YjncH4UUgGyc54yUqJIM0mdmNXI77ta2bMq4U5b2DOE6EgnF1mXpnjDU1A0hbHraXn7q
         9mUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUmXkRoFmC1Z806zMH38xJjccwItUehEISTrUvTVHXfn32E9D3/v90uocAEQpw+7/cN5VWkjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwflzWZ/+RS7YNuSayOjCH+XBO7flZwgcrgzF12vr6FLcL5H5/B
	8hWqZtNvQ4zB9BczSOOoT74TFnbPcVJEVVrWOx6FvuB+BrJJFV9hu873AJ+UfKmX+OihsSz10eS
	8ehlQalf/poYWKPwVtS7BTujAx6v1BczhulOt
X-Google-Smtp-Source: AGHT+IEd/oSNqH8cz5NFBfs5KmtKXnJdiFAFJr49LptGa208q++5/iywtCpT1y10rXIXSRCF42yfxP2hpnWyaDgI8vo=
X-Received: by 2002:a05:6402:1e92:b0:5cb:77d1:fd7f with SMTP id
 4fb4d7f45d1cf-5cba20217d2mr4571793a12.7.1729832102019; Thu, 24 Oct 2024
 21:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-2-ap420073@gmail.com>
 <CACKFLikH-8fdqpvFouoNaFGq011+XvR0+C-8ryq-SutAs=RdsQ@mail.gmail.com> <CAMArcTV3U62Rz+FPCJWVOqqNJOZBLnBvb+yRcjJ+drspm5nxbw@mail.gmail.com>
In-Reply-To: <CAMArcTV3U62Rz+FPCJWVOqqNJOZBLnBvb+yRcjJ+drspm5nxbw@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 24 Oct 2024 21:54:50 -0700
Message-ID: <CACKFLikK0p1e41sbkBt1MCL=gxoWbKNHvqzEfcaV=rBfvQjB4w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/8] bnxt_en: add support for rx-copybreak
 ethtool command
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fd4d6b062545eb12"

--000000000000fd4d6b062545eb12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 9:38=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> On Thu, Oct 24, 2024 at 3:41=E2=80=AFPM Michael Chan

> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt.c
> > > index bda3742d4e32..0f5fe9ba691d 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >
> > > @@ -4510,7 +4513,8 @@ void bnxt_set_ring_params(struct bnxt *bp)
> > >                                   ALIGN(max(NET_SKB_PAD, XDP_PACKET_H=
EADROOM), 8) -
> > >                                   SKB_DATA_ALIGN(sizeof(struct skb_sh=
ared_info));
> > >                 } else {
> > > -                       rx_size =3D SKB_DATA_ALIGN(BNXT_RX_COPY_THRES=
H + NET_IP_ALIGN);
> > > +                       rx_size =3D SKB_DATA_ALIGN(bp->rx_copybreak +
> > > +                                                NET_IP_ALIGN);
> >
> > When rx_copybreak is 0 or very small, rx_size will be very small and
> > will be a problem.  We need rx_size to be big enough to contain the
> > packet header, so rx_size cannot be below some minimum (256?).
> >
> > >                         rx_space =3D rx_size + NET_SKB_PAD +
> > >                                 SKB_DATA_ALIGN(sizeof(struct skb_shar=
ed_info));
> > >                 }
> > > @@ -6424,8 +6428,8 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *=
bp, struct bnxt_vnic_info *vnic)
> > >                                           VNIC_PLCMODES_CFG_REQ_FLAGS=
_HDS_IPV6);
> > >                 req->enables |=3D
> > >                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS=
_THRESHOLD_VALID);
> > > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copy_thresh)=
;
> > > -               req->hds_threshold =3D cpu_to_le16(bp->rx_copy_thresh=
);
> > > +               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copybreak);
> > > +               req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);
> >
> > Similarly, these thresholds should not go to 0 when rx_copybreak become=
s small.
> >
> > >         }
> > >         req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
> > >         return hwrm_req_send(bp, req);
> >
> > > @@ -4769,7 +4813,7 @@ static int bnxt_run_loopback(struct bnxt *bp)
> > >         cpr =3D &rxr->bnapi->cp_ring;
> > >         if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
> > >                 cpr =3D rxr->rx_cpr;
> > > -       pkt_size =3D min(bp->dev->mtu + ETH_HLEN, bp->rx_copy_thresh)=
;
> > > +       pkt_size =3D min(bp->dev->mtu + ETH_HLEN, bp->rx_copybreak);
> >
> > The loopback test will also not work if rx_copybreak is very small.  I
> > think we should always use 256 bytes for the loopback test packet
> > size.  Thanks.
> >
> > >         skb =3D netdev_alloc_skb(bp->dev, pkt_size);
> > >         if (!skb)
> > >                 return -ENOMEM;
>
> I tested `ethtool -t eth0` and I checked it fails if rx-copybreak is too
> small. Sorry for missing that.
> I think we can use max(BNXT_DEFAULT_RX_COPYBREAK,
> bp->rx_copybreak) for both cases.
> I tested it, it works well.
> So I will use that if you are okay!
>

Yes, please go ahead.  I think all 3 places I commented above should
use max(BNXT_DEFAULT_RX_COPYBREAK, bp->rx_copybreak).  Thanks.

--000000000000fd4d6b062545eb12
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFuvp5LVW80Oj0uJOq+suOnyVZ5GbN2f
5hYsyrLGMUgkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAy
NTA0NTUwMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAaCySeAKmQzz42HZM62rM/mce/WYGpTUNRs94n4q2a4V141g8t
eZewWTXdJJlk9sV2p19Rj7x+WwOTD9q55egoH98pP0+751elpsnobc1K+mncWbGlWx03XFjIGK5i
DxqoKaGmNjSxrOXpxy4A6YrEvNCNjwTfRrMI5LIJyG+qM9BN7crAXoDHVc+qZTkbKeZbHD6t8lMx
M5Uz35gQeLMfQZhJe+MuasAQcvY1s+xzZ4ppk5+d3O2+LAiEx4UhN8nN0Jzf88b1q3LzKsJuq8L+
CnA3pJCNYwPRGA6sygunA03m3hel/VnZIUOTpD41aIeYYEP5QpexCEoQsnu9tPUA
--000000000000fd4d6b062545eb12--

