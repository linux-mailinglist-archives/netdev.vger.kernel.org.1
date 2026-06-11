Return-Path: <netdev+bounces-297985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G17pBdpoKmqdowMAu9opvQ
	(envelope-from <netdev+bounces-297985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:50:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6F66F8F9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:50:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ATnA5osS;
	dkim=pass header.d=redhat.com header.s=google header.b=RhRHbjrJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297985-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297985-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA91D338CBF6
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7BF368284;
	Thu, 11 Jun 2026 07:39:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833513B893C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:39:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163569; cv=none; b=BBgojMP5tH1mbpKl3Pjk/JTNRznFmS+xeTd7/acuZRvSV/atLQH+5Nf1Qvm0nH/iyFombJwr2Cf8KUg8bztPjzehbHUFQh3w8Ivq9X7DQNkZCvAud8XlOM7Hzwn3KYbq/MyG2wCN79fYWxOV1cLSETIw+9SfV4MYXTpJG4XsAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163569; c=relaxed/simple;
	bh=pb4F24C0YjvzzjTcDDVE55NrogH22vK/ATzS7VJJXv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/4GtXifUs6AQc6unvIkOTB+7lidYqNTWT/THCFnylw6EZo9sJvv5DoyHDZIGRukQ2p9d0U1Z7TLB2bL1ocB0i/Voyv3s3UvirMkTQDw2s6AUfi0bkA79jm8Y8UnGuzZaPCAYMyPyBTmHFyMz1UFC1gZ890KrZGnmnVLsnh9af0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATnA5osS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhRHbjrJ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781163566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5sG39NXxnvUU37y/twU50S+o8Hi79gl9qFWHRrRzL0=;
	b=ATnA5osSADIETmGwKbLBT4pc1kYh67I3lCMLU0eFAEJShq1tYZiS334GPEIHTqJ22uYw63
	zvxXgNAfnOZ30M9Wp/NE/E+s3Uc48w9PGiKPYnAlAHRgkvE0G3kpQ8wklXCsjNYXD+Sn0K
	HXlflo2if1xFUItt0sRFSPwyB22aHqM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-P4EgjTRoOBu2by6vIo25rw-1; Thu, 11 Jun 2026 03:39:25 -0400
X-MC-Unique: P4EgjTRoOBu2by6vIo25rw-1
X-Mimecast-MFC-AGG-ID: P4EgjTRoOBu2by6vIo25rw_1781163564
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45efa2f7009so5002644f8f.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781163564; x=1781768364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5sG39NXxnvUU37y/twU50S+o8Hi79gl9qFWHRrRzL0=;
        b=RhRHbjrJEGUW/+gjQd98T/ITx+R5G9/XzsZenGpR1KG/RCoBKEElpkLGctOIKKg43m
         cwM2Ovp96tD+2be5KTBHJlrhkrSdjektcpoJSaxfDH6pBXBmz7jpChknI+le8MFrZh+s
         Kr5e69FkGn9+0BP/ZDiSV8Azx15PJkAkOIxk8HU6IWAtcz4J7mrmQQaZUWTsJDWga7Kj
         p0Tz9zD2lPFnX9KWVBnhShxDKFkElV3TPtrNFKKvUav7QhTmTxh0WvPezI9BcGD/i8Rv
         jmWRKeUW53PFgDLi+kH3xicJCdghl+vMtkwSgcAnMnuWlGpF6X/SkGof7ltJ09gomGiG
         qN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781163564; x=1781768364;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5sG39NXxnvUU37y/twU50S+o8Hi79gl9qFWHRrRzL0=;
        b=HA4xlO3mpfJUYHKjvEBodSvikeEmWeAvEK//GrUmyBOjc/4WbarTwhMvVH7dxagfIV
         Q1Kl0UlgvusCnJX+h81nmb0XjmaZvAP49A2hCGwIpVc//aj0ciDLbM6fUrGowCiIOr7r
         1nuIRD+b3SDAeTa4ufmhSGrXUKUeHVLx11ziGzuFB8incUVIRcUyvQED18V8I24kzGlE
         Dl3E5/UQ5A2N18uhTsKsinSi6n1omLf8WlAtUKgLz2aoR1z4Yksd9ymyNw/1UN/NvHxl
         YWLgxiZKqRUHRaXYUoy/XIKI3VwCSJ6mm+6ebgMycuNtCg3M3WAqeS/NyD2lsDgksyuq
         VSFw==
X-Gm-Message-State: AOJu0Yxc20he3r4nWry9rMWor4gvMWoHBKZ9d14RfC89sUitdU4b4x9Z
	h2Fs8nkgqKAGXbiEAA5x/m7uQOg0GMoeCbjsq29t++iOTeeI9khgpLwkINr6sJMys+UCosRQNiJ
	DPRpkTnb4KVRvAdmP2/esfqBiBzzgWmSjH+zO7ldCO4Sw69FvY/wP3qNBCg==
X-Gm-Gg: Acq92OGY35O9Jr60r/A/kAa8cFc5sXUYqftpmV7n9KFGOZapDFSdyYa8F1h0sqNsJnI
	EAYSg6YgFzRLmJbW2AWK4s7F56TSjS1ux6nz5PMmSUUTFBWfIKfhD0goHYFafqs2Bs3h+UVRB/k
	EBno/829cWqkuLjMiu/r9ur/F+t1QEhRrdDayGS0Xw4ADzGieoUAk2UtzD5kNRqNS/z8Zb6kwul
	AEzZCbih4Iy1Gue7siHMvcYs4Yq/QysA0ANJQ78TS1CaHLJpIBgjKtFVBA3mR+eB8dntxLHT3Av
	3xU4dRo/nNx0UNhSVSn0k2ZXXxqOP7TASJKmwtikJHoE0cTQAbdh4R5LmMPfBcx0bXtdu1JNwjJ
	dRZ5x7793hwg9Jt4KJ7E+U+ytNSL6A/PuUAWPussMLWMX0TVPDVCdWZd8UjdYBqB+Wg==
X-Received: by 2002:a05:6000:2911:b0:460:65bc:780f with SMTP id ffacd0b85a97d-4606758363fmr2377388f8f.13.1781163563988;
        Thu, 11 Jun 2026 00:39:23 -0700 (PDT)
X-Received: by 2002:a05:6000:2911:b0:460:65bc:780f with SMTP id ffacd0b85a97d-4606758363fmr2377333f8f.13.1781163563505;
        Thu, 11 Jun 2026 00:39:23 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dcbdsm66058292f8f.7.2026.06.11.00.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 00:39:22 -0700 (PDT)
Message-ID: <fb96d949-dcf5-494d-8076-eb4a972fa5e4@redhat.com>
Date: Thu, 11 Jun 2026 09:39:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/15] tcp: allow mptcp to drop TS for some
 packets
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FF6F66F8F9

