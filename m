Return-Path: <netdev+bounces-130820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BCA98BAA5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99803284FCE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92111BF813;
	Tue,  1 Oct 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1is1lxi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5C1BE86E
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780844; cv=none; b=OKXvtKH+/nB90sbYb3g/rPKiLDhGgOJP/DyVvIapHWLcupU7dtsLxZS6AuBW7sq5fuYrNbePeiIfG7wpj9aEcOKO3Ws1PntXMOxnmU3RcQCEdvPMU/wCiI6PTqTzA9utYluHo4X7M8+1W4UmMk6xHQjmNOHySAanVzJjI9BnUK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780844; c=relaxed/simple;
	bh=IJUBcrZdjtnNd9It4GJJETk8+bq6AmJ2FZZXOQxhG5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSTgCC2aNXgt14IY9tGb9O5/YeewQAH0AAKTbG+t3NGBF/7RIJJZ+UJM59+nJvjwh8s5X3JbZ51Odv/XpJ+TD7MXA0KQNM9xkiZO9GvieX+SEaEJx1oaHjJUoU/qlFP6mzIdi2qGqxLx8QkgWhp/cC7NqBEfKYFdxCR+dnbXbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1is1lxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6136AC4CEC6;
	Tue,  1 Oct 2024 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780844;
	bh=IJUBcrZdjtnNd9It4GJJETk8+bq6AmJ2FZZXOQxhG5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1is1lxisFvPcZ/S53DLjD9vRPSOM3Ej0gmvcsiG2W1kNHPHdo56IeKCQODhbtRGY
	 ZxFYj+2LIoW4NxTFiaLKPrzAIBf5pZcFXDuszB4D5u/QQmkjkNBIQZGCB0bzSvw31h
	 jpMeBEl/AtvCakM7xZvQZ8Mll2gokLyix9pgzvKp4C/V7IwA+ZEvc3rqU7oLuoFAke
	 Q1GUvkDkhHuerKgEBWVO/OKdCFbBBZiGV8dUFtJJw7kQuThbRdPlejBgHjSbID8qq5
	 j3IQ5OGJvQiemuzv19HMkYFIETFVik8/NSZJtxDQQF2BG7XTFex5/1mKQaEVwLeVES
	 b/YJLgaCU+USQ==
Date: Tue, 1 Oct 2024 12:07:21 +0100
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com
Subject: Re: [PATCH net 2/2] ibmvnic: Inspect header requirements before
 using scrq direct
Message-ID: <20241001110721.GN1310185@kernel.org>
References: <20240930175635.1670111-1-nnac123@linux.ibm.com>
 <20240930175635.1670111-2-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930175635.1670111-2-nnac123@linux.ibm.com>

On Mon, Sep 30, 2024 at 12:56:35PM -0500, Nick Child wrote:
> Previously, the TX header requirement for standard frames was ignored.
> This requirement is a bitstring sent from the VIOS which maps to the
> type of header information needed during TX. If no header information,
> is needed then send subcrq direct can be used (which can be more
> performant).
> 
> This bitstring was previously ignored for standard packets (AKA non LSO,
> non CSO) due to the belief that the bitstring was over-cautionary. It
> turns out that there are some configurations where the backing device
> does need header information for transmission of standard packets. If
> the information is not supplied then this causes continuous "Adapter
> error" transport events. Therefore, this bitstring should be respected
> and observed before considering the use of send subcrq direct.
> 
> Fixes: 1c33e29245cc ("ibmvnic: Only record tx completed bytes once per handler")
> 

nit: No blank line between Fixes and other tags please.

Slightly more importantly, perhaps naively, I would have thought this
 Fixes: 076ae667be9f ("net: netconsole: do not pass userdata up to the tail")

> Signed-off-by: Nick Child <nnac123@linux.ibm.com>

...

