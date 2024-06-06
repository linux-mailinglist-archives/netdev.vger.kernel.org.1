Return-Path: <netdev+bounces-101246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C78FDD2D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0AE1C22178
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F651C6B8;
	Thu,  6 Jun 2024 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rysmd2z3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E987C13C
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643321; cv=none; b=Ob5AdjWvdPhl63VqUuq5ioyanr83KT31Lw+JAwOSOPIesG49ImXvglvO2yNgO92MKh12bPbpG7kmOabQ3q6yiDmN/0kJ5tRQrtQAafh6haJLQSuQZ5vZy7O/fKBlU+i5+NuJhPkQdb0ah/VTLkZqV+32Btg3ZclSsuBQiCfJyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643321; c=relaxed/simple;
	bh=mZUZiSrqmz2rgaNLIKNrfd9kb5DxV+XQXb9pOYnqGGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djgMO4iACXTd6OMJGsI8LYU5l/KlwH5gcrAPto6R1cqO8cSPdcy+WjMpyV5ouHZPxwYAPkvyPBc6Dr0lyiWTdLqBCgwrkR3G5ZWgO4WwzKBrMsgBBYWdZ+O6uUiv3NHWi62xpEjep2Hx7btfyktqbMO95kpz8su430s4JhW0Kc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rysmd2z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BFFC2BD10;
	Thu,  6 Jun 2024 03:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717643321;
	bh=mZUZiSrqmz2rgaNLIKNrfd9kb5DxV+XQXb9pOYnqGGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rysmd2z35d90PL4ALEYuNlBHmPxzQyDv2a9eM0kL0Y51DaTEfQfOnWHjIgiCLA07m
	 y8eRUqGMryJYS7dgPvzVdiXdzu8jOeGIEMwkAvqNJ6t78AIg1NbDqJJRANnTrLSLAz
	 OXuujM2T0R/cPUp54gbX6Nk4JWpN55PmLmkc/SrQ+aUJvRFcTCq48H4jS4SrmNpZfY
	 uCJAR+f90H9P2uwy3Bzv4Ep9E115wz02gHbMtjRSZ6RqZcXR/Q/yuB6KmQkgt3ouEg
	 jYLifgLIM3yp6OjdPx5YEV+0Hp8iHGtfvglCN5ljol/vKTE1cVi2tNhs4F72CRxjL8
	 K5qZGDHHAZuKQ==
Date: Wed, 5 Jun 2024 20:08:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: core: Unify dstats with tstats and
 lstats, add generic collection helper
Message-ID: <20240605200839.5127eb8a@kernel.org>
In-Reply-To: <fec284041a4a4ccc450fdfd504aae4f24458b79c.camel@codeconstruct.com.au>
References: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
	<20240605190212.7360a27a@kernel.org>
	<ccb2a7fc282d7874bc3862dad1ca7002b713ac33.camel@codeconstruct.com.au>
	<20240605191800.2b12df8d@kernel.org>
	<fec284041a4a4ccc450fdfd504aae4f24458b79c.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Jun 2024 11:01:01 +0800 Jeremy Kerr wrote:
> > Right, but I think "no exports unless there is an in-tree user"
> > is still a rule. A bit of a risk that someone will roll their own
> > per-cpu stats pointlessly if we lack this export. But let's try
> > to catch that in review..  
> 
> OK, sounds good! I'll send a v3 shortly.

About that.. :) We do advise to wait 24 hours before sending next
versions in case there is more feedback / someone disagrees:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

