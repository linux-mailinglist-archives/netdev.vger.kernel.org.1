Return-Path: <netdev+bounces-94903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F39E8C0F7B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5CA282F09
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA614B091;
	Thu,  9 May 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtKanHZp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDAB12F5B3
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257050; cv=none; b=QX4o4Dm9iVWpnH9ICPFwGNnnOEPvW6vZLkiL9F/0IyQwuGn1e+oGGsl46mUWNrK8ygN8wchGcRx1pJ08jhhIujJ7sgXhemCMKn3t56ZDypDKTbtWSnjExG7IMquUFast/0ROZzc48X9QNjUpwMNRgkakzERH9ZdNudeNNyWzhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257050; c=relaxed/simple;
	bh=u93l2ocQmXd6ZTLqBswQIFAxD41FspG3/yaz6Yn0MVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc7WhV8XAyTv9yrfh5vVIC0RiK7aknEbDo1WB9B34QYEGNEKEjHTjzxdGaeD0WlrR9E3TfHX6M7zAP+BEDyrTQViZ58bYVFvTPGsgq/BXWAJgFMaJC5XZQ7VL0yar9Gh40sHHaCbig75PV2hOyUcddx2OLyMDdrTveihMAngMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtKanHZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3E5C116B1;
	Thu,  9 May 2024 12:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715257049;
	bh=u93l2ocQmXd6ZTLqBswQIFAxD41FspG3/yaz6Yn0MVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtKanHZpVcWxJVEFr+83hWC3Fk/VAjwEO6e4KGxg08hAnKhGg5zWrDTwb9uRbcTOD
	 YDqrJ8vDz5nABswI/7JoWepsaHGjUb6u8DjwljIwvGWnpj+PV8psJ64oa+CNARdnOk
	 GwDlML6I7p3kozE2iLTxw3bbEj+qmkPZVzRsy9WiTMdxOckb6azxEgSAE+v8fM3KYj
	 9z/jSm7VzIzxBf8SVRe6RhLB9h1X1bZb/9HTNGBQi9TGunThb5VFE0eMmd/atfLTE6
	 a4BwWeMgpouAsIBUVjtoRcAaZIq2qz5gtOqsHmmFa03AsuutX24yCQB4JaU7Xy1wz6
	 IacNpidWE20jA==
Date: Thu, 9 May 2024 13:17:25 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 09/12] gtp: add helper function to build GTP
 packets from an IPv4 packet
Message-ID: <20240509121725.GS1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-10-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-10-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:48AM +0200, Pablo Neira Ayuso wrote:
> Add routine to attach an IPv4 route for the encapsulated packet, deal
> with Path MTU and push GTP header.
> 
> This helper function will be used to deal with IPv6-in-IPv4-GTP.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>


