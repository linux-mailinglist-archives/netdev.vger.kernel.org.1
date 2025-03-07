Return-Path: <netdev+bounces-172930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BBA5686E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3061884EC3
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE7421766A;
	Fri,  7 Mar 2025 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjLGnbC/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB220968E
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352677; cv=none; b=a9ouPmC9h1933abjNeitNRgvoIGpjtvEWLwLee1lu3REEqMt2tkggWKN5xKR/8VTgUYDOl6JTuLTeyAeGPg33a5F/CRfRShG8YVyb/JJO0MKsP4IbGrzj9rNu/wTsmjmhfqQwSyNg76HEz8LVMH4AAc13reLbk6KH7JQQLvNng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352677; c=relaxed/simple;
	bh=zwdH5kjc0pp6WgGw7ooJgwfJ9cZrFa4Qa7IBZJ+FcWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBR1dwQLTHzppmOfyyQ2ByJzVrUUL/ysZo79/hWMXj1FhD8J5V/DNL164+n2M5aEckcc3xg90P37rLJzEUsTpPZimjpeCsvclqKFw7H/cp3b9yp99WS6VeWBO2LQbqSEHbNpWKmkuzgMJNMKBm8RqysKKMAfZsgrougJoXtAP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjLGnbC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3DBC4CED1;
	Fri,  7 Mar 2025 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741352677;
	bh=zwdH5kjc0pp6WgGw7ooJgwfJ9cZrFa4Qa7IBZJ+FcWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjLGnbC/8F8MuJbDB9cMtyneOj8/xFDB5Lw4mKlw90yvx+CMgX06/HqaLQwYt+zVl
	 tdfXKKw/g6LElRLiphrDjk6jlxqvhQLS9R5av4tZaI+/Csv/JtpIkIMmAVlyvlIG9W
	 KPac9xnJuXcmFWHUaHG52h2AjeeN8qY3iFW2MXOSXJB+RNdK6vyrKwmjdXI2/60tMD
	 /a7ip0nG5Pq+GzpfucyihJroBWuifVSDw/Q4EWjgQna2/0/EHqxlUdJo1JmQB4xkKu
	 6LQrX1KzJXGyQIymX4292SVyifXZdxS6BA8ZdTuOH6HG0FKSpRxpStnpVttDWopWyg
	 89hJnvxEGL8/w==
Date: Fri, 7 Mar 2025 13:04:32 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next] net: airoha: Fix dev->dsa_ptr check in
 airoha_get_dsa_tag()
Message-ID: <20250307130432.GF3666230@kernel.org>
References: <20250306-airoha-flowtable-fixes-v1-1-68d3c1296cdd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-airoha-flowtable-fixes-v1-1-68d3c1296cdd@kernel.org>

On Thu, Mar 06, 2025 at 11:52:20AM +0100, Lorenzo Bianconi wrote:
> Fix the following warning reported by Smatch static checker in
> airoha_get_dsa_tag routine:
> 
> drivers/net/ethernet/airoha/airoha_eth.c:1722 airoha_get_dsa_tag()
> warn: 'dp' isn't an ERR_PTR
> 
> dev->dsa_ptr can't be set to an error pointer, it can just be NULL.
> Remove this check since it is already performed in netdev_uses_dsa().
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/Z8l3E0lGOcrel07C@lore-desk/T/#m54adc113fcdd8c5e6c5f65ffd60d8e8b1d483d90
> Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

