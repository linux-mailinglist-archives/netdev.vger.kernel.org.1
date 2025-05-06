Return-Path: <netdev+bounces-188380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD4AAC96E
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5ED9500568
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4697283FD5;
	Tue,  6 May 2025 15:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2092277817
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545102; cv=none; b=HxiBUH4qGGLKqguAw8394UJtXf7UJLoy9qrTshx8BhYe3SE95puyugDLYT3WGyavXUc/6Z1/PHLbQewZBpQ3omZYxmABx4SKA/IJuTSRGKT68Lnut66fHqKKEyLZnkzdDoCo25FUznzAOwN5EwS5MeA2cVymUKm4+Y994k2wCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545102; c=relaxed/simple;
	bh=kHOo0TTG2E+azcnTaKa/TitUURRYG+FrLu72jmWYiDA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EKWh57IryeeR6MSQUlPBBr9zMp3mlXCQhsF4J3ueyMK+vaH9rPRLnXTGVjRKBnNto6+FNbX6kMhNEjBEEgmOEvigP63z/GtYyJDfN2d29fC121U3JG2NrgBWtcoJvmR9d6t3i8IMXr2ztaOVKVC+sQUH7kW/x+njlZ5PzdFPX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5f4d28d9fd8so7891945a12.3
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 08:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746545098; x=1747149898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJkx5T7QZ6OeB7JTYuDlAPnoixrZ1aXXPBauH0AFboc=;
        b=OsDY2c8VYLJboMyAbBWz+XDNx07gBtbn7BPPb6+jjzgw6UMzT3Dr28xEENgO6TZGnB
         CEruHMHIbB81ih0E/5F7La5saixH9fq3tvRB+SM3fDHidCwa//oC5gI1nZj19GpKtMeJ
         3ggTpS7i+8gGKOuoRU7xHRJfJuvzHOlJtPzkz349s32M8Bz6rKYPO7Y/PpXd04yNCXcc
         iKVxZFaXJdkD0XrAuurGwnvIZHzw199/1P0x9fVdtN1vbNR9hJbgnjZb539o8dK29EHF
         L3LAIS1n6vcH4H9BIJZmviKYlrb3zqBkGFrUHyN29Fvj3ZCijN2jpgeYafzrBrHndY9s
         UbnA==
X-Forwarded-Encrypted: i=1; AJvYcCV5xHEkbm+3kDp8/M6vqX+FELNWvKT+/qw/b5ZIMHiS+U8Ngyo1s9b4kkd/fu3hndyDpceSGBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOHXm7rr22zhrrZ7dD9iq9JVE/goW8vx0ysmdJPmvbYM+wQBxu
	WVaDLkEP5YAjBGQERdLutV1uEjwZv+jfVyd8Vm8TChqkbzWeasbF
X-Gm-Gg: ASbGnctjaWPiH8B0+yKu6zBAm4V6E35xuDCb0ojr48wSLpSJrVC52ayLlPNz8tAGqmT
	kec4RBXDz0wOyhPso5BDo7MhdEnre1H+QYQxZeTIL93zdGXqV13ABi7NzvOmOxVK0vvpDMz5t8N
	K6UkD7zzYfYaF9fV0Ywh7Sz50X0Bqfc0AQh9zXQx81WwcugtL/p0INxbyaTScEE2izDPhd/Ma1y
	W+bchiKURJyIYeF2W9BAQG/bCeueWcSVSi5axUY8A4jg+HrDz0ryjzU+KfRjAopGlmudV/vzjK+
	8BrgQm5ah39LusEVFAlw15zKeZOAvO3tm3m/e5vWwaG911ylcHj2zW5YVbpjC5P8kwqheXlVG1A
	w2g==
X-Google-Smtp-Source: AGHT+IHSOsqRr4daz5p9hC5Vsf+JYJ2MOE/hismBEzTp5lCHRPmrczFhHyfnEXYJglSoM+41Ot0Ehw==
X-Received: by 2002:a05:6402:4403:b0:5ec:cbf8:ab28 with SMTP id 4fb4d7f45d1cf-5fb70c56ce8mr3013502a12.22.1746545097805;
        Tue, 06 May 2025 08:24:57 -0700 (PDT)
Received: from [192.168.88.252] (78-80-121-182.customers.tmcz.cz. [78.80.121.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77818f02sm7679200a12.37.2025.05.06.08.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 08:24:57 -0700 (PDT)
Message-ID: <50b641a0-50d3-448c-a6f3-b4e143e87c08@ovn.org>
Date: Tue, 6 May 2025 17:24:56 +0200
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
Subject: Re: [PATCH net] openvswitch: Fix unsafe attribute parsing in
 output_userspace()
To: Eelco Chaudron <echaudro@redhat.com>, netdev@vger.kernel.org
References: <0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 4:28 PM, Eelco Chaudron wrote:
> This patch replaces the manual Netlink attribute iteration in
> output_userspace() with nla_for_each_nested(), which ensures that only
> well-formed attributes are processed.
> 
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> ---
>  net/openvswitch/actions.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Should probably add a Reported-by tag referencing the report id
and mention the reporter in the commit message.

Otherwise, LGTM.  Thanks!

Acked-by: Ilya Maximets <i.maximets@ovn.org>

> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 61fea7baae5d..2f22ca59586f 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -975,8 +975,7 @@ static int output_userspace(struct datapath *dp, struct sk_buff *skb,
>  	upcall.cmd = OVS_PACKET_CMD_ACTION;
>  	upcall.mru = OVS_CB(skb)->mru;
>  
> -	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
> -	     a = nla_next(a, &rem)) {
> +	nla_for_each_nested(a, attr, rem) {
>  		switch (nla_type(a)) {
>  		case OVS_USERSPACE_ATTR_USERDATA:
>  			upcall.userdata = a;


