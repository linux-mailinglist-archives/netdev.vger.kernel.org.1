Return-Path: <netdev+bounces-189106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28844AB065D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 01:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C32982B35
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 23:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9414122D9FF;
	Thu,  8 May 2025 23:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5928373
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746745663; cv=none; b=RXHpxzfeRco9jLYr4NiLMZI00XvFmxu7C7Kdw0sqXuGCK4AFZY5iL+Q+hHIpA3rRAx6NvxeCsnwXnJ671cqz0FZqa362qsAJpoRfzmLrswItlgDlUBWD9RToESO6qYY2bEhlNeqEJl6X2+7Cn/nz/sKc3hZm9aTYHFF9ciVBK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746745663; c=relaxed/simple;
	bh=hRp/RZdx3kIzhhF04A4OlIJqGBYxqs9asZkAnoxbw4Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DfvTtmHFF89MOvOi4RZY4P3GnKpAlCQ38HuwW3IcbpuQ0LCYZzczCkYIxfagDFR11uxd/mZimaEw75yIP8Hr03WNhwjDLFu5cQg4KquWFPBWJfpZ6GFCYHJCgaR34eN0HKxRBzbIP6zKMoozgfJDsZUyC/kjJd6VuwyjCZ55esg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad1e8e2ad6bso303981166b.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 16:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746745660; x=1747350460;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDsERyx+sJ3cEeP0v4iT+HMoswTatSkgMSOizPlucqU=;
        b=HT4I7QSjpwOobQcWfA3VxYr5MiitagtvDyEhgje0tdzIPDdKLMjzWZxqc6ZqZzekjM
         2rWlTM3pMqX0lx3GiEmXVxmlQuEWUj6hvHhqULT/JuwNSf4x+sC1BI+juFyQnon8LXtT
         Ty2uzX3cSN1n0SUSLE/2lfjzpuo3QgoqIt3LPDdYZm9E3VHJqeDSABWanChgyCoB4HG2
         kjj4wACSrWQd/2Po0CF3vKHJ5NykeMIG4kH0y3yFmLZQlHTVEe+asJGJ9QB11x+4uTi+
         CC4ilE+XCE/82X/KaSs/v9aLcp3t7qNx5rvvPnND9lMjBsQgm4yinMn5aim2zZzbgQq0
         FPXw==
X-Forwarded-Encrypted: i=1; AJvYcCWNWSRVMt7Y/RSP24kG9dnzuFt7z6X/32YXm/LHs4Sa11qln0yWCmLGt3yq651oL/mJSQiYUKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysMnwgLdNszzesA4JMnl4iul3I6X3pVe9VlIylfYL4tfKi1IRZ
	5GOJVvvXYYlDZxN7GGZjjUaP+6zRU/W92LRIZ0bE4Q3Yn47FSZXd3VxCPewo
X-Gm-Gg: ASbGncuFYbWLEDzjimCtkoy9DtptXH1wzTHrKMcdwF9w5JIgdhlwEBr5OpYkwn4GqXH
	NMJOlm2H4sjR4fHwGwLaAAfYOsxLHSaCqExHqQyC/zYUmKKK7G3hU3C0cla06xqIIdqZ9MFe/5d
	4xgmeafmcNT1xs0Ebs6F2LnYul63o66/t+6CWDWZA9nJxVGIGjztUh9p+hYYTUOHAKIGTHiIKjD
	XBoCClf2ro/jpRGP9TT7jxgZDbY0Je/vk3Az21XsxrFHeUrljOGD1IA3hz7aQH+7EWYWLe6/ghd
	6T4zdvGI32NLZD6OyGA+Np3giHNs1a1sX2/144pWH6a2+VmfqiKUPpfTxQ==
X-Google-Smtp-Source: AGHT+IGq60am4oc9sTKcIjROGKXc1j5CMHXonon6LmLOeMsA54XIRtGbA2n6GmF5ZrTIwpj+ucnQpA==
X-Received: by 2002:a17:907:97d6:b0:ace:c004:b475 with SMTP id a640c23a62f3a-ad21929cb9amr131503566b.61.1746745659841;
        Thu, 08 May 2025 16:07:39 -0700 (PDT)
Received: from [192.168.88.252] ([194.212.251.179])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad219746511sm54207466b.87.2025.05.08.16.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 16:07:39 -0700 (PDT)
Message-ID: <12cd8c5b-d399-4cc5-8b20-d80d567ba0cb@ovn.org>
Date: Fri, 9 May 2025 01:07:38 +0200
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
Subject: Re: [PATCH net-next] openvswitch: Fix userspace attribute length
 validation
To: Eelco Chaudron <echaudro@redhat.com>, netdev@vger.kernel.org
References: <051302b5ef5e5ac8801bbef5a20ef2ab15b997a2.1746696747.git.echaudro@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <051302b5ef5e5ac8801bbef5a20ef2ab15b997a2.1746696747.git.echaudro@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 11:32 AM, Eelco Chaudron wrote:
> The current implementation of validate_userspace() does not verify
> whether all Netlink attributes fit within the parent attribute. This
> is because nla_parse_nested_deprecated() stops processing Netlink
> attributes as soon as an invalid one is encountered.
> 
> To address this, we use nla_parse_deprecated_strict() which will
> return an error upon encountering attributes with an invalid size.
> 
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> ---

Hi, Eelco.  Thanks for the patch!

The code seems fine at a glance, though I didn't test it yet.

But I have a few comments about the commit message.

This change is not a bug fix - accepting unknown attributes or
ignoring malformed ones is just a design choice.  So, IMO, the
patch subject and the commit message should not be worded as if
we're fixing some bug here.  And it should also not include the
'Fixes' tag as this change should go to net-next only and must
not be backported.

So, I'd suggest to re-word the subject line so it doesn't contain
the word 'Fix', e.g.:
  net: openvswitch: stricter validation for the userspace action

And re-wording the commit message explaining why it is better
to have strict validation without implying that this change is
fixing some bugs.  This includes removing the 'Fixes' tag.

Best regards, Ilya Maximets.

>  net/openvswitch/flow_netlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> index 518be23e48ea..ad64bb9ab5e2 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -3049,7 +3049,8 @@ static int validate_userspace(const struct nlattr *attr)
>  	struct nlattr *a[OVS_USERSPACE_ATTR_MAX + 1];
>  	int error;
>  
> -	error = nla_parse_nested_deprecated(a, OVS_USERSPACE_ATTR_MAX, attr,
> +	error = nla_parse_deprecated_strict(a, OVS_USERSPACE_ATTR_MAX,
> +					    nla_data(attr), nla_len(attr),
>  					    userspace_policy, NULL);
>  	if (error)
>  		return error;


