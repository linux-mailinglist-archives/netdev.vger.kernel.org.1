Return-Path: <netdev+bounces-216957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E9B36990
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AE48E3147
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C637350D44;
	Tue, 26 Aug 2025 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Tc4kWRzt"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C4374C4;
	Tue, 26 Aug 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217425; cv=none; b=m7MVssChcv9bYS8X6/zBI0g48fRfC/NRbjZPbL1GyY4LsLjSrqEza+D5BGYVYIE0nWu3vsVNIMDLfufAyuVU8JCmYh0YdRNBEhsvJjph+tsHGN1NQzibPU4S4k0tAl5JvSow1C311Bz+kivul2o9T093HPRgSYZQCH0dRbwIDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217425; c=relaxed/simple;
	bh=Qwl9rI707fi2KSMqHzwqOIYprkRMmkQI9sfsdfuq3os=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkYvfKiUGUhnN2BCDVzLYgzLmY/YJcDH6RPfVYdhgreU5q9JnSRBOSUaoTm615Ugsoxqg/8cIFPhnEOIKV2GGMJVhbDrt9TgYEiO65+DXVKkc+dfSMxmcfHWtppYSKZBdQv6TBuotmvSIFegbV+Wz7w+0zkf2d1ZC1d2HJaYs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Tc4kWRzt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9M+n4kA2pS5d3rKzerjLvH+nIbGSZpDhSlPqAQjJvhg=;
	t=1756217423; x=1757427023; b=Tc4kWRztGhIp210EvqQiGlTSYLR2saJMoxRIFe172J73iEZ
	z/CxcndGlY2iIITCcw2o3lH/yg7WTIfufqreD5zVxDXotkL3GIG96x1EKDzQJlapTpp/WGNCOOwiI
	Zt7qeflrKVi1MIEHQTYJ1UsDUqB9aqIQFGr6yIg3Bsyd7a0gzLa+Wg8YTIjWP4w18kjNCqoBFwpu1
	3ftoyV8iOHYvk0sW4YegthE8ExUAZTz3zjv7ZZHNZS5Qp13dJoSvE/oRLNMnNPfaLlXcB1HuVoQCW
	taSAjxYYoX+1EeFdSoLCVk1KhmN0VnOKkq9UpEhJjDaZMas73iXg8vguNZ7b3wKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uquNR-00000003j0P-1Cp0;
	Tue, 26 Aug 2025 16:10:21 +0200
Message-ID: <2f22c98bee6c549205efed3cb03b82805cb54977.camel@sipsolutions.net>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>, 
	paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, 	boqun.feng@gmail.com
Date: Tue, 26 Aug 2025 16:10:20 +0200
In-Reply-To: <20250815094217.1cce7116@kernel.org>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
		<oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
		<20250814172326.18cf2d72@kernel.org>
		<3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
	 <20250815094217.1cce7116@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-08-15 at 09:42 -0700, Jakub Kicinski wrote:
> On Fri, 15 Aug 2025 11:44:45 +0100 Pavel Begunkov wrote:
> > On 8/15/25 01:23, Jakub Kicinski wrote:
> > > On Thu, 14 Aug 2025 03:16:11 -0700 Breno Leitao wrote: =20
> > > >   2.2) netpoll 				// net poll will call the network subsystem to s=
end the packet
> > > >   2.3) lock(&fq->lock);			// Try to get the lock while the lock was=
 already held =20
> >=20
> > The report for reference:
> >=20
> > https://lore.kernel.org/all/fb38cfe5153fd67f540e6e8aff814c60b7129480.ca=
mel@gmx.de/>=20
> > > Where does netpoll take fq->lock ? =20
> >=20
> > the dependencies between the lock to be acquired
> > [  107.985514]  and HARDIRQ-irq-unsafe lock:
> > [  107.985531] -> (&fq->lock){+.-.}-{3:3} {
> > ...
> > [  107.988053]  ... acquired at:
> > [  107.988054]    check_prev_add+0xfb/0xca0
> > [  107.988058]    validate_chain+0x48c/0x530
> > [  107.988061]    __lock_acquire+0x550/0xbc0
> > [  107.988064]    lock_acquire.part.0+0xa1/0x210
> > [  107.988068]    _raw_spin_lock_bh+0x38/0x50
> > [  107.988070]    ieee80211_queue_skb+0xfd/0x350 [mac80211]
> > [  107.988198]    __ieee80211_xmit_fast+0x202/0x360 [mac80211]
> > [  107.988314]    ieee80211_xmit_fast+0xfb/0x1f0 [mac80211]
> > [  107.988424]    __ieee80211_subif_start_xmit+0x14e/0x3d0 [mac80211]
> > [  107.988530]    ieee80211_subif_start_xmit+0x46/0x230 [mac80211]
>=20
> Ah, that's WiFi's stack queuing. Dunno whether we expect netpoll to=20
> work over WiFi. I suspect disabling netconsole over WiFi may be the=20
> most sensible way out. Johannes, do you expect mac80211 Tx to be IRQ-safe=
?

I see there's a long thread beyond this, but I just got back from
vacation and haven't read all of it.

As for this question itself, I'd say no. In some cases it probably could
be made safe for mac80211 _itself_ (by adjust that lock and maybe
another one or two), but that wouldn't extend to the drivers, so it'd be
up to the individual drivers. In most cases mac80211 calls wake_tx_queue
(either driver or its own implementation) and that will pull frame(s),
but either way it's going to go all the way into the driver, with
unknown results.

I guess we could do that async since we queue there anyway, but in this
case (of wanting to get things out of a dying system) that'd probably be
counter-productive...

Maybe if it's an individual driver opt-in, but I don't really see it
working for most drivers.

johannes

