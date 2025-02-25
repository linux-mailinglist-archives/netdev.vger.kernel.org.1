Return-Path: <netdev+bounces-169389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602DCA43AA1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D236D3B1F9A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E68267AF5;
	Tue, 25 Feb 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyFhLe+H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504D265601
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477549; cv=none; b=WPLUGexr1kLWvwdhG34EYnwUaod20pnAyOGXHmGTu/VwlBaZZU00W6musJTRt1XAJq22juUNUMpV6UnnBHxEQYGqLIiYYd6EMKQSdJtDjiVRwie3fMdcQrMF46SS/kwjNaitc7znNIYCO5+BVlpPvWhcqB6IVWNmiJ2sm4wjEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477549; c=relaxed/simple;
	bh=p4CmMFvGz4GnZuL7UKpm5LFmwyrMDK7TdvYwpQCZxls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVA/nYhR6yopeUZq2GjJX3vDdiNmB0NVJcIIj//0QLFodWYI+9pJTtb6MyJu6pXsCcQj10lSZM3aRU1haHY6hxsxtv/CulA93viLkdWs3R2izVofsxdClv7KGHn8IrMGJ/UT1eP57iBbytirgJkSmZGUx8z/ozaxo65S5+pnx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyFhLe+H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740477546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSN8ipOdoK6nr7GKwtPTgRwDHFeV4MnRHm175qJcIAE=;
	b=NyFhLe+Hp5wjltee3rsppWoHo75FZ7EhZzptAwEeqnkwUffpLez/3F5QWQgKWbR3rFHol/
	4ojVg341GrRy9uudd2yUD/b7FSSYU4j9lqeXuKS1VnyhLqG0gr/tiOFMYwFSB4uwfjVOlJ
	UHCEgRRMSg8hIqvUAWUCdZOccwXFWqg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-xoc1X3PIOAK-6m8W0pA9Qw-1; Tue, 25 Feb 2025 04:59:04 -0500
X-MC-Unique: xoc1X3PIOAK-6m8W0pA9Qw-1
X-Mimecast-MFC-AGG-ID: xoc1X3PIOAK-6m8W0pA9Qw_1740477543
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4393e89e910so29874895e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 01:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477543; x=1741082343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSN8ipOdoK6nr7GKwtPTgRwDHFeV4MnRHm175qJcIAE=;
        b=jHu6KKpF2QEsDIFfqnHycTfV8ogZW6A9tGBwgciUQqKclFBGuSceekVsPqrUzRrmwQ
         DSLA/pM0RItQCNZqejr6pHLH2YU+PGf9BAT/jQWgBpskMDPNwjdH5t2V1VLd2g7eSTZZ
         YFiYBR1YzJlliRyFWVDjiQkFCWM/xW30TaVP0SKKrzXqAFyE8HWQetUoPFx3PbXYvGwS
         TnhW4ZWAP+dMmERLw99Sd4rGeKQj8WJ4DOHlR9eigSsDhEoVMY1D8NwRQIUDZZmluZ+7
         puCAs6nyBhxGSR+jbMctJ7+oPxpSxeNPmTDlrVmXafoxl8Pm+Re3LZxw9u8F3wTsjnMx
         mQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXib+J/HNrleUpOCry+0LEtaKTXauyehxZsCehq6ph1NMG3sp6w9gYzAzHhtmEo8pwm+JYc0JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywtUc7yldNYCB9fcgU9HifFVyoTKZEirJGuDVFxrrdJ/Z3ihEF
	5sdKdsg1vuHOkHoOaZFgkmalYHrPyaUc+KOHl6DyehI5kB8Qj66fHhIoAoS7rN78qPDfNt3x8Fd
	r8gks07On7OJBbdkyQ6yl8V6xWkJtV8llEun6ckdy/3ckGXHK4UM/mA==
X-Gm-Gg: ASbGncuywvkhOC3GUW6MeFYVTHVWG0A+UJbva39sBIbf9dKBNvuqaSciP53toHXwszK
	l1F7euAGIyx8CgNxqsvE1H1iXjrTXYSHIHl2wAMu1FqxiYiewy9gmWAhlQO/s3yeXt1XnLEQgHh
	oT397infP8s8szw8iDLc/L5NNabR74UHK3BG1XI7nxEJDg0N9xX7QLF6L8UQZod75uoKZqn7zch
	bwgNvkszN1pw+Nfkz7QoXpLdvTjfhu1gtnD24/9+5X+lZONB0NHv07XhJgMalb+qZZtI8ppHaGP
	Uxj6MoDLYoefG6r0i+v0tJhIY8JgubXa2JnG+t21y+U=
X-Received: by 2002:a05:6000:1447:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-390cc5f20e0mr2112736f8f.3.1740477542898;
        Tue, 25 Feb 2025 01:59:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH60QjK9vH760gSUBPSCwYP4IhpIh63CiCbHL+6qOm3E8hNdxGsRrsrYn2d6kVVeMOzjquFg==
