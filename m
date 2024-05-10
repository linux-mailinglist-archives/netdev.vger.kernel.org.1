Return-Path: <netdev+bounces-95428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788778C2383
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175731F22698
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAB917279C;
	Fri, 10 May 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaI9S+Ow"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD5C17082A;
	Fri, 10 May 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340517; cv=none; b=KQQoM5Buc5GnRbacMvo9/KjavIhzGKQ5wePVuIa2jQHoJbWBUFD4bcw68pMfXuEUw3Jip9NEIPDte2EQUpEPfbSc7JobLMafWLcpPWbCRgNU6XHawXKNAPq4gdOieivk9ugUVB0ldfkFiOXCyQs8yd7Xp9+TQZu6ghRCyNTrGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340517; c=relaxed/simple;
	bh=VjidK1s4OWd/3MT51iGA2Jy+KprZUVq1rMsqwlZarsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgt8Fvl6xpQIf0cx9B3daYhyfFptHKxvq+jzhGt0McZVYY3vvf1FU4SIXDNpSp0PR40t3Ehyl6llDk6iRzhwGGaPXEcTox0skaYpNVWjNCun89ozl+UxbJa8Byq+lrePqqsrMLtA+BM/T1yzN/I9TsS9cUOim1ZkWGlBsMg82CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaI9S+Ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCB9C2BD11;
	Fri, 10 May 2024 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340516;
	bh=VjidK1s4OWd/3MT51iGA2Jy+KprZUVq1rMsqwlZarsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaI9S+OwFS9NEUT/5eixzrMiTE5eZDdAf3P+HUUyzjKTzVCMZHIASt1OH79PJmEfe
	 7XbvV/XakUNGN+KdrF/d5cYw2oFTehq9YLoQ9ugyMsVmlbtktPqFJBzVI315X0Evdf
	 VWRSXkB5BlhjJRsZAmilOS6WzKjJIFfU1G+eLqpCG1wbRzsj5cg2MUNp5qwf1a50lu
	 mXQLkUJ4HFHq+scpvlZMNTF/cJPushGLkcsjWRiZHbdM+7R7mEP+F8U23MRFwi+o53
	 Ms/pmOCYKXjGjI5jthCQTEgGkv3Fm4KyR4r6MzmEdTrxqm+Uli8ed6WjFY2dP9bR41
	 iLHeo0uvLCdEA==
Date: Fri, 10 May 2024 12:28:31 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 07/14] net: qede: use extack in
 qede_flow_parse_tcp_v4()
Message-ID: <20240510112831.GJ2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-8-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-8-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:55PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert qede_flow_parse_tcp_v4() to take extack,
> and drop the edev argument.
> 
> Pass extack in call to qede_flow_parse_v4_common().
> 
> In call to qede_flow_parse_tcp_v4(), use NULL as extack
> for now, until a subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


