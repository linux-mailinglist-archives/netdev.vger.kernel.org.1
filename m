Return-Path: <netdev+bounces-181144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A2AA83D85
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F504674D0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA60020B80C;
	Thu, 10 Apr 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXfVOiIc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1C2040A8
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275150; cv=none; b=YmqeGHM2QQYb6M6fPp98nsTnF6TWX9jzuvETg9Dn6I4mbcHvQm7bZQ26Akb5oAQyC1FFDdzQ7Cr5awX0KlMNoYc0HkJh7AyGmdlC9Tomm5vvw5ne5xgtKQFqnprfz0vTLiYqYilUkaz9Iy/oN+3phk6ODdDPZNuQivP4u6WrmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275150; c=relaxed/simple;
	bh=Otb0Z+gYi4l8ASz4IecniQZUANCUkLEol5p4BwhsNOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqSOL1T2wFmazfQb5QRUmSZU/wcTKMVJrz4+lb+frglB/HZfvEvC06dBb/gmToYlFh0CnVgy4a2d77ES+MSJ/ImZvVpQHJPY7hntfVyC0nBPh08XztaJV3rRom3eT1h6wcUhEyeMKsd2jFIUzs2jyKHeUGXZ8h5IBNSeIrk3elY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXfVOiIc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744275147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXi0tiwzVQZe4ibYbY8m/JOv4USn3TLJKodO3ULaiIY=;
	b=BXfVOiIcHjGNcswdC2uq5kT3Ypxg74E5uvvngegQ9zBQujh9JmkKWuLyXQk3FLLyQIUvUJ
	iC9rL9hvNPErzzur5Ewe52wfVtMQfglUZKT7ZUy1iEuqpnleOqarZvLF1savZ1s1pWFbDG
	Aimeg+WwqQVFu8adKGWU4lGFaaYR1T8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-cBWdAvzEN5OulqKjiPCIpA-1; Thu, 10 Apr 2025 04:52:26 -0400
X-MC-Unique: cBWdAvzEN5OulqKjiPCIpA-1
X-Mimecast-MFC-AGG-ID: cBWdAvzEN5OulqKjiPCIpA_1744275145
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ea256f039so5044305e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275145; x=1744879945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXi0tiwzVQZe4ibYbY8m/JOv4USn3TLJKodO3ULaiIY=;
        b=cu5VyxEMpYeagOlrdPyc0kq1mayHVj9PwyCkvNRhLBqOIuvre/Lod25ZFHmKqWrdhK
         mmCwaxku6ze06RWnO5x/9omn43A3rHW7+oxz1sltmswSbdidb0W9EdduA0v6y7Kvt7NA
         60+umOzwHtgmOIQEN0dCRzrLt069vGAbm/DHzhg+1LTTbcjRNL3thOpqd8IsXLC1R1ap
         X11V9Akg6FOwXcoeahxjMMOb6cBTjPKfJuFsmBTsZBEIT/PRjIj2zr6IXMVy+vUFQfzV
         ihSbqjKJU1xwWyzbaTlb945iwYTgh5qEsfAnoGhps6q3ohG53wE9E4uKkG/1hW9KAf7j
         x9GA==
X-Gm-Message-State: AOJu0YxJDFUQq+T0uqAWYUFCRE1TqKwe6uZmjQ0teDRgLyttJo68USVi
	STzAA7IbtjBHZaVbevbQvbpNpibfoAphDWfx5IER1g/B9LI40F9toDci47Ko3VS7bdL8lEAN+Dz
	PzykVUHo+5Vd8Raq9q9RnXetVJemvxNS0jCKjUA6rpnSwBLVBb22XJg==
X-Gm-Gg: ASbGncvmCGIzG64hH6YQgPOOP47SHuIGxuHW+ahnvFGGq1FvyPrTm5kzB2L9POpdrVv
	Tnx2uO9gqdrrSSihTlxXxz0wwMoL1fjlatXj4p5Ysym53+t3lHZOaTZGPCI+LVerVGJmqdv+nnV
	RRdaprSUr8K58rzLIpmyWTxiKSMRoczExSiBZ/Earglqu9fYny/QAVjW9l2zlOhiDJs5+V8UspE
	3Txo+ZMYlQi5LC6BsMXMCLddUEr0YID6oOML6FH0l3FgET/xzngq200MjoDkHxgppMqNQ0xARWf
	M65pEAGKOPUs+2aE0GGviSbtdb0UqWyEgQsJJbg=
X-Received: by 2002:a05:600c:1d27:b0:43c:ec97:75db with SMTP id 5b1f17b1804b1-43f2fee0322mr10204895e9.11.1744275144997;
        Thu, 10 Apr 2025 01:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwx5Hi9ECmDwz9GMu30eMZy70YCZsKt5/CrcCZnOgag+4ucAPiAAFjw0s6N27cPzQHFVNhTg==
X-Received: by 2002:a05:600c:1d27:b0:43c:ec97:75db with SMTP id 5b1f17b1804b1-43f2fee0322mr10204635e9.11.1744275144638;
        Thu, 10 Apr 2025 01:52:24 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c8224sm43079765e9.22.2025.04.10.01.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 01:52:24 -0700 (PDT)
Message-ID: <495e43ef-ae20-4dda-97c0-cb8ebe97394b@redhat.com>
Date: Thu, 10 Apr 2025 10:52:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/13] netlink: specs: rename rtnetlink specs
 in accordance with family name
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, donald.hunter@gmail.com, jacob.e.keller@intel.com,
 yuyanghuang@google.com, sdf@fomichev.me, gnault@redhat.com,
 nicolas.dichtel@6wind.com, petrm@nvidia.com,
 "David S. Miller" <davem@davemloft.net>
References: <20250410014658.782120-1-kuba@kernel.org>
 <20250410014658.782120-2-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250410014658.782120-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/25 3:46 AM, Jakub Kicinski wrote:
> The rtnetlink family names are set to rt-$name within the YAML
> but the files are called rt_$name. C codegen assumes that the
> generated file name will match the family. The use of dashes
> is in line with our general expectation that name properties
> in the spec use dashes not underscores (even tho, as Donald
> points out most genl families use underscores in the name).
> 
> We have 3 un-ideal options to choose from:
> 
>  - accept the slight inconsistency with old families using _, or
>  - accept the slight annoyance with all languages having to do s/-/_/
>    when looking up family ID, or
>  - accept the inconsistency with all name properties in new YAML spec
>    being separated with - and just the family name always using _.
> 
> Pick option 1 and rename the rtnl spec files.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: extend commit msg
> ---
>  Documentation/netlink/specs/{rt_addr.yaml => rt-addr.yaml}   | 0
>  Documentation/netlink/specs/{rt_link.yaml => rt-link.yaml}   | 0
>  Documentation/netlink/specs/{rt_neigh.yaml => rt-neigh.yaml} | 0
>  Documentation/netlink/specs/{rt_route.yaml => rt-route.yaml} | 0
>  Documentation/netlink/specs/{rt_rule.yaml => rt-rule.yaml}   | 0
>  Documentation/userspace-api/netlink/netlink-raw.rst          | 2 +-
>  tools/testing/selftests/net/lib/py/ynl.py                    | 4 ++--
>  7 files changed, 3 insertions(+), 3 deletions(-)
>  rename Documentation/netlink/specs/{rt_addr.yaml => rt-addr.yaml} (100%)
>  rename Documentation/netlink/specs/{rt_link.yaml => rt-link.yaml} (100%)

My understanding is that this rename triggers rebuild of the related
doc, which in turns leads to quite a large number of htmldoc warning,
but it's really unharmful/pre-existing issue.

/P


