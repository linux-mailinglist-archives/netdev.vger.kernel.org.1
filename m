Return-Path: <netdev+bounces-99171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B88D3EA9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9351E28545B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744131C0DEE;
	Wed, 29 May 2024 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0nLGIjz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8618734B
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717009058; cv=none; b=VKv/BG2A9LLZ8kpX9Z3SGo/2pGBar1pjyTev3UKA7+nH1d8zHnvHk51aDQidUFukFDSJhB71QAHSud0hFfnHg8S1SUjeDio8WJtNPLIqATtDemONpVQUFggOf91hEdsdcA3sfdzBiQukrECnBnM1cDnAe2btMUBnqWkREcQnEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717009058; c=relaxed/simple;
	bh=1jVJAcGsg3YBIcaEHXqBtZ/Q9kfpKhWaa0Q4WEtMDKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKf7w64WSxeTlwLUoaTO5iXm8iTWEgMx0KPrCSffqe8XJVvufg0fq6pZx5872ypZQtZhmSHI3XeLWvbxPWJ5T7DLa0fRrBae4CSWuO61BbNxKi1mXjc3WxGCYCrl+cUay3UB4e1HKC2vxCGY0GCJ7/IWIIjNf106UIHsmPIdSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0nLGIjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60897C2BD10;
	Wed, 29 May 2024 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717009057;
	bh=1jVJAcGsg3YBIcaEHXqBtZ/Q9kfpKhWaa0Q4WEtMDKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G0nLGIjzvVNoT3x2r8myhQjcY6bHmIDnYsOzpGbxSrjswLLjqQKstZ+iwEAcYj9M4
	 gcLXz+Iq5dJ6ntKVyM776T9A0P3TXtFtzkEK4kQ9KoUeceS+qgmcOcCtD0Ly4bXFi9
	 Cs8hjjwr7wAvFsaG12cEDaCCgWn9OxeFsigfQyFYId03AjYyy8Iw1z1UOKxEA+1N0t
	 5xMHGU1qn+Jp9GnXRBxuPMcuMrU6C/A+dR3mN1//XHCD5GGxsqE1XnYwEiqJHjlfh7
	 dlaQqlIvpYpRBmFhhLn9LFbYm0zh7QpbsVxPxt1kiTpeKOce+qOhoYEERS5Z3SY703
	 zWfm/vpimdk/A==
Date: Wed, 29 May 2024 11:57:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, sdf@google.com,
 amritha.nambiar@intel.com, hawk@kernel.org, sridhar.samudrala@intel.com
Subject: Re: [PATCH net] netdev: add qstat for csum complete
Message-ID: <20240529115736.7b83c0f3@kernel.org>
In-Reply-To: <ZldytYTJEU8yAJqA@LQ3V64L9R2>
References: <20240529163547.3693194-1-kuba@kernel.org>
	<ZldytYTJEU8yAJqA@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 11:23:49 -0700 Joe Damato wrote:
> Are you planning to submit a separate change to add csum_complete to
> struct netdev_queue_stats_rx, as well? Just wanted to double check,
> but I assume that is a net-next thing.

I figured we can add the handling with the first user. I can, unless
you're already planning to add more counters yourself once the base 
set is merged.

