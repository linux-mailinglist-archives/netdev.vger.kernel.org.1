Return-Path: <netdev+bounces-103883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60C909F12
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 20:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9E3282ED2
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D21C68E;
	Sun, 16 Jun 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUd6rbOZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B249628
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718561968; cv=none; b=hptxeWy4r81gDfBKEXaNu8jO5xXjp7gIG3+qMcfgaWmiRaZ0nxr5EVr+N2WQD+U/58ehbvT21zt7FRkyc9XmuGzWB2GhQs98uX8X2sBJ29RBovr8ZoQxQ56SAmBI/1lOScDz/KZbmoZ2nN34GjyggvhLacVLGWYZHx9nH1JZLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718561968; c=relaxed/simple;
	bh=tr+1h8kWS59dGbhWFQrIVlj7FrO0vjXtbFyd18/Bt1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gw1/Mhi20DkQz270h8bGbvfUWwKRIr6gxt/PQUSro9+uROyEeAWRsrQ4CyX5QTlDb2QTz+uWTTEfV1lDFPK8v9FS/d59KUEfrL2y5NW1h4NAejMoOy198gnHEkzCnTm/f1ocBspmEiHv63GlRx6gQ66q0qFn0wVnNnA1YgZXD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUd6rbOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFC5C2BBFC;
	Sun, 16 Jun 2024 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718561968;
	bh=tr+1h8kWS59dGbhWFQrIVlj7FrO0vjXtbFyd18/Bt1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PUd6rbOZ5BmZoPP2BCH1nZppvz0pENJ15VEtzh/UoXRy0YN5CWgPUWwa1kFc+n5GB
	 vMrQ9hPnOYA+SUPJGnbxBTYhCvQRAhkgqRa7RC649+Izlmqn2eZAsedmKxzJw8G3ye
	 hqlzMvNJ2LgrFyuUlWbk5Y8VcNlD73r9O114QksEMOlof7ET9jf3wASBCGh5FuSWpv
	 YF+rFycl8x1i8V/hc041cNmAzD9cSb8tPiqQCV4zKHgQ1s51vOtBhSAjFJqVnPXKHf
	 CAC8zEW1zfDNgu8D0P5BakR9Hg7wdyKABmVW5uV6iKkYpTfjIRC6dMxq0VZUasy/Qe
	 HoJgBUdHjECCg==
Message-ID: <7aa64be6-6555-4658-aebd-85c3d0131b07@kernel.org>
Date: Sun, 16 Jun 2024 12:19:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: prevent possible NULL dereference in
 rt6_probe()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240615151454.166404-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240615151454.166404-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/24 9:14 AM, Eric Dumazet wrote:
> syzbot caught a NULL dereference in rt6_probe() [1]
> 
> Bail out if  __in6_dev_get() returns NULL.
> 
...

> Fixes: 52e1635631b3 ("[IPV6]: ROUTE: Add router_probe_interval sysctl.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/route.c | 2 ++
>  1 file changed, 2 insertions(+)
> 



Reviewed-by: David Ahern <dsahern@kernel.org>


