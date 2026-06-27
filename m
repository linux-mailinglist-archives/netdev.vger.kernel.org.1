Return-Path: <netdev+bounces-302355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LtmIHvw+QGpieAkAu9opvQ
	(envelope-from <netdev+bounces-302355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:22:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1196D2B21
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:22:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=etwKwAkq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302355-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302355-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DB1D30046BF
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FB737FF53;
	Sat, 27 Jun 2026 21:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65C37DEBE;
	Sat, 27 Jun 2026 21:21:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595318; cv=none; b=ZBvd85zXl1e8/cH5YA8F6TPwEznRSMmtcfDnvDTx0Fv6rUxeKqRV7b8gOiuI+v/0MyYs0/gK/QWU4nznVbpw+bZR12kEl6eiR6Xr5SB7Cq8cVIq1HplK28pYf8K7b1BtffzbOIY4I5mMSxRJ0cpQ4YKJwn19nFjzWjCGCrbeCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595318; c=relaxed/simple;
	bh=fLVB8L5+UljNjcYGv92tq6IstmLoDyzrm8uVsdgxFhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=So2wQ/ZM858bnGKclRygA/i6QpGR06qJ8FLzmV+qaOrvLVxtISg8+Fac8ARhlAT+Cws5IMjojlGdUFQ9viqiFjKI/B/GSRqewhLKu9IvBjhhmnrCuqD5MZl7nIK0KUi5LlWYJPYaB4J9G3kkfWhSKVcPphPDV3htgE5y9H5qVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etwKwAkq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47821F000E9;
	Sat, 27 Jun 2026 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782595317;
	bh=x5uT+S91bvMhpnwLh7iOTlNFiSDT1D7uAsCLsW/OXis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=etwKwAkqBhWWyGjxnktRGcWg9eLJSghh12WRaB1pGLx5X7wRliWWGNmWU3bE/nuPX
	 KFAu/GmsEQcQvQC3+2jDi6JIRrvKu64YKTqq11hlHL2j1VVJXWes0VUgcowHspKNjD
	 UioAn9dNnm2bx3beW1HLHbDq6b2N8LTGgNkv1hRokUnZX9SRLoxGxg2WWFPIqDUat5
	 pb2NQ5ftsiqy6+8LFwnqKmA8IaaL+DxdG81EZF/+p6yRV5om2PQsl7Ubl/CDKLTrH6
	 uIgmcNgGXc8RuxsH0PBDRrwB7s/n9rREsgcYOyyn/PEXamA+B10aezPLF2sWja1oag
	 4LmIJHSc5nUTw==
Date: Sat, 27 Jun 2026 14:21:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "syzbot" <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, <netdev@vger.kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, syzbot@lists.linux.dev
Subject: Re: [PATCH] netdevsim: remove debugfs files before freeing
 net_device
Message-ID: <20260627142156.64c5799a@kernel.org>
In-Reply-To: <f15205c4-30e1-454f-97e6-92067a74f98f@mail.kernel.org>
References: <f15205c4-30e1-454f-97e6-92067a74f98f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302355-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:syzbot@kernel.org,m:syzkaller-bugs@googlegroups.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:syzbot@lists.linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB1196D2B21

On Sat, 27 Jun 2026 11:20:11 +0000 (UTC) syzbot wrote:
> A KASAN slab-use-after-free was detected in debugfs_u32_get() when reading
> a debugfs file associated with a netdevsim port.

Please read the replies to previous submissions:
https://lore.kernel.org/all/20260626184856.4b7f5228@kernel.org/
-- 
pw-bot: cr

