Return-Path: <netdev+bounces-204075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A746CAF8CB4
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE18B5A4679
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402EB2882DD;
	Fri,  4 Jul 2025 08:49:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE52877F9;
	Fri,  4 Jul 2025 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618954; cv=none; b=KwfgQhZyLFlHS88AHTk41NDJP9sMkiEQk1t/Xrw5wiVj8S+DGSuW6p7l8G3C3sJ1Taso+E57EborkkmUJAOTxmc0CMtZjgZj1bjX2ZqFJDXbgN5LDMr6wbL6zulTMBG1eERgerRnogRgyAXeKH1AAaocae/X17D4xrRGrB3hQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618954; c=relaxed/simple;
	bh=VJlhA+4V8cKq6Ze77CKxoGIcWtomnmXZsPHxdC45v7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VCukMlkKpCZaMdA5E55qw9hKJNqZEraLR+qdojCTphXJdBNT5sZusQnk0havDb4LWZEDK+KikFeDNmtWYMLlvAxckGnrj76eSj9qWnis8e7w06eztlJClQmCV+7Aok0yPwOMTfIEELkz1NVUBNn8CD72EIumqHN7kT2+Sl9i1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D394F43123;
	Fri,  4 Jul 2025 08:49:07 +0000 (UTC)
Message-ID: <1f49c0993c61d97128a78667c1967b440dc5b7df.camel@hadess.net>
Subject: Re: [PATCH v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
From: Bastien Nocera <hadess@hadess.net>
To: yang.li@amlogic.com, Marcel Holtmann <marcel@holtmann.org>, Johan
 Hedberg	 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 04 Jul 2025 10:49:07 +0200
In-Reply-To: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
References: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffieeuudevuddtffeiheduteelgffgfeegueefheduueejhfdtuddvkefhvdekgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohephigrnhhgrdhlihesrghmlhhoghhitgdrtghomhdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtohepjhhohhgrn
 hdrhhgvuggsvghrghesghhmrghilhdrtghomhdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: hadess@hadess.net

On Fri, 2025-07-04 at 13:36 +0800, Yang Li via B4 Relay wrote:
> From: Yang Li <yang.li@amlogic.com>
>=20
> User-space applications (e.g., PipeWire) depend on
> ISO-formatted timestamps for precise audio sync.
>=20
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v3:
> - Change to use hwtimestamp
> - Link to v2:
> https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068@amlogic.com
>=20
> Changes in v2:
> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
> - Link to v1:
> https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
> ---
> =C2=A0net/bluetooth/iso.c | 10 +++++++++-
> =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index fc22782cbeeb..67ff355167d8 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2301,13 +2301,21 @@ void iso_recv(struct hci_conn *hcon, struct
> sk_buff *skb, u16 flags)
> =C2=A0		if (ts) {
> =C2=A0			struct hci_iso_ts_data_hdr *hdr;
> =C2=A0
> -			/* TODO: add timestamp to the packet? */
> =C2=A0			hdr =3D skb_pull_data(skb,
> HCI_ISO_TS_DATA_HDR_SIZE);
> =C2=A0			if (!hdr) {
> =C2=A0				BT_ERR("Frame is too short (len
> %d)", skb->len);
> =C2=A0				goto drop;
> =C2=A0			}
> =C2=A0
> +			/* The ISO ts is based on the controller=E2=80=99s
> clock domain,
> +			 * so hardware timestamping (hwtimestamp)
> must be used.
> +			 * Ref:
> Documentation/networking/timestamping.rst,
> +			 * chapter 3.1 Hardware Timestamping.
> +=C2=A0			 */
> +			struct skb_shared_hwtstamps *hwts =3D
> skb_hwtstamps(skb);

The variable should be declared at the top of the scope.

Cheers

> +			if (hwts)
> +				hwts->hwtstamp =3D
> us_to_ktime(le32_to_cpu(hdr->ts));
> +
> =C2=A0			len =3D __le16_to_cpu(hdr->slen);
> =C2=A0		} else {
> =C2=A0			struct hci_iso_data_hdr *hdr;
>=20
> ---
> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
> change-id: 20250421-iso_ts-c82a300ae784
>=20
> Best regards,

