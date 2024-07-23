Return-Path: <netdev+bounces-112578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B26939FF7
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648011F23171
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E235314EC43;
	Tue, 23 Jul 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="luH2V+9v"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5514F111
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734267; cv=none; b=TQN35s5Rzphkw+we3gEiAJegWdgw1U9w20ZXy0/XQtA9yomvi3oRskq1cPSDYfI1X134hn12v3xR6Q5K0GEgkN1TzTqO6VrWhaz51puZ/E4Dbyelc+/ssLg/XZ1rmvurV4plRGJOHRTEOeb1BDDngdw2k4EsxY2cA8ITeGRHF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734267; c=relaxed/simple;
	bh=9W7N+RcPU+hcfWOtUThl48kqfYHUL1J2IWDqtRfdIMk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XgMyt0v0Zh7qr1AcDr6okSbz5kFlpyHdXTjTDTTqKm6Csf41TuBREAZKIwC25G8tEnKjRbrz/jPZjG9192mKsIh2c5rIH7GHgTSgduxh3+E6s9bwanLr+Qp9thNtCLAPPZqutPceeaUbe+MEPUHmEK+L8dUq7Crs3S5j925AVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=luH2V+9v; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9W7N+RcPU+hcfWOtUThl48kqfYHUL1J2IWDqtRfdIMk=;
	t=1721734263; x=1722943863; b=luH2V+9veRbeMoxqK0EwDkm0rDDheugh1/t6ip1ZcrZee6l
	wWymDLUw/ZLFKhr/Co4/jySyWSLlOgf0phcyRFSZQD+17PgyqiXAmmuwbTSQLAFIoQCU/365QJYEs
	peAIJ1859nNSspfLgnzoS7vbTWzQsA5bqcbTyOIuM8oP4Fc/mYjnbA7czNDzxV5dsxrWvGMh2y4uY
	dl+vz54ZhmmHoa8m6wti31hHLGsw6Pq443eDlhWJ1aVgzzrXmT/G3XIwtrVZU49XAcktwTQdJo0/Y
	Jq0JPpH1/dHyama0+7W+3iC3kKOzT985MazHm+iaBhrhkjYh5lwIngr4SIduJt5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sWDjJ-0000000BBGi-43xX;
	Tue, 23 Jul 2024 13:30:54 +0200
Message-ID: <310c8cfd1dc1747cf8ffc1f5be8994d0c87a008d.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: bonding: correctly annotate RCU in
 bond_should_notify_peers()
From: Johannes Berg <johannes@sipsolutions.net>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>,  Jiri Pirko <jiri@nvidia.com>
Date: Tue, 23 Jul 2024 13:30:53 +0200
In-Reply-To: <0b0cb62e-4e10-458e-8d21-8a082f94aa4d@redhat.com>
References: 
	<20240719094119.35c62455087d.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
	 <0b0cb62e-4e10-458e-8d21-8a082f94aa4d@redhat.com>
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

On Tue, 2024-07-23 at 12:25 +0200, Paolo Abeni wrote:
>=20
> On 7/19/24 18:41, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > RCU use in bond_should_notify_peers() looks wrong, since it does
> > rcu_dereference(), leaves the critical section, and uses the
> > pointer after that.
> >=20
> > Luckily, it's called either inside a nested RCU critical section
> > or with the RTNL held.
> >=20
> > Annotate it with rcu_dereference_rtnl() instead, and remove the
> > inner RCU critical section.
> >=20
> > Fixes: 4cb4f97b7e36 ("bonding: rebuild the lock use for bond_mii_monito=
r()")
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> Any special reasons to target net-next? this looks like a legit net fix=
=20
> to me. If you want to target net, no need to re-post, otherwise it will=
=20
> have to wait the merge window end.

Well, I guess it's kind of a fix, but functionally all it really does is
remove the RCU critical section which isn't necessary because either we
hold the lock or there's already one around it. So locally the function
_looks_ wrong (using the pointer outside the section it uses to deref
it), but because of other reasons in how the function is used, it's not
really wrong.

I'd really prefer not to have to resend it though ;-)

johannes

