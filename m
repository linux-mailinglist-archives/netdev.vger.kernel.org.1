Return-Path: <netdev+bounces-69777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF584C892
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910231C2189A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1761825566;
	Wed,  7 Feb 2024 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpIHEqJa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72062555F
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301631; cv=none; b=M0SPQ/ilk71zi1xqJllnI1/+xTzef9RuYjihKCGrl4R+K8+hhRN/F3Hb3kBnO1ezNiNuSKkpUueM3zP5eLrFkQ49ZgoM5159M2DWPS/z3Eh2Y+e0gYivPhR9VVQnmsNNvPlwkr2iIgUgI7TKJXPMAL12et+rJGxS59/LdZ7O+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301631; c=relaxed/simple;
	bh=CbY+NuE+0XEwh9Soc5RUUerrAGILMo9/VYKk3DKA0wE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=TRIwKB4wCePMyhzP/5pU42+aqF8IWtU9O8RX9EtU0uRSqyNjHSuCJsMsjNqsmRyCaldwTAssPZOiTdtmCJ7wMqFlW4MAPTYdXUzkmVQbHCx91sGlmUNbBbkPHvP7YGeQNfUds2vxQSXTs8Td5QKhA+5D1UFwZsMVpRelO5Z1Wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpIHEqJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07549C43390;
	Wed,  7 Feb 2024 10:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707301630;
	bh=CbY+NuE+0XEwh9Soc5RUUerrAGILMo9/VYKk3DKA0wE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MpIHEqJauKesroeng0qSYkS8vhDa4UqNWP1x0z6MauT7PFIwI3t3UduNIH7q7PR22
	 sW7jMPjPpcK5dMMWzYboFhON6eBBNKnqrKNvnWKJ/b7RicjVouKpNjyDrp/QfeYRrb
	 KlNrEan/Vp1l8GoETiXKdUL8JoURCsxSE1otMYEhXfnlgFwfdOoAVHrl/IM5i9PoUP
	 nbY2GeGJW9115xNUHOPTTgohSOmq1cAJNG42V90I28QJU9GfGTjHDB1a+RpJh/pB8/
	 zn/4YNEJUlAk6Z9N0dnfvb7I3POBw1CbDEuGD33A2tCrDAAKpOJFW9YDQDbR4SlD8n
	 oIZGdD6jwSKqw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
References: <20240206144313.2050392-1-edumazet@google.com>
Subject: Re: [PATCH v4 net-next 00/15] net: more factorization in cleanup_net() paths
From: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
To: David S . Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Wed, 07 Feb 2024 11:27:07 +0100
Message-ID: <170730162710.260533.5953063579623359667@kwain>

Quoting Eric Dumazet (2024-02-06 15:42:56)
>=20
> Eric Dumazet (15):
>   net: add exit_batch_rtnl() method
>   nexthop: convert nexthop_net_exit_batch to exit_batch_rtnl method
>   bareudp: use exit_batch_rtnl() method
>   bonding: use exit_batch_rtnl() method
>   geneve: use exit_batch_rtnl() method
>   gtp: use exit_batch_rtnl() method
>   ipv4: add __unregister_nexthop_notifier()
>   vxlan: use exit_batch_rtnl() method
>   ip6_gre: use exit_batch_rtnl() method
>   ip6_tunnel: use exit_batch_rtnl() method
>   ip6_vti: use exit_batch_rtnl() method
>   sit: use exit_batch_rtnl() method
>   ip_tunnel: use exit_batch_rtnl() method
>   bridge: use exit_batch_rtnl() method
>   xfrm: interface: use exit_batch_rtnl() method

For the series,

Reviewed-by: Antoine Tenart <atenart@kernel.org>

Thanks!

