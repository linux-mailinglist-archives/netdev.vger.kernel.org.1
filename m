Return-Path: <netdev+bounces-227354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D5BACFF1
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 15:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862443B73BE
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C1B23507C;
	Tue, 30 Sep 2025 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjPVTuqI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FEB2F6167
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238211; cv=none; b=ffX8rdmeEgFFHnInZQLwicbW3AuYd7hu1BM0NmFict9CEuDvpyhNZoOFR/30dJf/Cqp9a70xFLBktum4w2T6O38Gmyr6gpISfUAFLmNmqRqvw8JKxgp/bNTp6xtU3JvNx28e0s5JpdNrcnKRLkodjT9gmuwIvtdtJW2xEtsw3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238211; c=relaxed/simple;
	bh=JQdYQFztlTixlakaP0CYLnqIVCCuwGWr20KPxAr+N/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbdJs1SEHIPEwTdQ//+GTg01cVCaOxEp0/BRr9JaxlFAapxNk9smFiuif1K2+Q7gk0DwrRUyGpka+1IH9a04S6sOqx7aIORNizVAbvkPTjupn19ARX31fw8O5+Qt5D2CHsnSKmejrbrgBmuu6ETXLtMH6/XuGsTVKdwdWQ9S0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjPVTuqI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759238208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQoDjKHqpRXNqsixILAYa6PmTwHHRUnWjoBb2MDJWeA=;
	b=NjPVTuqIpyjt7+Q98d+3wKK6TieySJpB4Qm3VzcKrCYVqmcFrOfEUymmN3AkdrlORnz3H3
	YaMh+LeHUuoGSquYLlvyd4TVBdxTLq/ErFTEZificYLWQhC0UyL7m7NlUMGui5wE8kPAJm
	wyUf+HpVglmjlCxqcAH9pEVcn1FBNAI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-6-ZsmdIwPB6aIdAD4ylXDQ-1; Tue, 30 Sep 2025 09:16:47 -0400
X-MC-Unique: 6-ZsmdIwPB6aIdAD4ylXDQ-1
X-Mimecast-MFC-AGG-ID: 6-ZsmdIwPB6aIdAD4ylXDQ_1759238206
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4d34ff05so13640015e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 06:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238206; x=1759843006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQoDjKHqpRXNqsixILAYa6PmTwHHRUnWjoBb2MDJWeA=;
        b=qCjlsEso5ecgFcs7TH6TfoAZvxVCQB+eVy8GR3WJuJJ1Tv5iYJyyJYRbbo2C4m0wo1
         zSufNZcxzyHdVU2mocUN/AK4s07q4obcxjkFfLA3XxD/NsgGRMcLrTyrMtJYY6b4gN8s
         gGGkAxtZA8Igim5bdl9WRNU6eQf+RF8PUjWJv/mKUEgC9zHGfCWjmFI6OTdGBBqYwCqW
         MeEnwpbyowQ2Gs+pmYDw14flH8I47mBiTHXhARDF9cC6nLH3OjW2BMd00tQOCluRWpo8
         YCnML78vEcRpaUZUH8nOVlOjpMi+EG/CKKDzTW/nlre0sNgylBgBzztfM8t6hzi5jYkA
         0eXg==
X-Gm-Message-State: AOJu0YyRdshZCFn7x9m+mW1oAICrzgBBeWzSdcJ/0/ZP/SeWguo6hEjL
	rwsgBb4iudoXuqsEpIL/4kNaNOY8THnZkPevOsxkPSg0kwaCV2qVJApxoKDJCljGMNJPLpoR+dD
	lYxAYDvhF3h0Reo4ENJ0ec1C0a45YC8RvXanfGTfopwBZsrIGgh+cfMkI5A==
X-Gm-Gg: ASbGncub5/bzdik8jPvf6yk20C2lAic0OGxQ2ofwckUewJWo0Ffn3jzjjAOBcNQX3EM
	sfbmd0WyJ3krd4rhrs1zlKg6t3WQo6zkS30PqwpTmdER6WueCWwqV/7F1dk04RREyyFJvg7RR4s
	Y/whzjMA/WmSCfD7kPive7OBo9zDPva3G92BHpvNi2g6WovZSawr5q5pJEkSjHHsczMi8DL8LRW
	ikpP5dA+ZS3BcbZP6JMJpG0DiC+cMj1CE0CoS++F4ougmi8+7axOfwcl9524NmyTFfUhOEfEhze
	yxqJRdYxQEQSGdVkGYtwE+MDetvN+IjNje71tzgsGvSd0EMZYtCWZoBFkDbOP0uHMvVWi6/KMLo
	y9nJXaC5FeRpHV8fXIg==
X-Received: by 2002:a05:600c:1d12:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-46e4246ca96mr135448905e9.11.1759238205799;
        Tue, 30 Sep 2025 06:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu4P6oMDuFdG/0zr30Eb3WqTPE7tzXx6ivKJ9I6+IyFkjRGoowgd2u3GDdgMwD3iM2gvpqRA==
X-Received: by 2002:a05:600c:1d12:b0:46e:4246:c90d with SMTP id 5b1f17b1804b1-46e4246ca96mr135448615e9.11.1759238205387;
        Tue, 30 Sep 2025 06:16:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c1d8f36sm13788155e9.2.2025.09.30.06.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 06:16:44 -0700 (PDT)
Message-ID: <9d215979-6c6d-4e9b-9cdd-39cff595866e@redhat.com>
Date: Tue, 30 Sep 2025 15:16:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/8] selftests: drv-net: base device access
 API test
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, petrm@nvidia.com, willemb@google.com, shuah@kernel.org,
 daniel.zahka@gmail.com, linux-kselftest@vger.kernel.org
References: <20250927225420.1443468-1-kuba@kernel.org>
 <20250927225420.1443468-3-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250927225420.1443468-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/25 12:54 AM, Jakub Kicinski wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> index 1462a339a74b..559c572e296a 100644
> --- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> +++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
> @@ -13,7 +13,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
>  
>      # Import one by one to avoid pylint false positives
>      from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
> -        NlError, RtnlFamily, DevlinkFamily
> +        NlError, RtnlFamily, DevlinkFamily, PSPFamily

Side question:
There is a consistent false positive ruff check about this kind of
change (with the added import being labeled as unused even in a __init__
file.

I'm wondering if is possible to explicitly disable such warnings?

/P


