Return-Path: <netdev+bounces-93495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E38BC180
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F8728173A
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688C2C1A7;
	Sun,  5 May 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccfDhNJW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105E1E48A
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920694; cv=none; b=b6+Q4I3DKP/SJAlr2JfflJ6Z153dZVLT55oDHJ2pj5mZ8Z40zg9DQnTLigQMupLE03x7ZYJNI97rnwUv/hvjsd3jBw0ngKpCDRBcSwYHDr19Md7pszjt+ugElsbu+Zk6HGSi0ey8jgiB/aJnJ3aKo9jgBTDfbN02dpnTk0Zmz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920694; c=relaxed/simple;
	bh=sHJvqWfNIfGCS6gSl3432VsIxhnvQOLTReEv7DwFv6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTc0j9KZoJdbQb03Reo13lKedflVOBqJliigmw+AKZZ/KEnSCRDhg33kxHPUzUfajYhJqoz+Bb/gkV2tt8esZ3jL1a5ecoQem7vDwNAVOYd+9Cipgg9ST5KW5jmqf+k9A/Dw/tbQy7vBzF7aQS8l4BrMDap4OiyY/IOXxf8lO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccfDhNJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFE1C113CC;
	Sun,  5 May 2024 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920693;
	bh=sHJvqWfNIfGCS6gSl3432VsIxhnvQOLTReEv7DwFv6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ccfDhNJWaCqIZV14efb7v6ooEG0RwMvm6wjokbkmRpXGXRNTfqJ9hj4T/ZuYGnYBz
	 Ug+MKIIPc5NAgDw/X21Kcimtzvxg2VIEVmxnKaXNikIMUOzKn+UMueMjtt+BL7/Z7i
	 zi75xhAiLA9jiE17WjGsY5kAou5kc/11/pbY2GuV/1/NqZMSJbXvvd67+Dizk18Tcl
	 8WNJGN0Yb/nVGh6LcvDQyRUzB+qztrXFXvovHcXaeKshQuG8C7SAMcj/XKObl+LTn/
	 Ou7FZLlx3BU/5WZq8gPdd4xLzRtxaQyHONigVJk8xaPDZxlg5O6LyiM6ZgUZCeQkTY
	 NzNHi6qvGmLWA==
Date: Sun, 5 May 2024 15:49:59 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/8] rtnetlink: do not depend on RTNL for
 IFLA_IFNAME output
Message-ID: <20240505144959.GD67882@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503192059.3884225-3-edumazet@google.com>

On Fri, May 03, 2024 at 07:20:53PM +0000, Eric Dumazet wrote:
> We can use netdev_copy_name() to no longer rely on RTNL
> to fetch dev->name.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


