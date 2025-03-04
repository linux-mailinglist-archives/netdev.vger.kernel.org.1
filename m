Return-Path: <netdev+bounces-171472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9537DA4D10D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 02:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34CB177AE5
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587EA143895;
	Tue,  4 Mar 2025 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8QB2sY3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CBF13C9C4
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052102; cv=none; b=qs/1On4QS4sR3KzTN8yBY1qnZZmtfFYhpbVH/u4f6Fu2t5W73Nz6gYVoLnJyOCKK2O9KajcTGT8JphVpROzmZsm18UEuX0kZHSNRkCppFB8qwOQ99xnsWdT1oSR4xrRqh/mNTPS3Dduy27RkcEAKtSNlQ6AtIOQYdyELup1y+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052102; c=relaxed/simple;
	bh=uECuy/9sXANdKlbS4ZqTG5LD0/2SLrW+YQfqMhq8Y7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKIcB+w0TgcdMyOEnp2J521W2IRybnVBIoueob0jCeeMLM0BN5jX30LtKuFdE4KTYY5oLYvuWJ43fhkfmO4/5vUUhSQajZznPXPvtaV3udyMYyW/p4RdjPQa1PH9/hmItHHGddgSXUPCAGARhLxhQm9YVnrD8ZlrtNRCDvT6dI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8QB2sY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9C4C4CEE8;
	Tue,  4 Mar 2025 01:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741052101;
	bh=uECuy/9sXANdKlbS4ZqTG5LD0/2SLrW+YQfqMhq8Y7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8QB2sY3ogMYFYuBFNbYEKuhuZc5jwfVTAtlLexB0Ef6jxOlKmTiudtsmfYvS+JS2
	 pJ4j98rTis6dv90ieyPlKvmvTFcyJy74tg3XmsLmIMrUmqMLVjY3iLpcO4fOoRmo9t
	 R7bOjlMDL/kq+R0LP9n68Yb/o4V70exeq+tS5rQ+1n8JICxKZBxWevU7ReZ3iy7L6G
	 5AVEPbzmYrTBqNrO+qFPzOvZgrYecuFFQMdFZL/4jrNhon4b/q1+CbA3wMZWyZbrra
	 eYf09r9HGUM4oMQsXWgSrPd10qAeUg0VbeCPHoP19qV7i7lLV+uMmZRp2N6pd8GxWa
	 ToZg8BvoykLyg==
Date: Mon, 3 Mar 2025 17:35:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: andrew@lunn.ch
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 2/8] net: phy: Support speed selection for
 PHY loopback
Message-ID: <20250303173500.431b298e@kernel.org>
In-Reply-To: <20250227203138.60420-3-gerhard@engleder-embedded.com>
References: <20250227203138.60420-1-gerhard@engleder-embedded.com>
	<20250227203138.60420-3-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 21:31:32 +0100 Gerhard Engleder wrote:
> phy_loopback() leaves it to the PHY driver to select the speed of the
> loopback mode. Thus, the speed of the loopback mode depends on the PHY
> driver in use.
> 
> Add support for speed selection to phy_loopback() to enable loopback
> with defined speeds. Ensure that link up is signaled if speed changes
> as speed is not allowed to change during link up. Link down and up is
> necessary for a new speed.

Hi Andrew, does this one look good to you? I see your review tags 
on other patches :)

