Return-Path: <netdev+bounces-235731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE0C345CC
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 08:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BC7460AA1
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DED2287511;
	Wed,  5 Nov 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQNS0iq6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B322068F
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329189; cv=none; b=naqfvhehukCmBlleX2OzvUx8EDEnXL9nIMq8921sSd9TaA8S8bQulQh6r+0Nh+dykkGT7ecUG7ipYSbaNYm8Riic9dqhIYxnTnVMaEXO0pE6HoLwP3okN84j8O9VVvQIPduahavy+O0Q+k2zGkdKIcsEPB/BF0rpDv7rp2VXkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329189; c=relaxed/simple;
	bh=f1mDiB4caH6T0hXppSMfqh71s7Q4j8DIz8ZDVv+Hh+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN2ctO+R4XdW5X3DZMm7tlzFXe47rj/Ed345VQud3Zv4HZqB8qWubpcExhUOp1uiqPJs6JVgqFFYHpxhdauh8fhM374mlyRORpmaT0+lz1n2Rj2zhwEEl/AU91cmep4f43vJninhFPca/bFfGUbOBbSPFXozLo5RoM25RuMdhlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQNS0iq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924B4C116B1;
	Wed,  5 Nov 2025 07:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762329189;
	bh=f1mDiB4caH6T0hXppSMfqh71s7Q4j8DIz8ZDVv+Hh+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQNS0iq6cuzhMlF6th1dXepgkS2JWMiyqs9NLKnCFVzG/nmV29Cv5gyM7cVPQZvOG
	 ydwgZT3huCrlesuE712BNVUL60/aJr3zxfdUDejlZbhHRECwbrWqdNVAmDtzVQSz7Z
	 USLJrREJdOG1WOM3iw+332Yeg7nadVTNm7SdYzxiilIha073kS7cJWhYc+CGXDO1F1
	 jtixhB8/7GjzW8UAQCGCKgfD/YFHsjgVWKGAOSJ9aoY64ufJDZ+3CPab9QxEQ7Z8qi
	 210dzTCFxiQMY2kyqCpsiTXcJWvbzluEAFxWR8RU9oeVcssVSybDXasM3cWe/vQj/u
	 xxe+5GJ1Vs53g==
Date: Wed, 5 Nov 2025 08:53:06 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: airoha: Reorganize airoha_queue struct
Message-ID: <aQsCYoS-cvkUjrMv@lore-desk>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
 <20251103-airoha-tx-linked-list-v1-2-baa07982cc30@kernel.org>
 <20251104183200.41b4b853@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hWmCm/wRFf5QXlgL"
Content-Disposition: inline
In-Reply-To: <20251104183200.41b4b853@kernel.org>


--hWmCm/wRFf5QXlgL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 03 Nov 2025 11:27:56 +0100 Lorenzo Bianconi wrote:
> > Do not allocate memory for rx-only fields for hw tx queues and for tx-o=
nly
> > fields for hw rx queues.
>=20
> Could you share more details (pahole)
> Given that napi_struct is in the same struct, 20B is probably not going
> to make much difference?

I agree the difference is not huge, I added this patch mainly for code
readability. If you prefer I can drop the patch, I do not have a strong
opinion about it. What do you think?

net-next:

struct airoha_queue {
	struct airoha_qdma *       qdma;                 /*     0     8 */
	spinlock_t                 lock;                 /*     8     4 */

	/* XXX 4 bytes hole, try to pack */

	struct airoha_queue_entry * entry;               /*    16     8 */
	struct airoha_qdma_desc *  desc;                 /*    24     8 */
	u16                        head;                 /*    32     2 */
	u16                        tail;                 /*    34     2 */
	int                        queued;               /*    36     4 */
	int                        ndesc;                /*    40     4 */
	int                        free_thr;             /*    44     4 */
	int                        buf_size;             /*    48     4 */

	/* XXX 4 bytes hole, try to pack */

	struct napi_struct         napi __attribute__((__aligned__(8))); /*    56 =
  496 */

	/* XXX last struct has 1 hole */

	/* --- cacheline 8 boundary (512 bytes) was 40 bytes ago --- */
	struct page_pool *         page_pool;            /*   552     8 */
	struct sk_buff *           skb;                  /*   560     8 */

	/* size: 568, cachelines: 9, members: 13 */
	/* sum members: 560, holes: 2, sum holes: 8 */
	/* member types with holes: 1, total: 1 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
	/* last cacheline: 56 bytes */
} __attribute__((__aligned__(8)));

net-next + airoha_queue reorg:

struct airoha_queue {
	struct airoha_qdma *       qdma;                 /*     0     8 */
	spinlock_t                 lock;                 /*     8     4 */

	/* XXX 4 bytes hole, try to pack */

	struct airoha_queue_entry * entry;               /*    16     8 */
	struct airoha_qdma_desc *  desc;                 /*    24     8 */
	int                        queued;               /*    32     4 */
	int                        ndesc;                /*    36     4 */
	struct napi_struct         napi __attribute__((__aligned__(8))); /*    40 =
  496 */

	/* XXX last struct has 1 hole */

	/* --- cacheline 8 boundary (512 bytes) was 24 bytes ago --- */
	union {
		struct {
			u16        head;                 /*   536     2 */
			u16        tail;                 /*   538     2 */
			int        buf_size;             /*   540     4 */
			struct page_pool * page_pool;    /*   544     8 */
			struct sk_buff * skb;            /*   552     8 */
		};                                       /*   536    24 */
		struct {
			struct list_head tx_list;        /*   536    16 */
			int        free_thr;             /*   552     4 */
		};                                       /*   536    24 */
	};                                               /*   536    24 */

	/* size: 560, cachelines: 9, members: 8 */
	/* sum members: 556, holes: 1, sum holes: 4 */
	/* member types with holes: 1, total: 1 */
	/* forced alignments: 1 */
	/* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));

Regards,
Lorenzo

--hWmCm/wRFf5QXlgL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQsCYgAKCRA6cBh0uS2t
rHFAAQDj3Vyre7WUSS9oIsXyUpTR4N2pQmKzb4l2PYBU94jdswD9F7vYAu0DcE53
OvIHIJXFPV1h9xfMXmrM33nb8hU3LA4=
=yrTi
-----END PGP SIGNATURE-----

--hWmCm/wRFf5QXlgL--

