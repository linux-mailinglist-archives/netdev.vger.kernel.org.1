Return-Path: <netdev+bounces-12961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD394739973
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1D1281882
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E719616406;
	Thu, 22 Jun 2023 08:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556413ADF
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:26:15 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C571FC1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BThcAkpoygWCU/efkGXPT7nC3qwkRpDfOklWc3qAs0Q=;
	t=1687422373; x=1688631973; b=x1R9nuF8es7D3ahvLE2RyMPgUu25KAMI58Z7y59ZdRXc2RP
	P2NG1RwssPRtHPBDWifi2mUmzxB52qLp3KprpensqaOrfl3WrS0SKHVp3Q4ROzRRUCv2n1qtbVBd7
	7NxjzwYOK5jB5qPku9MtfuuqlWcFNmSXOkiGKWQMS4YJNXKq05M0aizBYOqkmEwAOv6EX9lOzrUCZ
	jxc49TMMI/gg/xnfTANqRDpjXlezDkt3emlosp0HcSnchyipdtj2ZWoh7pyMlUxDkxyoxBI+vtLtX
	J5z/KixOz2vz3/F4reqzwbAx2JqAZhxPWpO9Nrba96OWgCcmerUmsNk8RjhJsH7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qCFdf-00EatV-0H;
	Thu, 22 Jun 2023 10:25:59 +0200
Message-ID: <ad471e9fe6a9b3812497c40456cba6e0c8a152ee.camel@sipsolutions.net>
Subject: Re: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, 
 "syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com"
 <syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com>
Date: Thu, 22 Jun 2023 10:25:57 +0200
In-Reply-To: <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com>
References: <20230621154337.1668594-1-edumazet@google.com>
	 <ZJQAdLSkRi2s1FUv@nanopsycho>
	 <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-06-22 at 08:14 +0000, Eric Dumazet wrote:
> On Thu, Jun 22, 2023 at 10:04=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >=20
> > Wed, Jun 21, 2023 at 05:43:37PM CEST, edumazet@google.com wrote:
> > > syzbot reported a possible deadlock in netlink_set_err() [1]
> > >=20
> > > A similar issue was fixed in commit 1d482e666b8e ("netlink: disable I=
RQs
> > > for netlink_lock_table()") in netlink_lock_table()
> > >=20
> > > This patch adds IRQ safety to netlink_set_err() and __netlink_diag_du=
mp()
> > > which were not covered by cited commit.
> > >=20
> > > [1]
> > >=20
> > > WARNING: possible irq lock inversion dependency detected
> > > 6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted
> > >=20
> > > syz-executor.2/23011 just changed the state of lock:
> > > ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0x2=
e/0x3a0 net/netlink/af_netlink.c:1612
> > > but this lock was taken by another, SOFTIRQ-safe lock in the past:
> > > (&local->queue_stop_reason_lock){..-.}-{2:2}
> > >=20
> > > and interrupts could create inverse lock ordering between them.
> > >=20
> > > other info that might help us debug this:
> > > Possible interrupt unsafe locking scenario:
> > >=20
> > >       CPU0                    CPU1
> > >       ----                    ----
> > >  lock(nl_table_lock);
> > >                               local_irq_disable();
> > >                               lock(&local->queue_stop_reason_lock);
> > >                               lock(nl_table_lock);
> > >  <Interrupt>
> > >    lock(&local->queue_stop_reason_lock);
> > >=20
> > > *** DEADLOCK ***
> > >=20
> > > Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table()"=
)
> >=20
> > I don't think that this "fixes" tag is correct. The referenced commit
> > is a fix to the same issue on a different codepath, not the one who
> > actually introduced the issue.
> >=20
> > The code itself looks fine to me.
>=20
> Note that the 1d482e666b8e had no Fixes: tag, otherwise I would have take=
n it.
>=20
> I presume that it would make no sense to backport my patch on stable bran=
ches
> if the cited commit was not backported yet.

I'd tend to even say it doesn't make sense to backport this at all, it's
very unlikely to happen in practice since that code path ...

> Now, if you think we can be more precise, I will let Johannes do the
> archeology in ieee80211 code.

I first thought that'd be commit d4fa14cd62bd ("mac80211: use
ieee80211_free_txskb in a few more places") then, but that didn't call
to netlink yet ... so commit 8a2fbedcdc9b ("mac80211: combine
status/drop reporting"), but that's almost as old (and really old too,
kernel 3.8).

But again, I'm not sure it's worth worrying about ... Actually I'm
pretty sure it's _not_ worth worrying about :)

johannes

