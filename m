Return-Path: <netdev+bounces-304249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mGy4KI6wRmq7bgsAu9opvQ
	(envelope-from <netdev+bounces-304249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:40:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3946FC30B
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:40:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm3 header.b="N FYfDvo";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=oKror4K3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304249-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304249-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 804B230CA317
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA642346FB3;
	Thu,  2 Jul 2026 18:05:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743E32937A
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 18:05:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015524; cv=none; b=EoaYOl+lveInZ5WcMM/UC7LcfqIfGcihym7pZDPfVlVXpIDJGHeW/OWukHbSTpJnm2ZRyQ67fQWa/vgivlTaRRye5rmbgNKVnCAvWRfrOFuU/pIOhRbA/jr7QRcnRTXW36TswUdNgU7xRmZQLo1R0RZzc5IZ4UohlOxwtPCLWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015524; c=relaxed/simple;
	bh=ay6NJKkDQizb5EQ1lM5X3BJfLV8jZQnbR96BcuA03dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMG0XC9ygKFuoD4yf01fdLeICDXxsmxHcltalm3WdYjGD/wE4pCeMqDuIsrXC8H9SefApltaIfS7BkfLKaGtTIjzAfeeDJHF+Aa0UzWKYAUjY/efnYnxBLzPXqmawQKXB5qRyqr3OHoPi6NhZknoXiRTjH5MvTEXxB3jXt2G2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=NFYfDvoQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oKror4K3; arc=none smtp.client-ip=202.12.124.151
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 967861D00086;
	Thu,  2 Jul 2026 14:05:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 14:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783015520; x=
	1783101920; bh=VQ37vJ23hrjvK+nRNASQiJ26vFguBJ/W07YUaAa5YI4=; b=N
	FYfDvoQiyLzx2Wpl68G/u3FwwE7kCCvuvpFHE33FvqboFh2rVWWdKKrVCNtlZcAl
	xrOPk1aiObkEPaAGwBKscsQPLggwDX0hfbdURVaxffdLrCpG5KXqVmt8BPAiF216
	zj6la47jyU0xZEE1AG6s2CqaRXv2W3AtZ/jGWlOQsdwgUsEnIuR9AGzxAI0drYSp
	mpQKYVwmxx/5ia9qOFRmRQ7bFraLSlDyw5rv8I2T1RSbyThIQ14sBfxXKvkQf59w
	hvAUbgXdpZDzR9Wm3tQ5qkNZJCi3VoulTDi2K7iAOd/TI6d7u0jw2B+3DH6o9WkL
	XMar0SBasw4zr5enMQR+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783015520; x=1783101920; bh=VQ37vJ23hrjvK+nRNASQiJ26vFguBJ/W07Y
	UaAa5YI4=; b=oKror4K3HD876y4/6iaJ2uZDX6mkBjUmWZO5HK7+IuHItgDobbv
	dObJfsCCBtv+Qguu8ALfs0uXTiu/X/2JHMZcvhKh8UiGEW1DTTcB7KGEzuWAcbap
	ktZTGV9JRN9oS0FsGWOb+snlPZUDpAVntJHYtD33iuDKCsCZPRH+JM64PDz/w62S
	j8iPGtoc9ABrEuy3raN3/dlOpAVAZ4ROaGOFP1TtcXkbzINhXx4CS44yp7MS5OvO
	RDch7H5fl3dv8Vg7af4OuuzMsicwQt2aGNJ1/p/VyUuQcBDUbYxH7+/OVkTPWNE3
	LE5bKdOxgTcOW6IDTpdHGxK6EBAVTqUkVjQ==
X-ME-Sender: <xms:YKhGaoNNdppjSLHcjHETwOkSP0YM_hciefvpDL80d7OhbMSsqFLvvA>
    <xme:YKhGauCtL6uH2N4cne4HQiu_TrjK7_U0MKUqBKi99ZK7-vh_-SbBWD8SpYotcvjY0
    Hx3UEgxgjjW2T6jtcISkrNV2JbaocxTVgy65d4DXmOdGc_20tNN-ng>
X-ME-Received: <xmr:YKhGalcGkdcMsOoC0TpgziiTCR7Xe0aVXZo7dSA8xBCyPKCfFekFvIs2ewM>
X-ME-Proxy-Cause: dmFkZTE56gm/OCh4BAfqn5/e91qV1mIatQrhMrwmRutGnFI9cE+etz40wLwftfzG6YFwQV
    QXtcgqpEG2UDB1bDzbXDSPvNYfn081NQ69Acn5fiPIHhfy2Ygr1CAhi3BM2fqjU0rfv906
    dpbJesBnwSw0OsCjSu3rfME7QnqnAQfySO+nYe52WEgmXEUJXEvwI/9CBYxeJbDGA4+blB
    RGrZ5Tuk8sSKVtGZnMNCafsN2gUjUiORcNU/FylVLK0P3x04nLVjLKqZV8sKKcaNr0IKbH
    kkcEWeknXOrlNJU5D71MeONuPwyv8cpp/m719I5SubbS+K4C+jZHPvz9TbdF+Cupx9qgR3
    hS3+YCuq/vaNeRhew2+egnd1ZNwi1iih3heX1E10mb5pw0QG7CIh1CGw8J0gl/d/nzZelj
    4hQlFsbECwgzFLmlFVKOaZ3A9wivUp7cx3MNniBH7y3OKDOqaP+Pu3OYlYs4/pXpJilybz
    Iej8PwMvpgf7F6D8d1N7VYC/WlBDfwEpFsaciTb+HXyTaqHflsVE9pX9cXffyTQpFlPwER
    pB3/AAxqvR7y1jEoMqoSjo5UFTKHTeYa+WuE1DwYO0hEbtSvr9YmUkkz9AS16RlS2z95Lw
    eexDB68zGs6eyuEtdyJp0A0SYSFeCy+27pGizUzyoYSJ0ZuOqZGl/KNL22xg
X-ME-Proxy: <xmx:YKhGatP6jtPn2e3lhxOwH62cTwyLNl8y8wfjETPCWCbc-eB39egWvg>
    <xmx:YKhGalLs_OXHwRWpRhwovIakA5lhjG73Fa8WE_ZtWebET21iUAJkPw>
    <xmx:YKhGatJIUgGeKSTTfDl_vzuxc13y0aT6VPHKylnHVMoWQoqqaax4YA>
    <xmx:YKhGav790D39VzHbtO-h-XFmdn4u4IWO5SUi4Ya3V8o2Da6hZVLgZA>
    <xmx:YKhGagdGUqP7l_fXwZdz6GGVMtjSJOXjZiikxzqtKu1Fs-S14DpUuW2Q>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 14:05:19 -0400 (EDT)
Date: Thu, 2 Jul 2026 20:05:17 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net/tls: Consume empty data records in
 tls_sw_read_sock()
Message-ID: <akaoXcfamBp8_mYe@krikkit>
References: <20260630191551.875664-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630191551.875664-1-cel@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304249-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA3946FC30B

2026-06-30, 15:15:51 -0400, Chuck Lever wrote:
> A peer may send a zero-length TLS application_data record; TLS 1.3
> explicitly permits these as a traffic-analysis countermeasure (RFC
> 8446, Section 5.1). After decryption such a record has full_len ==
> 0. tls_sw_read_sock() hands it to the read_actor, which has no
> payload to consume and returns zero. The loop treats a zero return
> as backpressure (used <= 0), requeues the skb at the head of
> rx_list, and stops. rx_list is serviced head-first on the next
> call, so the empty record is dequeued, fails the same way, and is
> requeued again; every later record on the connection is blocked
> behind it.
> 
> tls_sw_recvmsg() does not stall on this: a zero-length data record
> copies nothing and falls through to consume_skb(). Mirror that in
> the read_sock() path by recognizing an empty data record before
> the actor runs, consuming it, and continuing.
> 
> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
> Signed-off-by: Chuck Lever <cel@kernel.org>
> ---
>  net/tls/tls_sw.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

I think tls_sw_splice_read() suffers from a similar issue (returning 0
even though more data may be available). Sashiko agrees, and also
found a few more pre-existing issues.

-- 
Sabrina

