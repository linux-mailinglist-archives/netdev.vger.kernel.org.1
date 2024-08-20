Return-Path: <netdev+bounces-119969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B26957B13
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779CEB20C20
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53EE18EA8;
	Tue, 20 Aug 2024 01:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3QATPaJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81722EF0
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 01:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118102; cv=none; b=u1kXQAujhwGAOUEkb8j2z19x2iZbZiN2tZMymmNT2OdnHoZnng7vNVKI/sEYA28KtE9Kyp4gbWEW+ILcL9bwch3diKhddRRAdlIaaQ9viEZY1XEXdX8uV1qHpGRvUbejBrYAaZfe1oemocqGi/OE0uggZPu/lWCowpdaQxyTLyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118102; c=relaxed/simple;
	bh=fPyHmOXS6j4SZyv1Cm3gt7sywNnmTmfCpgsedRGoMQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+Uxt8g9bTpll7nFU1qa3Ht8k8zRL32KeytOcmwL+/YdbHyYz2A3ZyNtGuWdaU56l5OWKTswSxDchu19WP7VGpIjJbGcUJ6+WY7vlQggUw5M1RjccMNPlSRaLHxetk7npI3kkv+47I/0M6Ri+6ipLo6dHxdWii1QwF/CTAfURRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3QATPaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9470DC32782;
	Tue, 20 Aug 2024 01:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724118102;
	bh=fPyHmOXS6j4SZyv1Cm3gt7sywNnmTmfCpgsedRGoMQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L3QATPaJnDZJ+YphPXXg+WtsszG/dvajB7rq4qE0CrUU8ySJTKvco6bfbxKaLqmSE
	 tg53xwrrIzeiL5oNgrThZtdUvyXo06+61ICR9HUQRV87GOgazMkKuau4TRVkacnoC5
	 wy43AQgMY+XpfYInvDMCJnraze3DBgxJo5XO9f+Tepwger9HzNke/Tql3a4jeW5al5
	 5yM8hHLOYFKUPultuJbLiYf54W5hRjPdeCat/yc4YDZWY/RACGTixr0EhQYYg+l22x
	 6I7drSLxDXIXoKkM8B84459kKjEptYV2mlCix4Y4WtE3bD3j5xPlPFwkPcA2BiafIl
	 vfM8+Aj+ztMig==
Date: Mon, 19 Aug 2024 18:41:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michael Chan <michael.chan@broadcom.com>, <netdev@vger.kernel.org>,
 <edumazet@google.com>, <pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
 <andrew.gospodarek@broadcom.com>, <horms@kernel.org>, <helgaas@kernel.org>,
 Vikas Gupta <vikas.gupta@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 2/9] bnxt_en: add support for retrieving
 crash dump using ethtool
Message-ID: <20240819184140.1d38b98a@kernel.org>
In-Reply-To: <895f8e49-2bbd-4211-b1a5-6708956a580a@intel.com>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
	<20240816212832.185379-3-michael.chan@broadcom.com>
	<895f8e49-2bbd-4211-b1a5-6708956a580a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Aug 2024 12:12:39 +0200 Przemek Kitszel wrote:
> > +	if (dump_type =3D=3D BNXT_DUMP_CRASH &&
> > +	    bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR && =20
>=20
> I would wrap bitwise-and with parenthesis, even if not mandated by the C
> standard (the same in other places with combined expressions).

Personal preference, I guess. I generally lean on the side of limiting
the brackets.

=F0=9F=91=8D=EF=B8=8F to other comments, thank for reviewing!

