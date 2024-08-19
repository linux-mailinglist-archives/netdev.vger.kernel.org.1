Return-Path: <netdev+bounces-119641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A4D95672D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D131280CD1
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707815B96F;
	Mon, 19 Aug 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR5Onn7X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23010143C63
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060086; cv=none; b=WEr7jbe/A+Oq2+g9tECOXFVmxcL+MI3GBsS6Z26Ab1YGe9aRXsu1AWG152/wrUQkveAfvoiPzjxPZbidY57LH9HYcdPS99lvk1PtxlMK4Ro4fzwDpjyUDGf/UPsWD/jUnWCI2T3ESojxlW5LDZExEtwvPEPKgXBXnWAjYVGVVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060086; c=relaxed/simple;
	bh=x/4DTNok/TEYL4vZnw96JP8oUmLb+gUITpOfHEFsGJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlFy3aMCnyAwLRZb60BvDAFedZovpsxmypEJvWdCrhobeVRhuld/mn8CKHgO8fP+2seCLfAKTxo/ZJ7si+CzxxbOXq+lZurik61jGA3DyhB8Pj0euAT6CbE0bpCKXczrxidnBJkQTQ82bOmIMeEK6LQrqMXQB6KlPcJEtu9d+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR5Onn7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269E6C32782;
	Mon, 19 Aug 2024 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724060085;
	bh=x/4DTNok/TEYL4vZnw96JP8oUmLb+gUITpOfHEFsGJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lR5Onn7XRA+c+Gp0BVB5KAEEpzwGeykZCUfaiTPGiTCtM+6KS79FWY+bicc+rxM9C
	 +rhyqWblMtxcrj0CQ9xWEsIXhZXu5s1bo+lD/uZroWyLz2nNYXBLTjTm2coRhUR/Ba
	 FtTTByyITujij38cOFWfEhdQN1KmQx1nQVVpsevgCgu1YPnu8fERRKbjrfOAWWUbUN
	 xqsjocGDekZjl6eIqwXnNRnLZ74nPIrN/ZjJU3zFX/XfX8AxOaYoSWK2AtJkuPN92k
	 GQKThbzjeyXrmUexuqU3WnW+EJndFxBupJ9yoiXJMe9ETrWxMqr4Wpmq5kITVVV2NB
	 qaC9wIPTjtuDw==
Date: Mon, 19 Aug 2024 10:34:41 +0100
From: Simon Horman <horms@kernel.org>
To: Christoph Paasch <cpaasch@apple.com>
Cc: netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>,
	Craig Taylor <cmtaylor@apple.com>
Subject: Re: [PATCH netnext] mpls: Reduce skb re-allocations due to skb_cow()
Message-ID: <20240819093441.GC11472@kernel.org>
References: <20240815161201.22021-1-cpaasch@apple.com>
 <20240816111843.GU632411@kernel.org>
 <967C2745-1EDB-464E-9C80-46345CA91650@apple.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <967C2745-1EDB-464E-9C80-46345CA91650@apple.com>

On Fri, Aug 16, 2024 at 03:20:03PM -0700, Christoph Paasch wrote:
> Hello!
> 
> > On Aug 16, 2024, at 4:18 AM, Simon Horman <horms@kernel.org> wrote:
> > 
> > On Thu, Aug 15, 2024 at 09:12:01AM -0700, Christoph Paasch wrote:
> >> mpls_xmit() needs to prepend the MPLS-labels to the packet. That implies
> >> one needs to make sure there is enough space for it in the headers.
> >> 
> >> Calling skb_cow() implies however that one wants to change even the
> >> playload part of the packet (which is not true for MPLS). Thus, call
> >> skb_cow_head() instead, which is what other tunnelling protocols do.
> >> 
> >> Running a server with this comm it entirely removed the calls to
> >> pskb_expand_head() from the callstack in mpls_xmit() thus having
> >> significant CPU-reduction, especially at peak times.
> > 
> > Hi Christoph and Craig,
> > 
> > Including some performance data here would be nice.
> 
> Getting exact production performance data is going to be a major challenge. Not a technical challenge, but rather logistically, ...

Understood :)

