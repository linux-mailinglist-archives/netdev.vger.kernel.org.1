Return-Path: <netdev+bounces-260846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEd0LGTFnmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:48:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC9195459
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A972303B933
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F3B38759D;
	Wed, 25 Feb 2026 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpzSYJS1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369F33CE85;
	Wed, 25 Feb 2026 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012748; cv=none; b=j84bW/D4Gu+h0Noy5Q2yv/dvLI+qOnp8if82ReLE+rZBMEJv2+Wga7QGN2kk/b/8sMMnyFfsh9frrrRMfvw3bFEZT8hqgYiTk5LuZzd5iq6nSu35b36nGX0nyKJya/tXLhFC4SdL8TS24Sdc2f1kkMuYvftIF5ChsdhrQhZ09ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012748; c=relaxed/simple;
	bh=+AIaFX+M+97g0FC7V8T6FVbRuf2pCtdY/Mu0e3fv1TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdgXof8WcXswiAPeTeGvoIfkhoTx7QkYieA0lXr8WBvRjZlEIyH9LXwpG7w7ggk6kRi91MAV3e2wPop2ET62SthpvYW8e62g+aFCMyAHQbmucJh8IMQvM8c9DwYQjBy0A11kluxzxk3TFvYPm19ZkMZ7w+RzwLpHUQp49Ge/0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpzSYJS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977B5C116D0;
	Wed, 25 Feb 2026 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772012747;
	bh=+AIaFX+M+97g0FC7V8T6FVbRuf2pCtdY/Mu0e3fv1TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpzSYJS1CLjwf1gP9zjWL5R7sOqJQopkUI/fGiONizbjjUNeYhAPx0pLhy5qRA+kR
	 +0ZlTWW1tHvehApcLXhXKIkKYYRsGo8nNTCBg/sAG+zNXcHydLi26uF6HPm6seEOsJ
	 nqAOrz2LONUq5ChfKIwcnVneUjWDjfK/0HGfXFZPz5G1dzxrpr0Spdnz78cPCBLtyj
	 H+UKCe9kGtmNYq9mfwXSW9c6zYjOvZPJF8v9Rx/eQDnpSGK/A8nrrFXPwucS24asdo
	 UfZ0AsqpjmNp2604wDGLWd+D/Ft3UQikwu59PWWin5AVLLeXhgtnSaWwRkrHlrE/Wg
	 zWSHkk2Ty2JFA==
Date: Wed, 25 Feb 2026 09:45:43 +0000
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
Message-ID: <aZ7Ex6c1ZeqvWLFp@horms.kernel.org>
References: <20260224044648.243578-1-jiayuan.chen@linux.dev>
 <aZ60sfG1tdraA0zB@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ60sfG1tdraA0zB@horms.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260846-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,shopee.com:email]
X-Rspamd-Queue-Id: 5FBC9195459
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 08:37:05AM +0000, Simon Horman wrote:
> On Tue, Feb 24, 2026 at 12:46:38PM +0800, Jiayuan Chen wrote:
> > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > 
> > syzkaller reported a null-ptr-deref in lec_arp_clear_vccs().
> > This issue can be easily reproduced using the syzkaller reproducer.
> > 
> > In the ATM LANE (LAN Emulation) module, the same atm_vcc can be shared by
> > multiple lec_arp_table entries (e.g., via entry->vcc or entry->recv_vcc).
> > When the underlying VCC is closed, lec_vcc_close() iterates over all
> > ARP entries and calls lec_arp_clear_vccs() for each matched entry.
> > 
> > For example, when lec_vcc_close() iterates through the hlists in
> > priv->lec_arp_empty_ones or other ARP tables:
> > 
> > 1. In the first iteration, for the first matched ARP entry sharing the VCC,
> > lec_arp_clear_vccs() frees the associated vpriv (which is vcc->user_back)
> > and sets vcc->user_back to NULL.
> > 2. In the second iteration, for the next matched ARP entry sharing the same
> > VCC, lec_arp_clear_vccs() is called again. It obtains a NULL vpriv from
> > vcc->user_back (via LEC_VCC_PRIV(vcc)) and then attempts to dereference it
> > via `vcc->pop = vpriv->old_pop`, leading to a null-ptr-deref crash.
> > 
> > Fix this by adding a null check for vpriv before dereferencing it. If
> > vpriv is already NULL, it means the VCC has been cleared by a previous
> > call, so we can safely skip the cleanup and just clear the entry's
> > vcc/recv_vcc pointers. Note that the added check is intentional and
> > necessary to avoid calling vcc_release_async() multiple times on the
> > same vcc/recv_vcc, not just protecting the kfree().

Sorry for coming back to this a 2nd time.
After thinking about this some more I'd like to pass on
some feedback from the AI powered review.

I'll put the full text below. But in a nutshell: could you clarify
why it is necessary to avoid calling vcc_release_async() multiple times.

AI output was:

  Is this description of the guard's purpose accurate? The commit message
  states that the null check is "necessary to avoid calling
  vcc_release_async() multiple times on the same vcc/recv_vcc, not just
  protecting the kfree()."

  Looking at vcc_release_async() in net/atm/common.c, it sets ATM_VF_CLOSE
  flag, sets sk_shutdown |= RCV_SHUTDOWN, sets sk_err, clears ATM_VF_WAITING,
  and calls sk_state_change(sk). Calling it multiple times would redundantly
  set flags that are already set and trigger sk_state_change() multiple times
  on an already-shutting-down socket.

  While preventing multiple vcc_release_async() calls is beneficial, the guard
  is primarily needed to prevent the NULL dereference on vpriv->old_pop (which
  would crash) and secondarily to prevent use-after-free on the kfree'd vpriv.
  None of the repeated vcc_release_async() operations would necessarily cause
  a crash or data corruption -- they would just set already-set flags and
  trigger redundant callbacks.

  Could the commit message be more precise about the primary purpose of the
  guard being to prevent the NULL dereference, with preventing multiple
  vcc_release_async() calls being a beneficial side effect rather than the
  main reason for the check?

And, I believe due to that, AI goes on to comment about the fixes tag.  FWIIW,
I think the commit you cited is correct with respect to the first part of
your patch which protecting against double-free. But I do begin to wonder
if we may have two fixes in one patch.

  Should the Fixes tag point to a more recent commit? The null pointer
  dereference bug was directly introduced by commit 8d9f73c0ad2f ("atm: fix a
  memory leak of vcc->user_back") in 2020. That commit added cleanup code for
  entry->recv_vcc that frees vpriv and sets vcc->user_back to NULL without
  checking if vpriv is already NULL.

  When multiple ARP entries share the same VCC, the second call to
  lec_arp_clear_vccs() dereferences a NULL vpriv, causing the crash. While the
  entry->vcc path had similar code since 2005, commit 8d9f73c0ad2f introduced
  the recv_vcc path with the same vulnerability, making the bug exploitable.

  Consider:
    Fixes: 8d9f73c0ad2f ("atm: fix a memory leak of vcc->user_back")

> > 
> > Reported-by: syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68c95a83.050a0220.3c6139.0e5c.GAE@google.com/T/
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> 

