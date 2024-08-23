Return-Path: <netdev+bounces-121517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A795D7C3
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E9EB21CA5
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AD2197A83;
	Fri, 23 Aug 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8+FgWyj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243EF193087
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444195; cv=none; b=eUM8vTlzlVKBJ1OdNDYew/M91uOcWZa3zpf26udgAzxO2nE1KHTujb0FbHSqTtKCKYLEvGHBUuBn4oWKCkgMh/QzB/GsJGTVUvzUabcMONUWjxQ9A0FCMfnHU6/Y2tjEvF9cQOkk5PqFDWpj6EGkePU44hGplw3CmrpC2vCbDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444195; c=relaxed/simple;
	bh=YzrbcT7Hi/51AtA0uUsSvWlafQ+6x8m36YYXxO+a/aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLSGfpegYZKRvMeL7cGJ7piAiFOevUrj4pc9Sh43BnMywWOdSI0vL9qx6aUFQSpbg0OlEiJtUAS9YbXMHxZ0Y1EZ0llbPMunSajQCmpDnPFgOcIt/IScIB2MCadCxpVv9VUPlMSmySlvWZhOOd4zUCY2p4q4S+N86vRAMkkb9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8+FgWyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728D8C32786;
	Fri, 23 Aug 2024 20:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724444194;
	bh=YzrbcT7Hi/51AtA0uUsSvWlafQ+6x8m36YYXxO+a/aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8+FgWyjALEhKrrfTBC4gfbfj8BzEnnGuJ87SRUtpnYcWqh1CU+Z8quvheXfGbf0U
	 9ymwzbIg5yEq1TSOl1qiCQlRVUx03QorwEqYNLAo20lieQn3rDOSlDPMqpa5Y5WquK
	 IEaCtFm4g0CdlsVo7TDyknRt2ZgaYFpxENIHRhe1aZffCUVRXzpghGo5ZrEBJzB8hZ
	 zibRA0wf1rSoiTiSBUJlJSjkVamZoAoZ+fdZc+TegNhxOVDokLQ+yxssUEZYcsM8Sc
	 m2mY60kE4g1kkrI8DcnRinJEuV7c31vjPAcRQpLlv3s/Sg8ekxAZ0T83aA9AkB0kcc
	 9SI26S78Qh7Nw==
Date: Fri, 23 Aug 2024 21:16:31 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v7 iwl-next 2/6] ice: Use FIELD_PREP for timestamp values
Message-ID: <20240823201631.GF2164@kernel.org>
References: <20240820102402.576985-8-karol.kolacinski@intel.com>
 <20240820102402.576985-10-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820102402.576985-10-karol.kolacinski@intel.com>

On Tue, Aug 20, 2024 at 12:21:49PM +0200, Karol Kolacinski wrote:
> Instead of using shifts and casts, use FIELD_PREP after reading 40b
> timestamp values.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V5 -> V6: Replaced removed macros with the new ones

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

