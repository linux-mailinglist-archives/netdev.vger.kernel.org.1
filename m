Return-Path: <netdev+bounces-122156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7659602F1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97ED3283094
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB949148FE1;
	Tue, 27 Aug 2024 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P7QXms1b"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF45B33999;
	Tue, 27 Aug 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743423; cv=none; b=GKOywmHP8yt+0rbi/Dy3MHr6gdA1wCE7DWCGOMgohuOOhV+x1nLc7VJ51RDemzWQ/I9/DnDLgkERIqQoMFbLFrNYvaL3E/yRSkqCmn3d1OSDuhhNlhpOm2whHsnEEgfrnMH9eBEjJBakBZ7kWEDxPOMcVdSPl5exqH1NvLbkQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743423; c=relaxed/simple;
	bh=2rECGyWZ+FRfZt/8J7fETlHqNpv/DOmb9UU9bZbMPQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkvcdFkAKIDINIsWo51J5apVLJ0zsdVmzit2HTNebn8Li/gwdX/N5raqjzgz+EzcJ0qagrHcGqOrhydcovHtOSbH/fxgMWdPRy+D3uOKt+zcWEFM6zOXSAv+J8LJ1rlHph75dT1E+Rvy0/AtV8wSEalRuj/ThRLR76uagSguMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P7QXms1b; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D08E1C0004;
	Tue, 27 Aug 2024 07:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724743419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsh4CUmIbXcKfGNtpmfHGFRPg2Hxi62eZORcnrnzLN0=;
	b=P7QXms1brU4E6NHxWUlAqtICVeZjATeGxwqgJnmkCqtxnlGVe83uLF5oxvYbKKEQgPp7oI
	04a9ogGRvHwQCn7hKMWc4fF+dKA4vdA3I/wO5EEOcAoNpEIBv8hv6QAZTJZx/Bd43bXyZ9
	D7ZgWIX/E5O0s4TgHZSKoj8q+i3g3fSIi0u7oIrZ1C4W8PQpWKonhXKD8xCWrtzbyt4wLZ
	dQmwnAh0GSbEJ9e8ZSQruG5I41vkHgtg+fEktGSjBC2fH/1Kdo4utsHqkTjiAn1Ux9Or3f
	1Fu2yG88HupUPU2u8LqGvcWW4J5b7oiCpbGJbCtd81g8lMhGp1Il4VjX5bgG/g==
Date: Tue, 27 Aug 2024 09:23:36 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch net-next v3] net: ethtool: fix unheld rtnl lock
Message-ID: <20240827092336.16adeee3@fedora-3.home>
In-Reply-To: <20240826173913.7763-1-djahchankoike@gmail.com>
References: <20240826130712.91391-1-djahchankoike@gmail.com>
	<20240826173913.7763-1-djahchankoike@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Mon, 26 Aug 2024 14:38:53 -0300
Diogo Jahchan Koike <djahchankoike@gmail.com> wrote:

> ethnl_req_get_phydev should be called with rtnl lock held.
> 
> Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
> Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>

This looks good to me.

Even though RTNL is released between the .validate() and .set()
calls, should the PHY disappear, the .set() callback handles that. 

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

