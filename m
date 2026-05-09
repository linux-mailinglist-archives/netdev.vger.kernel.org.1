Return-Path: <netdev+bounces-286082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBidOqeW/ml5tAAAu9opvQ
	(envelope-from <netdev+bounces-286082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:06:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6456E4FD85B
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40DBC3012BDC
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71C28751B;
	Sat,  9 May 2026 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4Mhw1F6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA726B08F;
	Sat,  9 May 2026 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292387; cv=none; b=XZmQBimrbOyzHMPD1zkXmhr/pOqZLzpc2OWz5ThZDtFnDJK0XOa9sX7mlEqlN9OqFIWLP3F5TlDOa7qoVyM1BhSDtRkDWjgw98SucbrQHCsY86CwxV8nte1dDaQ4NgjmvnKhUwK94EyG0EatCLsGsYBW2x9qjc5oqazPyEa4euI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292387; c=relaxed/simple;
	bh=yn/+2cFICuNwU4pGxRYer4YVYdlnxxH4QSToZStIcyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hj2yqkqdK2PS9VPasT7zYnc3ZdUzGN97pRIhDjrlujVC7rrO5vUomHkwMutk56O0/QvckCc+zByuBh/sYiWz/cuFwBZ0/vFS7mnAVVquKnq1CTd87UOd3pddR9lwb94K0NFiizy73NUzsNn4Dc1bmSEf0gHadH5KPsiO02UlkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4Mhw1F6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB7EC2BCB0;
	Sat,  9 May 2026 02:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778292387;
	bh=yn/+2cFICuNwU4pGxRYer4YVYdlnxxH4QSToZStIcyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4Mhw1F6oIvfZsNHKhRF7oZA1f+r5DybiOB0cjwEfLEnQvg8blFPa+Gp5Ay64P/ne
	 Y15OuuDcB4L7X7lM2al6YeDBdvbpVfEWNUjwOf5C1YQd8TuRCDZhv8mDlE+hvAFjkF
	 CYM7OT0gAWSeacJQnx/9hzWK+zeX4ofEh009Zh6cOU+QpoWQJtf5jwjNxMRZFPphf8
	 ECpfElyKwzyf7W81d/jowE8vgRhMt3449XzTTb+wo9hD670zVWCrFKBtHTtrhLaZiq
	 vynBG6JJ9zf39MOobmuPG6YpiystZGOioFjTSRXHUIsyHC840xg8rUDRFrMiDDuzBR
	 63i7fEiK+G9fw==
Date: Fri, 8 May 2026 19:06:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Simon Schippers <simon@schippers-hamm.de>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
Message-ID: <20260508190626.4285fac0@kernel.org>
In-Reply-To: <6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
References: <20260505132159.241305-1-hawk@kernel.org>
	<20260505132159.241305-4-hawk@kernel.org>
	<ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
	<8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
	<e3a91545-13cd-4f87-8375-d707865bdbca@schippers-hamm.de>
	<6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6456E4FD85B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286082-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[schippers-hamm.de,redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 7 May 2026 21:09:09 +0200 Jesper Dangaard Brouer wrote:
> >>> I still think first that adding an option to modify the hard-coded
> >>> VETH_RING_SIZE is the way to go.
> 
> Not against being able to modify VETH_RING_SIZE, but I don't think it is
> the solution here.

Was it evaluated, tho?

It's obviously super easy these days have AI spew no end of complex
code. So it'd be great to have some solid, ideally production-like
data to back this all up.

VETH_RING_SIZE seems trivial, ethtool set ringparam

