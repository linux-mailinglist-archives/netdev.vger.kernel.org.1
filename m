Return-Path: <netdev+bounces-200496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7EFAE5AAA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94D2163BCC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2771DE4CC;
	Tue, 24 Jun 2025 03:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjQl5PLV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D863597E;
	Tue, 24 Jun 2025 03:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750737531; cv=none; b=onUvwIYCnXGpeMmzKwCpzqvMrsEmBBY8nLag2GZYnpz2a3Bb9IXoGNMXr3XLMPeAyMKGEeEClcj36IHyjgYPh1Z2QLiCOnolrN56SU56bwM3mI200bcIzS2yMJcWO7a5SuXnHbfXJ2cf1W7WhoEItDVAQ2cYUbTGz+DGIh6LdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750737531; c=relaxed/simple;
	bh=nKKZsrh+9oxSjNjOB29wjfPsx0AkAJ2v6Js1OTnrnKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldCUZWZJGtNUuIUUAHwWAUIxXAzv6y5vDpBnKnNBSc0xy9wI3PTXS4pznHpIAL99RAWreJtgHF1n5vOlNONTPsXe5NJJLKGKCsKn52AeYnn2HjFltMCKOHowrck4yck2ko5jbz8cp2a9blDmQWM95jG1VvsOCJx9w3WZhoSEJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjQl5PLV; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3de11a14ff7so17577955ab.3;
        Mon, 23 Jun 2025 20:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750737529; x=1751342329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAY0RAJGDKYlHbRxfeU4on+SkgBM7vcmN2ITAECwUWI=;
        b=LjQl5PLVuFMtfpBra54r7m3rktovTW1XdHOLZQl0Q41mTHz5STlp1WvfV0g0slkCpr
         YxESe5hzw/ph7Ml59kkTDr1lPFaufOQpvXfSAN939pY0B6rjxccUhGKHKsq4pPzVHveL
         6vnSb8EWwgimB0fg8pEVIeFcy9oc4W3PspfB6fJIR4A98bV0hE8Wx5zrahmdMZN+0Cnn
         PPUiTfpfsrePOS6R7JcBeQg+VvY9Fuyzu8Vrpo9xQTLVk3xS5TAPJxM+keRdkaj0Wg3w
         gWbJLGLOK0idvJxSInfQsUehLZaoBI36NghxQHV57USqftSPjg0OiHAq9ddp/S1P5Tjb
         +uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750737529; x=1751342329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAY0RAJGDKYlHbRxfeU4on+SkgBM7vcmN2ITAECwUWI=;
        b=ka2nbYIHgAyabXOPxetHXjby8euN4QVV7depSzTkqV64inVOWPuitljiI2MdfqMh3k
         1Lxsn2nclLFa14HNAZNQM9cfdomQfoLrVPHa4t0VbnryNbLY/9qaEDArA07ZCLBHFKc3
         1xf0yuHBvvPJHatRWp1M+7NcFV1wcC9OVbOvw0wLJUC//QgOXywE4qO2q7porX6NkQpa
         igx6WtlCcY92YRlyOlCeD6CfdwEbIY5PdUJAjh7c58waAFvjaJw0bGhVsJ/IBxZWK3PB
         xVlej9+OSj4M72bONPB4X++tBHoD726SgDVjmOb8XONEqymWf4MygvZL7W4/y5GbR7D1
         FKsA==
X-Forwarded-Encrypted: i=1; AJvYcCWOy4b75jUNacbHYxgckUK2ZbQ4sc6Pgjt/+HznrcP6zzE+eZk1JOMfj6ko7j7UR0c1frAsQIDE++Jqnp0=@vger.kernel.org, AJvYcCX2g7P39KZrKsHsmXrLwYh/mlheZ1klyqKGCz11Hrn3tQZSs4dqp1q2kqtTG0hWcpbuMaKxFR4d@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeg2xUBKR/prQz0kcAH3x/RWpyZhGLTpaQgFrlg24x4m90ZVyr
	l56awoedMrXpDlzv7vhgbgc86QmyNQzDLiS/XCi5eCY+9o0X/jslbOTs
X-Gm-Gg: ASbGncsyjgK3BOROokyOGrAr3t6ZtmNSDz38hHch84gs+Q8DcQtw9XsHK/JpIp4sidg
	NUTgpijgCCrvJMN0GzevKpNO6pvgVILm4LZ99VwAEIBYorUEH+smlQz1MEui92mMkwXF7lax6sX
	mlVoGACzvQ7ppfvQ3PxpaAbsWMRdePOhbfWXI5f+tN1mHRxxgQKNR2SpM/rMiOLKwvM8UqGuwLn
	67xNHTZEB73iqLdqMfvGM/obsrGseGUqhTR0xn/PBnDcKKXNy/S+KmcvRYO0aScyes+SPItZLNg
	e5D3aDIauiOyfuErHhYHEiOIpG1b7qvXIcW3AhUJgJ2a4kRs9OK/8s+5fNAKzwMY
X-Google-Smtp-Source: AGHT+IHQwgTA8VyU5Wb7dI+J+dWXPpvGPwQ72Cl6kjX1KD07UcPTX7IBYCMsZFiD1YR37g0dQMwT4Q==
X-Received: by 2002:a05:6e02:16ce:b0:3dd:d653:5a05 with SMTP id e9e14a558f8ab-3de38c1bec3mr175713855ab.3.1750737528655;
        Mon, 23 Jun 2025 20:58:48 -0700 (PDT)
Received: from localhost ([65.117.37.195])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de37618764sm34580985ab.7.2025.06.23.20.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:58:47 -0700 (PDT)
Date: Mon, 23 Jun 2025 20:58:46 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: Remove unused functions
Message-ID: <aFoidoPHGeIYNacc@pop-os.localdomain>
References: <20250624014327.3686873-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624014327.3686873-1-yuehaibing@huawei.com>

On Tue, Jun 24, 2025 at 09:43:27AM +0800, Yue Haibing wrote:
> Since commit c54e1d920f04 ("flow_offload: add ops to tc_action_ops for
> flow action setup") these are unused.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

