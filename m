Return-Path: <netdev+bounces-101899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F309007F6
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A1128D8C7
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF903199E9E;
	Fri,  7 Jun 2024 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="F2b484tB"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF5198E7F
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772217; cv=none; b=FrRppljPOkjRqKMPGu1Y9s8tYbdGmzNf4R2kTBsyzDEV5qnQEzGQ7M5hg7eKpT0UO0DNHLxv2EmSbZz1CH9opYUahMYKg7tTqH2HwOcCxFeSkdIVclF+YYEJaKhzaxzDJI+mGCRRaF+cpgEI0XMvzbK57mXE7L0BClWi2V0SWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772217; c=relaxed/simple;
	bh=QWGp2GlpxTkLdWjX9UIVvLrfgJ2Ztrfqrl1xLCynUVI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjOMsIxOvFzU2bFU84DBMN+I0ApqQjEbIaC6qTs2fOTvXDaO0ffchWAvo9VCI394Lf4+FX/R3vdY2SUawYG06lKMGBo9W0zf2+SyjGr1FlNpu6c4tANDDcLjeYMo9VZ9YTGjedeK2Rfy6wVSG/J2PGm/xKbO67KkUC+Qt6ZdCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=F2b484tB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QWGp2GlpxTkLdWjX9UIVvLrfgJ2Ztrfqrl1xLCynUVI=;
	t=1717772216; x=1718981816; b=F2b484tBoYZaf2qT5AcgcJNtqWlaU0vsgxA+ZPpbhYaOw/v
	2w5G5cpBhCGRNE1LjfXEDY3PVl+iMLYUS4LAVHw19RhTrjJP8UgiBMI6ztt8ijACUXjpXAXr6RSSA
	i9JY9yyxN6ZUiybrZ/6NVrGmeV5tP9qNUMkoEQrkRbTGvzCnVkWK/uo79OVS/7MqvzkxaWMmbvKLL
	yK0McoeLvUZK2C85Q+dN0nkSHFSx2v8fLwlTjrDMFXtJjYvFC1GZ9W/EBXmZCzseM26s8OAh9GbM3
	4WE4Yol699Pou0Ss0qEWM3XDAWRxL2NyKk9eo0t9t1hCKDTnKXcIcZAh+k8MI46w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFb1N-00000001EZS-3uwd;
	Fri, 07 Jun 2024 16:56:50 +0200
Message-ID: <18ecd075c0c0d32a2b854b470155880d58bef082.camel@sipsolutions.net>
Subject: Re: [PATCH net] net/sched: Fix mirred deadlock on device recursion
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Dumazet <edumazet@google.com>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 xiyou.wangcong@gmail.com,  netdev@vger.kernel.org, renmingshuai@huawei.com,
 pctammela@mojatatu.com
Date: Fri, 07 Jun 2024 16:56:49 +0200
In-Reply-To: <CANn89iLyXx8iRScGr5zzBVJ+-BnN==3JJ7DivQE_VUpaQVO4iQ@mail.gmail.com>
References: <20240415210728.36949-1-victor@mojatatu.com>
	 <127148e766b177a470a397d9c1615fae19934141.camel@sipsolutions.net>
	 <CANn89iLyXx8iRScGr5zzBVJ+-BnN==3JJ7DivQE_VUpaQVO4iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-06-07 at 16:54 +0200, Eric Dumazet wrote:
> >=20
> > I'm not sure I understand the busylock logic well enough

> Why not simply initialize noop_qdisc.owner to -1 ?

I didn't understand the locking logic, so I was worried you could still
have it be used in parallel since it can be assigned to any number of
devices.

johannes

