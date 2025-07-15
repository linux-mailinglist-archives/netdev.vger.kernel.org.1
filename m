Return-Path: <netdev+bounces-207248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4EAB06623
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FEB504BA4
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0D92BE639;
	Tue, 15 Jul 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="j4qA7O1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C4628A402
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604882; cv=none; b=PE4azpoRGnlqZB9+xzG+WEwfKOrgSNs9qS17mB4/YB5DMgNm9kReiR0k7QViqWc0e7ccUC1ac+c9dJp7nvfAflO0+uttRHQzNTJAAGp3nKdcxoVsrd0XyeJr37rbAFogXIEO7/bt9LlHldFT4ZNP8b2HITo7a4WnuWa9HlrKaEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604882; c=relaxed/simple;
	bh=yQg+k6fb+9ZgqH2UOCOw5ct42D4V3pGJTMg7MmEcKxY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kO/ggHL4HOjGLOLdBO3AcVa7g9F9UiaUneMv1c+wUHz/Ql6RyyOQci9iYtFws7C4qyYF5qfViSNi3anU9q5ufRukzJmrkLpuEWffDK98QNZziw5/Mjeb4su/PKk+oKKnLcZDGVjsyR+UMYu9y7IlbkR2kR4Z2alOAysj3J3UEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=j4qA7O1f; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1752604868; x=1752864068;
	bh=yQg+k6fb+9ZgqH2UOCOw5ct42D4V3pGJTMg7MmEcKxY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j4qA7O1f+puDccgzt+HzvBVRkBXqfFwBpOSzsWgaY3OPsp/lqD/gBxQkC6eJBLNDa
	 vtB/uElZB+voJzxbZ7KUXH08qDzhzuvBilCecgI2KcTg03O7p3rzFYlG55XwBP11p3
	 YwEwHIKHFTTmUJt+GeFHq2kga1vH2od5060MvDlqW/62Y7ZyAiXyaelfU3Z0n+tOci
	 B+/FgrOOuZtjZ+08du8xBBTvno3RIqpybJAbtlCSWQkdtHdfdTDcPeAeGH7viyinZT
	 6lbjpbttSnQECmu8PzsW3/81ddxVr0MpcgxqyBcsx2oC58bgPWMq3bMVRo3Dy+HVMJ
	 l2etY7Wf5WccQ==
Date: Tue, 15 Jul 2025 18:41:05 +0000
To: Cong Wang <xiyou.wangcong@gmail.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, stephen@networkplumber.org, Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch v3 net 1/4] net_sched: Implement the right netem duplication behavior
Message-ID: <xi0MIYyksyLO_1P2VCdlupWbaZk4XFWqX4yq0L-ZjavT4RyEnl7KzGTnk9aAOWdSFAUIhR8nCN3U5_0kwyG6iDDfdTxWeQsaFIJS_WSOEiw=@willsroot.io>
In-Reply-To: <aHaX8n8o/fLBi57L@pop-os.localdomain>
References: <20250713214748.1377876-1-xiyou.wangcong@gmail.com> <20250713214748.1377876-2-xiyou.wangcong@gmail.com> <pGE9OHWRSf4oJwC4gS0oPonBy8_0WsDthxgLzBYGBtMVeT_EDc-HAz8NbhJxcWe0NEUrf_a7Fyq2op5FVFujfc2KyO-I38Yx_HlQhFwB0Cs=@willsroot.io> <aHaX8n8o/fLBi57L@pop-os.localdomain>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 5f4d2356bcc0f7e45fc87a28eb7ab3ab78d8bed8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, July 15th, 2025 at 6:03 PM, Cong Wang <xiyou.wangcong@gmail.com=
> wrote:

>=20
>=20
> On Mon, Jul 14, 2025 at 02:30:26AM +0000, William Liu wrote:
>=20
> > FWIW, I suggested changing this behavior to not enqueue from the root a=
 while ago too on the security mailing list for the HFSC rsc bug (as the re=
-entrancy violated assumptions in other qdiscs), but was told some users mi=
ght be expecting that behavior and we would break their setups.
>=20
>=20
> Thanks for your valuable input.
>=20
> Instead of arguing on what users expect, I think it is fair to use the
> man page as our argreement with user. Please let me know if you have
> more reasonable argreement or more reasonable use case for us to justify
> updates to the man page.
>=20
> I have an open mind.

I don't really have too strong of an opinion here and personally think it m=
akes more sense to enqueue from the current qdisc under duplication. Howeve=
r, if the code has been performing the enqueue at the root from so many yea=
rs ago..

I will defer to what others say on this.

> > If we really want to preserve the ability to have multiple duplicating =
netems in a tree, I think Jamal had a good suggestion here to rely on tc_sk=
b_ext extensions [1].
>=20
>=20
> Do you mind to be more specific here? I don't think I am following you
> on why tc_skb_ext is better here.
>=20
> The reason why I changed back to netem_skb_cb is exactly because of the
> enqueue beahvior change, which now only allows the skb to be queued to
> the same qdisc.
>=20
> If you have a specific reasonable use case you suspect my patch might
> break, please share it with me. It would help me to understand you
> better and more importantly to test this patch more comprehensively,
> I'd love to add as many selftests as I can.
>=20
> > However, I noted that there are implementation issues that we would hav=
e to deal with. Copying what I said there [2]:
> >=20
> > "The tc_skb_ext approach has a problem... the config option that enable=
s it is NET_TC_SKB_EXT. I assumed this is a generic name for skb extensions=
 in the tc subsystem, but unfortunately this is hardcoded for NET_CLS_ACT r=
ecirculation support.
>=20
>=20
> IMHO, Kconfig is not a problem here, we just need to deal with the
> necessary dependency if we really need to use it.
>=20
> Like I said above, I don't see the problem of using netem_skb_cb after
> enqueuing to the same qdisc, this is the only reason why I don't see the
> need to changing it to either tc_skb_cb or skb_ext.
>=20
> Thanks for your review!

If tc_skb_ext is used, then the original behavior of enqueue from root can =
be preserved and multiple duplicating netems can now exist in the tree in a=
ny hierarchy. No potential user setups or expectations will be broken.=20

I am not sure how others would feel about propagating this amount of change=
 though just for this one specific use case though (but I am of the opinion=
 that not hardcoding NET_TC_SKB_EXT for one specific use case is a good thi=
ng regardless).

Best,
William

