Return-Path: <netdev+bounces-205053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FDAAFCFD4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD30A16A245
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2686C2E264F;
	Tue,  8 Jul 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="utOGj/bb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D51A288
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990198; cv=none; b=BKBMDVao6WZ+M8HSHTa/nBiE6GIDAix9uB+lYmcnk1a5sjtsx7wlmKFzxCXI6+wVJQA47M3U7/+tj/s26OY9u/ouYxO9FULiiwAA9njiz7Si7pz10JCskj4kNzNOJ+7juht3iTaJzy/zdsN2huLEdHIhSdr81y46LLdSmVOnicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990198; c=relaxed/simple;
	bh=tPuUoU4N19SV2hBg3rWAtVuKMuqp0Xf16nrENovhyY0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxjmmrwwY8bRN5Ks1OdF/G9sKppwGH/grSHm+dVgvkJi4eSafMkkxM9S+xt4yp2Bk+Yl7PH8O/MXeYU/18Ub3AnEyVEcKKE7d2KV2DM5hePrB5aGBJWFrXwae8O+wD3GoUxXhusciOYS8PhDKF7jHfsRWDPU4ykptbteawPW/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=utOGj/bb; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751990194; x=1752249394;
	bh=tPuUoU4N19SV2hBg3rWAtVuKMuqp0Xf16nrENovhyY0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=utOGj/bbIGcwJqx3lWTfytJeJKci35+kyObCsuv/edI/+xqujIbUio+mwEUOyljn3
	 jSx/zgT5xuGfnHyI/NNEZ+Ifjc2UykzpcZWAehTo26g1XGzY7d2mNjIXvszyChZZ5D
	 ucPhikVXuM5qIZBDWn1CydV3ua7E0UJyP2AvBRW+3KTdpUHf6Le5s7dEAHOKGF3mnf
	 YpIloJKC+D6dIZ3qdalaBOB9cMdYUmZXsP5R93FxWYys0SVJqJ8ix3hHl0DrF+ph0q
	 apLYw5D0DHg7KNSQyXBEIt7YOPg/uW20VZPHKrDO5zjmniWwBnqcJVLmODTw5LY9YW
	 61sIeM9MWRSHQ==
Date: Tue, 08 Jul 2025 15:56:29 +0000
To: Simon Horman <horms@kernel.org>
From: William Liu <will@willsroot.io>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, jhs@mojatatu.com, stephen@networkplumber.org, Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch v2 net 1/2] netem: Fix skb duplication logic to prevent infinite loops
Message-ID: <3SdBpUCGSDH5s1aiYafxKcMPi9-g1hKh11zkNKSudHgduTFQn2w_2biBrtFijTuZgfZFAvx__KRdXywmsN6BYUkFg9AaaZXMlxTG0cwzBHA=@willsroot.io>
In-Reply-To: <20250708131822.GJ452973@horms.kernel.org>
References: <20250707195015.823492-1-xiyou.wangcong@gmail.com> <20250707195015.823492-2-xiyou.wangcong@gmail.com> <20250708131822.GJ452973@horms.kernel.org>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: f447855aa4eab654a7850b259d4adf61ca9059f6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Tuesday, July 8th, 2025 at 1:18 PM, Simon Horman <horms@kernel.org> wrot=
e:

>=20
>=20
> On Mon, Jul 07, 2025 at 12:50:14PM -0700, Cong Wang wrote:
>=20
> > This patch refines the packet duplication handling in netem_enqueue() t=
o ensure
> > that only newly cloned skbs are marked as duplicates. This prevents sce=
narios
> > where nested netem qdiscs with 100% duplication could cause infinite lo=
ops of
> > skb duplication.
> >=20
> > By ensuring the duplicate flag is properly managed, this patch maintain=
s skb
> > integrity and avoids excessive packet duplication in complex qdisc setu=
ps.
> >=20
> > Now we could also get rid of the ugly temporary overwrite of
> > q->duplicate.
> >=20
> > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> > Reported-by: William Liu will@willsroot.io
> > Reported-by: Savino Dicanosa savy@syst3mfailure.io
> > Signed-off-by: Cong Wang xiyou.wangcong@gmail.com
>=20
>=20
> Reviewed-by: Simon Horman horms@kernel.org

From what Jakub and Jamal suggested, the patch for review is now https://pa=
tchwork.kernel.org/project/netdevbpf/list/?series=3D976473&state=3D*

It was marked for "Changes Requested" about a week ago but I don't recall a=
ny specific changes people wanted for v4 of that patch, other than the atte=
mpt at this alternative approach in this patchset thread.

