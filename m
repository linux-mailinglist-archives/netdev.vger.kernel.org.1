Return-Path: <netdev+bounces-120743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2F195A7B7
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65551F2299E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 22:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F6217B402;
	Wed, 21 Aug 2024 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYQlEaEI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9A17BB07;
	Wed, 21 Aug 2024 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278888; cv=none; b=HThoaoSJvzu+Y+azMVq1QuBs2RcY0zhhyOMgWV3jJ1qu29TdhDek5NtddwGNaTo3Eye+CKM8wZjAgvRMsEnn70mr3oi2PyoQwgRreZq8eStpOGFF/oy8rF9mM8AT3K0kdgl/vst8wUOrHy5Gx6gZD9mZK4xSGEHgt1uuHLl2cKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278888; c=relaxed/simple;
	bh=anHimuf/KItTG3ghSU4vcPw/8ft4yW+FB1n3TRM/HSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMUJSGiw2XwzyHciMDqYR+e5g9aJKZiqqw8iXRSzlgRPuf9Pjgw6+jIZBjSVClCKVPLc2uiyD63mKgSD000AKH2SyrNlmwhTwFqKZpEZeAu0be0VyizJCJ78suz7dBfsM5h790o9gTWyeFcjq9GQQ+OxwLpQKkl1OjPpe0w/UaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYQlEaEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3624CC32781;
	Wed, 21 Aug 2024 22:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724278887;
	bh=anHimuf/KItTG3ghSU4vcPw/8ft4yW+FB1n3TRM/HSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XYQlEaEImpMTAf5e3+EpnOIW6ILjfpclOncdNx6ZsDOMOaTO+ZKlN1WaP+J85ntU8
	 +kP0FK+Z64dYbCQt3zspTRK+B9c7cMenfVC0qr1YjCTnZcOC5WTnehujjt7kXjXzkT
	 yymaf5Fmn2lzH4EyZ9TzO0+0QN+uqrFhQnI+kNzgETYJSUkbC3jnzOxZzlZR9svLPE
	 5aUU531IJifT5TxgaRXs++OgpB7BYaX7w76wvUaAorVlM+afPyeka5No9c9Vt+mx2O
	 ZsRk/wUg5BdlJtnkXsKr2osUOq7BivWbIq/PeYox40ffbWETJzChcR3pcCd5tScvVP
	 kuGgl5q1Mp2Og==
Date: Wed, 21 Aug 2024 15:21:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larry Chiu <larry.chiu@realtek.com>
Cc: Justin Lai <justinlai0215@realtek.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "horms@kernel.org"
 <horms@kernel.org>, "rkannoth@marvell.com" <rkannoth@marvell.com>,
 "jdamato@fastly.com" <jdamato@fastly.com>, Ping-Ke Shih
 <pkshih@realtek.com>
Subject: Re: [PATCH net-next v27 07/13] rtase: Implement a function to
 receive packets
Message-ID: <20240821152126.519f44ea@kernel.org>
In-Reply-To: <14b068505fda436e92b58b2ea86e45a6@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
	<20240812063539.575865-8-justinlai0215@realtek.com>
	<20240815185452.3df3eea9@kernel.org>
	<5317e88a6e334e4db222529287f643ec@realtek.com>
	<20240820074102.52c7c43a@kernel.org>
	<14b068505fda436e92b58b2ea86e45a6@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 09:02:41 +0000 Larry Chiu wrote:
> If all buffers are empty, it indicates that the memory allocation failed
> multiple times. Should we keep trying to allocate or just log an error 
> message and stop it?

Yes, you can keep trying to refill every time the NAPI loop exits.
That will be at most once per packet (assuming NAPI loop collected
just a single packet). I thought you wanted to return "busy" from
NAPI until memory appears. That'd be "busy polling for memory"..

