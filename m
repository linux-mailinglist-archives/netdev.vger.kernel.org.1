Return-Path: <netdev+bounces-29406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBF5783067
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3361C20990
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8B79FD;
	Mon, 21 Aug 2023 18:48:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB279D1
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 18:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82723C433C9;
	Mon, 21 Aug 2023 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692643684;
	bh=Um5mFwcE5cVNHmWMTL+F+fXrhZmpdU1DH8xAEdxyQ8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PuldAdNm9nwcH6ymGQckb+V24C/yp1Z5osDjRGqWHtxcUiEdn7t2c1EahQSfzAnCi
	 WPtUkgYrcZzYdhLGM9MgpY6h/jc6VrO2fEvtjBzZeFSRNXUgSuc3WcNjYwr+kHIZFE
	 5mOsmi64Tf0DopK1nRJpSjlEdmPuJdBHdWZL0fkTy/xlQ1opV+Bx4mB+hxkwFqCPh2
	 gyeWuaHxrdBsTo85WINZK7hEe+9QWl8h+aiX/Lif0RsZ+nozoh95VZ5/yAKoYQPvXc
	 cdrOkSkgvvyvCvCBe+9xxNsaDLUCaHLno3V8M3qxl/aIeuwL1VkC7g6qk4lNNyhY/z
	 uUyCY5Y0JK12w==
Date: Mon, 21 Aug 2023 11:48:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
Message-ID: <20230821114802.1d1ce74b@kernel.org>
In-Reply-To: <CAM0EoM=fZVr4ROKZ+tA9A=yxcx6LnNVFzTb+_brFv9c-CiRfdA@mail.gmail.com>
References: <ZN5DvRyq6JNz20l1@work>
	<20230818193810.102a2581@kernel.org>
	<CAM0EoM=fZVr4ROKZ+tA9A=yxcx6LnNVFzTb+_brFv9c-CiRfdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 10:35:29 -0400 Jamal Hadi Salim wrote:
> > Sure, but why are you doing this? And how do you know the change is
> > correct?
> >
> > There are 2 other instances where we allocate 1 entry or +1 entry.
> > Are they not all wrong?
> >
> > Also some walking code seems to walk <= divisor, divisor IIUC being
> > the array bound - 1?
> >
> > Jamal acked so changes are this is right, but I'd really like to
> > understand what's going on, and I shouldn't have to ask you all
> > these questions :S  
> 
> This is a "bug fix" given that the structure had no zero array
> construct as was implied by d61491a51f7e . I didnt want to call it out
> as a bug fix (for -net) because existing code was not harmful but
> allocated extra memory which this patch gives back.
> The other instances have a legit need for "flexible array".

Based on the link provided it seems like the Fixes comes in because
someone reported compilation issues. But from the thread it seems
like the problem only appears when sizeof_struct() is modified.
In which case - you're right, Fixes and Reported-by tags should go.

