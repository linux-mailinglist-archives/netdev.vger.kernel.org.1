Return-Path: <netdev+bounces-262178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFY6MsYio2mC9wQAu9opvQ
	(envelope-from <netdev+bounces-262178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 18:15:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851E1C4D57
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 18:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF4EA305F4C3
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6567C212B0A;
	Sat, 28 Feb 2026 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLQL9r7y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421BAF9C0;
	Sat, 28 Feb 2026 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298947; cv=none; b=DOtig7tk23fFDUNjCj9xQNwtZh/P9jmOcvfdX9J5HMQ0aNZv80f4y0xgUhh/Nqywi6+TjwmHkUUi69ZwbNfTrgRPJoEyA+F9B9pSV8QLg67L1CJ/n3HbIjvlockPKkH9bMlDqlbdOVeoXlnEcOUlqAFFJFTpAeCbr11QBBAP+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298947; c=relaxed/simple;
	bh=g5zuGVKS7v7fviuuVEC+z+dh+biXaZe2a+7u1x3Txx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngAGlFRCaMTqqKCzrX3mPardTFGSZ7jtFThOywrR5EPyO1DsA0ykzTUbiwu4C4cDcmYbHoOwW/zBdcs7+npPYa6Fp+fjMMCDB0sWGsScg7lRNBX2fsJ/hffr74OCUVKw/khLjNuUX22UEwnUunsy38pxWpTMgPn3hblqRozFzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLQL9r7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC96C116D0;
	Sat, 28 Feb 2026 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772298946;
	bh=g5zuGVKS7v7fviuuVEC+z+dh+biXaZe2a+7u1x3Txx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLQL9r7yE9NDzL8fJ1nHueq4A01CPlMlAh9Xrw/Mb+AFs+v/KyvGYdL1DS31Kgly9
	 dp5qRwlira7rMEWlqOUT1o9V6PIvutz2EYDdAFG6fg0j1hql8C9rjcc2xhvilSuo2d
	 9uSIrcakN18H6KxKO01ac9sDL6Ar67gFg900e4675ixG5A4t4u6i/zo2Tf4nCZcjwk
	 1AF31EQ8E8JCGzxzkujoH2Y6ioU7XqgqmuZrlWNbbRzKm73icV+W/RQs19f9cM039/
	 08/HmWlF2khBttTY1dKQPtipft5TEE8Jc7refbadKMGMojjBbgfsZ7iJvfRfDKBFfy
	 qXHZtPNL5NXuA==
Date: Sat, 28 Feb 2026 09:15:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+ca1345cca66556f3d79b@syzkaller.appspotmail.com, John Fastabend
 <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vakul Garg
 <vakul.garg@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] tls: fix hung task in tx_work_handler by using
 non-blocking sends
Message-ID: <20260228091545.412a9a2d@kernel.org>
In-Reply-To: <20260227063231.168520-1-jiayuan.chen@linux.dev>
References: <20260227063231.168520-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TAGGED_RCPT(0.00)[netdev,ca1345cca66556f3d79b];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1851E1C4D57
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 14:32:31 +0800 Jiayuan Chen wrote:
> tx_work_handler calls tls_tx_records with flags=-1, which preserves
> each record's original tx_flags but results in tcp_sendmsg_locked
> using an infinite send timeout. When the peer is unresponsive and the
> send buffer is full, tcp_sendmsg_locked blocks indefinitely in
> sk_stream_wait_memory. This causes tls_sk_proto_close to hang in
> cancel_delayed_work_sync waiting for tx_work_handler to finish,
> leading to a hung task:
> 
>   INFO: task ...: blocked for more than ... seconds.
>   Call Trace:
>     cancel_delayed_work_sync
>     tls_sw_cancel_work_tx
>     tls_sk_proto_close
> 
> A workqueue handler should never block indefinitely. Fix this by
> introducing __tls_tx_records() with an extra_flags parameter that
> gets OR'd into each record's tx_flags. tx_work_handler uses this to
> pass MSG_DONTWAIT so tcp_sendmsg_locked returns -EAGAIN immediately
> when the send buffer is full, without overwriting the original
> per-record flags (MSG_MORE, MSG_NOSIGNAL, etc.). On -EAGAIN, the
> existing reschedule mechanism retries after a short delay.
> 
> Also consolidate the two identical reschedule paths (lock contention
> and -EAGAIN) into one.

It's not that simple. The default semantics for TCP sockets is that
queuing data and then calling close() is a legitimate thing to do
and the data should be sent cleanly, followed by a normal FIN in such
case.

Maybe we should explore trying to make sure we have enough wmem before
we start creating records. Get rid of the entire workqueue mess?

Regarding your patch I think all callers passing -1 as flags are on 
the close path, you could have just added | DONTWAIT if the flags 
are -1.
-- 
pw-bot: cr

