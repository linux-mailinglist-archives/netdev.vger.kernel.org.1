Return-Path: <netdev+bounces-120345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04DE959031
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BBE1C213C6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301081C3797;
	Tue, 20 Aug 2024 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEyZALOK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561815C152;
	Tue, 20 Aug 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191310; cv=none; b=Y1gffhxq7WPE49snK3HM9QfvihU1rdmFMyl329+bO6fI5Kt9IHMAQqlGo/7pMCCDd9WqzoVMzt6jupYahSBzCl75zDJHJ6YUYSKmEQKvHYOqZg1B7805xO6c8tB4PcEpGg25bDBcKMyXyZcH1C4sGM6sJ+W2ksyI9sP6Qn5E2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191310; c=relaxed/simple;
	bh=XP5abZo4cddZxbccoQFIh8U8/zvqdwnW9rxfFg/8M0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IriYIJlW27snsfE9lbbVIk0vfb5KmKHxm58u8UAx4IJtjVdIcQzPJpTNW2IzmkERxU3Ynr0HtSV4fXtii8Fi/9OAezSNZwL9JbF3MfLkcWjcEzWPaqkykEO1VQCP5E6TN/Si+KHgYcAnKmozJnqotxaX2MWaBvXK2oUSfKnlQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEyZALOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057FDC4AF60;
	Tue, 20 Aug 2024 22:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724191309;
	bh=XP5abZo4cddZxbccoQFIh8U8/zvqdwnW9rxfFg/8M0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WEyZALOKwA65r3UitX9SbpMT9HzJl1u33ao5EC/dy38mc0nmwkGgBh+4ystko6ZsY
	 QY3lDvv33P8IyqlgH/Do+H8IpozKLB60wxS0nU+TXwAFb2/tfsWbs0PTTLo+IXK1RT
	 2xYRvS+mo1ewRW4ciNY5gsasCSKYfVnCKdMqVTYcZtuVeG4JgtDZN31yiqSyRPS+Hb
	 LpsAN6wBQlwFL2vsTRS1S6f8pMKcuvgquLt6HUKpONhkcpdwSFVob1BxiKIq42q64r
	 SAUeAVJA2yG1vIQrAA/l+6Me6VZtFj3jtukOBgs5wqWQmBuWEjdMjXbd1vKw5dp9x1
	 WcOBMf9aq1uEQ==
Date: Tue, 20 Aug 2024 15:01:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 1/3] ethtool: Extend cable testing interface
 with result source information
Message-ID: <20240820150147.1fdae1ac@kernel.org>
In-Reply-To: <20240820101256.1506460-2-o.rempel@pengutronix.de>
References: <20240820101256.1506460-1-o.rempel@pengutronix.de>
	<20240820101256.1506460-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 12:12:54 +0200 Oleksij Rempel wrote:
> +      -
> +        name: src
> +        type: u8

If you have to respin please s/u8/u32/

Netlink rounds up all fields sizes to u32, u8 ends up being the same
size as u32 "on the wire" but 3 out of the 4 bytes are unusable.

