Return-Path: <netdev+bounces-144223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A03629C61DB
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E911F22E36
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD3219E31;
	Tue, 12 Nov 2024 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="00ninf1A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728EA21D228
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440928; cv=none; b=XRO5fmKLijtTlk1YL7Mn4ZeyXs5R4TU1Ue/sAJ+6nD6RZaq6Z+EmOFkwS8ykrYmSmc7JMQ5x63EcmH72s5ztrMAWIfpeQb8aJqbCSEO3XWDi3uRANKhIotzmLkq8JidVvPMydd0WOKnlsX/MGOTi39UxoUxOTITbzgVmyMmXQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440928; c=relaxed/simple;
	bh=bv1bD3DTJl3OlSUTGK0Ns0I+pBp6aRbwW7SZVQNso/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/j6rdn9Hh6IxkqsD5lFf9YVs6N3WlbkSRn4cgvtU80df72or6eOgfxMHcoxYbpawU1YhrABv4pRQMTlJYuiujD8kmtAVYVLKJFs8zRjUA3OsHrZp2ka0t77zK5FAnH2g3wkaQie/PZ4Ie99tYnDar6Ifp+cxUueTt0i5wSgQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=00ninf1A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FZfkWfWolAvtialz3NdL55N0tY8qs8mq0xNY1DMTats=; b=00ninf1AZAyKujY/1w85TAPGYT
	OUQgfRn44Up/XxKP5W8xOBitWLHEFbUDEtSzDgpktMRn+y7QWHiXA1J9b02Ux9D5XEEDgctA0zblh
	npuZPVV9bLUqiotVes+ZfqhPlt4olvCPxF6Qq7U9gQVqfcNyTouaG8M19g5m2NMjkfPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAwek-00D4jF-B4; Tue, 12 Nov 2024 20:34:30 +0100
Date: Tue, 12 Nov 2024 20:34:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Yuyang Huang <yuyanghuang@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	roopa@cumulusnetworks.com, jiri@resnulli.us,
	stephen@networkplumber.org, netdev@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Ruddy <pruddy@vyatta.att-mail.com>
Subject: Re: [PATCH net-next] netlink: add igmp join/leave notifications
Message-ID: <b47b1895-76b9-42bc-af29-e54a20d71a52@lunn.ch>
References: <20241110081953.121682-1-yuyanghuang@google.com>
 <ZzMlvCA4e3YhYTPn@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzMlvCA4e3YhYTPn@fedora>

> > This enhancement allows user-space components to efficiently track
> > multicast group memberships and program hardware offload filters
> > accordingly.

Sorry, i missed the original posting.

Please could you say more about programming hardware offload filters?
How is this done?

	Andrew

