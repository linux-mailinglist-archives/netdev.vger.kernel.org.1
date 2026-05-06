Return-Path: <netdev+bounces-284784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KvoA4sa+2mtWgMAu9opvQ
	(envelope-from <netdev+bounces-284784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:40:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3054F4D9665
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BA8D305B45A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C303E9F9E;
	Wed,  6 May 2026 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="TWdksrvX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpRM3IwW"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA573E928E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063863; cv=none; b=UrLJT8i9HvyXIP2m0wrIKGiqDfXViSSmhZ72dhX0a8ApKiZrScSDNB0fjrwozehWTdgTn6VxnvsR3SedpiRO2k0K3KFj05zJfAHfjz3i2mlF/eyJ6le+ZDuKHk7uDp0m2FduZCdan73flXAXtEBE4g89P4BS7iy80UDnKpLP8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063863; c=relaxed/simple;
	bh=biJ3LHoFgrAWOZjyZVAaLvaFFUj3TGFGsDB+WdUA54E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB/xWACm9aQxT2TeY6uOGABuxDgv9qj8pWfZNT/1FETLGa9zYgdHa8yTgnlSVaOkTY5Hj98Jf6Kf3lw8rvlf4+PZI4kSKvdoltbNM24cWksZsr5gM5x7eBCitLnHXheYUjZh52J3KPu5ivIoJI8GtUszZF3jTOTXGT15dgZ8Cyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=TWdksrvX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpRM3IwW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 01AB6EC0093;
	Wed,  6 May 2026 06:37:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 06 May 2026 06:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778063857; x=
	1778150257; bh=frVuoQFLdboaKoDRBOxAsVGzqw0B/EOSMqbitjEfcnI=; b=T
	WdksrvX0z2sbcN61De3kmejcak/RrgozRk1zhc17wUk+CGih9At5stqi5mj0p8D6
	ae2z/OkPD8hkRFs/F+tXLidBb393VoO0TYTm30fuXsUwge9E9YzL/R/CfP21KZ2a
	GjESPnWoK10NFTRM8ignXTyRsEL6bFGzosB8Mm9B5NMeuQwEVh/M/ZG+UFisHmmM
	pjr4jnrZA3MeTc9OeZmkKbM7T6C45h7Nw+JcE4dXfxkWtVD/gSeX8nhyXZFLt14z
	J23SQpAMmPqCSfADb3tgyyM66eG/P6DMLVdmct6HWHkAyOaA5ycmN79eRu5ufsK/
	ur0mOhDIeLqkRy6Y3q6ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778063857; x=1778150257; bh=frVuoQFLdboaKoDRBOxAsVGzqw0B/EOSMqb
	itjEfcnI=; b=NpRM3IwWFvXArb4NQR24cCuMkmffY96mYSxmlQ5R+T4Zss/uy9Y
	5oPes9d/9mrg4OHPx6050rnfkSYzujX6k8KQSorZAPWA0eq2+mJWv/sAng0vgtvn
	2lGX0Be3xzdlq+OnaIieNlKxPKXL4DX/v9Of30gU7ZgdT+QhyGTamhEgtkJ8eBXZ
	E/elgc472IpHPZGDNFTYLWpiELma7FYE7beoZVwNOWuFjWoLezJzQXZdKsmLM6Jd
	cNuuNMCOxC5MmBNzdLL5+QckqyIpuvotj1a7Dk//SYlasvu2QNaPKNZcGGRkEF98
	HEFNnHTeZC7n7xk7IHhiL4D2FmDJHyq7iRg==
X-ME-Sender: <xms:8Rn7acKdDfdgmB4AGhtfAdWPbS7j0J7vMKHr-WgyNnhhdDa-1R9VXA>
    <xme:8Rn7aX_ikdTY6JNs5bEUJsJfwMjU1gM9m13TsGUGxTjWW0hg0YF-BkK4FVwzMNwc_
    45YNjkrlc2pOlnl03z2txUG41gNKiblWAgU8IdXhQth20BAzuH2K9c>
X-ME-Received: <xmr:8Rn7aYHDAEt-_8-_oH3YH_EwIl8JiFPmgJrYM46HeHtv9II-fsBAzo8k3UoR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdegfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehrjhgvthhhfigrnhhisehpuhhrvghsthhorhgrghgvrdgtohhmpdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshgrvggvughmsehnvhhiughirgdrtghomhdprhgtphhtthhopehtrghrihhqthesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtohepmhgslhhotghhsehnvhhiughirgdrtghomhdprh
    gtphhtthhopegsohhrihhsphesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhohhhn
    rdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8Rn7aS5hk-rdl_PE50ueaFE3bQrV9LClAURWUEdfgoMwRQgS_2HKww>
    <xmx:8Rn7aRZLAgsOOaajVjFs6C-hWum8zMv9WU3QDTJnXEv6GIf2lMDaxw>
    <xmx:8Rn7aQiOtjbvMBqDLPts5Oh08V_AVzTKBkFY23sDsh9alOcNY0N9jA>
    <xmx:8Rn7aTe3Tvhaugn61I7pJoolnuvsCdi-cyOCSeZRCJm294gX_5_XbQ>
    <xmx:8Rn7aR8Zcc_zHNSMJuNX0N28k1beMmVH3FtGYb7n8QKPn2hCDwYNcB7o>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 May 2026 06:37:37 -0400 (EDT)
Date: Wed, 6 May 2026 12:37:35 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org,
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v13 5/6] tls: add hardware offload key update support
Message-ID: <afsZ74sn1DUHxM18@krikkit>
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
 <20260429181016.3164935-6-rjethwani@purestorage.com>
 <64d71f18-f86b-4fd7-a6bd-02243eed0492@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64d71f18-f86b-4fd7-a6bd-02243eed0492@redhat.com>
