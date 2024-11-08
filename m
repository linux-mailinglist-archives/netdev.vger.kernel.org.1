Return-Path: <netdev+bounces-143420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFAD9C25BE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F96281BC8
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C431AA1E9;
	Fri,  8 Nov 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAVKPHPY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745851A9B52
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095028; cv=none; b=lNX5C6hio4Lcc+hIvrvb6Phq751FyJJVhurXRYY0cucWgLHYhoFeDNQJIjeCfHi9uv9b5gNn3PTT05BPhay+SI1PoXyKQIoLQNb81sWme2ZuHCTGValP7EgXQU51DMgMoF+V9UGZh+VhkKhZFOl8SQpWbXYMKnbPZ3M7vhv6ugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095028; c=relaxed/simple;
	bh=gLxCPRe32fmoHsZqkUzw5B3+ZU+dgwaJADBvsOEqWCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7nee1+r8TVSTScCOewCveAAFFd9aZwWOAurPjM0hqxxUHy0xGiqFThQ7IqsIkJZP3qNIYdVQScq8aTcxW7t9FY/sZrjuzXZQsQu4lToXVY33VzvnXVDbamVXe2e5xvPdtHg1lICEWcMmN3t0AIF61gnThs9Y6QHhtLj3UfQ9VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAVKPHPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B869C4CECD;
	Fri,  8 Nov 2024 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731095028;
	bh=gLxCPRe32fmoHsZqkUzw5B3+ZU+dgwaJADBvsOEqWCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAVKPHPYZ8aMBfpex40qQgB44e450WKUJgGC6oBWPCrssxu7VudN7IMpgI0CvQXyZ
	 DiHsZ0jNIIqdKpBmwIQAnmWncjqRes9CrFIZ37Nj5GQdkxw+ztHSnzvJxkybz5F4T+
	 alDVvqNZZE6EqlzYh06vBdvS+A39vzQ1Wv4HNnTrHmMdGA5BFmrxACLt+u5CjQn4hW
	 4GPu8CCNgv38YjQ3GD5bLE6NIBShnbcRrlDY3wkVeFf3H1JAUNCiFEefzj/qdygkmz
	 JKjmPi4AicfW/9gcTSgfS/R+w7ixfCJ5XkxNroC4EF72vQrszS8NB9LTm62B6pu950
	 WnHzkRt6CQURg==
Date: Fri, 8 Nov 2024 19:43:44 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] r8169: align WAKE_PHY handling with
 r8125/r8126 vendor drivers
Message-ID: <20241108194344.GH4507@kernel.org>
References: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
 <51130715-45be-4db5-abb7-05d87e1f5df9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51130715-45be-4db5-abb7-05d87e1f5df9@gmail.com>

On Wed, Nov 06, 2024 at 05:57:08PM +0100, Heiner Kallweit wrote:
> Vendor drivers r8125/r8126 apply this additional magic setting when
> enabling WAKE_PHY, so do the same here.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


