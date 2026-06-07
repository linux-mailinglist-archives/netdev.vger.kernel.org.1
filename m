Return-Path: <netdev+bounces-296318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cTUQLHbsJWoNNwIAu9opvQ
	(envelope-from <netdev+bounces-296318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 00:11:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B76651C92
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 00:11:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="h Zt+8u3";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=FAycgVaQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296318-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296318-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C276D300D479
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 22:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A09633AD82;
	Sun,  7 Jun 2026 22:10:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316D6FC5
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 22:10:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780870259; cv=none; b=Stttw82SQRvgs7Zczz5OlfURXkRrzEzR3p2DQN6eLp8AWsTE7FRcXAmcpJj4BaW73bcYRmMUbcreVHHZ6nnk0S3wRwdITOuF18KTCc/DM3fTWAOI5kFF8CwEJhtSvhsloibjhS+CM2NXaVa/dp44i8PxY3VWO0i1JYUxzfL1cIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780870259; c=relaxed/simple;
	bh=cSg3mEe/nk3Hc3/J47bZa6b7/HjEyK6H3PEjizIHGyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBlJbIBUeeQKPnfMtw3FCK0oMGesiQCtM0Mpg4Gg+js4iP2QaWgn9t0oj4bwSHwoZhi2eg+trUnfbX+OCDE5JvQVGt77+Vm6rtaeRu3IYt0Q7Ln63Vz8EPjY6YSeF4/xXlEN9cHA0MlDXxwVKoWq+sIh0Ks0bk5sR+I5nmlJU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hZt+8u3C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FAycgVaQ; arc=none smtp.client-ip=202.12.124.155
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61E257A00E2;
	Sun,  7 Jun 2026 18:10:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 07 Jun 2026 18:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780870254; x=
	1780956654; bh=ORguDEtjWww27H8qt3wdVTnWIh76EuvWiCrQuOvCf9Q=; b=h
	Zt+8u3CV9Jn58jSQ7/XHw4zz+UvDZO6uSpTluShesHenVeigSomUGF07APL1CM3c
	XTUFwl09Ca+J3YVfXXTiPJl/lpmOremYfBLDhTGGvoiX7pNiDlcv/Cfk6ysx8iPI
	5XEOQEel4iBZdZ2OGoF1X9Fj3TWspfzJ9PZbmKlaJp7QIic9UPt7LUN+h5Mbcz0R
	hGpnNvgZ4bAE8JxkYydtIZvjaNPACYDbfTnxUQ2j7W1gg9Ro4bfPelJxl2i/b3jN
	YucWBNYEh/VjJGk1QjryjbRtRqfUyMlRDrpCzlga4pkfkiDwVCnz8m2RvsNlwil3
	A2TDz6R8AEKEWeTSyoWvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780870254; x=1780956654; bh=ORguDEtjWww27H8qt3wdVTnWIh76EuvWiCr
	QuOvCf9Q=; b=FAycgVaQQDKMIi+e+ssmtCWu4Mps9FctGkov5C91kHF3LQeTeYU
	q5HUuZVhu0SJ4dotPQHIzexYRUP6c4Urm1e7C281jLRBl6f3WvD1GwHDj0AYhKau
	85GE6etrHHrGXiUe+vRrEcL0/7FCuqUbuXLFDON3hldH43+op01Cz6vRWFB6PmqO
	lca8xfBZd3vGNh2WEkWyuU2dJvLNYDgy4wIsLLMT1qxdhXil2IZoz2S73Vci076e
	7YVH/RpaZt37VcdXkPeDy6WbefMr9PYQTEynVIQcQdHGVIOIzjfefWGaLkEI1Xzl
	Twq91wfDi4eNzSE8XJhvMt798rXhbBU27hg==
X-ME-Sender: <xms:bewlav_Dx4Tj3fp2ZCLGf80hCOSbbNkAP4yv5Iun430q6pDfxrKKYQ>
    <xme:bewlauyOrgQmGXqzZUoFDFpg1BUcCIEeI_kxhZaazTXz2P7VmVUGHZIw0RfBHLdJ0
    CUw88Bp26zLKNft-a02cov6Q0XlarPy62TnH_-KPDWH1VKhQIV2bA>
X-ME-Received: <xmr:bewlanq6aJimX03eOt8OZW4XKBJrlU2C6cx7oM6dNRC8bFRvRqzdBowKyLVlDC69rBwiO3s5fIj8w1AkJUIiMIc>
X-ME-Proxy-Cause: dmFkZTEzypjPAMTRugTLai+EOQ1s2Juwf36K9gfdJJ2HR/CddZi/x+tXzrWsUY1VRJ//4o
    h4Z9fPhvuObMo8dXmVJeXScZHRlc3epOR1IbBXqDBCir071An/ldMAStQm2t2JES//fyNM
    87gK22OYlR1tRlF3kKTjs4/LrcBTwzGLSyC/QKj8UL5wl68DDjCWDvLqCluwYtG6MMia0b
    WturvXTHX3s9p0Z8G7BLwIqy6gTBt/Al3ZU6JvLfiT3NlnggJzrURkddLLw7K4sKunRbrr
    ub45Y+3B1Qo7Pxigsohjylx8KBgAvixyO9TVjb/N2FXXSY/OwuVa8hojRbsDxX5u0QHATg
    dDaMxPPQ21L0ExjE2SMMntDutyhtYkD/E3tHrWOzFP33/uqsfzJ7wblns+oqiDzQNulcNR
    +i5C2XOqk/UmCVeADpHM3ssn6O0h8D11o/2UF8T+zoDFvfRYGIR3wcxjBgWS/ulYw3X2BA
    n8CTgjP7icDJCNZIi6T10G2nJgkrbxFFkHqsKfBlEr0Nny9UcpYUEbIm64o+OPH2c7zcly
    ySEPR6Aw+kKdEQEGnuVR+9l3QSGLasyTD7zXDKShnp6VahBM2MqOaJcjwO1X+0wRSJBAFK
    5N9G4Jt7RI4lOPXzRJW2BKD9blrWtM5yKQOqUTXvKzLaGiVWqi4bKWDi8y7g
X-ME-Proxy: <xmx:bewlanp5m4m5iy0OkLRSEPm6Xh4yq8XH_C31eDi3ptVWI5fUpuQACw>
    <xmx:bewlavC9jqLcrTqZf9FpURuHp46-hXhDCy5QoG4-lsKE4Kg11ztgeA>
    <xmx:bewlatuPHnGzPclytX9VMRjWTHvw24P7GChfDmnQup5XCWmQqwipzg>
    <xmx:bewlamLEoLCbjW1y9XpOYdKgbvgKuZcmnjrDi8dy_WWxdbA8N-TtYQ>
    <xmx:buwlaixQsDpHOF_BVVD_J0xboQpu3NxPD_NqL5pJpWhHnLTdZbjL1KdF>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jun 2026 18:10:53 -0400 (EDT)
Date: Mon, 8 Jun 2026 00:10:51 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH net-next v12 6/6] tls: Flush backlog before waiting for a
 new record
