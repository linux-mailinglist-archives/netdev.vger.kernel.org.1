Return-Path: <netdev+bounces-69916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD784D03F
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC841C22A9B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C89182D6D;
	Wed,  7 Feb 2024 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACLDh0Kw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931082C76
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328665; cv=none; b=PfU05LNVZOZKz5QrHjf1+qUT4CfdLdAyFo0amjnBqMDMk4CFEmWuhWoz7HnoJhoC6eGG0pqFRvtunqpPEann6viZUhASkEB/TjrF6yJWQApj0GdI+qK9mKEbYHQcVhanVePXhASp0V/BSIInY0pL+19XLA9Kun9dpKX+DX3QUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328665; c=relaxed/simple;
	bh=FH6SAeQvpWB5aQx7MyAaFO45wKdC/PzmfZT5wtOHgUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FI1Ercr/u51JS2IEm3QcmJGZMwV8NwoRkI9+FPEVNqTKpksokCExsYz9PNp9PhixanUkO64fpcQFlkykePwvF/yRLNXwO0l5APJPIdU9Ed/WBvr1WjAFjeIPiYHNdWmegnOZlLSaLAeCuwt5obW+8YyxoDcjRMvhuLgB+DSnvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACLDh0Kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77970C433F1;
	Wed,  7 Feb 2024 17:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707328664;
	bh=FH6SAeQvpWB5aQx7MyAaFO45wKdC/PzmfZT5wtOHgUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ACLDh0Kw2neQV+QrSz6fVgQyrwJEAJZVpIT/ArhIdicUcSwF5y0fUrw/7AWvioujH
	 A7ujsLAEZihPViHtSas2QnoUQPUrkhVockvHKZMsS5/Ggjt5gZUy0arboaiuV6TamV
	 okPooGgUnOdHA1Ahz00XkFkm20bY1+oZJ/4u0lxL+ZiAHw4xyBelBWHLQuweuRtlOs
	 M0MPKgKIbVNA0s8slEae0Har1qzvQ+reZytoARTaEvcS4XN00JG8nCvvBWXp2kSSDL
	 CyNDcgm43/EdjQVV/zPIKioeflSQCY1YgPMK9f0XoRO4XzC+uFS5J1syQKjGYof2JM
	 ibqD2N1hzGiuQ==
Date: Wed, 7 Feb 2024 09:57:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] ethtool: do not use rtnl in
 ethnl_default_dumpit()
Message-ID: <20240207095743.1fc940f0@kernel.org>
In-Reply-To: <20240207153514.3640952-1-edumazet@google.com>
References: <20240207153514.3640952-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 15:35:14 +0000 Eric Dumazet wrote:
> for_each_netdev_dump() can be used with RCU protection,
> no need for rtnl if we are going to use dev_hold()/dev_put().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

