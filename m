Return-Path: <netdev+bounces-229942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF562BE2520
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2E9422926
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35693164DC;
	Thu, 16 Oct 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAC6uWx5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D629C323
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606053; cv=none; b=TNGVa4zfJP8T5i7AzAsdjHpaBS447rvp0MNwH2r/Y/fkrQwkwzKmUCJEVVg+yBjsMrS0H1NJHdZpxgBHnb3r764tjJQqwrfZOmdxtsoeo5euF1jEPcsEWiFIb1C6o/OK2F5GJgcwS9W22c1G+XtPDkbBo9Wgj6GlMub7IgMSG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606053; c=relaxed/simple;
	bh=ELmS2iqx46fL7UasEsDCyMyL+buB0jyC61nw+TSeRsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SM1rUAPhlSMgJx7e4UB2GYtjf0FqiwH27Rkaz88tLPWnBhS4THUz6VH2P/d+KoTHjNI22Rx9II3d3TAqWGH3gvf2BZm6s4jHJopX+bxUjIYIZ75VMmIjlKXr09W5s0kZMP2srl8W5e0ozhiPi2LVXVh41jrNaSbe8PmUAoQjHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAC6uWx5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760606049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQC/nox2pPgKzpW6LX7hPXAhl0xagSfw6/n0g49FETc=;
	b=CAC6uWx5no+nLLg/vjsn2aae9L174c9xDZK5OuuAhfC4TJRWH/v5wAZnWq2dn5S1rU+Cm9
	GvFdfS+dEphSMo+wcmavFlxZC24Oj5wGlZvdsM29tEDNGFP8126IXI/kASgItlaiGQwMe0
	AIBm3wlkNgXgZolLn42arv4HHuMjCF0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-pL0XvJpbOhC5y6ObGEGJjg-1; Thu, 16 Oct 2025 05:14:05 -0400
X-MC-Unique: pL0XvJpbOhC5y6ObGEGJjg-1
X-Mimecast-MFC-AGG-ID: pL0XvJpbOhC5y6ObGEGJjg_1760606044
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so1101752f8f.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 02:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606044; x=1761210844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQC/nox2pPgKzpW6LX7hPXAhl0xagSfw6/n0g49FETc=;
        b=jFApqpyR03vfkKpLpMPCFW0GAkBkVQN2KxHpxDNUHQ2d+0SROUHTFx5hmMtIuOvfJz
         z9qjGcrpGX2H25mPaqGvFvK8Bq6H5kstPEsiuYmJy2jqlhke24crnDOALwrrvvtTe8kc
         8ALEiPIt8q4d810aiWWAOaP34TFUM+lVn/lIhPkVbPRqCNyWLsCuj5xBBqcvPWa4kAEu
         mXtHo3OD/H8vFLkYf4eUBYtGDvU3QXd5FETtf6MxfQ10XcOlqBRbrNGYuen65nI1OV7h
         vSktegrP3gBjaeidn82uecUvfrhOBr2LZWENRqR24oDSXafPiHaiNDMcrbQTYmuAd8uX
         iV0w==
X-Forwarded-Encrypted: i=1; AJvYcCVbAWHfasfUWfnc/DIDcJO3a+4qc/p5ySYLRmYIAe/N20oVEQ92gqLtocoZFsbY+QKYeDb1pqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6aXYB+gOOX8753xbrNllFoR+3yf7Fo2NCR3xLx27YInMwusu
	pyPfkBJvTF7tiqg+hX0PzvxIbNExPKa4oDaQf8R5cUy7WDxJ6TPkQWxYRaDuOcsSFAkB93djUYI
	TfZW78apddmOU97ImeiLK2k0Cm5cXM1T8ekr7osLNwfL5hPfDakAo8y1ylQ==
X-Gm-Gg: ASbGncuGRiUr/nppwiB7tpGnjZtawt0UHYicclIBBqbXMebKPa5h0ZkNeaSXqrs4uQy
	f8oTLfDrjGd+DIh/2KWW5ybsw4bC1O4eg9rb4A5jvk2e4GW+FyNezsMX61Pw7uARH4jsS6CEQjO
	hqkbZhDt+QLpfj090UyvVIesybtmWucStfXJEXhR2jt9ASuXkbOUwoUgQKexRZX8h/pFqjYdhDL
	4wjt23HGdFTBZQDHzPxzwdv1QrUjfyI4MFjHGTEV4s+QqjFzmBRE1Q+xTrkG5uMJerS7rMQclTG
	xawKBl3iwaRLSmsaIBV2DS9sIdAToKaQUuIyVIEpCfW1Oop8X+dInQwErcdPBXByQC2FPz4lhBD
	WWmkOLs62He8VJmhy/ayARLL75GID6lpLkExD9JyEcHyp/Zc=
X-Received: by 2002:a05:600c:4743:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-46fa9af1814mr216099005e9.23.1760606043958;
        Thu, 16 Oct 2025 02:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuLIFjtnAoI+JjoLtnLBFFwkqEMXB7AsH8mFt1MS1ibyoib4YpL7DpeFE1kmI6fKT2Oau5gw==
X-Received: by 2002:a05:600c:4743:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-46fa9af1814mr216098695e9.23.1760606043472;
        Thu, 16 Oct 2025 02:14:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114461debsm15463165e9.18.2025.10.16.02.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:14:00 -0700 (PDT)
Message-ID: <705f02b2-44c6-4012-a1f3-0040652acc36@redhat.com>
Date: Thu, 16 Oct 2025 11:13:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 08/13] tcp: accecn: retransmit SYN/ACK without
 AccECN option or non-AccECN SYN/ACK
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-9-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013170331.63539-9-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> If the TCP Server has not received an ACK to acknowledge its SYN/ACK
> after the normal TCP timeout or it receives a second SYN with a
> request for AccECN support, then either the SYN/ACK might just have
> been lost, e.g. due to congestion, or a middlebox might be blocking
> AccECN Options. To expedite connection setup in deployment scenarios
> where AccECN path traversal might be problematic, the TCP Server SHOULD
> retransmit the SYN/ACK, but with no AccECN Option.
> 
> If this retransmission times out, to expedite connection setup, the TCP
> Server SHOULD retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0)
> and no AccECN Option, but it remains in AccECN feedback mode.
> 
> This follows Section 3.2.3.2.2 of AccECN spec (RFC9768).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp_ecn.h | 14 ++++++++++----
>  net/ipv4/tcp_output.c |  2 +-
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index c66f0d944e1c..97a3a7f36aff 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -651,10 +651,16 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
>  static inline void
>  tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
>  {
> -	if (tcp_rsk(req)->accecn_ok)
> -		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
> -	else if (inet_rsk(req)->ecn_ok)
> -		th->ece = 1;
> +	if (req->num_retrans < 1 || req->num_timeout < 1) {

I think the above condition does not match the commit message. Should be:
	if (!req->num_retrans && !req->num_timeout) {

/P


