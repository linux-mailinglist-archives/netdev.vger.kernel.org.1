Return-Path: <netdev+bounces-201217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2BAE87FF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4FB5A7B8D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408122DA765;
	Wed, 25 Jun 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="MDfinMof"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7232DA752;
	Wed, 25 Jun 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865005; cv=pass; b=PiLCVpAB5iCqS1mBRIn+svNd837SUPR4eFIxM1u47HK6fU4pXzujG144wvlJi9dpBnYvAlCXtxtTNLU0FHRDTM0kLUtZbwIlxUxhjrUgrk4uL9GxZrWut5oGyi6byFvx369m859wittX0XEZf/EsrxXFu3McmA/rkAwWG2/q7n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865005; c=relaxed/simple;
	bh=dbm6Ij9s2O8swfUZzR1v4IH0cSSPUEclfNNYbKRETwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vC/Jt2aw9b2HeQZCX/jJc0yb8/mz9iAgtTQMw9d0o7PJFIzGizVrbY+4avGDgJlIr973kXYlO5D5kUkCVETIcf2sEugx6G6nSBkkRE3ttgavZnOcgvcWmb7liMYA2nlC9VM3k16LNjn/dj+j4ujm4/Mv0aYAEXUb1HQ1s0kNRLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=MDfinMof; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bS5Df2y1rz49Q47;
	Wed, 25 Jun 2025 18:23:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1750864996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=psSAEbA6GBc3e7dUMsn95jE0RdMTFhIo/mTHBwvBzf4=;
	b=MDfinMofByz7XZhDK2T0GeJzfEZ8fZQq3Iu0ZILTmHhoNia+VXLg5ExlXPFz2wVs1qkm4d
	pL5l9mMgRAiZ0wpyftZPyk0DjAZsWvLsFmznVT1B6qfokdA2ac0tQY3u3MVt6lFxE8/kud
	30blGJ9BTvCCF4X5vdtiJGngAfp8K8owc5Jz77IzQI6jnlEDKI8n6OguFqUygJKtgtkbrW
	brjZ/010A58/Zl2DBeSC5drzhoRfNmg+kF/w9m1pQ0I1yjhaPPNzXMsq4vylHSOYFA1qDz
	Wn+F6x8ndXpQU0EWNKdymQlicaLAJygrtAFGQVbKpIFJukPv7coDDE/qtPQBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1750864996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=psSAEbA6GBc3e7dUMsn95jE0RdMTFhIo/mTHBwvBzf4=;
	b=vCjqnD3FcXf/2mMvCcfeyDA6vg4BjiRQ4lJyaP75swsfKXZGhAHyX/it/7MYSRInA/jPJH
	G/wuUo8IF5AAJ7EeO/EXiNmCKZcMg3b9edc7Y9gSs7i8C8BOi7TzakfZKZoKaPG0yZHaQ+
	SlNAME7nBJqs6LBDfoOjWugcPfdW5oLKqfraw97Kt0ydk3RKsJk4KfvakpwdStsWVfx/Sd
	L+vF6qf61X/R6ZXlbxrs0P99EPza9oSMYTTLW2122JtdDnb46Q9TN6YaC6MoEPayw+mBkf
	SYtdFBkBGnHf/2Tn5XekmcQ7w9kTR17jKBm/+tV1wfys+PsnZHFA/smeRxyTNg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1750864996; a=rsa-sha256;
	cv=none;
	b=IXNg2LDtngA7UtAuMRAmck9XgZUJR38EbTfbA9OPGjTvS8M7BlxwKuuWwhlTzUkcGVjvuB
	cX2oFohH26IvXLzxSKPMD6UTbCF8obcwKSslu9VNcS3IHMjhCNzc+RaXlZBbVi5IkZV5er
	jMru5gFkxsIbazPW+WtVP7nc16om8l+pZyVu50XfzOnzmjfEI28Jt50c9Nj/2qLupkWMnw
	ulL0eNoNxErqXUzAt4XYqdQJwMguUKYISygCsj1YdJ9H2zj6FNiwq7QX9YXNJvWJpSCUBe
	Rfo4E3MucIgvlGbmdJU8CEBWv3ZtxLyM0pkLi5zI6rO89nD1eQJxedzy2ehzbw==
Message-ID: <1306a61f39fd92565d1e292517154aa3009dbd11.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: hci_event: Add support for handling LE
 BIG Sync Lost event
From: Pauli Virtanen <pav@iki.fi>
To: yang.li@amlogic.com, Marcel Holtmann <marcel@holtmann.org>, Johan
 Hedberg	 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 25 Jun 2025 18:23:13 +0300
