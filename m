Return-Path: <netdev+bounces-227383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988DEBAE341
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 19:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4979317CE5A
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2A230CB53;
	Tue, 30 Sep 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Q8ihPE4N"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB73090F7;
	Tue, 30 Sep 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253720; cv=none; b=LjuTQW5uoyb6lUWAu7kR8l8bsVzd4cmlmG8BlF6r5EqQvhr9+QBA6FnrOJQSjfR7DfPbjfnxvQ3Kz4KqBLPadiUi2cnn9OeJpn39A5pSCr+zu41SY0n9cYoosZJ+kTZWfNG8d20WWKiBIFQbHvJkudl+W5D8+EMqcs7Xg5FY69g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253720; c=relaxed/simple;
	bh=v3jrUySsdUCuSMSLtdi+xl+npUecrn3TqUP40m9zXC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ShYpX8344/6gtOhLDdOfHMDjaOHhobXow+wKNZhBB5MVxGlJyE/ibeaDo1Yq8RoyA3EcO4ZoA39XrZfu4QaUkBIk0e1tfJpz8HkgqRkraRY3OxDoJEcPAtgbUOlemgjfENcwEarc7cp3bNHU//yoE3O1e1d/skpHer2Sw+0lXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Q8ihPE4N; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759253711; x=1759858511; i=efault@gmx.de;
	bh=UeU+AdMYVPoY9EXENK7q9qM9luQFfa0kyZuRqshuRLo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q8ihPE4N8e5vyxPA9UMsw3Ccvgex7ab6bqyf6uzslwcWGHDqkDvYRY0KoqIawzPZ
	 qjnawZ0VOrpEL9ePT9J5d4uu8VFjFTnTr69Tav6Ydpw/0AJLflNgfes3ms49YihQz
	 vD3YBeSRNyA95ohlGQM/v34cikicDlbWbt7ZU11N/hAnQrfmajp2XGmFaewLZ9mdi
	 BIFoCP9/gYOHDGvb168Lu9vrI35JJ5i3zf85xcS1zZp9ALx/FAT4+cCYMTizBnKh8
	 P6qh8yuuhohK189U+mZ6cVkdks08dJQ+8Z/UMf1zdkY8MHqxFDhUn+KtrmL8JR4IW
	 V4zbKCHYe5LFvPZhNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.92]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJqN-1uZpgz37FD-00bjX8; Tue, 30
 Sep 2025 19:35:10 +0200
Message-ID: <d92202c8ec3d31eb54b41e669e3bf687acbf86e1.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: Sebastian Siewior <bigeasy@linutronix.de>, John Ogness
	 <john.ogness@linutronix.de>
Cc: Calvin Owens <calvin@wbinvd.org>, Breno Leitao <leitao@debian.org>, Petr
 Mladek <pmladek@suse.com>, Simon Horman <horms@kernel.org>,
 kuba@kernel.org, Pavel Begunkov <asml.silence@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>,  paulmck@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
 boqun.feng@gmail.com, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven
 Rostedt <rostedt@goodmis.org>
Date: Tue, 30 Sep 2025 19:35:09 +0200
In-Reply-To: <20250930143059.OA_NFC9S@linutronix.de>
References: 
	<tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
	 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
	 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
	 <84a539f4kf.fsf@jogness.linutronix.de>
	 <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
	 <847by65wfj.fsf@jogness.linutronix.de> <aMGVa5kGLQBvTRB9@pathway.suse.cz>
	 <oc46gdpmmlly5o44obvmoatfqo5bhpgv7pabpvb6sjuqioymcg@gjsma3ghoz35>
	 <aNvh2Cd2i9MVA1d3@mozart.vkv.me> <84frc4j9yx.fsf@jogness.linutronix.de>
	 <20250930143059.OA_NFC9S@linutronix.de>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:WatIRJSJpoEtZTUiQ1w1Ns4MQlTadPo14WMPT2yR7PSB9rjCYme
 rDXh0SA6J0NzWnL5fYIe9KIcF6vRMu0kZe422fJqYtVHKNLJMBecWQxz/lKeEyN/62RIZQ/
 S9oc/7Q+V6fHp1tWULuF/5S+nnJpFZ9DUA7QRyHA5INrXrJXz/HM+bvTML681Hn1RY3PKcE
 82sk+ns64c0jknysJxNGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/qOHgES21uM=;Dd8g651Z8sxnHaFjNw2wArBRYok
 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

On Tue, 2025-09-30 at 16:30 +0200, Sebastian Siewior wrote:
> On 2025-09-30 16:29:02 [+0206], John Ogness wrote:
> > @bigeasy: You have some experience cleaning up this class of
> > problems. Any suggestions?
>=20
> I though that we have netconsole disabled on RT. As far as I remember it
> disables interrupts and expects that the NAPI callback (as in interrupts)
> will not fire not will there be any packets sent. So this is not going
> to work.
> It needs to be checked what kind of synchronisation is expected of
> netconsole by disabling interrupts and providing this by other means.

Oh dear.  It's not netconsole at the root, it's the netpoll it's made
of.  The xmit loops are trylock, but memory alloc/free issue remains,
as does netpoll xmit loops holding IRQs off for up to a tick.

I've been using a test coverage and monitoring patchlet for years that
let's RT relax local exclusion to better suit its needs, substituting
BH for IRQ exclusion.  Due to meeting $subject, patchlet now does the
same whenever wireless nics are in use, as BH exclusion fits them too.
Not super pretty, but dirt simple and effective.

	-Mike