X-Rspamd-Queue-Id: 3054F4D9665
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284784-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[purestorage.com,vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

2026-05-05, 10:40:41 +0200, Paolo Abeni wrote:
> On 4/29/26 8:10 PM, Rishikesh Jethwani wrote:
> > On TX, the NIC key cannot be replaced while HW-offloaded records
> > are still unacked. tls_dev_start_rekey() installs a temporary SW
> > context with the new key and redirects sendmsg through
> > tls_sw_sendmsg_locked. If no records are pending,
> > tls_dev_complete_rekey() runs inline during setsockopt; otherwise
> > clean_acked sets REKEY_READY once all old-key records are ACKed
> > and the next sendmsg completes the rekey, flushing SW records and
> > reinstalling HW offload at the current write_seq. A KeyUpdate
> > arriving while one is pending re-keys the SW AEAD in place; if the
> > HW reinstall fails the socket stays in SW mode (REKEY_FAILED).
> > 
> > On RX, the NIC may have already decrypted in-flight records with
> > the old key before the peer's KeyUpdate is parsed, so the old
> > AEAD, IV and rec_seq are retained on tls_offload_context_rx.
> > tls_check_pending_rekey() invokes tls_device_rx_del_key() to drop
> > the NIC key; otherwise post-KeyUpdate records (carrying new-key
> > wire encryption) would be XOR'd with the retired key.
> > tls_device_decrypted() classifies records by old_nic_boundary:
> > 
> >   - after the boundary: new-key record; drop the old key.
> >   - before, fully encrypted: advance old_rec_seq, let SW AEAD decrypt.
> >   - before, (partially) decrypted: reencrypt with the old key so SW
> >     AEAD can decrypt with the new key.
> > 
> > For mixed records skb->decrypted flags can be wrong (NIC clears
> > them on auth failure); on -EBADMSG, tls_rx_rekey_retry() toggles
> > those flags, decrements old_rec_seq to reuse the nonce, and
> > retries once (gated by old_key_reencrypted).
> > 
> > The new key's tls_dev_add is deferred until the old key is fully
> > consumed: tls_set_device_offload_rx() sets dev_add_pending while
> > old_aead_recv is retained, and tls_device_deferred_dev_add()
> > installs the new key once copied_seq crosses old_nic_boundary.
> > 
> > Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
> > TLS 1.3 TX and RX KeyUpdate cycles.
> > 
> > Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> > ---
> >  include/net/tls.h             |  84 +++-
> >  include/uapi/linux/snmp.h     |   2 +
> >  net/tls/tls.h                 |  29 +-
> >  net/tls/tls_device.c          | 753 +++++++++++++++++++++++++++++++---
> >  net/tls/tls_device_fallback.c |  24 ++
> >  net/tls/tls_main.c            |  92 +++--
> >  net/tls/tls_proc.c            |   2 +
> >  net/tls/tls_sw.c              |  76 +++-
> >  net/tls/trace.h               |  79 ++++
> 
> This patch is really big and complex and you should break it to help
> reviewers.
> 
> At very least you can split out the tracing bits and the trivial
> refactor moving around declaration and definitions to separate patches.

True, that would make review of the refactorings easier, and then the
changes for rekey would be more obvious.

Things like tls_sw_ctx_tx_init, adding/using tls_tx_cipher_ctx and
others helpers, function renames, splitting of
tls_set_device_offload*, maybe others.

Based on this, I won't review the whole rekey code this time around (I
think it will be much easier to follow the logic after the split), but
I have some comments that I'll send out today.

-- 
Sabrina

