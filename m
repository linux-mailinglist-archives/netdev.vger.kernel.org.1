Return-Path: <netdev+bounces-154554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B449FE91F
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E152E188278B
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127441ACEBE;
	Mon, 30 Dec 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMkTcS6x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A201ACDE7
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735577091; cv=none; b=O+3/CUI0Qq+B0LKelhqBdhz4xZWYgGPx+1Qs9yi+BTpvS4n9MAnnk+0VDUPdV5hM3wwqzykvBT1CgxkdPa+mQ1vLwx36ngwQQebYrkA10R0Zi8CLNLSaW2xklLasZfzlxYOdK7WHQRIqbAQA8+Xffs/GjWBTOtQKc0VyaAlheMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735577091; c=relaxed/simple;
	bh=AGJtIcuXtfK18ISgkgqYR56HAl3+0wDQqk0dr2azRSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V81IfFsYB36Y0BnkK0fu1IYY+yZtEhvGCKC0/GYUXBNrb7cMOjyGlIzoDj+tKMiJT38YQa35Vyf2eAU7CrRDq7Y26+Stm5tIKSDmfD5QHMaHznL72e7pJ78nBi8M9llsjV97rs4ssbEbontHPpz9pUZ+dMDV4iLb1EUU7GLa1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMkTcS6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1432CC4CED2;
	Mon, 30 Dec 2024 16:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735577090;
	bh=AGJtIcuXtfK18ISgkgqYR56HAl3+0wDQqk0dr2azRSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pMkTcS6xS1itGfYXiNwXMmFBudRh1vG8uVulbFTRQazgAup8xtAbbk9Q5jwtE3RTv
	 q2r0oqqRCVT8VM3Ha01ijElj38f7pSPvoliGfpzCSxdLIvVcMu8g3ucraapL/N6++7
	 SF8hop46iFyu7TDjCrxKGb22BwpYdh8ne+lIkyHRCJJEc4NoMT1AfUxcat8BkhB/+o
	 HdzJ5yCIK69YPuVkOwPLf1OGctHouspKAdohW08DpksQwDt249ZK1dFNucc0J2+LWZ
	 ts41esEwhDi5SeB7fsV9HLwgtkL9MCQBt1Ly2vVBuAzS39TtU9pz+LM8pBXNkKF9CD
	 xvc4uVDxGN1DA==
Date: Mon, 30 Dec 2024 08:44:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: John Daley <johndale@cisco.com>, <benve@cisco.com>,
 <satishkh@cisco.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next v3 4/6] enic: Use the Page Pool API for RX when
 MTU is less than page size
Message-ID: <20241230084449.545b746f@kernel.org>
In-Reply-To: <ef5266a0-6d7a-4327-be7c-11f46f8d1074@huawei.com>
References: <20241228001055.12707-1-johndale@cisco.com>
	<20241228001055.12707-5-johndale@cisco.com>
	<ef5266a0-6d7a-4327-be7c-11f46f8d1074@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 17:18:39 +0800 Yunsheng Lin wrote:
> On 2024/12/28 8:10, John Daley wrote:
> > +void enic_rq_free_page(struct vnic_rq *vrq, struct vnic_rq_buf *buf)
> > +{
> > +	struct enic *enic = vnic_dev_priv(vrq->vdev);
> > +	struct enic_rq *rq = &enic->rq[vrq->index];
> > +
> > +	if (!buf->os_buf)
> > +		return;
> > +
> > +	page_pool_put_page(rq->pool, (struct page *)buf->os_buf,
> > +			   get_max_pkt_len(enic), true);  
> 
> It seems the above has a similar problem of not using
> page_pool_put_full_page() when page_pool_dev_alloc() API is used and
> page_pool is created with PP_FLAG_DMA_SYNC_DEV flags.
> 
> It seems like a common mistake that a WARN_ON might be needed to catch
> this kind of problem.

Agreed. Maybe also add an alias to page_pool_put_full_page() called
something like page_pool_dev_put_page() to correspond to the alloc
call? I suspect people don't understand the internals and "releasing
full page" feels wrong when they only allocated a portion..

