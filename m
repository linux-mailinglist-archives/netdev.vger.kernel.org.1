Return-Path: <netdev+bounces-228082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D98DBC0F93
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 12:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8C884E262B
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 10:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE2C2D8362;
	Tue,  7 Oct 2025 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU70vLiO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581025393E
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831936; cv=none; b=aNBMDYq2eIjp3/QK2n0/yZd7vc5YiungsLPO+dBoieSgm5l5lPH7KNrMquH0AChHLx+mPRJGixVvjBtPgmBf8iKgPpCgfIL7glTeIVcnXkSP4p/dSwmULqPzPZzyHWRvTeiKEG7dHNtSg797SeeolJhXZCFJ/IESOpUPtn0QvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831936; c=relaxed/simple;
	bh=K5ih1fcLdd7FAp/nTzxWpRzg6pbB2HICCQemr+Ina0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUYiOrmlzhGOsWOCBjKUpQhL7THTQWfTa+n56qWGutjOXgpWbixolciOncYRwMDVoVatykK6ui79VIuwwGDyKxzzjGK8D3JbeWxBQH0o3aBkQWXF5dY/bAucBlKnfLO3rj8D5kbCMrT2YHI1aCb3Mxl6jAfFlBz99N3Y4nKgCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gU70vLiO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759831933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQl2T7LiPKb6GyAjuTicXUHe3bGmDDt+v34reyvvw/M=;
	b=gU70vLiONMnivq9OeY3bOdKwROx+EG0p7aHbQd+i0ypI0K8Epx/3/0YC4DAaksMrqvWTOr
	WKjrB9SGG86peAjtowwyuh4IZ7oxxI+fZuH7ylPgy59ZmqtyNfljb484AF/54mBxWWOlw6
	TSUWMX+laJta5vHomiSO5ax+5SII7M0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-uytOQXNgONyLNJmxPuHOtg-1; Tue, 07 Oct 2025 06:12:12 -0400
X-MC-Unique: uytOQXNgONyLNJmxPuHOtg-1
X-Mimecast-MFC-AGG-ID: uytOQXNgONyLNJmxPuHOtg_1759831931
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f42b54d159so4833246f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 03:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759831931; x=1760436731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQl2T7LiPKb6GyAjuTicXUHe3bGmDDt+v34reyvvw/M=;
        b=wD+x4p+EagDUqlVmmpOTa69QlyTY37DwQ3OJJwD3DzaweI19kzwcI9/xciZSxVRmdb
         getDmvkaKJplarAt+jLkpQQyWnVHJBszzaTJ4GLvCkd6/dPxy10psQ1WgeXRRmYYOwMW
         esHXfrZtWviayscXLFnHowRRj/exOwI5zE+3gcBQDwW9HjOuEYJEAu+V7b/qTA8vZAQX
         Rnz+tIh+wPzw3RgbfujJIgOUjuc1XIKjcLMTUyIxhHxhsIw37eoDLkmcDb4rlwawetGg
         yttn1Ke5422va6xOTYWuTcdVoDSsBSgcimKNQ5ldkRtz03r5a9uXi8Xbd1LGEIylCcwx
         8Meg==
X-Gm-Message-State: AOJu0YyHkEZtlT48sQuZtA/P2xw1dXECtSmebY9Sl7GXh9r+PZeHuEA/
	3XxfhVcfeCZqFQhEBYcZc7O0frcJVOF2HHAZsFIYm10C0ZgFGjMlelF7PA1jD8lM/iQnaxXND7h
	pNGEDmdkqwNAPf++7wcpmlcxUV3w8YHwLPkp9LVBFRR10WPecR5EzdhUklA==
X-Gm-Gg: ASbGncv4/Xul98GJO+2NlPw8bZEdGEDZXYFAjzJOzK/9xVo525abt6Rdagao0rJ3wWz
	vFVkgRqOf+Zo3Pc3KKh5XfuFGrJ60p25VCapVultXIaEpAfDcYz5OjxxUEJtJ28g9XMclSpEbYZ
	fEQYMEHydAAMBFULKibhnOR5/Dh/BPlbBlsoal0JVzEBORg134DBAmfn+p+32iN7YUd8pcAXiTC
	9xUVErREBaRlMyAPVtAvkPvIHxUy9OJAZOToLhvhGq7CfAlQlwjdwZaR0DLJSYbrbk6KY1Qn+hP
	0t4hHolqB7QKM2kK1vY0Kkr/tfP/kMEKr3wlYX06nY88yx4wrcF32ocNvhCoNqgAgnzN7d8idP/
	PmYlv4Ob/Idg22aKghQ==
X-Received: by 2002:a05:6000:26c7:b0:3ec:4e41:fd86 with SMTP id ffacd0b85a97d-425671abb56mr8897439f8f.50.1759831930938;
        Tue, 07 Oct 2025 03:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElT2zv84PkTMQb+IKMagVR2YqjOOjuYvYqUPHGOQ1mK0lXAffA65VV2mZwTbjFrEfS+7DMjw==
X-Received: by 2002:a05:6000:26c7:b0:3ec:4e41:fd86 with SMTP id ffacd0b85a97d-425671abb56mr8897407f8f.50.1759831930499;
        Tue, 07 Oct 2025 03:12:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6e1bsm25083049f8f.8.2025.10.07.03.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:12:10 -0700 (PDT)
Message-ID: <96ab4322-e27b-452a-8408-d36c3e209714@redhat.com>
Date: Tue, 7 Oct 2025 12:12:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net repost] selftests: drv-net: make linters happy with
 our imports
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, petrm@nvidia.com, shuah@kernel.org,
 daniel.zahka@gmail.com, willemb@google.com, linux-kselftest@vger.kernel.org
References: <20251003164748.860042-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251003164748.860042-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/25 6:47 PM, Jakub Kicinski wrote:
> Linters are still not very happy with our __init__ files,
> which was pointed out in recent review (see Link).
> 
> We have previously started importing things one by one to
> make linters happy with the test files (which import from __init__).
> But __init__ file itself still makes linters unhappy.
> 
> To clean it up I believe we must completely remove the wildcard
> imports, and assign the imported modules to __all__.
> 
> hds.py needs to be fixed because it seems to be importing
> the Python standard random from lib.net.
> 
> We can't use ksft_pr() / ktap_result() in case importing
> from net.lib fails. Linters complain that those helpers
> themselves may not have been imported.
> 
> Link: https://lore.kernel.org/9d215979-6c6d-4e9b-9cdd-39cff595866e@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  - resend after net-next PR was merged
> v1: https://lore.kernel.org/20251001234308.2895998-1-kuba@kernel.org
> 
> Sending a fix for the driver's __init__.py first, if this is okay
> with everyone I'll convert the rest. I'm not super confident 'cause
> my Python isn't properly learned.
> 
> Sending for net, even tho its not a real fix. I think that getting
> it applied during the merge window may be okay? No strong prefence.
> I'm slightly worried that merging it in net-next after the MW will
> leave us with a release cycle full of merge conflicts.

AFAICS linters are indeed happy, and I agree this should go via net, to
propagate the correct style ASAP on both trees.

Thanks,

Paolo


