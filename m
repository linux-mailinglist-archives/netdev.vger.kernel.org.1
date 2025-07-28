Return-Path: <netdev+bounces-210551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE02B13E29
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5757E189FEDA
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1972621;
	Mon, 28 Jul 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmZKWLTl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ADF2905
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716240; cv=none; b=diFqnFA2aRi2v3D3wribjqhPyBrsJi3s+iZtZs8Guc70CFNuIF4ycOjMiWPjZNtOxbTBZEQbOrkEFOF3BL1nFzoMEQJzD3WPfQgqjlUj/Dbn/o1/SOxJAIbUNM/oe1UjP0Uvtdbt+6BT4kqLcxe2pEM7HAvp0lBaf1hhpznR0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716240; c=relaxed/simple;
	bh=qT4zjDk5sY5VzFYcFLh+htjafGOFDWYMxDDCLYM+hrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JL3nXm608F7zNGMQPIC8G5aek7hniPHLikDCW8t9GYW1OvNmNOa/IL6pzgogthZYW+eKNjZ9qlKUPs2xA+ZObNB1oYbVYlN7LBq1JE0GGab3DNZgqkyk+gXn3IqFTAiyYifF9nndz8XQJ4Mj7EOwaJeS7MVZ/KsajE/lSlFp8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmZKWLTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4C1C4CEE7;
	Mon, 28 Jul 2025 15:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753716240;
	bh=qT4zjDk5sY5VzFYcFLh+htjafGOFDWYMxDDCLYM+hrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BmZKWLTlPffVL9eIIt1sdKma9ygHZaiNIQwaWHRBC8boeazOdQhw2px4HixUHXI58
	 EKVopnrAWEWrzQz8t4qMkareaEYCF20B3pO9QHoK27iVsTrW2BTWM8N23BbiLhffKV
	 p1onry503Rmon4PIXcInzRPSQ3OkbhkDV2NXmPkBUjuBz610stTTY5ZN505t6Szg5t
	 PIsCVjJvkYiFeVEopu3QPXkFDZQnMQVmXLcXUAbVwQ56h2xDSZqP1KqSwBIIVMLE0H
	 Fg5hh87fMlb7HRiitJ54K7PWcIaw5MMAWXXP15V/ACkBu3OcBs54T7pfLD0QTcMOOu
	 nh0aKdFNV695g==
Date: Mon, 28 Jul 2025 08:23:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <netdev@vger.kernel.org>, "'Andrew Lunn'" <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>, "'Eric Dumazet'"
 <edumazet@google.com>, "'Paolo Abeni'" <pabeni@redhat.com>, "'Simon
 Horman'" <horms@kernel.org>, "'Jacob Keller'" <jacob.e.keller@intel.com>,
 "'Mengyuan Lou'" <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v3 3/3] net: wangxun: support to use adaptive
 RX coalescing
Message-ID: <20250728082359.170c54a4@kernel.org>
In-Reply-To: <058001dbff65$85628e10$9027aa30$@trustnetic.com>
References: <20250724080548.23912-1-jiawenwu@trustnetic.com>
	<20250724080548.23912-4-jiawenwu@trustnetic.com>
	<20250725173428.1857c412@kernel.org>
	<058001dbff65$85628e10$9027aa30$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 10:15:42 +0800 Jiawen Wu wrote:
> > > +				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,  
> > 
> > so far so good, but then you also have dim instances for Tx ?!  
> 
> I hope RX and TX can share ITR value, because they share the interrupt.
> Once adaptive RX coalesce is on, use the smallest value got from RX sample and TX sample.
> If adaptive TX flag is also set, how should I properly set it? Cooperate with RX?

You can require that both adaptive-rx and adaptive-tx are set to the
same value.

