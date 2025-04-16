Return-Path: <netdev+bounces-183062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B6A8ACC4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB491442511
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4311C84B1;
	Wed, 16 Apr 2025 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvL+SwAj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6994B81E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763908; cv=none; b=c/PmMMos7nXJ6XrTq0rDKpKsSMRMlN3ZyNt1p8qLegImZyMMqKprY/B+dEtUFio4KeiQNJbYmB/eCydF24OFuxApHX9LHuEITvy3fMbRz3TTTDaf6mX05qlsBkLZcW9vm3KRiFLoFeg8JMJjMkVovpu/9qh6vg0Xe74mXUgu438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763908; c=relaxed/simple;
	bh=WBPzNKVtE1nyZ+2Kdt0CRnXSwsIKjP5hrrS9znxUWyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMQXTDmsBookaNTgYdXrHXJcjR09heVJj1XqSgEVBssAv30S76EDAP8KV/yCOPwEGkSFl6Ef+aQDDFkqFhcZsQmjUQSTsBlJGBku+rZw628WYtb9OiS50uTh1bjZZm3fv9+1Dsj8j4Mcb/iH80A7r++I9qD2T3fJyZt0U57Qi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvL+SwAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F12DC4CEE7;
	Wed, 16 Apr 2025 00:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744763907;
	bh=WBPzNKVtE1nyZ+2Kdt0CRnXSwsIKjP5hrrS9znxUWyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UvL+SwAjlnrfg1dVItVytp5lH7C1v6mnR+qPpMGguJ+1qvZIVJFRArhyfRuSiuR4I
	 4RzJQXOCjYcOS++HYHxjgozlFyWDaQuatb6e/SGRr7AywXSHVOYOFe5nXMkgZqUHi5
	 wu0br1F95E3MyEaz7aFLgJGepulcK6MJQPB+JJZ57/eJrNvj2UG2HdR9vt1V2WncSg
	 Mp+UIPfLy3QaO274OgrQKtOrGFBkULGXPShuqseKZA+v8TtQfQDNIKE2x7NzrrvKa/
	 XEcauCeYLJXjSwCFW4F4gWQz553NQnTjMacCXtRQrtZSGcngpKqNgF7simfQMnbmmZ
	 JJDOgxG+iAIbw==
Date: Tue, 15 Apr 2025 17:38:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH]nfc: replace improper check device_is_registered() in
 nfc_se_io()
Message-ID: <20250415173826.6b264206@kernel.org>
In-Reply-To: <20250415025436.203-1-chenyufeng@iie.ac.cn>
References: <962edb17-a861-4e23-b878-fcc1fd5ac006@kernel.org>
	<20250415025436.203-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 10:54:36 +0800 Chen Yufeng wrote:
> > On 14/04/2025 16:11, Chen Yufeng wrote:  
> > > A patch similar to commit da5c0f119203 ("nfc: replace improper check device_is_registered() in netlink related functions")  
> 
> > Please wrap commit message according to Linux coding style / submission
> > process (neither too early nor over the limit):
> > https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597  
> 
> Thanks for your reply!
> I have reorganized commit message as follows.
> 
> A patch similar to commit da5c0f119203 ("nfc: replace improper check 
> device_is_registered() in netlink related functions").
> 
> The nfc_se_io() function in the NFC subsystem suffers from a race 
> condition similar to previously reported issues in other netlink-related 
> functions. The function checks device status using device_is_registered(),
> but this check can race with device unregistration despite being protected
> by device_lock.
> 
> This patch also uses bool variable dev->shutting_down instead of
> device_is_registered() to judge whether the nfc device is registered,
> which is well synchronized.

You're also missing a Fixes tag
-- 
pw-bot: cr

