Return-Path: <netdev+bounces-107052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA6E91985B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44ECD284B13
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11EB1922E1;
	Wed, 26 Jun 2024 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH+ZJd8w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8C33C5
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430983; cv=none; b=cyG622iJTlJfO3axLYvBg//e/+OqzDy4UmDS1Fo8zvg44Jh82pzx5W1CCvTJGjbTWTF0yvHuBAlfhOh9dQaAbU7/N/l/kY5mcpWaos29mwmETjj3CbVPnJ3WJxSSZ6+HOaiSs+yxfGI3FF4WGWKXzz4VSkrC/4unfOpznpE9BUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430983; c=relaxed/simple;
	bh=P/nl1ipyrOE5lH7R9h9GlnF1puud6X3wdyGqW2EOewg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEJvO22NfH6WZZvGkyViHUdQzdcX0nGsJjhmefncoAsqM+gWUTD4y+ViBcp2O0O9RRM2x2FfLNIghQzMZG5ujv54Is8CwF3y3d4gpkp1lOKQ2Ik5sDqB6iShVFUg3dsdtuqLSMzz7/dDwRDyAKOvH6wE2/HnVldkbqOIRUbj5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH+ZJd8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB36C116B1;
	Wed, 26 Jun 2024 19:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719430983;
	bh=P/nl1ipyrOE5lH7R9h9GlnF1puud6X3wdyGqW2EOewg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZH+ZJd8wQB++hXvGdO0w6CYIG0rGIjDr8iCS+6p8F1+nJz9Mg1Ykb8g0GEYvwz+r1
	 nwNyHL4twDmz7Ar4z6WjBkWkHOghTzXevefyNypzJOGFOcJ1WXSwmqWCDcSdEk3T7b
	 +88xo2frLrTAGSniK0VHG31wiUAc20haYprrkfWG1f9SGusrehTtx251SKsG2/ygNN
	 ejI7nyt/7U5c9+G4L2vacSkHjkxuYULX5VKuhWvnCTRf8SlmcR59KobbIthQxTbo+A
	 YWKn3B60/RXPyngJHJPwGNSS6Y0TfI8RboC4d33DbM454Yba0yfADaZiTUGykyLT25
	 0V9JVjURkc9fA==
Date: Wed, 26 Jun 2024 12:43:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "davem@davemloft.net"
 <davem@davemloft.net>, Shai Malin <smalin@nvidia.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>, Yoray Zack
 <yorayz@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Gal Shalom
 <galshalom@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Aurelien Aptel <aaptel@nvidia.com>
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240626124301.38bfa047@kernel.org>
In-Reply-To: <d23e80c9-1109-4c1a-b013-552986892d40@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
	<20240530183906.4534c029@kernel.org>
	<9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
	<SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
	<253v81vpw4t.fsf@nvidia.com>
	<20240626085017.553f793f@kernel.org>
	<d23e80c9-1109-4c1a-b013-552986892d40@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jun 2024 19:34:50 +0000 Chaitanya Kulkarni wrote:
> > I'm not sure we're on the same page. The ask is to run the tests on
> > the netdev testing branch, at 12h cadence, and generate a simple JSON
> > file with results we can ingest into our reporting. Extra points to
> > reporting it to KCIDB. You mention "framework that is focused on
> > netdev", IDK what you mean. =20
>=20
> just to clarify are you saying that you are want us to :-
>=20
> 1. Pull the latest changes from netdev current development branch
>  =C2=A0=C2=A0 every 12 hours.

Small but important difference - testing branch, not development branch.
There may be malicious code in that branch, since its not fully
reviewed.

> 2. Run blktests on the HEAD of that branch.

Or some subset of blktest, if the whole run takes too long.

> 3. Gather those results into JASON file.
> 4. Post it publicly accessible to you.

Yes.

> I didn't understand the "ingest into our reporting part", can you
> please clarify ?

You just need to publish the JSON files with results, periodically
(publish =3D expose somewhere we can fetch from over HTTP).
The ingestion part is on our end.

