Return-Path: <netdev+bounces-190727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC93AB8829
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B531746E8
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661F16EB7C;
	Thu, 15 May 2025 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5xPPuII"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9903158DA3;
	Thu, 15 May 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316152; cv=none; b=LfJ/Cc9l7XDdNBAYD523nYiYFh0Xmx8nHaSyIowPmjGYItnDBanCBOA6mH2pRw5+7Y9cIWtHhRbPk4wyxJLp8BcLXIYWuRNa1A+vyj2VnqJIKEWnPMD8pr0W4QxPobiX1gkVnjMhwdpqKfTAK+S+d1d+9UkOf6rThcfp53Q4fBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316152; c=relaxed/simple;
	bh=3mpHCNTdw83e6Xd1/Q/RuiqfzIT6w2eWI6KqpTfF1x0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njpURNWkD4qPVJ2YrIpFEWll0dh9FqyQfqpuz64TvD0N2nqBz/3MRiVGq3qHIDKhlGY8yhioy1o4V7DLLRnnG5SNTUMVkBgP+Mi2ak/v7SeC5u2AMJsPmb9izTIKnU1oT75Ha6KrCgKjuYSOQglBuekTopEtXJyR1LAcU8ClQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5xPPuII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7600C4CEE7;
	Thu, 15 May 2025 13:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747316151;
	bh=3mpHCNTdw83e6Xd1/Q/RuiqfzIT6w2eWI6KqpTfF1x0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N5xPPuIIRv1L5ax5/TiPgkKU6kHc0WesdMdEwwtk8AxN2Q7DG6Fh63Nc+9PHiQP4z
	 Pu8RxK6WZgQVre3aFVAPL9jxrWWfn4+8xnL6reOVyN+Sy/3LD9P1E++WrqxHgNmYhx
	 10DxmTtdfm9B6OmXi/CwFgMldi4ilG3YVT+vk1/1EE6j/XlI2VOBke3Y0uja7R4Ah5
	 ghERYicesxT5rWmr8yuOU0/n5zNQsE3Qip+mjB/6XwvWLlPW3eIVbrmllO4iCLq0mg
	 vbT8hnVnZ4gxnzDsGgh27kW5ZEEFCB1f+kss5O33niU4wETfippNLxC0UjttwlnR1L
	 B0YwDbG25UYWA==
Date: Thu, 15 May 2025 06:35:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <long.yunjian@zte.com.cn>
Cc: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <fang.yumeng@zte.com.cn>, <xu.lifeng1@zte.com.cn>,
 <ouyang.maochun@zte.com.cn>, <mou.yi@zte.com.cn>
Subject: Re: [PATCH linux-next] net: e100: Use str_read_write() helper
Message-ID: <20250515063549.0f7c0a34@kernel.org>
In-Reply-To: <20250515204414844_YQsk90Odo5a3bx9qvo8g@zte.com.cn>
References: <20250515204414844_YQsk90Odo5a3bx9qvo8g@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 20:44:14 +0800 (CST) long.yunjian@zte.com.cn wrote:
> From: Yumeng Fang <fang.yumeng@zte.com.cn>
> 
> Remove hard-coded strings by using the str_read_write() helper.

Please don't send "string_choices" conversions to netdev.
This is pointless churn.

