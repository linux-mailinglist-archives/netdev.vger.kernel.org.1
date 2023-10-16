Return-Path: <netdev+bounces-41267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D2B7CA6B7
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290591C2093B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08DF23775;
	Mon, 16 Oct 2023 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANdei5Zg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A6208CA
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B521C433C8;
	Mon, 16 Oct 2023 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697455704;
	bh=A5cUwPAsu3oksXhFl3oa+u3vGrczDMCN23UrhSj9K+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANdei5ZgS5hh8GiV0Sn5KlfXvQDndrXD/HZQbhlKSCnodHzXM8r3BePaCcWUxAk8j
	 AkzqA4kBLR77RPdnbcHLRgZPWIgGbtKYqoJ1T6lvLo0qCIvg+o/b/CkAyrlum4RU4f
	 MyTNz3xH0YZc5Wy0a4tynECi5TpEOqxp1T7w2mCSi8e3A6PfNwGvmWMuDudc6c8nkH
	 xRhahEnAp+PfH5XJsu2wY7pn3Fuj1wkVLcWMFV9/3JflkkbS01kcEFG3F/NzEh6H9R
	 I1wivZbLz178pKipPjrPmJHN5mEHhIuYGO2/O9OUZojMIniW9kAu0FBM0L5xsgRDAZ
	 EdALH4UXHkxWA==
Date: Mon, 16 Oct 2023 13:28:19 +0200
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?6buE5oCd6IGq?= <huangsicong@iie.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next] nfc: nci: fix possible NULL pointer dereference
 in send_acknowledge()
Message-ID: <20231016112819.GL1501712@kernel.org>
References: <20231013184129.18738-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013184129.18738-1-krzysztof.kozlowski@linaro.org>

On Fri, Oct 13, 2023 at 08:41:29PM +0200, Krzysztof Kozlowski wrote:
> Handle memory allocation failure from nci_skb_alloc() (calling
> alloc_skb()) to avoid possible NULL pointer dereference.
> 
> Reported-by: 黄思聪 <huangsicong@iie.ac.cn>
> Fixes: 391d8a2da787 ("NFC: Add NCI over SPI receive")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks,

I agree that nci_skb_alloc() may turn NULL and that this
is an appropriate way to handle that.

As an aside, I observe that the return value of send_acknowledge()
is not checked. But I don't think that affects the correctness of this
change.

Reviewed-by: Simon Horman <horms@kernel.org>

