Return-Path: <netdev+bounces-161961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B1A24C81
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 03:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B6E3A54E6
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 02:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13838C07;
	Sun,  2 Feb 2025 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGOhwFu1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8285234
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738462682; cv=none; b=ixEdXzvDrePZsdo0AT26NwMg2/WRfWON9UifJ6YqJ/kQ1LFtMpnLMd1ratuCHtPWLvsUl6qoX5pEYegQCSt1tXXK/KLrAaFp+k0ViLGqF8g1x61si4HIINWKl7M0ihON07Jn/kIHO5Jr8EAY4uBZ9xp+uSGseZtHVMU5urc5TVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738462682; c=relaxed/simple;
	bh=/3H5yf7FzrabJDmIibncpgkLHhFWj6duHGerXH8OZWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f38wndD7INR28ocAKL93PJvAB8UuXFwXV8c7A3JVK/6ZoVhhBE2A9Dt6exOIBbUKskauMmiqY7UNK5oBF8HXpSJ8HFeE2W5hPaf2Ws6xnABspfTlUPZ5SyFKZqB/LLMyGX0xruC6ymHsnBmiPRXBBi26f62GyzJ0Za15ktDbqks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGOhwFu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE397C4CED3;
	Sun,  2 Feb 2025 02:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738462682;
	bh=/3H5yf7FzrabJDmIibncpgkLHhFWj6duHGerXH8OZWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hGOhwFu1SnrYzLWmn+5BeZFXO+3vghO+00RNVk9tCC6Lle7VciP0zmRaN8ndE/0Ud
	 WdI4tR5BYLoc7aJMIKGFy/+aiG8Cz28u9zrn/zgD2Zbx/f6wahUH9Rg186cp5Bpsq4
	 1DFoN09IDstlDvNKoxwF21FgbZsb03nAX6I8T4jEASirrEcnm/UqQmlgVTO+fPVAbc
	 +iarGl2ol8Qd7Ui8sOoJgCS3pzrneM2HEZ0FQZ5wAHyD2iex/VMsCQFiubElSn9lql
	 tuq3Rh2z44fTAqXd9Zd65ZDPF0+iW5zddeOhqiNy1xRFcigY/1E07h34fw2kEATHju
	 gPai+dxdA9X7Q==
Date: Sat, 1 Feb 2025 18:18:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net 00/16] net: first round to use dev_net_rcu()
Message-ID: <20250201181801.4427248a@kernel.org>
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
References: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jan 2025 17:13:18 +0000 Eric Dumazet wrote:
>   ipv4: use RCU protection in inet_select_addr()

patchwork thinks it's an incomplete series due to lack of this patch 
on the list. I'm afraid a repost will be needed :(
-- 
pw-bot: cr