Hi Eric,

On 6/5/26 11:21 AM, Matthieu Baerts (NGI0) wrote:
> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> this case, it is then not possible to send the address signal.
> 
> The idea is to let MPTCP dropping the TCP-timestamps option for some
> specific packets, to be able to send some specific pure ACK carrying >28
> bytes of MPTCP options, like with this specific ADD_ADDR. A new
> parameter is passed from tcp_established_options to the MPTCP side to
> indicate if the TCP TS option is used, and if it should be dropped. The
> next commit implements the part on MPTCP side, but split into two
> patches to help TCP maintainers to identify the modifications on TCP
> side. This feature will be controlled by a new add_addr_v6_port_drop_ts
> MPTCP sysctl knob.
> 
> It is important to keep in mind that dropping the TCP timestamps option
> for one packet of the connection could eventually disrupt some
> middleboxes: even if it should be unlikely, they could drop the packet
> or even block the connection. That's why this new feature will be
> controlled by a sysctl knob.
> 
> Note that it would be technically possible to squeeze both options into
> the header if the ADD_ADDR is first written, and then the TCP timestamps
> without the NOPs preceding it. But this means more modifications on TCP
> side, plus some middleboxes could still be disrupted by that.
> 
> In this implementation, an unused bit is used in mptcp_out_options
> structure to avoid passing an address to a local variable. Reading and
> setting it needs CONFIG_MPTCP, so the whole block now has this #if
> condition: mptcp_established_options() is then no longer used without
> CONFIG_MPTCP.
> 
> About alternatives, instead of passing a new boolean (has_ts), another
> option would be to pass the whole option structure (opts), but
> 'struct tcp_out_options' is currently defined in tcp_output.c, and it
> would need to be exported. Plus that means the removal of the TCP TS
> option would be done on the MPTCP side, and not here on the TCP side.
> It feels clearer to remove other TCP options from the TCP side, than
> hiding that from the MPTCP side.
> 
> Yet an other alternative would be to pass the size already taken by the
> other TCP options, and have a way to drop them all when needed. But this
> feels better to target only the timestamps option where dropping it
> should be safe, even if it is currently the only option that would be
> set before MPTCP, when MPTCP is used.
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> - v2: Avoid passing local variables' addresses to
>   mptcp_established_options not to force the compiler to use a stack
>   canary in this hot function, even for non-MPTCP flows. (Eric Dumazet)
> To: Neal Cardwell <ncardwell@google.com>
> To: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/mptcp.h   | 13 +++----------
>  net/ipv4/tcp_output.c | 10 +++++++++-
>  net/mptcp/options.c   |  2 +-
>  3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 24d1016a4664..71b9fc5a5796 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -72,7 +72,8 @@ struct mptcp_out_options {
>  	u8 reset_reason:4,
>  	   reset_transient:1,
>  	   csum_reqd:1,
> -	   allow_join_id0:1;
> +	   allow_join_id0:1,
> +	   drop_ts:1;
>  	union {
>  		struct {
>  			u64 sndr_key;
> @@ -153,7 +154,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
>  			  struct mptcp_out_options *opts);
>  int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> -			      unsigned int remaining,
> +			      unsigned int remaining, bool has_ts,
>  			      struct mptcp_out_options *opts);
>  bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>  
> @@ -269,14 +270,6 @@ static inline bool mptcp_synack_options(const struct request_sock *req,
>  	return false;
>  }
>  
> -static inline int mptcp_established_options(struct sock *sk,
> -					    struct sk_buff *skb,
> -					    unsigned int remaining,
> -					    struct mptcp_out_options *opts)
> -{
> -	return -1;
> -}
> -
>  static inline bool mptcp_incoming_options(struct sock *sk,
>  					  struct sk_buff *skb)
>  {
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d3b8e61d3c5e..26dd751ec72a 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1175,6 +1175,7 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  		size += TCPOLEN_TSTAMP_ALIGNED;
>  	}
>  
> +#if IS_ENABLED(CONFIG_MPTCP)
>  	/* MPTCP options have precedence over SACK for the limited TCP
>  	 * option space because a MPTCP connection would be forced to
>  	 * fall back to regular TCP if a required multipath option is
> @@ -1183,15 +1184,22 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	 */
>  	if (sk_is_mptcp(sk)) {
>  		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
> +		bool has_ts = opts->options & OPTION_TS;
>  		int opt_size;
>  
> -		opt_size = mptcp_established_options(sk, skb, remaining,
> +		opts->mptcp.drop_ts = 0;
> +
> +		opt_size = mptcp_established_options(sk, skb, remaining, has_ts,
>  						     &opts->mptcp);
>  		if (opt_size >= 0) {
>  			opts->options |= OPTION_MPTCP;
>  			size += opt_size;
> +
> +			if (opts->mptcp.drop_ts)
> +				opts->options &= ~OPTION_TS;

I'm wondering if you are ok with this patch in the current form?

One thing that was discussed on the mptcp ML was exposing the
tcp_out_options layout so that mptcp_established_options() could receive
such argument and likely clean-up a bit this code.

Not done here because placing tcp_out_options under `include` felt a bit
"too much". Perhaps adding a `net/ipv4/tcp_option.h` header (and
including it from the mptcp code) would be more palatable?

Thanks,

Paolo