Message-ID: <aiXsa5zx3u0DUn0l@krikkit>
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
 <20260604-tls-read-sock-v12-6-b114efa6e3e2@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260604-tls-read-sock-v12-6-b114efa6e3e2@oracle.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296318-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@suse.de,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[krikkit:mid,oracle.com:email,queasysnail.net:dkim,queasysnail.net:from_mime,queasysnail.net:email,suse.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5B76651C92

2026-06-04, 13:48:29 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> While lock_sock is held, incoming TCP segments land on
> sk->sk_backlog rather than sk->sk_receive_queue.
> tls_rx_rec_wait() inspects only sk_receive_queue, so backlog
> data remains invisible. For non-blocking callers (read_sock,
> and recvmsg or splice_read with MSG_DONTWAIT) this causes a
> spurious -EAGAIN. For blocking callers it forces an
> unnecessary sleep/wakeup cycle.
> 
> Flush the backlog inside tls_rx_rec_wait() before checking
> sk_receive_queue so the strparser can parse newly-arrived
> segments immediately. On the next loop iteration
> tls_read_flush_backlog() may redundantly flush, but this
> path is cold and the cost is negligible.
> 
> Backlog processing can run tcp_reset(), which calls
> tcp_done_with_error() to set sk->sk_err = ECONNRESET and then
> tcp_done() to set sk->sk_shutdown = SHUTDOWN_MASK. The pre-existing
> top-of-loop sk_err check already ran before the flush, so the
> freshly-set error would be masked by the next-line sk_shutdown test
> returning 0 (EOF). Re-check sk_err immediately before the sk_shutdown
> test so a connection abort surfaces as -ECONNRESET rather than a clean
> EOF.
> 
> Commit f508262ae9f2 ("tls: Preserve sk_err across recvmsg() when
> data has been copied") gave the top-of-loop sk_err check a
> has_copied split. The recheck applies the same handling: when the
> caller has already copied bytes, sk_err is reported but preserved
> so the error surfaces on the next call; otherwise sock_error()
> consumes it so the error is reported exactly once.
> 
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Link: https://lore.kernel.org/netdev/ahgHgQ84RCc8uYrG@krikkit/
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls_sw.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks for your patience with this series, Chuck.

-- 
Sabrina

