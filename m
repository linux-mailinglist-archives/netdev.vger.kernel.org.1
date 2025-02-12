Return-Path: <netdev+bounces-165326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B8A31A77
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD62D166D74
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A55B17C2;
	Wed, 12 Feb 2025 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4fl0Qgt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115C2111;
	Wed, 12 Feb 2025 00:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320134; cv=none; b=axT1R5KiTpzqzPBjTpA13jj7kOXuDMgGtIhdZvSmj31JJI/oKrnf+qDTKWWYHh2Txnckbh+XGonwLMZHlH/GE41tlhnxBngwU5QWZki8hec1PUuVfW1BwFF8y2RX7CupzCpoCAkZzb/BhSVqySdGBgTdIBNdqS5Y2N6nQ7P37cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320134; c=relaxed/simple;
	bh=PX0y80qAB6JuymCN0sWZFKFBTK8nn1vKz6jz9qDkfNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKSK23b+zrYSFmiuM3sa1ouIStfVyhtkwmrmozaMVVW9u1AdgoYnp8zLhohUejKxPKv2lI7qdy4g6vJ4iBa0L8fGTfdh7qKM96iFWbl2UtCmWu5TvI5pEuOamc/7HXbWL5FUv6P2fmXTz7TgKoAgzCoUV2+l2stS75eQlPD+G08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4fl0Qgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853F1C4CEDD;
	Wed, 12 Feb 2025 00:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739320133;
	bh=PX0y80qAB6JuymCN0sWZFKFBTK8nn1vKz6jz9qDkfNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4fl0QgtXvVUEzoGD1EQzZWCYsHA3Fk8rw8Uc9ALrQ5ledczjrbZCIHuZlCArt17d
	 01zF3F5GeME12DA34GIx7xsSE/sN2NnHHbT+30J0UvNy/rIugtbDEn8HWhLTlBSF0w
	 JoNWqPrkxkk+hAmE4b+aX9kmf72y2t6hbPn1M1Iy1jVQMIzujvo8P4MtSsNj7OROLc
	 /rZPvRB7y5QQFbhTqgb6bwJwne15spPkMd34ZZC0iay5OBcNcFeP8ZrQjmYNOAWtIF
	 yywKVO1Vbb9qmzXozpfP6W1lYqgX2RXR8tELUkt7/bmblsVFJ26cX2TUPFnHvmMK7Q
	 sZ3JduWbXydqA==
Date: Tue, 11 Feb 2025 16:28:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Kees Cook <kees@kernel.org>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan
 <tariqt@nvidia.com>, Louis Peens <louis.peens@corigine.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Pravin B Shelar
 <pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dev@openvswitch.org, linux-hardening@vger.kernel.org, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next] net: Add options as a flexible array to struct
 ip_tunnel_info
Message-ID: <20250211162851.4409b61a@kernel.org>
In-Reply-To: <ee761ca9-5aa0-4f48-96b9-295ed2c444c4@nvidia.com>
References: <20250209101853.15828-1-gal@nvidia.com>
	<202502110942.8DE626C@keescook>
	<ee761ca9-5aa0-4f48-96b9-295ed2c444c4@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 20:59:24 +0200 Gal Pressman wrote:
> > Everything else looks very good, though, yes, I would agree with the
> > alignment comments made down-thread. This was "accidentally correct"
> > before in the sense that the end of the struct would be padded for
> > alignment, but isn't guaranteed to be true with an explicit u8 array.
> > The output of "pahole -C struct ip_tunnel_info" before/after should
> > answer any questions, though.  
> 
> Thanks, I will attach pahole's output in the commit message.

Why not slap an __aligned(sizeof(void *)) or just __aligned(8) 
on the new option field? That should give us the same behavior 
as we have today implicitly.

