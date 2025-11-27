Return-Path: <netdev+bounces-242131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F5EC8CA3F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ECD3AD9F8
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243D924503F;
	Thu, 27 Nov 2025 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="VyzULnO5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5224337B
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764209420; cv=none; b=hN3SHEX7jgDCw/r1xQ8O1jhs2CcK0KbmNu6gwPskoaphoE9lJ93rDQaSUrOGykyj9N049nZTEbteDL2GFM8CjcH/Vf2idJV3W1niwtu3/YT9oUh9U9MYwmyXACtDTrsqt7BKPLsjTPyAYrjUsp0NjIVAHNhBo+rkZPfj5t4SUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764209420; c=relaxed/simple;
	bh=elkV15Fs8uvab7uQnhKv56JerGPw+Vz9GvBGzznb7uY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHLdwJFhAtzaDZ0/P8BnLS4lxOQYI3/yLsfFh3kTzcaKk+DcvTq0t3W9hkH92o+wqeapK89RwH9Lv9faFQe7NTrNrLdtku8VN54CxGFobhA25vclajgVQ/YOrNB8HcpOR7GLlE+mCIUAe0I+NT6riDS3aCDQQb7g+0y7DcLb+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=VyzULnO5; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1764209401; x=1764468601;
	bh=elkV15Fs8uvab7uQnhKv56JerGPw+Vz9GvBGzznb7uY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VyzULnO5F1oRCD+PG/AYj1dUaR2cH7HRDUm2qctDUdtGFa8phlGTPEs0Aq6sNKz7D
	 5YewjDgPAzLchOCN+zmhbFZBBrLueXrLRv8uEUQVQc7XbSth7ON6XpotAXRqOBm4FW
	 ZnEn4A/nAFxwerX1mGlwF064pOvCFaAT0tN39hKRdyuoM/CrhQExtbvts+a92zkdst
	 0175thClED1lPlGoWmjgkY24T/kYsR+AhT/GOOUIhEciNhDx3QkNWn7v+PG++pOYYN
	 0IKEYeO3E6PhLb0SoBDbOD46s3sQdBPU0kfG+rKpR33RbzJyXMguAeM2CiCYETMKc4
	 K9MxrZb1OGMRw==
Date: Thu, 27 Nov 2025 02:09:58 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, kuba@kernel.org, Savino Dicanosa <savy@syst3mfailure.io>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [Patch net v5 3/9] net_sched: Implement the right netem duplication behavior
Message-ID: <mz8HnpeShmNHFgeE6yoGG_gb5l1mHqvNee9aRtGX6yTz5zDvf2I4U1wKtH9k5qkfz0SfUfhsonzrzDSgvyM9vRRyvktvYwtTHvfmcZK_Sp8=@willsroot.io>
In-Reply-To: <aSeJo5C9tA93ICcy@pop-os.localdomain>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com> <20251126195244.88124-4-xiyou.wangcong@gmail.com> <dEmtK-Tj-bnNJVo0mNwP1vJ1cj9g0hqnoi-0HJdZeTittbRmmzE4wBRIjapBAFQNZDWgE4hcR27UrTSuiGj_-yRFntfX4Tuv4QP6asVecZQ=@willsroot.io> <aSd6dM38CXchhmJd@pop-os.localdomain> <JgkxCYimi4ZuZPHfXoMUgiecvZ0AKYxbIhqPQZwXcE4yC9nYnfproH5yrmQETZUo55NOjj5Q9_bOFJbWI351PFvc9wv3xiY_0Ic9AAsO1Ak=@willsroot.io> <aSeJo5C9tA93ICcy@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 8963e200793c57cfe1d05b6b04813600e3bcd704
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 26th, 2025 at 11:13 PM, Cong Wang <xiyou.wangcong@gm=
ail.com> wrote:

>=20
>=20
> On Wed, Nov 26, 2025 at 10:43:07PM +0000, William Liu wrote:
>=20
> > > If you have a better standard than man page, please kindly point it o=
ut.
> > > I am happy to follow.
> > >=20
> > > I think we both agree it should not be either my standard or anyone's
> > > personal stardard, this is why I use man page as a neutral and reason=
able
> > > stardard.
> > >=20
> > > If you disagree man page is reasonable, please offer a better one for=
 me
> > > to follow. I am very open, I just simply don't know anything better t=
han
> > > man page.
> >=20
> > I agree that your change does not violate manpage semantics. This was t=
he original fix I suggested from the beginning, though other maintainers po=
inted out the issue that I am relaying.
> >=20
> > As I wrote in my previous email, "as both Jamal and Stephen have pointe=
d out, this breaks expected user behavior as well, and the enqueuing at roo=
t was done for the sake of proper accounting and rate limit semantics."
> >=20
> > The previous netem fix changed user behavior that did not violate the m=
anpage (to my knowledge). This one is the same - you are fixing one user be=
havior break with another. Both are cases of Hyrum's law.
>=20
>=20
> They are two different things here:
>=20
> 1) The behavior of "duplicate" option of netem, which is already
> documented in the man page. This is why I use man page as the standard
> to follow.
>=20
> 2) There are infinite combinations of TC components, obviously, it is
> impossible to document all the combinations. This is also why I don't
> think Victor's patch could fix all of them, it is a simple known
> unknown.
>=20
> For 1), the documented behavior is not violated by my patch, as you
> agreed.
>=20
> For 2), there is no known valid combination broken by this patch. At
> least not the well-known mq+netem combination.
>=20
> I am open to be wrong, but no one could even provide any specific case so
> far, people just keep talking with speculations, so unfortunately there i=
s
> no action I can take with pure speculations.
>=20
> I hope this now makes better sense to you.
>=20
> > > Sorry for my ignorance. Please help me out. :)
> > >=20
> > > > Jamal suggested a really reasonable fix with tc_skb_ext - can we pl=
ease take a look at its soundness and attempt that approach? No user behavi=
or would be affected in that case.
> > >=20
> > > As I already explained, tc_skb_ext is for cross-layer, in this specif=
ic
> > > case, we don't cross layers, the skb is immediately queued to the sam=
e
> > > layer before others.
> > >=20
> > > Could you please kindly explain why you still believe tc_skb_ext is
> > > better? I am very open to your thoughts, please enlighten me here.
> >=20
> > Yes, if we re-enqueue the packet to the same netem qdisc, we don't need=
 this, but that changes expected user behavior and may introduce additional=
 correctness issues pointed out above.
>=20
>=20
> Again, it does not violate the man page. What standard are you referring
> to when you say "expected user behavior"? Please kindly point me to the
> standard you refer here, I am happy to look into it.

I meant long-time existing user-observable behavior (since 2005).

>=20
> > If understood Jamal correctly, tc_skb_ext allows us to maintain both th=
e re-entrant at root behavior AND prevent DOS.
>=20
>=20
> No, the whole point of this patch is to change this problematic
> behavior, without violating man page.
>=20

If that's the case, I will defer to other maintainers then.

FWIW, the commit (0afb51e72855) that introduced this mentioned that the cur=
rent behavior helps "avoid problems with qlen accounting with nested qdisc.=
"

If you were just trying to fix the bug, then a fix that prevents DOS and ch=
anges no existing observable behavior is better imo.

> > I hope you can understand I am trying to relay problems other maintaine=
rs have pointed out repeatedly; I personally don't have a strong stake in t=
his.
>=20
>=20
> Your independent thoughts are welcome, no one is absolutely right, there
> is no one you need to follow or relay.
>=20
> BTW, I already responed to them. Please let me know how I can be even mor=
e
> clear.
>=20
> Regards,
> Cong

Best,
Will

