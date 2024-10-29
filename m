Return-Path: <netdev+bounces-139739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBEF9B3F37
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C91C1C21AD5
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74F5BE49;
	Tue, 29 Oct 2024 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQojNdMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB88F5E;
	Tue, 29 Oct 2024 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161970; cv=none; b=AYf0i3ejruswU7Pr7t/qB5+KCz7spDLYa8ByZ+dEJFROAvtvqd99iM2gX+0oWZagerdnVKpBxXBNvrFEM4fjMLZwj1U7U+TeHgQsM024TP4/J2ZPukDHeA1qf090fxVVPTRoyIFLa1MPw60AmbB/Cezslz+gGUCwOaPFhdXvS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161970; c=relaxed/simple;
	bh=VrGmwAKvt8OuEEU8UFOYAYL/Op/81kQxgvV8yNAWlac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruX4D8trO33ouRXLCqKAQp/fG6/jsEiCvxoByNu6a0zwSq37kuHh21C4inYsBVQZlog7m7xaTyGYoVSbjkuTkSPG6fYIoQDZeE/FOhMk0ogls80LYWT+4No4n0IJ2spAC83Dc9PrrQAW5vlI8pzmavDjadlsWcuh6+ifvv39Txg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQojNdMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEF8C4CEC3;
	Tue, 29 Oct 2024 00:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730161970;
	bh=VrGmwAKvt8OuEEU8UFOYAYL/Op/81kQxgvV8yNAWlac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sQojNdMwb7KKZ5rXzgsyQq+Miz7vK7/LJMBuPSxJ826Q4I3iDQjJ3gJsLA/DiAJFq
	 8nsbcrA/lMEj1o5qnskS3CECbrzx4gfyaS4q6UDfvhUmOcODQczoNPyuZ/3H6AXYWC
	 S+c0VS8ud9LWSp4zlywiDPmUW5ErfE/WnnfpuC+Chc2JEzfhnqDK8mSMiaO3Vq4jqy
	 twSmu4DXAaqFf/5ZyZXNvpmzl+gMGoUuaRgo9Nyf3NijHj06suHzwanDbjRd/BW3VB
	 B5cSkUTI1BDUwZLoNub/ModARMxvQyHldKKF0KMwYXlMEn+1lQmTf0fnprsXpiso0F
	 DzBlV3ooV/WOQ==
Date: Mon, 28 Oct 2024 17:32:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241028173248.582080ae@kernel.org>
In-Reply-To: <158eb222-d875-4f96-b027-83854e5f4275@embeddedor.com>
References: <cover.1729536776.git.gustavoars@kernel.org>
	<f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
	<20241028162131.39e280bd@kernel.org>
	<158eb222-d875-4f96-b027-83854e5f4275@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 17:32:53 -0600 Gustavo A. R. Silva wrote:
> >> Additionally, update the type of some variables in various functions
> >> that don't access the flexible-array member, changing them to the
> >> newly created `struct ethtool_link_settings_hdr`.  
> > 
> > Why? Please avoid unnecessary code changes.  
> 
> This is actually necessary. As the type of the conflicting middle members
> changed, those instances that expect the type to be `struct ethtool_link_settings`
> should be adjusted to the new type. Another option is to leave the type
> unchanged and instead use container_of. See below.

Ah, that makes sense. So they need to be included int the newly split
patch. Please rephrase the commit message a bit, the current paragraph
reads as if this was a code cleanup.

