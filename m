Return-Path: <netdev+bounces-116691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0B94B604
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBD5283D17
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761A12DD88;
	Thu,  8 Aug 2024 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd8LIhoA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEAB83A17
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723092857; cv=none; b=nuEZly7QUuCkbLqH9GV/jIz6jcUXqNvxAOrjFeMFIY7z6qlNbFVM+VUAkiijhEgT1Ao3z1qDU82/BH7i+xdDMcHjC/WaEwY68L9S02QptO8aZAfBoZRN5XMnZriK02hjWmtPZ1n7xnBWgPTbXt7kBAor6ySNZ0DL/FkhKKJ+ZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723092857; c=relaxed/simple;
	bh=7YSzCk1x0lHqAwjDor8GeWE/OSdIDFIRLEbOD4s+Lvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJgCb6FBo2TfVqzk0Rk+yPZUgiFerH61RgzASIXkkfIpW/O3tUqN4nsYT4M6pYJJo8IvNiCvOIE13azdTj+W8ZSATiJ24j9xIiq2zhg/RGDMempDtpanNyKOUrim4lsLGHWEspA69YpGg3qvrVd3EWc84ONn72Ahybsy/A9Vp+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wd8LIhoA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723092855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGxD/J7yLslw467eIYb7KFvZb5Ntx0WCR07t6fDsHCo=;
	b=Wd8LIhoAA05IUKik7LoO2U2favb25fMXkb+sAtSwphG0O5EkPxdhgqsFdY9tOqaFXBMCZl
	hNGge4Xnt9wstxQqDViPhr+eDzDZTE5XB8K5VfBTVnLTsuW4//iNm5BjI5aeF/0bUy4SAo
	MgUZn3qgh+RFonBrtw7rh/Vlf/NzooU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-hNpRSWJCO46RDWrUdtnEcQ-1; Thu, 08 Aug 2024 00:54:11 -0400
X-MC-Unique: hNpRSWJCO46RDWrUdtnEcQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3688010b3bfso435317f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723092850; x=1723697650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGxD/J7yLslw467eIYb7KFvZb5Ntx0WCR07t6fDsHCo=;
        b=Ry5PAK07Kdq32l8cUZ0vcef7Pb1RthFoQcar96/nQy10V870VuT7jryB015eLRwWQM
         9aGx1BrE4dihhTv1Ll2plo4AECxbjB6aJor7UzGT8ur11f0dJEvG0Wj857CAc3nZEozE
         hM3ObMX0NiJGc8iHfl2NyQ2HJQjhteXpzM1oqWM0TiBfEtK7ZMqDZeviqi6WCiOB7Sne
         xgab8AAgWOpH+UyTC6MTdibhdRpceSWkfypsBBI0uf7uAoNshano0Vs8W66eTVSGwEq9
         wC4Q1xVOEdadvh0cyB8S78N9xsdj5MCcmgs6y1kbrzbZQyjeZ+c8iO9PR2bhOTWzKYm/
         UYTA==
X-Forwarded-Encrypted: i=1; AJvYcCUQhN64p2Emi8PfpEHdAcz1ouZyGy9N99zJHxnw8Y2hlETd7RGx/9TG1Vw7lwnLKIprCV0Af6SAcgYceTcdVFr/ue/K7koC
X-Gm-Message-State: AOJu0YyF8FteoiDH9YBEYQTc5pB4BFNsK3YVWxzGR7W1YIuuMxlKCOT8
	wJh7U7irqfc+QWpVSwtAAJPYpE2bIuQymxlHWGsTw0oS4jBlYL31Mtmtb+y6hfTsZ5zzGwYGv05
	11KR5/hqzjmwu53J0+B6Rx8JFVznFLnLHBsORweanfeo66aA1DUkKfA==
X-Received: by 2002:a5d:4f05:0:b0:368:3384:e9da with SMTP id ffacd0b85a97d-36d275ce9a7mr428245f8f.62.1723092850048;
        Wed, 07 Aug 2024 21:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxcuyBS6WGfohjX62xojVV6mMc4LlSUlv10jMb/ThanMzMeAKJEdX/KoyeeG9vRzfcx6bY1A==
X-Received: by 2002:a5d:4f05:0:b0:368:3384:e9da with SMTP id ffacd0b85a97d-36d275ce9a7mr428232f8f.62.1723092849508;
        Wed, 07 Aug 2024 21:54:09 -0700 (PDT)
Received: from localhost (53.116.107.80.static.otenet.gr. [80.107.116.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2716befbsm594845f8f.27.2024.08.07.21.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 21:54:08 -0700 (PDT)
Date: Thu, 8 Aug 2024 06:54:06 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"toke@redhat.com" <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to GRO from
 netif_receive_skb_list()
Message-ID: <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BrzZC+NstxqLld0s"
Content-Disposition: inline
In-Reply-To: <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>


--BrzZC+NstxqLld0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Alexander,
>=20
> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
> > cpumap has its own BH context based on kthread. It has a sane batch
> > size of 8 frames per one cycle.
> > GRO can be used on its own, adjust cpumap calls to the
> > upper stack to use GRO API instead of netif_receive_skb_list() which
> > processes skbs by batches, but doesn't involve GRO layer at all.
> > It is most beneficial when a NIC which frame come from is XDP
> > generic metadata-enabled, but in plenty of tests GRO performs better
> > than listed receiving even given that it has to calculate full frame
> > checksums on CPU.
> > As GRO passes the skbs to the upper stack in the batches of
> > @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
> > device where the frame comes from, it is enough to disable GRO
> > netdev feature on it to completely restore the original behaviour:
> > untouched frames will be being bulked and passed to the upper stack
> > by 8, as it was with netif_receive_skb_list().
> >
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---
> >  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 5 deletions(-)
> >
>=20
> AFAICT the cpumap + GRO is a good standalone improvement. I think
> cpumap is still missing this.
>=20
> I have a production use case for this now. We want to do some intelligent
> RX steering and I think GRO would help over list-ified receive in some ca=
ses.
> We would prefer steer in HW (and thus get existing GRO support) but not a=
ll
> our NICs support it. So we need a software fallback.
>=20
> Are you still interested in merging the cpumap + GRO patches?

Hi Daniel and Alex,

Recently I worked on a PoC to add GRO support to cpumap codebase:
- https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016da5a=
2dd9ac302deaf38b3e
  Here I added GRO support to cpumap through gro-cells.
- https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72401c74=
14c9a8a0775ef41a55
  Here I added GRO support to cpumap trough napi-threaded APIs (with a some
  changes to them).

Please note I have not run any performance tests so far, just verified it d=
oes
not crash (I was planning to resume this work soon). Please let me know if =
it
works for you.

Regards,
Lorenzo

>=20
> Thanks,
> Daniel
>=20

--BrzZC+NstxqLld0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZrRPagAKCRA6cBh0uS2t
rK0FAQCwzPqU/L+8uGaMYta8IEEG8is+yCbIYKNDjVPfsabMBwD8DTd1Xi5dSpFL
Lj2cZ9irZxRYcLz+GkmnAHDga5i2+Qk=
=Oc7V
-----END PGP SIGNATURE-----

--BrzZC+NstxqLld0s--


