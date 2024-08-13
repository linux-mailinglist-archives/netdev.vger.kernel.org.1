Return-Path: <netdev+bounces-117883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A20494FACC
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 02:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE06A1C21B66
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671B3524F;
	Tue, 13 Aug 2024 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwWhOEgY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419679F2
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723509649; cv=none; b=DAqIgp9xbgyLfT0vTJwcnG8NqLWuqsnJzbFUmgrmr8xlr0CwzIRfcmgNiYrY+/c7HdZ0ePZo+swEQkdE6gCGMwnKaC1Rh0Zulsking0hWWvuKSZYEsJLu2YhqYRQNt/ZeYXlbCH3g+HmkS9l1rrqbzCdPoshxKzIjQqX6eXtuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723509649; c=relaxed/simple;
	bh=/QrkkgCFqi72QhGUFrGb6BPkRX3Hcg9JhnR2Tz3/4iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hg+hTfkS772WkNoeoYt3wGWqJa18z9+1SOR6LTC0D5I6vFlsnq5Rp7lMaVvLJBsA6ktU3Wno9u/N2KWsYxcYShdjaFg9JANu+p8btazI9VC55XGix1UV7glre92Hy6wUqfk+YeWCupdrG8m52yL5s4OJ43i7LWvADcnaR6r0B38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwWhOEgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBEBC4AF0D;
	Tue, 13 Aug 2024 00:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723509648;
	bh=/QrkkgCFqi72QhGUFrGb6BPkRX3Hcg9JhnR2Tz3/4iQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DwWhOEgYRnoJDDmqJvnAehBgjaVNeDafALDaEL7Qd1JK+8Pw7bOUZ7o6j31cXj+7i
	 aG61hLReAp9PaaCcNw4IoUx6SC3Io19ZS9ij0BriCcgwj0AVNutlIg4dr9vS5Wjdrb
	 PpkeTX30OdigcpQ0Bxy/fUbVXmvQdNC5jzlYTCAn5ytFYXcDCxKcgYilEmBoolh4iI
	 Dfg+6rZSe/jDLXHGnXHU16w/5NXNETE9lZXrmbQes/557H7/AejNtCLb7cm/Axnr6h
	 R8kPo/y/VIgD+XeguOQLj1elZau8T1qromtqj6LF1gRGbzcGWhPUfNdc219/TUYeOT
	 uNtrW8kYjU82A==
Date: Mon, 12 Aug 2024 17:40:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Mina Almasry <almasrymina@google.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, David Howells <dhowells@redhat.com>,
 Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH net-next 0/5] tc: adjust network header after second
 vlan push
Message-ID: <20240812174047.592e1139@kernel.org>
In-Reply-To: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
References: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 13:56:44 +0300 Boris Sukholitko wrote:
> More about the patch series:
> 
> * patches 1-3 refactor skb_vlan_push to make skb_vlan_flush helper
> * patch 4 open codes skb_vlan_push in act_vlan.c
> * patch 5 contains the actual fix

The series is structured quite nicely for review, so kudos for that.
But I'm not seeing the motivation for changing how TC pushes VLANs
and not changing OvS (or BPF?), IOW the other callers of
skb_vlan_push().

Why would pushing a tag from TC actions behave differently?

Please also add your test case to
tools/testing/selftests/net/forwarding/tc_actions.sh
if you can.

