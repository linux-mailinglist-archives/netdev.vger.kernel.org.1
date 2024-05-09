Return-Path: <netdev+bounces-94937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFA78C1094
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294521C20D3A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8851158A21;
	Thu,  9 May 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptDrQ0mD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7913FFC;
	Thu,  9 May 2024 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262282; cv=none; b=fWfWnIEqcQKA+fTiRqG/toE5XTih0h8z9rfZUwhs7vn3uoJUcAcw+0vwt1XxNx+6MrT5q6XbjTRMXMWZf9abIsVsVOayls+EeccKyI4uiV1nJ9i0TX1bIR8ggBLdBwqlVLfE7feph08fgFk8qi9v7kkxsWM5aIn/e4oB27LxFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262282; c=relaxed/simple;
	bh=WcY2wo/FnsSYtsWNC3xHygaA3eIfThCXh1WmOPkVRMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPj8Q/uLbYGSaArvr+XUDfWO6k8k12ELi2TaS0jCgSlJgaMbZfJqhx3LIEjAXmf/Xa6acedn9AZ9Zz4h9epGUg9VnTaSNBqUbX2HGENhpcy4ZA5WG4nEgkI31+rJcVF+aJd4SOLm4mA7zlfZ5CHFRFFov2Q+kE1kvqSlOl7Tn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptDrQ0mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7601C116B1;
	Thu,  9 May 2024 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715262281;
	bh=WcY2wo/FnsSYtsWNC3xHygaA3eIfThCXh1WmOPkVRMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptDrQ0mDlOzXPcYvSjSPLfCnVu60sa6OiCWWkSNISxsVh0yRyXZ/AYzTAVe9vQ25e
	 W/FPCdCSbamNAlK686Ci4In2kW+d/rTSQUbZW8LOOfQIbyvHR8vzG6UqJ2k6TZvX0v
	 1eSzQtG0511u9RQSte0fRifMbMk9hPjCFsSLS+55tZXLjeYy0ZTzyGEvgJVnVL8AIL
	 qwfGqB1xBlrfzZ5yGTSA37t/m0AwksWxffMuffRfjkdZD2oYKdYjwf86a6zCo3Q4ju
	 HI6gm0Fk/B6kdFF6oknMW2o5TRp2/xVezLZAuCgmYmFb5NDyurBrHtn7WtRE7ke7Xz
	 U2Aua38DKTuUw==
Date: Thu, 9 May 2024 14:44:36 +0100
From: Simon Horman <horms@kernel.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: Re: [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <20240509134436.GA1736038@kernel.org>
References: <20240509113036.362290-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509113036.362290-1-ryasuoka@redhat.com>

On Thu, May 09, 2024 at 08:30:33PM +0900, Ryosuke Yasuoka wrote:
> syzbot reported the following uninit-value access issue [1]
> 
> nci_rx_work() parses received packet from ndev->rx_q. It should be
> validated header size, payload size and total packet size before
> processing the packet. If an invalid packet is detected, it should be
> silently discarded.
> 
> Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

I suggest giving time for Krzysztof to review this.
But from my side this looks good.

Reviewed-by: Simon Horman <horms@kernel.org>

...

