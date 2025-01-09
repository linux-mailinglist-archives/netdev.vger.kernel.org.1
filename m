Return-Path: <netdev+bounces-156787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E9A07D4F
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7231884927
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0453F2206BE;
	Thu,  9 Jan 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaD9up5G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43712206BC
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439492; cv=none; b=RSnszjdAA6fbS0Y3e5zNbcpFhalEUD1vzQ5itQ63QfnvWfPh8KB8a93Susb+BKGL6KsC/Ek9HEQlaWz3l2Ma+KbASsJzSM8vC2btsEphNq9LUJDjvUnjcOFa27m/mDlhdLF2q2XVMb1+HO7K1pEU6qc8egIHNCsEQWPT7OItrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439492; c=relaxed/simple;
	bh=10+Dg1BFv4IwT+mfDUUg++YF0ACEY5Xdn5RCQC9n7x0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+o3RzfHpf4/Swn5QgoSAcbQ27VmYvF17meTAAoE/Ky6a1RXaO5NLJT9LQuV8a9lalzuuL1rp9VrroECZIX/8JS+mLySMvnn3uotz+E2pes+3q4O8GUMx8hMvhr8EyHQj9cOTMVuFzFAafZ30WhpX+H6XKx77nAwOeHPSEEZpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaD9up5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46624C4CED2;
	Thu,  9 Jan 2025 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439492;
	bh=10+Dg1BFv4IwT+mfDUUg++YF0ACEY5Xdn5RCQC9n7x0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VaD9up5GXA9v64/lMaOzJOYE+w682V2ZN2vhCVKLEFMj1e52pi2ajwdscruac9aHJ
	 /Lq1J97TCBId3IHrg6edXUay0E99IqfaqYRMUscyTUgBiS84Qp6YvMXCRtv6A6ftTz
	 SwIeUuZlzrVHZnI46XXysBWetiK+lumkfl3OAFjvLpYyo9MKkpcv0UHxaU2AMgrjJD
	 AtNZAonmkAwWVQHcyevyJujOXojhCLjX/ih0EEtEgOiVMopo3DXj+b2dI9Qk3zgMft
	 Dg9lpONgtxabJWkFdebvAxsFzaLgGiE5uDTzSpavPVgUYpZ1CM0uGqjbm3SB9Hb/ht
	 16S0GXizoZv6w==
Date: Thu, 9 Jan 2025 08:18:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>
Cc: Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] sched: sch_cake: add bounds checks to host bulk
 flow fairness counts
Message-ID: <20250109081811.01b7bad1@kernel.org>
In-Reply-To: <87ikqohswh.fsf@toke.dk>
References: <20250107120105.70685-1-toke@redhat.com>
	<fb7a1324-41c6-4e10-a6a3-f16d96f44f65@redhat.com>
	<87plkwi27e.fsf@toke.dk>
	<11915c70-ec5e-4d94-b890-f07f41094e2c@redhat.com>
	<87ikqohswh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 09 Jan 2025 17:08:14 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> I guess I should have mentioned in the commit message that this was
> >> deliberate. Since it seems you'll be editing that anyway (cf the above=
),
> >> how about adding a paragraph like:
> >>=20
> >>  As part of this change, the flow quantum calculation is consolidated
> >>  into a helper function, which means that the dithering applied to the
> >>  host load scaling is now applied both in the DRR rotation and when a
> >>  sparse flow's quantum is first initiated. The only user-visible effect
> >>  of this is that the maximum packet size that can be sent while a flow
> >>  stays sparse will now vary with +/- one byte in some cases. This shou=
ld
> >>  not make a noticeable difference in practice, and thus it's not worth
> >>  complicating the code to preserve the old behaviour. =20
> >
> > It's in Jakub's hands now, possibly he could prefer a repost to reduce
> > the maintainer's overhead. =20
>=20
> Alright, sure, I'll respin :)

Hold on, I'll do it :)

