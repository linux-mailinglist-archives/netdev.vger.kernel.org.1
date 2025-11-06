Return-Path: <netdev+bounces-236318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D1C3ACCE
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 13:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A17124E5BF1
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A7324B1D;
	Thu,  6 Nov 2025 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJ9nmZnr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nCkEQhgW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE9322C7D
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430849; cv=none; b=duqhB6n6umkyT0kxUxfU1IWonTHZn1z8Qr5TxFwFyuMTP00D5ZpJy7BiktEfXV2kaap4/bgpoZ4Og0oiYl9wfLXT66MgTcGMI8+QKeLdXzuWUIcndGvcos3rlXay/FTXFdmz+8QHdLfUOhwHIh6/IooAryb7qfwF4eGOpcOxE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430849; c=relaxed/simple;
	bh=IYqfFJNvPfd62Bb/O37mPF31V+FC5WYlcRjL6D8j4zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MGRwRMlchkGa4qN+Q5nMFa5hHKaKrJ+3ILk//+w4DzBOFreoQrDlOwIUeM77gLzjvRdUrAkgxlcQ23OaqKrSgq9/PUmJe/aN80NuY7cSZyUTqER2K6XJaOsYXjXadtjfRTG1FTqWQualtImMMfy2somdbenl/Yow231ZpaqlONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJ9nmZnr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nCkEQhgW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762430847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gQ4lVmNvCRfpjsdJ7H9mkpnntTRrFAHidg+hA5PZ9U=;
	b=CJ9nmZnrfLJVw736Y4hTcp9hdJZDyTSYdelhZbAMN7D2Go50ZnUnfY7eDfKbsQ5Yfi1g3c
	1+Q9UZHqVEmhCYPOlU6xUD8usQSzVOjvzZR+I5QhXflAXwaSf1FdeGjsbDvQDtlG2a6d3L
	ApumeWS7UvpRdlENc/pb+IzsG5eIFXw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-N3Vnz_uwOqaZi4qmlT5yWw-1; Thu, 06 Nov 2025 07:07:24 -0500
X-MC-Unique: N3Vnz_uwOqaZi4qmlT5yWw-1
X-Mimecast-MFC-AGG-ID: N3Vnz_uwOqaZi4qmlT5yWw_1762430843
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471201dc0e9so7766885e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 04:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762430843; x=1763035643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gQ4lVmNvCRfpjsdJ7H9mkpnntTRrFAHidg+hA5PZ9U=;
        b=nCkEQhgW90l5n4hT6ngPy1l0dOQkYjuICYiA37k6shKjVzQM7iB1we9Vw0QvbdRgo3
         xImskoXIKEFawo4+eHEHLp5cmSBkNrTXJue+LalSG1vF43N6WlSR0PYgsfLY+2Dkb0Hg
         59/Ncvvr71Q5d84lB0P8hFhDTbMNt7hlHfroTOWnhUh8C26T2vPLmo28WQg72mTZvRia
         vlRgj+3Hp8xRTK7icAC3QYLsrJb7FUmNcKO3gUtGyV7/o6A+PzCf/Nl8/WXapnlD3GlD
         85dHNFXbIGghbBl0pnF9rMfRiFSmEumG/xbhw+sPbBMhhCjwRESDozGHjWjIKYtXhttr
         kFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430843; x=1763035643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gQ4lVmNvCRfpjsdJ7H9mkpnntTRrFAHidg+hA5PZ9U=;
        b=C20Qz92sYpo2W050RbFb9HRB0hpNrYpvoGQRRKwBfZPhdIeIhHrQwoQbjHHq277mfx
         1gF+9xg0qqoT3c10jP2g57Hfb0Zb4yfxq20VpIn5lStJVIfCQYWYqA5QL3zqS4U7pnfc
         ZWsVZqLEmrIuVsGTUcUUrLObHnmeRfXJvJ+FABn/vu3AwbSU+mC7JWbJ7II8gyXeRaU5
         I5+q/OpO3yPvBlsnhrDmEU27PeHUevnk6rUYOoNMod1519dKywPIFyyVtL9cc+/3FJp6
         aNLhOnRkNmS/o/vok6vy5tErINdGGXqgFF8qA7WfD9X61Tc5G5Q1c7IRIvjDtP4lGd0P
         2PUA==
