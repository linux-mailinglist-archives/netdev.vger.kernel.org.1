Return-Path: <netdev+bounces-122362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D14960D4B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C31D1C20D52
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265B51C3F3B;
	Tue, 27 Aug 2024 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1rv4OLK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0807126F1E;
	Tue, 27 Aug 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768069; cv=none; b=fZiOCZnq+hS39rhow8uYtrAqpyWWIwYIIKlAL4mk4//1IfUFS1kz7EhbPC4kUsM77s/9I6ck0uY3Aem9I8a2CAnbRDWQ14P7b+B+MnZGjUXgHVfU5oGMVXL/Z/XrnwY7CxZe4B0SxhM+yuD7VXGvoWsyoULjF8Z7XQNLoOhMEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768069; c=relaxed/simple;
	bh=MJFXP/k9RQK0ByF56VDngc+Nl9urhri3xUs+JNYlmhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaX/DnyyL3Ty8nzw7PHyHsjuIaeISp99Wt6GwxpUPPs4ftgdX7xuKT02/dYa1+Xx+9oLJT1JjnxA2FoF3RTqDaZFHJfYOJQxJG071ITz7iOjYmBAnkkpdVubneAAtN0lFerM3RHPPnkj60f026Qd2Au7JT+dynWSmcn1BOdzD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1rv4OLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3452FC581AA;
	Tue, 27 Aug 2024 14:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724768068;
	bh=MJFXP/k9RQK0ByF56VDngc+Nl9urhri3xUs+JNYlmhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1rv4OLKi6geNW+qmLq+G/zau60NRnAQ8jlm4wMN1kQUU2ml20OJldWMFsgSWrc96
	 IYdXuovm7OoldXaJHbgZEEvsPNZIzvOSDaLhMzn00P+cTuZW7ZvAZeMRHwHbfHN1Sx
	 l0/GYopSKK/pPYOQDCnS/WgGemlfo5O1imN7D9Jdvbhze667OiZ13/DStg7cihbWi0
	 e4nG9IweKQct05F0QVR96vl7xrOPrfXJA0dfZi89PLEzdEXikqOudd6itVMEiH/JQS
	 TXBtn+4U1JrsKNgO7uwpByvLptlo3WcZdR2BpACqfHuke59Q82PokuVWQkZZYEmO9D
	 VcHohoA2LJegw==
Date: Tue, 27 Aug 2024 07:14:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jeongjun Park <aha310510@gmail.com>, wei.liu@kernel.org, paul@xen.org,
 davem@davemloft.net, edumazet@google.com, madhuparnabhowmik04@gmail.com,
 xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/xen-netback: prevent UAF in xenvif_flush_hash()
Message-ID: <20240827071427.4c45fdb8@kernel.org>
In-Reply-To: <fd2a06d5-370f-4e07-af84-cab089b82a4b@redhat.com>
References: <20240822181109.2577354-1-aha310510@gmail.com>
	<fd2a06d5-370f-4e07-af84-cab089b82a4b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 13:19:59 +0200 Paolo Abeni wrote:
> On 8/22/24 20:11, Jeongjun Park wrote:
> > During the list_for_each_entry_rcu iteration call of xenvif_flush_hash,
> > kfree_rcu does not exist inside the rcu read critical section, so if  
> 
> The above wording is confusing, do you mean "kfree_rcu does not exit 
> from "...?

I think they mean that kfree_rcu() is called without holding RCU read
lock..

> > kfree_rcu is called when the rcu grace period ends during the iteration,
> > UAF occurs when accessing head->next after the entry becomes free.  

.. so it can run immediately. Therefore the loop fetching head->next
may cause a UAF.

> The loop runs with irq disabled, the RCU critical section extends over 
> it, uninterrupted.

Is this an official RCU rule? I remember Paul told us it's the case for
softirq, but IDK if it is also for local IRQ disable.

> Do you have a splat for the reported UAF?
> 
> This does not look the correct solution.

The problem may not exist, but FWIW the change makes sense to me :)
We hold the write lock, and modify the list. for_each_entry_safe()
seems like a better fit than for_each_entry_rcu()

