Return-Path: <netdev+bounces-38138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68577B98B0
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 79F1F281959
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF4130FAF;
	Wed,  4 Oct 2023 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8EfGQ55"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C7266A1;
	Wed,  4 Oct 2023 23:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5F1C433C7;
	Wed,  4 Oct 2023 23:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696462112;
	bh=qbZU7R3Zsw96CbqqTm9vDJi7eGwTuFjG+uwNT9ctvJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L8EfGQ55WKi2LtRA9Xq3ybLy4Wo7O+1h42hkjCU7fXyLjgOwfulSK88we8iNeXqMg
	 4WNGn9C+lCAzRAU/+j7fLKqOXpcNguoZXELO17m/GIBD1XQpBLMUKAwPizMkYrLY9M
	 8aoFnvoq7EuL3yA+tS6n85VijY+Fq3YDH7dVhSSNkClHBSEOzqZgt42/RksJXBJoQP
	 J4OAuBhXO9SaGtypP7nm3WuD6IkXmrkny8BcMfMHO5dyI9MhHLWVzWUmOeBIcc1n/i
	 hptqd23VLm5iLw1D6CUkZ5fXAZ25kcnj4I8jY00293ZWz60lkhNyMA7wnrp/kdNje7
	 Dar0izIYT0FnQ==
Date: Wed, 4 Oct 2023 16:28:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Robert Marko <robimarko@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Marangi
 <ansuelsmth@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 devicetree@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
Message-ID: <20231004162831.0cf1f6a8@kernel.org>
In-Reply-To: <20230930104008.234831-1-robimarko@gmail.com>
References: <20230930104008.234831-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Sep 2023 12:39:44 +0200 Robert Marko wrote:
> +	ret = of_property_read_string(dev->of_node, "firmware-name",
> +				      &fw_name);

Perhaps a well established weirdness of the embedded world but why read
the fw name from OF?! You can identify what PHY it is and decide the
file name based on that. And also put that fw name in MODULE_FIRMWARE()
so that initramfs can be built with appropriate file in place :S

> +	ret = request_firmware(&fw, fw_name, dev);

