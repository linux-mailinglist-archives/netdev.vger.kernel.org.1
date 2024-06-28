Return-Path: <netdev+bounces-107779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE1A91C505
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920861C23079
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA731CCCAC;
	Fri, 28 Jun 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TQglB+nv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2894CB37
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596255; cv=none; b=miL4AYHsYZhViyUT7nzW2dgJmFvNXfitpjg6CKmZ2MdQ02NJ1mSTqsHi9Juyx9+j6iZRziprEqozTiki7OjlWgsHgqPM3T+3orfY1NwbJWkGkmql2vPY4gKlljV4aCgbe+AnRc/HvE10gx588vFp/8lzqhvMRBTodAnMdgFGKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596255; c=relaxed/simple;
	bh=gUfOFimNWqS+txg/VKIj1VEHH7ReYiDf6Dti8FXEX0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRpUwGIQHb7+ly4R+JL62Yxrv3R3X2L7YhjiTghq33prlpsI2cFYh3fVAZc5Adye8JQfUXpxM9w6A0dYMw3rfQ0+Lm7yPZIWVA+Tuzme7cXwwZLYku5POd4nVIA0LCttracdpzIYS2mNStYf64NXT/1wbwp06Z1/jEGL/7BlmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TQglB+nv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso1176252a12.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719596251; x=1720201051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bhKxRptn8THR4sr6GT/1kQFhqZdRtRQrOVfOK6gFvlQ=;
        b=TQglB+nvlKV3kGkQ//hiGKpPd0uIFt8ytie0ke0GtbBHUyXKX+GzXO57ejN9wqVfzC
         1wDVXxwn9V1N5kHiQuplOHLGQQUPoo25N1rP0QtRcKDyv9avmC5rEyfImHUhDE0OuTOv
         hLZMCoNeCaNpoODLVSJtZm6o7z59VQr5lrX4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719596251; x=1720201051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhKxRptn8THR4sr6GT/1kQFhqZdRtRQrOVfOK6gFvlQ=;
        b=TjkbmvJM23lgw2JcFriSKvuM1zl6+LMLEfxnLyLhnTeyQqE+BL0To035Y306wY1WLA
         NjyP+RbybXuB8pV+VrV8/7iel/2HBEg8bUc4qqGS4B6TWgnV1cR0dG3X6h3yq4mnT9D+
         EFCBNOr1Kx3QyqY+RBk4PgQl5/ZTOd5hS2c2GXSXfhFizvssG3sE08+ceXJOdet3sSqt
         ODJxa1bfeyPIpOL9hmALWcqAPf3UZ4gQfAjkfX4cN2nyE3Mm42oQjUzDlV4GqIvYzTD1
         9++49AD7j87XqhCWbxmUbgxN/fZYactjNeDuz8odQmu41XaThXWzasUzFdzZnOhSgnyS
         8ydQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKdKZjTEeUzK49OJ9e8GDg9BTGzyMOJYZrFnt59+Np/hw5V2Jsztq2cXUx/tkMo6lzk/SnJpqY/8otdkUL0QOxLtV+ppWd
X-Gm-Message-State: AOJu0Yw9GsRn5uuIYpKl/Kqh3vQHbJ7NT6kUVQD/EVKUbaMBHMcAuwHh
	wSyERYMZfl8k5TEb0RdS0QuL34yy+NcdUS0J5dMEkvrX7vjSJcQHb8eq9LzCYRAeZRLBv1xfgny
	OG3PZ4DUoZv0neeUGfjzkMDwbv176gvaDmR7wHPOEKNPte9lJ3A==
X-Google-Smtp-Source: AGHT+IHrsGl+Osl6Q0We8QPBdMGZJalF0IMWaNq5sMVdAycOkzYThpT0x3zN+vNfHAu6aPw5j7uq72/12wOnqf4v2I0=
X-Received: by 2002:a50:9f8d:0:b0:57d:1627:93ed with SMTP id
 4fb4d7f45d1cf-57d457a1540mr13390723a12.22.1719596250935; Fri, 28 Jun 2024
 10:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626164307.219568-1-michael.chan@broadcom.com>
 <20240626164307.219568-10-michael.chan@broadcom.com> <20240628170318.GK783093@kernel.org>
In-Reply-To: <20240628170318.GK783093@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 28 Jun 2024 10:37:19 -0700
Message-ID: <CACKFLikv==pNi2i9FbpQ-qOJofPxq6eoj5j_9bA_bqRBj+NV2Q@mail.gmail.com>
Subject: Re: [PATCH net-next 09/10] bnxt_en: Increase the max total
 outstanding PTP TX packets to 4
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, richardcochran@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c1187d061bf6b393"

