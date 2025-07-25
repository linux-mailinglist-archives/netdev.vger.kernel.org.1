Return-Path: <netdev+bounces-209933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE2EB11592
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 03:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0241CE42DA
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 01:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C8A199E89;
	Fri, 25 Jul 2025 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evzm3eUS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEBD2E36E3;
	Fri, 25 Jul 2025 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753405960; cv=none; b=G++hd7Tvrt7lXN1qmYTW2a3Ndc6VGY+9kyGNzxsbYcIFizzKQyLZCxFEsj7IRdr5jj++NbZqzo22uf+FlMtDdH2pvcGZDgh9f2kM959Ty61QdROA5a8zDhTDhdzOuNb8pC0i+IaHXnFWv9eWhvndCNi+rwxXZQv4cJ51Ao+61LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753405960; c=relaxed/simple;
	bh=EYIRq2VM5vfyfzF+kJOF2cgj0uudSeF5lQM4EtxFsTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/cU+AZZMnFuZ0OqLm3BK90u3oM8ucf5U+NVOr1v8wXY5y2FLrjyMu3Lp1m8ue8IJ43GmSMoqIR0uv+YHnG4ouXb/X1tRY8gb8PtU5wWXq8P/15G+dlkJ7l8FiKU0mTjL4gVpORjZq0t7e1bo+Bxix60HI9YKL2wENeWNh+4zgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Evzm3eUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B07C4CEED;
	Fri, 25 Jul 2025 01:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753405956;
	bh=EYIRq2VM5vfyfzF+kJOF2cgj0uudSeF5lQM4EtxFsTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Evzm3eUShlxsqe8tBmydpWDhn6AvapfCeya7rtDzzaCYQCn98BJ1RFwQHNOUwfTwB
	 KLTEqkrFoVUtsZXv+iA9kJ/sR044W5ZjOee1kOAu3mZwBzZLuNScsPNa/19plgVtAa
	 +TjDhPhjhRWMEEWUfHpj9/6J+oLylIcvDyYr7CfjTDxVAAj2JfNltkaHE6VwJ1pTR6
	 m9l7VRlBzEFknfitt895lGEX0tZvCxVe/xHZ2HrbJV7sI+P/hWgoOF2sbFw/iI/ZWT
	 gj1cuxqx71lO0aM3/s+JbzaRVJb6fU8z/M+ep5ezhHbuPa3K0/vAZddjKMb46IQB4O
	 i8Qfh3GLjA00A==
Date: Thu, 24 Jul 2025 18:12:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] vrf: Drop existing dst reference in
 vrf_ip6_input_dst
Message-ID: <20250724181235.55ad8514@kernel.org>
In-Reply-To: <aIJ2OA6fnxrdo2XE@mini-arch>
References: <20250723224625.1340224-1-sdf@fomichev.me>
	<aIIXQiu5i_ABjqA9@shredder>
	<aIJ2OA6fnxrdo2XE@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 11:06:48 -0700 Stanislav Fomichev wrote:
> Not sure how that happened.

FWIW looks like your hash is coming form the NIPA testing tree:

commit 8fba0fc7b3dec1abc4dd57449d578d8c2682d60e
Author: Li Shuang <shuali@redhat.com>
Date:   Fri Jul 18 22:16:12 2025 +0800

    selftests: tc: Add generic erspan_opts matching support for tc-flower
    
    Add test cases to tc_flower.sh to validate generic matching on ERSPAN
    options. Both ERSPAN Type II and Type III are covered.
    
    Also add check_tc_erspan_support() to verify whether tc supports
    erspan_opts.
    
    Signed-off-by: Li Shuang <shuali@redhat.com>
    Signed-off-by: NipaLocal <nipa@local>
-- 
pw-bot: cr