In-Reply-To: <20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
References: 
	<20250625-handle_big_sync_lost_event-v2-1-81f163057a21@amlogic.com>
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

ke, 2025-06-25 kello 16:42 +0800, Yang Li via B4 Relay kirjoitti:
> From: Yang Li <yang.li@amlogic.com>
>=20
> When the BIS source stops, the controller sends an LE BIG Sync Lost
> event (subevent 0x1E). Currently, this event is not handled, causing
> the BIS stream to remain active in BlueZ and preventing recovery.
>=20
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v2:
> - Matching the BIG handle is required when looking up a BIG connection.
> - Use ev->reason to determine the cause of disconnection.
> - Call hci_conn_del after hci_disconnect_cfm to remove the connection ent=
ry
> - Delete the big connection
> - Link to v1: https://lore.kernel.org/r/20250624-handle_big_sync_lost_eve=
nt-v1-1-c32ce37dd6a5@amlogic.com
> ---
>  include/net/bluetooth/hci.h |  6 ++++++
>  net/bluetooth/hci_event.c   | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>=20
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 82cbd54443ac..48389a64accb 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -2849,6 +2849,12 @@ struct hci_evt_le_big_sync_estabilished {
>  	__le16  bis[];
>  } __packed;
> =20
> +#define HCI_EVT_LE_BIG_SYNC_LOST 0x1e
> +struct hci_evt_le_big_sync_lost {
> +	__u8    handle;
> +	__u8    reason;
> +} __packed;
> +
>  #define HCI_EVT_LE_BIG_INFO_ADV_REPORT	0x22
>  struct hci_evt_le_big_info_adv_report {
>  	__le16  sync_handle;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 66052d6aaa1d..d0b9c8dca891 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -7026,6 +7026,32 @@ static void hci_le_big_sync_established_evt(struct=
 hci_dev *hdev, void *data,
>  	hci_dev_unlock(hdev);
>  }
> =20
> +static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
> +					    struct sk_buff *skb)
> +{
> +	struct hci_evt_le_big_sync_lost *ev =3D data;
> +	struct hci_conn *bis, *conn;
> +
> +	bt_dev_dbg(hdev, "big handle 0x%2.2x", ev->handle);
> +
> +	hci_dev_lock(hdev);
> +
> +	list_for_each_entry(bis, &hdev->conn_hash.list, list) {

This should check bis->type =3D=3D BIS_LINK too.

> +		if (test_and_clear_bit(HCI_CONN_BIG_SYNC, &bis->flags) &&
> +		    (bis->iso_qos.bcast.big =3D=3D ev->handle)) {
> +			hci_disconn_cfm(bis, ev->reason);
> +			hci_conn_del(bis);
> +
> +			/* Delete the big connection */
> +			conn =3D hci_conn_hash_lookup_pa_sync_handle(hdev, bis->sync_handle);
> +			if (conn)
> +				hci_conn_del(conn);

Problems:

- use after free

- hci_conn_del() cannot be used inside list_for_each_entry()=C2=A0
  of the connection list

- also list_for_each_entry_safe() allows deleting only the iteration
  cursor, so some restructuring above is needed


> +		}
> +	}
> +
> +	hci_dev_unlock(hdev);
> +}
> +
>  static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *d=
ata,
>  					   struct sk_buff *skb)
>  {
> @@ -7149,6 +7175,11 @@ static const struct hci_le_ev {
>  		     hci_le_big_sync_established_evt,
>  		     sizeof(struct hci_evt_le_big_sync_estabilished),
>  		     HCI_MAX_EVENT_SIZE),
> +	/* [0x1e =3D HCI_EVT_LE_BIG_SYNC_LOST] */
> +	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_LOST,
> +		     hci_le_big_sync_lost_evt,
> +		     sizeof(struct hci_evt_le_big_sync_lost),
> +		     HCI_MAX_EVENT_SIZE),
>  	/* [0x22 =3D HCI_EVT_LE_BIG_INFO_ADV_REPORT] */
>  	HCI_LE_EV_VL(HCI_EVT_LE_BIG_INFO_ADV_REPORT,
>  		     hci_le_big_info_adv_report_evt,
>=20
> ---
> base-commit: bd35cd12d915bc410c721ba28afcada16f0ebd16
> change-id: 20250612-handle_big_sync_lost_event-4c7dc64390a2
>=20
> Best regards,

--=20
Pauli Virtanen

