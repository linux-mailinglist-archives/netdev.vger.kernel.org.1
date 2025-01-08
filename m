Return-Path: <netdev+bounces-156107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78554A04FBA
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868BB162C0C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA14335BA;
	Wed,  8 Jan 2025 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihX5T/It"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600652C80;
	Wed,  8 Jan 2025 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299879; cv=none; b=GXZk/bhq5OABC4s+wMlGGmq92+vvTUrH6Y+U/q9mX9n/oU2E/HKTh7n26D/E+0gR62eMlGfErqxVPsEA54bSe7+FMErZXKfSEKwCto9XwG8L6pkjEI7kDV3JGBUyXLtiWHW7wFlJqFnIsIBX/duHDroaeSZcAf2gLV1ft6gKC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299879; c=relaxed/simple;
	bh=ASIyh/NmUK2ASIAemM9WXO3o0ShwgvBUt7y5TCXKgHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcBYtbqR7xWt7I+e6vZeVh05Tfvb+Ifv+So/cIWatufXseDeBHkSESLgXOKqU0Hiu9A4S5lXWs0NUL86eo+ZkznpU2/88/uyBx5kWI+mXtc5oVN8pLpDhsPFzoGZJF3IDkyuXeXCHuk09OMRjCfNhp21wiQZVHDadPvzX/FZxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihX5T/It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8813CC4CED6;
	Wed,  8 Jan 2025 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736299879;
	bh=ASIyh/NmUK2ASIAemM9WXO3o0ShwgvBUt7y5TCXKgHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ihX5T/ItayouOblF46u5KEDjh/ybhYbRSeUIF7zjXH6FLdgHzNcg8hDrhtHZoHWTD
	 LLvVMD5avFbft330IsbS4lV9LpZCi11eZ/QoX5/LmcNrxxpU9CyKV7DQSrKuD582jt
	 Of4n0wBD5irhooI0WtggDjvV/OorJXrOqX7tKHvN91c/1BG1wtf4FmicsvkMLgzcds
	 mtJTwWAwT9n0AqZlDewG6Y4rlzMyn45gZcGTRVZ1e/zTKnC+VPpdJMeRVrlkUS+loR
	 dYikwUxfaGsP2by+oRSiRX8dmetzCdkP0u8LbrFbY4Iqg/jR+byEKpPfMNkxhgsRvU
	 JczyVvzsFfAyw==
Date: Tue, 7 Jan 2025 17:31:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Foster Snowhill <forst@pen.gy>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Georgi Valkov
 <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>, Oliver Neukum
 <oneukum@suse.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v4 0/7] usbnet: ipheth: prevent OoB reads of NDP16
Message-ID: <20250107173117.66606e57@kernel.org>
In-Reply-To: <20250105010121.12546-1-forst@pen.gy>
References: <20250105010121.12546-1-forst@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Jan 2025 02:01:14 +0100 Foster Snowhill wrote:
> iOS devices support two types of tethering over USB: regular, where the
> internet connetion is shared from the phone to the attached computer,
> and reverse, where the internet connection is shared from the attached
> computer to the phone.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Please add that to each patch, address Greg's comment, and repost.
-- 
pw-bot: cr

