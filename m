Return-Path: <netdev+bounces-198496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE970ADC6E3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EFF18942D6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B8A2C032B;
	Tue, 17 Jun 2025 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMDuYYoD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A72BE7C8
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153470; cv=none; b=WPt/wSoVhibIeHJ3Y4GiOgFP4PBw9W3cDa+XnNuHBfnezS+wtaYsKB+nLe+WftjbySCI9jdXmz9xOnUePbfHIa/DXDlsM227BHFUl3+oE+jzax0TqpP05f4kwvwf/99vx7moEp7+S4RTtwkf1Tyto8e4AdEsLxjutWkWxCbYN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153470; c=relaxed/simple;
	bh=e4uRqKiHK+914gVeOIiVV3X3FcUt9r0rHl937hvIjjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VLcYKzevzkCdBU1QMPFJMeKLBHorbypw5ildykYmOMltukzfzYSsTZ4iqfiEj0wj5f5Smxxk5krLj5lh5VlQAybN62wUnuQ395nu+4Zr375T24ckISQxi5OK9QrYbyTmFAhPdo/6MNz13ZnWgeMlixRN1vbW7IcnHwBcuBqSbPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMDuYYoD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750153466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzL8BCb5z5mTe8AmKnSvyMsKdN+ktV9EKzPlxxLDauM=;
	b=AMDuYYoDWFJKnahySOKC7fu/UovDN6k0UTkmMIPV70HymgS1GDLj29vd9bYslqJnpNaeeq
	ugNe4tn24TZsLlZC23YsVaXKRxP0BRDr+uPRfnQM4BQzco1AtYV369AKkttflG443hF4h1
	4XElNQqDsLX6VB7o8dhARnhOVl2ZiWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-XMF7oVzXO5S37r5M1eyQKw-1; Tue, 17 Jun 2025 05:44:25 -0400
X-MC-Unique: XMF7oVzXO5S37r5M1eyQKw-1
X-Mimecast-MFC-AGG-ID: XMF7oVzXO5S37r5M1eyQKw_1750153464
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a56b3dee17so2013106f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 02:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153464; x=1750758264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzL8BCb5z5mTe8AmKnSvyMsKdN+ktV9EKzPlxxLDauM=;
        b=Wg4n2qIkrQXtF3Mvzy0c8KPoFBy/isVNBQCZ2BZlbh80GPst3ee7eR5NBwfpfVR3bH
         mQSBCnHNBeDWhEySpwJ9UpfvVtd2+JNnTkgKYo58fVEXN4RFmKgxAOYK9/dkiaxr7/ha
         Dhd5WoHFVmyK9aNEj+AWDJ5Ve6d9rqb2lt9kK4iQpJA7aezayHaRGA6jLA50TQG4/7LM
         rdRKNYt173JxKacv3cPK3G3nerN+aTGaF1dz1egL+AS1rPWyqTRD00bhmBVxyTHqJOXM
         tva7z2+ZqK/YUUvWRCI4FgBOYpVRuL2C2sV4oSTnbcuzH+80j6kk+pmtjWtlTK8PNOsB
         AZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWODM72rSDS5NjiJTKF7Lot+754nh6QooDZHRqGXN1SvrXC06jEEYUUb34QwQFXwypucd5bHnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlfbQWCbCxoVsp1ZOVDqTBL4Z45jRdZQR8JODRjdPSQaJEf5jy
	Pz4H5IMucLFR1iyRnIaph7LhsvkQbhol1edGUXD1YoDMCpnqRPHxw7Q1oR0wUlSak3RknECn2Dw
	TzFwxbd5l5yY0SfbZsVSfDO0UvVPIRLnCPM77e0doF1y3bX0cF0K7/4XgcA==
X-Gm-Gg: ASbGncsmu/T66Bh3oQzwiFxrr0dTG3fUTmupwNFUiD66K7a32H/5bVV65I/Rb0KE8GN
	jkbPwtT2KZpyQmnWlN1qjanrhkYpOlkYGZZzyKREKyh0cerxapb0L2NBfkiFqnFjaQwmoLErBI9
	QliE2JxX4rbrF6iSqmBZUA/gPjw4dTHDziaeNW6LaqXXBKAPtULBKnX9fiTlxC8/lwZQ+/O0NU+
	82m2YVDd0Kha9bxgy6FuCPCykqQzuMRQTn2DIWDj7CA/R3HVTUYK1bgpzPTJM/qlS7pdwy0a2hm
	qUAsK0uPGNpQJOMxm/ueYC+eqGlGRdBoYhZ63G7aDLBeeJBpaUcrX6fJCEazPxnpl9ELEg==
X-Received: by 2002:a05:6000:4106:b0:3a5:7c5a:8c43 with SMTP id ffacd0b85a97d-3a57c5a8d11mr6597976f8f.11.1750153464174;
        Tue, 17 Jun 2025 02:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKE4/hdGNiZlnyMYBRWFUzYwIsk6LZeUq2PZYEGJVxcoKxTedoN7Csr9UGI1dlan0YwSjvcg==
X-Received: by 2002:a05:6000:4106:b0:3a5:7c5a:8c43 with SMTP id ffacd0b85a97d-3a57c5a8d11mr6597942f8f.11.1750153463754;
        Tue, 17 Jun 2025 02:44:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10:3ac6:72af:52e3:719a? ([2a0d:3344:2448:cb10:3ac6:72af:52e3:719a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13d009sm172188815e9.20.2025.06.17.02.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:44:23 -0700 (PDT)
Message-ID: <558d81d1-3cd0-41f8-87b1-aa7be05f2924@redhat.com>
Date: Tue, 17 Jun 2025 11:44:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 11/15] tcp: accecn: AccECN option failure
 handling
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
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
 <20250610125314.18557-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250610125314.18557-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 2:53 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 3de6641c776e..d7cdc6589a9c 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1087,6 +1087,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
>  	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
>  	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
>  		     tcp_ecn_mode_accecn(tp) &&
> +		     inet_csk(sk)->icsk_retransmits < 2 &&
>  		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
>  		     remaining >= TCPOLEN_ACCECN_BASE)) {
>  		u32 saving = tcp_synack_options_combine_saving(opts);

AFAICS here the AccECN option is allowed even on the first retransmit as
opposed of what enforced for synack packets and what stated in the
commit message. Why?

Either code change or code/commit message comment needed.

Thanks,

Paolo


