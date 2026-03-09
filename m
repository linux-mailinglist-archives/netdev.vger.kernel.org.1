Return-Path: <netdev+bounces-265783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLVICXFOr2noTgIAu9opvQ
	(envelope-from <netdev+bounces-265783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 23:49:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8DC2425D1
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 23:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A20063006F33
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 22:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB134F479;
	Mon,  9 Mar 2026 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7DyK7VM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB995246766;
	Mon,  9 Mar 2026 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096559; cv=none; b=EgTMt/pKSvfmQns408FdtT5caiu/k9x4lWz8Mct4oD5Ne3gVipQa0nNNOKv32rfJCjcXISaJx37cGRzTrhnk+9WVtcBxDCilcrAL9gtdu323GDp7XA9TWDS+KM78uz9LBKWHFgulYSIWl+puyaUmdoqjOGyJGSZKac81BJ++2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096559; c=relaxed/simple;
	bh=C7JCDAPGl9ETtf4IVv0zfsB8t20cm/jyipVBZRK/JvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qi77W6kqftQWRor5jxVfxlmgJU6MZKKVA6QTBKrpyxWx8q/nl3FWb4P9DdAFdw6FEvLVipm2+NYaql9hcczYqIkfSaYvzQTGfBoeeTFRrbcuiUul0eoo2OWvFJaquGw1e/b0WY1eXX81oMpQjUqoV3rIegzcriRhfj+bXqSTlpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7DyK7VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43702C4CEF7;
	Mon,  9 Mar 2026 22:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773096558;
	bh=C7JCDAPGl9ETtf4IVv0zfsB8t20cm/jyipVBZRK/JvM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=n7DyK7VMoJGZkj6EWg5OO7nAcSF7fhiHBuWAyRKT2boiUJhsQbTQkMXF3F0hFALRq
	 Mk8itPyysEzfzFOnyAtiIJRsabj5Gwv+w/MkMUF+p/XZi4bkE+1TisaQAwh5KFn3u/
	 qjTWRoAtyj594XFp+i9T2eBuzw8FUFssxNSHDTqsB3JxOTsOXlQgnAVqu2QCwtheVU
	 sphSdrp5iBL1TYwpY9WwJm38uGQO6J/MKeTschzY6GGP1rVwUZOOLGwylbKllJP752
	 TWNfv+pjHzANbbaCv7uF4H8Mu/h9BAWQ2dk5xXbVNZeeT7y1mUTqZ1wTNeXxI2kRtl
	 WmlwHfeUpS6QA==
Message-ID: <ac50b18c99f5863f456d2d486454df8eebe35719.camel@kernel.org>
Subject: Re: [PATCH v23 08/22] cxl/hdm: Add support for getting region from
 committed decoder
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>, "Cheatham, Benjamin"
	 <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, 	edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, 	edumazet@google.com,
 dave.jiang@intel.com
Date: Mon, 09 Mar 2026 15:49:17 -0700
In-Reply-To: <28148dcf-3cdc-439b-900a-a3f672a28ad1@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
	 <20260201155438.2664640-9-alejandro.lucero-palau@amd.com>
	 <03ab7820-a6e0-4655-bae7-61d2d0b7dfd6@amd.com>
	 <28148dcf-3cdc-439b-900a-a3f672a28ad1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: AB8DC2425D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265783-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ppwaskie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

On Thu, 2026-02-12 at 09:16 +0000, Alejandro Lucero Palau wrote:
>=20
> On 2/11/26 22:11, Cheatham, Benjamin wrote:
> > On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com=C2=A0wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > >=20
> > > A Type2 device configured by the BIOS can already have its HDM
> > > committed. Add a cxl_get_committed_decoder() function for cheking
> > > so after memdev creation. A CXL region should have been created
> > > during memdev initialization, therefore a Type2 driver can ask
> > > for
> > > such a region for working with the HPA. If the HDM is not
> > > committed,
> > > a Type2 driver will create the region after obtaining proper HPA
> > > and DPA space.
> > >=20
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > ---
> > > =C2=A0 drivers/cxl/core/hdm.c | 39
> > > +++++++++++++++++++++++++++++++++++++++
> > > =C2=A0 include/cxl/cxl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> > > =C2=A0 2 files changed, 42 insertions(+)
> > >=20
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 6e516c69b2d2..a172ce4e9b19 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct
> > > cxl_endpoint_decoder *cxled, u64 size)
> > > =C2=A0=C2=A0	return devm_add_action_or_reset(&port->dev,
> > > cxl_dpa_release, cxled);
> > > =C2=A0 }
> > > =C2=A0=20
> > > +static int find_committed_endpoint_decoder(struct device *dev,
> > > const void *data)
> > > +{
> > > +	struct cxl_endpoint_decoder *cxled;
> > > +	struct cxl_port *port;
> > > +
> > > +	if (!is_endpoint_decoder(dev))
> > > +		return 0;
> > > +
> > > +	cxled =3D to_cxl_endpoint_decoder(dev);
> > > +	port =3D cxled_to_port(cxled);
> > > +
> > > +	return cxled->cxld.id =3D=3D port->hdm_end;
> > Is this the way you're supposed to check if a decoder is committed?
> > The doc comment for @hdm_end in
> > struct cxl_port says it's just the last allocated decoder. If
> > allocated decoders are always committed then
> > I'm fine with this, otherwise I think you'd want to a register read
> > or something to find the commit state.
>=20
>=20
> Hi Ben,
>=20
>=20
> Yes, I think you are right. This works in my tests and it is safe=20
> because I check the region does exist before using it. But the error=20
> inside sfc should then not be fatal for cxl sfc initialization and=20
> fallback to the other cxl initialization possibility.
>=20

So I'm running into this situation I think.

When you're testing, are you surviving a reload of the driver?  Right
now, I can load and successfully create the region0 device.  However,
following the same teardown path in SFC, I cannot reload my driver
afterwards and map the region.  I get:

cxl_port endpoint5: failed to attach decoder5 to region0: -6  (ENXIO)
<driver> 0000:c1:00.0: CXL found committed decoder without a region
<driver> 0000:c1:00.0: CXL init failed

I'd be surprised if SFC in its current patch state would survive this
same insmod/rmmod/insmod test.

-PJ

