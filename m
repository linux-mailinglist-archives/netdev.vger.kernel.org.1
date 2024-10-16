Return-Path: <netdev+bounces-135984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB88899FE4F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E201F2489A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D450B282FA;
	Wed, 16 Oct 2024 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paas4bPP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93C433D9
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042291; cv=none; b=Kgai7ZtPvj4t7rke30v6E9RPcT0BFWsP2HzhSyWBSH7fmWDPl3aPwJDhO6xEuWQ5n/97/JowvoPhSV3xW0fMlQZwc/czzGYwElvKUj82Wkf7jTe1HONER0175eQnr/X1FlXSmYq00kpwnhN14GGEyiw13qMw8k81CKjxGVLHUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042291; c=relaxed/simple;
	bh=hhIZNNhbRehK/fRlkWPT21p4C5bvD8ibmSfksXpEVZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4+QPGZmD3mJ+Y9xFU4beOOZYUh/gQH4g7OApH7SuyQNFUGypgdFxc90me+T1GD4RZhI6EO0tyE1XKP21CKHhBkTw1aCWc23OO6riZ53c3f4GozqdpKvYPDwVlKdBiFOinjPlqkA61v3j2qghJZwSuGoQ1sLMaFhn0ud/6qbVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paas4bPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9BEC4CEC6;
	Wed, 16 Oct 2024 01:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729042291;
	bh=hhIZNNhbRehK/fRlkWPT21p4C5bvD8ibmSfksXpEVZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=paas4bPPjm5aMP8ZzhN1Gw86PG/w/ymq5ja8k/LM524yNM/eTDi5rMGGtJ4ASK7u0
	 yIq6xt8n8yX/y6CV7vLeSbJii9XEac3CGqwcPq5UG25jG1+P4iR9l6RItUjAj+rV5u
	 oYpqz9TSB1zvK82/RwFEWIBPGPJqlG5ZkfNypEdUTFQ8vhdUQDLCmEwoQnLmOIfHXD
	 5aiUmDvPUX+aQRCBqkwKPM9rTXhwB0hUmRiw7wdi43M7QTk1/TPYHsvEKRkGlJ6J2u
	 pEtsjuK6h79hQv6TiRYthwQIZb+8EbalwVXhdaZwDLEebzunjVaPHOlH63BKv6C2R7
	 nHRkp5HYXUc7w==
Date: Tue, 15 Oct 2024 18:31:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH net-next 09/44] gso: AccECN support
Message-ID: <20241015183120.72eabc79@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20241015102940.26157-10-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
	<20241015102940.26157-10-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 12:29:05 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>=20
> Handling the CWR flag differs between RFC 3168 ECN and AccECN.
> With RFC 3168 ECN aware TSO (NETIF_F_TSO_ECN) CWR flag is cleared
> starting from 2nd segment which is incompatible how AccECN handles
> the CWR flag. Such super-segments are indicated by SKB_GSO_TCP_ECN.
> With AccECN, CWR flag (or more accurately, the ACE field that also
> includes ECE & AE flags) changes only when new packet(s) with CE
> mark arrives so the flag should not be changed within a super-skb.
> The new skb/feature flags are necessary to prevent such TSO engines
> corrupting AccECN ACE counters by clearing the CWR flag (if the
> CWR handling feature cannot be turned off).
>=20
> If NIC is completely unaware of RFC3168 ECN (doesn't support
> NETIF_F_TSO_ECN) or its TSO engine can be set to not touch CWR flag
> despite supporting also NETIF_F_TSO_ECN, TSO could be safely used
> with AccECN on such NIC. This should be evaluated per NIC basis
> (not done in this patch series for any NICs).

net/ethtool/common.c:52:35: warning: initializer overrides prior initializa=
tion of this subobject [-Winitializer-overrides]
   52 |         [NETIF_F_FCOE_CRC_BIT] =3D         "tx-checksum-fcoe-crc",
      |                                          ^~~~~~~~~~~~~~~~~~~~~~
net/ethtool/common.c:35:30: note: previous initialization is here
   35 |         [NETIF_F_GSO_ACCECN_BIT] =3D       "tx-tcp-accecn-segmentat=
ion",
      |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~=
~~

