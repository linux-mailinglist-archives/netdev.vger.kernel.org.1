Return-Path: <netdev+bounces-115169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274C8945545
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03FE1F2386A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8405672;
	Fri,  2 Aug 2024 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Vc0IDUR1"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C926AB8;
	Fri,  2 Aug 2024 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558117; cv=none; b=RDrJn+xiQfUcHF+dRAWe42Kt/5pregkfGz13Wzq2a5lPUlsFDSkyxyJqTYWC9Mvm3UjbJd9R5Zjz4B0qrUhDDEljGqGkDv30MdgYTLqsctEBvpARnYgcVWE+aQewtAFzyciK2wZBJFi5T0Lt++pl/82pwEbSYCqVPKDS8+o2izA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558117; c=relaxed/simple;
	bh=ghv9OtTv9SJqdWKFw3ZACL/St9pTAizFrhYcNywrhk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEAuhvEPHib+Bc4A48EHG2+G9ZI4HN3XOVz6QGW4I2Q0cBngG/k+/em6QjHogQzpuVk6bpumV2guIFaf6kphRb0al96v/Xs5KeRqGta1etVfy4sFcmSY8JTRNKnN9/MxusesegmuJ2s13mz+HmrOuGdI5BeuI0oEfDdzsbFA0p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Vc0IDUR1; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722558107;
	bh=ghv9OtTv9SJqdWKFw3ZACL/St9pTAizFrhYcNywrhk4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vc0IDUR1WbhlOK+xhX/4k8svb2qgx/Fss3PgEJ4UfVRfCsrGYExqRzVSrmfTql/dJ
	 nNToSS3DbzrjOfGbEZc1QW0HSbJ5k1wXdTl3nXf3md6EwL6frI865iIighH0Sx8DKn
	 pMLNlG/PqgJcBxlSYsnueZBOOwDwHMTQP4pf6bEFqy5f52941/fnIacPZ7AkAuqCvh
	 qpNv595qmcZh4BPrJ4WgC9SWLrb5xKd9Y5uNeX3wZslv3+nqvyhraws7cDmcc9MNK7
	 EawbNJQDr5khVkKQGKL+pmrKfr5iO9+Ph16YyI3NgZhYlqyA6z7AIYdbAW0UV0s3Xs
	 6Z0Ns4zxKTsNg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 39C2364B84;
	Fri,  2 Aug 2024 08:21:47 +0800 (AWST)
Message-ID: <2fde081adb2352e613ae33536363f284f1b46f32.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2] net: mctp: Consistent peer address handling
 in ioctl tag allocation
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>, Matt Johnston
 <matt@codeconstruct.com.au>
Cc: John Wang <wangzq.jn@gmail.com>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 02 Aug 2024 08:21:46 +0800
In-Reply-To: <20240801085744.1713e8b5@kernel.org>
References: <20240730084636.184140-1-wangzhiqiang02@ieisystem.com>
	 <20240801085744.1713e8b5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub and John,

> On Tue, 30 Jul 2024 16:46:35 +0800 John Wang wrote:
> > When executing ioctl to allocate tags, if the peer address is 0,
> > mctp_alloc_local_tag now replaces it with 0xff. However, during tag
> > dropping, this replacement is not performed, potentially causing
> > the key
> > not to be dropped as expected.
> >=20
> > Signed-off-by: John Wang <wangzhiqiang02@ieisystem.com>
>=20
> Looks sane. Jeremy? Matt?

All looks good to me!

Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

(John had already discussed the change with us, so no surprises on my
side)

> In netdev we try to review patches within 24-48 hours.
> You have willingly boarded this crazy train.. :)

Yeah we bought express tickets to netdev town! I just saw that there
were nipa warnings on patchwork, so was waiting on a v3. If it's okay
as-is, I'm happy for a merge.

Cheers,


Jeremy


