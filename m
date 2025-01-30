Return-Path: <netdev+bounces-161616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A9AA22B95
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07973A488D
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B917A1B4257;
	Thu, 30 Jan 2025 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQrSE2WE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4033987
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738232608; cv=none; b=shZxSkotn3vIcAbXC9YmAmLsAxnlK58Y1rAaRDoZgM/dNVqxsHKwN9jiZ5zsnkdguBqNt/1IqXb10Y4nPXvBEiIfEjG9hA0ENwGeDSRXCrovhgAOMyIHj7H/s2nk2q1RXB+V2joZD+oujm52UH9PoWGrm7I2M1UdxsVfFJJrMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738232608; c=relaxed/simple;
	bh=hnWaQmSsnDc59VKoKRX4VZGlUO1bQTQOQDzEmlfiBig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fu0zGWect8rBNy6kPTzpjKxr8485H9pZjIjZKplkWrKH6/Cc3So+jN60qGCI3ExhynYIZWYv1W5XBOlE9rxjZvYHCimQAHwfxFhLsgK+wy+FjkinDgBE7D2Ctj9wsPYlBYiv+5smVYpV16D2M9o6xQKs/dMOIoRMptgRLCoIx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQrSE2WE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C22AC4CED2;
	Thu, 30 Jan 2025 10:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738232608;
	bh=hnWaQmSsnDc59VKoKRX4VZGlUO1bQTQOQDzEmlfiBig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQrSE2WE19OYonZ15HghwPPW0mgUZiPMjp6BXPl5lMBZWrdjF5Ew8aIp4g+ji+wYj
	 gGWI/+PALVdyZHN69KQLAZs+y/ryL7wPMJ+7L+GTVhUaTRa2Ib3n0FiXZ6/6kMEKc7
	 +jbRhuzMzcQ43tt5sQvzagrfrK/jVmZ806eZT8QxiHGYg9UzyiNLCv1eTyc0qtmSlZ
	 YyNszndUzfiV8lxi2o6q2PJmMnB0blGkeBRqAqEjDXvSyGho4HBcgL5Sx5ViumltUE
	 R3D3KJvLOk+2vfTzgmkVNfIH0NbWA/rkd6poJI5uARibY6iHMLPhm5kREFGx2uL2Ym
	 lrQXp7k8VQ5DA==
Date: Thu, 30 Jan 2025 10:23:24 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	Justin Iurman <justin.iurman@uliege.be>, dsahern@kernel.org
Subject: Re: [PATCH net v2 1/2] net: ipv6: fix dst refleaks in rpl, seg6 and
 ioam6 lwtunnels
Message-ID: <20250130102324.GC113107@kernel.org>
References: <20250130031519.2716843-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130031519.2716843-1-kuba@kernel.org>

On Wed, Jan 29, 2025 at 07:15:18PM -0800, Jakub Kicinski wrote:
> dst_cache_get() gives us a reference, we need to release it.
> 
> Discovered by the ioam6.sh test, kmemleak was recently fixed
> to catch per-cpu memory leaks.
> 
> Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
> Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
> Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
> Reviewed-by: Justin Iurman <justin.iurman@uliege.be>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

