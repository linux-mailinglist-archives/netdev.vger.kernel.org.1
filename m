Return-Path: <netdev+bounces-224273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE42B835BE
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C75721105
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B33C2EBDD0;
	Thu, 18 Sep 2025 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSnk2+ai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89BF2EA48F
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181148; cv=none; b=NL7mOfCANSXKOQ9rYlRye9Q7mguFg6/cX6jo6FUDtIK6raJzB57oPrp2JzIPatLVw0oiTQs6Zd4KRMNrm8T4vyExjOWE7/PUdOWBh6e2hH7ZxwZk3S30yD/lkGaKHrZUDf/HFiGLRBybTAFqZEXV/ZzQURqE5RaMSJOAN6O/O9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181148; c=relaxed/simple;
	bh=zr9sG0j68lmhOpqFGvsTn7V0/phVlb0kkL+RjN1CCm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQfO83gfNhldUN+r+IF/+WF/2B8RRwkE9prB5doHJwmRY9Aolkhha0vr2qs7Gc14NCiHowLbAjoJK9s5r/bLDZ7qXbRmjltjyQJfuJC7SGBbK8viCESNJ6lWE3GXzqz5wDbtuP4GjP3gUFuBnZyUyQ1onaBPkKKP0cQZHWbmi3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jSnk2+ai; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f31adf368so4281565e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758181143; x=1758785943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXt4qIjnPyB2Xiavamfk0cWdPtVvBQPn83+TPQKe3KE=;
        b=jSnk2+aiclMSdfvaENwl/v13ykOt04X0HlnCTT7V30DdbrP1cXbIz/sX/4jOQugfcd
         Xi/GdyIfvvHyywWNX0xdppR30bM+4mesm/h3JyYDFsRkOygGVbVUukIwLREglLsFkqsQ
         D6uhuIgJGsWt/NJ3ZsphlSleHbyOOqctidTbMMZQwNf/7KCqKI5lo1HZ2869bL+QvVPT
         Yuvvp51L3BZyvPAKA62kuoaIuLHem6gAppY4jWEFb1cF3kdpMNCuf6iortAcrp7z+YCV
         Apxx4mjkPvxZstkUqgMpAE9ppSJwcDZcqIqGhVsS8c824zPiTQyff0Pam9GHB2YfV9WI
         XT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181143; x=1758785943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXt4qIjnPyB2Xiavamfk0cWdPtVvBQPn83+TPQKe3KE=;
        b=r4R7lLCBZnhPlRbdZI6C02l9oEeg4zE51Nb4mp4Cq2YDRo/ZnSJJLvpNxWGA95ZR82
         +1PSCKfGSc1YAq5PRt5IptL0qrF99KTrYi4ZOgOvd+RJTSTeqsHiyJ1pL9pbOmmSfCYK
         s98YrXdO63gthbf4izPjV7Tgm+FTShUYJ/yUIuoejI6X/68diuSsmKbX6ICP21IpYKZA
         cdRFPO1dE1eSb+PEOJS454CLHqiUVVlfbdPvqn8Qk6MbkyxyCrjY9hdOoqqFnKKpoD1/
         UYZWdT91GbX85tPR+963xGNnFNSdJvNxH/xLJAvPsszgH+d9amKgozw7UJhYtnxq+xYe
         ikRg==
X-Forwarded-Encrypted: i=1; AJvYcCXTs5yXdRpuewuGTqCHRDp0QXUEhCmDWV9MX2g17Q4iXKJF+XD5klXv46vy9DIInftVZXcN+uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEZM7Ga5F+7hMgmZ6K5VnGTaPBEWen2Nf8vJkPEEtu/5p61ES
	p/fvmkWMxMB1h2YLBW3Q8gnLUg+O9kO8frLKjYukKQ+/nLKiEtvrhuSU7jdXFTDWb19aL3v79q5
	YsX3j
X-Gm-Gg: ASbGncsIkWMFRj/ohkpXY1Xd1IbPkuZFp/TF9E6i5GIZOGnpjEg+ph9eTkaLcfkgyLj
	8QJEotRDDMoYnSVkXQQgm/TPVABSp91cAxRnM49d2+FEq129EZDkk8IQdzAe2gwYeiiukxmjZA1
	n8oKS0IenGqhKJKn3fAJxBSewBuF/qY3ZEn66Xq2fGu6HASymp7xfzBhnNxml4ci/qGg+jNJUav
	slWIeq7iHQADWdbbXpIyFRORelElY1nZp+X2dzpXi2RRWZfm30vwubRbiFyXIkSERhzHzuQx50w
	CdLzAY3dM5oWJqHkHQtu/GP+JB6J/4G+RCx2Job+sOLNCPgw6fkaidNqjJ9ToSmjUNq3kM3w2wT
	fYHdpXbHhSqrySPdHJ0sSRLEpOl/Q47ZGhBHowqMvGgLAXA==
X-Google-Smtp-Source: AGHT+IH2MLUzEYKA2BPh6/SOk9G3FIKKjuMYakg7LjBGvzqYlCjhPjkDjyAhkJHpc9DvchwNU3Bf+A==
X-Received: by 2002:a05:600c:5250:b0:45d:d5fb:1858 with SMTP id 5b1f17b1804b1-46205adf916mr40396985e9.21.1758181143198;
        Thu, 18 Sep 2025 00:39:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbc72e6sm2350863f8f.29.2025.09.18.00.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:38:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v06 08/14] hinic3: Queue pair resource
 initialization
Message-ID: <aMu3E-wTfK-B18id@stanley.mountain>
References: <cover.1757653621.git.zhuyikai1@h-partners.com>
 <8d72eefd38d1c3b106eeb830d9e149df247b2906.1757653621.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d72eefd38d1c3b106eeb830d9e149df247b2906.1757653621.git.zhuyikai1@h-partners.com>

On Fri, Sep 12, 2025 at 02:28:25PM +0800, Fan Gong wrote:
> @@ -102,6 +127,41 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
>  	return i;
>  }
>  
> +static u32 hinic3_alloc_rx_buffers(struct hinic3_dyna_rxq_res *rqres,
> +				   u32 rq_depth, u16 buf_len)
> +{
> +	u32 free_wqebbs = rq_depth - 1;

Why is there this "- 1" here.  Why do we not allocate the last page so
it's 1 page for each rq_depth?

regards,
dan carpenter

> +	u32 idx;
> +	int err;
> +
> +	for (idx = 0; idx < free_wqebbs; idx++) {
> +		err = rx_alloc_mapped_page(rqres->page_pool,
> +					   &rqres->rx_info[idx], buf_len);
> +		if (err)
> +			break;
> +	}
> +
> +	return idx;
> +}
> +
> +static void hinic3_free_rx_buffers(struct hinic3_dyna_rxq_res *rqres,
> +				   u32 q_depth)
> +{
> +	struct hinic3_rx_info *rx_info;
> +	u32 i;
> +
> +	/* Free all the Rx ring sk_buffs */
> +	for (i = 0; i < q_depth; i++) {
> +		rx_info = &rqres->rx_info[i];
> +
> +		if (rx_info->page) {
> +			page_pool_put_full_page(rqres->page_pool,
> +						rx_info->page, false);
> +			rx_info->page = NULL;
> +		}
> +	}
> +}
> +


