Return-Path: <netdev+bounces-137198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A79A4C0E
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 10:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C43F28424B
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92F1DDA30;
	Sat, 19 Oct 2024 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBJwaW41"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323A1DC04B
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729326922; cv=none; b=XgtDrwn2PD+yd+lvqiptt6iD9ZaW9sXCn/eCkZ0noa5KQAlwMzsZNG4QtoFi3LP8ERMdnngQ5MHEDGd8R/1IUar50nDpiPLMNCDyO2+jbtZQ0ucoxKl7FT+B5/V1mgr9HA45cM420UxvCtWslU11dNkcVi15HyOF0vzS4uQwa/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729326922; c=relaxed/simple;
	bh=zRFQMEYNsQS8URWjkAwCdUcTxZ2YaSxA6ImkdKBhBqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCMYUo7aQTnoXzM19ORon9WW20BAa39I20uSOnslxs38v8F0sKL1sjz1Tunr5jgz3g74wQdWUOCYTLL6/FZN/jK6C78v2HdpNnN4xk+ScQ4zUa5jqwk3u8OaC5HsGrg381XMtstEOCUlvjl5VQKv7pIY89nEugaLZqhfTmyuBgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBJwaW41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95410C4CEC5;
	Sat, 19 Oct 2024 08:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729326921;
	bh=zRFQMEYNsQS8URWjkAwCdUcTxZ2YaSxA6ImkdKBhBqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBJwaW41j8Ktq4XuagYkoRNWfTXac6uUfWWCsBCI0DqmmkTsttl60Z3sbw/fiN+PR
	 m0anlfH/KcLvWl7qntLfU47j++nddyh3rKy4h4GHWwRwiDlIJjNoZqhlQsyZGW6OH1
	 QK6pQPw8v0YaEXGa6D3nm8sgjNKsRmIyG6zcyLm907WGZUiaAkEWra//jECzK461NK
	 iQmH9v+zIdqybU/7WFUammaUxoOadiLF9AL4TJh8zwQ1o2MtL5fRNhsoSdO+QocLn9
	 fnseOZDvolp1RrghWeDD08A7xHpV+HC7dU1sqWMk+OqfGejJjmMZP3JwTVTwnf7wQa
	 QUA15vC7Tnmqg==
Date: Sat, 19 Oct 2024 09:35:17 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH iwl-next v3 2/2] ice: support optional flags in signature
 segment header
Message-ID: <20241019083517.GK1697@kernel.org>
References: <20241018141823.178918-4-przemyslaw.kitszel@intel.com>
 <20241018141823.178918-6-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018141823.178918-6-przemyslaw.kitszel@intel.com>

On Fri, Oct 18, 2024 at 04:17:37PM +0200, Przemek Kitszel wrote:
> An optional flag field has been added to the signature segment header.
> The field contains two flags, a "valid" bit, and a "last segment" bit
> that indicates whether the segment is the last segment that will be
> sent to firmware.
> 
> If the flag field's valid bit is NOT set, then as was done before,
> assume that this is the last segment being downloaded.
> 
> However, if the flag field's valid bit IS set, then use the last segment
> flag to determine if this segment is the last segment to download.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v2: co/- authorship change

Reviewed-by: Simon Horman <horms@kernel.org>


