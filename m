Return-Path: <netdev+bounces-206671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF787B04015
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6AB1A6478A
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79324EA85;
	Mon, 14 Jul 2025 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxvTKTdI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2E188CC9
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499834; cv=none; b=OFbXSzc7uX7nF7j0spQG1GGxzYz4MNdJmet/r3roTyq89cmY3MzogYh0tdRNcMSdVMnENWmDT1UazoWq4LEsAOBH1Wo9Ih5YdoFlId+tGAp5yEnwrAGZ4sVm4A716nXlAXRJF+7fyaLVIHztN0Jp64DP3JQ43uvty121qv7NlvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499834; c=relaxed/simple;
	bh=jE2PjP+eUyYjMNAeVnNr5q6iOIuN3tAeEx+RGEXiP+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tW5Oy+oG/oAA7jQTCkPJL/C4FGIgeGDPRfWPgsQGTDl8DQidhaQERmMbneQ4Y5JhTHoxJEeIhSLs1ea8aEsWgbKQbWQ2tTNLh6ea7FtquPSyROKo83LozXY39hB2B5NBEVtHEM+s6WkJQzBaNWldDlYY16yIby9BBImPFnS0Ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxvTKTdI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zrHqcWkaADA2V8M40rY+/BG8BMVb7igefIEkGbRiek=;
	b=HxvTKTdI1itRGZQJ2uwjeuXXe7W60mB52wyg37fJQtO2zwHB3meczxI0U0cL7qCxH8nekB
	j8KlMq/zSVJLB/5OKiNmLitDfHBwJ+dC0s7N9etWzfPhO+UpIVRr634qSupvZ71yXugewc
	06TeSay7s/ZhnJiiZ3r13Sy8TeH2UoI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-PlJ257k6OF2UytsUTJ5dew-1; Mon, 14 Jul 2025 09:30:30 -0400
X-MC-Unique: PlJ257k6OF2UytsUTJ5dew-1
X-Mimecast-MFC-AGG-ID: PlJ257k6OF2UytsUTJ5dew_1752499826
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so1911808f8f.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 06:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499826; x=1753104626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zrHqcWkaADA2V8M40rY+/BG8BMVb7igefIEkGbRiek=;
        b=U88wo7F+zA5IUEz9vCm3OcASxFGz36rjU8zK5U3rcVZYDrMP7Gjdvcff6c5m7/hCin
         S274cdrWHrxhAlU7Thy4ZT09vZZHOiXdu1IKbo4kkk617lXuiAcN9a34gi6XkkOMs9o4
         6MriuYooQ4tQeqSjzNhtMxpP4nhT8qiT4Zi1AmHEOlBzX23S5amcUnOPG5UzKmQkalcK
         pd0ihgi8afnV5gBxoUMFvmh/xOj1T4acTWaZBJBdqKPvm6l85+xrFGQ72lte1zdYHnTv
         Q0NNdti/VxVvMGs2udLrwJB/UD0gXiqw7g/y7rfPKWdZmd1G9ebHjdakE0TSt2tYGUnc
         4v+g==
X-Forwarded-Encrypted: i=1; AJvYcCXv2TXAbZ+EQ5oeo7G6c4IGehNIYd40q77dZgSQKSqq82hkUGUUaZ9ByxFk3N5mZTIspTSis5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJ2/5zQKyeE28XYt8j+v+hPYOelXQcf+ykAw+REOPsFTsC2IK
	tGKAIxSYDxyoWV7dtj/9MS2Vsr9xDqlTkUOW5vFHwlIBsUBt3IC4jw1gczjUSzuLDPxeWH88Kyx
	FrTt1HoikEoD3UzLAP+eyDsAkpqyO0Fh+bkghHJjhXT4JoGINwcGCjEqQzQ==
X-Gm-Gg: ASbGnct9RYNn+2VhAIyJcY0Hk8Z0iHBLHSaM9Yq8tUYPo3ARc8pX4QWHdc+gVxez/Be
	Nnq1A8fs9+S1Fla6L1tifSEsCYiALZEh3loqP5MRLLdq28CTIO0uUG5oEZMMK0JWBC9JakoAN03
	nOU2Qrf39U3rxDVJ9ZxmuHwI+TWcBvI9cLW5oEnlkQNmXD32a3dJI6FvX5Ji9sxv+W/ku/+a2VZ
	cTGlwYQTbKz3ovMMD5pAsppkUfbk+AsoyuR8UtXYy7krgmZMshVKchGwFKLv+Uug0k5hLIRwpDJ
	iTYnkO7/et4G4ZCQuCNTkU08xxGVE4Tikf+zJFLbjN8=
X-Received: by 2002:a05:6000:1a86:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3b5f2dc216dmr9064710f8f.13.1752499826076;
        Mon, 14 Jul 2025 06:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFaTEcDjTABy5Z9QcNaN67akhbYxVRmsOC1nK6NjQhL0rqHS1s4JU+e5aThLy1SFXDe8sLSA==
X-Received: by 2002:a05:6000:1a86:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3b5f2dc216dmr9064691f8f.13.1752499825633;
        Mon, 14 Jul 2025 06:30:25 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560ddf5e0esm67383545e9.18.2025.07.14.06.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:30:25 -0700 (PDT)
Message-ID: <dcf822ea-9dd1-47f5-8b2f-9c98013b1499@redhat.com>
Date: Mon, 14 Jul 2025 15:30:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 08/15] tcp: accecn: add AccECN rx byte
 counters
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
 <20250704085345.46530-9-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-9-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

n 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 61b103633da4..0d8e1a676dad 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -971,6 +971,9 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
>   * See draft-ietf-tcpm-accurate-ecn for the latest values.
>   */
>  #define TCP_ACCECN_CEP_INIT_OFFSET 5
> +#define TCP_ACCECN_E1B_INIT_OFFSET 1
> +#define TCP_ACCECN_E0B_INIT_OFFSET 1
> +#define TCP_ACCECN_CEB_INIT_OFFSET 0

It looks like the definitions above are not used in this patch. I
suggest moving the definition in 'tcp: accecn: AccECN option'

Otherwise the code LGTM, but I still have some doubts WRT the
significant increase of the hotpath data.

/P



