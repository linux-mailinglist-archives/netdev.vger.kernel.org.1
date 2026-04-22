Return-Path: <netdev+bounces-280430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJyJGqbT6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:56:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB9446FD0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B78073017798
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960DB29E0F8;
	Wed, 22 Apr 2026 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLVo6AxV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mA9cdvbr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40089221F20
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776865933; cv=none; b=J+ItqHRRA6AC5TM8fRq6GzlhWMWvUKQ2raKCOZo1DnCjwbsOGHQXse01Mdw4jwfFubmym4QVDGhyfpyfnTlBQO7U576YMSrZuBx7CgPtJ4Yypw+IoyeeMRHMCHW/yIqCa/2WFWqUAskpZA5rGjUe6NkDEsd7XTq6v6aKRfYdjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776865933; c=relaxed/simple;
	bh=FinX88tVtqohGgVWhbO3j5h4eWT/4q18+66GEVCg1kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3NZw2sgtOglUFyZTJZw1/yhApxrBnuc0luCq3d/PtvonoQP6Z8MxDBoXfINTp2NfrkKru9WyiT2czRtnaIOWAaQkmbMFOC4wBYGNrWJcDZyAMXC/Qv8bBPkWIxKcFT63vzaPerNOvHIVreCSPJALob8cLf2L+J+Ov7PgpLCjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLVo6AxV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mA9cdvbr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776865931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFJ3Oe6hSxhMeBbeLsUE7Rx9fPyR4qwpGR0YXzFQvsk=;
	b=JLVo6AxV9X9w0ZahMePtIw203VEXMc/at9L2wFfoLLwW3nMC6XzDZQmbGL2V3iO60+yfm5
	2HJu5TySl/81fslXUdpuH0TiuNnAZ3cPdELgbw05S2ghvZ958innN36zQvadMPpjbmdBEa
	yqQdhXMcpMnxFVnYSPaL9MH4sKkIcS4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-68puuIXKPN62FB0g0bxzmQ-1; Wed, 22 Apr 2026 09:52:08 -0400
X-MC-Unique: 68puuIXKPN62FB0g0bxzmQ-1
X-Mimecast-MFC-AGG-ID: 68puuIXKPN62FB0g0bxzmQ_1776865928
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dce437f1a1so2477550a34.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776865928; x=1777470728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFJ3Oe6hSxhMeBbeLsUE7Rx9fPyR4qwpGR0YXzFQvsk=;
        b=mA9cdvbrTKZCZu5SwP1CrY30g+0oGTs9KBe3ZVVtIyB4pqCx07pAVyz8+N65DBMDI+
         dAtyx+uRBvek4EYOouJEUMgp3KHT2XFjYnyHvy9KbLBLEoUA8jCd8kICn1qgAnaoNYde
         KruDOSNYUj44uZGtGnskNc0GFWHPEVnIiEhtEOEpW+0lgA4JEhm/8ELWGabPjjYQG6tH
         GmtRXKBeNlh8KgOcgvwVDGzoyVVAEielaNFCUXCftM7OmBbsdqEr8DfwWG+BetFjiI9l
         eBkT33rwzoJ06e8V0dEbOJI8zKSbqZs+IVP6vzgN0aGiAnD4hr9mjzvSOD+o2vGAkxLV
         FUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776865928; x=1777470728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFJ3Oe6hSxhMeBbeLsUE7Rx9fPyR4qwpGR0YXzFQvsk=;
        b=s+nBkdD2p9WlEVaAg50MvrEbtzGpSHyfPUKnT992jYAClLQbRxywFy4Q34aEMPlV1p
         aazjF3jtVy7hJL2M7m38/o8AzA+t7ff4EuW7IbmJzHRbadHOuNGHopMuF3omtvs0CgPr
         4ednM/No5ecWBl2B7n3Qu6S3lmfHxgY6T8vx4+BuZFi7Gy2z6L1Pliv+6b1buk7H6zkr
         kfoU0LZ1p4rEs9l8dviguukj5sz55EJI2I4UbNBgeFVV+ln6jgwGhdHOn3ajCZ4QpzMx
         rTcy3nELa1dqQVUiga3fcbOGgQtkaPtRU0Y9pYxpozuk3jTEsrT0lfQd+bxN0XSqbUEF
         2pmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XRGE8Kx4wizN1XkA/SH4Fp9YgTYSlyKuvLdxNAW12+J95z4KSDl2F1k0ayI9C/rcGjHkGS74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzlnhSQ1qbdee/BLql/cvgEOtdddzCNXFuOUe5E/M3NpdMaGQb
	ohqKscQxReSdHB2Yc2nRlHYE5mkc8xOWIMIIVnPmdn0SR52doGjEh2eioNde7ars5brqZ7XfEFk
	SzMmKH7bQ6GQqe5YOS4VjltgsO6TEoXSNV9SYfUa3q/+Df/fcFUHV11EXOw==
