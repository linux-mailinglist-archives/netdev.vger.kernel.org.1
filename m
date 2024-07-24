Return-Path: <netdev+bounces-112834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A3893B70C
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 20:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A17CB23F68
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 18:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD115FD01;
	Wed, 24 Jul 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9srwDYF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135215B13C;
	Wed, 24 Jul 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847186; cv=none; b=uidkWhYzaYRWcAgQESGkzxcMyYhZSPYKFwatxW3serZ3yQG1k0MifulU+ZIf/HQzpa4JceprZxMhO7XsYoF4v5z3SowecmEwtYkcFqoXS0YS+QSdUzsJ51fGDzQKuDaQ+orVn2+K94N4KDngqOZHP2s2GxjMVqYSF4dYbCImJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847186; c=relaxed/simple;
	bh=fO2lryZMg47qys0F+8lSwFQGsYfIVkdHrQsZKJpNwnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6eilMuGjs+nuIc89rbIZWhU0703NKjYnfRUcFGVJ8ZDNoYZKCUiXkTFwiCEK6Y24EpU1I8/PL6ONSEhVDMZdKUHA/QaLzHtIio6GPPXEk2UWA7ECnHcwoWoVc8BT1C7uPdYDddGy32AXBftH0C15F4vWxvvK7bXWkcton2JVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9srwDYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B13C32781;
	Wed, 24 Jul 2024 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721847186;
	bh=fO2lryZMg47qys0F+8lSwFQGsYfIVkdHrQsZKJpNwnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9srwDYF5zUSnwsV6r+DbdndrYDOdGrkFhKXmMzwCD/HDYthlS2dLkEeLw9zLQN20
	 OEAIkqu0vxZZh1rbOjUffGSZWUH8idsks3U3eHrMOEsRZSf8InsP26h7E6Bt9Vvzuu
	 ls4Z6RuEMR2hUbK9x8QFwPIClykbimCPB9/22PaVAEIFjghHqxchVYaR1CfQjSb4Ek
	 Ee4aipJPUJREuSmnqWxl/HX2biFGL/K3rfjmvEdw0qnffGT4NtqmehhfnZXHulH+Bg
	 KaTLL36c60JnRZEr6hu560TjQk9OvckvHjM8q+B79Vtz1tUj5JujrTgJ7S1CvP94XR
	 yp4QEk43wx/tw==
Date: Wed, 24 Jul 2024 19:53:02 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Karsten Keil <kkeil@suse.de>, Karsten Keil <isdn@linux-pingi.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-XXX] mISDN: Fix a use after free in hfcmulti_tx()
Message-ID: <20240724185302.GI97837@kernel.org>
References: <8be65f5a-c2dd-4ba0-8a10-bfe5980b8cfb@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8be65f5a-c2dd-4ba0-8a10-bfe5980b8cfb@stanley.mountain>

On Wed, Jul 24, 2024 at 11:08:18AM -0500, Dan Carpenter wrote:
> Don't dereference *sp after calling dev_kfree_skb(*sp).
> 
> Fixes: af69fb3a8ffa ("Add mISDN HFC multiport driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/isdn/hardware/mISDN/hfcmulti.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

I guess that this is net material.

Reviewed-by: Simon Horman <horms@kernel.org>

