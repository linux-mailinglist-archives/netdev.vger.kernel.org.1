Return-Path: <netdev+bounces-183055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA2A8AC95
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FE51903A65
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC5D1917D9;
	Wed, 16 Apr 2025 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUdkxXkh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB4185920;
	Wed, 16 Apr 2025 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762769; cv=none; b=JCUglzjXZyDCeFo6l2dx8v4YN9+xbR5KkYJ/Q51hREWF6Lq6QUzGbts7mU206P3q0loVor6OjR2+5RauJTJnIeax5EYtuFv3MOM/W5Qn0UGwTcRgNlGX82ns3N4nCesDYOR1AjhNjjrE+Kqvv5QcSLlvH4cOd2dyXUpbNVRuV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762769; c=relaxed/simple;
	bh=3SFSkOv1V4kUc0PGBbEZf0lUcEdotYE/XwhRIWozbQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUECbw73+35+LXCTf0yIFt+53HgXwvOCTEdmNEWQJ5UxV2U2IGM8AczOq7A4CB02zkHUlaZHH/WfSqW2fEYUiYPHp1c70VC91tP8GIJT/y9yu8kggajXOsP3cKGzJYd5V38epn1yg06RH+DpXMwelsAqa3e9x7wST2TsWqR9lLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUdkxXkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFBDC4CEE7;
	Wed, 16 Apr 2025 00:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744762768;
	bh=3SFSkOv1V4kUc0PGBbEZf0lUcEdotYE/XwhRIWozbQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RUdkxXkhX7znYRhN2yDnYDmrgkhmQNYgil9t1tSHAioqAXf7enFW/t3p74Q5Hqr1G
	 6NzTlLmmYBGomj+CyjigSQ1pl0q+h84qAupiOBpkemR6/MncKaIsMTlukXQhLggpC2
	 VpoSDuMXHnmSqlOgxNVwUKDIZMuJbP9wcSJpR1WOd3ad+YZmVgCjBCCD3wWdsHoto9
	 nEbpbOptby8+9SytLz7pO7pOWqKgOEEYLjsqOllZ4vi/02TRhETbqkIN0MDudKksQV
	 IH5OFTCUrryORovwYfv8SX6sp811XtxorfRJaYS4RFLBeyUX8qFjhZDu+/f3xAUjEO
	 yrXSGUbJzJPGw==
Date: Tue, 15 Apr 2025 17:19:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
 skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] net: ipconfig: replace strncpy with strscpy
Message-ID: <20250415171927.5108d252@kernel.org>
In-Reply-To: <20250415163536.GA395307@horms.kernel.org>
References: <20250412160623.9625-1-pranav.tyagi03@gmail.com>
	<20250415163536.GA395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 17:35:36 +0100 Simon Horman wrote:
> > @@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
> >  			*v = 0;
> >  			if (kstrtou8(client_id, 0, dhcp_client_identifier))
> >  				pr_debug("DHCP: Invalid client identifier type\n");
> > -			strncpy(dhcp_client_identifier + 1, v + 1, 251);
> > +			strscpy(dhcp_client_identifier + 1, v + 1, 251);  
> 
> As an aside, I'm curious to know why the length is 251
> rather than 252 (sizeof(dhcp_client_identifier) -1).
> But that isn't strictly related to this patch.

Isn't this because strncpy() doesn't nul-terminate, and since this is a
static variable if we use len - 1 we guarantee that there will be a null
byte at the end? If we switch to strscpy we'll make the max string len
1 char shorter.

