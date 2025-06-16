Return-Path: <netdev+bounces-198037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208D1ADAF18
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF4C1643C1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D232E6D0B;
	Mon, 16 Jun 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAd1oNy7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4C2D9EE1
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074701; cv=none; b=Gqdf74xJLHZzFEPfRtAaG1LugyVW18kjOK0716cP5aL2r+7JwKfXMMNMbxnbUJ8snIIxbmUOHw4HcVpgfnB/GgeqdvTKGpS/7ZD6asVv/5I62C3oBF9WVlkpvhJceBJP5YVqqYKfCT/f6rjn3VwGAe+ObTFbfx0PkV6iTdzoJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074701; c=relaxed/simple;
	bh=recUC0kFFnGzEdaWQH7H0BilUe9FaISxYjWJllf5NjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CZw0er/lYKKVzhM6Bnd8rxlQdOhLqiH2hp5uXs3Fdg5Imskx9BXMBZ/Z+ZYeVJX6Id/tL+I0OPMjEAZkxGlCv9AnWjl8tovYID6kNcDT/7cgTiCWaA2s8r2WED9wZtwOsHYUsG/H4Oz2o9ljtONm6ypWlw2Quq9dQ8RDzxwzF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAd1oNy7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750074698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=recUC0kFFnGzEdaWQH7H0BilUe9FaISxYjWJllf5NjY=;
	b=VAd1oNy7agTryW0tTg+WOFT3w0wI0f/VHJ2lPuGlqEJrEEcx1vDbL2iutSKh2Oa2ZwEvNM
	muc1cHV1guLdrlcgEPFX6pw5ip4Re3/rqVwiFF09TN3ClbyWr7zKcVShFjCsP0HJ9x8N5P
	2DMHycoUEyuceGBAwRlsekPJKZXHC10=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-H64FNu91O6qe_MoHuiPfPA-1; Mon, 16 Jun 2025 07:51:37 -0400
X-MC-Unique: H64FNu91O6qe_MoHuiPfPA-1
X-Mimecast-MFC-AGG-ID: H64FNu91O6qe_MoHuiPfPA_1750074696
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-553af33d98aso1917957e87.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 04:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750074696; x=1750679496;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=recUC0kFFnGzEdaWQH7H0BilUe9FaISxYjWJllf5NjY=;
        b=Q7biSBT0j9LqWCFq+Lx1moxglI16eKll0kQpt9dbknyVfMze7zves6BnA92ZvBsBoo
         vL77iPGJ9mfJG7ekOUAoaeQ7bVfj17vSVT+/8nr2BJ0K6TzCm33fssxdEFxJAVSZ00EX
         tnPoGEma/PmeoVP6McY4+xVqhGk037m3Zy2pUGdAa8ZNV1jw4SySi2eBGWLefztlK4gB
         ZZgfMj8R84IyC8AleL7iHsURW0Bb6V0b0GMBWyuq+QPjwlBvod/XZdULI36SJ/pm0oMF
         y76Sl2FwYiZNvZQYtgY23u6Hzzpl/ydNsZjLRdUWLCaOKXwKi1dhcB7lrXBDFlTJKFGB
         4ZtA==
X-Forwarded-Encrypted: i=1; AJvYcCW/tjywPzHVpLJuYVoONqqYV0zY/kKMSMGXgOKCw9x0KGl7HyZP35WNr2fUangAhtv3uY7N4bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwxIekr8Wu3csUultfuQoYCDUjfWcY7PJ/7u5XK1gbOVEH2kS
	T92uuIay/9ym59vwapBlHCaX9nJmvpES9Pdbg+dOmdKzYR8xaNyX0f/74flK/s3WTwJQ2psbZvK
	jjyWYHGYZqUEVB50wZHBftYef45Zo0hKJQNvVdG+JVvDPmpMKMc0p25gbXA==
X-Gm-Gg: ASbGncuESYodvikTzwhWke1Cg/JXOjodZRqWCEn+NRANrbtsQXk/wRUIczXeUNEQlRQ
	uzmkKMfgQsfpN8ZaVcxLpBY/Ti6x59tCX2v+m0k1DvEtmSbtNzmpcYSvrP8oOv+Zt7gja3rNPsQ
	6ymCBz8IBEAPOG0ap5Z/g2ugxHkbfM3aPDa/6cXF9pnv1BcCenctNY6F1cBGwrGnzidsDZEKQM+
	FWk3kwzrDFE5U8Es69DkRZN1FOqsvMBaQp5n45EfNcwOrBu25kZ1TLpTDQfb73PgtfQS4adqDrJ
	d8LOqKK8MmOgR1M7vxw=
X-Received: by 2002:a05:6512:e9d:b0:553:b054:f4ba with SMTP id 2adb3069b0e04-553b682f08dmr2304072e87.12.1750074696117;
        Mon, 16 Jun 2025 04:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq1zDdCtdfik3lRAowzxz5xWaAFhlaXBXpx5e4xCVEJd3HNErL6veyBK7eMHOuxk7R+o8hsw==
X-Received: by 2002:a05:6512:e9d:b0:553:b054:f4ba with SMTP id 2adb3069b0e04-553b682f08dmr2304056e87.12.1750074695677;
        Mon, 16 Jun 2025 04:51:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac135c22sm1526086e87.65.2025.06.16.04.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 04:51:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4D6F31AF7026; Mon, 16 Jun 2025 13:51:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev
 <stfomichev@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, lorenzo@kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, sdf@fomichev.me, kernel-team@cloudflare.com,
 arthur@arthurfabre.com, jakub@cloudflare.com, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
In-Reply-To: <75b370cb-222c-411a-a961-d99a6c9dabe0@iogearbox.net>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk>
 <75b370cb-222c-411a-a961-d99a6c9dabe0@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 16 Jun 2025 13:51:31 +0200
Message-ID: <87zfe7lxa4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 6/10/25 10:12 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
> [...]
>>> Also, have you thought about taking the opportunity to generalize the e=
xisting
>>> struct xsk_tx_metadata? It would be nice to actually use the same/simil=
ar struct
>>> for RX and TX, similarly as done in struct virtio_net_hdr. Such that we=
 have
>>> XDP_{RX,TX}_METADATA and XDP_{RX,TX}MD_FLAGS_* to describe what meta da=
ta we
>>> have and from a developer PoV this will be a nicely consistent API in X=
DP. Then
>>> you could store at the right location in the meta data region just with
>>> bpf_xdp_metadata_* kfuncs (and/or plain BPF code) and finally set XDP_R=
X_METADATA
>>> indicator bit.
>>=20
>> Wouldn't this make the whole thing (effectively) UAPI?
>
> I'm not sure I follow, we already have this in place for the meta data
> region in AF_XDP, this would extend the scope to RX as well, so there
> would be a similar 'look and feel' in that sense it is already a
> developer API which is used.

Right, but with this series, the format of struct xdp_rx_meta is
internal kernel API that we can change whenever we want. Whereas
exposing it to AF_XDP would make it an UAPI contract, no? IIRC, the
whole point of using kfuncs to extract the metadata from the drivers was
to avoid defining a UAPI format. This does make things a bit more
cumbersome for AF_XDP, but if we are going to expose a struct format for
this we might as well get rid of the whole kfunc machinery just have the
drivers populate the struct before executing XDP?

Or am I misunderstanding what you're proposing?

-Toke


