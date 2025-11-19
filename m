Return-Path: <netdev+bounces-239764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E338CC6C3E1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CA2734FEFD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6076E22D9E9;
	Wed, 19 Nov 2025 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUP03K4g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB31F4606;
	Wed, 19 Nov 2025 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515577; cv=none; b=EOQPGBTe0TyR8onZ8Z3RPccFCtGdk+aqjImUPpSzGeyE04E4ayovCCGjfvTBUdfZCiQEcaFW3FWl+lGGHfXmpwptEonct+hM4bJBW0Vdqb3rGCebeOxmj4JVaGrNWZQJ0wIQZOUtFNixbcScS34OSXZv9ZGG5hjoJZ/1h7rLV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515577; c=relaxed/simple;
	bh=6MkOsWAO2IN2kHt27nbuLETLlM3DkFwCgdDFpmSMsSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7MoSrIW1EhynWQNDxsEkrIEAsoivj1JIYvupp3nU7zOSA1am+P4p9EIEnqBkHlx1LmElgmHh6Ru1Du85JzG805ppFurZtUsOU/RHNH7jNJ0u9vJQhtQ4kQMKd2N7b/D9cfkpzOnR8tUshaxAbqTpRhSFbrqCdSb3U5RGIdKUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUP03K4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AAFC2BCB6;
	Wed, 19 Nov 2025 01:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763515575;
	bh=6MkOsWAO2IN2kHt27nbuLETLlM3DkFwCgdDFpmSMsSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUP03K4g9q5Woi7Ne4uR2OpoxU1dk0CGWUBI/qA6/5txa12O1z9Y+XDy5zffq0Jm9
	 U8TX0eIm3j8pA3wwoPXRJCu573MW/W0yrJ6b5DtCgBoUQjS2XviyWxX0xeBmNp+vV/
	 uSnwzPjqWTOvak7ayA0pNRrOJYsAH6Ylo3TTZsGwQoNNXprQWwpblxBbq2hIu4i/cc
	 avswSF/QAGrURKtU5Em3OSHBr8ft8ZmAHdl7ngiHeFY/y67oVnEZhW7bwx9VcFytgc
	 DRSlNue9JGAdKJPxw+fKotKZ4Q+P3vm1zjoqBhLtj9AH9Zsdfq02BqacJTZ+M7wKNI
	 jgkz4EZ0eCfVQ==
Date: Tue, 18 Nov 2025 17:26:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrey.bokhanko@huawei.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 05/13] ipvlan: Fix compilation warning about
 __be32 -> u32
Message-ID: <20251118172612.1f2fbf7f@kernel.org>
In-Reply-To: <CANn89iJvwF==Kz5GGMxdgM6E8tF8mOk0gUqSt2Lgse-Cvpo9=g@mail.gmail.com>
References: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
	<20251118100046.2944392-6-skorodumov.dmitry@huawei.com>
	<CANn89iJvwF==Kz5GGMxdgM6E8tF8mOk0gUqSt2Lgse-Cvpo9=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2025 04:47:03 -0800 Eric Dumazet wrote:
> On Tue, Nov 18, 2025 at 2:01=E2=80=AFAM Dmitry Skorodumov
> <skorodumov.dmitry@huawei.com> wrote:
> >
> > Fixed a compilation warning:
> >
> > ipvlan_core.c:56: warning: incorrect type in argument 1
> > (different base types) expected unsigned int [usertype] a
> > got restricted __be32 const [usertype] s_addr =20
>=20
> This is not a compilation warning, but a sparse related one ?
>=20
> This patch does not belong to this series, this is a bit distracting.
>=20
> Send a standalone patch targeting net tree, with an appropriate Fixes: tag
>=20
> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")

Not sure we should be sending Linus "fixes" for false positive sparse
warnings at rc7/final..

