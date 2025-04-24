Return-Path: <netdev+bounces-185444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6D2A9A5DA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B577217D7D6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE620AF62;
	Thu, 24 Apr 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKgU9dcb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E11F2BB5
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483370; cv=none; b=dIF258sGUnhVpOihr8/Rbi6Jq6XULGrug28ZXFLaRXgCe4OJD/WLiURKzXpsaPPKWn4xqQyHRmQNnWwwUt029d+cuVyuLUMJHvNXOBle3mAn5vs8DktTOXke91wvp+g0Et448GzC9kGx4h+8Xccjahwmy5D2uspKO1l2dlH+WZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483370; c=relaxed/simple;
	bh=hq0EANnqCqcKSyYlr/k7E7dzpD9JH3nzWHWh//6n1fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZ/Vl0M3vv/IXMi4Xw/EQKzcCm9eChl6i2xG3eizP0OaeKLVjYxIl76U9wVd2xSXnMG43RMtBNSxoTNCYTsP1DnTZUiFAd6BAe/x040yjO+3NXP/dtjWmQB3udiLKojAuYcjqRK/7rW0rSUXDbakjta97+4JSd0gdpd9C04kMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKgU9dcb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745483365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkbpC0XhR6t9ZKyAfaXSILJlrh57IHfoS+fb/sPEuLE=;
	b=CKgU9dcbpgrWzYoNkgTrth9ucbUSQeXVGW2XntHhAOnVCDt/zZIBRaVvJ2vbGonXLImzH/
	MTFhcA6hZ9eFQttTM1p/01gdoqUJ4P9b0V8yMi9JMEuy006ZGsNo+Pl0W0Z+9cQ5iQRZJ4
	N2wx6Gq9II12mev0O1XnHzepoZrMbAU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-gITVB4YwOWCgK46TuhIIWg-1; Thu, 24 Apr 2025 04:29:23 -0400
X-MC-Unique: gITVB4YwOWCgK46TuhIIWg-1
X-Mimecast-MFC-AGG-ID: gITVB4YwOWCgK46TuhIIWg_1745483362
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b19so4133525e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 01:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483362; x=1746088162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkbpC0XhR6t9ZKyAfaXSILJlrh57IHfoS+fb/sPEuLE=;
        b=oc6/zoEYmIYnF6GCCQUg7Xx1bXE8r+n6PJj0lzGFmzyMtKjts6OMFBB/mTiUgyqdZp
         l0K6bKkGrCwJzRmpTA47YmsRJSdl8X0d+8sHDuss8W6QfpwpjuRPdbiU1ybzdflgPg/3
         O8AH2qVfqGqhQAw/xcuQpMrMIhvrHdgrt196Ymsldybu5DbHwAfFQdVKwvbKXdvxp999
         6V5pZ8AlmCvXYEhoP8Co12agQb28zQ1gxfk0DroPr0X1fWAo8/BqYpNjwjmOo1gnPb8H
         gcPvL2MlOxKu1TfU9QfXPsGVsJUjscP1dytXG1RoibArbnM0HbJgqrJBb8NVj058zyiU
         snWw==
X-Forwarded-Encrypted: i=1; AJvYcCXxHyd2OaRjMFC1eDpMmsF9SwP3WnGSU/hEOv7YRyMbQpQE0DmZuJ244XEmhbtTiL7DPW2o6V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdh6Q9Wr+dLTUnhbtO6EPSjpsHWZE6HAupRu0S7xvMRcg6+Ui
	JnLKho7HzC7eRT6JMf0YHxcGPxgF7NtjM0tHBIVHhKnuKVYPCl2VhTPnWkBnt64Dcxzb7BpReb6
	sYi33ejZ0wQOVxNXKbjgGDAO5LEPAxQXRbvbYLhO6vI5rjMOiTygkPg==
X-Gm-Gg: ASbGncuP/HoPP4+rjnSyKEnO+DE0cjw4TWIcfxgyHxOReAu+1f+/6+ESCOC2d9WGgvg
	58MiT7LpqABRtVfgY2pk8fan70Cybp6PWGSu4Q1YM4yiYSv0yH3o0v3smcSmy1kWEtREaiBkcFj
	8gFPRKwHSE5Rnuapl3flKPCS8zsueG/yJo5o4hOs1wlxi7O66BJboti6NbIpt+elG10SRfHl7hh
	ab6h77GyDwrrPfJSnW2O0N/eCHW3zFKtK5oOJ6ZNun/wF8YPooLrLfRvM0zJJHqlXIPv/0qz2Lf
	VFSvImnSTgxKPdoPB4QuprQfRTye4AL8WVGYinw=
X-Received: by 2002:a05:600c:1497:b0:440:6a5f:c308 with SMTP id 5b1f17b1804b1-4409bd13f28mr11836215e9.13.1745483362158;
        Thu, 24 Apr 2025 01:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEwYKxuKk5eguUFfKvH6bg02dDTTmgZLgchMIJ7H/cvdD3iA2I8ENZITHjzJqOj8HuDJyt2g==
X-Received: by 2002:a05:600c:1497:b0:440:6a5f:c308 with SMTP id 5b1f17b1804b1-4409bd13f28mr11836005e9.13.1745483361787;
        Thu, 24 Apr 2025 01:29:21 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2aab65sm11011345e9.17.2025.04.24.01.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 01:29:21 -0700 (PDT)
Message-ID: <c932825f-6249-48c0-bb10-8c5754e01f8e@redhat.com>
Date: Thu, 24 Apr 2025 10:29:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/7] neighbour: Allocate skb in neigh_get().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250418012727.57033-1-kuniyu@amazon.com>
 <20250418012727.57033-4-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250418012727.57033-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 3:26 AM, Kuniyuki Iwashima wrote:
> @@ -3013,23 +2982,30 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
>  		pn = pneigh_lookup(tbl, net, dst, dev, 0);

pneigh_lookup() can create the neighbor when the last argument is 1, and
contains an ASSERT_RTNL() on such code path that may confuse the casual
reader. I think here you could use __pneigh_lookup().

Thanks,

Paolo


