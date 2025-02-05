Return-Path: <netdev+bounces-162953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82EBA289F6
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E5F1885297
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B69222B8B4;
	Wed,  5 Feb 2025 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="CW08jZiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779721C19F
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757576; cv=none; b=YcutrOKFFoHLr7Tyxe6m3xLOYnNPcA0oXd9i0N+9hkfExF8TsFuSfWvDVh5wkZEyEqd1cZtVKGMSjm/SDACCrLn1pQ7rrAfDqMHvs6Obe+8W+oQllhVTBI94fhpj6AfaJPQ8DHoBe8Pom37JL/jvVaPxdZ+XuCVC/MihtzlV6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757576; c=relaxed/simple;
	bh=Kg08dmAcHa6DbTzmlmuDOnHgGPNKSYzIntc0ykLXYEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aROqg3ddOU3kgxImwt0ow26aGUksX1uT7WBTqp+lZ/uDyfu80NRZLMqpdWK3cbtZMGXNOw8LK5IiBSVI3hwYN6pY4LuVHIzDtrbJ1IMm5lY6AfcdhEliwyh69Jcvo6EZaJqQrg3JRhCpB+cUZcNv0IR4fEakSioHASg66Vt8COw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=CW08jZiD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaeec07b705so1120957366b.2
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738757573; x=1739362373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTot+vU9OR8KI5U7bhFlmEjwjQsZz/60F6Eo3Sk+vbE=;
        b=CW08jZiDye0iX/Ggm/YefD8kjzlF95LviIXNqkt7G4Os+LgGW9wDv+HyEixsSOLXOs
         jfFnsejBskffVuP47ExuqW1lwSUWK4y1ZtSLDnYllR1qA2NFTrtYSzs0p4GYPec3iBIk
         mNMa81ISQDsIRgZP1YuHjGJT18rF4Z7WmLphBrvpC18k4xGYMmxAHxx0UDp+Idn3l/8P
         qX28JihnpTanhdP0dleSJLz2S1enaUg9M7PX4y9QW/hd0r7Llxy/SGbBKo7j0+zkezfd
         9XB+RPEpVmjvUtzFPwNEIXin45DliuRx0A/85vffcaLC4jGvobnaOWpGbUY/EkCH8BY4
         sonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738757573; x=1739362373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTot+vU9OR8KI5U7bhFlmEjwjQsZz/60F6Eo3Sk+vbE=;
        b=e5W+mlcA2QjbHV0pQCLVVXFVsnXOiBEB33AD8UrS8lndqbq5y1tbNt0RbJvC6D70+5
         r4LZ85pVibGsz3NUlwtHgC5kSjN34Dc8j5z57HBBdjjp694lKb1PWad1ZYLT6WdpVDhI
         tgL5GwJEngbxpqqnK78NhoJ7Rz1uldnhCH5Uo2vi4n7QrCSSY7S4ZHSW1JGTBiHD+W0U
         Cgm5XXBiekSyfhoG936aOWTr2d9Mm8e1rlY/1mOhjXTx41pNtmBiQj6orIzmnJyvgNbF
         5MMA3stJlQibtEK8mzabNQmFPKuGjfKizQPnWtZZXR/cizbcKr7ZftyaV2s7amwIvyk0
         f9ow==
X-Gm-Message-State: AOJu0YwfI7lIKDkV8MKJf30UgjHBZ+v73fR3iI+XyFnZMkTZ6YAjHSto
	yzp8YXdjr3pylqXAnaubEOnfRKMBMj33BCo5YlP8xKqfKMfWiyRmp/FitFpHdcQ=
X-Gm-Gg: ASbGnctwQ2otX22TpF8A8MzWjqF77dpxTT36dpIDhEV55ICzTaAsK2CSGMCXf9Ycjk/
	9zH3Mac/W9pHP4HTO//+03oAAuUmsfxhWETBKXLovOfJD/Qei1gKUZNgpwl3kwOODuVTWeAE1kR
	O3+JEf/Ll19WFnX4B2dG52VUlQcW0WutqLbPCMdlmpJ571S2JAnXnxIQiZtsspo/T3zwdD45lqY
	OBZvMTGGPi56wvj6mCQUNatonXLtlIgyUeywo6Zw5jKWGQMlXRPaS2w0rAQrOgNxRbW//jZZn5g
	CAGW7oPbaZknXe7aZXhlXpHt9P1f2Bee441zJvNtttAK7K8=
X-Google-Smtp-Source: AGHT+IHFMazR8a0zAGxZvSijw6tKXqvySGxxQyyJulHLVrf71p/c1k4SEOfhWJLvGgeppqlXVujXFw==
X-Received: by 2002:a17:907:6d05:b0:ab6:32d2:16d4 with SMTP id a640c23a62f3a-ab75e3464eamr231483166b.56.1738757572587;
        Wed, 05 Feb 2025 04:12:52 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a56fbdsm1103157266b.179.2025.02.05.04.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 04:12:51 -0800 (PST)
Message-ID: <7fcca70c-9bfe-4fd7-b82d-e21f765b8b87@blackwall.org>
Date: Wed, 5 Feb 2025 14:12:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: vxlan_rcv(): Update comment to inlucde
 ipv6
To: Ted Chen <znscnchen@gmail.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@idosch.org>
References: <20250205114448.113966-1-znscnchen@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250205114448.113966-1-znscnchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/25 13:44, Ted Chen wrote:
> Update the comment to indicate that both net/ipv4/udp.c and net/ipv6/udp.c
> invoke vxlan_rcv() to process packets.
> 
> The comment aligns with that for vxlan_err_lookup().
> 
> Cc: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 5ef40ac816cc..8bdf91d1fdfe 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1684,7 +1684,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
>  	return err <= 1;
>  }
>  
> -/* Callback from net/ipv4/udp.c to receive packets */
> +/* Callback from net/ipv{4,6}/udp.c to receive packets */
>  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct vxlan_vni_node *vninode = NULL;

Your subject has a typo
s/inlucde/include

IMO these comments are unnecessary, encap_rcv callers are trivial to find.

Cheers,
 Nik


