Return-Path: <netdev+bounces-193575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5ADAC4927
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6BA3AEFF3
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2619E1FE455;
	Tue, 27 May 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEpe7VGI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D21F1905
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330258; cv=none; b=tv+fdWyvPJ9prMGP+KHvrie5IZBpehRUQ6FOWWDy0dlLlweduCY2wbTRrtzJR7M5II0TA0Cga0ORUK4F4bOGjyIAX+7F4SVhcsdiKj+FkQo4RqkJ2C0l1CNGvil+Z1XBQQ+XlfbQy4khct1i67sT5zLcNIwcqiwHquhHXTX8wVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330258; c=relaxed/simple;
	bh=c7fLyJFyUEsXGupJPUcA5deevABmi1JPgUKpiDGU38s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjcu8ZtrrgRNSx1Jwa+mdtkGXLh3W+i6jW6VYKiTzJxTFf+dWG6s+5wgQ5EEojLqHBq5e5KzTZqTOEyIO2ybfSXzA+IdidJ3PqrJtzpk9I0zLIYtC+jf1kypR773bBzWZIJ6oHq6e7w6itgKdtmZFSzLN6toB2Y1eiOgu2hMtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEpe7VGI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748330255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFoZttK1qFQLLWq/vRTqOPjL4JDl9U9JL7VK0ppo1m8=;
	b=DEpe7VGIjiW3Gs9XOhpDpJZRe6WUQyUHOPyfKH8PpIE/plFOVyKkLP//pjWWiWeoebUQwb
	r/z9wrSrk/hMCuXuMPmlE6qOMMVLeYuce4FCPmyT4EuHLimh9eGIfK1BNE7crUNiD/7Ulk
	5HIqXuKzUQQAPlo1bU6VlCS6zT396uY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-mYrGTIvvMX6kL9U5YIrQhg-1; Tue, 27 May 2025 03:17:33 -0400
X-MC-Unique: mYrGTIvvMX6kL9U5YIrQhg-1
X-Mimecast-MFC-AGG-ID: mYrGTIvvMX6kL9U5YIrQhg_1748330252
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so15414755e9.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 00:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748330252; x=1748935052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFoZttK1qFQLLWq/vRTqOPjL4JDl9U9JL7VK0ppo1m8=;
        b=EmqKhP9PivJJpO46OTedOfjNKA9sPC+05Dq/I++j5zN2NWRpb30qt1p1aqCsNG+byT
         rfVkmfC2W97mcCs+BEtkzJASdAT5DEjTE+nH1MLAvuqB9jUyFNME10jjb1E/J45A3RRW
         NlVN7wRxGZHQLcchPZ/OfuXBtb1F3YQLhU1jQE7SvRiiMA+c4v+WR0Wl/JD4ot1OLwRE
         iKsKta7FJ+UjOfiiF46qoQ8xR7Fe8/r5eZ70sorA4cQDKrMyMgbbTVGzj9QSv2x6t0cW
         lhvWtFxvMFLnXzp3H2ESneD7huaQKQphHm3yORGb/tbjrop7UxnYT5BKb9X3J49p496v
         iE4A==
X-Forwarded-Encrypted: i=1; AJvYcCWUgnu6BKICoUFqtoCI8VeZxKG3wIwsDzoK7tATS9+q9ARbehVoXxc9uaE+QtH3SPTgAyLBx5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNanZWccVc7rize1fuVY91F3F/K4vIBN0sjdtYq0OzG5butDqb
	vK7EatchJJ7FRontLGRJdzeb1RDwfhdoVcUCUJtjV6pW4jJDV4zy7LbKHFVZBTGl47FtSSzLV7Z
	gVij4WGm9UBPtLT0z0PaXgL5TWio827akYKeoMazRr7FRoFb9wRE2G3DpubVGLLB3kw==
X-Gm-Gg: ASbGncskp1JW9LiUbzAJucx/yifYSuc4b/bCD5MSoItFFlNbTr3JbbAsVMFFykJp8XC
	WhpycS5On84oGq5paGlbPrOYAqK9VmH4P/xAaB7e06PkqLpIDCSrxa07PAO8IKglkITquT0/Y8C
	FfPp2WA88h9/7TVGBOPuJcv91K0rhS6INnc4lIp/VGZyZE/ccbvprkm1xXNWxC2Fiue8IxLsUWM
	CKEzXsQrKOlqZALGczqZLbvoyoRTVr1FUYnmvqPsb/UOKhHaFj2+fmf2fpETVkmrY0AXIh0RPjp
	WVTPeyQFh86/IYJ/tMirxL0XNn4pXMdn+5lVlBFMpfQ2SqaeYKlieB7RfPI=
X-Received: by 2002:a05:600c:4e45:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-44c919e13ddmr134348865e9.10.1748330252214;
        Tue, 27 May 2025 00:17:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6rjaM4MrEBKpkWOooZj5HtKU+xPTWzAblyNoOT7GHD0DA87EDlFyvauURgtKhnloJkF0iXg==
X-Received: by 2002:a05:600c:4e45:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-44c919e13ddmr134348585e9.10.1748330251888;
        Tue, 27 May 2025 00:17:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d66a2de7sm6100565f8f.3.2025.05.27.00.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 00:17:31 -0700 (PDT)
Message-ID: <12b16f0b-8ba8-4077-9a13-0bc514e1cd44@redhat.com>
Date: Tue, 27 May 2025 09:17:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 26/26] selftests: netfilter: Torture nftables
 netdev hooks
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org,
 Phil Sutter <phil@nwl.cc>
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, fw@strlen.de, horms@kernel.org
References: <20250523132712.458507-1-pablo@netfilter.org>
 <20250523132712.458507-27-pablo@netfilter.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250523132712.458507-27-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 3:27 PM, Pablo Neira Ayuso wrote:
> +ip netns exec $nsr nft -f - <<EOF
> +table ip t {
> +	flowtable ft_wild {
> +		hook ingress priority 0
> +		devices = { wild* }
> +	}
> +}
> +EOF

The above is causing CI failures:

# selftests: net/netfilter: nft_interface_stress.sh
# /dev/stdin:4:15-19: Error: syntax error, unexpected string with a
trailing asterisk, expecting string or quoted string or '$'
# devices = { wild* }
#             ^^^^^
not ok 1 selftests: net/netfilter: nft_interface_stress.sh # exit=1

For some reasons (likely PEBKAC here...) I did not catch that before
merging the PR, please try to follow-up soon. Thanks,

Paolo


