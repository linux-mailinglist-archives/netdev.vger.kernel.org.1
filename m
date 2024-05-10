Return-Path: <netdev+bounces-95427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E478C237E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B4EB24C99
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694E16E894;
	Fri, 10 May 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVn8gyFH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F120770E7;
	Fri, 10 May 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340499; cv=none; b=TEexPezprMqyHc6/4fsJz1JTKEDPJS6rxMXvDl9cVU+EfB+sZ4Oa0WKl+BYJNnbqEOALRlVUzwehsqRl/M9RSJY8IBUqzqFokcw0UYLwGbl+WihR1q23sEtk/Jzo7Jr72pk3BfNifPmEuIm2+FQuAB+FCk9Er4fmy2FHo9PrsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340499; c=relaxed/simple;
	bh=cwfQY6H0JtRsywqi9DeJXovbh8i8oOQ98Q5xl1/CNSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2MxGQX1igWWUlkQRUH+Vva/Kz/RbvXqw7cpnQ/jAvB7tcXcQySrcivzkT+GFQDnvtZwXmCMeM1nEpzKEx+yMoJ+cBWu0mo4wM8yt43uxvglHGb3maSys5KNQzuKdJkLtA6Q6H9bCp86d9HydIopNDzL/yzwpseposXcxQGwiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVn8gyFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB840C113CC;
	Fri, 10 May 2024 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340499;
	bh=cwfQY6H0JtRsywqi9DeJXovbh8i8oOQ98Q5xl1/CNSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVn8gyFHd2vmnv39MxTzB12BojEbmbEgw0xLq67W5fxcxN39HqsxdxMeNWf14UPTa
	 peVaQMzwD4h9vQEduxVZXI07nOdKRFQR8LdsweafSt7XaF9XAGVDub6I+TQknM64Np
	 YUZk/dW6QUvL62CFUG9T8gLWYpgJZ2BZIiCvucBHe9Gu8l1LP0Eeh7sFs790zoY2tg
	 I+6/uBiVmoYFpLZnTbOnICNQ7vDzHojLITgKRDt9q+lLl24DO0Ys/hWWPTxBV2F62d
	 nVy0EpFIjqwVwDUpYCExXJdikbGw0mAfdOPifQYCBJVs89oaAB3ql2VbIRH+2v7+bY
	 ibK3Pg3uKtf2g==
Date: Fri, 10 May 2024 12:28:14 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 06/14] net: qede: use extack in
 qede_flow_parse_tcp_v6()
Message-ID: <20240510112814.GI2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-7-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-7-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:54PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert qede_flow_parse_tcp_v6() to take extack,
> and drop the edev argument.
> 
> Pass extack in call to qede_flow_parse_v6_common().
> 
> In call to qede_flow_parse_tcp_v6(), use NULL as extack
> for now, until a subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


