Return-Path: <netdev+bounces-267939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICFWJwLitmloKAEAu9opvQ
	(envelope-from <netdev+bounces-267939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:44:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F21A9291823
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A8F4300C92B
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEA5371D1D;
	Sun, 15 Mar 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqbUpT8g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F3221540
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773593088; cv=none; b=hzKR3dbqd0YSzWr4jw1BFEpR/rgNQnJzy6aE2Q3v4RheJLErLxnexd+5zS+zCUuTWdnvUehViMSk7esBxVa0qp2sR7vPAsWXdhn9bl2FqMP89WsqRZXeJMz91u3aTJ70SLlb3YFIgF6BjmhEb8hqUcQpy4T7MFKsFZXT64Dcozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773593088; c=relaxed/simple;
	bh=uCPI/EKwvtUKYoNU9iAMXx/QFPZHPsfW6UW9P57Kd+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j06+ZaGhoO0KCUVZeshgqXH8WRt2QJSPXewhgVHsdRbboT2/N7c0ZGTCm8FU/bB5mD03FARl1CQaKhUQaGlJVbxl83m7am2kW3xxxZ0AbIJYVXLtldEX5WSAnORprC8vTZLQl+51HVaeIhx936tUrlbg9H774Uhlwvq/1C/kv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqbUpT8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00010C4CEF7;
	Sun, 15 Mar 2026 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773593087;
	bh=uCPI/EKwvtUKYoNU9iAMXx/QFPZHPsfW6UW9P57Kd+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqbUpT8gV+KMmlSW/CQY5OIsTAp8A4z4VSGFPSz4if5XnO248dTcX4UaHFuOrMwKl
	 37Cht0wIcTAvq6thdEwfa6tkhYg/6HT/l+5HwX71h/TlPc+OIBaO6ecfDVuXJmBkNA
	 gfit9Ayf83N9idhuhAkcs7Ky9lJ6RPZ/gEAxwTVI7A+WBSkuDC+/b2zRkgLeCNWmGv
	 A0TJiVX+UklvtxOXJC97W9lbSFnemiNIhSd7+iSPVJdb/eSeD0QNsxjipsok83t528
	 MQHDMQdK10/egnAXWlfes6NNdPzSXidxouTKOY95MuDMq2RTIjFIRlAjQxZG4OGudJ
	 yM5YtsasYV0zA==
Date: Sun, 15 Mar 2026 16:44:43 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next] tcp: improve inet6_ehashfn() entropy
Message-ID: <20260315164443.GB1369074@kernel.org>
References: <20260313120346.3378811-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313120346.3378811-1-edumazet@google.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267939-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F21A9291823
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:03:46PM +0000, Eric Dumazet wrote:
> Instead of only using the 32 low order bits of the local address,
> use all of them.
> 
> Xor net_hash_mix(net) with the 32 high order bits of the local address
> so that we can use __jhash_mix() three times.
> 
> If we were hashing 4 extra bytes, we would need one __jhash_final()
> which is a bit expensive.
> 
> Using net_hash_mix() at the beginning allows beter register allocation.
> 
> We no longer use a cascade of two jhash and inet6_ehash_secret,
> this was dubious/weak.
> 
> Add a comment explaining why @lport is not part of the jhash computation.
> 
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-24 (-24)
> Function                                     old     new   delta
> inet6_ehashfn                                330     306     -24
> Total: Before=24855958, After=24855934, chg -0.00%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v2: do not include @lport in the jhash computation.
>     Add a comment explaining why we need @lport being added.

Reviewed-by: Simon Horman <horms@kernel.org>

