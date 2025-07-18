Return-Path: <netdev+bounces-208201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5540FB0A905
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166F84E0512
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB712E6126;
	Fri, 18 Jul 2025 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkCEA+BV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523EE2E5B2F;
	Fri, 18 Jul 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858191; cv=none; b=GmSy1jcYD53oYFuDv2w4bxCiURkcXdWfcVL2ImAJSVsyMW5r1BNDmm6YmMzuu5uAPk47j7IqC9MyH10cB06D5ITTpZMt5iMvzr5HVwkV4wrFKO4rdL+jF7oVDxIVY3c6WjE4v+edVLHlnxOkPxCfV1bVAJZqZiSltVeyO6w1nlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858191; c=relaxed/simple;
	bh=AMbuJiXUU2z7Ei6EOXHLsRBwhPW5EIyed0dXOSIpjTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wv1E/YlffPRV049ZNLOviE7RXPZ6PbHsUBZEJ3OHlFL/TIW5EoZk51kxq0yVUTlL/2Ha6BeE/9WMEaB0RZ2rwrQOh9XhNvo8b81ycfAh04jPQJ2aUhpDo59MFj+6Oo/A1d9XAG3hKEGWdmZF+f7LS5PZBrllQj2kdG0dQ1AalcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkCEA+BV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D481C4CEEB;
	Fri, 18 Jul 2025 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752858189;
	bh=AMbuJiXUU2z7Ei6EOXHLsRBwhPW5EIyed0dXOSIpjTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dkCEA+BV7IPjhiLll0xnjdSaNzg3n1Z+J9gzf3nY2HiJJYyKfJRWq/F/Rz1jZsTdi
	 anZRTFDclKjkXFXAaY0fdQi5i9AQslox8n8I+roMeNY1ADhuHxN87Jjr4CjC9X0utK
	 8WfCok/yzZJWcIg0mbLZ3J83MhQTGmaOyPc5yfaREf4Nnja/zP5EziOMsprf7Ea8rQ
	 NQ6mbBbKWZhhiwEVRvUyHis4yaYA9H6IjwfSwgWeBi/wx5haNf3C9/anL6zS7MaotG
	 klSqxZhNfUkTF7DHICR7s8V87Rstg0zFtVHt5dJDZAZvwiVTxMSSYo0OHhOdYkkMlg
	 8mmUDI09u+/fA==
Date: Fri, 18 Jul 2025 10:03:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/5] netconsole: move netpoll_parse_ip_addr()
 earlier for reuse
Message-ID: <20250718100308.06c1db67@kernel.org>
In-Reply-To: <20250718-netconsole_ref-v1-2-86ef253b7a7a@debian.org>
References: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
	<20250718-netconsole_ref-v1-2-86ef253b7a7a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 04:52:02 -0700 Breno Leitao wrote:
> Move netpoll_parse_ip_addr() earlier in the file to be reused in
> other functions, such as local_ip_store(). This avoids duplicate
> address parsing logic and centralizes validation for both IPv4
> and IPv6 string input.
> 
> No functional changes intended.

You're moving it to the section of the file under
CONFIG_NETCONSOLE_DYNAMIC breaking the build if dynamic is disabled
-- 
pw-bot: cr

