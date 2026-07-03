Return-Path: <netdev+bounces-304551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LAhlAoO3R2odeAAAu9opvQ
	(envelope-from <netdev+bounces-304551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:22:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D75A702CCB
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:22:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XQVcQHFY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304551-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304551-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34627304DA2D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CD03D566E;
	Fri,  3 Jul 2026 13:18:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591013D7D70;
	Fri,  3 Jul 2026 13:17:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084680; cv=none; b=kC/HiUSjdxw6037vr+509IEhNhhbkf8e9qJnW5CwzZ2QSr/BBhRfV0GTRHjiArk5bD+NxF0jb+f8xLymMYmCpOfryTlxtP/5cJCGuGbd7QrZdmqlJJ708kd92gQ5TVUYQJQ3MYRI6YYRkXn2dkvW9xvz3PkKxKW3k39fWLwBdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084680; c=relaxed/simple;
	bh=da84PVDC//s0n3UnC3+7q8M9U4D54VfmLDm787Mpq/Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hjIu29W5cXOXtZfV6puqtVhxzZV3+7C0rmBS2js0xwvP/oOVeAaX5Pc9VZdMoFmKbgHEozHizOGkd1BHig7TSBKHMgl4AxiCOU8+jrG3H24uoNHCzCN8KjOdRPCe3Pz+++NXynoWUpbtQCVDlQDSwKGEdQYSoTot/7awpLFUaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQVcQHFY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA301F00A3A;
	Fri,  3 Jul 2026 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783084679;
	bh=9+XNhS6iqV+STX9Ukxgu0+z6kCX6i5FaXvdEcuOwMDg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XQVcQHFYAgSkPmof7wzu4su5pcs8TUlRYRcpZ5omL+SE3tJQj37YepFhfBn9MPNDL
	 pMlXqUPaZsoYifnXHI/V8ABj2z9BxoeqIO6Ne9B0FCX3hJbg9K5N/BX3f+/eUDa1WZ
	 pjbYMm531OXVqkLsArSHfl1x86vspT7hI29leoQu9896Z5jbXg0/Zq5LeIPIaa7mte
	 Adv7XGlc6vtK9HjqoUU/4LqstOHfktTTMyuBxXHETWVKFdDV6mR+jFO9bYH4i7Hi6g
	 ZGn42x0eVpOIF2JGsvIOIjnd6s5D3Xn7Ho2RwkRF0LYX+OoX3Ik7eHXyYJ5xhikj7u
	 MDIVdzlV4wT0w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v2 2/3] selftests/net/af_unix: test listen()
 rejects wrong socket states
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <John.Ericson@Obsidian.Systems>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 John Ericson <mail@johnericson.me>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Rheinsberg <david@readahead.eu>, Cong Wang <cwang@multikernel.io>, 
 Sergei Zimmerman <sergei@zimmerman.foo>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260703081416.2583118-2-John.Ericson@Obsidian.Systems>
References: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems>
 <20260703081416.2583118-2-John.Ericson@Obsidian.Systems>
Date: Fri, 03 Jul 2026 15:17:46 +0200
Message-Id: <20260703-zugmaschine-roden-tagwerk-383588cf7da1@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=brauner@kernel.org;
 h=from:subject:message-id; bh=da84PVDC//s0n3UnC3+7q8M9U4D54VfmLDm787Mpq/Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5b2tYnfl43pGM6Iini49453SxcgY3Cix0nqTCuddYv
 2NtCYtnRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETq5zP8s/3pujB7meGrf61S
 eduYJKZJTMgOLdTfKLH4DZMCX9/Xcoa/wq1GDKbLHzCE3ZbisW7Q5nRdwv577R2D6WaLUqRfOs7
 nBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:John.Ericson@Obsidian.Systems,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:mail@johnericson.me,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:cwang@multikernel.io,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304551-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,johnericson.me:email,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D75A702CCB

> Add a regression test for the `unix_listen()` state check. The key case
> is `listen()` on a bound socket that has already been connected: it is
> no longer in `TCP_CLOSE` or `TCP_LISTEN`, so it must fail with `EINVAL`.
> A `prepare_peercred()` call slipped in ahead of that check once left
> `err` at 0 and made `listen()` silently succeed there instead; this
> guards against a repeat.
> 
> The neighbouring outcomes are covered too so they cannot regress the
> same way: a bound socket in `TCP_CLOSE` listens fine, re-`listen()`ing a
> socket already in `TCP_LISTEN` is allowed, and an unbound socket fails
> with `EINVAL`.
> 
> Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid")
> Signed-off-by: John Ericson <mail@johnericson.me>

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>

