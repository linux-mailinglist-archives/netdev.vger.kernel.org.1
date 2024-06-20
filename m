Return-Path: <netdev+bounces-105371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C9910DA9
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E23FB23B86
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57711B14FA;
	Thu, 20 Jun 2024 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2tcGz+7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168217545
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902469; cv=none; b=oIploBS4ehzrhzU2BGggm/MPJHO3OJ9ezFntA6vuHu+k0veqIHVMHcQYjRMv+tV9mS/zxlIEuB88Gg8XrqydSTQYQAYISlzSQwtddBdvgGCcqgNK0GIQJHLlSiDcuz9XGWM2dxUS1lTqzaHk+ZfE4A6ImK1AIbV2uiD8XNp3OCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902469; c=relaxed/simple;
	bh=5M3C34tIE0ucTolh4z668KgSqh9mMS3emITSyiqEQuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGuYlpFxvAlGyuJWGfaLcWSETCJ2lHA+tzWrPh8MktKDizRhAzaV/8zJKnNu8t96Lb9gZtB8I2+oBMS61fgjD/w1oOcNHZBG3JzQhxvJIyeviDaDhfQwvEfvaRQdBMOEJJXo+AkKtkVFnsAeWRJF2QzTeMkRCbBN9ioxBxW9R6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2tcGz+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75FCC2BD10;
	Thu, 20 Jun 2024 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718902469;
	bh=5M3C34tIE0ucTolh4z668KgSqh9mMS3emITSyiqEQuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2tcGz+7s7xSTwL3isE4YpQ710bUko+l6c+KZ097Tmp1KxmGz5ZSBUj1LKnhU0XDO
	 xcIteviy4rQ8a5YWONF/dSOgby0z/wAnxx4vpcLkE9te2gaiXKDr5MlevEQK2uGhcY
	 If6wdI6nwk6sZCpMdFcZFI09rh9+IjSRdGKV0Qp70EeaKGMF9nSaJV5TRIjKpQ24rn
	 Wgsr1amajx9RbVr0L7VggA6wqtFdImuMxLyBqOE5mjAumpXP5x6ihyzIyrkG5zEJAE
	 Xz2lwf5H9AhMgbvT4vdakgwL51wWuJNmBojEwXQbQy28ZJM846tLzfM8JKvTBhaTNj
	 5a6/YBlE4Tczg==
Date: Thu, 20 Jun 2024 17:54:24 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 1/2] bnxt_en: split rx ring helpers out from
 ring helpers
Message-ID: <20240620165424.GM959333@kernel.org>
References: <20240619062931.19435-1-dw@davidwei.uk>
 <20240619062931.19435-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619062931.19435-2-dw@davidwei.uk>

On Tue, Jun 18, 2024 at 11:29:30PM -0700, David Wei wrote:
> To prepare for queue API implementation, split rx ring functions out
> from ring helpers. These new helpers will be called from queue API
> implementation.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


