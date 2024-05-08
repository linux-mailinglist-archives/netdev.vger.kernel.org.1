Return-Path: <netdev+bounces-94550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3668E8BFD61
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467741C22F1D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F8A44C7A;
	Wed,  8 May 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+Jh7H7/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E65820C
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172050; cv=none; b=mYIvixd+j9mwdrmeegyLztzjBM8jzSBRkZXbseLVI/zFzD7TuYjKmxqiEbUykTpkDHkG8AJCyZ+r2l+yNr0gG900DBlv5BpFC5Wy+Zy7fUyh/ns3c9fRa1W47xVtlWfv9O5vQdYY+0uxtwYhibO5XJ/zL1GjxCIySkvNz7IwxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172050; c=relaxed/simple;
	bh=KshEsZ++XPWV2oCFnYNsh6G3XmmGdJOqWAx/1Ec67G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWpwPcqgPqOGN6C5da+H4I1ckG7ND+9Z8xzUi89j6n9lmn2q//WO0agnG17U244cEenJ1vBdYxI/mk89DClA5QxSqU9cb1QF7UL01BKB2ihAUz+gNR3bGdf0unbhLO4byVjR7OeHehaj2gNECLbH/uUt/fmjCrCPplhgwWGK4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+Jh7H7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E237C113CC;
	Wed,  8 May 2024 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715172049;
	bh=KshEsZ++XPWV2oCFnYNsh6G3XmmGdJOqWAx/1Ec67G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+Jh7H7/tXqnqPZnmNc6Eh3dQ+u1d7s+0Byal7AYzRdePhsClzkl6TzZ0JDkunPXu
	 zBZ/dTq+4OT1FtyebkB6i/xp5Rlc9Ye3u1h0ylLOYxW/DxjXTlvtXkP9E3Ejhv3t4M
	 15jS4GV591Qdo8ZmREvX95hR8bvuduLfJshcYtYxucQb2MDtUjVVoLt6hEPphY6gQ2
	 MLca3tkJT3ipqjfw7YE5iv2/fz/+KUIPInRq6A4fBSNSW4RMq8t5HTKaY7XXdeO5mY
	 nVA+fkQ3oTRb1I497GoFIItS7urUBquxcVooU1zHYVBWg6snCDxwfLZIi+GYP9Zk01
	 y5O4+VFDIqCeA==
Date: Wed, 8 May 2024 13:40:46 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Remi Denis-Courmont <courmisch@gmail.com>
Subject: Re: [PATCH v2 net-next] phonet: no longer hold RTNL in route_dumpit()
Message-ID: <20240508124046.GD1736038@kernel.org>
References: <20240507121748.416287-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507121748.416287-1-edumazet@google.com>

On Tue, May 07, 2024 at 12:17:48PM +0000, Eric Dumazet wrote:
> route_dumpit() already relies on RCU, RTNL is not needed.
> 
> Also change return value at the end of a dump.
> This allows NLMSG_DONE to be appended to the current
> skb at the end of a dump, saving a couple of recvmsg()
> system calls.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Remi Denis-Courmont <courmisch@gmail.com>
> ---
> v2: break;; -> break; (Jakub)

Reviewed-by: Simon Horman <horms@kernel.org>


