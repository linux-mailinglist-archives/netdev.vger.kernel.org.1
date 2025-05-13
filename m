Return-Path: <netdev+bounces-189921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99254AB483E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DD11885774
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938D13FEE;
	Tue, 13 May 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbUhmla1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FAF17BD6;
	Tue, 13 May 2025 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094824; cv=none; b=ljZJg7dN/Sc6BJ+aNlB/dFzVrBmVI7bEqE9KX1QL6zIVGQEFybheyjTgqMjRA+AWrY6jgAlbTCBzHegSgnIEXTVuV8hHHzU4Y/dAqMmjDrMDXtJbELoIf29NLza4zSAzhBB8+wh8td9HaeKNNoLSoPlWOVZtdigBt0nM38do4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094824; c=relaxed/simple;
	bh=U0boT/n71vP7m2xRZfDDdU6vloNdHhiy1bFvzu8kD1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sqjobfi3rbmAp4hkvixmTIMqNbzEF3jo7guK4h5naLOWorOACMC1gTag28HcO7m6mUuODdceT19JSDe+lGlRtCWOJu0edfKPr59HRh2HI4lMb7LR2WxmSrINfKX6j/1LDQjYC12ZiZfz3prMTKpCei2KEWj/w2X+HvVLYlmWCvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbUhmla1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22114C4CEE7;
	Tue, 13 May 2025 00:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747094823;
	bh=U0boT/n71vP7m2xRZfDDdU6vloNdHhiy1bFvzu8kD1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TbUhmla1r+1amng13YDYQxxVW4K2CPGDNbhFUmJjdDt+G2SpDaiNHscmuBZCk5Hbb
	 NGJXgG9LB01ZvnCxKVC9ZNIhBZHKli38hbKJlnQCRlcJ0Xne1gi4XVZKwijgBjEe1B
	 JnTTL6LRXB+KQv0S2a9U6GAa8/9wjbQw4m99Xf9y3hFDWkEhTVLR8vwpgFruyTxwto
	 d/s297Ye9I46pydQBPns+0ZfTDP4C1IGsKgrtCQ3tnUrQ2jx8lt9ypj60mWsUoe4pm
	 TfBQaGsuSnI2Yvbfr8FSC17x/ruwWSsAIu2kiCMoF77hBdzE82PsEZ+rcAYksd1pp5
	 opR9BGgAkOQbQ==
Date: Mon, 12 May 2025 17:07:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2] ptp: ocp: Limit SMA/signal/freq counts in show/store
 functions
Message-ID: <20250512170702.1f6d0c07@kernel.org>
In-Reply-To: <CAMuE1bHL1-t_YD0B5v1LuY_b558U5qbseSYJXvnm734+Vb-v_w@mail.gmail.com>
References: <20250508071901.135057-1-maimon.sagi@gmail.com>
	<20250509150157.6cdf620c@kernel.org>
	<CAMuE1bH-OB_gPY+fR+gVJSZG_+iPKSBQ5Bm02wevThH1VgSo3Q@mail.gmail.com>
	<CAMuE1bESfcs92z-VowaQjgWG25UK6-fTzgDqFagOyK1yifH5Lg@mail.gmail.com>
	<CAMuE1bHL1-t_YD0B5v1LuY_b558U5qbseSYJXvnm734+Vb-v_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 11 May 2025 17:39:08 +0300 Sagi Maimon wrote:
> > > > What do you mean by out-of-bounds access here. Is there any access =
with
> > > > index > 4 possible? Or just with index > 1 for Adva?
>=20
> The sysfs interface restricts indices to a maximum of 4; however,
> since an array of 4 signals/frequencies is always created and fully
> accessible via sysfs=E2=80=94regardless of the actual number initialized=
=E2=80=94this
> bug impacts any board that initializes fewer than 4
> signals/frequencies.

Right, but the bug is that user may write to registers which don't
exist? Or something will crash? We need to give backporters more info
about the impact of this bug. Can this crash the kernel?

As for sysfs exposing 4 entries, I think it's controlled by what groups
of attributes are added. So I think were possible we should create
attribute groups with only 2 entries for Adva. Eg. copy
fb_timecard_groups[] with just the correct entries, and in
ptp_ocp_fb_board_init() add an if which selects the right array.

