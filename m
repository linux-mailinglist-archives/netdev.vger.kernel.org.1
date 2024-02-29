Return-Path: <netdev+bounces-76231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75F586CE72
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DE7283946
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A111516064D;
	Thu, 29 Feb 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN9TZ2cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C35160643
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221963; cv=none; b=lAMujwGWHmfWbW0rE3oYYHomJc48oE9xqmn0f86duimBMFvyD2gPSmIGPSycl0h3YEzE9km4fqZ0vSNPJIa4kQqh37Y0ksqggyg+mqu9Q1E4S+nzdLDpoSU1LillL4EaUfGzzs92iTFid+bvW5FArdVwr1t+uwGh+Tw/wvYo0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221963; c=relaxed/simple;
	bh=rCIKIrGxuCFKWDSA2TTIUOTjhfH7hdlRM8DeCp4ASjk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UwMJDCqdi7oIPRm10Exays7itMr3AsERMEl17WkHYfP+R8nFRb1FmcrCJv83IyxDODmf6f8bHVuNybmb90raL+WNLhFeO5x1bs7MWjvPB4LphvGBDvWM+Dvu01MHA1eJia1ybQShaVOeSKkReEIdv/2JDqn3zUs1B7507FMEORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN9TZ2cz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412bc3350d0so6232175e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 07:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709221960; x=1709826760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rskQzjujSkCnvrVIU58F3xgIFNIx+Joo5bhVFSpHnNs=;
        b=KN9TZ2czT4E6hKV8ljlDLeAFvoBaLzUC+Vb1X3nkoepEG0xMHOs63HLc77EqBOsHTJ
         Pu+/2aRkgkzLjZ9MkmU6+4agqPSw+zaWhyTLvHc4fDeaqcFw7+FCC0GtofemvBCG/HOE
         WIcXskVChXFhOWoynSy+2H4MkCDKSMBU6iv0ALDMksW1hiDmID+LzgOSZ82osaX8yvF5
         SnPJvRwGeOFMe62Yx2jfcqEhQXtn9/TbiItZXnCzcApbfcM4hrEMzRVAo8pKPuXBqqch
         8yaCbSY9+d3/9TytQTm6Y7Yd3zQ/o5lW09PDvh1MqWgDPc7kmJQl1n0c+LlsiWkzfjcT
         VTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709221960; x=1709826760;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rskQzjujSkCnvrVIU58F3xgIFNIx+Joo5bhVFSpHnNs=;
        b=pw86IIZBo36kVGdkDNpIPbcYtN+AH6HDhwPiNiLnYbWwql+mlzhoNPDM24IvnyBo1X
         oLxqG2S3CFaOjaMKl6h+wBvEYfDmbIAOP7Ul6SvA2t6g7Jy34sZoamOlDE5O+o/jAkov
         qE9jgOyI/qHOPAMvVL88cZCu+ajA98wYg3XxGHeOWZA2wRMLRUQda3k80/Tq0FzVPVbN
         9PWjsila8N4lA7QDAO0JuBakjKNy8i2F4Jy3Kkjw/n9IYgC+lJ6bgKFyT7c1m7WxS2/i
         vuEqZUgfKVJV6wc9iYDGmATY7yuIqAhmC1SNsCrsIjEdZBU+LKakkglflEBB7kX7N4QR
         c+bA==
X-Gm-Message-State: AOJu0YwjlgtmYC2dgZQ/WjujKiqUcXjpcpGwe6QZ7iK7syXLoXozYigS
	/c1MH9hGInHADi28k0+bFHdqvwGLm4zFxcsxEDVwHHjsoATIEYK3IwKtNH2X
X-Google-Smtp-Source: AGHT+IFSBRKfDmf8dCawua+Rk7jeZlz7d5wm4MO5grVyNcVcs7ZOE4Qp4Tis0Dl89CUpsvhMfDnazg==
X-Received: by 2002:a05:600c:310b:b0:412:ada8:85a6 with SMTP id g11-20020a05600c310b00b00412ada885a6mr2203897wmo.4.1709221960071;
        Thu, 29 Feb 2024 07:52:40 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00412a0ce903dsm2437177wmq.46.2024.02.29.07.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:52:39 -0800 (PST)
Subject: Re: [PATCH net-next 1/2] net: adopt skb_network_offset() and similar
 helpers
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
 eric.dumazet@gmail.com
References: <20240229093908.2534595-1-edumazet@google.com>
 <20240229093908.2534595-2-edumazet@google.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <78861e3e-be81-a279-6a97-c9cef85f8205@gmail.com>
Date: Thu, 29 Feb 2024 15:52:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240229093908.2534595-2-edumazet@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 29/02/2024 09:39, Eric Dumazet wrote:
> This is a cleanup patch, making code a bit more concise.
> 
> 1) Use skb_network_offset(skb) in place of
>        (skb_network_header(skb) - skb->data)
> 
> 2) Use -skb_network_offset(skb) in place of
>        (skb->data - skb_network_header(skb))
> 
> 3) Use skb_transport_offset(skb) in place of
>        (skb_transport_header(skb) - skb->data)
> 
> 4) Use skb_inner_transport_offset(skb) in place of
>        (skb_inner_transport_header(skb) - skb->data)
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc

