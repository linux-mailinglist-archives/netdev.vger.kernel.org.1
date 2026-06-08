Return-Path: <netdev+bounces-296745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Av+VIFg+J2qntwIAu9opvQ
	(envelope-from <netdev+bounces-296745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:12:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ADC65AE8C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:12:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="aAc/I2rl";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296745-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296745-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 353E3300C92A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7793B0ADF;
	Mon,  8 Jun 2026 22:12:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424AD3B0ADB
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:12:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956749; cv=none; b=KaGUIXP6bhJBAffOsxdsEgGTQ/yokiRBdxouFR3LLF9I0YlY/QxOT1PbkDHeHg8mvCe0pGH2Cyx8mntSsIruJpdDQySss+SrCFJLaxmnROCtRDexfU9hh4SaxQpzgBYPVLcHleOYjlqAjxm0925DSuNTPBBCikZYu/2IqQ74m0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956749; c=relaxed/simple;
	bh=1mW4UPRZnlwwXcOBTh1xw9GgO1hKSdsmrO2g0JXCE1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qv3onulrlhtoVTW1YKtsDSevT+dwlJRXoF2n+KeU+fWv4oyoI6cyPBXzLGHsHU72R18svBck97kHrGEq4XIHto9621nZNcX5n4r31MSmYltJU2/V+trWJ6212zPdMsqj3uIU5oiiMiRpiGiZDQqXygkc1p+Jxy2xe0d4L6wBF2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAc/I2rl; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490afc47455so24861215e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780956747; x=1781561547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XT0sc3tiUNM3ws0Cy/hiiq3H/Zd9w72qwy4YmSm9Xlo=;
        b=aAc/I2rl1Q9qV/IzGNfSTvkooFrBGPPwL4AKmXMydb/+ckwoByz7o++qBcA4eEpFq9
         ZpYe+d3Yr1Tcnu1zWXHyZzseLQwkrNZeKlXQZPpicE/u+N7gJBCHTsD/4LbcnP82g22S
         9sGsA4o1JLR63/ARvAz2HVq7s3XB9HS8J9OnYvapHUC2aak7acsAj9w4J++i/D4JP58m
         cmJlRwnyhywRjGHyfQ+3UecLlLqyiF44jVi7Gx87AkFUZO44nL7Fl/RZCH1dKcvbwaYJ
         r4rJdw8uW911MlyZrXIdWrBHnaAwTNRZMhI/P4ImKu18sxcYtcATuXoq9HcObosLCMH5
         ritA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956747; x=1781561547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XT0sc3tiUNM3ws0Cy/hiiq3H/Zd9w72qwy4YmSm9Xlo=;
        b=U+Ny1hDhSndhSgYB0ehgqVmUfESEiHyYefgBhlhfKeGEra+c2/6RyMZU1GilJuSmHY
         qKP8mXZP3FVNTPulxJZtIasQINQx+Q2tRqs2Cm28UJMcf5ClxRKIqHD+kLZm8miT3Sbm
         hrQDOr+6d8L2NY3TJGyRljx/R58ar7EGeX9RM388QE9F1krqCu+n/o/tVVJiv0MAB+vt
         zC+eR0Jz6+VlHBQ2FKX4PwC0ANLAAKeeM28SFjENyf/nVj1jIWtyeqkCASQSKtfumUZe
         92K7dB1gOm9DmZ6aTGWNpQYHdzvI/PbTwyuNJk3VIvkeJ+UC2bjj8DjynjNIapM891vv
         EhaA==
X-Forwarded-Encrypted: i=1; AFNElJ9Q7sy1D+r0GcaIn4uJ/fRcpnE/0/BKWAWKBA1IeArZWj/t2ajBXEfa3R8C3l1PmTd/LY8kOLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tWHa4KXrLlXLCDDEyQAxuAuZXxdUocrRzc+oEIRrlQQhk1dv
	hNc97npihJ6EXjN66fdEGN+ARxyf54zm3vNBXQq9mNMZXKC8tNx3CiaX
X-Gm-Gg: Acq92OGfPaqmMsNVtaJGrTOI2MFd4WyILpvQ3mnFr11ovgYNGVET+DQfyQgPTtz1i3p
	GnBgy1RfXWA3ZhyKqp1TnD9vjQwKhSwBkC6FbsTi4pU3kRNityntgRwtjq0gWWAgCyzxRit8tbs
	JTY3IsluhJ1aqS8kMUg0baNq39Ng8osKLYqoabxKTc7zaXCAmjfBUn/LNn/V2T68eQqL/QVP5Gt
	ToZSWW0mAJ12vxDqDbDNdx4FgZDNNmzJfXNRK8kdEqjtqUTeYmHpit/Y9bZRWmm92M0LfV+Apfh
	77llkZGmTSL640luVh4Kj7627Vl+eYIn2kO2Q9fGJSX6BAOHyHSviTgy8H6ngArCXygz+m5KdiZ
	vpyCu71C817mUktUZB3vGGaGjVg5KXIkeAUOH9g5ywKvm2eEQ3Wn2hBzTeYT5srgz20mJgn3WX0
	O4vTqA34DzHJjBqOJMX1ZHkYlicvPxvP1ejsnHSnb2FP6yt+TntEU1fS/+rf13lAbcyjICUlaHg
	07Py0uSUSVyoJrgJWnBcCtDdfF7NVwsEBA=
X-Received: by 2002:a05:600c:4e47:b0:490:9bc2:bf8b with SMTP id 5b1f17b1804b1-490c25acd68mr288367305e9.5.1780956746379;
        Mon, 08 Jun 2026 15:12:26 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f38df00921b0efffe889e28.dip0.t-ipconnect.de. [2003:c1:4f38:df00:921b:eff:fe88:9e28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd663sm493223885e9.10.2026.06.08.15.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:12:25 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 2E6BB3195CF8; Tue, 09 Jun 2026 00:12:25 +0200 (CEST)
Date: Tue, 9 Jun 2026 00:12:25 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: refine tcp_sequence() for the FIN exception
Message-ID: <aic-SfHAIsYCswa7@gandalf.schnuecks.de>
References: <20260608151452.706822-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608151452.706822-1-edumazet@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-296745-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1ADC65AE8C

Hi Eric,

On Mon, Jun 08, 2026 at 03:14:52PM +0000, Eric Dumazet wrote:
> Commit 0e24d17bd966 ("tcp: implement RFC 7323 window retraction
> receiver requirements") removed the special FIN case that
> was added in commit 1e3bb184e941 ("tcp: re-enable acceptance of
> FIN packets when RWIN is 0").

Commit 0e24d17bd966 did not remove the special handling; it is still
present and covered by the test "tcp_rcv_zero_wnd_fin.pkt".
 
> If a peer sends a segment containing data and a FIN flag before
> it learns about our window retraction and has a buggy TCP stack,
> it might place the FIN one byte beyond what it thinks is the
> right edge of the window (i.e., max_window_edge + 1).

The FIN exception in tcp_data_queue() is not a generic allowance for
incorrect FIN handling.  It is much more specific and only applies
when:

1. the packet is in-sequence 
2. RWIN == 0
3. the packet is a bare FIN
 
> The data portion (end_seq - th->fin) will end exactly at max_window_edge.
> In this case, we will drop the packet if our receive queue is not empty,
> even though the data was sent within the window we previously allowed.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Simon Baatz <gmbnomis@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index ab7a4e5435a8a2cbb532d42c54af76d8541c903b..8560a9c6d38207c098d673497caf2c7652c36f5c 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4812,18 +4812,20 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
>  					 const struct tcphdr *th)
>  {
>  	const struct tcp_sock *tp = tcp_sk(sk);
> +	u32 seq_limit;
>  
>  	if (before(end_seq, tp->rcv_wup))
>  		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
>  
> -	if (unlikely(after(end_seq, tp->rcv_nxt + tcp_max_receive_window(tp)))) {
> +	seq_limit = tp->rcv_nxt + tcp_max_receive_window(tp);
> +	if (unlikely(after(end_seq, seq_limit))) {
>  		/* Some stacks are known to handle FIN incorrectly; allow the
>  		 * FIN to extend beyond the window and check it in detail later.
>  		 */
> -		if (!after(end_seq - th->fin, tp->rcv_nxt + tcp_receive_window(tp)))
> +		if (!after(end_seq - th->fin, seq_limit))
>  			return SKB_NOT_DROPPED_YET;

It is not clear which additional case this change is intended to
allow.  Are you sure such a packet would not be rejected by later
checks in the data path?

(For the existing FIN exception, the previous condition also seems
broader than necessary. Actually, it should be sufficient to use
"!after(end_seq - th->fin, tp->rcv_nxt)")

>  
> -		if (after(seq, tp->rcv_nxt + tcp_max_receive_window(tp)))
> +		if (after(seq, seq_limit))
>  			return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
>  
>  		/* Only accept this packet if receive queue is empty. */
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
> 
-- 
Simon Baatz <gmbnomis@gmail.com>

