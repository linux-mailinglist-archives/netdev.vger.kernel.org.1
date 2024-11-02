Return-Path: <netdev+bounces-141224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FEA9BA14D
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9631B213E5
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897E51A0BE1;
	Sat,  2 Nov 2024 15:58:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942C5189BAD
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730563114; cv=none; b=gQWQ1SihfYXyA+wwStzCgk87zUGy61eiQNpsGGCK9Q39H5MPnOcZSKKdEIm7rab+SuA1YTpiGfemXaocafexPUeCKhZscl3+qh2qCBjJcfhlK2+VGb7NuTUBl3WtT3v47wDOtlr4pSH5Oe5QFh341714taJ/TqNqmJbumfIAM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730563114; c=relaxed/simple;
	bh=kZwhxL4tq+vcv9AutL0zFGbi2LsG7PVSn8ofF1oO6jU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=NCVlcPeRziXMDsMqSjlUMIDN5TZuFDiqg7HDvllTEC6GbMegUOnXV7Ktr66hB/9Sl4rwp5tLj14Wp2Fiqv/8+bBGADEVAorxgnrLh4Sq855Uyr6Nn9OS/+g+liQv+QDVCvYkPHYl+zUwePM0Thtk+PoSVSum2A5eXZTnVBE1P8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [185.122.134.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 9DD257D08A;
	Sat,  2 Nov 2024 15:58:30 +0000 (UTC)
References: <20241007135928.1218955-1-chopps@chopps.org>
 <20241007135928.1218955-11-chopps@chopps.org>
 <ZxYhHQ1xDW69EiDM@gauss3.secunet.de>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, Sabrina Dubroca
 <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, Antony Antony
 <antony@phenome.org>, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v12 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Date: Sat, 02 Nov 2024 15:50:42 +0000
In-reply-to: <ZxYhHQ1xDW69EiDM@gauss3.secunet.de>
Message-ID: <m2v7x5iq56.fsf@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Steffen Klassert <steffen.klassert@secunet.com> writes:

> On Mon, Oct 07, 2024 at 09:59:22AM -0400, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add support for tunneling user (inner) packets that are larger than the
>> tunnel's path MTU (outer) using IP-TFS fragmentation.
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>> ---
>>  net/xfrm/xfrm_iptfs.c | 350 ++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 321 insertions(+), 29 deletions(-)
>>
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>> index 627b10ed4db0..7343ed77160c 100644
>> --- a/net/xfrm/xfrm_iptfs.c
>> +++ b/net/xfrm/xfrm_iptfs.c
>> @@ -46,12 +46,29 @@
>>   */
>>  #define IPTFS_DEFAULT_MAX_QUEUE_SIZE	(1024 * 10240)
>>
>> +/* Assumed: skb->head is cache aligned.
>> + *
>> + * L2 Header resv: Arrange for cacheline to start at skb->data - 16 to keep the
>> + * to-be-pushed L2 header in the same cacheline as resulting `skb->data` (i.e.,
>> + * the L3 header). If cacheline size is > 64 then skb->data + pushed L2 will all
>> + * be in a single cacheline if we simply reserve 64 bytes.
>> + *
>> + * L3 Header resv: For L3+L2 headers (i.e., skb->data points at the IPTFS payload)
>> + * we want `skb->data` to be cacheline aligned and all pushed L2L3 headers will
>> + * be in their own cacheline[s]. 128 works for cachelins up to 128 bytes, for
>> + * any larger cacheline sizes the pushed headers will simply share the cacheline
>> + * with the start of the IPTFS payload (skb->data).
>> + */
>> +#define XFRM_IPTFS_MIN_L3HEADROOM 128
>> +#define XFRM_IPTFS_MIN_L2HEADROOM (L1_CACHE_BYTES > 64 ? 64 : 64 + 16)
>> +
>>  #define NSECS_IN_USEC 1000
>>
>>  #define IPTFS_HRTIMER_MODE HRTIMER_MODE_REL_SOFT
>>
>>  /**
>>   * struct xfrm_iptfs_config - configuration for the IPTFS tunnel.
>> + * @dont_frag: true to inhibit fragmenting across IPTFS outer packets.
>>   * @pkt_size: size of the outer IP packet. 0 to use interface and MTU discovery,
>>   *	otherwise the user specified value.
>>   * @max_queue_size: The maximum number of octets allowed to be queued to be sent
>> @@ -59,6 +76,7 @@
>>   *	packets enqueued.
>>   */
>>  struct xfrm_iptfs_config {
>> +	bool dont_frag : 1;
>
> This bool creates a two byte hole at the beginning of the structure.
> Not a big issue here, but usually it is good to check the structure
> layout with pahole to avoid this.

Moved to bottom changed to `u8 dont_frag : 1`

>
>>  	u32 pkt_size;	    /* outer_packet_size or 0 */
>>  	u32 max_queue_size; /* octets */
>>  };


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmcmTCUSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAl7LIP/RgfwSZKe19ACfaR8MYptz+RGvTj5501
fxaCpjcDGhjQa4ZfxkBNcORCzGL/UW8MiWrvaXzKa2vbX85+/HVtfd1M+qzPo8ZO
Km2yB0KP+e/mnmjQERGJxMsGf/d6H3fd9aMlW/qclPynS9RIFodA3xzSGx6pQjJS
WsuSzw3lV1I0pIWRn1Crm1ILICogfiPhzfRDAfwXwykaD6f+E2I+5rk8xWEeL4AS
WL15i/88v3+T4MhgrVUJ0Ttxs1Pd0MbdqgdRJkQ1cIKllixzB8zIRTytQUSbmHPD
kparfl11l18n6KrzM8+1pO7E4XzbMv1ugmw1BdvkQOpMPF4pOJcvK6VB3vxk7/eX
dml08ZWyzv6L2aQWPrYTNqr2wVPPr+Pt5lp1LRDkbqCpwIUXJQAJ+jU9KL2lAS4H
Dqe/0SuLuauUhev3WSqVI/Zd4wc6DqTNwnCSWx7R6lWKFCOUJ39g3EGyBinCgGHP
9JaXwrVaCL7/nHZyNWp/W+KXBwJUrvL2KDtUPo4F68iT9w5yfp6kcAyK24cpgoan
f8SpwAB+Vog5hgJJVLkaS62YX1vc37tSl3thb6dKQPkxLTuBzpZl4dTLpE9nhDjr
kUyvKDwzEBIRPAFvN5ZLWalNH8pgQRGIZB3lieoU4YqVSafjxldX79YyhBFcfbTE
1bJACWUTQ5Yz
=zRro
-----END PGP SIGNATURE-----
--=-=-=--

