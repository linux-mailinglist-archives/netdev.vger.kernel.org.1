Return-Path: <netdev+bounces-203409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31031AF5D48
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A114E1E4D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C102E7BBA;
	Wed,  2 Jul 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qwCmYvbl"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0D2DCF54;
	Wed,  2 Jul 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470273; cv=pass; b=kzoKNnkit66spH9W6TShud5VH11k4KwQyHEXr91YAgrF5I+LKWFWeFsSGFX6aKZpd2XRAB22JPsPQCQJbVSZpIngqw77iOV0Sb2+dTquoviEEKD+75ZhbeUzCRN+rG48HivVvWIFoCqnnTgPVaFqq2TMOniWMmYyg5Y/olhupy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470273; c=relaxed/simple;
	bh=MPn4dwWS4SsgFUv2ktEgYlMmldSTWVa0DGbq8Yo9njs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/Hu5pdoRc9WXhYJgWrhEJuA7MF7OA1D//qGG/5G69JC7bIzB4btGbCNmoCO9vM7bwgeu8WN0HRmwWjyVyVjhxa3dcViWHNyicrYwAde5qaQg5bJniLYLCyeFJ/2OvnQdl6lpUy+4h39kj3xfz9DTIXdEKzoWWQlj8T/CC41cTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qwCmYvbl; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bXNv66SDgz49Q1w;
	Wed,  2 Jul 2025 18:22:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1751469781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=74URfcO5JqEqPB6bVC6qfZC838MIsWWJe/PpASUbCcg=;
	b=qwCmYvblW1ha/yOsewISSpkENjgZG6kjiLfwgD0E+sVtnNzh7Zr2APWtQjd75KzRr4ENID
	bREMQTMzIGyQq7GVpw0pWWqcKKMdAgslFC2A6NPz2cYwlBY6lQ+Z6XSyoG2bebOhh3hGbR
	yzxJghasL1SVrZw0yElS2xcort6THfuzb0NWrF95KsPt01HEXhdNSluFnPci+PsrcU3jeg
	CkTQKPb/sDydrKGVVGDFVxEvtxnYpTRD5pyrBHOLLY1c0Jv8IWsr/Oi1JFoSFuJRk64k6d
	nxI5+9DuJrSsWWuw2EqbJ/GqWCZxaVeikWDhLI++PbAGa10N5/mIvIThj5dZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1751469781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=74URfcO5JqEqPB6bVC6qfZC838MIsWWJe/PpASUbCcg=;
	b=Bv+zQLY/uODqENaM6A+8FpHCZeTVMohTR+6yB6cacaQUKKREpAdN4s86urYViTDo+sYBgi
	P1tFQrjn7ks7/8ZtC6i9GYh5r+X/CCUVubuWHEBi6zLdSYK2OLSWuIrue5GZ/iYgeQ+asE
	/e5p9W6wrQbFlBd5RWDivSqEZCYpI2qpUyN7b36rcgnUWKa6V3GIcknISLH+iU9N4g5s3/
	8mJRLrtS0Yhec1VZUbXs7U5WeZJwHVf6303Sj6Ifoa/qdBNg9CUTtCTRPq/O6qiBQqpgrA
	RVr/N+EyUAdyEoUMX3hmWRD4JNUaWTs0ruomOJ/FwsrSI8S+T/o/u+ZhsiiTyQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1751469781; a=rsa-sha256;
	cv=none;
	b=Un44gB7xX3oHblb63J1ZUJcaxwh9h1IM/GXh/z3WacNRJoluk3xC/FZdg8sMXiWE3fKARu
	rwMhFyPesxQWyabrE/grEPy3rW7F556dvD487yqFxyUN8AKFHOZQgoIjHgeWeNlxMFq1HP
	IIQB+tI+B1ApF8GG+3L0yLiCl/Nel4TRfvLezNuMwf2Ea6QiMrMEHcuRn6k39rWnIbqql1
	+ffCgM61X2xXFvdjV3GTZiDvx7s40ovSl4QX21Hz4fueFT36s4pWFJCxifa4SUbaR4mjbQ
	0kfuv4T60XWlFAN45QjQ1MnOrOz6NtNiFzU40/C45S5XYpQSr6nkdrNfwxDoBg==
Message-ID: <d6906cfb7fae090b9fe0c1c5b8708182eb939b42.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: ISO: Support SOCK_RCVTSTAMP via CMSG for
 ISO sockets
From: Pauli Virtanen <pav@iki.fi>
To: yang.li@amlogic.com, Marcel Holtmann <marcel@holtmann.org>, Johan
 Hedberg	 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 02 Jul 2025 18:22:56 +0300
In-Reply-To: <20250702-iso_ts-v2-1-723d199c8068@amlogic.com>
References: <20250702-iso_ts-v2-1-723d199c8068@amlogic.com>
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

ke, 2025-07-02 kello 19:35 +0800, Yang Li via B4 Relay kirjoitti:
> From: Yang Li <yang.li@amlogic.com>
>=20
> User-space applications (e.g., PipeWire) depend on
> ISO-formatted timestamps for precise audio sync.
>=20
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v2:
> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
> - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb=
@amlogic.com
> ---
>  net/bluetooth/iso.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index fc22782cbeeb..6927c593a1d6 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2308,6 +2308,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff=
 *skb, u16 flags)
>  				goto drop;
>  			}
> =20
> +			/* Record the timestamp to skb*/
> +			skb->skb_mstamp_ns =3D le32_to_cpu(hdr->ts);

Hardware timestamps are supposed to go in

	skb_hwtstamps(skb)->hwtstamp

See Documentation/networking/timestamping.rst
"3.1 Hardware Timestamping Implementation: Device Drivers" and how it
is done in drivers/net/

This documentation also explains how user applications can obtain the
hardware timestamps.

AFAIK, skb->tstamp (skb->skb_mstamp_ns is union for it) must be in
system clock. The hdr->ts is in some unsynchronized controller clock,
so they should go to HW timestamps.

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

