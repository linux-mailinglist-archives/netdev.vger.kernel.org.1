Return-Path: <netdev+bounces-103670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB36908FDD
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AEE2B289DB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850716B751;
	Fri, 14 Jun 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4FzgjLd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7C02232A;
	Fri, 14 Jun 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381739; cv=none; b=SmbOewHjVKBr/31ZagPObp1RX7jNHt9wXVAIEz5dg7MBTloJX1zJ+Wc3XAoikYHaTgCdLy/pw/SRudn9ZvA1o4YIFaZlttLS+xPt8YqfZj8F9ixjU6dk9tR0VCklYMv/tYy1yNxQ2/30a2h61hTOUyW488hLcUFWC1VVCQZ1ByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381739; c=relaxed/simple;
	bh=lLNDiROxpO6pLANFAbPa5fupMdZGiml5z4NIV4Owxxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZVluSrdCDuAhnnRHt0E0gHVVYJma6IamsRcGfnMDh18k800RaPqkFI7aOB6q2HBpyw68dRXOUn4AzDN2AJvGG2opo+o3aWvT0NFMpn7Vo0cLImhrhuCr7ALgn9GLzsdfvZIyh210+AMb0P7qOkXeZllrSBNhY3JAQg+z7u/DmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4FzgjLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A95DC2BD10;
	Fri, 14 Jun 2024 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718381739;
	bh=lLNDiROxpO6pLANFAbPa5fupMdZGiml5z4NIV4Owxxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4FzgjLd3XJALTHDN5SZ0DxcxIl2HYKxFd1d1aBzzoSRnUkpUmVCpZXm/xtvyBN80
	 PZrbxByDpl6sJNTS3KK/kPylUy1+Bj2tygRjWXU+UxESnLf9B3wxhBPozqq4MfNlTm
	 LbSi2Qa8ryW7VvzIorqf0YOhGAzxZ3IbJ3e84oJGUHLN/CTEZE2TTEtcFO4PhlsuY7
	 O9w2KFqxI31a6py5slXQiTIjMwlSV77lsFw5yl/lyfZiJooqBJ/3QYl/NoGVbDAkbH
	 OY3EH9pOmIXepJF5k/2H9YGR1Z6AAh1ZMpZ/gCI7wn4dp6bl/fUTsgqrlM057+o+DD
	 KkmKhHyb4MUMg==
Date: Fri, 14 Jun 2024 17:15:34 +0100
From: Simon Horman <horms@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	i.maximets@ovn.org, dev@openvswitch.org,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/9] net: psample: skip packet copy if no
 listeners
Message-ID: <20240614161534.GT8447@kernel.org>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-4-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185647.2310748-4-amorenoz@redhat.com>

On Mon, Jun 03, 2024 at 08:56:37PM +0200, Adrian Moreno wrote:
> If nobody is listening on the multicast group, generating the sample,
> which involves copying packet data, seems completely unnecessary.
> 
> Return fast in this case.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


