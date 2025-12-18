Return-Path: <netdev+bounces-245392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D1CCCF1A
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A9C300EE4E
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C737A3F6;
	Thu, 18 Dec 2025 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEBSD81X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8337A3E4
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073681; cv=none; b=TLdDYZgdLK+ESBjeVQIW4BvY7RSzt+KmfEoVhK3woCg7kRqgHb/QKrwqhgNvcC/3pu8NNZPxvZ5pW1SVv5xXoITu4N1FAJuWq7y3sf2fto57plfP7Iy5XJ1qGdkCW/U0FD0KFKYU2utXfz8fG8pg9O/QGQbcFpdk+Nja8EOdnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073681; c=relaxed/simple;
	bh=tfGgeolmEeMub3msQoiEs35SHiGJUXuzVfjUZB+vOIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IchV52ORDEhjargLN+n4Nx7VGaInQ7IlR0SEhVb1M/+diBdPGbpGqHT3rGvqZHPfiP2J5lFUcXx69NyT1Gqz3012BkLt7s08iY+GkK2R1ui+n6aZ7vSB5Fosn5Vcr5+VU+Iid68NLdvqsI/2CgNhsfAIM9X8SGmaw6MeSPYV+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEBSD81X; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3f0ec55ce57so536336fac.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766073677; x=1766678477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uuAkrD2lct9S73QpH6jqf1LLFy31o/vRAKZaXLJid4Y=;
        b=SEBSD81XSGg5OusDDrFvmOJ80CDPf1LipzVLhmQK/frzY2B5pJoG7QFIwnhrU7y33v
         aZX33M8ZoZW4enPDTNTNEoOv4pxOZvVFzCdKTql8gnZaXuljEiMnZ7aiy4C4XnKnPzTi
         +NbeKC0sptS24l61zsxkpqajHlq/YSAkqcTPZmvdPRnaWdIurVtMypqPXhbcTGiMTLnp
         vcOuQyj15iTNS1azZopSwbFPOMABnBPRmBiW/0PWB3LpI/zkhxWn/LYZ3rMeXPqBN1km
         xBhUgw7L7+slKN7nfUGTeG1iul3Y6bt7Dl4SElvXZuucG8UtqEcEBgFDHhTqy8j4204z
         VAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766073677; x=1766678477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuAkrD2lct9S73QpH6jqf1LLFy31o/vRAKZaXLJid4Y=;
        b=qPYpLlVXSZxqQ+B0jGxpCVn/8o0/YqRN3rKQFXbsHhlny18Vh0SFn0c+Y2F//TUSnW
         xQw/dUVL/gIyVuazG/qb96y1kTTWr4KMyniUyAKG/FdhCs04hE9BAHwhwtPlfXVttrCv
         ho7RizukReaJQ0oU93uspxMxoLBliGJ1V0XVGzXVvBULiA14HeOp2zhxgUESsAKp8LMA
         3LFOipIm1uFYrNqZmT9y0RPthMOKZzP4qmCWGnn/BXel/JGQR01FrPqZnbwPGQ959Aiu
         SJiovLT2WpZAMMBtRzKbdbkcdwM7RhBfqHYeicVPYj7CnFVE/HGkue/v6A2ZmXhhqwah
         apMQ==
X-Gm-Message-State: AOJu0YwexlxQNBrN/XWbe5sNvjGDEVScahodY3AaqmNj36aVE95AcEgZ
	JRJ44mr8k+sdve4doAMB5xwK4vwcXf5SG2lextQsqlErl97LiuvW5polmYi+pA==
X-Gm-Gg: AY/fxX7lLGoMxrRHQ3BzwvxJrK+dV3IDdqDuCA3QfUmnSpXxbARwYf5x5I4L0IGH9Er
	nOROxZOsoLkU0dBHAA7lPu4FVgncCzmHV7XDYeghUEwpqpIu8+rI4PpnvILVICYVhUChsffKgHY
	XieRCBaU/xhKBmAbPCwJXod7RyvPpVpL6F6y7wNpRrY+vhQZKYNK4Yr/JOXQx0tmuNL89CBezJ4
	BTJkPS8gT5oXYchRWuO6lYKdN0YJ1nX+s5+R4Zat0zmNzU564ZWeY6sK+8JED/fs7H0DNvGqEea
	7h47ikpuW8jh8yMi6uKH/HE9B4tPgv6j6x8zx7JkOu87a2b+n8129Rg2V3N/JGDibu8tMGPGQr+
	R1XYjMVlL+aWEO039vSpEpk/oDBe9dPVDcxMAHidXvOgx+rpo9XjDBZD37Q/67TVVR1ClRJ39U1
	dVvuy+NmZi7b9hH8IHKywCzgCXaxDoQX1rdERQOskOp3dokNYVGwKMOY+ks0sG/mr2I417v+IJt
	90OiA==
X-Google-Smtp-Source: AGHT+IFearGGCMehcaf7l2oGrHLYTG/BJJ+fsXD89fmhah3wKRDfHzTz4sMHeduJJVb5yqsIa+UGaA==
X-Received: by 2002:a05:6820:20b:b0:659:9a49:8f9c with SMTP id 006d021491bc7-65b451ac6admr9680026eaf.21.1766073676871;
        Thu, 18 Dec 2025 08:01:16 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:7186:5ba6:22df:700c? ([2601:282:1e02:1040:7186:5ba6:22df:700c])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-65cff238d6csm1195738eaf.13.2025.12.18.08.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 08:01:11 -0800 (PST)
Message-ID: <3ef6563c-84bd-49d4-a0bb-3dbc36e73318@gmail.com>
Date: Thu, 18 Dec 2025 09:01:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: fib-onlink-tests: Set high metric for
 default IPv6 route
Content-Language: en-US
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/18/25 5:20 AM, Ricardo B. Marlière wrote:
> Currently, the test breaks if the SUT already has a default route
> configured for IPv6. Fix by adding "metric 9999" to the `ip -6 ro add`
> command, so that multiple default routes can coexist.
> 
> Fixes: 4ed591c8ab44 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  tools/testing/selftests/net/fib-onlink-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
> index ec2d6ceb1f08..acf6b0617373 100755
> --- a/tools/testing/selftests/net/fib-onlink-tests.sh
> +++ b/tools/testing/selftests/net/fib-onlink-tests.sh
> @@ -207,7 +207,7 @@ setup()
>  		ip -netns ${PEER_NS} addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
>  	done
>  
> -	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64}
> +	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64} metric 9999
>  	ip -6 ro add table ${VRF_TABLE} default via ${V6ADDRS[p7]/::[0-9]/::64}
>  
>  	set +e
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251218-rbm-selftests-net-fib-onlink-873ad01e6884
> 
> Best regards,

The intent of selftests is to run them in a clean environment with known
settings. ie, there should not be a conflicting default route.

