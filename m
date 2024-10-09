Return-Path: <netdev+bounces-133384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9FE995C5F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A177D1C2207A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DF753AC;
	Wed,  9 Oct 2024 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtK+RsZV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12843C39;
	Wed,  9 Oct 2024 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434425; cv=none; b=LN4+7Qp+n/DuP9o4FJsUtmstqK8i07a94CM4Du0pHAsfE9kXGb3OECW7hJKqA7wi9H0Ivf1D6MEJBWXV8I719mhhVCCXX4xFVxO2VYrLrILA7IPrvul8iIINJ+YadTBI04NVroTIVwHnJE/n9snqwTXTdakgDugGcLRR+dwHFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434425; c=relaxed/simple;
	bh=AkOCBbHEOfEQCI1+m3dmccijhcVNtg1Wx843sDOs1ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ra/2/0p+nD+HUf/Lu5J3cU6ZNQDHqdjW5WM++WusDd4L2mtz1GnuVDeHhdgTdzo17qhv7NJyMBNx4mWUaV09KtS3SwU6bb/Rq797e7EG/48f/9nfbrv559qVpQxOtcknfpfmHziR0TtWOFlugnejStYvCpEQTryYTP6QhNZKxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtK+RsZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DEBC4CEC7;
	Wed,  9 Oct 2024 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728434424;
	bh=AkOCBbHEOfEQCI1+m3dmccijhcVNtg1Wx843sDOs1ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rtK+RsZVJkQz06cOHN6ZVaJzbp/CIafcX2kg9Tmf3XlYHmFz4Xok4DiAZaEqNVnr9
	 aLVLQJ4EdDs76Wsg/2HOZRbhymGpq8MVdVSQnHp/jV4lUTd2xHQQUOBLTN/e+7KPgX
	 YHuK9pJ2GutGnzyTXG/tUiKkoKMtbSaqz/MtkNqibbZ4EHNRetdLwsC9DWXjKnOqQ5
	 SoI8ONie3gx3hcMqPHrGI72kOeErZovGvwJUnRXqS4OlFmhxPhth47KfazS0Vt360G
	 QLj1wwn9pyfNyvz8fNRobafgo3XJlnyxykLS2IpwZWhDir9+KXsQ6mjHYX5NcmF7R7
	 3zFoklXlU+Gow==
Date: Tue, 8 Oct 2024 17:40:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
 <fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
 <edumazet@google.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/2] page_pool: fix timing for checking and
 disabling napi_local
Message-ID: <20241008174022.0b6d92b9@kernel.org>
In-Reply-To: <20240925075707.3970187-2-linyunsheng@huawei.com>
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
	<20240925075707.3970187-2-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Sep 2024 15:57:06 +0800 Yunsheng Lin wrote:
> Use rcu mechanism to avoid the above concurrent access problem.
> 
> Note, the above was found during code reviewing on how to fix
> the problem in [1].

The driver must make sure NAPI cannot be running while
page_pool_destroy() is called. There's even an WARN()
checking this.. if you know what to look for.


