Return-Path: <netdev+bounces-165368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A482A31C13
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D712B188238A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5542AF1B;
	Wed, 12 Feb 2025 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U38ppGdf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68373271817
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327497; cv=none; b=gNlRpBGRvm0sBbfG4PsgGNKDKPFWeh1n3kjWIJRtFLi1FVZxYYEtMkloHemqorivp1rH8y22hrqGZKSMGdtm4Gzo8aAwXHuZow8I+VQ9bQZlIGm/Ae7TBIesC5H/mV/RaH/NSSOIXjPStRfR9tSjitKQAOKNlJvX18wUEQSNymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327497; c=relaxed/simple;
	bh=eo3wLUwhBmcOz/Oe33WpzD5W+tGA19ZexWX3W+MC9kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heAeIPlNwOgdU5UvE56OiZH9TagoXDYxhh8916iIeA4xVytiOkqIx0/cjIKI3nejmBbbJovC/CJ6BplWGiBW9pE++/tpuR+GwiaLaFKVBskJoV8MhIiV49nnTl2D3DV0QIfkCXWDqBnbVRv9erqOGc6hiFV3Bx4E2LkFEBuDMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U38ppGdf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7d3bcf1ceso372996566b.3
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739327494; x=1739932294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jEJClt2k4Vmv1QsMA4NHlYUHw/TYZVwCPi3mj7Yr2zY=;
        b=U38ppGdfuB2D+Be8/r/f48CM+OnAqcyKH7bKYCTDFrsP0ChE+m8VxyWRSKtKVK302/
         3p5x34eINooyt29tectsLwlHdgHx97pU6uF3qrBdT2SrZRLR183UfPaeFpZny6O5GcBS
         DeItOA85qHrEp74mIc+HZ3Y2iZNd14G4PQ0l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739327494; x=1739932294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEJClt2k4Vmv1QsMA4NHlYUHw/TYZVwCPi3mj7Yr2zY=;
        b=D+Me4Yb2GRs6n5404PkwEMGLrgGu5ZOIpYb07HZYYjkpfqx1voBMbGf4gBFHRvfTcN
         DhD+fv5VnEzrX5D4+3d2yuyp1RWZtPBpDVtyhjwAkZHrrggxq5+KIGucq4S7qtLD9xzP
         YyRzl1m47a+DaghEiaenPffwXzuN3IUcEx+ndE7ueII/AEVOb4VjAseYYFcV8uWo2G4O
         pH6RSgQ7YqrpRoRRDxhdL37Q0Pm8Pn5CuzCrMY6+MkNL/SDEvk5tc9QjilW/J18GiGGK
         vK8Zwr+GiD2KiNdN4O1c78/O+SDzG3W4WaXfi/pcqtRG08UXQEe0LZCvFOvuxDfOvHol
         3G4A==
X-Forwarded-Encrypted: i=1; AJvYcCUWZjuaiQLUuWL5ytiU2se0onjV/O5+YMUkD9qpcySIKdJjN89dJxb9oxFo45xpFwA4hsQ3Ans=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Q1T48klZ4nmb4YEPfcEKIpkEzSsEBs8vIORAVu75Y7eD99XW
	byy1ZwMJ9vliTJqpbzJsdP+NDugeZABrtfSexaUOqW1vVK8bobGgYj/lfCBc5pPBbCYO/sZXl43
	dGX+5or3bWfns1I2PLdsNh40P8gt+bCWVoTTQ
X-Gm-Gg: ASbGnctdozN5N/s6wwaq/n8GT227TLfjcihdDSoSTNrvCGoZARMUjWjgXywoGV2yuxw
	8cBzqucBkXM/LtQBXcRdFVVWNarxu0v2dGwans+tkW2y9m7VZeqqfJhWeTbkeIcWlNsGVeCM=
X-Google-Smtp-Source: AGHT+IGZzDgYZzri5cLyQ9YfZ1qMxSJ42XJL8epEE5Fh7WkK4uMByLuSC45LYm9P2oFVcUWWy7MQuVwlVQHjKL0yW4w=
X-Received: by 2002:a17:907:1c85:b0:aa6:9624:78f1 with SMTP id
 a640c23a62f3a-ab7f3714978mr114404566b.9.1739327493592; Tue, 11 Feb 2025
 18:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208202916.1391614-1-michael.chan@broadcom.com>
 <20250208202916.1391614-10-michael.chan@broadcom.com> <20250211174438.3b8493fe@kernel.org>
In-Reply-To: <20250211174438.3b8493fe@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 11 Feb 2025 18:31:21 -0800
X-Gm-Features: AWEUYZlzSgRZDo_iS0D-Tch2bCdpuA3XymOG1r3romYuCMFcD0Riiiur7NhhwYU
Message-ID: <CACKFLi=jHfL2iAP-hVm=MmLDBD+wOOHrHsNNM21dCRAjRu7o7A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 09/10] bnxt_en: Extend queue stop/start for TX rings
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, michal.swiatkowski@linux.intel.com, 
	helgaas@kernel.org, horms@kernel.org, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	David Wei <dw@davidwei.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006d9820062de8bd75"

