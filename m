Return-Path: <netdev+bounces-108841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DAE925F4F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0445128B425
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B6515D5B3;
	Wed,  3 Jul 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pcS+WE4+"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8E17334E;
	Wed,  3 Jul 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007792; cv=none; b=SwX9msO+pygTUrD1ptfvaXa+g+zSQwnj00A1+sUHmv2vEdZuFbNwpLBnR2kN0nb7xgkhQX3+pWBy1+tttg1+ASe79kgNZIdNwmqmU95d/ZzLmIm2kmjhCNWVb2R/JnDcv5Blv4/yJNb+KxIEslG4lvjRvzilx8ZmkrPjRyEwBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007792; c=relaxed/simple;
	bh=pa0BbAJnpQCZ8YmzHdt8extE4JGitdsthqfyiB6n3Ag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fcrRoOHXCjxplN/r2vnH+eSlA87M6jUf6CTcLoahZ4uwD1ofJg4J8kzr4zPH5gKx0jrnNP8cTw3ipguKQQJQSubS79EtdaAOd2smbwU2yzaimtWAlhSaYf9E2vemsHd2mFUbV5OSm+iLA7wwiCiAgU9TRRR2YHENkXVplLJBGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pcS+WE4+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FmZ4Y7/HFmvSSNlD1efee8gNUvKzCwyE9Dzfh0Sl05A=;
	t=1720007790; x=1721217390; b=pcS+WE4+JZj9P2hhf5MQlhf08i1D3VagQ0KwDU/v65a6f60
	FxfX6+azNrarCYhx40RxE9KolmrD78Ccg2eEgzyvgLb7fPlwU6G737HzDyWjr5Hz7WGdIG0202zP2
	IZHsmiYEn46nN8rizgUzpqzwAeJHsiPC13bvM6LoEeZlfdz9MC3uFu1JTk91En9XCxGtSwOfgk2xx
	2RwW1LvMJ/CykAujyibpGxdTx6jKbcctZXm4XyMcFhF5N/xaDpCKb7kFVDwBCTl6/x8XZSzqYafz1
	cCqwosx3awU4iKVoDb8sefreTeJBTpK9L3yXNcge/mFrNnL4in4+IovoLhGoaBrw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOyaw-00000008rOt-26JU;
	Wed, 03 Jul 2024 13:56:18 +0200
Message-ID: <a6430c7b6af910894ed891e12e18b020d53e8f4e.camel@sipsolutions.net>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in dev_activate
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Dumazet <edumazet@google.com>, syzbot
	 <syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "Hadi Salim, Jamal"
 <jhs@mojatatu.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>
Date: Wed, 03 Jul 2024 13:56:17 +0200
In-Reply-To: <CANn89iJFATii0PdPxfhjurHXiBo6j5Dgqunok1dLJw_NNYtb7g@mail.gmail.com>
References: <000000000000227d2c061c54ff82@google.com>
	 <CANn89iJFATii0PdPxfhjurHXiBo6j5Dgqunok1dLJw_NNYtb7g@mail.gmail.com>
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

On Wed, 2024-07-03 at 10:10 +0000, Eric Dumazet wrote:
> I think this came with this patch :
>=20
> commit facd15dfd69122042502d99ab8c9f888b48ee994
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Mon Dec 4 21:47:07 2023 +0100
>=20
>     net: core: synchronize link-watch when carrier is queried

Yes, that makes sense.

> Issue here is that ethtool_op_get_link() could be called from RCU context=
s.

That's ... unexpected, and apparently not just to me. First (but not
only) example I found: usbnet_get_link() calls mii_link_ok() calls the
driver's mdio_read(), i.e. sr_mdio_read() which does a mutex_lock().

And it was always broken? I can't really find anything that introduced
this problem directly - even before 4cb4f97b7e36 you had a read_lock()
there, and the bond slave_dev->ethtool_ops->get_link() call goes back to
the beginning of git history, the usbnet example is just slightly newer
from c41286fd42f3, but even before that there are examples in usbnet
drivers with this problem.

> Adding linkwatch_sync_dev() in it broke this case.

Right, I agree that it made the problem much more wide-spread than it
being driver-dependent as it was before.

Perhaps we should change bond? The original commit that added RCU there
said it even considered RTNL instead.

At the very least I'd say some _big_ documentation is needed there in
ethtool, and probably then __ethtool_get_link() should also
rcu_read_lock() to make this consistent. But like I said, I'm not sure
it isn't bond that's on the wrong side here.

> BTW, this commit also made it difficult to convert "ip link" dumps to
> not use RTNL, but rely on RCU instead.

You could probably sync all of linswatch beforehand, and only acquire
the RTNL if there's work to be done at all?

johannes

