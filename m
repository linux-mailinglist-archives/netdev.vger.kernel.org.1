Return-Path: <netdev+bounces-204342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B87AFA1D5
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 22:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26F61BC340A
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87644136349;
	Sat,  5 Jul 2025 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Bq5Nwewg"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E123A989;
	Sat,  5 Jul 2025 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751748016; cv=pass; b=AY5T2hK6rrODaHD5/V1qgJn2U+OK5dRr5xFybvPeFefvZXl2IdU4O8aUCo1Sz4G4zktXNUPrVPevA4PI4HXkPfFId8aRmUxs/QhEsoWkQnnqc8GFNLE7qA/FCv+iRmTv8eaUw6gig07WWKV8R+jq592OR6lXVgpxsTd0rhTMgCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751748016; c=relaxed/simple;
	bh=BBKeb4VUqkK+mCCLHILneLZVL+VTBUXOrNqq2Ujx9kQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j746zAcP/M2esz7Qv7obSb97s8zys7eFBYl3cfMeEMiRtyKuvQh3mXp67o+g5A5aznZB7zLErhlJEwlzVPG9qwPWIbSs6p/GMj+IglvfNVyrgsb5rlGIqVQBB+Wk1ANq73hO7Xl0adSi3IqeN7NMhtGpfUvEJeNfT3tCu7q7oB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Bq5Nwewg; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bZMnW6Wgmz49Pwl;
	Sat,  5 Jul 2025 23:39:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1751748001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2vD+jaYiwk+HSz5ZbQuNgl9DF52txAe2E/1eLI8Xm8w=;
	b=Bq5NwewgxKp35aBVcbkkg97S5EeBaUpsWT9t3tDg0PUdiVjmUf0DDSQ5yZbS5vDH6ryuKO
	fPq25+//cZz+3F31lCTIeOBGsfsc2LIZ717iakfBcK5ab34xmCNceDJQj3jNavdp2Px5/Q
	SZy4NJLZ+o5PKYq76oc4fUkll7mpOssbuzvV+RL6db9/YLR0yP390S+rYdXPC+vgqovpbe
	CVOroY+f09oT6v5+Qi3/M8qYy3mAnTFWvR+sPrNXMm3rtUzqEVTdxfdVPVl0yEE9KN7RHF
	7W2FidLa2iiVLgmhiL57IwEVy2f42hEXkFicsQ7fP4G9N988bezlUogq4EqJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1751748001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2vD+jaYiwk+HSz5ZbQuNgl9DF52txAe2E/1eLI8Xm8w=;
	b=Qidgw054ZQe6eca64ttwdk+Aexe9CByUBU0Nk/wS11qeLbwY+miSmnt+SmoWVxl9jsEJ+J
	VggWoB4mPETTDFrTX4OLkIIy4qGuXI5NDNgSzkVnyUXIOWRlCI2tzMc76Mdtl20yVYoSpC
	kSmNccm9Hh5GRdLbAAByb8XGgPZLd13TBrTw9miyWOIl+cGmMSqA6vt5wZrrKWDAVgfKbs
	vn4lp91AVmsy+v416z2TvostioQnd4qG+1ucWtqyYaW6KD6JuMTEdu5ycGbAcwcqEqJpY6
	g5rEZ1h7PTe2NjtazqYpgTOGZncHTDqenrurm7/kT73XL5L3EXXJysM+Njv4Yg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1751748001; a=rsa-sha256;
	cv=none;
	b=Ssq6e2xxiM8Gl4O+9VNBql/0FpVu9YHXHaXeelJJamLNWyNowaHVLSfUUrNxTL622e4ykz
	gd4MtKSWOaf9rSFbT3a4VmJ/ChvcHBqJDum66glouzNtVGWMQrsV8i326GO0KM0welYS7E
	fnJ57xxLtusbtuUQ6FLvu2vOu9EvTZP8L5yzfyUU22revGT0XDfa7vi9oHpz0pD65k3G6r
	QtWs7UGvHdT+Ma3+/jrqbuNtzRX0CDjmxLBAZ8MYP4QWWNFpVj6szZjT7S968FkET58vUp
	d7cHINwa8mdpwf7r5XQP6VmcvkInXZvOyvhP+Y38uKJkv/pj50IO5Xd9heGAeA==
Message-ID: <bebb44579ed8379a0d69a2f2793a70471b08ea91.camel@iki.fi>
Subject: Re: [PATCH v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
From: Pauli Virtanen <pav@iki.fi>
To: yang.li@amlogic.com, Marcel Holtmann <marcel@holtmann.org>, Johan
 Hedberg	 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 05 Jul 2025 23:39:58 +0300
In-Reply-To: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
References: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2025-07-04 kello 13:36 +0800, Yang Li via B4 Relay kirjoitti:
> From: Yang Li <yang.li@amlogic.com>
>=20
> User-space applications (e.g., PipeWire) depend on
> ISO-formatted timestamps for precise audio sync.
>=20
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v3:
> - Change to use hwtimestamp
> - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068=
@amlogic.com
>=20
> Changes in v2:
> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
> - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb=
@amlogic.com
> ---
>  net/bluetooth/iso.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index fc22782cbeeb..67ff355167d8 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2301,13 +2301,21 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
ff *skb, u16 flags)
>  		if (ts) {
>  			struct hci_iso_ts_data_hdr *hdr;
> =20
> -			/* TODO: add timestamp to the packet? */
>  			hdr =3D skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
>  			if (!hdr) {
>  				BT_ERR("Frame is too short (len %d)", skb->len);
>  				goto drop;
>  			}
> =20
> +			/* The ISO ts is based on the controller=E2=80=99s clock domain,
> +			 * so hardware timestamping (hwtimestamp) must be used.
> +			 * Ref: Documentation/networking/timestamping.rst,
> +			 * chapter 3.1 Hardware Timestamping.
> + 			 */
> +			struct skb_shared_hwtstamps *hwts =3D skb_hwtstamps(skb);
> +			if (hwts)

In addition to the moving variable on top, the null check is spurious
as skb_hwtstamps is never NULL (driver/net/* do not check it either).

Did you test this with SOF_TIMESTAMPING_RX_HARDWARE in userspace?
Pipewire does not try to get HW timestamps right now.

Would be good to also add some tests in bluez/tools/iso-tester.c
although this needs some extension to the emulator/* to support
timestamps properly.

> +				hwts->hwtstamp =3D us_to_ktime(le32_to_cpu(hdr->ts));
> +
>  			len =3D __le16_to_cpu(hdr->slen);
>  		} else {
>  			struct hci_iso_data_hdr *hdr;
>=20
> ---
> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
> change-id: 20250421-iso_ts-c82a300ae784
>=20
> Best regards,

--=20
Pauli Virtanen

