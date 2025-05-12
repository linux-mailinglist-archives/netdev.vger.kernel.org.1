Return-Path: <netdev+bounces-189884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE88AB44D3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08487B06B1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611D2296D32;
	Mon, 12 May 2025 19:19:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3302AEFD
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077552; cv=none; b=Ip9RTyELeZWHvN9VzkjRP86Bk2xAuQd3P2Q66R82Sf7RLwFb6L12oC/tTdk5nf0fIZxwUrD0sgtOzr5qYkBLc6m5QfIX/0wXYV7jIgMpe8xSzNliNTbn420jUSsHV4cJbQrfzhN67H/wsgTNiYWlfomhdCzdKhgVopYoAyb8fqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077552; c=relaxed/simple;
	bh=o3jldYgjxLNS5kgGjKz/+cPxv+Art+Qzg470GdKD1VU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nmPeKU0uMhxL4v5Ff+LgD9yPC6CAD/0+a8wrBaL+QpxHh5+oxqzDRL1PeeM0AjqL8A3xUDVWarggLgdONjAdfa9ZvJRtm4mFpmS941/0i6Ar6cRPSSWNx0GOs0HNuegT4vyGm78njPhSNd+5TACfTnNNJNx3VCXNawZAraLImMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5fcc96b6a64so5270060a12.0
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077549; x=1747682349;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQpBJvYhQGol7pXyMwJQ5lWbtzJNjPvn7U0rGgFl8tc=;
        b=EoeA4VAgNv0lf/Lv45VXVsaKHh/YV541wnwfY7mowknU8Kk6WJhBtoel9Z9hohVPDo
         ZpX/C9jPq5DAMdo4p7GojPrQOW/HktWU9YqfBKSG1eWOGAO57xFMLMQKIN5MUFs3IM82
         nj71CbuaE9/tWRy0oN6CTisQh+LWcN++heR74D8VdkYWRuteJP3T5vvqIQFl4vPf8OiL
         GN1OF1ql26byjAzHmktuJQra/GmYt5WCYW07O+fUF3UJyjdUnRkJWbWJ6ihl6CNxEA4K
         ZwxdoHwKd6zEFHwb8GTgNF8u85jsHDjW4lecesUswYwG+KFZwSeB9Pe/BUXEwcjjV3zp
         Fq8g==
X-Forwarded-Encrypted: i=1; AJvYcCUTNOzhhRF3FueYw26wKaf+iXvZw+/N9Q/bMedeuhjVzfCm9NVOamscnAPZk8kgRdkE8V4BbDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwTLa+L2JWIRHUOl0msSrPnFzVoU0jKKjBnA/tyL1zb2wXo/h
	UX3kCqXxIAHa6rNWBYQYNV7CgsJjiF/8925PdA1kg7bDn6DpWFSdWXDguChlsvw=
X-Gm-Gg: ASbGncsU/AL9q45n5QqSBmwiZ3t55GCfGEwfEKD4q5TrZX1w1hne/EukPtwo5bZA26+
	GtF7wld1GPQYIESqbLYBIoJ91m5nfzqoBM5aKIJMo592yKt+vBwBIFs6r5Yz8UeOnvfVTptmrcl
	zley22RPy2Lhe6THnSzmwE0epUUrmPqJPa8ZlBX/PZB4peiWW9vFK67ZMCVqRqx8IhnAJIPQ2Jw
	EnF3wQ/d8PujNWeulIvLQMfUH1sahmAcvOt6F5nkBjxrPMTt4NJi+EUM/ec13dun5ZWMWodj+iW
	8Oy74nUkCSP9NF3oKIgw/8ZNLbcV93lgEoZKVLA1J6ZrV8F02TwcqucQw8ahJ3LUu8NcOHBsAUn
	Xsyg2OyVaRYpa8GegP5EIK0Mzfica
X-Google-Smtp-Source: AGHT+IGeDrgun+0/v4Lc1Q58iX10Co76cz+bFCR1suPfkRnMipzz9L6uuagi6zSG9KNvK2igxJ1UCg==
X-Received: by 2002:a17:907:7fa6:b0:ad2:54c5:42f0 with SMTP id a640c23a62f3a-ad254c5457dmr383667566b.11.1747077548475;
        Mon, 12 May 2025 12:19:08 -0700 (PDT)
Received: from [192.168.88.252] (194-212-251-179.customers.tmcz.cz. [194.212.251.179])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2192c8bacsm652916666b.6.2025.05.12.12.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 12:19:08 -0700 (PDT)
Message-ID: <d730ef45-185c-4622-bdfe-8cd896b4d940@ovn.org>
Date: Mon, 12 May 2025 21:19:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, dev@openvswitch.org, aconole@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next v2] openvswitch: Stricter validation for the
 userspace action
To: Eelco Chaudron <echaudro@redhat.com>, netdev@vger.kernel.org
References: <67eb414e2d250e8408bb8afeb982deca2ff2b10b.1747037304.git.echaudro@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <67eb414e2d250e8408bb8afeb982deca2ff2b10b.1747037304.git.echaudro@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 10:08 AM, Eelco Chaudron wrote:
> This change enhances the robustness of validate_userspace() by ensuring
> that all Netlink attributes are fully contained within the parent
> attribute. The previous use of nla_parse_nested_deprecated() could
> silently skip trailing or malformed attributes, as it stops parsing at
> the first invalid entry.
> 
> By switching to nla_parse_deprecated_strict(), we make sure only fully
> validated attributes are copied for later use.

Just to re-iterate for anyone reading this thread, copying non-validated
attributes is not a problem as they will be ignored during execution.

The change looks fine to me, thanks!

Acked-by: Ilya Maximets <i.maximets@ovn.org>

