Return-Path: <netdev+bounces-178795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A9A78ED9
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1BE1885135
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD06238D22;
	Wed,  2 Apr 2025 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW+FrH4n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64971F2BBB
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597978; cv=none; b=Brnncjp0DfHVppcIP9KpZ3t62AkdlGHzyQA569PPhm0a3KPl1xckrbeQTHHVTXjZG5gmNIod+x6Y06hFWuPAHnx5/E+TsuTtELpLxrbjY7O0MOx5B6ubX4e0BU86HrEQa9z6RAo1W8tHtF7WPxvaou0drr2TDTkiq89n0xCiwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597978; c=relaxed/simple;
	bh=gmXrJqMbDJP9L7o/wyuv4H/pXoOv9lxkuJmGIWCbvN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Al8PHh2PdaX0ASPJdpEqgH7AXLfMzXZdjkvuAA64zSFo8H79fvcVGCmX2PIkOB1r9kYJ0yk4hRMjA4vge9azLUQVzcm/sG5PDlOmWep6Q9e21tJwuClv2ONp/sdyp5oDikF0uKU8O7fiqiMVgt9tA6WajCL6JOhe0JLEzLiNjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW+FrH4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841C4C4CEDD;
	Wed,  2 Apr 2025 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743597978;
	bh=gmXrJqMbDJP9L7o/wyuv4H/pXoOv9lxkuJmGIWCbvN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oW+FrH4nOmW+LOhcHKScnN6hctI1oiQGGAa/Xq9iqFM2gzeUmqNn6BSekjELOFo7q
	 CzkJAy8lv2dosxbSRgsec0VMkW1+DeWtFkpv1PEnmaoUUu5E8C7dMDHPcUVWYI3Uh/
	 vHuw2XQyINYpKEePchURX5ix2CDxU8yJjmjOGJq2ob/Zsh8kYUsgl9QG+lVpJ9DpIp
	 8WMOiQ25gY2zuBFcMunbFb3BEumEm24yPdYfBftbUqm/NbPMU+jQowU5wozqa+EQbc
	 NoQzVFNxfwpzhvh8OwHjISPhR/1nBGMLQXpEcmHJ5lqR7qhhD2XlD9kqfTB5fq5UrM
	 Can7EKrBviFmA==
Date: Wed, 2 Apr 2025 05:46:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ilias.apalodimas@linaro.org, dw@davidwei.uk,
 netdev@vger.kernel.org, kuniyu@amazon.com, sdf@fomichev.me,
 aleksander.lobakin@intel.com
Subject: Re: [RFC net-next 2/2] eth: bnxt: add support rx side device memory
 TCP
Message-ID: <20250402054616.4dc1c5b5@kernel.org>
In-Reply-To: <CAMArcTX1Q3Nx=GNiHHom=_P3A-jwT1gjpjh_yegj9CWkXbqvdg@mail.gmail.com>
References: <20250331114729.594603-1-ap420073@gmail.com>
	<20250331114729.594603-3-ap420073@gmail.com>
	<20250331115045.032d2eb7@kernel.org>
	<CAMArcTX1Q3Nx=GNiHHom=_P3A-jwT1gjpjh_yegj9CWkXbqvdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 21:09:11 +0900 Taehee Yoo wrote:
> > Do we check if rx copybreak is enabled before allowing ZC to be enabled?
> > We can't copybreak with unreadable memory.  
> 
> For the bnxt driver, only the first page's data is copied by rx-copybreak.
> agg buffers are not affected by rx-copybreak.
> So I think it's okay.
> I tested rx-copybreak+devmem TCP, and it works well.
> 0 ~ 1024 rx-copybreak and from very small MTU to large MTU.

Ah, good point!

