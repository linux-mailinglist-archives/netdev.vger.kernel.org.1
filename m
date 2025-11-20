Return-Path: <netdev+bounces-240384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 164EEC74157
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 098964E262C
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4FD3112BD;
	Thu, 20 Nov 2025 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfTBCuTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499C372AD0
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643992; cv=none; b=A/bWjtDhWdwfh5jVS4Exd3NMO2ubNyqOtfSbTueRMhuhyydzbQ8qVg2OXjINK9hxtB9eJEeTVC2f1iHAUTn3niQ21kN+KaZZ8PzW/wdvLrameTQAAo6VVLWUO8Y2jWotdgMbcUmXryOAortvoeV5Sqfq7xmWMQaCYGO7VzD72BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643992; c=relaxed/simple;
	bh=FS5ec4De3BI94cwKE61yozPnuKJGc4rrYteEKvL6Zbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPhy+hHbMTT/XZbwzkrn9ooGz7geHRXm2MqdDP5Bu0aPNGRo5O2t9uXJNAvweIr2OixozAHtKAM3k6zBHtikzSjPBFcuB1UqjHtfDkf4Wy8tqVT6jX4WHPVS20ZoCKXAqgKhLyQe2QYQIisXqQKvFKQvOgKsz0yf48szJLWQH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfTBCuTL; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78a6a7654a4so8487757b3.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 05:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763643990; x=1764248790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS5ec4De3BI94cwKE61yozPnuKJGc4rrYteEKvL6Zbc=;
        b=gfTBCuTLfcFQ0aN4hQ0DuNWhDhQgb1rrAhqx/Qx5fgJEMvXQlYySreXpjiwx+CRgP2
         NIjTa6zFTKnvrCurE6iRqU0lbO4h5tXoMchhP02azY7+nhr6m6CJJwjcZwoaudg1Wpfx
         vhW0RLKv+Fd6c7nYVMo2ZHmj+iUl41qLLZKscgpXaGw1kNqeNgQx24yellGvQk8zcnxJ
         0zpnuNDMOFmA/1WxkdGTmh8xPDSCCGbkcvE8KrxXHdFfeLeMAkPeoRkZlu3kZv3V5amy
         Y7e1BA0JnXmY8Cv4OuBoAERfMseLzBZhLkKOPH+HtHGoNafGODDq+Mq9aUYXrGzl3lv9
         4AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763643990; x=1764248790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FS5ec4De3BI94cwKE61yozPnuKJGc4rrYteEKvL6Zbc=;
        b=E6Csqp2gmkEquOBiFbUUTKUhEUvl3M/8/tiqc4O6IHhrasqG/hTGJkPjZdYcHFI3Xb
         cAPNT2kun/QDPu51z5FO8HVkGikwyCunxpOAwpWrteFxqD/RiY8+woAVEClGPDbC89tr
         msux5WkRs3gvI+NTTPTEPSUHxtdlqJz3wUQCYC/MAW/sJJ/F8S/jULuHgVNw8Tr0ud4q
         KBSGO1LOYAhf1nA5Amg4bQ8wegNcf5oMGHBnLUcZdM2EBheKBWqtCDNtY6tNfPA1kZtT
         w7OYWXjnyG/05TJyRt9O7UTL5eWF3OXbFhKfkoHrNwbYZ4KYTMHDbxZaugn7pHn7VM5k
         z3CQ==
X-Gm-Message-State: AOJu0Yxu5LewB3gdD8eMJv6Z+F1/BssdiTvjZc7sg6vSDjuWH466tVaO
	aPDx8RDp0AElyNidVnCx7j49dlycj6NFaj3rJoqITZoamsAAykJOebUFh6TA+8Rbt+qB+Ze1q9E
	x2rsPoGdA83BLkOdFnOqmsC+l+qOvT9w=
X-Gm-Gg: ASbGnctRcCK8JdIDvEdsJA9VkB0fHLPZyY4fEGUZQ8KjA2oqIsBtm9Vilkzz44kJoiY
	c9lfXB18U6sJCxC7/cWalVxMpKbBUedf77x2ldIVnLwF/V+icVlnHGc93uITRJHr824JJ3/xIol
	RSdvPTojYNqpWtwjpTj/tPOVqCzmL6brxwdBJaQ2rwZE5aATBzfNL8rmglHbnhmAHXrPvz4dEU1
	kr+U1tn2iCWkoDnl1yHpF1pmmNfmrHtK5wEEIb4CX+FHvcVKg0DIe1xivZ9RrDBi2T/mOsUESLb
	lXngEi/wDi/Pbu46vg==
X-Google-Smtp-Source: AGHT+IEif0p++PmfeIu5OoaBWPu1Q2Fi2pBdNGn2rkg+IUV6D+xB/PWEJqujjVGhnWKWgjp2SK3sdy7QM30pAHPEO4I=
X-Received: by 2002:a05:690c:4491:b0:786:9774:a39f with SMTP id
 00721157ae682-78a7ab10a7emr21278907b3.5.1763643989858; Thu, 20 Nov 2025
 05:06:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118070402.56150-1-jiefeng.z.zhang@gmail.com>
 <20251118122430.65cc5738@kernel.org> <CADEc0q4sEACJY03CYxOWPPvPrB=n7==2KqHz57AY+CR6gSJjAw@mail.gmail.com>
 <20251119190333.398954bf@kernel.org>
In-Reply-To: <20251119190333.398954bf@kernel.org>
From: Jiefeng <jiefeng.z.zhang@gmail.com>
Date: Thu, 20 Nov 2025 21:06:18 +0800
X-Gm-Features: AWmQ_bmzDblqmO2UA6Y0rlESFFsLqqzu3Gb8wITmlmuU4UyixLGVGyDVEx9_HUo
Message-ID: <CADEc0q5unWeMYznB_gJEUSRTy1HyCZO_8aNHhVpKPy9k0-j8Qg@mail.gmail.com>
Subject: Re: [PATCH net] net: atlantic: fix fragment overflow handling in RX path
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org, 
	irusskikh@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 11:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 19 Nov 2025 16:38:13 +0800 Jiefeng wrote:
> > And I have encountered this crash in production with an
> > Aquantia(AQtion AQC113) 10G NIC[Antigua 10G]:
>
> Ah you're actually seeing a crash! Thanks a lot for the additional info,
> I thought this is something you found with static code analysis!
> Please include the stack trace and more info in the commit message,
> makes it easier for others encountering the crash to compare.
> (Drop the timestamps from the crash lines, tho, it's not important)
>

Thank you for the feedback! I've updated the patch to v2 based on your
suggestion to skip extracting the zeroth fragment when frag_cnt =3D=3D
MAX_SKB_FRAGS.
This approach is simpler and aligns with your comment that extracting the
zeroth fragment is just a performance optimization, not necessary for
correctness.

I've also included the stack trace from production (without timestamps) in
the commit message:

The fix adds a check to skip extracting the zeroth fragment when
frag_cnt =3D=3D MAX_SKB_FRAGS, preventing the fragment overflow.

Please review the v2 patch.