X-Forwarded-Encrypted: i=1; AJvYcCVFrM5bCT+UEwKTEHdkTT0RhHR7Rt0rYRjiiVje05imzFk2tJjVQ+c2Uf4plsRluC2eBFo8uqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbkRer0Yxi8qlne+PkkI2614QJ2qgE93ETJVY9Kjv3B6GeAZE
	ey+twgM1nzcHk/xymJxFeCU1yZ9hXy7aJ8kw3i2FFTsC69gUuNQV5tE2jhDVB00Hrum6v4FRymq
	C+OPpGz/Uxdv6c79P5UzSCTVNJ2hzv0khN8cRO1j/GlfOvY0sRFMlnWUWIA==
X-Gm-Gg: ASbGncuR0UoR8e9vCKWuQQTsEOou0+J61qxLx4KdgLqk8VPg0oR6+92D6y9r0qJF3PX
	mZwEUNPe2bYvDznMvFpnpL2XTyWDzK5gqcT7ocTbOCADOQa9zxAzVlfneSo5o39s/6Uflvy+9ht
	nt+6r4J7ctl6k98k4KNrgJS7qcKZyt7Jr1vAMwsRGcxSltyubFaE9ePktWJowoyyloSZKBiuoYB
	6klzEf2jO3YXA+ZREbh94Q3eLUySLxhfaUHjU4cAxoYEQJDoJ8fCDorPTJJVypcGVjUbR5o9atZ
	ZbSrdkckcxE93pva98vI/e5+Cg9tacAfHlwI/rwCx2jl6NmO+oeqVnmOXGcPfXjTxYkq/muP/Lb
	euw==
X-Received: by 2002:a05:600c:4e88:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-4775cdad65dmr61056675e9.2.1762430843064;
        Thu, 06 Nov 2025 04:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx03MVe1UPLGcOQ/uXdT9zWecweOElKZRclz+LOkTGKy97++ZKxB8Kf0/fNaib1PlyCL3ejw==
X-Received: by 2002:a05:600c:4e88:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-4775cdad65dmr61056065e9.2.1762430842523;
        Thu, 06 Nov 2025 04:07:22 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776250d3d0sm45954345e9.7.2025.11.06.04.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:07:21 -0800 (PST)
Message-ID: <d1045b08-2cc9-42c7-816b-ba467c27086c@redhat.com>
Date: Thu, 6 Nov 2025 13:07:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 10/14] tcp: accecn: retransmit SYN/ACK without
 AccECN option or non-AccECN SYN/ACK
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-11-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-11-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the
> ACE flag (see Table 1 of RFC9768) and the AccECN option to complete the
> capability negotiation. However, if the TCP server needs to retransmit such
> a SYN/ACK (for example, because it did not receive an ACK acknowledging its
> SYN/ACK, or received a second SYN requesting AccECN support), the TCP server
> retransmits the SYN/ACK without the AccECN option. This is because the
> SYN/ACK may be lost due to congestion, or a middlebox may block the AccECN
> option. Furthermore, if this retransmission also times out, to expedite
> connection establishment, the TCP server should retransmit the SYN/ACK with
> (AE,CWR,ECE) = (0,0,0) and without the AccECN option, while maintaining
> AccECN feedback mode.
> 
> This complies with Section 3.2.3.2.2 of the AccECN specification (RFC9768).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp_ecn.h | 14 ++++++++++----
>  net/ipv4/tcp_output.c |  2 +-
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index c66f0d944e1c..99d095ed01b3 100644
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
> +	if (!req->num_retrans || !req->num_timeout) {

Why `if (!req->num_timeout)` is not a sufficient condition here?

Simplifying the above condition will make the TCP_SYNACK_RETRANS
alternative simpler, I think.

/P


