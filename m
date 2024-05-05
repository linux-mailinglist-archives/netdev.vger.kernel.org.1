Return-Path: <netdev+bounces-93492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB198BC17A
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 16:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2B12816BA
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661AA25569;
	Sun,  5 May 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buly0Iz6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428201E48A
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920309; cv=none; b=KIIKOOmZp6qDlQxr0TeFRIN1VyQvubMhp7K/Cy+3EWgnkXKXbQoSEhYFgsLZQWFcl8xrbzhlaHqELXjSQ8n5+YV6QQMKL4VsyhKQi/njOw+zJ4fdxGmHsyn9aFSv+GL6JFeQ1yGR6lpnIMvtibNgEQvvvXny5puDcX4nR1fxAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920309; c=relaxed/simple;
	bh=0WPW68k3vJ5ADUQrdXOApcvKuGn1RL5qdWbXUecUfT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs3CsCxkBv+hPD7cbTfgLKuy8Tn46xTU0n13nvw7h6EtdE4/l+x8+a3ArhKstXq+/U3NS99lCgZJ75no+Xl2GFhL3iAVOjs/Q7Z3b3L157ci1p2DswU0bntAD6+G2GbnEgJWOtdlhPGs7MN+9sV5a7T03ibRqqObVtu1hEwHLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buly0Iz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49612C113CC;
	Sun,  5 May 2024 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920308;
	bh=0WPW68k3vJ5ADUQrdXOApcvKuGn1RL5qdWbXUecUfT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=buly0Iz63gjBJxXtxeBYHtlLKbb/CJ4XFvd5PKR0iPVDUClaEnCMMlKWwnKdAix+G
	 m/45R+nDZdh3+q2YmOsGVLagvU01C+lnak9JDOIOdif4x/tXo4kX3F2lE27tDR0KRO
	 zy8M9ikjeFVP4OEgNojKdv+ll+E2mT5G435nwspccsgBkA8ItXl0VgqRUKe3U4pFEd
	 6ofS2IVG9JW/99iiRJkWpOzBx1A1ncZzcM9PhfkG3IbWHq5eVC/l457Vabec74tyW9
	 C+GI4AAEk02l3CShA5axY6KclDfrMCBxc3HfE8ToxwvBY4PdNTEr1KmbcdM3xZUs8M
	 yAxlAzhnSzU+w==
Date: Sun, 5 May 2024 15:43:34 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/8] rtnetlink: do not depend on RTNL for
 IFLA_TXQLEN output
Message-ID: <20240505144334.GA67882@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503192059.3884225-4-edumazet@google.com>

On Fri, May 03, 2024 at 07:20:54PM +0000, Eric Dumazet wrote:
> rtnl_fill_ifinfo() can read dev->tx_queue_len locklessly,
> granted we add corresponding READ_ONCE()/WRITE_ONCE() annotations.
> 
> Add missing READ_ONCE(dev->tx_queue_len) in teql_enqueue()

Hi Eric,

I am wondering if READ_ONCE(caifd->netdev->tx_queue_len)
is also missing from net/caif/caif_dev.c:transmit().

...

