Return-Path: <netdev+bounces-258474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ2kLQ4Fjmlf+gAAu9opvQ
	(envelope-from <netdev+bounces-258474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 17:51:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAC112FA49
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFB25300BE92
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D53235DD05;
	Thu, 12 Feb 2026 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g301/aHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8635293D;
	Thu, 12 Feb 2026 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915082; cv=none; b=USBLiHKotrJFFTVvesNQjVFaRPvcKSDOnFQzpS9PhpF80jWpbWvKymVyrr2Q4YW2w9VPd1WhAKzV+7VvIKROEjzml2rxzSX61iET6o/dt79MiIC3iU1MI0ypjyGkutItX6IaYK4fv5eeC3d7bweldDAtexLQflz6SkO+I35Qww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915082; c=relaxed/simple;
	bh=XdxVG+YXGaMS3AWMGOWVYDuXvjuKlsGk0gHHkVYXoBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHmyzQpriZbfgKw+7KZsf8A8lIE2AFSae8xeUI/INNmENgZxXJE9F5xoplBV74naRYgLJWN3RoXSLSYUQIRqPxlIG/2q0iAO7C4iV2m7AvWMX0jmwP9T7miabhB+rgMsjS4m4q4LtxW3dNZSrpIaWOdR2STx4Tr/XgbhODVM0qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g301/aHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE26C4CEF7;
	Thu, 12 Feb 2026 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770915082;
	bh=XdxVG+YXGaMS3AWMGOWVYDuXvjuKlsGk0gHHkVYXoBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g301/aHxOBg/tZoPaoIo39YQf6X3yf/bDbcpa60KjMq6uJblkjbFxXdfsoMG8aTBn
	 nlwV7lbuECo+Mv9r5Kk484RzEJleTWEL0UWNOeOomzwDmP1ZcORj3OW2batpf6uiFA
	 FMhVTI5BQs4yfi6qfcJmiINE42oRNQfLcZBxaFclppUqy/bQn1aafFpob6bcLbBzEr
	 ZkZHWziHAccDsvfcp7A85qp34HZJxItkFXVKl9KzYf2sQ4dXSG2DjYkn6XNd3V6Jsj
	 5SgHidUP7eTxjL/wKPAV7aos/RXsrc8CJ9uYaP2Tpp/uVBzWPv7Um3Yf7zIgfR1INM
	 0w2O4FVC4LexA==
Date: Thu, 12 Feb 2026 17:51:19 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aY4FB_Gf31V-VYiF@lore-desk>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
 <aNYUqdaIJV1cvFCb@mini-arch>
 <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>
 <aNcZdfCivLR2slFw@mini-arch>
 <aYtqKfv0F0l2-hgy@lore-desk>
 <aY0zd4Esewxa-8hw@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8qT/NFgXfwBYc55E"
Content-Disposition: inline
In-Reply-To: <aY0zd4Esewxa-8hw@mini-arch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258474-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,gmail.com,davemloft.net,google.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,vger.kernel.org,lists.osuosl.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FAC112FA49
X-Rspamd-Action: no action


--8qT/NFgXfwBYc55E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 02/10, Lorenzo Bianconi wrote:
> > > On 09/26, Jesper Dangaard Brouer wrote:
> > > >=20
> > > >=20
> > > > On 26/09/2025 06.20, Stanislav Fomichev wrote:
> > > > > On 09/25, Lorenzo Bianconi wrote:
> > > > > > Introduce XDP RX checksum capability to XDP metadata specs. XDP=
 RX
> > > > > > checksum will be use by devices capable of exposing receive che=
cksum
> > > > > > result via bpf_xdp_metadata_rx_checksum().
> > > > > > Moreover, introduce xmo_rx_checksum netdev callback in order al=
low the
> > > > > > eBPF program bounded to the device to retrieve the RX checksum =
result
> > > > > > computed by the hw NIC.
> > > > > >=20
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > ---
> > > > > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > > > > >   include/net/xdp.h                       | 14 ++++++++++++++
> > > > > >   net/core/xdp.c                          | 29 ++++++++++++++++=
+++++++++++++
> > > > > >   3 files changed, 48 insertions(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Document=
ation/netlink/specs/netdev.yaml
> > > > > > index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67=
c6b9ee3548098b0c933fd39a4 100644
> > > > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > > > @@ -61,6 +61,11 @@ definitions:
> > > > > >           doc: |
> > > > > >             Device is capable of exposing receive packet VLAN t=
ag via
> > > > > >             bpf_xdp_metadata_rx_vlan_tag().
> > > > > > +      -
> > > > > > +        name: checksum
> > > > > > +        doc: |
> > > > > > +          Device is capable of exposing receive checksum resul=
t via
> > > > > > +          bpf_xdp_metadata_rx_checksum().
> > > > > >     -
> > > > > >       type: flags
> > > > > >       name: xsk-flags
> > > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > > index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b=
70618a9d4f32544d8b9a30b63 100644
> > > > > > --- a/include/net/xdp.h
> > > > > > +++ b/include/net/xdp.h
> > > > > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attac=
hment_info *info,
> > > > > >   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > > > > >   			   bpf_xdp_metadata_rx_vlan_tag, \
> > > > > >   			   xmo_rx_vlan_tag) \
> > > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > > > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > > > > +			   bpf_xdp_metadata_rx_checksum, \
> > > > > > +			   xmo_rx_checksum)
> > > > > >   enum xdp_rx_metadata {
> > > > > >   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > > > > @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
> > > > > >   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SCTP |=
 XDP_RSS_L3_DYNHDR,
> > > > > >   };
> > > > > > +enum xdp_checksum {
> > > > > > +	XDP_CHECKSUM_NONE		=3D CHECKSUM_NONE,
> > > > > > +	XDP_CHECKSUM_UNNECESSARY	=3D CHECKSUM_UNNECESSARY,
> > > > > > +	XDP_CHECKSUM_COMPLETE		=3D CHECKSUM_COMPLETE,
> > > > > > +	XDP_CHECKSUM_PARTIAL		=3D CHECKSUM_PARTIAL,
> > > > > > +};
> > > > >=20
> > > > > Btw, might be worth mentioning, awhile ago we had settled on a sm=
aller set of
> > > > > exposed types:
> > > > >=20
> > > > > https://lore.kernel.org/netdev/20230811161509.19722-13-larysa.zar=
emba@intel.com/
> > > > >=20
> > > > > Maybe go through the previous postings and check if the arguments=
 are
