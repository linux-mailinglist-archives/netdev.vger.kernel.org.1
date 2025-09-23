Return-Path: <netdev+bounces-225556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8FBB9563E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB46F2E144F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E01030DEC7;
	Tue, 23 Sep 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAJwLRBR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52E2F2909
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622136; cv=none; b=Ky++A2qPA0rGud7w2WGjzTGFg1E2K20ozT/VfftFNAGquCmzYHlDCAunuVW0YvOwMMwB8t7ON3bJI2elX9x51Rd601PJslhE5/IV8PE8ZpjretSAQCbO+n4cN25e2+tDDWarRVjZKeoS2+8c7566EwtH5z0hhHhDFAFvRFg5/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622136; c=relaxed/simple;
	bh=S3KOpBbqom2/3HrzTHThYA0lYWi/O5mMBlQ+qwi7tME=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p6pLeXNz4dyMV9Vmqsd81t8mYYCETXVg8urzfHPaKaHQT2sMsRVv6r0lfy9ebpFWrPX1jZzEQG+7vx470OY9NfzIK1TIURSuLoHY1HZ3i6FlESqk5uc/bHO9C3piuUw6i8BSwPy6KGK9TJO4uerndzxa7SADsTZNhs7vEQOz+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAJwLRBR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758622133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAJnOq7wJ5XI1FIJLe0LF85/fgqZuSixFEm3aUU2pcI=;
	b=TAJwLRBR0nuiHGR+/950zNyNaIIipgI424WncV0PcWCnmj1cUYv8brCKeDHHoOXy1VEg4g
	x+b+KECzKgFmRZ6/ds6VtSHLtXPw6LCoLnK++ekPrIfsEIVQRmhRyImHcLNNMko4BWNTtg
	lTAVsB6Pfw+CmNE+AQxboIYxPQIu6Rg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-05puOCVfN5atoDhTzK78HA-1; Tue, 23 Sep 2025 06:08:52 -0400
X-MC-Unique: 05puOCVfN5atoDhTzK78HA-1
X-Mimecast-MFC-AGG-ID: 05puOCVfN5atoDhTzK78HA_1758622131
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e1e147cc0so4676355e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 03:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758622131; x=1759226931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAJnOq7wJ5XI1FIJLe0LF85/fgqZuSixFEm3aUU2pcI=;
        b=Em8F65y2MlpLeBnLAOroWATDfmF+1lDfouTkMqG8+B0IkyJg9NjnJUbUCIIpLv8Bur
         UcJ0pG6UWYXK+pnLY82xyztb+8UNJq/t8BBEGBO+jseqD/bpGEAGU/6HkOt4CaBP2I8l
         6y7W453pV4PCJYW8tmEqYvJSj8UKlBqVnAXYnWqHK43kkBP2SFStF+Tn8v/C903nscXx
         U8R2wjktNTj9bMV/zErvClh2n98SS94QGuIhgWulBPjiloohu6dqIIQQ4TctaAllDixJ
         YtBGZUb+u7XxKTyPjNyfze+JFp39J2D5WJMz8qymGNkSUQAqw1CpYcs0CtH8fore3mW3
         BYaw==
X-Forwarded-Encrypted: i=1; AJvYcCVcJoH2hueAQ1LJCvjDGIuqV9BRPuIwO/pHpsomNyqOe9tL2bFCK74+hxfpsjeE2bakLtDFwDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaRrAm6oBmV2y0RgCUlIWKemOlkxwbw+fWid7njatbYP6eju+A
	UqNONaaBzz16cVCn82F9VRSgFhkPUotNMF0HzQV5NXAOZMj6+QYvJJsL3lSLW4hZMww5z6eQPIW
	ew28ft+ss9jceFHzTE7gHQg/kB1S2eWNxEDtWaCApkK189lKJVOAia4CQcQ==
X-Gm-Gg: ASbGnctAkI8oLYfmlTG4cjxvQjBTCdHeBebviRqzDWxmBwWUaeDgYNqTZx93wea6n2e
	fbJ+Plk3Nv7FmwyGuBt+6vt1zXmC/hiltW0E74nOWCcaioYHwHNJ2eRxoumtdTTSdGHaf7Td2fj
	uH0PiKTA+LGsBcC+1UcJ2U4b/zeBpwtx5JtlSOYINL16Bm6RPLB6K9/ogKGYAIjcZLijk1bmBYH
	+ExqYTkvjaTGctoCfq9Xt1X9T8GcxH8lf2z9Vw9gcZCKuUbs3GfK7dqke3ULicQfjGeGfEdfAjQ
	tIhTZvLChgNQqwzvPTuMVTBViD9SrDP/GLJ3iRsNCegneYfk6RvCoMlbtutr2VOYjsWMZjSk3dv
	cSZd4Zz0KWkTF
X-Received: by 2002:a05:600c:a48:b0:46d:45e:350a with SMTP id 5b1f17b1804b1-46e1dab50e6mr24290135e9.17.1758622131003;
        Tue, 23 Sep 2025 03:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGiVBoeiv8DFrvBqu78ojFZFjTSEy+NrpSObi8FAlZe/hiEW3VVmVz2sDexaIeGuLuj+QBIg==
X-Received: by 2002:a05:600c:a48:b0:46d:45e:350a with SMTP id 5b1f17b1804b1-46e1dab50e6mr24289565e9.17.1758622130617;
        Tue, 23 Sep 2025 03:08:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee1095489asm22527408f8f.24.2025.09.23.03.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:08:50 -0700 (PDT)
Message-ID: <790a6a0d-4611-4cad-b72d-a99daf7abb14@redhat.com>
Date: Tue, 23 Sep 2025 12:08:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 05/14] tcp: disable RFC3168 fallback
 identifier for CC modules
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
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -525,9 +527,10 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
>  	}
>  }
>  
> -static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
> +static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
>  				   const struct sk_buff *skb)
>  {
> +	struct tcp_sock *tp = tcp_sk(sk);

Minor nit: please leave an empty line between variable declarations and
code.

>  	if (tcp_ecn_mode_pending(tp)) {
>  		if (!tcp_accecn_syn_requested(th)) {
>  			/* Downgrade to classic ECN feedback */

/P