X-Gm-Gg: AeBDievEYCwdDw84CmvnXya46TVmc0kbRSAZzMf+AAMHpBumSXwYe7sKvKeuaoOD7lJ
	xXSr4IFuijl0JmBRMFjXowF4DZh4R72wNCjN6bS38N7d0iqcBiM6/2JHr6196laukx3ghP6+n7i
	13zyVpcApF4L89iPG72vRaucV7y1WGghKFtwZwmvt9j8To4KYHhruKabJjA+hBhH8riK99jimhZ
	E1Vt8ysZ9352YnhNBR5jA4W0w7NRIizlypUGc9gLAaVGTwo5PWq8n6Sh9TtD+YhR9KOw3o5dFFC
	XjOcu/HIK3ieJ71fU7qrJbx0Vb0l+wQK7D2LP3ZDODreBl4wqm1785i1/2u3WXyRA9VtXgG/jdc
	PFD24mcctz3/oLe37kja5Ao+DGE3MmoUo/68mID+NquvDbszIqhHkseGuodMTBx+pmLE=
X-Received: by 2002:a05:6830:911:b0:7d7:e57a:bcd with SMTP id 46e09a7af769-7dc9521a821mr14384600a34.20.1776865928143;
        Wed, 22 Apr 2026 06:52:08 -0700 (PDT)
X-Received: by 2002:a05:6830:911:b0:7d7:e57a:bcd with SMTP id 46e09a7af769-7dc9521a821mr14384583a34.20.1776865927721;
        Wed, 22 Apr 2026 06:52:07 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd5408b5asm4919147a34.11.2026.04.22.06.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:52:07 -0700 (PDT)
Message-ID: <fc2ca10a-1fa8-48f8-b140-6c59595fc08b@redhat.com>
Date: Wed, 22 Apr 2026 15:51:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: do not drop partial packets
To: Shardul Bankar <shardulsb08@gmail.com>, matttbe@kernel.org,
 martineau@kernel.org
Cc: geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20260422120954.8877-1-shardul.b@mpiricsoftware.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260422120954.8877-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280430-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57BB9446FD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/26 2:09 PM, Shardul Bankar wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 614c3f583ca0..6858e6e283e3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -397,12 +397,27 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  		return false;
>  	}
>  
> -	/* old data, keep it simple and drop the whole pkt, sender
> -	 * will retransmit as needed, if needed.
> +	/* Completely old data? */
> +	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
> +		mptcp_drop(sk, skb);
> +		return false;
> +	}
> +
> +	/* Partial packet: map_seq < ack_seq < end_seq.
> +	 * Skip the already-acked bytes and enqueue the new data.
>  	 */
> -	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
> -	mptcp_drop(sk, skb);
> -	return false;
> +	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> +	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;

here MPTCP_SKB_CB(skb)->offset is always != 0 ...

> +	msk->bytes_received += copy_len;
> +	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
> +	tail = skb_peek_tail(&sk->sk_receive_queue);
> +	if (tail && mptcp_try_coalesce(sk, tail, skb))

... so mptcp_try_coalesce() will always fail.

/P


