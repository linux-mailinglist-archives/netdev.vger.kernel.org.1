Return-Path: <netdev+bounces-97124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B764B8C941D
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 10:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44F41C20900
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90818E554;
	Sun, 19 May 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="DG5VGzVX"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950913D60
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716108493; cv=none; b=q/+GtDJQLu80LHfR3GnD6KBYmKxRDjj9t3zIOZdbzlPMIIcayvmejkLYq3V0TatPmvEpqtbpyylvbZRqsxnTGUCZXVcdbfvEr6uLl7FYbU5l3/oxwwUqDZUtFHpgrjS+ZdryPbLagbm4gTn7RQRllm4YSrV8CugmCTSW38SSVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716108493; c=relaxed/simple;
	bh=LjRG+pYHmT5woJoQF+MZa7l/urKDo/VXlusByCkD6BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTVi7GRGTsebnQpoNnJjt2U+q1XoHqQTnl/qaU+umU/NHUOwas6Sz/seub4BhmvOfmB0hmvzR3/aqwUGtasVdytPm4CID/oUtAr+PNzZO8Kdug/ezPvoi8NTB80gsElLhR9jnhsfaLj90Zal4U+xsPMP7sDjK+nvObe2pGQPLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=DG5VGzVX; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s8cD6-00ATMp-Le; Sun, 19 May 2024 10:48:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=DaPOdoRIPg8R1pOh3yec9IyGVmz4ls6Cp2IG4vqLW4c=; b=DG5VGzVXWxUS9w51Ewu87wRspI
	vUfMC3efiYcfx4giw2az2OeIg/+TmD5OJxowbxlN/XeojDhdjwLp02j5tIIRvaFan0osGUE+IH98j
	CZlzDmLL6g2pilSjNV9smSOtFJ9WxDmcuNLn6UxvIuYSUhuzwPt2uNOVVWwUcJp3XCe+siBAIxgYr
	8NRTWnSgWcZ2RH25OR30bqJ/l3mNXmuzyNUr6LwTX9Dkcu7vLoVukqILa9Mi6fBixgMBJ4tZqPQ8j
	5kgzeWAIO4qGP4uU0YbpbG3k9CUVQiGPRzG7sGa7SjYkMyb6OiYvS7B7SI7G0ejzEUxxORsmxTje3
	bQqCwO2w==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s8cD2-00034M-Kn; Sun, 19 May 2024 10:48:03 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s8cCx-00BXN6-8v; Sun, 19 May 2024 10:47:55 +0200
Message-ID: <b7c97010-c568-437d-8949-aea4aa909040@rbox.co>
Date: Sun, 19 May 2024 10:47:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] af_unix: Fix garbage collection of embryos
 carrying OOB with SCM_RIGHTS
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com, shuah@kernel.org
References: <734273bc-2415-43b7-9873-26416aab8900@rbox.co>
 <20240517074742.24709-1-kuniyu@amazon.com>
 <20240517122419.0c9a0539@kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240517122419.0c9a0539@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/24 21:24, Jakub Kicinski wrote:
> On Fri, 17 May 2024 16:47:42 +0900 Kuniyuki Iwashima wrote:
>> From: Michal Luczaj <mhal@rbox.co>
>> Date: Fri, 17 May 2024 07:59:16 +0200
>>> One question: git send-email automatically adds my Signed-off-by to your
>>> patch (patch 2/2 in this series). Should I leave it that way?  
>>
>> SOB is usually added by someone who changed the diff or merged it.
>>
>> I think it would be better not to add it if not intended. 
> 
> My understanding is that Michal should indeed add his SOB, as he is 
> the one submitting the patch now, and from the "certificate of origin"
> we need his assurance that the code is indeed released under the
> appropriate license.
> 
> If you could reply to your own posting with the SoB, Michal, that'd be
> enough.

And there it is:
https://lore.kernel.org/netdev/71ceafc1-269c-44e0-80f0-6f16a1f35f0b@rbox.co/

Thanks,
Michal


