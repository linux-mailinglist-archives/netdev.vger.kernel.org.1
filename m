Return-Path: <netdev+bounces-134849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6955199B50E
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 15:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6941C20873
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898B0183CAA;
	Sat, 12 Oct 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw2A5TL/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F91F5FA;
	Sat, 12 Oct 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728739405; cv=none; b=Fb9m5/22s4i+2wcehRdDZ9rp6c7sJjir7X93KzB5SzE9+sHf7NuveNtQnY/8Zzj059X0hwOKOUUoVBQsuQsys26sigA78xKiygnCnYa6zhyh1+ImzUTwXf9IPDk3m6Zl3HNH0DHmBnImx9TX0jqMewu5QFgD/91rX5V55KYW/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728739405; c=relaxed/simple;
	bh=OwvKwN8rCuNf66q+Jyo+RUWIIEYPdVJoV50ibEHaDK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ7YUX4KGP0fNrrjntdxhMycMErsDA1LaW9PDtS+AoeOPOy6ZQHs1/zNOjo/Ex1igjhSWmczXA7AvB+7q++MF86QnXXOpdlBUw1A0qNG8dtwUBtrnjUojXU2uGyzYDnHnB0RUxRLGjliL0mTF8kP3dIOTtdn2IIxnvkFbesgVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw2A5TL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AD0C4CEC6;
	Sat, 12 Oct 2024 13:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728739404;
	bh=OwvKwN8rCuNf66q+Jyo+RUWIIEYPdVJoV50ibEHaDK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nw2A5TL/KgBDyktAfg1GsSW2Mtgfil2yXvw9WiU5d9LEtKNAu3mn/GMUtdz/YQEQ4
	 ts0/pUh+EHYNTw//DrhaHMlqt9Rlu1+RXgcG0oaDBUAEMzlmmhx0FKZS7Ojk9Snsov
	 fVHhGKBfiemL1TA+5+a9dHz1sHEi+qEkLqKhFEtCokEwfOn3uAPFVwoL7zZi7m1Ov0
	 JPKJnR9Gn/wtmD5OKmUYYPr8og4DLGhhU+ovVZU2814voVfs6geHl9sEo+r0KZdcZD
	 me5+NsPeyGzOPjfCS+aSu4AO7qabDbXSIjET28rAmIVLO7fcZaNthgfFtnzBpvIX3I
	 eezDUUPbcl5EQ==
Date: Sat, 12 Oct 2024 14:23:20 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv6 net-next 3/7] net: ibm: emac: use
 devm_platform_ioremap_resource
Message-ID: <20241012132320.GH77519@kernel.org>
References: <20241011195622.6349-1-rosenp@gmail.com>
 <20241011195622.6349-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011195622.6349-4-rosenp@gmail.com>

On Fri, Oct 11, 2024 at 12:56:18PM -0700, Rosen Penev wrote:
> No need to have a struct resource. Gets rid of the TODO.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


