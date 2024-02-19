Return-Path: <netdev+bounces-73096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBBA85AD79
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 21:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12FD2864FC
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298F52F97;
	Mon, 19 Feb 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIw+NCkC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD31482C3
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375862; cv=none; b=obnTQ4gOebA6GbZ2islJ+v0HmNZH68t3Qv08Ptki41FX8Srh67Jljw8Qp0C/Po8DPzVV963tihAWMpwiyiXjx/QSQ3RhvenWIaBVZGjMJNleakszPM0fAK7+OfH/mb+bVk1gRRtXSBAjwKsrsmzUS97/v98pEToeZEtClOxb/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375862; c=relaxed/simple;
	bh=/m+qZX3GE2vueYUVxSJYZIZSBD+L1SoJnYkbFNzhTUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2TwEuwMNZr4Q/UW5CJ8QCeOemEqtqR3PTgbK4jiXTWne9o2MccWGtXAoBnc0nG8uFHNONsKBHi0wVARERPHRbm/x1Au6X9qRh+oBVrkcMkqUmlMg06O7145TCpZxYyzXQZPHJ5B8sQPUcSUgyhW9ktYsIbE1c0KGftJy/zXt+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIw+NCkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C64C433F1;
	Mon, 19 Feb 2024 20:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708375861;
	bh=/m+qZX3GE2vueYUVxSJYZIZSBD+L1SoJnYkbFNzhTUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NIw+NCkCxQkhG+0yOzC8rK0lPxpJdlDyiukuFBtOPX1ycDJXbcNB8TnOh8CIa91xT
	 ErmsUqAWujBqOC5xIS/FmXPyCtw4Rns3K6Ejs6X2Gd5x9afyEHfu5vv/UPjd5TFO6s
	 bJlN9wGXzyls+Zt5PQxTXC0w/+Lq7FJSX6FqfBV31uPzuxPDoaFww0u+oI8UXL3cj3
	 +LnbqBiymyVDcAX3juy/mKSxKXHOgaSURQ/y/mVlllFTGAu75ZthXBNj1ewjZfliE/
	 s+Ee48iF1QNOfQlUDmYiXDsdbMCDp6hz3DjkHT5hKAh5Er9bAAktBUMEopwl0WuVP/
	 xgkb2/g0pJHGA==
Date: Mon, 19 Feb 2024 12:51:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 03/13] tools: ynl: allow user to pass enum
 string instead of scalar value
Message-ID: <20240219125100.538ce0f8@kernel.org>
In-Reply-To: <20240219172525.71406-4-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
	<20240219172525.71406-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 18:25:19 +0100 Jiri Pirko wrote:
> +        if enum.type == 'flags' or attr_spec.get('enum-as-flags', False):
> +            scalar = 0
> +            for single_value in value:
> +                scalar += enum.entries[single_value].user_value(as_flags = True)

If the user mistakenly passes a single value for a flag, rather than 
a set, this is going to generate a hard to understand error.
How about we check isinstance(, str) and handle that directly,
whether a flag or not.

