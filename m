Return-Path: <netdev+bounces-56082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E461C80DBDF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224601C2149A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EB053E3D;
	Mon, 11 Dec 2023 20:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 14090 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 12:42:43 PST
Received: from 6.mo576.mail-out.ovh.net (6.mo576.mail-out.ovh.net [46.105.50.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6DBE3
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 12:42:43 -0800 (PST)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.140.177])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 89CB6274BC
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:47:51 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-hznkr (unknown [10.110.96.35])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id BE2ED1FE04;
	Mon, 11 Dec 2023 16:47:50 +0000 (UTC)
Received: from courmont.net ([37.59.142.101])
	by ghost-submission-6684bf9d7b-hznkr with ESMTPSA
	id sT/OKjY9d2Va+AAAGgGHxg
	(envelope-from <remi@remlab.net>); Mon, 11 Dec 2023 16:47:50 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G0048eaa972c-c1f3-46da-8c8b-782ecd81a60b,
                    7FBF38BF62821C46071231C39A97DD9406C7E705) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:87.92.194.88
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: courmisch@gmail.com, imv4bel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, v4bel@theori.io
Subject: Re: [PATCH] net: phonet: Fix Use-After-Free in pep_recvmsg
Date: Mon, 11 Dec 2023 18:47:47 +0200
Message-ID: <4366234.TZO2pnkceX@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20231206042519.GA5926@ubuntu>
References:
 <20231204065952.GA16224@ubuntu>
 <A2443BF8-D693-4182-9E07-3FFA33D97217@remlab.net>
 <20231206042519.GA5926@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 4410994360715712851
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkfhojghfggfgtgesthhqredttddtjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhfegfeefvdefueetleefffduuedvjeefheduueekieeltdetueetueeugfevffenucffohhmrghinheprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht

Le keskiviikkona 6. joulukuuta 2023, 6.25.19 EET Hyunwoo Kim a =C3=A9crit :
> Hi,
>=20
> On Mon, Dec 04, 2023 at 09:12:11AM +0200, R=C3=A9mi Denis-Courmont wrote:
> > Hi,
> >=20
> > Le 4 d=C3=A9cembre 2023 08:59:52 GMT+02:00, Hyunwoo Kim <v4bel@theori.i=
o> a=20
=C3=A9crit :
> > >Because pep_recvmsg() fetches the skb from pn->ctrlreq_queue
> > >without holding the lock_sock and then frees it,
> > >a race can occur with pep_ioctl().
> > >A use-after-free for a skb occurs with the following flow.
> >=20
> > Isn't this the same issue that was reported by Huawei rootlab and for
> > which I already provided a pair of patches to the security list two
> > months ago?
> Is the issue reported to the security mailing list two months ago the same
> as this pn->ctrlreq_queue race?

No, it was another similar problem but the fixes did cover both, I think?

> > TBH, I much prefer the approach in the other patch set, which takes the
> > hit on the ioctl() side rather than the recvmsg()'s.
> That's probably a patch to add sk->sk_receive_queue.lock to pep_ioctl(), =
is
> that correct?

More or less

> > Unfortunately, I have no visibility on what happened or didn't happen
> > after that, since the security list is private.
> Perhaps this issue hasn't gotten much attention.

Quite possible, but now I'm between a rock and a hard place, because I don'=
t=20
know what's (not) going in the security mailing list. In my understanding, =
it=20
was not really OK to bring the issue or post the patches on netdev :shrug:

=2D-=20
=E9=9B=B7=E7=B1=B3=E2=80=A7=E5=BE=B7=E5=B0=BC-=E5=BA=93=E5=B0=94=E8=92=99
http://www.remlab.net/




