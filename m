Return-Path: <netdev+bounces-226722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE5CBA473D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D35560955
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58B221CA0C;
	Fri, 26 Sep 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvTpEmzg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8121C9E1
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901204; cv=none; b=nTRYLCUYG64kLil/EepxUXt7YQBlUu0YzEH9/yRFTaxXq0cs7Af52jrw32ilhiy2KLJz5AQ5/goa/ha6B8aHXULjaNl3KUUn7hoc9tUq2XDlik7CPRkza5I85RuwAYzyz4vQexOZqKvmJApwQlU3ZjEyrR8U6f3gPVrN22IeDmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901204; c=relaxed/simple;
	bh=3Lg/7jQJnEgqNVVkE2krc94eZ0HEEG2MSUWSQVSZn8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5k+iaaLm8xBP8SfWjhe2i78eM760/rHUokiB03gjiqw9mqM5e3PdEbxmDxNaPiiNmHLqWTMYccSfAXgTcVrnsakf1w/+HJwDD02CRwoCfM6fFGEjdG/lwo5WdhxIFJ76AEYoVGGMextov8L6AOrT/FHFDnewM1ce9/jqVHXnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvTpEmzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4B8C4CEF4;
	Fri, 26 Sep 2025 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758901203;
	bh=3Lg/7jQJnEgqNVVkE2krc94eZ0HEEG2MSUWSQVSZn8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvTpEmzg82ktiWEabWl33dQp/yiEY23+84TnjtDyMK9YARcZb+YPeoE6h4YKbiuK8
	 skblgVM9PeK2S5Ph2lBC+g4kUH9GbYq3BFdVlNHWi/k9kZJIHDeCDJpdE2P8HmkdTF
	 9lSvc0a4YDYO7HDwWDN37MqWL7haEwUnim6vcEG5yevJvtA6dtAemScrkzSVqYdPbf
	 yJBKCa1HVLRAa/mUC6kFNX0BZDar5GuyBYT4PYG0FQ/boenxpom5IehIg0r7wrLntu
	 sRpEbnEPC6HIumQpkZoqrvZf/qq0COb5Z0dkURd1yjreYi7yWxN/g27OSXyQP2FRLI
	 Ea6q6tqBJU2FA==
Date: Fri, 26 Sep 2025 16:39:59 +0100
From: Simon Horman <horms@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next] tipc: adjust tipc_nodeid2string() to check
 the length of the result
Message-ID: <aNazz8tpiCeFi9KZ@horms.kernel.org>
References: <20250925124707.GH836419@horms.kernel.org>
 <20250925165146.457412-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925165146.457412-1-dmantipov@yandex.ru>

On Thu, Sep 25, 2025 at 07:51:46PM +0300, Dmitry Antipov wrote:
> Since the value returned by 'tipc_nodeid2string()' is not used, the
> function may be adjusted to check the length of the result against
> NODE_ID_LEN, which is helpful to drop a few calls to 'strlen()' and
> simplify 'tipc_link_create()' and 'tipc_link_bc_create()'. Compile
> tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v3: convert to check against NODE_ID_LEN (Simon Horman)
> v2: adjusted to target net-next (Tung Quang Nguyen)

Reviewed-by: Simon Horman <horms@kernel.org>


