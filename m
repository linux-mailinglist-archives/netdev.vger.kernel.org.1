Return-Path: <netdev+bounces-94895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455CB8C0F69
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021282823FD
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333114B95C;
	Thu,  9 May 2024 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOFT55PG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2513174B
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256886; cv=none; b=OkWb97tZ7O1vjPmDq2fpUeP6suww778K0yyJSwpWpOXxdA+IkVYe8lipPg/VpR0rlG0Q2sD4cB8kXAWXYzh05V2x8OvHGzLQeeTOvPBZ71ZIx/FI5fbN7X5+iXjzqtvIiKRpdXeFmKvD9vfTaFYrsc/Cz2wB3Ki68x7jGKQFJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256886; c=relaxed/simple;
	bh=jcRZC5HCMVEOj4rJQRs/ozXAVgsg2hXzB4C+DdmCiwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoexlJBZecWsp+EFG9zJ4a6EWaL8rgsmfZbNwYK+1yqBMZnBtS0NsQBJZaphAfIXGSMOBQSZuyQqvnKiDlLgt+JHYOKp0YBAQbeWQ+uqHdz8249zK7kKSYtv+uxv8/cp+VvZ0z+3BTmlYzuoNmgGrBjxGerQWxwk8o6M1UmsEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOFT55PG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7591C116B1;
	Thu,  9 May 2024 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715256885;
	bh=jcRZC5HCMVEOj4rJQRs/ozXAVgsg2hXzB4C+DdmCiwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOFT55PG1oZL1BLJvkRR6LnplprC/+7QE+NRDBNm4kay0pGJyDXydavFON+jD7fna
	 Oa6JRwL41a7yx/3TEswFmyWU4GV20ah8UmSSvyc9acjZguNjEIhW4haGw35E2T2VGo
	 g7mj22emZoP5foc3tfIdIeK57h/LMGnR+AF43qAn95IfOuxcUxsmP1YKWIeZneGwK6
	 9fefEinshmmH1iZCiuXgALvTMM1tVWtt4uOwmrjwvg/ahMWRsfKJJsE2LY79ul+4lQ
	 xvO3JYHZs5C9it9kYjUvkz1BGSN5yVBKYVNEYhny618hIR9Gap+twrz66kCaDAzGF1
	 Q9UrOAu3/OluQ==
Date: Thu, 9 May 2024 13:14:41 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 02/12] gtp: properly parse extension headers
Message-ID: <20240509121441.GL1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-3-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-3-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:41AM +0200, Pablo Neira Ayuso wrote:
> Currently GTP packets are dropped if the next extension field is set to
> non-zero value, but this are valid GTP packets.
> 
> TS 29.281 provides a longer header format, which is defined as struct
> gtp1_header_long. Such long header format is used if any of the S, PN, E
> flags is set.
> 
> This long header is 4 bytes longer than struct gtp1_header, plus
> variable length (optional) extension headers. The next extension header
> field is zero is no extension header is provided.
> 
> The extension header is composed of a length field which includes total
> number of 4 byte words including the extension header itself (1 byte),
> payload (variable length) and next type (1 byte). The extension header
> size and its payload is aligned to 4 bytes.
> 
> A GTP packet might come with a chain extensions headers, which makes it
> slightly cumbersome to parse because the extension next header field
> comes at the end of the extension header, and there is a need to check
> if this field becomes zero to stop the extension header parser.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>



