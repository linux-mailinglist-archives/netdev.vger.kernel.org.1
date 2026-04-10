Return-Path: <netdev+bounces-277276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIRdHVSh2GnegAgAu9opvQ
	(envelope-from <netdev+bounces-277276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:05:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE0F3D3131
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD89B300D609
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E890137FF50;
	Fri, 10 Apr 2026 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Qm4gw0jH"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCEE38B15E;
	Fri, 10 Apr 2026 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775804748; cv=none; b=qMOcbjgf4xi7Gg5CHKMfbKO4jR8UniuzqChtABHSthXj2uhg44A0Eb1+cg8FJR/UyVynVlSpYBTHnyA1vY5WTNmPp9+VpwjzHonz4J8EMeSTMw0WhR3LilphrcMvJaqId7oFRP+d7m/m+rxhsTFAEpV4Z2pc44mh1iMTxLrOfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775804748; c=relaxed/simple;
	bh=Oy/mYPLUCjkzN3QPWYx62GdWgbKmAadAtpo0ISNECrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRRN5Sc4Ll8RA7Bw7d2GYw7P45Irt5xkQUrecu9wbTppPwhYtfK4VWBB7dEdFMmh4IoD1r87THWzkFlEZxC2/Q16AgrsiWYDaYvyjjgwJR6BIMeOuewicdGOZMy2Jw+VsNujfRRntM+2DeeUJx0OmwRYb6UdPSmznPonXjt30IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Qm4gw0jH; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1775804744;
	bh=4I6rRy/sQufd64AScJslz3j5lUTMK2dmDI6ASPTwMQA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qm4gw0jHEzYGjnCJl5podtkU3MV6Qg5pBCNoZidfiq9/XwY2cz18/spiNEn/2tFD4
	 fA+UIR9ECdrzjqgf0ILs1p83R4FRzF6hMrvCLYxsrxbtTIhIaTbEczNpvDl9o7s55B
	 HLEIbzDoVar18mlNTRbm6kC5VzAeY5EDRsbixitSk/RlzEmbMYJbxUQdO4W2Jb1uyU
	 bo7TEC753VoyTD7wB3fCTpk5LXgNvpnDFRP22LcvXTcQ6YaRkdCKABE8KQXpTTN8+v
	 NSVw/PRCqYKid4IoFUbvzW4sE9521f0V8PYeEUJ6NXxySFXAVjppBLa7Jxo6rBUWVI
	 sRcpkOuwGdpKQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 531B7658B7;
	Fri, 10 Apr 2026 15:05:43 +0800 (AWST)
Message-ID: <071438dea6e35df4a313142c91aaa9673179ab98.camel@codeconstruct.com.au>
Subject: Re: [PATCH next-next v2] net:mctp: fix setting mctp hdr ver
 reserved field cause  data dropped
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: wit_yuan <yuanzhaoming901030@126.com>
Cc: yuanzm2@lenovo.com, matt@codeconstruct.com.au, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 10 Apr 2026 15:05:43 +0800
In-Reply-To: <20260410061703.3547-2-yuanzhaoming901030@126.com>
References: 
	<ff147a3f0d27ef2aa6026cc86f9113d56a8c61ac.camel@codeconstruct.com.au>
	 <20260410061703.3547-1-yuanzhaoming901030@126.com>
	 <20260410061703.3547-2-yuanzhaoming901030@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[126.com];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lenovo.com:email,codeconstruct.com.au:dkim,codeconstruct.com.au:mid]
X-Rspamd-Queue-Id: ACE0F3D3131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Looks like a better approach, thanks for the improvements, including the
net-next patch prefix.

I would suggest reading up on the contribution guidelines too:

 https://docs.kernel.org/process/maintainer-netdev.html

(in this case, the 24 hour spacing between revisions).

> Subject: [PATCH next-next v2] net:mctp: fix setting mctp hdr ver reserved
>   field cause  data dropped

Add a space between the 'net:mctp:'. That should be 'net: mctp: [...]'

And perhaps a tweak to the wording, giving:

  net: mctp: don't require received header reserved bits to be zero

> From: Yuan Zhaoming <yuanzm2@lenovo.com>
>=20
> from spec dsp0236_1.2.1.pdf page 26, the mctp header contains the
> RSVD(4bit) and Hdr version(4 bit).

Some wording things there - It would be more clear to reference the spec
by name, rather than by filename, giving something like:

  From the MCTP Base specification (DSP0236 v1.2.1), the first byte of
  the MCTP header contains a 4 bit reserved field, and 4 bit version.

Then, explain the current issue:

  On our current receive path, we require those 4 reserved bits to be
  zero, but at least one device is non-conformant, and may set these
  reserved bits.

[If you can name the specific device, that will certainly help others
with future debugging. I assume the device is currently public?]

Then, maybe some rationale about the change, and an overview of the
implementation:

  DSP0236 states that the reserved bits must be written as zero, and
  ignored when read. While the device might not conform to the former,
  we should accept these message to conform to the latter.

  Relax our check on the MCTP version byte to allow non-zero bits in the
  reserved field.

  Signed-off-by: ...

> mctp_pkttype_receive invoke mctp_hdr, and get mh->ver whole byte=20
> compare the MCTP_VER_MIN, MCTP_VER_MAX. the reserver bits may be by=20
> misleading used.

This is no longer relevant for the new revision.

> @@ -35,6 +35,7 @@ struct mctp_hdr {
> =C2=A0#define MCTP_HDR_SEQ_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GENMAS=
K(1, 0)
> =C2=A0#define MCTP_HDR_TAG_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> =C2=A0#define MCTP_HDR_TAG_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GENMAS=
K(2, 0)
> +#define MCTP_HDR_VER_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GENMASK(3, =
0)

This section of #defines is commented to represent the flags/seq/tag
field. I would prefer to move this definition above that comment.

> =C2=A0
> =C2=A0#define MCTP_INITIAL_DEFAULT_NET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A01
> =C2=A0
> diff --git a/net/mctp/route.c b/net/mctp/route.c
> index 56c441e90..aa0e89d67 100644
> --- a/net/mctp/route.c
> +++ b/net/mctp/route.c
> @@ -464,7 +464,7 @@ static int mctp_dst_input(struct mctp_dst *dst, struc=
t sk_buff *skb)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netid =3D mctp_cb(skb)->n=
et;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0skb_pull(skb, sizeof(stru=
ct mctp_hdr));
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mh->ver !=3D 1)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (((mh->ver & MCTP_HDR_VER_M=
ASK)) < MCTP_VER_MIN || (mh->ver & MCTP_HDR_VER_MASK) > MCTP_VER_MAX)

Use a temporary for the version, rather than repeating the mask
operation. This makes the conditional much easier to read:

    if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)

Cheers,


Jeremy

