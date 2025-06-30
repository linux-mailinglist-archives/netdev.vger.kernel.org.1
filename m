Return-Path: <netdev+bounces-202531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E66AAEE23F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376763A3D55
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1414C242D77;
	Mon, 30 Jun 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqBqH8bq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E30282FA
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296839; cv=none; b=pV3yv0LDV50aQIHzM9dSbGdi2ApNDHt8OzK3BJBPaS5aaTMZWKb8Z344XwLewn+33YDqH6uYLUsvdLccOEVPdeVuHuX1AqqWlQCWEIgmbT1W+F7zT1/JyRIAAJ5kcH4nai5k0KIO1+CzTSAz8vq4gQAGzbtgL9ZrDhVjzQ3KM48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296839; c=relaxed/simple;
	bh=BBMJSzf3dC4dVy55RFgPwMX3/eT+aAKvAiClcEBUNcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujdbTtbxD69OtqgTQXc0SnD3b5xh1DYX65C6hGTHT8Zd8SIH7WTafJg3TCL/nmbe992VlxJknktVYF4ptLK8odHS3TiaVW6UTJVKK29RlqkBc5oWxWdD7gNrTLuVvpH7sCK4ATrBEmeoSTNmoa0GYJ5rDQE3lalFA06Y+GXBLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqBqH8bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAA1C4CEEF;
	Mon, 30 Jun 2025 15:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296838;
	bh=BBMJSzf3dC4dVy55RFgPwMX3/eT+aAKvAiClcEBUNcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sqBqH8bqbHa7CqkxWEVfPKtVW6Py5CwSIJ5q1a4UIIS7GApWTXJ4WGEIqSFMxP5fa
	 q9xJkRlqq0hse9biqFbnMg2iX06R7u12y7ZPXktQnGVIlKa6UUM4MfB0KQDEtJmTT4
	 1UC0Yrf46/X2cdniuOUG8dUTMYVZJ1PeYGQiiJVw5BhMezZd49s2IQFGPKnuAoSMBb
	 YQc2bWV+Iu8JZiwNc+DzZ7mJ7/A5gL5jZFgvghh8M8a8FMXFwr5XAI0z6yWmgnDELa
	 xFOGQibJPC+cgAI3+UoA8Oi6eZC5UZqyO8vk+bPexKc/Ne9yyZyGen5VBrp3jL3GCh
	 7voQDOT5bDLEg==
Date: Mon, 30 Jun 2025 08:20:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 syzbot+430f9f76633641a62217@syzkaller.appspotmail.com, andrew@lunn.ch,
 maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next] net: ethtool: avoid OOB accesses in PAUSE_SET
Message-ID: <20250630082037.4ac5d518@kernel.org>
In-Reply-To: <aGEPszpq9eojNF4Y@shredder>
References: <20250626233926.199801-1-kuba@kernel.org>
	<aGEPszpq9eojNF4Y@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Jun 2025 13:04:35 +0300 Ido Schimmel wrote:
> On Thu, Jun 26, 2025 at 04:39:26PM -0700, Jakub Kicinski wrote:
> > We now reuse .parse_request() from GET on SET, so we need to make sure
> > that the policies for both cover the attributes used for .parse_request().
> > genetlink will only allocate space in info->attrs for ARRAY_SIZE(policy).
> > 
> > Reported-by: syzbot+430f9f76633641a62217@syzkaller.appspotmail.com
> > Fixes: 963781bdfe20 ("net: ethtool: call .parse_request for SET handlers")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Ido Schimmel <idosch@nvidia.com>
> 
> Thanks, we hit that as well.
> 
> BTW, shouldn't you also release the reference from the net device if
> ethnl_default_parse() fails in ethnl_default_set_doit()?

Oof, good catch! Let me remove this trap of an API :S

