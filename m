Return-Path: <netdev+bounces-108285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E2291EA66
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C146A1F253EC
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1645C614;
	Mon,  1 Jul 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1AgC8Pv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF38168D0
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869569; cv=none; b=hWoKCMdyan2JSojmvAcPQl5c560Vol+AWnHDk0mcYvUAC/RUP5WGAGB1DwbTBA9CAiNciPxoHaFu5B/Aa3LA6FG9PRCqorFLoFymtrdYq2jR7Qjqti9amvHA+1MZEhT8UOL6f4iJaHSW3c9F6FPK+KYSwNDWyfODrqM/xuMbKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869569; c=relaxed/simple;
	bh=dVEaZDE3hR3FJGPpOiCr94mW/uHY/xSEoewCiQ0Qy24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fkqc7E3nBt/VQF7l8V36o8fBbloB6CymiucoamwMQqHbM/DEAwsmfRt6Z5f+qeVXHnmYD01lf2G+hu0IVGA9y6k7rT3Pq+fEpd+d5SvrqAhTu9uhQG8Kf8xuBUdnNxsikuTAgVWGZQCaUiwU6ytEOGvPZqh8TWzVIO1RMm9sxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1AgC8Pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51AFC116B1;
	Mon,  1 Jul 2024 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719869569;
	bh=dVEaZDE3hR3FJGPpOiCr94mW/uHY/xSEoewCiQ0Qy24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K1AgC8PvFigUfnGQxYuHhZpwKdTvAsywzHgvx1ft+daR0fItY1clqDYnhtOXJiQmO
	 92f31eSg4uaBwR53reAxgQb2gasm/+XMnyfN9A1sw9/m9GjoSJg7Id2fn2zR9YB0Hm
	 RgNbTg1c2HaZZoBR9DfHPcV/6Yd8QsDuxsjNc0dsStPDBwwwqW0QQXJLaX4E96nvGw
	 bJ8h1F9qYAmzcgtQJ5J0aFEE0mG1QzPfCQ28WzjuhqC0oxyDDCWUeTv8tJZh4T2gbv
	 KA3ikWKH1iEGyhOU0mmmyh6BbKekdoEp/N73MXaY//O0iEPi2IdlJYS6f33TQ07Dp/
	 PsquUPRCuE04g==
Date: Mon, 1 Jul 2024 14:32:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: 'Simon Horman' <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Ding Tianhong
 <dingtianhong@huawei.com>, Hangbin Liu <liuhangbin@gmail.com>, Sam Sun
 <samsun1006219@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v5] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <20240701143247.07bc17c9@kernel.org>
In-Reply-To: <20240630-bond-oob-v5-1-7d7996e0a077@kernel.org>
References: <20240630-bond-oob-v5-1-7d7996e0a077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Jun 2024 14:20:55 +0100 'Simon Horman' wrote:
> +		if (!(strlen(newval->string)) ||

The extra brackets made me look, this really feels like it wants to be
written as:

	if (!newval->string[0] ||

or:

	if (strlen(newval->string) < 1 ||

