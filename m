Return-Path: <netdev+bounces-112249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BCE937B12
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B055C1F21A79
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E1D14601E;
	Fri, 19 Jul 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tEZ9IAWe"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BA145B1F
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406717; cv=none; b=Mz7PxD+vzwD4nfhR6Jsq5cAb+ftwk8SN0eWHJAgY0HQ4BsVfPve06LCmPtd7JCIQsoVcaYwjhaLWfa0RO6ag4pd2FUo3B0aNJ3S9Mcw7bOw8I5bRjeBbKTYoksPW6PJQeLWWCNpqEsae/n0vVGxmLYGKHjA9yqXStNW3P8VIObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406717; c=relaxed/simple;
	bh=v1mNnXDj27KqVtlI9I1CpNHzTJ8lfxuQCjaq0ALt4HE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdBy7Q9vGd13DevTYkw/NnVcOOzvjjaOXyiroTFklOwXYd6YcR1y/72iwT+pe9LE+g1RARa/YSaemddE61IKhIyHnfbJFzU5OYiDk9IEZTACyI01idSOOxUKBZOKaah0Fy7oOq5DVQiTVJkmf+qP/6D3ghJ8w3zfz5UryuTnafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tEZ9IAWe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v1mNnXDj27KqVtlI9I1CpNHzTJ8lfxuQCjaq0ALt4HE=;
	t=1721406716; x=1722616316; b=tEZ9IAWetLLeqjMriaWOwRdtAO2fDsorhTxBGRPpZ/UGXER
	zSgIggP1BSqSQnkpVdwehh7JvQSP0bkT+a/oRBWJPXjeN7/X3jaaz7uo6MuR+IVSnCgPCpyl3rUCB
	e+y326+xOVst7No8yYkQVRsHiwC8OtZKXRiHOzVJL0xW1iUIsKIFZG8pb9XfZUAgAkSMP73liDYSm
	zhpdcvUqmmUT5xV1vB+4VBTzcYFItp3RO0UEqJLoMapjZwqO+ED1zIaAkA8u6nRgT6SiqNvcty4HF
	hfTE9l/GKiQ8U//mMCg1U5f0c/Y59HfpHq413Nhk2m7qwCN1sFaNjhPhn4r/Qksw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sUqWO-000000041W3-3sW8;
	Fri, 19 Jul 2024 18:31:53 +0200
Message-ID: <af2dae8e1628b43afc898262b64c10128f7d1a7d.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/2] net: bonding: don't call ethtool methods under
 RCU
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com
Date: Fri, 19 Jul 2024 09:31:50 -0700
In-Reply-To: <Zpo27pq6lWYyVv_y@nanopsycho.orion>
References: 
	<20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
	 <20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid>
	 <Zpo27pq6lWYyVv_y@nanopsycho.orion>
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

On Fri, 2024-07-19 at 11:50 +0200, Jiri Pirko wrote:
> Thu, Jul 18, 2024 at 09:20:17PM CEST, johannes@sipsolutions.net wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > Currently, bond_miimon_inspect() is called under RCU, but it
> > calls ethtool ops. Since my earlier commit facd15dfd691
> > ("net: core: synchronize link-watch when carrier is queried")
> > this is no longer permitted in the general ethtool case, but
> > it was already not permitted for many drivers such as USB in
> > which it can sleep to do MDIO register accesses etc.
> >=20
> > Therefore, it's better to simply not do this. Change bonding
> > to acquire the RTNL for the MII monitor work directly to call
> > the bond_miimon_inspect() function and thus ethtool ops.
>=20
> Is there a good reason why to directly query device here using whatever?

See Jay's email for that, I think?

> I mean, why netif_oper_up() would not return the correct bool here?
> Introduction of periodic rtnl locking for no good reason is not probably
> something we should do :/
>=20

Yeah, fair.

johannes

