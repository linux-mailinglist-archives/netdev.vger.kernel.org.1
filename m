Return-Path: <netdev+bounces-268498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA9eA8QcuWm+qwEAu9opvQ
	(envelope-from <netdev+bounces-268498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:20:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F1C2A680A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E7DC301346E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583D7358D00;
	Tue, 17 Mar 2026 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJWhNAj+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6635F16A;
	Tue, 17 Mar 2026 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739170; cv=none; b=jno97LcHylOdTkUTSbb7CdwVShVwmvD1KGVcMIGOZdkvu+PFJnAvNgNuxWmT10wVDfkx6lJDa96o6c162poHR972fGj+WRtGH3+Pftut7hufxw0XJSzvHIV+Er/uFgxZ7VsKAfmon1IRcZ4pKX5c4qLG97PMUouUBdeo9CzpL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739170; c=relaxed/simple;
	bh=DCURi86uRcFMWZ3j+SUJmdI96P+kkRuQLQRIMxxqF/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mal2IGSVqyXKoHc8xDs4QPcur88Ib9nquVxY4IztyiRsqTUJ+E5wV6oPLLn3qSFhikHECUMfb26Y+7M3kFidZxgGe8M0ksqAp1BMLGS2LlhrSfecrKbWxTuypC8dk+JujhEIBcsUfeJQfWZU3S0LRTvCvv9kA/jbIYfpL97WAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJWhNAj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2AEC2BCAF;
	Tue, 17 Mar 2026 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739169;
	bh=DCURi86uRcFMWZ3j+SUJmdI96P+kkRuQLQRIMxxqF/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LJWhNAj+KLnBF1VSVZ2Z6bhXbRuqCVntYP3bL0IN7gXmXMztNa81BlY9YdmTL/AIZ
	 3AuRDWi60YgL9blUlNFktQ6isdWv3ayVTLFJ9BfIm/p1MJpIkRFkojp4DuXtgFgVNS
	 B20vIgNll1r9ymWyYCehwUNTS4e7dxLFWwHRzrOTcCKEekY5QCjwVQfjZbg5o0uxti
	 sXR35MAqCcBgxLV5cp34deoO3JZzoml1EbcvGMkva1L/ObEcSyy3/eYgt0IK51WqLh
	 dY6qFvDrUIm7S6unJ2wquw1u0t1lC5KCdWPEyQDq9vHF2G4bpGLm75HxUH2Xji+kub
	 6qvm6Whe+3zHw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH net 1/6] xsk: respect tailroom for ZC setups
In-Reply-To: <abiJ2C_q62bn7EC3@mini-arch>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
 <20260316174550.462177-2-maciej.fijalkowski@intel.com>
 <abiJ2C_q62bn7EC3@mini-arch>
Date: Tue, 17 Mar 2026 10:19:25 +0100
Message-ID: <878qbqrexu.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268498-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A7F1C2A680A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Stanislav Fomichev <stfomichev@gmail.com> writes:

> On 03/16, Maciej Fijalkowski wrote:
>> Multi-buffer XDP stores information about frags in skb_shared_info that
>> sits at the tailroom of a packet. The storage space is reserved via
>> xdp_data_hard_end():
>>=20
>> 	((xdp)->data_hard_start + (xdp)->frame_sz -	\
>> 	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
>>=20
>> and then we refer to it via macro below:
>>=20
>> static inline struct skb_shared_info *
>> xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
>> {
>>         return (struct skb_shared_info *)xdp_data_hard_end(xdp);
>> }
>>=20
>> Currently we do not respect this tailroom space in multi-buffer AF_XDP
>> ZC scenario. To address this, introduce xsk_pool_get_tailroom() and use
>> it within xsk_pool_get_rx_frame_size() which is used in ZC drivers to
>> configure length of HW Rx buffer.
>>=20
>> xsk_pool_get_tailroom() is only reserving necessary space when pool is
>> zc and underlying netdev supports zc multi-buffer. Since this function
>> relies on pool->umem->zc setting, set it before ndo_bpf during zc
>> configuration, so that driver that actually calls
>> xsk_pool_get_rx_frame_size() inside ndo_bpf will get correct tailroom
>> value.
>>=20
>> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
>> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> ---
>>  include/net/xdp_sock_drv.h | 21 ++++++++++++++++++++-
>>  net/xdp/xsk_buff_pool.c    |  3 ++-
>>  2 files changed, 22 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
>> index 6b9ebae2dc95..13b2aae00737 100644
>> --- a/include/net/xdp_sock_drv.h
>> +++ b/include/net/xdp_sock_drv.h
>> @@ -41,6 +41,19 @@ static inline u32 xsk_pool_get_headroom(struct xsk_bu=
ff_pool *pool)
>>  	return XDP_PACKET_HEADROOM + pool->headroom;
>>  }
>>=20=20
>> +static inline u32 xsk_pool_get_tailroom(struct xsk_buff_pool *pool)
>> +{
>> +	struct xdp_umem *umem =3D pool->umem;
>> +
>> +	/* Reserve tailroom only for zero-copy pools that opted into
>> +	 * multi-buffer. The reserved area is used for skb_shared_info,
>> +	 * matching the XDP core's xdp_data_hard_end() layout.
>> +	 */
>> +	if (umem->zc && (umem->flags & XDP_UMEM_SG_FLAG))
>> +		return SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> +	return 0;
>> +}
>> +
>>  static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
>>  {
>>  	return pool->chunk_size;
>> @@ -48,7 +61,8 @@ static inline u32 xsk_pool_get_chunk_size(struct xsk_b=
uff_pool *pool)
>>=20=20
>>  static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
>>  {
>> -	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
>> +	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool) -
>> +	       xsk_pool_get_tailroom(pool);
>>  }
>>=20=20
>>  static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
>> @@ -332,6 +346,11 @@ static inline u32 xsk_pool_get_headroom(struct xsk_=
buff_pool *pool)
>>  	return 0;
>>  }
>
> [..]
>=20=20
>> +static inline u32 xsk_pool_get_tailroom(struct xsk_buff_pool *pool)
>> +{
>> +	return 0;
>> +}
>
> Not sure it's needed? xsk_pool_get_tailroom is only used by
> CONFIG_XDP_SOCKETS' version of xsk_pool_get_rx_frame_size.
>
>>  static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
>>  {
>>  	return 0;
>> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
>> index 37b7a68b89b3..2cfc19e363e3 100644
>> --- a/net/xdp/xsk_buff_pool.c
>> +++ b/net/xdp/xsk_buff_pool.c
>> @@ -213,6 +213,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>>  	bpf.command =3D XDP_SETUP_XSK_POOL;
>>  	bpf.xsk.pool =3D pool;
>>  	bpf.xsk.queue_id =3D queue_id;
>> +	pool->umem->zc =3D true;
>>=20=20
>>  	netdev_ops_assert_locked(netdev);
>>  	err =3D netdev->netdev_ops->ndo_bpf(netdev, &bpf);
>> @@ -224,13 +225,13 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>>  		err =3D -EINVAL;
>>  		goto err_unreg_xsk;
>>  	}
>> -	pool->umem->zc =3D true;
>>  	pool->xdp_zc_max_segs =3D netdev->xdp_zc_max_segs;
>>  	return 0;
>>=20=20
>>  err_unreg_xsk:
>>  	xp_disable_drv_zc(pool);
>>  err_unreg_pool:
>> +	pool->umem->zc =3D false;
>>  	if (!force_zc)
>>  		err =3D 0; /* fallback to copy mode */
>>  	if (err) {
>
> I'm not super familiar with the shared umem patch, but is it safe to
> unconditionally undo pool->umem->zc =3D false here? xp_assign_dev_shared
> looks at this umem->zc flag.. Presumably other places do as well on
> teardown?

Good catch!

I can elaborate a bit; the zero-copy property of umem is shared between
all users (sockets) of that umem. IOW, all sockets sharing an umem,
inherits whatever the first socket negotiated.

So, we could get into something like:

1. Socket A binds queue 0, ndo_bpf OK (umem->zc =3D true)
2. Socket B binds queue 1 via xp_assign_dev_shared()
   reads umem->zc =3D=3D true, so flags =3D XDP_ZEROCOPY
   xp_assign_dev() sets umem->zc =3D true
   ndo_bpf() NOK for queue 1 -> error path: umem->zc =3D false (oops)
3. Socket A is still active on queue 0 in ZC mode, but umem->zc is now
   false

...and we'll have a bunch of checks on umem->zc that now has incorrect
state.

From this follows that the zc flag shouldn't be toggled on a shared
resource without checking if other consumers exist. I think a per-pool
zc flag is needed here or smth. :-(


Bj=C3=B6rn

