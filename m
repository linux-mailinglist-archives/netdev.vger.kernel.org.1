Return-Path: <netdev+bounces-94329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D48BF32A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106002884B7
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243413667B;
	Tue,  7 May 2024 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twWAl0F9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB43136678
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125694; cv=none; b=M7XWouVlwSO6zk2QgXukZHVEv9VyIjYu1QoEsr44SVQVYE00TQqVwD+91Xi+SvsualUkjWVZTB4mQCCZfc/q016FdciKHhnA8uw68oWf1PZRsRyPFe0DpSUDvM9sYoNA8gyMfzY+1FppNZgAY2AfGQwFWfRD6Ukj46PandV2yfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125694; c=relaxed/simple;
	bh=7SAeFUNocfotopBOdnHpq4EmC3tZJy6HINGUamWhsII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTUpUjxyvP180Lqvaeq4ipibmBp5Ppa8/gBIMf3UWoRvMzfyJVFYN0JwbNZNBwLPewhF67sxW5t936N3HZUQXXpEsXaaE8rR7165YRpOddkEZp/FTSFi/eWC/T6XWnDb+Sz/FxrsoCQJRXVzgE/ew1cFBRP1qEVZZ5y3NBJJx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twWAl0F9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A74BC2BBFC;
	Tue,  7 May 2024 23:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715125693;
	bh=7SAeFUNocfotopBOdnHpq4EmC3tZJy6HINGUamWhsII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=twWAl0F9s/Oz18EMRlXfY3BtVfBiHOSM+RiD82ggrMGa2m3hBqARCM6Ryd/rRmdRl
	 6k2XLsHScy57jqKFDfoMsMOOikLrLsl8kbKZHc0RDk7FlXLyevk+VcsXdMVFG2bSY2
	 AzzII8KXUpmF5eRdLRirmTd/6+642up4iuis/Vxo2zjbTTS408Ml2EBKD1Lgm9JPNY
	 EtKZXoy1xTIyni7HkSJLN731Y1dsFHUsZuASQJdjLLfr+mIxXws8wZ5SayuT/Ufg7U
	 ZWcAiJ06KZ03qIuF5d4A6/3jvizDN9Fz6LH4sFeBktmrzYrut9SHKfmGi66fG2KOhb
	 JHBEU/eY0OPTg==
Date: Tue, 7 May 2024 16:48:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 00/24] Introducing OpenVPN Data Channel
 Offload
Message-ID: <20240507164812.3ac8c7b5@kernel.org>
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 May 2024 03:16:13 +0200 Antonio Quartulli wrote:
> I am finally back with version 3 of the ovpn patchset.
> It took a while to address all comments I have received on v2, but I
> am happy to say that I addressed 99% of the feedback I collected.

Nice, one more check / warning that pops up is missing kdoc.
W=1 build only catches kdoc problems in C sources, for headers
try running something like:

./scripts/kernel-doc -none -Wall $new_files
-- 
pw-bot: cr

