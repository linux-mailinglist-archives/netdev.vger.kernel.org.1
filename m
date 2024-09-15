Return-Path: <netdev+bounces-128404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47435979758
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4568B21088
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C315D1C9848;
	Sun, 15 Sep 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igjyk4DY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982871CF93;
	Sun, 15 Sep 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412292; cv=none; b=kVi1Oh8onW+tabikQYC3oNm3YK2WEvIv0NKLYTA7LRbqDdu+KbVxb9iq1uIYXV8rutipci03b6V+x4RMu7Q1OaxRdzH2qUywzkjTs0beC0epm72bKN7ahRwOO//cT1ym41NYAuXtl7PIN67yMLZrA87huNUJVMmoLJKYPRBi47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412292; c=relaxed/simple;
	bh=U1sjKtLt8zT/5WpFurLK8OmAk9Suf2Q03BprragVRvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1XRmKVDXBhLBun276QlG0OtUq19F0iYgPE3zdADEMin1TmNxd4B5bmYlKAsTrbwXhJOp3oA4p3T4pwTdGM9agtgpS8UPl7Tc1DxI+URjdZDXPL4aAdYEPrCWTRhN1eQ4FW0SqQZxQy8M0B0IZy4K5soeuODgj8HVQrrT6/Nobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igjyk4DY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90380C4CEC3;
	Sun, 15 Sep 2024 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726412292;
	bh=U1sjKtLt8zT/5WpFurLK8OmAk9Suf2Q03BprragVRvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=igjyk4DY2rco2x+rUZY79KsAzHykl6B5UT29ZAUbBNr4sXHYzRivBx61TIW192fGT
	 FiyPzqciGbJhuiKxEbNMX/724QHzdFAQMfPhkmXVEv0ppM7VYj2IIsFoCXGMU1AmWZ
	 aqqn0mXn/0O6dQHcKLb6UEMpipNZiayS1axSNCpLiQjoCFtDKC+XFc4m9C3YPHSjtT
	 zTIeC9Yq3zVue3R+X2c/sfCyP02qkm6sNU/ZOBVhxjkGA4S3U1TSK0yVMRj4kdytOt
	 b1lcqtufIvMFzDx0XvfRdrXkviVYZqSMiDqEbwR+2GLNWNn9ZEsBe4cN6T7/Wewuyw
	 mxUanHmdJgooA==
Date: Sun, 15 Sep 2024 16:58:06 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 thepacketgeek@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, vlad.wing@gmail.com,
 max@kutsevol.com
Subject: Re: [PATCH net-next v3 03/10] net: netconsole: separate fragmented
 message handling in send_ext_msg
Message-ID: <20240915165806.2f6e36a8@kernel.org>
In-Reply-To: <20240910100410.2690012-4-leitao@debian.org>
References: <20240910100410.2690012-1-leitao@debian.org>
	<20240910100410.2690012-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 03:03:58 -0700 Breno Leitao wrote:
> +	if (userdata)
> +		userdata_len = nt->userdata_length;

I think this will case a transient build failure with
CONFIG_NETCONSOLE_DYNAMIC=n. kbuild bot probably didn't
notice because subsequent patch removes this line,
but we should avoid potentially breaking bisection.

