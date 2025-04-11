Return-Path: <netdev+bounces-181475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AEAA851CE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 04:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF814A58FD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB5927C14D;
	Fri, 11 Apr 2025 02:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/FyAa7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35A27C141;
	Fri, 11 Apr 2025 02:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744340309; cv=none; b=QwFxv8obcyHcbYJRUynjPN+TS7IzA3a5Ma2MH9QCk8Pb7CzR0EnAo00+hrYAtt8d/iQ0CrGjDViWz78TV9aJJmvyDhBc1srRFmaQ2GLU+/0JcN8VN6zK5ZgBlaVuDfvBopdyudS0/9jiPFwEevDjZr9YHdTgTTRK/RiMbShwvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744340309; c=relaxed/simple;
	bh=YydfOOT36YWq6GE0OBYYkVn0Yb/seNwF6iZKh4oB3KI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+Yf6z1w1DmjxjI+1G7H59Tpzf4P6EeP+KflVYWD0iW7KFTnR/F6kYVyJwkDX0N0XM+RuFZokxvNpBh8ztWYU0TfTFsSGyTin3NtjoZsk7wNeB9RSK0BiUTI/0/0T+OHdaz+Ir8ECXe2ZB31GCMP3yze2avTTkOacje6M2LbGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/FyAa7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA0BC4CEDD;
	Fri, 11 Apr 2025 02:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744340309;
	bh=YydfOOT36YWq6GE0OBYYkVn0Yb/seNwF6iZKh4oB3KI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b/FyAa7MgaYH1QJ3mmX2HlpG6vAiESFMUVpGw55uWAw39PPLAZ1y1hceAWRSBQJ1C
	 LgSmck6eVdzGfHbzB9FINzsMlIoEQrcAs1PTOWaKhNZsKbm8APdCe/Z0H+yYRTQVRd
	 AGToa6YXAJ9qnFQcd8DK+unPjcQczkezNAyYnOchqY+hWTtP+EeNmVpZYVzmiNkBtY
	 P/wuzrc5B5jMpsDcsyapdIpfEutkDaTLQvEJaf9/hUAWBYOpNv3eTTFrWXX0iCSIGv
	 5uV8hLtzqscPlaAQtKAVZp1BCK/E2m0mtmhWdjn5zbuXvr6y6nvk98PgnF1SBnnDLf
	 YVBCTnBnc0CDw==
Date: Thu, 10 Apr 2025 19:58:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Shuah Khan
 <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Xiao Liang
 <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v25 02/23] ovpn: add basic netlink support
Message-ID: <20250410195822.41a77f1c@kernel.org>
In-Reply-To: <20250407-b4-ovpn-v25-2-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
	<20250407-b4-ovpn-v25-2-a04eae86e016@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Apr 2025 21:46:10 +0200 Antonio Quartulli wrote:
> +        checks:
> +         exact-len: nonce-tail-size

some of the checks look slightly mis-indented (needs one more space)

