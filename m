Return-Path: <netdev+bounces-73866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC80885EEA4
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBEBB22C47
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 01:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701711C82;
	Thu, 22 Feb 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cX+4wKZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA48F45
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564991; cv=none; b=QcDmYY/cg0NflNfREy/OZ49mGUWdJnuzqIxWWk+YOpnD9WVh4D2iNzKhKEVJFYp+wGq9u+YZPR0tYlO8bFm3Lt0OS2yu6tHHFRHyZEBRlcxdmWUUCm3KQ6hZ535mtOwW1jFPcxG5Fklhn2t9CxeqCW9FVn8XHRqzqnYCOYmJUgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564991; c=relaxed/simple;
	bh=PeFQCPTyIw+COwJkIAWq1/bCUW+tFnN40oJ86gD0Oo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EruBhrWYti07pNcU1EiYZpe98jdwzFoHqoXQrYDxYpPWq9K/isUMrYFaAQowxi4WqSUIFACM9BFFbCbRFaxfuW1Nd0UP6q3MXyEkS2rAEEHSeib1gzfsaV/6l5v7X/zjNSqfMSmSiy11q6LTiaSbjKJwizzoqhRxUZ3ZQgp5X/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cX+4wKZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E7EC433F1;
	Thu, 22 Feb 2024 01:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708564990;
	bh=PeFQCPTyIw+COwJkIAWq1/bCUW+tFnN40oJ86gD0Oo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cX+4wKZDlgCZVXZLU56mcDqhMluGodLkAAvb5WpLNujJjEq+g/0K/pLWWwG0+HQ2d
	 dMbKOEVZ/+JTRMOgmKodj4hJESRPe6NN9M+MA8HseHtixdUvXduJrQWtQ1KITM8KcI
	 qXbSFB/JizzPsZPVcJTBPDvR/S2THq3GuTkN2B+6NzCyQQdBcsTsKi86Sk7RNNWUvz
	 4fcjFLQHWA8H4m7goTQDCWS43v5Vb8PFIKHAn114pMPScwWyqfyqcn2jAJbdi70SA/
	 300q838fgomiYpOmo+uOVmdgSLAjhkR/0Cw5/FFTeDEcBtaOtS2QvnfRetadp1CEJF
	 oFLD6QAMi1qkA==
Date: Wed, 21 Feb 2024 17:23:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: kovalev@altlinux.org
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jiri@resnulli.us, jacob.e.keller@intel.com,
 johannes@sipsolutions.net, idosch@nvidia.com, horms@kernel.org,
 david.lebrun@uclouvain.be, pablo@netfilter.org
Subject: Re: [PATCH net ver.2] genetlink: fix possible use-after-free and
 null-ptr-deref in genl_dumpit()
Message-ID: <20240221172309.405cc4b1@kernel.org>
In-Reply-To: <20240220102512.104452-1-kovalev@altlinux.org>
References: <20240220102512.104452-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 13:25:12 +0300 kovalev@altlinux.org wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> The pernet operations structure for the subsystem must be registered
> before registering the generic netlink family.

I think this one is incorrect, genetlink is what other families
register _with_. It's special. Until it opens the socket in
genl_pernet_init() nothing can reach it from user space.

We should probably add a comment saying that it's special, I get
the feeling other families ended up doing a copy & paste of genetlink..
-- 
pw-bot: cr

