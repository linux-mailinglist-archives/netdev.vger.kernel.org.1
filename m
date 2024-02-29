Return-Path: <netdev+bounces-76004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F07086BF87
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15992885B7
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 03:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F2364D8;
	Thu, 29 Feb 2024 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OAhY5is0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF0E1F95F
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178016; cv=none; b=O6bCOgNzHL7+UNDhibZMbWp9qr64t/mP3qp99LHggyVbyK9qTiE6u7fkA9bGczPPvkwTINg6UwaFvhNwrGhSVgjAIz/+vejCOQgCVA9naez6lTJt4Z+ASkEBq0o7jxmjXHYBpudzJ3f/Emk7EW/wJ5imeFLJz4aGaQB6nzDswes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178016; c=relaxed/simple;
	bh=v40dIjRDr8kjo3gCGODG+v6pS2lOBexrI4kUGuXi5jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUgDTfgzwWhTdy/r4N3/S6vdobIgD3Cac7NjeRmQIDMpxckJABifqNC7gjWxv5eLXAgO+yLHFMfEnyUQOjtr7hYTbGmL4BKoH6zIxXrEfvo5yacXr06k5vxbikiykGQgzdpHqsZKCFWh1YwAvdD6IYIFYSItSN77mBz62D2vqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OAhY5is0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso528957a12.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 19:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709178013; x=1709782813; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpCI5MpFuYW7E3F7aDMsb235mA9ytI+3GvIaB441NHo=;
        b=OAhY5is0NDZBuecgtF6sFbn4/u7RyTmqNCmuRALKwDVeTrCUTqfe3tAHEd+u9YAajo
         2RK7O5tEy4lGYFQ+TJWLMJBMRiBeAA8KQhhK3v+d3iSnsMBh33UQhUY8vQO9lh1aXBC3
         AQSUIpPpZrwf2V1pFfgx7KapIxWB57TKAzLVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709178013; x=1709782813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpCI5MpFuYW7E3F7aDMsb235mA9ytI+3GvIaB441NHo=;
        b=hJhB/dq03xnJXxxBeCy0pIwCJe6sQIahDJLakcHrCZxVbAODeCLOkto2fv+Mn0GvxM
         CIz77xYJfluuE190K20QEo5CE3dPIZI9aXZmY+G5A4N3VMXlw5f37uq8chVVT/bsKJVu
         FiHDxJIRDx+LDAR+8B1j7AJWnImlv16j/PAJv2nK1US9thyVc+tUSYGdoTp4AR7zo5tu
         R1296SOX4oNJeBQAiycOQOhnL9iXLMs8B1v/wYSPANL+ydm2tn4bcB1xuDkFBryIqPFt
         l2AEzY0rsozk2YGoflItAZgo4m+W3uQawPg/CwYw+Q2TavOAf+Evh3N7pkWjRMp888NB
         TGrw==
X-Forwarded-Encrypted: i=1; AJvYcCV+we4cwHEtFNjYib5ox+LbZqzgeb+L63N2XyfkGl5ZJFBJi9f4B1nvO9TjLmJYmSL5xKViHiVECeY8aE8gOrw0f4BtGfyb
X-Gm-Message-State: AOJu0Yw2KMM7dhcu+IsTUdv+D6vYAh5DKey8wQM/jhcdknb6LJgCEvn6
	SwfkGzPYXqrRnuAOKDNx8I45CiKj+df+hSlbMnrwhyqyFs3Yy27sdjTU8yUYt8DSzjjBNsjbZ5w
	dtVaQ8mknKctZeh+4abHR0du8Law0P8cH8OFT
X-Google-Smtp-Source: AGHT+IH9ASQqg1dJBcUfQkqBUmGEH3sdYGdm0tEO1KjU1SxI2P81UExPhFB1U74C5+z0lOa3oqHBvZMtDxrwcfYqYU4=
X-Received: by 2002:aa7:ca58:0:b0:565:6e34:da30 with SMTP id
 j24-20020aa7ca58000000b005656e34da30mr446729edt.21.1709178012798; Wed, 28 Feb
 2024 19:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010221.2408413-1-kuba@kernel.org> <20240229010221.2408413-4-kuba@kernel.org>
In-Reply-To: <20240229010221.2408413-4-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 28 Feb 2024 19:40:01 -0800
Message-ID: <CACKFLin4dUL9eOrH_=sZpc26ep5iZe5mgOHAxyWEAHwVWuASTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] eth: bnxt: support per-queue statistics
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, amritha.nambiar@intel.com, danielj@nvidia.com, 
	mst@redhat.com, sdf@google.com, vadim.fedorenko@linux.dev, 
	przemyslaw.kitszel@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000563d5306127d041f"

--000000000000563d5306127d041f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 5:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Support per-queue statistics API in bnxt.
>
> $ ethtool -S eth0
> NIC statistics:
>      [0]: rx_ucast_packets: 1418
>      [0]: rx_mcast_packets: 178
>      [0]: rx_bcast_packets: 0
>      [0]: rx_discards: 0
>      [0]: rx_errors: 0
>      [0]: rx_ucast_bytes: 1141815
>      [0]: rx_mcast_bytes: 16766
>      [0]: rx_bcast_bytes: 0
>      [0]: tx_ucast_packets: 1734
> ...
> +
> +static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
> +                                   struct netdev_queue_stats_tx *stats)
> +{
> +       struct bnxt *bp =3D netdev_priv(dev);
> +       u64 *sw;
> +
> +       sw =3D bp->bnapi[i]->cp_ring.stats.sw_stats;

Sorry I missed this earlier.  When we are in XDP mode, the first set
of TX rings is generally hidden from the user.  The standard TX rings
don't start from index 0.  They start from bp->tx_nr_rings_xdp.
Should we adjust for that?

> +
> +       stats->packets =3D 0;
> +       stats->packets +=3D BNXT_GET_RING_STATS64(sw, tx_ucast_pkts);
> +       stats->packets +=3D BNXT_GET_RING_STATS64(sw, tx_mcast_pkts);
> +       stats->packets +=3D BNXT_GET_RING_STATS64(sw, tx_bcast_pkts);
> +
> +       stats->bytes =3D 0;
> +       stats->bytes +=3D BNXT_GET_RING_STATS64(sw, tx_ucast_bytes);
> +       stats->bytes +=3D BNXT_GET_RING_STATS64(sw, tx_mcast_bytes);
> +       stats->bytes +=3D BNXT_GET_RING_STATS64(sw, tx_bcast_bytes);
> +}
> +

--000000000000563d5306127d041f
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN0A7OW05v/ChwJ6f2lRvK8jTkfpcFEd
DRhXpqB8IT+/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
OTAzNDAxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAtNxpEmhdmnXaGWqEcotlQykc6xKvGVWUcMvgyVUPTemzHWwFt
HMHE3vPvwgcdvY1ZFjcZNWRwC+fFGHamLzzvk02nZItPMc2MDjTQoJnNrozvjY4f+RXJwp3ZfmyV
nIOk6hSB76PcZC8w4d3d0ab8Oo0dFijwr5naLfOu+CYCy9sUICliaB/5s+UarC4jNdro1InHV7oj
ScchUTWpGls6eTSdf94OhICS4y/8YLefexKjdx5pUSgcxcOT8aUjdSRNqHuJh59ilwaqhP/mVhHq
AlzQHNJhwVodKUOOA5uQ7nwazXVrXmAb+yBzIVQbUoC7AhFp9X5WSurSdiGNnCHb
--000000000000563d5306127d041f--

