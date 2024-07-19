Return-Path: <netdev+bounces-112250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A79937B23
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 18:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E7D7B20A49
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C32145FF4;
	Fri, 19 Jul 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dsaDwT+E"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889E1B86D9
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407057; cv=none; b=sKd1/8EVTuZDvxAJcbLBS0Bx+SUuAwtUy8vh0uqw2HScAKVhz1dJli+2ycpAvcU/S7Wo32iFdw13MMctRbGH9/lPBEiEsW4rTXM/82BXMDA7LovYxsCQMWKX5Q1c2tigUZQglIB/NqDF3o1mXLeJj/03XQd3wjrTwJ1TXZa7pmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407057; c=relaxed/simple;
	bh=EWFZmS0QHfj/WPVVbx2hzEOiB6F/jZck/wb3H7CwPJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UiwIDQwUHzQYlzCaeZQjn+vVQMW8NFCypfH63B3b8RLM1q/EGP62m3FvbKaY+hg9CWnBp1n+81krXl2FN5WLyjAv8B6kGS5CW+lHIJxjkz3AjKLS66i/IS5RmvV2L/6ihV6NQRAcsxJY3MXF01KvpztjRu14eotImtFx7+eUCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dsaDwT+E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yig1URcXHQaX3DtoDaRkgMbQM+IVH96dMhptxEBpZIU=;
	t=1721407056; x=1722616656; b=dsaDwT+EB8uuOiuiO62JN4B2uuID6aCP3Z8nr8lKaLxY0a+
	RWr4bj+o8Rh4i58p7XFBmnnQ3bsfm7q3boVhq2sui7lFWLr8wxHYtruGe8WfDMx7KnvAiXi93pAez
	07ngVLJTHBfvZB4yJ71YgdoU9bl/802S7ns3KAbV9GAHRiCSyBhXc8Q6xdXAzskrMGL8v6gE3t3PF
	X+JtOlBDixe2XeQ9RUbLuoaDLW6v5PF0u+T7XQEQ5rYZ3VbMiXnKxl4j1ubTt/yy0T2IrFNdzfrVn
	Vk8FtkaaHhQbcqEk6uori/xMxLTE9yqZnrQS0XUFMX8336hbHqT67WAlCgnuX8nA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sUqbr-0000000422G-3wAL;
	Fri, 19 Jul 2024 18:37:32 +0200
Message-ID: <58b1501ddd7299164cf71768f10d0f4771b18b4f.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/2] net: bonding: don't call ethtool methods under
 RCU
From: Johannes Berg <johannes@sipsolutions.net>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com, Hillf Danton
	 <hdanton@sina.com>
Date: Fri, 19 Jul 2024 09:37:28 -0700
In-Reply-To: <2649494.1721337149@famine>
References: 
	<20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
	 <20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid>
	 <2649494.1721337149@famine>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-07-18 at 14:12 -0700, Jay Vosburgh wrote:
>=20
> 	We can't do this, as it will hit RTNL every monitor interval,
> which can be many times per second.

Fair.

>   The logic is structured to
> specifically avoid acquiring RTNL during the inspection pass.

We also cannot do _that_, however, it's just broken with devices that
want to sleep there. Arguably the common ethtool op that syzbot
complains about is just a distraction, because while that does sleep
(now), it's also equivalent to use_carrier=3D=3D1, so we could just say "oh
if it's the common ethtool op then use the carrier directly", but while
that'd prevent syzbot from reporting the issue again, it'd not actually
fix the problem with all the USB drivers etc.

> 	The issue that szybot is seeing only happens if bonding's
> use_carrier option is set to 0, which is not the normal case.

Sure, but like I said above, syzbot doesn't really matter. Don't get too
hung up on it.

> use_carrier is a backwards compatibility option from years ago for
> drivers that do not implement netif_carrier_on/off (and thus calling
> netif_carrier_ok() would be unreliable).

Sure, OK.

> 	This also came up in [0], and looking now I see there's a patch
> that syzbot tested, although I haven't reviewed it.

+Hillf, I believe that patch is broken because it completely defeats the
purpose of my original patch there, and also addresses only the "syzbot
complains about common ethtool op" issue, not the more general problem.

> 	Another option is to for the Powers That Be to declare that it's
> safe to assume that network drivers implement netif_carrier_on/off to
> advertise their link state, in which case the use_carrier logic in
> bonding can be removed.

No objection to that, if you don't have proper carrier reporting then a
lot of other things will likely be broken anyway?

> 	Or we can somehow isolate the "must acquire RTNL instead of RCU"
> to the problematic use_carrier=3D0 path, but that's a nontrivial change.
>=20

I guess.

johannes