--0000000000006d9820062de8bd75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat,  8 Feb 2025 12:29:15 -0800 Michael Chan wrote:
> > +             rc =3D bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
> > +             if (rc)
> > +                     return rc;
> > +
> > +             rc =3D bnxt_hwrm_tx_ring_alloc(bp, txr, false);
> > +             if (rc)
> > +                     return rc;
>
> Under what circumstances can these alloc calls fail?
> "alloc" sounds concerning in a start call.

The ring has been previously reserved with FW, so it normally should
not fail.  I'll need to ask the FW team for some possible failure
scenarios.

>
> > +             txr->tx_prod =3D 0;
> > +             txr->tx_cons =3D 0;
> > +             txr->tx_hw_cons =3D 0;
>
> >       cpr->sw_stats->rx.rx_resets++;
> >
> > +     if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
> > +             cpr->sw_stats->tx.tx_resets++;
>
> Is there a reason why queue op stop/start cycles are counted as resets?
> IIUC previously only faults (~errors) would be counted as resets.
> ifdown / ifup or ring reconfig (ethtool -L / -G) would not increment
> resets. I think queue reconfig is more like ethtool -L than a fault.
> It'd be more consistent with existing code not to increment these
> counters.

I think David's original code increments the rx_reset counter for
every queue_start.  We're just following that.  Maybe it came from the
original plan to use HWRM_RING_RESET to do the RX
queue_stop/queue_start.  We can remove the reset counters for all
queue_stop/queue_start if that makes more sense.

>
> > +             rc =3D bnxt_tx_queue_start(bp, idx);
> > +             if (rc) {
> > +                     netdev_warn(bp->dev,
> > +                                 "tx queue restart failed: rc=3D%d\n",=
 rc);
> > +                     bnapi->tx_fault =3D 1;
> > +                     goto err_reset;
> > +             }
> > +     }
> > +
> > +     napi_enable(&bnapi->napi);
>
> Here you first start the queue then enable NAPI...
>
> > +     bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
> > +
> >       for (i =3D 0; i <=3D BNXT_VNIC_NTUPLE; i++) {
> >               vnic =3D &bp->vnic_info[i];
> >
>
> > @@ -15716,17 +15820,25 @@ static int bnxt_queue_stop(struct net_device =
*dev, void *qmem, int idx)
> >       /* Make sure NAPI sees that the VNIC is disabled */
> >       synchronize_net();
> >       rxr =3D &bp->rx_ring[idx];
> > -     cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
> > +     bnapi =3D rxr->bnapi;
> > +     cpr =3D &bnapi->cp_ring;
> > +     cancel_work_sync(&cpr->dim.work);
> >       bnxt_hwrm_rx_ring_free(bp, rxr, false);
> >       bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
> >       page_pool_disable_direct_recycling(rxr->page_pool);
> >       if (bnxt_separate_head_pool())
> >               page_pool_disable_direct_recycling(rxr->head_pool);
> >
> > +     if (bp->flags & BNXT_FLAG_SHARED_RINGS)
> > +             bnxt_tx_queue_stop(bp, idx);
> > +
> > +     napi_disable(&bnapi->napi);
>
> ... but here you do the opposite, and require extra synchronization
> in bnxt_tx_queue_stop() to set your magic flag, sync the NAPI etc.
> Why can't the start and stop paths be the mirror image?

The ring free operation requires interrupt/NAPI to be working.  FW
signals the completion of the ring free command on the completion ring
associated with the ring we're freeing.  When we see this completion
during NAPI, it guarantees that this is the last DMA on that ring.
Only ring free FW commands are handled this way, requiring NAPI.

--0000000000006d9820062de8bd75
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIP9fIHe9CTted7oswJ3DRbqylqR3yqDX
9qnZgERa7c3XMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIx
MjAyMzEzNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCxAcaboTe0GFys8tGyyi87Ibd2yMQFSNWWREFnC23xd6ew4UDH
sL4WKoVxRvWRFJYVXRdRH9VhZs7o50j8iv2+FZkt63K0kSAuCN2CagyCRcCAgn94xkL+zwtpg5qf
5zARlBgBF1M4cevMTK57O18OTutuU7+NwEpYVkRDb9P3nIoiAfB8+9X3AH8oYna1FGsvSvOMW3ug
rKS9frr+mR3FkL0LXf3x8mhaLXlubxzDIxXBs7/wAaYaV8qd/RsSON4P2jy1jbijZxyKQEZHnTlc
9iz+qsp1IF0Hex/rwzTtS0MfmUXRhfCK+Dc3wvRFQElFNi0NKwpLgkjR0wyWJPHA
--0000000000006d9820062de8bd75--

