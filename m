Return-Path: <netdev+bounces-206357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B88B02BFC
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 18:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EC7A47CB7
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858E2857F9;
	Sat, 12 Jul 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="ykhIWjMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA872750FB
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752339116; cv=none; b=Dv1sS4E03IJU+ztk1QovYS1N5/Utu1Ztg77HLcZdxlaJEhN7sg1GsmFt3UN1epVymX0ukXmv7GVM4DCXpjFhaOg/Nr/qb1iLBM5Hb6lRFK4j+nh17NYC5vHfCzij6ex9awnGOx8EaawjyyWuWbPE3ZBfp/XoxojbUVKamhMiJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752339116; c=relaxed/simple;
	bh=qza05lza6gb87u4mUP3nQTSQUJjEpdNgU+7wR5EkS30=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=By4kpEnP47w4bFPJQQiNB0sbpwOvzAs5pJh2KvGzu4/8u0TUft3hltZ8EDTuBQPx6vrW700weF5TA+xtmvGBCm5F8NaAdjBhzZLj7sxCbndVlEzxkSBV38fkSJGklksu+HRfF966vu7vwtkz8iY4xqnWTGZq+u9c20XxaPLUDuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=ykhIWjMU; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1752339105; x=1752598305;
	bh=qza05lza6gb87u4mUP3nQTSQUJjEpdNgU+7wR5EkS30=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ykhIWjMU0lDthqtLwm/KQBR5x1kTfRDiLH2VNCoTdDODFsgFf8/8oGII8O2NaD8kO
	 kddizbC/vTKTvFM9iNaXzrWnjT4DRExm/ayWZi7WRy8euTvzIkn7vCSLpSevH+YpwO
	 QZryLpKnFYsx5JlfdpPa/GKabCuwGMCgX1sEvhasrgywJNZDoPFaopfujAQwqSnrLu
	 BgDRHm3lq+++9EquO6IWjvvWfjERvmjBS0dpUxlMVkhLY+IwWoYvX3OTkTCqrMV3dO
	 eyuu4C65elsU0SfI83nwrghLwgFWqWCzbpyG+rkIQ+W+2P7a8UVegPfqTND4zHs3+X
	 GXxgJaLquLXDQ==
Date: Sat, 12 Jul 2025 16:51:39 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net v5 1/2] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Message-ID: <Xkn0k1T1WExEErBWNX2KpV5LgS9_QyNobWmlUUjcpihDZ5oJrCtZyvuXfiTnrGiOGQnKVQatnw0suv3voQl_6lMrncCe5NdO3NaQliF16mc=@willsroot.io>
In-Reply-To: <20250711155506.48bbb351@kernel.org>
References: <20250708164141.875402-1-will@willsroot.io> <20250711155506.48bbb351@kernel.org>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 4da2c8d22e3e242b77956bece8db107ec9a8bf53
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, July 11th, 2025 at 10:55 PM, Jakub Kicinski <kuba@kernel.org> wr=
ote:

>=20
>=20
> On Tue, 08 Jul 2025 16:43:26 +0000 William Liu wrote:
>=20
> > netem_enqueue's duplication prevention logic breaks when a netem
> > resides in a qdisc tree with other netems - this can lead to a
> > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > Ensure that a duplicating netem cannot exist in a tree with other
> > netems.
>=20
>=20
> We already had one regression scare this week, so given that Cong
> is not relenting I'll do the unusual thing of parking this fix in
> net-next. It will reach Linus during the merge window, hopefully
> the <2 week delay is not a big deal given how long we've taken already.

If this is going to net-next, will this still be a candidate for backportin=
g like other recent net/sched bug-fixes? Or will this only be considered fi=
xed starting 6.17 onwards?

Best,
William

