Return-Path: <netdev+bounces-183265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5AEA8B839
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E999B5A2793
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2B248886;
	Wed, 16 Apr 2025 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RokOIi3k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14763248884
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804999; cv=none; b=Ii0630to8RxyP99suWx2YE8r5Oh7iYuDwA023DNc6ITyoieWVZTOSm+ThiiHfxqMJ5PIeY28jKYRX5B65xCwrWNHbhX2vJ7aAky7A+5LUZwUr5qR/x8wful7CohFi25BRuRGQ0UOeIPO2QXVsSbRLuhj+FBIsxF9e9yKtJ51qnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804999; c=relaxed/simple;
	bh=GFyWzZs+3a8jDuZ8Oy0SA1ow5ZKthN0STKRzTP4JbEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz48nactXjZ43GujkyT3smZlAQOnjKX2lROZllKW53xmk+voA2vJ3mqlfNntpbqomFgEyKRyWlGMBm+Nv0oVv67OVYHsWQ/SHLlVfhpmOe17Oqs5jtDjVEh4dON0wHqOyUVBzJTYErcGaU5VOmt8GnqxmSyz2AaEVhBGSEzAGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RokOIi3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D5EC4CEE2;
	Wed, 16 Apr 2025 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744804996;
	bh=GFyWzZs+3a8jDuZ8Oy0SA1ow5ZKthN0STKRzTP4JbEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RokOIi3k+PY3LEqysUCSVF4n5pyCa1gnakjhnvwAtMWqmlBzr3ez1BmLqsjJeaPyd
	 5OYQCjuDjx+md8ktJ1PjRaipn/wiJW3nFK9LDwDPWEtLZQGW+gWdlY+eIIxO1p6YOj
	 DJm2rV5GoXnLb9NWbRNLO6EgQ8zhrDK+DuKx6XkedyN04fk+4GgemTaZnucTCHnJgt
	 R5zQQwYKsbac99+zEB5t/eUBv1f9qM+Wd47l4Q08qWc7gSrm5+s35j/vCNkSzsZdmM
	 GwfiH8Poo5GWmCGKVclFLJQozOAJiHToE1NbuNAW7oDk1VXvuxpppbjjVmoV/hZpK9
	 piEdvTU8EtyHA==
Date: Wed, 16 Apr 2025 13:03:12 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net] eth: bnxt: fix missing ring index trim on error path
Message-ID: <20250416120312.GP395307@horms.kernel.org>
References: <20250414143210.458625-1-kuba@kernel.org>
 <CACKFLikF5SY6MaDS97G7Vg0+tZeGR3cKOimsm+ra7Cg+msXYkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikF5SY6MaDS97G7Vg0+tZeGR3cKOimsm+ra7Cg+msXYkg@mail.gmail.com>

On Mon, Apr 14, 2025 at 09:35:54AM -0700, Michael Chan wrote:
> On Mon, Apr 14, 2025 at 7:32 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Commit under Fixes converted tx_prod to be free running but missed
> > masking it on the Tx error path. This crashes on error conditions,
> > for example when DMA mapping fails.
> >
> > Fixes: 6d1add95536b ("bnxt_en: Modify TX ring indexing logic.")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

FTR this now appears in net as
commit 12f2d033fae9 ("eth: bnxt: fix missing ring index trim on error path")

