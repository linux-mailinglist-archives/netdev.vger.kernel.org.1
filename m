Return-Path: <netdev+bounces-112740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D5493AF1D
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 11:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C481F22D37
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2167914A4EF;
	Wed, 24 Jul 2024 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nUH8EKO5"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4113DDC2;
	Wed, 24 Jul 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813762; cv=none; b=uAhR+/9+k7JQNPZi+q9uItNF8dFGwA1W3ZoyocmLKU5cCrnZP/jsbDc1WQjKPa0p4A+3ftTRmXh0KfPfGBtHky0dV0YFw1Pwagb0cKZdbcozHGTlIeBFoeIkejob8ZLhjMHCWuiHw7AJmxcj1AM3xf0E/Z4RpVmGawyLrz7F+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813762; c=relaxed/simple;
	bh=b33Tv6aUwH6360/yXHULuLmoETHrVC9pf6bWNY3pl1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vBATefQv+iOqbV9ghVf67Ufon9+IWR1HgxL+tbZhpFjiuC7rN62o08uI6VDI62nlvuOMaFp3dOfy7UD6bUYfv/wboMVzdbimtt2oKWqsXJTIiFuHlVRMK6sc3q14I5gF94zC2EFCH0+eySCXqdLDkg4H4tIhrfCYcBLNH2hWVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nUH8EKO5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=b33Tv6aUwH6360/yXHULuLmoETHrVC9pf6bWNY3pl1s=;
	t=1721813760; x=1723023360; b=nUH8EKO5c4g2WG3iiCX+9niss4nxEjQDmjm54rckJpLLG/J
	iuSOh2YLZtb8l3CZhT3m0IsLzy8OpFRbxZ5P/BdbtN3bEaBD25N19KSYNBtcthjRz7reZdIKhZpaU
	o+z/N0YlkMGRpv3zNEvs4j/WOaXUz5EEpG94ryt5hRVBD6/GZ1G0zR3eV+99KrnvoCSDhP7xGBHYa
	CuNwGFN67y8Qjxke+0HQn7cKKyNwZm1iHkm8uFQG/mdidlNfxTpedp+JfdjG6P1hX4g31GpSfRYNx
	AhlmYpeKdwmnRIUaJ3CWlw0sTy0sago4qB/pd8yCVWnoMg2+np6cCvVikqHpk4aQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sWYPZ-0000000DNS1-1Dw3;
	Wed, 24 Jul 2024 11:35:53 +0200
Message-ID: <c20dcbc18af57f235974c9e5503491ea07a3ce99.camel@sipsolutions.net>
Subject: Re: [PATCH net 1/4] net-sysfs: check device is present when showing
 carrier
From: Johannes Berg <johannes@sipsolutions.net>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Wed, 24 Jul 2024 11:35:52 +0200
In-Reply-To: <066463d84fa14d5f61247b95340fca12d4d3bf34.1721784184.git.jamie.bainbridge@gmail.com>
References: <cover.1721784184.git.jamie.bainbridge@gmail.com>
	 <066463d84fa14d5f61247b95340fca12d4d3bf34.1721784184.git.jamie.bainbridge@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-07-24 at 01:46 +0000, Jamie Bainbridge wrote:
> A sysfs reader can race with a device reset or removal.

Kind of, yes, but please check what the race actually is.

> This was fixed for speed_show with commit 4224cfd7fb65 ("net-sysfs: add
> check for netdevice being present to speed_show") so add the same check
> to carrier_show.

You didn't say why it's needed here, so ... why is it?

FWIW, I don't think it actually _is_ needed, since the netdev struct
itself is still around, linkwatch_sync_dev() will not do anything that's
not still needed anyway (the removal from list must clearly either still
happen or nothing happens in the function). This will not call into the
driver (which would be the problematic part).

So while I don't think this is _wrong_ per se, I also don't think it's
necessary, nor are you demonstrating that it is.

And for userspace it should be pretty much immaterial whether it gets a
real value or -EINVAL in the race, or -ENOENT because the file
disappeared anyway?

johannes

