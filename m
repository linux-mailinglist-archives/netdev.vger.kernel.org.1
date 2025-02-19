Return-Path: <netdev+bounces-167799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9680A3C636
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379833B8859
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799A821423F;
	Wed, 19 Feb 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYXuW6Sf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518231F61C;
	Wed, 19 Feb 2025 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986094; cv=none; b=NY5SfJzdlahdSmb/U8Mvo4QWI/9m65mBaxiVo/VGFKfHa9IBNXEPRrPCrJhC89HzJyyV0o/2hd9EKMHOCE73nFYh4jQEj6Q+QWV0bdBza4IHz9NcKNYlBoTd6C+hRFvgn52mZmCAq7quK79eQXcNzUQs3PKlU5TKqJYdVbncYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986094; c=relaxed/simple;
	bh=sol/rANcPeWqkhz+mfJ5z75eZ81RKc2VAU23pqgdTuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGL8g9ImMbr+udTQoCons0JpC3YeTPa2ShjocW3/Llo3AFl/KpVb8NbRoQN2PTLHOV4dQH2MQWPrd+/dGRUGvhSm8ibIe8gbzO+GlQh3+ubhO16VOeX2vs1GHSz1eq6Bb+jwEIbkN0vAO/deSpCOxkh+Vhf5OfTHUDJk7zzlA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYXuW6Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8777C4CED1;
	Wed, 19 Feb 2025 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739986093;
	bh=sol/rANcPeWqkhz+mfJ5z75eZ81RKc2VAU23pqgdTuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYXuW6SfNquDJH5n8DPAJCtAiok0nnTaVaW0n46/dIL83qHFD15x5GYOSKTUJ+wpX
	 lFSCY6fLEsklWYkSL/K+0iknKhiVM6xN8ghUx6o+G2+tATZq/LodKET3zHaJ1m94tI
	 XZ9VjiqY2Wvr1TEYgMc06C6spnTuAyukQZFu3wK0k5oeZ0gRQIMOCY7oaInZVOId82
	 5DhhcUPqMXnw0Tdo63iuttl5b545ChfmBXwh/ZsxG0GPXbJkuXc9/8Zi4KiPgGsKBy
	 ppq/Zcz+9HI6xV2VWxpO94rh699d2KySTjnPEfVqarryZ/uVPVFyspW70CacTQbbQr
	 SdFf1/I80/TmQ==
Date: Wed, 19 Feb 2025 09:28:10 -0800
From: Kees Cook <kees@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tariq Toukan <tariqt@nvidia.com>,
	Louis Peens <louis.peens@corigine.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, dev@openvswitch.org,
	linux-hardening@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v4 1/2] ip_tunnel: Use ip_tunnel_info() helper
 instead of 'info + 1'
Message-ID: <202502190928.2F4D28C@keescook>
References: <20250219143256.370277-1-gal@nvidia.com>
 <20250219143256.370277-2-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219143256.370277-2-gal@nvidia.com>

On Wed, Feb 19, 2025 at 04:32:55PM +0200, Gal Pressman wrote:
> Tunnel options should not be accessed directly, use the ip_tunnel_info()
> accessor instead.
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

