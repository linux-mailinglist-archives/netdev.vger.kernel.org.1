Return-Path: <netdev+bounces-206672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AACB0402D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB38175A60
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8142522BE;
	Mon, 14 Jul 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpzctJLL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50540251791
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500042; cv=none; b=MRyNO6dbnSZfV4ozvR6NJvK0mjbUKEGMBWtcCMQynWllZhV56sGqFwFQdT9gJOGuTQMWC6PirGGIRchshM+gq1ynHrSBstd8DE1H94/UyraF7mLsmc/lfuc3Aovb7N4CKL43r+8TyTk/3AY//AtflkefmBpEHwTmCMAD/ALXzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500042; c=relaxed/simple;
	bh=dknSdYPDMo76cFz0sXYbOIhIT5DVtRwgwQqMWZ1ploE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WcwNmP8o3oN4HlsQcF+2x1XVYrngP0HhnEJdM1Lz4dQDXLEfOsMrrWq6rFyLqsW3ca48Ll2ZQPKEiKQGJxp7lhr7Hup6a5LLX78bwc+pNp9JCxIrtZ4l/AXnvXI2tOI43LlW1hyprT/NGHJMjIFZ1CmflUbvE+KQhBGl7WqN1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpzctJLL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752500040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib61hPCB4AUA3/+sodbduYae96rRA8xkreivfOor25Y=;
	b=GpzctJLL7UYjrjouZ4PlUM97VKFQY/VF4SQ9d8rp6RJ5aO3VTmdpXcLJDPkedCK4iGCqG7
	0YXYST4etSTYjmrWJBohncxeHetXqiFwMozJ1jlJ80Bq8D6tqWpV0l1lQRBkp6p3TEm4eI
	jga3JLDxVBa+zT5+UAxIKkNpH4k7jvg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-3za8PlOJM9KYxjJorqBlWw-1; Mon, 14 Jul 2025 09:33:53 -0400
X-MC-Unique: 3za8PlOJM9KYxjJorqBlWw-1
X-Mimecast-MFC-AGG-ID: 3za8PlOJM9KYxjJorqBlWw_1752500033
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso2125415f8f.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 06:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500033; x=1753104833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib61hPCB4AUA3/+sodbduYae96rRA8xkreivfOor25Y=;
        b=kPiWgbLMlFy2jdC7TSaCBgNM3wZw+qUP2D7iJyIZ36NTlwj2sfoBZW614XwURSjxfF
         CA93vxC2emqrVhFIo1nV5cq+7higbDBIdno15jI0SkxRwngeAdYT+TBmOwxtVnHjcOnQ
         k7dnHEJjY+evXFHuc9VoBYwQhAU3/oq88Pu3up64zJqxOwaXqgHnCWriLx+JvXuYp6xB
         TKdc/eLyQZpTSE2jVI//TrAzgLSF/8xofc0rPJlGGMI1A3wKMIB5UYqk6SaBCbqJloz/
         SAyR00ia3DJqcRFNCjJYwfYnLkok3zN0x+Ej6PL2I6EgKbNmBCmevzPaDKWW4eoH//Et
         4YfA==
X-Forwarded-Encrypted: i=1; AJvYcCU63LCFX/kjXqHzNKcJTWu/ZAAJ1fekxyBCmHXA2XKZmbM4roQ7icgKXLAP2VTcBDCtK4a2LKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDD5w5nDE8H4nqJZOtS1sg7uxIJPZekjWKbFF/0zZZG6mDnUzP
	y4gQoJwOwRo57plY1Heqx1K38/lgpdsGHDHmZAv76UFGmfd0QGVGLe6mQXfS4EXu2rHMUfMFGep
	b1ZKNwp+Fa5DYTUvrultH7eqACNmq3E5/K88uKM5Vmn5lvSBKHKmKoX68RA==
X-Gm-Gg: ASbGncu6NxqSLeDVwWfjl74Igju+q2XmxcJUycSfUqn39YhuaZOVt2e7Efq2XwtS9cP
	/lp8WVMA86dbzFoPGA2kLJyrdchBKA/29uG5+pF61nR9EcIn80GcHpI+1DeeQQrIc2vKICtsjlA
	S1ojM9jCKUPhCz+aDXQl2bec5zpKr6/Tybd6YHPKXt7hPm2RXP4HI2Uv67m5A40l9SuA8cCB0Vl
	Gf71KfKn6FAQYmayLesOhqPRDJ8vQNZrJXDL9CAPQ3SM4sQptUiZeq9G2p7SfFjFSP3tDU+b5C2
	OGc+I3SBJrdRIGyJcClEC4FudeEbemeWo66widcTVfw=
X-Received: by 2002:adf:e194:0:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3b5f35795c3mr9445133f8f.34.1752500032642;
        Mon, 14 Jul 2025 06:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcwfUCJlkG4jBfS0/HPnRj2f8oJvU/65bj2WaKyheEy4Aut2WkWbMl50W+qZ6Yk9d4ozuegA==
X-Received: by 2002:adf:e194:0:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3b5f35795c3mr9445096f8f.34.1752500032183;
        Mon, 14 Jul 2025 06:33:52 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26f22sm12633688f8f.94.2025.07.14.06.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:33:51 -0700 (PDT)
Message-ID: <226c49dc-ee9c-4edb-9428-2b8b37f542fe@redhat.com>
Date: Mon, 14 Jul 2025 15:33:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 09/15] tcp: accecn: AccECN needs to know
 delivered bytes
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
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index eea790295e54..f7d7649612a2 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -1050,6 +1050,7 @@ struct tcp_sacktag_state {
>  	u64	last_sackt;
>  	u32	reord;
>  	u32	sack_delivered;
> +	u32	delivered_bytes;

Explicitly mentioning in the commit message that the above fills a 4
bytes hole could be helpful for reviewers.

Otherwise LGTM,

Acked-by: Paolo Abeni <pabeni@redhat.com>