> > > > > still relevant? (or explain why we want more checksum now)
> > > >=20
> > > > IHMO the linked proposal reduced the types too much.
> > >=20
> > > IIRC, PARTIAL was removed because it's mostly (or only) a TX feature?
> > > So no real need to expose it as an rx hint. And I think empty xdp_csu=
m_status
> > > in that proposal might have indicated NONE?
> >=20
> > Sorry for the (very) late reply. According to [0] CHECKSUM_PARTIAL can =
be used
> > even on Rx side, right?
>=20
> So is this for virtio (which I don't think you need)? Or something else?

I forgot to mention before CHECKSUM_PARTIAL is used for the veth use-case
when the packet is coming from the networking stack.

> Can we start with the "easy" cases of UNNECESSARY/COMPLETE/NONE? I'm not =
even
> sure we need to expose the csum_level (start with level=3D0 and handle
> encap if/when there is a real usecase). With kfuncs we should be able to
> change/extend the API when needed.

ack, I am fine to drop csum_level for the moment but I am not sure if it ca=
n be
useful for the use-case described by Jesper.
@Jesper: any input on it?

Regards,
Lorenzo

>=20
> (for PARTIAL, not even sure what the BPF prog is supposed to do with it)

--8qT/NFgXfwBYc55E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaY4FBwAKCRA6cBh0uS2t
rLgyAQDNKqpoeLWazkdUXhQHQ1Jjc9nNvo0J0et1ZcPKGvP2RgD/aGy9hpI/I7tJ
HHNGMx9dyMNBjMP6TKwbgmwxuYvj9As=
=RLM+
-----END PGP SIGNATURE-----

--8qT/NFgXfwBYc55E--

