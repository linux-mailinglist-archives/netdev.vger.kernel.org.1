Return-Path: <netdev+bounces-127618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD0975E18
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1141A1F239B7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5121D2119;
	Thu, 12 Sep 2024 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YdzZJrDn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C547F9DF
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102037; cv=none; b=SYQDprYnCkrUWAovGIdzKMABBHimzzg1MZK60JnBc5kMwl5OOCNQ34W2F8BUF5uGDRUIJCCdpFD27NOgmlgDZ44+co5zkqjFEkJ/R3eJ/biy8BIuVtVOt0u3fjatVmJRZoLfwCWe5STwdu2nybK9P1nc+WWEDNT/z0nLxQy5K+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102037; c=relaxed/simple;
	bh=DstfjD5L9Wo5UYpSOlp770Al0lLhTASRbbG0RNz8qtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgfjgcGEKtEHyoODSTU5JQxrAwnJEh1DnopXOpjwXoGcLjXhjOKitPYEf4u4bkM6H7olRwpEHyAglP30jqJXGBcqNnLEd6NrF30g/jqy0dWMqDqQ+YmsHGbDVj956lwisU8dv/uqcXWmJQuRX0ri8IDS2efBomOKkDkYAZig0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YdzZJrDn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374ba78f192so325860f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 17:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726102034; x=1726706834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2An7Qy1lj7E9DcOV2k+Q6oMIt5Y2hf1cToysbqFsMsE=;
        b=YdzZJrDnvPc2Xov8KefWQb9koN67zLy3HFaIM7nXDzUTBrafBUqSkRJYbX/XdzVCTk
         ZVYhW369DMt7jKS6d64fuerHlaIrDqdhBjlrmUtGSf5wVE/0ct1fqkN5H64UbDbSHeVR
         LvwUYfnmxdjd6BgND5B22xWSN/SEtvDhh5GEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726102034; x=1726706834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2An7Qy1lj7E9DcOV2k+Q6oMIt5Y2hf1cToysbqFsMsE=;
        b=ptnbCNIui+VMpok8Zo86uqULtYVTRjfr0OpAelaUA3pncc39e3V0j+dK4IcD8yX7ZL
         IaMWhzRxA8h3KvbpmKlElrriUhuBOjmlKwfQpKuzKpuTjd0Bi+v8d6ZPvIpZFSe3pYr3
         9ebmc7Z0VFnmOcxrhmboorkGr382TXHdj/hSOcd/WTGiOCt41ODbAvgHnujjyvCShykk
         angelkUkNEmBUJgmrEFsw8NSZe0Vyfk7vYMvisbtiDu5ILYD04RFBP8X26jwZvQC6kYB
         oudjE5L8xf8msghV2xJHp2wUt7h59mTpjeK91PYmKP84kslFL7HqqYzwigToUDxkgEwJ
         fdhA==
X-Forwarded-Encrypted: i=1; AJvYcCWIQN5kG60pASwDWGykh6LT1y/ZoxzSczBbNDqMarUFASOtmcTe/GMo7nFKSiuSuhAERMK0zk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTd4iJ4ASYCNVRaBiN0JRU8D/Vt+ow+2gFH9KU+ERiCaB6/ZL
	FvrSdngTe9osTzfaufysWJc8tTqIiwi6fpRXmCXxXNRybmudkEzsSj88FlyIUD3hK72KoO1CWT4
	qTS369cmE7DhybVFGc3yCnEV3rJfgOV6SAgi/
X-Google-Smtp-Source: AGHT+IHG5LSFY+B44+w6otdj7phQ/+6Jdt5LOICzLoQLMNhYsTBa7XkZBTmhfVuArwrtHhngcuHJlpHqp4+7ZrTcToU=
X-Received: by 2002:a5d:5d84:0:b0:378:c305:8f43 with SMTP id
 ffacd0b85a97d-378c3059085mr391146f8f.18.1726102033611; Wed, 11 Sep 2024
 17:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911145555.318605-1-ap420073@gmail.com> <20240911145555.318605-2-ap420073@gmail.com>
 <a5939151-adc6-4385-9072-ce4ff57bf67f@amd.com> <CAMArcTVH9fRU3kHf8g4U+e3fawMGiBNy1UctWG1Ni5rS=x6QQA@mail.gmail.com>
 <20240911172251.4d57b851@kernel.org>
In-Reply-To: <20240911172251.4d57b851@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 11 Sep 2024 17:47:01 -0700
Message-ID: <CACKFLimx-R5OV-3=oZkVBTtyN8jhR7w_YW6VVu6EA7D8vSWHRg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] bnxt_en: add support for rx-copybreak
 ethtool command
To: Jakub Kicinski <kuba@kernel.org>
Cc: Taehee Yoo <ap420073@gmail.com>, Brett Creeley <bcreeley@amd.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, corbet@lwn.net, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	kory.maincent@bootlin.com, ahmed.zaki@intel.com, paul.greenwalt@intel.com, 
	rrameshbabu@nvidia.com, idosch@nvidia.com, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, aleksander.lobakin@intel.com, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000980d7a0621e172b6"

--000000000000980d7a0621e172b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Sep 2024 00:53:31 +0900 Taehee Yoo wrote:
> > > if (netif_running(dev)) {
> > > bnxt_close_nic(bp, false, false);
> > > bp->rx_copybreak =3D rx_copybreak;
> > > bnxt_set_ring_params(bp);
> > > bnxt_open_nic(bp, false, false);
> > > } else {
> > > bp->rx_copybreak =3D rx_copybreak;
> > > }
> >
> > I think your suggestion is much safer!
> > I will use your suggestion in the v3 patch.
>
> This is better but Andy mentioned on another thread that queue reset
> should work, so instead of full close / open maybe we can just do:
>
>         for (/* all Rx queues */) {
>                 bnxt_queue_stop();
>                 bnxt_queue_start();
>         }
>
> when the device is already running?

If the copybreak value changes, I don't think queue restart will work.
We need to size and allocate the buffers differently than before, so I
think we need to do close/open.

--000000000000980d7a0621e172b6
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPZRMOTYtf5MDMKj9VJZyEG4cJcRvPvI
Cf9i1Jj5b8tHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkx
MjAwNDcxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAhj7KXFbOQm5SgaILL0Lql4CluUAOYC2TKJr4K6qwyKX949lFG
WTBJ+7dI7f1dLXjisUWRB9rfdox964tnh6e3UjfxHZ9cQEX+NG1Nuek6MoebtV/C/BWaVEAaJVpm
zPimGLSn1D/Rfm4kfdk97Pb+DSR7nWZedD3rGiZqTdypC+fZ1s+8TluHx8iOsxKJD3VO0b/Gw+6t
InZ5DveTG0uP1xlG8yLO7iE3Q1ZxS4HWdUJvrKN4uaa8laApSAN21IqiKv6IreRkkSZqZJpepYVF
CYQ9hMbAlB+CobMx/e6wnvv5QoRXhQq1pWVVADSuLFLa2Oj8HmBAWS2Zx75BvTqJ
--000000000000980d7a0621e172b6--

