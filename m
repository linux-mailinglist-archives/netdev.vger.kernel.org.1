Return-Path: <netdev+bounces-217386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925EB38815
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B4D7AFAE7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8E42D543A;
	Wed, 27 Aug 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6DLKjq9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD03276023
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313750; cv=none; b=OEgWHyyR/uwErkLFXwCuGOEPbFUpl2UiJUdjrUWGzUM2OKiPPmNEYnxlveSEWBJUd9f1+y+m63YAg5Kqj9PSRliUnailnPV3AR2byeiQTEMwJB4RTDPZ92xS/PVqdOQ5QjWiU6lrhJASsUKlCoGqpyRItTLxfxZnKe4SFgaQK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313750; c=relaxed/simple;
	bh=VG3P9eVQn6nlFN3+mBllTM4E48rJVF3S+KPtsLx8pHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na9uOFSWbxp6WNQglE8AmfS16t95KOv8rWO0hIV3HLLb/qzY4AdHDDFoSt0z7LCq2H6r/W72ZDP56ql1O7byfPxjaBZeoTtc/bRE6L92/8scGQ9Ik2RBQoTYawXulCG1AncYKfuKgnaIKHqRGx3RFo7KGZrCFFRkMmYmjUr5EMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6DLKjq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F9DC4CEEB;
	Wed, 27 Aug 2025 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313750;
	bh=VG3P9eVQn6nlFN3+mBllTM4E48rJVF3S+KPtsLx8pHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6DLKjq9DIsp3oHf5/hNzftif2kyY7JhNYxQGa6dIZPnZeZ4xYi+p/L5QXC9t7ZJm
	 6fiLFi3Gf6+2Flox1AxgQZJjkjmVLj9357+OLKq/1jCKkYJJWrqGm4sdH63TEnYzn2
	 o1yr62fJdAFkJJJe8Gwo+6AIoHqY0L3pkcvcDcPsTKWbulJuCUnasmvZz1adNLPrxj
	 bya1mtFqjcH4yP0EIiImwY+QAelZpR4Kfs/kQ2kgkiCz3ilUKPB4Tk0KpvnEYeSPFp
	 8K6lDjidOBX5c5A+sMuTCbPLw5gaAOvN/b65v2OC6MNbopSTY9g7G8SvV38shFIiDS
	 COba5rFnOi7MA==
Date: Wed, 27 Aug 2025 17:55:47 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/13] macsec: replace custom checks on
 IFLA_MACSEC_ICV_LEN with NLA_POLICY_RANGE
Message-ID: <20250827165547.GK10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <398cf16191a634ab343ecd811c481d7bdd44a933.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398cf16191a634ab343ecd811c481d7bdd44a933.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:27PM +0200, Sabrina Dubroca wrote:
> The existing checks already force this range.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


