Return-Path: <netdev+bounces-207126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB92B05CE7
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274351655B3
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E66A2E267F;
	Tue, 15 Jul 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="i8JWJmg2"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36470831;
	Tue, 15 Jul 2025 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586223; cv=pass; b=mjUfJDlES+dOwuO7Ceke6ueKfbdHuKxze1BCp8sdqGLn8RkxdoGaDVgMk1tK+XMVdrVfn0RJ0uBzF4cMw5fNQ4E6vL5K3jIfihta/+T+JsCPh4LW8AGU19QRcxi0wB1nRu6wF4HZkVJKHbgW7hn44NvGzsDznnpeyqsenaoSmi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586223; c=relaxed/simple;
	bh=ukVqDzKv3T002zkFrlqTEt5G+rdShgc0hTxrWB4rZ18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XK5M/0JrfdAb1d0S957rHrbQMi342kRqed7QXkOL7bZuhuP9uZai28dmC6dFfNcaX1KsI49cZUW5oyOL7XPkE6RhpTD8zG3KOH6ITQEPIudFhwPsohhGH7WDWFFT+wPgeWnFmPPVUx0WOAbGBBuoCUMBv79xJJGUnm7L+KJOH9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=i8JWJmg2; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bhKn00KTrz49QDm;
	Tue, 15 Jul 2025 16:30:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752586212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wojtQdm1EX7XpuNh9dziLOT6hG/mH6gTFQHlhqQ/p2c=;
	b=i8JWJmg25uSDUf822B9CqfyqcE0u2SNQo7Fl4nrxeahbLDcI666afqWGmHSTD9U58AyOAA
	9GxJMYL9z8FhL3CX5bT4OetA05jsK57yHCIXUBzAkOT3JPLP2JysXQxiOl6UxVORzTUsQI
	dYWyOytdQBrt4kYOuTXdo6NqWQmgpsl+4ntVKvIvTVloKBjcJpPUL5o/rmh5J8P7hoLo4/
	yewAjrlky2Qm8TPvWY/drHW0497LztbuBnNLFN2XBwq7LAJXIevHqcy+74U6Byn/scEqxx
	giST69wvicFiZsUE5vw09NaG/ZrgHix4w+D3H2J18fYW/sBbQGJGblpwuQALYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752586212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wojtQdm1EX7XpuNh9dziLOT6hG/mH6gTFQHlhqQ/p2c=;
	b=RtmXHiU/7Nxwmp8nuQyZ0IPy1wMnrVO38CzyExrwoUqrmzXpvVKipywwqUnp08P5Ctckcy
	BI9Lg+jYQng1htgleLWFVGeWooVt6idthsTASaUG1yV/pHwQm5wjF7rl2bptQtC6O2lpc/
	8GfbSOGJTIwvJDhsRDbwk2KJD9BPI1tT5fFxGyTdMZA4R/A+58xPGoA+SvGRBfVROnOEI5
	fqiNBYjnWLjfF0UvGaJePrWXOG5BOjs+YDW11YotfXwjNcVi4dWV/+Svbr5EeAy/MeM7Ot
	bgggCNOJ9Ta6jC6x50zlRWi7IXoMysslB6OgBlX7491StSuXKVpIz6FNRktlqQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752586212; a=rsa-sha256;
	cv=none;
	b=kaniIZ/FOgcdgo0vtt3eswmO3WDkeEjP9fIbhuHTbA1mfMEi5ko4IAgmAvQih028jgURVP
	s+FfMw1W51hIBdEAeVgtcaEMuznQKeelhuuTphjpQh1xJZAPYaYwRAlWAJSQwZVv65YK8G
	M3H02Qysxj800ZeeB2wOOlWUIQPv/GnBWuDkVjuNkponBmfhyypNHD00WulyCq8nBvUe9T
	2IvsFbcDrNZZRFOHfMhwSSzOf6/vSs5OB8U0C8XbeEeqFOEaOFUFRvmq7FHRoLHTXRVl0+
	cifozbyg951MoiuAobGzxghMVsF2Ff/p/Z5KS3x4gt/SEzMbVxbQ6VeoW8+EBw==
Message-ID: <dc9925eceb0abe78f7bafe2ed183b0f90bdb3ac5.camel@iki.fi>
Subject: Re: [PATCH v4] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
From: Pauli Virtanen <pav@iki.fi>
To: yang.li@amlogic.com, Marcel Holtmann <marcel@holtmann.org>, Johan
 Hedberg	 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 15 Jul 2025 16:30:11 +0300
In-Reply-To: <20250707-iso_ts-v4-1-0f0bb162a182@amlogic.com>
References: <20250707-iso_ts-v4-1-0f0bb162a182@amlogic.com>
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

Hi Yang,

ma, 2025-07-07 kello 10:38 +0800, Yang Li via B4 Relay kirjoitti:
> From: Yang Li <yang.li@amlogic.com>
>=20
> User-space applications (e.g. PipeWire) depend on
> ISO-formatted timestamps for precise audio sync.
>=20
> The ISO ts is based on the controller=E2=80=99s clock domain,
> so hardware timestamping (hwtimestamp) must be used.
>=20
> Ref: Documentation/networking/timestamping.rst,
> section 3.1 Hardware Timestamping.
>=20
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v4:
> - Optimizing the code
> - Link to v3: https://lore.kernel.org/r/20250704-iso_ts-v3-1-2328bc602961=
@amlogic.com
>=20
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
>  net/bluetooth/iso.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index fc22782cbeeb..677144bb6b94 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2278,6 +2278,7 @@ static void iso_disconn_cfm(struct hci_conn *hcon, =
__u8 reason)
>  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>  {
>  	struct iso_conn *conn =3D hcon->iso_data;
> +	struct skb_shared_hwtstamps *hwts;
>  	__u16 pb, ts, len;
> =20
>  	if (!conn)
> @@ -2301,13 +2302,16 @@ void iso_recv(struct hci_conn *hcon, struct sk_bu=
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
> +			/*  Record the timestamp to skb*/
> +			hwts =3D skb_hwtstamps(skb);
> +			hwts->hwtstamp =3D us_to_ktime(le32_to_cpu(hdr->ts));

Several lines below there is=20

	conn->rx_skb =3D bt_skb_alloc(len, GFP_KERNEL);
	skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb-
>len),
        	                                  skb->len);

so timestamp should be copied explicitly also into conn->rx_skb,
otherwise it gets lost when you have ACL-fragmented ISO packets.

It could also be useful to write a simple test case that extracts the
timestamp from CMSG, see for example how it was done for BT_PKT_SEQNUM:
https://lore.kernel.org/linux-bluetooth/b98b7691e4ba06550bb8f275cad0635bc9e=
4e8d2.1752511478.git.pav@iki.fi/
bthost_send_iso() can take ts=3Dtrue and some timestamp value.

> +
>  			len =3D __le16_to_cpu(hdr->slen);
>  		} else {
>  			struct hci_iso_data_hdr *hdr;
>=20
> ---
> base-commit: b8db3a9d4daeb7ff6a56c605ad6eca24e4da78ed
> change-id: 20250421-iso_ts-c82a300ae784
>=20
> Best regards,

--=20
Pauli Virtanen

