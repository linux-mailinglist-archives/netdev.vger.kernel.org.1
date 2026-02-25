Return-Path: <netdev+bounces-260793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CFyD7m0nmnZWwQAu9opvQ
	(envelope-from <netdev+bounces-260793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:37:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED721944DF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14FB630363B5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68631CA4A;
	Wed, 25 Feb 2026 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQh/oDwg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843323E35F;
	Wed, 25 Feb 2026 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008630; cv=none; b=JxIGoMECJ5ThuUJvot01CYVx3WdWj1AXoJyOGKHk+/NfndhiICCy49KtknQXIHVZOKr+tS5xfXOvxU126y29ypbqog3BfMfKy1oJwxApVoUXKFujSeWoaLqnk8wjz1Q2f4PZfGlZtU7QOWClFnLbPUa0aKYFEcGivDCU1fIZjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008630; c=relaxed/simple;
	bh=v2rH28nFVvo3EsdsY4l5mm7g16gXuk4fKlF1OhHQTwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9lw0jK8WzAKjqPTDBff2uN5FXOzUxcFJ0j5TLGmFAU/zDA10bGb/8Ch+AsIYGgyfAXFtiA6G4YkVteatKCnsc8MbC/3nndyEuq7jDUtwUPTTwlybyTtnqLZI0To0MSMvVQrMsu+B28eZrHpwjnOd4qT45ZTuKG+0/Vtn3G98QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQh/oDwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946D9C116D0;
	Wed, 25 Feb 2026 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772008629;
	bh=v2rH28nFVvo3EsdsY4l5mm7g16gXuk4fKlF1OhHQTwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQh/oDwghR4VGZoT2ipd2jZskB/lLXAY7AK5bgABVXn4tvYygDUriJC6d3JcOfY/U
	 wXohKYEvRGYwSfcxRD/f/V9ZZyg9PZvKlOhGv0Hi5sQ2ji11vxiJaN9Zu817DfQV+y
	 qK2m3JZSQ7s9lahjEHHQJtANwtcz/FnfoWku8eopG0tgwEjG3/qC4WM8KPcZ6sgiJw
	 +97ZN8Si11iBiH0cDtQYNwDOHYsKjAqzEnwXM9A9AZo0aVk+0mHFasF+hsNsW1GSKe
	 6JJQi9O2FybXuRvI1u8XDgprK/3s4Eg431fvCpo3OHHcM5dQeQHofxE1+qbzoIrINu
	 /7vT61fAs68nA==
Date: Wed, 25 Feb 2026 08:37:05 +0000
From: Simon Horman <horms@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
Message-ID: <aZ60sfG1tdraA0zB@horms.kernel.org>
References: <20260224044648.243578-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224044648.243578-1-jiayuan.chen@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260793-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,72e3ea390c305de0e259];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 8ED721944DF
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:46:38PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> syzkaller reported a null-ptr-deref in lec_arp_clear_vccs().
> This issue can be easily reproduced using the syzkaller reproducer.
> 
> In the ATM LANE (LAN Emulation) module, the same atm_vcc can be shared by
> multiple lec_arp_table entries (e.g., via entry->vcc or entry->recv_vcc).
> When the underlying VCC is closed, lec_vcc_close() iterates over all
> ARP entries and calls lec_arp_clear_vccs() for each matched entry.
> 
> For example, when lec_vcc_close() iterates through the hlists in
> priv->lec_arp_empty_ones or other ARP tables:
> 
> 1. In the first iteration, for the first matched ARP entry sharing the VCC,
> lec_arp_clear_vccs() frees the associated vpriv (which is vcc->user_back)
> and sets vcc->user_back to NULL.
> 2. In the second iteration, for the next matched ARP entry sharing the same
> VCC, lec_arp_clear_vccs() is called again. It obtains a NULL vpriv from
> vcc->user_back (via LEC_VCC_PRIV(vcc)) and then attempts to dereference it
> via `vcc->pop = vpriv->old_pop`, leading to a null-ptr-deref crash.
> 
> Fix this by adding a null check for vpriv before dereferencing it. If
> vpriv is already NULL, it means the VCC has been cleared by a previous
> call, so we can safely skip the cleanup and just clear the entry's
> vcc/recv_vcc pointers. Note that the added check is intentional and
> necessary to avoid calling vcc_release_async() multiple times on the
> same vcc/recv_vcc, not just protecting the kfree().
> 
> Reported-by: syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68c95a83.050a0220.3c6139.0e5c.GAE@google.com/T/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Simon Horman <horms@kernel.org>


