Return-Path: <netdev+bounces-196350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD1DAD458A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4455F3A4901
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F09286D61;
	Tue, 10 Jun 2025 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q5FmwdCP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37F284B5F
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593007; cv=none; b=LcBRk4nVzb/yi8gsc2p0ZL8pkl3slnq36D/poSAomaAGY/zMCfka0YkRGjxPuqS9QYFc7L9V6v+UDTQ7x2WhCGgZ+b1F9ygUDAyStzbi0DDsrCLomCQOmQ1nJrcix2oIEz1BsZRJAwB8FVYE+apf5HIQjOVQWH7s3aVL3k8HtFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593007; c=relaxed/simple;
	bh=lAzkbZRsiYkiAFt594FQ0xW8AjZBW060MmReVLZSPEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avkWqnwG+01x6QnEPAVQPKHSdy+iire46MJRJnuegyJmtmf0JCZ99jDytPmDzlnjFhl9hvsjDeXI1DT9CALzbXXmCzDF4BVpApmK4mipz6tlsn9juTORgL9EjMTveyjdC8cgK7K/dgZu9KCo6dlKr3iT6kOSx48bngR/Nptjkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q5FmwdCP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235d6de331fso70482225ad.3
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749593005; x=1750197805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CiAybgJTvUHDDHI0zOr7gnQJrjAwYePwjmyhAIO9NUc=;
        b=Q5FmwdCPIB7iYeFN13TCbC1Nhv+q+y+Ccn3o54uV/9r00OOTtv9PPtiNPNSDTANKVi
         t00lgGZnwEjb9s8vFqwEtPVyeMASvnBvzTVsRjIeKxEI7vfgpkkIUm6vDs98bhhVk7rV
         vw/5IE0WUCBTBCWUeINqb1qXqpa4oOP3LST/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593005; x=1750197805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiAybgJTvUHDDHI0zOr7gnQJrjAwYePwjmyhAIO9NUc=;
        b=r/YEFIhZ50n1lMR/FNfnn5F4PcRqzUpfMdN6Z5ZETZ7o6RAr4xPlKmR67Y72H4K8pN
         nr0S+KHfY2ZJMdVkv5rR1DhLlmWomlB939Wz2beHBbDjYbCDPqUCWVGGWYJEUv2YWn+y
         Pz5ekY8pe5eQEE2l7KNMzvr230XJAtXdIKTzgdALdJmU21E/6ngig5P7C+h4hsGrLxRS
         0dnZtu/Vru5ZKgt0ypJqjBmryywmzAnKarPYdRMalpR3QAsHtdqrjnyQ2R6QFltBxAGB
         yziwpmnza49vrhjpe/iAOHaGaJddK9yjxw1UKMDBChTb8MqZprH/in4lZ4l8jZFTrcXN
         uDWA==
X-Forwarded-Encrypted: i=1; AJvYcCXKGlFQ0ZCwYHJDRlkSNfEgD4bZoxk8nXbivS5Qsm4m4bzqsKojgArK2Uo9aP6x9Zc3+AQvkR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqcXi0V96bCNDfxhtJa1MnsxvMx1GFcKkNClaxBSBFqHGi2Ng
	zv3eKe4y0seO/tM9oxrCF7j9I3MgVQF5iXFyGsyEdEGsXfAYl9zd6eN6Zm+VVCc/Sw==
X-Gm-Gg: ASbGnctHuZVMUGlHQgV1j+05mq7xVrjelkJAmooqR0FfZH8+yDZg5B8Dws3tNQOfcam
	vI5qy7qXKpHvhVJjXIsxEK4wE+ww6eBpYFNKZBlFYuqokNrK10ckOhRQh8gmvJ1sn8wpyen5nNw
	lEg3SVWEt8XJpLISOBu06dICRv+s5wPtG9opNQLOOq/P2CxcQYDCEvjK5UAsAtTp1RBJ3YC97Tu
	GpCT8aE0mzuxkOzpZ7Da0YY6VumS4/sZuucwIawulVEc/BUeSykh2WOqwEPq6KcYtF2sBq7SkBu
	XyWB0uu+clbpe/7MFbfzDOa1B1pD566c9XRGHXK2GFujBV4LzAZVsLqNCfAZKxiL9Un4sAWPZVl
	ZVOctbWT+QFHQlJrCi17XPH5Em5xo5m1uvHophcc=
X-Google-Smtp-Source: AGHT+IHTZUfe9NgQX4fBB9+qXz05x3tkcD4vBuXAHP7YeCeJw7eNzZ9CYK40gUkuN3RyfnzZ7PjnFw==
X-Received: by 2002:a17:903:41cf:b0:235:a9b:21e0 with SMTP id d9443c01a7336-2364255bc96mr6670475ad.0.1749593004825;
        Tue, 10 Jun 2025 15:03:24 -0700 (PDT)
Received: from [10.69.66.4] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034065edsm75206445ad.185.2025.06.10.15.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 15:03:24 -0700 (PDT)
Message-ID: <21c6abaf-b208-4cc0-874f-42bceed5c1b7@broadcom.com>
Date: Tue, 10 Jun 2025 15:03:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: bcmasp: Utilize napi_complete_done()
 return value
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:BROADCOM ASP 2.0 ETHERNET DRIVER"
 <bcm-kernel-feedback-list@broadcom.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250610173835.2244404-1-florian.fainelli@broadcom.com>
 <20250610173835.2244404-2-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20250610173835.2244404-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/10/25 10:38 AM, Florian Fainelli wrote:
> Make use of the return value from napi_complete_done(). This allows
> users to use the gro_flush_timeout and napi_defer_hard_irqs sysfs
> attributes for configuring software interrupt coalescing.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>


