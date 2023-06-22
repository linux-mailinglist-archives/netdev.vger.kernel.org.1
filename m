Return-Path: <netdev+bounces-13003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21448739A7F
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1912280DC0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C71F3AA8A;
	Thu, 22 Jun 2023 08:44:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5780C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:44:45 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7812D78
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MqbI5q6EuYEL3/WkkRa3AhVWJCtHhHAOh26jcyc8ASs=;
	t=1687423465; x=1688633065; b=aVNic42WB5nfKoLmoePpAwlbG1+NsINdUjRgR6RZGoTw2yD
	oAW6JNsC85g5BrMKmw1LIRIY0l+1brNVKGKDSPtr0Hx4au7DJBSJvDeUVQzyxZz8LpIPB9aPfz0mv
	6GQudcuQhRebi8Wtqlg2UiKF4uNhBgxK2ec2XssN7KwsamXI2Eg5pPfuKSfmM1H4/k+jaZvsTYTj8
	JN/xreipSBZBVBfrgGlqTte0yocrbl5Qlz1bH/SVrH8Qhp+T9pkbnk6a0wme4IpYPHyAe803Q+pVf
	cn1n0x5GddchhC4EqeilSCRgKQU5sudmI1bjKRlyd/V6xOUQn5vhC1BvnY9Iv24Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qCFvM-00EbLw-1F;
	Thu, 22 Jun 2023 10:44:16 +0200
Message-ID: <adc98602aba4ca1d3251da8279abbad98ef6a184.camel@sipsolutions.net>
Subject: Re: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com"
 <eric.dumazet@gmail.com>, 
 "syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com"
 <syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com>
Date: Thu, 22 Jun 2023 10:44:15 +0200
In-Reply-To: <CANn89iJRWp9o1fcnGmC7GO0BKA-Rki+0k93Vt=Zo365OkdS=_Q@mail.gmail.com>
References: <20230621154337.1668594-1-edumazet@google.com>
	 <ZJQAdLSkRi2s1FUv@nanopsycho>
	 <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com>
	 <ad471e9fe6a9b3812497c40456cba6e0c8a152ee.camel@sipsolutions.net>
	 <CANn89iJRWp9o1fcnGmC7GO0BKA-Rki+0k93Vt=Zo365OkdS=_Q@mail.gmail.com>
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

On Thu, 2023-06-22 at 10:39 +0200, Eric Dumazet wrote:
> >=20
> > I first thought that'd be commit d4fa14cd62bd ("mac80211: use
> > ieee80211_free_txskb in a few more places") then, but that didn't call
> > to netlink yet ... so commit 8a2fbedcdc9b ("mac80211: combine
> > status/drop reporting"), but that's almost as old (and really old too,
> > kernel 3.8).
> >=20
> > But again, I'm not sure it's worth worrying about ... Actually I'm
> > pretty sure it's _not_ worth worrying about :)
>=20
> OK, should we revert your patch then ?

No no, I think we need that original commit, and also the fix now.

> I am slightly confused, you are saying this bug is not worth fixing ?

Sorry, yeah, that wasn't really clear. I'm saying it's no worth worrying
about backporting it to stable and really figuring out where it was
introduced, since it's never actually going to happen in practice. We
never even hit the code path that made lockdep show it in any prior
testing with lockdep (which we do too), and actually causing the
deadlock is far, far, less likely since you have to race simultaneously
with an interrupt from the same device (where the netdev down is
happening) doing something to the queue state ... so that already needs
multiple interfaces since one is just going down, etc.

> This will prevent syzbot from discovering other bugs, this is your call.

Oh sure, I agree we should fix it and I think your fix is fine. I'm just
not sure why we're having a discussion about backporting it and what it
really fixes when it's never really going to happen in practice, and
even syzbot couldn't figure out how to reproduce it due to the race
nature of the issue.

johannes

