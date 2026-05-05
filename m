Return-Path: <netdev+bounces-284426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICECNa/5+WmNFgMAu9opvQ
	(envelope-from <netdev+bounces-284426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:07:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B62504CF11E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C833D30198B4
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8C447DF8F;
	Tue,  5 May 2026 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybx9IKDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3629847887A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990038; cv=none; b=I96TNx2zJpcxnj3tlasxpny2i4Mx9l00bTbltfbeVjyiYl6j/jVq1DkxY8lepEYs21QQr9bjeodBlmCFMTO9Gg+Xz1ZLAFLCzjNuyzlUcFcDyAMbsOI5ijo+g4yrouzuOEQhgJbJOrB91ts0WbZ/nKEIML5gMMDKy2LlZcP/v1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990038; c=relaxed/simple;
	bh=sO0X5qvLJf8xDKmxIhHhryP/fBuODumlkJiplhsuySw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUiezYO4NcCNW0lHIYQ9UPJOMlVuL5cNd2bQ1fvd8WIn8a9zic32rQ0cjn+2AkhSPuf8DYN4qf43GVuyeKHjglQePpLKCeU7oRszlU9/5VPMY1zXKPQYGqnVy9lkR1/DONmoBcY8y9D4AG1ILxQUsxUNmEre36ovr3/Qw0TgDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybx9IKDY; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-651b4d09141so6444460d50.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777990036; x=1778594836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyOdi3DzWBr8O0Jx6oKKUallneRee3ai2LfMOSpZ3Ic=;
        b=Ybx9IKDYvA8dB59PZSysquFDuuoV30zI8KztO8G8gQww5KTvdss06msWuv9rXPhv7L
         W6M9iz2YUQhkxYxBo+0EHogHm4FwEsolrQtLvmORF8m9vqr+BDWKv9wTXYyP3XUnpPMI
         36RT8HjS/MstWdgcWFKjHZRqF5i0zm8/rRcc6e5pifYEL2Y7OtPFq2XumFSXIIoDGUMw
         U2kaBNJpCGtXaSDZ6mstZ76QwT8qANeMLOBjII0lXbvyTB/0RFNIdgnf9ieDKwld2PqO
         H6zUD5b++78S74I++T6HqENe/j3pOJVge4MFlnFjqBo4lZEqFB7Ep2P0i6uJg8pyU4SQ
         EYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990036; x=1778594836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyOdi3DzWBr8O0Jx6oKKUallneRee3ai2LfMOSpZ3Ic=;
        b=K0U7zmRuDFhMGp3VnT0Z/2YZ9tb4uta4JSkTvexOnNwV7S9fHorUildgvw2naQAQsB
         fNLEfjmJuGBkd8s294Gf2HIrozsfAR9PCLBvqk0W/tmL7AKJx6L/t3vZ5Cg+Y6biK3EV
         6cWgQqHxcdqfqcIZyDik7VmZPsNTLQsNmrwVZdijuAoScwo3SMa9SxG5n94JMfOL1YMZ
         +KT/jkwV11VceB3m93Z04qjhqlcSlxWY93jk4XrMjXm8/pzlhhqhwlMehVDIE8v1gaUK
         b4H8mqj7YCEQGU+ItlyCKWaRz7UmtdT83WPYzkkmOUxfj15FtB1/6NklFImw6phIg02h
         EGhw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZMipAVumbQFH9SshZit0LQvq+DKzjirU6BCp70au0d033kKgnIi1XbCoa9PsmzsyF9AIN0sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UkW7VluUC7RzmJfpRPDjQgMtKVADGi946Yej7ZCjQT45pvEH
	jEZIyU3I4nvtxr96dJ9CU+z+Air/OWrv8HLPmPVgslisW3ggseJk/kQm
X-Gm-Gg: AeBDietNQ2YuV4GTKgGOMARU90/VFSH6wuWJ+pI3mOyIZNr4eP8nNOril4onDJNd6fg
	7QWLMHkI2VKHtD0yKDmtuwAoihjKU3alGoM2lz9BRPqHHyuaMVITBSVbHyCAoZ5nMDM2T4ppoS2
	OP4Yy/7P2ETrWPaD6oX/TGolj/7YTBKne8sw54zXT8o41WWBH3/PryqK6kqlAgo9MQ2TnLVfJ1n
	9NCUfJYfoT2b50kycubV/5OBrcu63PgP7eXlAZKcpj1fdY+rVicvwe8IUTg+h1I3/Zs0Grzdthd
	RJX1YToE+w4R8RRB0WixM965EU1JghyhWdytHwoS4bpE5FkM76PYhexjtdAGWOdOQCn9uJ+FYDI
	/XVfsWhjztUodNWKYHSef2dO66gJwq1uBP7/6Lur0CzIOzMTfVGVcGKEBb3tAqwg7LK39/b5UvB
	SxbbIWlj5MTOCTzlggwg7yzHmvjOU2AMIEMvbUXqz+B1gjVdhMaxN8ZWC/Jftsad3OsSblgWD/p
	7mr+rXnt4h4RCBqDNrIp4tZJA==
X-Received: by 2002:a05:690e:1c1a:b0:650:26c1:ee84 with SMTP id 956f58d0204a3-65c67f4f51bmr3408147d50.11.1777990036099;
        Tue, 05 May 2026 07:07:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:e656:d544:da59:2c22? ([2620:10d:c091:500::1:d405])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d0702aasm158321576d6.43.2026.05.05.07.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 07:07:15 -0700 (PDT)
Message-ID: <12f11785-0bd5-400e-8acc-f47b92271e33@gmail.com>
Date: Tue, 5 May 2026 10:07:14 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weibunny@fb.com>
References: <20260504230056.917415-1-weibunny.kernel@gmail.com>
 <20260504230056.917415-3-weibunny.kernel@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260504230056.917415-3-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B62504CF11E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284426-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]


On 5/4/26 7:00 PM, Wei Wang wrote:
> @@ -281,6 +318,34 @@ operations:
>           post: psp-device-unlock
>         dump:
>           reply: *stats-all
> +    -
> +      name: dev-assoc
> +      doc: Associate a network device with a PSP device.
> +      attribute-set: dev
> +      do:
> +        request:
> +          attributes:
> +            - id
> +            - ifindex
> +            - nsid
> +        reply:
> +          attributes: []
> +        pre: psp-device-get-locked
> +        post: psp-device-unlock
> +    -
> +      name: dev-disassoc
> +      doc: Disassociate a network device from a PSP device.
> +      attribute-set: dev
> +      do:
> +        request:
> +          attributes:
> +            - id
> +            - ifindex
> +            - nsid
> +        reply:
> +          attributes: []
> +        pre: psp-device-get-locked
> +        post: psp-device-unlock


Should these require flags: [admin-perm] and/or psp-device-get-locked-admin?