--000000000000c1187d061bf6b393
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 10:03=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Wed, Jun 26, 2024 at 09:43:06AM -0700, Michael Chan wrote:
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index ed2bbdf6b25f..0867861c14bd 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -457,8 +457,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >       unsigned int length, pad =3D 0;
> >       u32 len, free_size, vlan_tag_flags, cfa_action, flags;
> >       struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
> > -     u16 prod, last_frag;
> >       struct pci_dev *pdev =3D bp->pdev;
> > +     u16 prod, last_frag, txts_prod;
> >       struct bnxt_tx_ring_info *txr;
> >       struct bnxt_sw_tx_bd *tx_buf;
> >       __le32 lflags =3D 0;
> > @@ -526,11 +526,19 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff=
 *skb, struct net_device *dev)
> >                       if (!bnxt_ptp_parse(skb, &seq_id, &hdr_off)) {
> >                               if (vlan_tag_flags)
> >                                       hdr_off +=3D VLAN_HLEN;
> > -                             ptp->txts_req.tx_seqid =3D seq_id;
> > -                             ptp->txts_req.tx_hdr_off =3D hdr_off;
> >                               lflags |=3D cpu_to_le32(TX_BD_FLAGS_STAMP=
);
> >                               tx_buf->is_ts_pkt =3D 1;
> >                               skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_P=
ROGRESS;
> > +
> > +                             spin_lock_bh(&ptp->ptp_tx_lock);
> > +                             txts_prod =3D ptp->txts_prod;
> > +                             ptp->txts_prod =3D NEXT_TXTS(txts_prod);
> > +                             spin_unlock_bh(&ptp->ptp_tx_lock);
> > +
> > +                             ptp->txts_req[txts_prod].tx_seqid =3D seq=
_id;
> > +                             ptp->txts_req[txts_prod].tx_hdr_off =3D h=
dr_off;
> > +                             tx_buf->txts_prod =3D txts_prod;
> > +
> >                       } else {
> >                               atomic_inc(&bp->ptp_cfg->tx_avail);
> >                       }
> > @@ -770,7 +778,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >  tx_kick_pending:
> >       if (BNXT_TX_PTP_IS_SET(lflags)) {
> >               atomic64_inc(&bp->ptp_cfg->stats.ts_err);
> > -             atomic_inc(&bp->ptp_cfg->tx_avail);
> > +             if (!(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> > +                     /* set SKB to err so PTP worker will clean up */
> > +                     ptp->txts_req[txts_prod].tx_skb =3D ERR_PTR(-EIO)=
;
>
> Hi Michael
>
> Sparse complains that previously it was assumed that ptp could be NULL,
> but here it is accessed without checking for that.
>
> Perhaps it can't occur, but my brief check leads me to think it might.

Simon, thanks for the review.  The key is this if statement:

if (BNXT_TX_PTP_IS_SET(lflags))

This if statement is true if the lflags have the TX_BD_FLAGS_STAMP
set.  This flag is set only if ptp is valid because this flag tells
the hardware to take the timestamp.

>
> On line 488 there is the following:
>
>         if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
>                 goto tx_free;
>
> Which will lead to the code in the hunk above.

The lflags will not have the TX_BD_FLAGS_STAMP flag set if we jump from her=
e.

>
> Then on line 513 there is a check for ptp being NULL:
>
>
>         if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && ptp =
&&
>             ptp->tx_tstamp_en) {
>
> And ptp is not set between lines 488 and 513.
>
>
> Sparse also complains that txts_prod may be used uninitaialised.
> This also seems to be a valid concern as it does seem to be the case
> on line 488.

Same explanation for txts_prod.  txts_prod will always be set if
lflags has TX_BD_FLAGS_STAMP set and this condition is false:

(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP)

--000000000000c1187d061bf6b393
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG5Cm4RlidM29EvqOqGYboS3j/VUsGVg
VlJ/pL3Uka1fMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
ODE3MzczMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCunRVDGpdiLTNIzcqKetVnjx5MfnZqMvQ1DZZThzRQzwVZ+q0w
vfag97uQQqmGCky6vcLQ2kJi9D6llcGCNwG3L80CgxMDdM2vED4Y/3slbQ1SHw01qFh21UPTnQqE
DgwbkFN41jawonyxRSKqKEtbT7/pancVocS0O2+3ZHSiUvFopPbqw8daWoGDr4gARohN8Gce1nWA
AmCAHIWxurp6wxWtlUzCevTCYHDE+fBqxlHLqAWBTl5ZR8RUR3cvleAZi3RKlZX3VIOwmm2w0FfY
cPfAi4y7vZWHUrJM3Y5040jx2IkcWVQGuf7aIaJPdCR4mp2ZPqKIW6bpkF4a/lzl
--000000000000c1187d061bf6b393--

