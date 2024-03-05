Return-Path: <netdev+bounces-77543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E6872269
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021C3B21249
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E164126F31;
	Tue,  5 Mar 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARPcBXtd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C4126F08
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651166; cv=none; b=SKJnaGs30fVhrGEnheCwKHc7P1Zo87MZI/cY/6qFdv5EOJsEA5UasuJQlHSoEp931Q/bVB90RlS4b/5puBWk+pgBXRikcQ+qsOZknPNNhKkUQKXKVuBO+97pu2a3nDp1Hh9eQO+1NcSYxCIgmvyWzDs8LTPwyoCJBiDxzR81fVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651166; c=relaxed/simple;
	bh=XoVpndx8sf++BCXM0AE8BRl2u+9YYaa4Gj1Dtb+cGgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxlWTpmhrmsgwScPHTHo+ZiMvA7buZHWXYFqso/5R7iNWMMIKlZOfuq8l98U1a4kfdh4iB495V3fYzAafINqGDYk43x3hbDb073GmPp9Br53HIjVWVEXIPdQ8sZvki1xnk0lhvLq9AtglTeRtr+sx5RAo+P+da7RNVlobXQkIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARPcBXtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6142FC43390;
	Tue,  5 Mar 2024 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709651165;
	bh=XoVpndx8sf++BCXM0AE8BRl2u+9YYaa4Gj1Dtb+cGgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARPcBXtd/4ClAp1KQZedQvZlzTnl7TfuGcaB23WWYrVsE3IS/mbLesAY3cY2AOs7Y
	 s8+W89YgarbtW2FRv/Hr6v1kciUWUvxLMVtXg7Gh/5l9aWDbpDKYHRG74fsVLaNbEq
	 WkSts0kSrfz+yUp0ZCHs2rEpFJI7Py6u8WmD4LSkiW+ZT+a5A2rbxNP0HiH22lQd1P
	 zJ8iWKi2WU98hH4NKBAfhixQV0Lv6X1maahxKvZrH3oPcjmReUNylvzQQFEYol7y2T
	 YnR9ORN/9gukxR+DdJcsIKOgWhaorhNlLAFE02jve0HtEm9lwq3XJbUSn3YeY0Ox8G
	 bDkh8xPw/yKPg==
Date: Tue, 5 Mar 2024 15:04:32 +0000
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 09/22] ovpn: implement basic RX path (UDP)
Message-ID: <20240305150432.GK2357@kernel.org>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-10-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-10-antonio@openvpn.net>

On Mon, Mar 04, 2024 at 04:09:00PM +0100, Antonio Quartulli wrote:
> Packets received over the socket are forwarded to the user device.
> 
> Impementation is UDP only. TCP will be added by a later patch.

nit: Implementation

> 
> Note: no decryption/decapsulation exists yet, packets are forwarded as
> they arrive without much processing.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

...

> diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
> new file mode 100644
> index 000000000000..c016422fe6f3
> --- /dev/null
> +++ b/drivers/net/ovpn/proto.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + *		James Yonan <james@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPNPROTO_H_
> +#define _NET_OVPN_OVPNPROTO_H_
> +
> +#include "main.h"
> +
> +#include <linux/skbuff.h>
> +
> +/* Methods for operating on the initial command
> + * byte of the OpenVPN protocol.
> + */
> +
> +/* packet opcode (high 5 bits) and key-id (low 3 bits) are combined in
> + * one byte
> + */
> +#define OVPN_KEY_ID_MASK 0x07
> +#define OVPN_OPCODE_SHIFT 3
> +#define OVPN_OPCODE_MASK 0x1F
> +/* upper bounds on opcode and key ID */
> +#define OVPN_KEY_ID_MAX (OVPN_KEY_ID_MASK + 1)
> +#define OVPN_OPCODE_MAX (OVPN_OPCODE_MASK + 1)
> +/* packet opcodes of interest to us */
> +#define OVPN_DATA_V1 6 /* data channel V1 packet */
> +#define OVPN_DATA_V2 9 /* data channel V2 packet */
> +/* size of initial packet opcode */
> +#define OVPN_OP_SIZE_V1 1
> +#define OVPN_OP_SIZE_V2	4
> +#define OVPN_PEER_ID_MASK 0x00FFFFFF
> +#define OVPN_PEER_ID_UNDEF 0x00FFFFFF
> +/* first byte of keepalive message */
> +#define OVPN_KEEPALIVE_FIRST_BYTE 0x2a
> +/* first byte of exit message */
> +#define OVPN_EXPLICIT_EXIT_NOTIFY_FIRST_BYTE 0x28
> +
> +/**
> + * Extract the OP code from the specified byte
> + *
> + * Return the OP code
> + */

nit: '/**' denotes the start of a Kernel doc, however,
     other than that syntax this is not a Kernel doc.

     Likewise below.

     Flagged by /scripts/kernel-doc -none

> +static inline u8 ovpn_opcode_from_byte(u8 byte)
> +{
> +	return byte >> OVPN_OPCODE_SHIFT;
> +}
> +
> +/**
> + * Extract the OP code from the skb head.
> + *
> + * Note: this function assumes that the skb head was pulled enough
> + * to access the first byte.
> + *
> + * Return the OP code
> + */
> +static inline u8 ovpn_opcode_from_skb(const struct sk_buff *skb, u16 offset)
> +{
> +	return ovpn_opcode_from_byte(*(skb->data + offset));
> +}
> +
> +/**
> + * Extract the key ID from the skb head.
> + *
> + * Note: this function assumes that the skb head was pulled enough
> + * to access the first byte.
> + *
> + * Return the key ID
> + */
> +
> +static inline u8 ovpn_key_id_from_skb(const struct sk_buff *skb)
> +{
> +	return *skb->data & OVPN_KEY_ID_MASK;
> +}
> +
> +/**
> + * Extract the peer ID from the skb head.
> + *
> + * Note: this function assumes that the skb head was pulled enough
> + * to access the first 4 bytes.
> + *
> + * Return the peer ID.
> + */
> +
> +static inline u32 ovpn_peer_id_from_skb(const struct sk_buff *skb, u16 offset)
> +{
> +	return ntohl(*(__be32 *)(skb->data + offset)) & OVPN_PEER_ID_MASK;
> +}
> +
> +static inline u32 ovpn_opcode_compose(u8 opcode, u8 key_id, u32 peer_id)
> +{
> +	const u8 op = (opcode << OVPN_OPCODE_SHIFT) | (key_id & OVPN_KEY_ID_MASK);
> +
> +	return (op << 24) | (peer_id & OVPN_PEER_ID_MASK);
> +}
> +
> +#endif /* _NET_OVPN_OVPNPROTO_H_ */

...

