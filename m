Return-Path: <netdev+bounces-149539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798BD9E627B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2939B1881D62
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 00:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0BDBE46;
	Fri,  6 Dec 2024 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtCtBe3b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B951E51D;
	Fri,  6 Dec 2024 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446213; cv=none; b=qgWje/zyOdAg2KCESmcbuULPni9eSOfrdn8g7oHEY9Gu79sLc9GrQh9SgMd2gt/wIpCPCrtw8LMglpkUP6OdnteKXcU8pune63W4otMx88iIKNj8QImk75RD9ZZEsum9rSK9XMu5WqicycrFapz8sVff/TdnR0JmJG0YpXix4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446213; c=relaxed/simple;
	bh=sKOKtAHmzPbczlCRzagkeIbyBrq+Q2IqYB03x3TXLoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeChsvXG86GW0bGIiELtZ/qozjUPPHSktFU49q0DDsNu+ZOoOGkzcifG/ol757jF24TLHkhnG1KiEFGca1AnSLQqI2KsVES9KW1lOALJDFuB9cYqA2xAnTqZ2bwQ1neeXj5cvh7JuTB8oNzeNSHORUbo+4VURuHwji0TRBLn2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtCtBe3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A60C4CED1;
	Fri,  6 Dec 2024 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733446212;
	bh=sKOKtAHmzPbczlCRzagkeIbyBrq+Q2IqYB03x3TXLoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BtCtBe3bS8jEyYng1cHGRyxI7RsRlLme8dkPrWxBbuoK1MkExxq853bFREWmAMZ70
	 eMLOoDafFjHcMvoReEWDUm9IGL1drmPsiSox9iQ+97j/2aZVggFaZ9z4F0VOmAnxiw
	 lzfB9r6JvxQJqBs/mIhqtiHplPadGlAxkrC/9PN7jO2gL56tEuLUk2LA0XaoySxZzh
	 nmyPCDAFIXtZR/wRlNVQw2Tdx4YwSVolABcoz9QspRjX+1k/rqhBaB5VoqVfJBimX7
	 pNlWBemNxfakHIvhACOzgSb+3cnAEpx+VzpFx+ZMOMw50AZzm/xXSg7NvDzfaemAre
	 SgCYK7vkMcUGw==
Date: Thu, 5 Dec 2024 16:50:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] qca_spi: Fix clock speed for multiple QCA7000
Message-ID: <20241205165011.549ea681@kernel.org>
In-Reply-To: <90137949-650d-4cc0-b40f-9b8a99a5e7e1@gmx.net>
References: <20241202155853.5813-1-wahrenst@gmx.net>
	<20241204184849.4fff5c89@kernel.org>
	<90137949-650d-4cc0-b40f-9b8a99a5e7e1@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 12:07:21 +0100 Stefan Wahren wrote:
> > I think we should also delete the (seemingly unused?) qca->clkspeed
> > in this change. Otherwise it looks surprising that we still assign
> > the module param to it?  
> Good catch! But shouldn't this be a separate clean-up, because the
> clkspeed was already unused before?

I'd put it in the same change for the sake of backporters.
Otherwise they may worry there was an intermediate patch,
or perhaps there even is one, I haven't checked.
If we delete the field and the assignment - if the backport
compiles its probably correct.

