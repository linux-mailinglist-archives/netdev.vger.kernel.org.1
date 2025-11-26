Return-Path: <netdev+bounces-242099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0EC8C3CF
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7B83A95F7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFD533F8B3;
	Wed, 26 Nov 2025 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="j30qKAuC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D46E2FBDFF
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764197005; cv=none; b=j+XXsfojnepT4IyrYQgbiXQi+W+jw7CMUECHIlhdoBjsRvfbCunH7QcxD9xaUvkf159+rvQRSS3sTMnbkib8xuqrOUcH+xrAlY5gpLUqefX21KePkwkSfUucR53c71sDSCfQIxzctm3ilT0vjiO7pAu4Y9x285m69nFBz91xBNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764197005; c=relaxed/simple;
	bh=Gl3448YDQhHub9agEbGREFi6nCVi0ZcOAklK+F9xn/Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww3UXldLdf4dbUUFFTCfKUh2WEJUF/9qW/Or32K4CkVktKxvWsOR7Pgb4JssU/ME7i0LTcl2FORR4Vt7hle5AcaCygoIJQWrVIba8Hr4hLdggcdVt7ODivXWG4py9sLhjnFC3bWWYC8M7AMbMyn1Z88C7mxjC/u9WZd9PQDDvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=j30qKAuC; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1764196994; x=1764456194;
	bh=Gl3448YDQhHub9agEbGREFi6nCVi0ZcOAklK+F9xn/Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j30qKAuC5xgVt0DNW5/ddltu0w+VETRNd8PsxrvmyBE76YH3LOLQp8XN/oTWCj0pt
	 0nR1O/NatNWRgTFFGjQ1WrjNsJkQtiNQUtg+fnPFrpUQpz7J9QymPXE+mBspRzuMww
	 xbv7dPyGfSAbhTlc3sHLIPbi+C3laXAUqZBDOXUACRgyvLksT+AdRkUhsoP0/kQ5fg
	 DNINE/wlPKYYjdreoqY1fe8D5VS76XOvk2T2zkoKt7R2T/5GZPe0G1otadD9JlBhOG
	 KV3BIMCoKDibMh1GMFCX+kSlCg3pWm1gkMs6kZLAD+RLmvXRe8g7WR5RXGpqmjicqS
	 zNiC+Z3nMWAdg==
Date: Wed, 26 Nov 2025 22:43:07 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, kuba@kernel.org, Savino Dicanosa <savy@syst3mfailure.io>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [Patch net v5 3/9] net_sched: Implement the right netem duplication behavior
Message-ID: <JgkxCYimi4ZuZPHfXoMUgiecvZ0AKYxbIhqPQZwXcE4yC9nYnfproH5yrmQETZUo55NOjj5Q9_bOFJbWI351PFvc9wv3xiY_0Ic9AAsO1Ak=@willsroot.io>
In-Reply-To: <aSd6dM38CXchhmJd@pop-os.localdomain>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com> <20251126195244.88124-4-xiyou.wangcong@gmail.com> <dEmtK-Tj-bnNJVo0mNwP1vJ1cj9g0hqnoi-0HJdZeTittbRmmzE4wBRIjapBAFQNZDWgE4hcR27UrTSuiGj_-yRFntfX4Tuv4QP6asVecZQ=@willsroot.io> <aSd6dM38CXchhmJd@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 9ee82c9b81333d0e6ed13d86c732ca7b65c22734
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 26th, 2025 at 10:08 PM, Cong Wang <xiyou.wangcong@gm=
ail.com> wrote:

>=20
>=20
> Hi William,
>=20
> On Wed, Nov 26, 2025 at 08:30:21PM +0000, William Liu wrote:
>=20
> > On Wednesday, November 26th, 2025 at 7:53 PM, Cong Wang xiyou.wangcong@=
gmail.com wrote:
> >=20
> > > In the old behavior, duplicated packets were sent back to the root qd=
isc,
> > > which could create dangerous infinite loops in hierarchical setups -
> > > imagine a scenario where each level of a multi-stage netem hierarchy =
kept
> > > feeding duplicates back to the top, potentially causing system instab=
ility
> > > or resource exhaustion.
> > >=20
> > > The new behavior elegantly solves this by enqueueing duplicates to th=
e same
> > > qdisc that created them, ensuring that packet duplication occurs exac=
tly
> > > once per netem stage in a controlled, predictable manner. This change
> > > enables users to safely construct complex network emulation scenarios=
 using
> > > netem hierarchies (like the 4x multiplication demonstrated in testing=
)
> > > without worrying about runaway packet generation, while still preserv=
ing
> > > the intended duplication effects.
> > >=20
> > > Another advantage of this approach is that it eliminates the enqueue =
reentrant
> > > behaviour which triggered many vulnerabilities. See the last patch in=
 this
> > > patchset which updates the test cases for such vulnerabilities.
> > >=20
> > > Now users can confidently chain multiple netem qdiscs together to ach=
ieve
> > > sophisticated network impairment combinations, knowing that each stag=
e will
> > > apply its effects exactly once to the packet flow, making network tes=
ting
> > > scenarios more reliable and results more deterministic.
>=20
>=20
>=20
> Thanks for your quick response.
>=20
> > Cong, this approach has an issue we previously raised - please refer to=
 [2]. I re-posted the summary of the issues with the various other approach=
es in [3] just 2 days ago in a thread with you on it. As both Jamal and Ste=
phen have pointed out, this breaks expected user behavior as well, and the =
enqueuing at root was done for the sake of proper accounting and rate limit=
 semantics. You pointed out that this doesn't violate manpage semantics, bu=
t this is still changing long-term user behavior. It doesn't make sense imo=
 to change one longtime user behavior for another.
>=20
>=20
> If you have a better standard than man page, please kindly point it out.
> I am happy to follow.
>=20
> I think we both agree it should not be either my standard or anyone's
> personal stardard, this is why I use man page as a neutral and reasonable
> stardard.
>=20
> If you disagree man page is reasonable, please offer a better one for me
> to follow. I am very open, I just simply don't know anything better than
> man page.

I agree that your change does not violate manpage semantics. This was the o=
riginal fix I suggested from the beginning, though other maintainers pointe=
d out the issue that I am relaying.

As I wrote in my previous email, "as both Jamal and Stephen have pointed ou=
t, this breaks expected user behavior as well, and the enqueuing at root wa=
s done for the sake of proper accounting and rate limit semantics."

The previous netem fix changed user behavior that did not violate the manpa=
ge (to my knowledge). This one is the same - you are fixing one user behavi=
or break with another. Both are cases of Hyrum's law.

>=20
> Sorry for my ignorance. Please help me out. :)
>=20
> > Jamal suggested a really reasonable fix with tc_skb_ext - can we please=
 take a look at its soundness and attempt that approach? No user behavior w=
ould be affected in that case.
>=20
>=20
> As I already explained, tc_skb_ext is for cross-layer, in this specific
> case, we don't cross layers, the skb is immediately queued to the same
> layer before others.
>=20
> Could you please kindly explain why you still believe tc_skb_ext is
> better? I am very open to your thoughts, please enlighten me here.
>=20

Yes, if we re-enqueue the packet to the same netem qdisc, we don't need thi=
s, but that changes expected user behavior and may introduce additional cor=
rectness issues pointed out above.

If understood Jamal correctly, tc_skb_ext allows us to maintain both the re=
-entrant at root behavior AND prevent DOS.

I hope you can understand I am trying to relay problems other maintainers h=
ave pointed out repeatedly; I personally don't have a strong stake in this.

> Thanks,
> Cong

