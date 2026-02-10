Return-Path: <netdev+bounces-258135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEu5KEVqi2k1UQAAu9opvQ
	(envelope-from <netdev+bounces-258135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:26:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2658B11DEB3
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8707D304EA6A
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521F5388840;
	Tue, 10 Feb 2026 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbVzr0bH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tl1ZTJTO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3E318EF1
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744371; cv=none; b=i9+AAyeIY37CeQRzUI9f0liOyJ3S/OjK7peUjt5JGnkbBPsyBO646sqxwscXEXSDH3apQfnJYi/lNMiPmXFMrLz99cnVuMeg8U01cvJYUWhwiwoQ7TR5b6zHCGV9JwA1MvZBJbkBgX2BBb3lSQB3V9Nlfq85pQ7mj+ZC6kI7yzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744371; c=relaxed/simple;
	bh=bGZAvqDxEIu2N9ucVC96wgoTT6pCXw1PIhUB4cBYFnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE7qBr6II0aZnJaOMVgzyWU6xhcmma/jD98BNARa60naB0rijwd6Mf4i5s3ujl6WATiKS5a6PWd44F2DmdoGH57xAic2z6dIuX9PDOjIKjFQauLt3FwulOBuLEG8miXCR1WCnt+uLwD+HryB9GDqJCXw3Ex30lNsy7r1UG9d3nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbVzr0bH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tl1ZTJTO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770744367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6SXb5IczZILKvt9qVo3/THUDjn6esbNCNc+i/3NT+A=;
	b=MbVzr0bHv4KfwrQPF02uLZydCCM+SDFDlEqxDsoZkSla13pQXbDHG04+tN/kvP7uIk6FHX
	IL7tr7OsiBE5lCr8eYABtUFgFJivStQUJrqlbC0Y1mAk92TQWhC4di+I2mjMrUPU3Gtkze
	SPlREfPrTirpeIdlLk8dfY+yK13gHwY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-SSuo48ukNzOqxd4Nrceunw-1; Tue, 10 Feb 2026 12:26:06 -0500
X-MC-Unique: SSuo48ukNzOqxd4Nrceunw-1
X-Mimecast-MFC-AGG-ID: SSuo48ukNzOqxd4Nrceunw_1770744363
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4359849d324so4947369f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770744363; x=1771349163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6SXb5IczZILKvt9qVo3/THUDjn6esbNCNc+i/3NT+A=;
        b=tl1ZTJTOg45iq6VrG0u5VwUFL4YNzUWIYDH3vVn8XghxoTq8Djq1qV9MRvHfxOIa4z
         dqZq5eJVgTL8NmKcM1ELVl6g/a67bKKZ5680EPiGYR39W/g8TXJrQpLOWMJ+xnB8/jNr
         XsnK++MDByMpI3EhFo7yG61dR8eY3zAcCvuG96mhy229oAX1BEd2HKeYZoxz3ORAujcK
         JATvzC7gJiyfTNwKmWp8tmkq5MG4aaFtmXfVujj9rfYr+A+/L5LaJFFj1IxU98LLml0L
         ZK2fzXy2vKQF3+aR7DDnSw54tTB+vAfidxPDiRdG/EhkIZWA2/BUBnaYgBQHsRlecpkW
         dP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770744363; x=1771349163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6SXb5IczZILKvt9qVo3/THUDjn6esbNCNc+i/3NT+A=;
        b=M8766b6BnKF1iNX4qn6JB1VSpPEpGnaRrxUXo32CCwv5omZtvbpaPTRad5Dg52tEBG
         sGpHdhChouADwGY7gB+1/rC31ju1grsXRN7mbyl3xL25zh8q9+kYbg4j5QWEj5Dxe9U1
         dM/tnBx9aM4GgOd/CfhtEkgaVU+Sbd1UE4AOopUHpDlOOCJJDX/4BNgDyQvrhQf/EqOy
         O7qiye3Eg+cGeAVTY0NMQ/4F/hf8HADRfhTZnY+c+WhVOKK0Ob9qftSiqXCZxYSdbi9p
         QkRUac8PCdfmXBPWrd6HTjXk+XROFSLET6DAnHJE1uU7HXPmhLQul8ID1gKk47JbwDDG
         /bjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEK/k4CP96+QuC1j9K5gZCxWk2ySHETjxNUWfbGRIbMc6sKY9KRfJIyaCIYadVT+ncRPMUGME=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo4n7a/QBpYO5pQrzPKZSohAPBFsjGxVgNzAVU3Q489f34XbH+
	O32t/tWg0GSKcjGzK9PUrWD19AzX+EJE7k13AZGQAg5G9UyRL3gHwgwKkUgczcdEMMa+reIcX6n
	YguJEQf46uMYeAecORi01YNJ38/p4k8v174eQK1qAHJpgsxvQGCrwOjp5mA==
X-Gm-Gg: AZuq6aJO6URjnlkY6hUVCQ7tzaNsaWGg4rxdl53BvbO3TRXjh7C4EXY+h8zPAFHG7d3
	koPHLcu7JUQe5Ms57fzUuvobc53GvbRZk87nRDeNC6mHiv+JBHsWkveF+1HMuKias1daWSChR7w
	oExWuZxR2mw/8dg6/pWKgDQF4jKEiWuenAcT/AhW2djPD5xeCSwL3pPUBg8YJcC+J4dgkh+pgll
	HuQMRf8cFd2sSzo4YUi+dUQzqyJJqBwWP/1hDMEuQGRL4StzeHTfjlX8fgxXGLN1bgN90WnUOeL
	I4qvLEBONnMemFCGAQrrW7wQQsrudcNWX5i6zf/e3V56oIumPTG5yg/wP1UJ1ZESoKIIi2jnUAa
	NvRy4TpPP6K0Rncqo2K16hX75y92m7f6LvAHPMcKqCpfZNx2dbzRszu1uPrDN15Rt56vnmw==
X-Received: by 2002:a05:6000:2287:b0:432:5d73:79a1 with SMTP id ffacd0b85a97d-4377a5a89c5mr4412131f8f.55.1770744363106;
        Tue, 10 Feb 2026 09:26:03 -0800 (PST)
X-Received: by 2002:a05:6000:2287:b0:432:5d73:79a1 with SMTP id ffacd0b85a97d-4377a5a89c5mr4412089f8f.55.1770744362668;
        Tue, 10 Feb 2026 09:26:02 -0800 (PST)
Received: from localhost (net-37-119-153-93.cust.vodafonedsl.it. [37.119.153.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4a1sm35585372f8f.17.2026.02.10.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:26:01 -0800 (PST)
Date: Tue, 10 Feb 2026 18:26:01 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
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
Message-ID: <aYtqKfv0F0l2-hgy@lore-desk>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
 <aNYUqdaIJV1cvFCb@mini-arch>
 <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>
 <aNcZdfCivLR2slFw@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kbaeu9Ugo55vjxdy"
Content-Disposition: inline
In-Reply-To: <aNcZdfCivLR2slFw@mini-arch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258135-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.bianconi@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,vger.kernel.org,lists.osuosl.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2658B11DEB3
X-Rspamd-Action: no action


--Kbaeu9Ugo55vjxdy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 09/26, Jesper Dangaard Brouer wrote:
> >=20
> >=20
> > On 26/09/2025 06.20, Stanislav Fomichev wrote:
> > > On 09/25, Lorenzo Bianconi wrote:
> > > > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > > > checksum will be use by devices capable of exposing receive checksum
> > > > result via bpf_xdp_metadata_rx_checksum().
> > > > Moreover, introduce xmo_rx_checksum netdev callback in order allow =
the
> > > > eBPF program bounded to the device to retrieve the RX checksum resu=
lt
> > > > computed by the hw NIC.
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > > >   include/net/xdp.h                       | 14 ++++++++++++++
> > > >   net/core/xdp.c                          | 29 ++++++++++++++++++++=
+++++++++
> > > >   3 files changed, 48 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentatio=
n/netlink/specs/netdev.yaml
> > > > index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9=
ee3548098b0c933fd39a4 100644
> > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > @@ -61,6 +61,11 @@ definitions:
> > > >           doc: |
> > > >             Device is capable of exposing receive packet VLAN tag v=
ia
> > > >             bpf_xdp_metadata_rx_vlan_tag().
> > > > +      -
> > > > +        name: checksum
> > > > +        doc: |
> > > > +          Device is capable of exposing receive checksum result via
> > > > +          bpf_xdp_metadata_rx_checksum().
> > > >     -
> > > >       type: flags
> > > >       name: xsk-flags
> > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b7061=
8a9d4f32544d8b9a30b63 100644
> > > > --- a/include/net/xdp.h
> > > > +++ b/include/net/xdp.h
> > > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachmen=
t_info *info,
> > > >   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > > >   			   bpf_xdp_metadata_rx_vlan_tag, \
> > > >   			   xmo_rx_vlan_tag) \
> > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > > +			   bpf_xdp_metadata_rx_checksum, \
> > > > +			   xmo_rx_checksum)
> > > >   enum xdp_rx_metadata {
> > > >   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > > @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
> > > >   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SCTP | XDP=
_RSS_L3_DYNHDR,
> > > >   };
> > > > +enum xdp_checksum {
> > > > +	XDP_CHECKSUM_NONE		=3D CHECKSUM_NONE,
> > > > +	XDP_CHECKSUM_UNNECESSARY	=3D CHECKSUM_UNNECESSARY,
> > > > +	XDP_CHECKSUM_COMPLETE		=3D CHECKSUM_COMPLETE,
> > > > +	XDP_CHECKSUM_PARTIAL		=3D CHECKSUM_PARTIAL,
> > > > +};
> > >=20
> > > Btw, might be worth mentioning, awhile ago we had settled on a smalle=
r set of
> > > exposed types:
> > >=20
> > > https://lore.kernel.org/netdev/20230811161509.19722-13-larysa.zaremba=
@intel.com/
> > >=20
> > > Maybe go through the previous postings and check if the arguments are
> > > still relevant? (or explain why we want more checksum now)
> >=20
> > IHMO the linked proposal reduced the types too much.
>=20
> IIRC, PARTIAL was removed because it's mostly (or only) a TX feature?
> So no real need to expose it as an rx hint. And I think empty xdp_csum_st=
atus
> in that proposal might have indicated NONE?

Sorry for the (very) late reply. According to [0] CHECKSUM_PARTIAL can be u=
sed
even on Rx side, right?

Regards,
Lorenzo

[0] https://github.com/torvalds/linux/blob/master/include/linux/skbuff.h#L1=
48

>=20

--Kbaeu9Ugo55vjxdy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaYtqKAAKCRA6cBh0uS2t
rFNfAP9IZ4RIoXiTgNfqdm61xXJO8X8DZttEjYppOw1iHdPLUAEAtTMcYDTh8p0A
ZFsUX/AZUM9EY7k2Fd9cdM0dbkaAKg8=
=ofYP
-----END PGP SIGNATURE-----

--Kbaeu9Ugo55vjxdy--


