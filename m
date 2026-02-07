Return-Path: <netdev+bounces-257714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBSPKsqthmm2PwQAu9opvQ
	(envelope-from <netdev+bounces-257714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:13:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE85104C60
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 111C43016D09
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 03:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF2337BA4;
	Sat,  7 Feb 2026 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiz1CHPB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71A222582;
	Sat,  7 Feb 2026 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433990; cv=none; b=rSfjzDiit+oQ5Kc6siMEw8t7ILkQIBYZoeCmw7i3kzdlJBlTuoaXDf6v1g2y+lTBP1qEnV+OcIC6IuDhAy4ptafsGkDU1q5dLTKBO3jNFVxkxnkB0OnSeEI1TwcomGj4CLeXyPX9B2oTbl2wKGIVAMZ92j5fwGSiYb8NvOBdksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433990; c=relaxed/simple;
	bh=jO9T6Wauc6sgCUGQKDfmY5wCuFcBaI3/fiI365rgQYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1dErc+sKQUNnv1GC1cdUulBOFMcpVcWhzuN3xZCJDE5VGc0XL0Tt6SLoekgtkXKbbjeT9yKvt3bMSjoKDvgT9FHzkfWrjUsCiFDQpMjUBjgDHF2T/m0i2C0+SmgFZKiiehfOKDZccxAf0sJOytrOznnd5bJS8CMqcQ/6CxEt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiz1CHPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3A6C116C6;
	Sat,  7 Feb 2026 03:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770433989;
	bh=jO9T6Wauc6sgCUGQKDfmY5wCuFcBaI3/fiI365rgQYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aiz1CHPBvgEHRzoYQ7Hlt+jua/1QQnJo9V88pJWZKQu7kQBAE9j8Pe31BJVth3mmB
	 l0zBzbPZZA67vkrulASCUX9vvHCkHjo4nqPnuXG2BMrsPAJ2Eb5TXon2JWRaPC3gLN
	 QQCQLA8ii6k51y/dPPosCAs9BKoNBF4Ah0+TvvEwOh4DTWW9HXg8wGM8ypcglqMmzl
	 xlVw7PHJE7vZcyCN+oaXQruGMWWISjP8ZrGGrJBwL308bgnNCjL7bGr55+avkFOmtJ
	 hCkfsZm9E2O5YDMVy2kLxI393dmmkvhAfViXovLWfw6/DJkk+H0eMOoTZ77ym9nyAh
	 U69GKuF8OybRA==
Date: Fri, 6 Feb 2026 19:13:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Srujana Challa <schalla@marvell.com>
Cc: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <ndabilpuram@marvell.com>, <kshankar@marvell.com>
Subject: Re: [PATCH v2 net-next] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <20260206191308.7fdbfef4@kernel.org>
In-Reply-To: <20260206120154.2548079-1-schalla@marvell.com>
References: <20260206120154.2548079-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257714-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BE85104C60
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 17:31:54 +0530 Srujana Challa wrote:
> Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> align with kernel's standard RSS key length. Add validation for RSS
> key size against spec minimum (40 bytes) and driver maximum. When
> validation fails, gracefully disable RSS features and continue
> initialization rather than failing completely.

Hm, FWIW clang says:

drivers/net/virtio_net.c:6841:31: warning: result of comparison of constant 256 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
 6841 |                 } else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
      |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~

Which is kinda annoying because the value was increased in net-next.
If Machael wants this backported then we need to keep the check
and follow up in net-next? We could try to cast the u32 away but
that feels dirty..

