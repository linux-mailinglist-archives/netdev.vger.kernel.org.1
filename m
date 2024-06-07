Return-Path: <netdev+bounces-101653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AA78FFB6E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BD62846C8
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 05:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2B014EC7D;
	Fri,  7 Jun 2024 05:50:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294B217BB4
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717739445; cv=none; b=f0sU1cYj8/cEHrdDYKigkOFkWsCv6O+J9wAMQrvxjN1715oXzshRoMyhBAFp0Q8p7m7K5DgNoAd4rgCYJ5VhfNZMJ6A4x76TMpzGlQT//WfFgDtaYJO5PsxZV06cRDvs9oLNYlnvrfY+fIM7Qp3YzvjQuOuZEO80eVXjFMrnFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717739445; c=relaxed/simple;
	bh=Ga/ZhAiIM2g6n9et08M9cn3x1tanfGe2QiwvGlLqQew=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=VIxfGdvF5AuCMNIH1zXTKYUhC1IWd4rPKetslZsyDDAlYVdymreh2YXUBTjUTp4LH1KUbcRl6xDeBSAaxbmSbk+nHI2A2Hlod18D/0GJFlL6ey7N0FKTSisvtMW/QTruHWOKeeeO+BPVmNnQWo0H4LAU+IF8UuHMm5eQu91JjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id E6F6D7D10E;
	Fri,  7 Jun 2024 05:50:42 +0000 (UTC)
References: <20240520214255.2590923-1-chopps@chopps.org>
 <20240520214255.2590923-9-chopps@chopps.org>
 <Zl354nSbE5mOMC2h@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v2 08/17] xfrm: iptfs: add new
 iptfs xfrm mode impl
Date: Fri, 07 Jun 2024 01:49:40 -0400
In-reply-to: <Zl354nSbE5mOMC2h@Antony2201.local>
Message-ID: <m234ppgv2m.fsf@ja.int.chopps.org>
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


Antony Antony <antony@phenome.org> writes:

> Hi Chris,
>
> On Mon, May 20, 2024 at 05:42:46PM -0400, Christian Hopps via Devel wrote:

>> From: Christian Hopps <chopps@labn.net>
>> +static unsigned int iptfs_sa_len(const struct xfrm_state *x)
>> +{
>> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
>> +	struct xfrm_iptfs_config *xc = &xtfs->cfg;
>> +	unsigned int l = 0;
>> +
>> +	l += nla_total_size(0);
>> +	l += nla_total_size(sizeof(u16));
>> +	l += nla_total_size(sizeof(xc->pkt_size));
>> +	l += nla_total_size(sizeof(u32));
>> +	l += nla_total_size(sizeof(u32)); /* drop time usec */
>> +	l += nla_total_size(sizeof(u32)); /* init delay usec */
>> +
>> +	return l;
>> +}
>> +
>> +static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
>> +{
>> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
>> +	struct xfrm_iptfs_config *xc = &xtfs->cfg;
>> +	int ret;
>> +
>> +	ret = nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
>> +	if (ret)
>> +		return ret;
>> +	ret = nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW, 0);
>> +	if (ret)
>> +		return ret;
>> +	ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
>> +	if (ret)
>> +		return ret;
>> +	ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, 0);
>
> Why copy all attributes? Only copy the ones relevant to the SA direction.
> Also adjust in  iptfs_sa_len().

Updated in new v3 patchset.

Thanks,
Chris.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmZin7ESHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlPT4P/1RSE0hQFiG/vcTNj1vbbYR+Zrl1qBy1
NuLGpSX3k2DYlcctxLXp68FTij6+wCaGHqtQgnK2/qoDfnjWNtr0xMA0aXOlOWhq
SoxzbnmRG3Ux153hyAvCSK8/5dnHiwvqTS5VL4zFWE/maYQQ22qTgOlMe52UCVWN
d8whvAVxTfZx2Y7s+OjpSMq2PPrZ1cFE90nljXSr6N+wAm4P7jpYh6JjLS5n0bXm
f3yQRI5BDYIrbfhlmEmh+TXuED1OMtbfuROL0B437IdyFUdMVf1AyZhTxbjhilTW
/oK+1++FSLr1chAgRNlJazQMK+umFhXriYItEZ4lHDFBrTj85dgYR5Xxq9FtWEVH
5vRSfgEqsXZ0Cj4QOj//swEx/k2oEr4+a6SwH79KgYPVEBOmEcTqQNu1ZdQ5oT1K
akbOiiT9RbKDMoLHLgpCw0q0poa9KGn8n21JEt1S46d4jz6eCbbzkSv5Va0BKE5O
rK1SZfxEvXNlBVm3Zk6tXDreaY57/mpYbf3g3TeOkhZk4yVnZUjZuUr+mUifIi5E
CsJyJ3PPD3mV2Vw4cnJYdmKjXKwhvhmiWqFjt7VzU5cB4h/uwKsSBKfR31zFmgV9
BgG+l7hga9xsKgMxTmYAOfAuCZIRDc8owPQD/uy7COnGPpAuYVO6AfPb8ZE6/A7m
JBaUaxLGnEvY
=5PWw
-----END PGP SIGNATURE-----
--=-=-=--