X-Received: by 2002:a05:6000:1447:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-390cc5f20e0mr2112696f8f.3.1740477542496;
        Tue, 25 Feb 2025 01:59:02 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd883934sm1747035f8f.59.2025.02.25.01.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 01:59:02 -0800 (PST)
Message-ID: <4f37d18c-6152-42cf-9d25-98abb5cd9584@redhat.com>
Date: Tue, 25 Feb 2025 10:59:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: be less liberal in tsecr received while in
 SYN_RECV state
To: Eric Dumazet <edumazet@google.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Jakub Kicinski <kuba@kernel.org>,
 Yong-Hao Zou <yonghaoz1994@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Neal Cardwell <ncardwell@google.com>
References: <20250224110654.707639-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224110654.707639-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 12:06 PM, Eric Dumazet wrote:
> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
> for flows using TCP TS option (RFC 7323)
> 
> As hinted by an old comment in tcp_check_req(),
> we can check the TSecr value in the incoming packet corresponds
> to one of the SYNACK TSval values we have sent.
> 
> In this patch, I record the oldest and most recent values
> that SYNACK packets have used.
> 
> Send a challenge ACK if we receive a TSecr outside
> of this range, and increase a new SNMP counter.
> 
> nstat -az | grep TcpExtTSECR_Rejected
> TcpExtTSECR_Rejected            0                  0.0
> 
> Reported-by: Yong-Hao Zou <yonghaoz1994@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  .../networking/net_cachelines/snmp.rst        |  1 +
>  include/linux/tcp.h                           |  2 ++
>  include/uapi/linux/snmp.h                     |  1 +
>  net/ipv4/proc.c                               |  1 +
>  net/ipv4/tcp_minisocks.c                      | 25 +++++++++++--------
>  net/ipv4/tcp_output.c                         |  3 +++
>  6 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentation/networking/net_cachelines/snmp.rst
> index 90ca2d92547d44fa5b4d28cb9d00820662c3f0fd..bc96efc92cf5b888c1e441412c78f3974be1f587 100644
> --- a/Documentation/networking/net_cachelines/snmp.rst
> +++ b/Documentation/networking/net_cachelines/snmp.rst
> @@ -36,6 +36,7 @@ unsigned_long  LINUX_MIB_TIMEWAITRECYCLED
>  unsigned_long  LINUX_MIB_TIMEWAITKILLED
>  unsigned_long  LINUX_MIB_PAWSACTIVEREJECTED
>  unsigned_long  LINUX_MIB_PAWSESTABREJECTED
> +unsigned_long  LINUX_MIB_TSECR_REJECTED
>  unsigned_long  LINUX_MIB_DELAYEDACKLOST
>  unsigned_long  LINUX_MIB_LISTENOVERFLOWS
>  unsigned_long  LINUX_MIB_LISTENDROPS
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index f88daaa76d836654b2a2e217d0d744d3713d368e..159b2c59eb6271030dc2c8d58b43229ebef10ea5 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -160,6 +160,8 @@ struct tcp_request_sock {
>  	u32				rcv_isn;
>  	u32				snt_isn;
>  	u32				ts_off;
> +	u32				snt_tsval_first;
> +	u32				snt_tsval_last;
>  	u32				last_oow_ack_time; /* last SYNACK */
>  	u32				rcv_nxt; /* the ack # by SYNACK. For
>  						  * FastOpen it's the seq#
> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index 848c7784e684c03bdf743e42594317f3d889d83f..b85dd84dda5c13471e2f62c3a4ffb11b22f787f8 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h
> @@ -186,6 +186,7 @@ enum
>  	LINUX_MIB_TIMEWAITKILLED,		/* TimeWaitKilled */
>  	LINUX_MIB_PAWSACTIVEREJECTED,		/* PAWSActiveRejected */
>  	LINUX_MIB_PAWSESTABREJECTED,		/* PAWSEstabRejected */
> +	LINUX_MIB_TSECR_REJECTED,		/* TSECR_Rejected */
>  	LINUX_MIB_PAWS_OLD_ACK,			/* PAWSOldAck */
>  	LINUX_MIB_DELAYEDACKS,			/* DelayedACKs */
>  	LINUX_MIB_DELAYEDACKLOCKED,		/* DelayedACKLocked */
> diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> index affd21a0f57281947f88c6563be3d99aae613baf..2f0d2cf7cae45d824f8c506df3f83c175e794a0a 100644
> --- a/net/ipv4/proc.c
> +++ b/net/ipv4/proc.c
> @@ -189,6 +189,7 @@ static const struct snmp_mib snmp4_net_list[] = {
>  	SNMP_MIB_ITEM("TWKilled", LINUX_MIB_TIMEWAITKILLED),
>  	SNMP_MIB_ITEM("PAWSActive", LINUX_MIB_PAWSACTIVEREJECTED),
>  	SNMP_MIB_ITEM("PAWSEstab", LINUX_MIB_PAWSESTABREJECTED),
> +	SNMP_MIB_ITEM("TSECR_Rejected", LINUX_MIB_TSECR_REJECTED),
>  	SNMP_MIB_ITEM("PAWSOldAck", LINUX_MIB_PAWS_OLD_ACK),
>  	SNMP_MIB_ITEM("DelayedACKs", LINUX_MIB_DELAYEDACKS),
>  	SNMP_MIB_ITEM("DelayedACKLocked", LINUX_MIB_DELAYEDACKLOCKED),
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 1eccc518b957eb9b81cab8b288cb6a5bca931e5a..a87ab5c693b524aa6a324afe5bf5ff0498e528cc 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -663,6 +663,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>  	struct sock *child;
>  	const struct tcphdr *th = tcp_hdr(skb);
>  	__be32 flg = tcp_flag_word(th) & (TCP_FLAG_RST|TCP_FLAG_SYN|TCP_FLAG_ACK);
> +	bool tsecr_reject = false;
>  	bool paws_reject = false;
>  	bool own_req;
>  
> @@ -672,8 +673,12 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>  
>  		if (tmp_opt.saw_tstamp) {
>  			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
> -			if (tmp_opt.rcv_tsecr)
> +			if (tmp_opt.rcv_tsecr) {
> +				tsecr_reject = !between(tmp_opt.rcv_tsecr,
> +							tcp_rsk(req)->snt_tsval_first,
> +							READ_ONCE(tcp_rsk(req)->snt_tsval_last));
>  				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
> +			}
>  			/* We do not store true stamp, but it is not required,
>  			 * it can be estimated (approximately)
>  			 * from another data.
> @@ -788,18 +793,14 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>  	     tcp_rsk(req)->snt_isn + 1))
>  		return sk;
>  
> -	/* Also, it would be not so bad idea to check rcv_tsecr, which
> -	 * is essentially ACK extension and too early or too late values
> -	 * should cause reset in unsynchronized states.
> -	 */
> -
>  	/* RFC793: "first check sequence number". */
>  
> -	if (paws_reject || !tcp_in_window(TCP_SKB_CB(skb)->seq,
> -					  TCP_SKB_CB(skb)->end_seq,
> -					  tcp_rsk(req)->rcv_nxt,
> -					  tcp_rsk(req)->rcv_nxt +
> -					  tcp_synack_window(req))) {
> +	if (paws_reject || tsecr_reject ||
> +	    !tcp_in_window(TCP_SKB_CB(skb)->seq,
> +			   TCP_SKB_CB(skb)->end_seq,
> +			   tcp_rsk(req)->rcv_nxt,
> +			   tcp_rsk(req)->rcv_nxt +
> +			   tcp_synack_window(req))) {
>  		/* Out of window: send ACK and drop. */
>  		if (!(flg & TCP_FLAG_RST) &&
>  		    !tcp_oow_rate_limited(sock_net(sk), skb,
> @@ -808,6 +809,8 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>  			req->rsk_ops->send_ack(sk, skb, req);
>  		if (paws_reject)
>  			NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
> +		else if (tsecr_reject)
> +			NET_INC_STATS(sock_net(sk), LINUX_MIB_TSECR_REJECTED);
>  		return NULL;
>  	}
>  
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 9a3cf51eab787859ec82432ee6eb9f94e709b292..485ca131091e58616b4f3076acc2ad7a478de89d 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -943,6 +943,9 @@ static unsigned int tcp_synack_options(const struct sock *sk,
>  		opts->options |= OPTION_TS;
>  		opts->tsval = tcp_skb_timestamp_ts(tcp_rsk(req)->req_usec_ts, skb) +
>  			      tcp_rsk(req)->ts_off;
> +		if (!req->num_timeout)
> +			tcp_rsk(req)->snt_tsval_first = opts->tsval;
> +		WRITE_ONCE(tcp_rsk(req)->snt_tsval_last, opts->tsval);
>  		opts->tsecr = READ_ONCE(req->ts_recent);
>  		remaining -= TCPOLEN_TSTAMP_ALIGNED;
>  	}

It looks like this change causes mptcp self-test failures:

https://netdev-3.bots.linux.dev/vmksft-mptcp/results/6642/1-mptcp-join-sh/stdout

ipv6 subflows creation fails due to the added check:

# TcpExtTSECR_Rejected            3                  0.0

(for unknown reasons the ipv4 variant of the test is successful)

I haven't digged into the code yet. I'll hope to have a better look
later, but it will not be too soon.

Cheers,

Paolo


