Return-Path: <netdev+bounces-134326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6C7998CD5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4CA282579
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E851CDA2E;
	Thu, 10 Oct 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4tfqS4j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488761CDA23;
	Thu, 10 Oct 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576529; cv=none; b=nTnciphc91aPDBZdx7s9g1JVzIMyowvwW2uTWC8zBhohw2QaDKtRgllsLRS31ATwjDLEM6ZSpV8RjsmD0UBBG6a/hkjSCDpA2FA//bgbh9Nba9J1kIyqZDXkxSKLJtPO5f7ppDWBJ8W9sN/YvxmYgOqz72F8pPhjnLTfDbkCyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576529; c=relaxed/simple;
	bh=H/CDRM8cNCk2Uyzx9OYI7E5kI6hdfMo4nCgOpogddZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyYpr9VO83o6hD9cjwVfNXEZKRJAr2prVhMBzvu31E44grSo8VUoaZMhr4G+d9fVAdnYgy1DewygyiN1iL5REuxXy+WskZA76Vx2DS4AIy3/eFDSYzwJVTCMwlo8sJSqyMlV2jjTBYES5ZXTnRGiJ+wb6MQ+z7hzUg6CB46sty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4tfqS4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24B1C4CED1;
	Thu, 10 Oct 2024 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576528;
	bh=H/CDRM8cNCk2Uyzx9OYI7E5kI6hdfMo4nCgOpogddZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4tfqS4j0eRoFhq9N4DOjFKqL0A82C7alpYPYR5aCfFq8bnx8fSxr9YCiYxvtEKAi
	 3QVmFuztRGoqqjXvKbCY/lz3//8EyeKJUjBqMe+Ws8qKnMf42xEuk+EcsA3gJyqYr9
	 YujEIrSTL/VF4LlHekER85L4JYSfACZkbqYR1wlqujTB2UEtBWWwCH2PKaEQGzHQfw
	 MEhY6f8gXlYpusNfpYK/8a1rCweZHTG4w6qKALEVKIvhgO0v5U5suLF3RtdLUhxIlx
	 DBekig2HEhssa7Pr5pVzOsiAUZhLJ6oppc8OZjkFWAJz/Bu90pVDM5Uc/MKTJNn9xw
	 wIKRTMfSf1iqQ==
Date: Thu, 10 Oct 2024 09:08:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
 bjorn@rivosinc.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jiri
 Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, Kory
 Maincent <kory.maincent@bootlin.com>, Johannes Berg
 <johannes.berg@intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 5/9] net: napi: Add napi_config
Message-ID: <20241010090846.1857dbae@kernel.org>
In-Reply-To: <Zwf54UVvfyx830sk@LQ3V64L9R2>
References: <20241009005525.13651-1-jdamato@fastly.com>
	<20241009005525.13651-6-jdamato@fastly.com>
	<CANn89iKytfwyax_d+7U8Xw-Wvj5z1d7xoi4LNhmUQphDiborDQ@mail.gmail.com>
	<Zwf54UVvfyx830sk@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 08:59:29 -0700 Joe Damato wrote:
> Jakub: I hope that it's OK if I retain your Reviewed-by tag as the
> change Eric suggested is a minor one?

Yes

