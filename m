Return-Path: <netdev+bounces-73513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F485CD99
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64EFBB222AD
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CF1468F;
	Wed, 21 Feb 2024 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLU5yQHg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38D23C9
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480558; cv=none; b=HQNuB308ILsIwLhW4KvYUk33r8r3ltMWFJ4BpYYK1fKcYlQl52WePpKMrnEJCqDcUXGQqC+51k7E0PA9cqrLmAmBjR5ap4On5QJrLNEbMNGXkq9It4eqM+g6vc14/88FfpdIwJcS+4fdnB04T2hgMpPUjYyLLSe9DlCc+gvBCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480558; c=relaxed/simple;
	bh=dn9hViBCYl+szJewJxHU7ZzVHEhe2Z7JJ/8C4/boLyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAp5sZIyOhEiFrP4AUm9y5n+9QCOMPGrSjwLD2O97ka1W77qb7UhywKLMliylM3fCLcikseHm2eECyGld+gGIQ8xan/Wsi/FZpkhsfpTZI33J5dok3TF6NhD1BJPTWorRXaNEo1k5huLi5eL9jwsTTy0X1ca42lzpV3thEhSRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLU5yQHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C09EC433F1;
	Wed, 21 Feb 2024 01:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708480558;
	bh=dn9hViBCYl+szJewJxHU7ZzVHEhe2Z7JJ/8C4/boLyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dLU5yQHgaoodI/2gy9N6HTnAtGlD11sEWMBmtgYtGXzSAD4V71cIPW7GLFyCjMrYt
	 QlokpsvoxeFQZrCAISyoZDjG/Dh3I6xBqqtsZiCsNryDCrLOu583YPH5AKQXAXobaS
	 HOCJ/xZCXRvE0ABUerwZjyc2PEE4lsOOTuHRlbBKr1JeFJLlw7J8/78YLAsy7t2pPp
	 aY7TOHpd1/b4bxYRieGpbvXnoVvd95+A9iR6LdsoJ4QCDPuGaqEFeAWSY2tRkjaMgu
	 U3mmYZOANg134Lt+5+u4ZQx818HzLCesfpO55r1ubAig3Rw0k3a1jX3B9ZQVqa6Wxc
	 W5ECyorsvNemA==
Date: Tue, 20 Feb 2024 17:55:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 03/13] tools: ynl: allow user to pass enum
 string instead of scalar value
Message-ID: <20240220175556.2a8a4ef9@kernel.org>
In-Reply-To: <ZdRT2qb2ArAjaCWI@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
	<20240219172525.71406-4-jiri@resnulli.us>
	<20240219124914.4e43e531@kernel.org>
	<ZdRT2qb2ArAjaCWI@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 08:25:14 +0100 Jiri Pirko wrote:
> >It'd be cleaner to make it more symmetric with _decode_enum(), and call
> >it _encode_enum().  
> 
> That is misleading name, as it does not have to be enum.

It's a variant of a encode function using enum metadata.

