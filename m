Return-Path: <netdev+bounces-109516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F28928AA0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F14B216F8
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D305C15FA8F;
	Fri,  5 Jul 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wlOAycWC"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8811B14D452
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189431; cv=none; b=Tcqx1Yd3hSv3sO/ck8BAymmilRKua8L3YDZg1wZC4OcjOzm97/qQgbyrNosEDF47qSqWw7dR2yufy5oQrE7JwFte5vGFbVw5gIEhcJNr9lnd3HToO8a3+XyD2AlFRFifVgU8muW2czQfvOto00kFYofBtsIoMeSI29LCq1yMtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189431; c=relaxed/simple;
	bh=tNxakSXOmvYInSW6M5n/h/iOt6QbYAmn+CRz6NWN/PE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=swy3SKCdkpnTUBmdooVHfBPgxf3t02qdtD1n9DUi2cUM9K8gHuwZZ7SlGLcZ+bQjRjJw8zAFofjlem/vUskhQN01rKy34QLAj8WkxdeW3UnNHW3LHkFAltvfRe7iUAxBak2X3bbiTXr6CaWTtgYj1IGjBVFC3Fqvxhj4xFXXgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wlOAycWC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w3q6LtSKoTN7QRUgNP37eEVu2tmVTJhhBAr866eX+f4=;
	t=1720189429; x=1721399029; b=wlOAycWCnnIR6fVLnDSmo4Qj/oJuX2zN5Q/Mdnk+/ClsiXN
	L2Jz/wiwsDpVl0pjMSk+AlxPMp9gjubm2gcmPuArs492HrYBluYLw4P2eTaTQzqQcgxv0RlJkI6QC
	76h4XskiRaoVvDTE0gcvkBE7Gjxc7dNZKMY5wYZYzjQw5ObMb9Fk7Iuiz6aS1S/GaIfJcRqP9fdMy
	n9DpG9up4ucCuUvmYOp1AJ9tp75+RJ9Zk5NZtAVx3c9Yg6lIYniUdojeP7pMjWJDFb3FcNhEu18C4
	AzFGzMEN90ZmNYGKylBbn7iNX4Jnpa/W941iYh27UCRjBRbpZVVA551+8XXYmlGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPjqi-0000000GjlJ-2zzg;
	Fri, 05 Jul 2024 16:23:45 +0200
Message-ID: <09edde00d5d44505b7a41efdfb26cb16d0cbdc59.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 netdev@vger.kernel.org,  Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Date: Fri, 05 Jul 2024 16:23:43 +0200
In-Reply-To: <7eab05e6-4192-4888-9b6a-6427dc709623@lunn.ch>
References: 
	<20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
	 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
	 <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
	 <7eab05e6-4192-4888-9b6a-6427dc709623@lunn.ch>
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

On Fri, 2024-07-05 at 16:19 +0200, Andrew Lunn wrote:
> On Fri, Jul 05, 2024 at 02:33:31PM +0200, Johannes Berg wrote:
> > On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
> > > From: Johannes Berg <johannes@sipsolutions.net>
> > > Date: Fri,  5 Jul 2024 13:42:06 +0200
> > >=20
> > > > From: Johannes Berg <johannes.berg@intel.com>
> > > >=20
> > > > WARN_ON_ONCE("string") doesn't really do what appears to
> > > > be intended, so fix that.
> > > >=20
> > > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > >=20
> > > "Fixes:" tag?
> >=20
> > There keep being discussions around this so I have no idea what's the
> > guideline-du-jour ... It changes the code but it's not really an issue?
>=20
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

And ... by referring to that you just made a guideline(-du-jour!) that
"Fixes" tag must be accompanied by "Cc: stable@" (because Fixes
_doesn't_ imply stable backport!), and then you apply the stable rules
to that.

The time that any one of us will (have) spent even reading this thread
is clearly longer than it would've taken to add (if desired) or remove
(had I included it and not desired) the tag in the first place ...

johannes

