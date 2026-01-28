Return-Path: <netdev+bounces-254191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PZRC+/keWl60wEAu9opvQ
	(envelope-from <netdev+bounces-254191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:29:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE54A9F764
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6ECD030095CB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA2F2FBDFF;
	Wed, 28 Jan 2026 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="P9Smfeyh"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0B2E8B6B;
	Wed, 28 Jan 2026 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596117; cv=none; b=GdcdQhgyZQdpA/3UH37fO1soUtheyKWSTovgrQdO98T3hGCsz9UBB2yErGysZuZPYqG5T51DB6fVVGjfC1aPiI4+FCmzXaY6/crEgtOOUsCP3LYFQ1n26sRTNYa20K1QkG7B3dGu3hxAjH0LKrEYngHVLsz2W25YRgvkn0mEmrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596117; c=relaxed/simple;
	bh=fST2TX5PPZJpDLOSpjQLko63WnxUbMvUHXK4UwSoCIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MWNd47XxXB6yczMsvjO3DiLUd40aYFaIi0DGj4pQb8N/yXf8FIm4MrywbWnFyHV/lcpiq6+bIzDuvycks1KXBlA0wrknexVQO11j5UIcBndbrXMrok1PtGmJEeQiLa39ci53Nh6C5wF8P+Nx9zbc+2Q4HKqHyKTGxDFSQbZM4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=P9Smfeyh; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1769596105;
	bh=fST2TX5PPZJpDLOSpjQLko63WnxUbMvUHXK4UwSoCIc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P9Smfeyhj+3R4c507f8lR4nt3CVe+M1aTK5Mu2SpAP/JV2jc1lv8CZTSt4RE2DcWt
	 MLOZwcMzcRi01fsbbjpBCDmN6DRmyM40MfJLGCnxyUjxryOghhQI95MqRds0HYeULL
	 3g3LdFnJEb/JIPRDnKdt30zA30vl3jDLEQQOFhG88qzWVNcBbhyjAWflv6EwCacvaS
	 /Nta5fC2XAF2KfOQHLW7gPcFQpOq2+Q7T+pkZtIT8H0ONJi/DLVoiYEDvR5b0wJLN+
	 9pitWreykAIi4jFCYMYZO3/TzltNHHoLG88uqml/ZsNcQ7cUg2H41TAW/dP2U13LV+
	 HQCieJFCUx5RA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C082764706;
	Wed, 28 Jan 2026 18:28:24 +0800 (AWST)
Message-ID: <189d4a03f32ace3fd995596e8b5415ced6ae9c3a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/4] i2c: SMBus ARP support
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Matt Johnston
 <matt@codeconstruct.com.au>, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Wed, 28 Jan 2026 18:28:24 +0800
In-Reply-To: <aXjDENOsmWe5_VqS@kuha>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
	 <30ad166e2b3d7f10080356ec232e604f3ac9ea2e.camel@codeconstruct.com.au>
	 <aXdyll4KVOF6SWni@kuha>
	 <6ca4bc87620bb0c2e5bfb264ec88189f32b53757.camel@codeconstruct.com.au>
	 <aXjDENOsmWe5_VqS@kuha>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254191-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,codeconstruct.com.au:mid,codeconstruct.com.au:dkim]
X-Rspamd-Queue-Id: DE54A9F764
X-Rspamd-Action: no action

Hi Heikki,

> Uh, no. You should only use interfaces like new_device with the
> devices that really can't be detected in kernel, which isn't the case
> here.

Who is deciding this "you should only" case? If the facility works, it's
suitable. You raise some good points that may mean it is not a suitable
approach for an ARP implementation, but we should still make sure we're
taking the right approach.

[You seem pretty defensive here? I'm not saying no to the kernel
implementation, just doing our homework before agreeing to it]

> So why would you want involve the user space at all since it would
> just add complexity and limitations without any benefits?

Because we have fewer risks implementing this in userspace.

As an example, you currently seem to have a stack information leak in
the proposed Get UDID implementation, which would be much less of an
issue for the equivalent protocol handling implemented in userspace.

> - You still need to deliver the UDID to the kernel because of things
> =C2=A0 like the PEC flag, and the drivers will also need information from
> =C2=A0 it.

That seems like the main reason for requiring a kernel approach, in that
we need more information than just the assigned address. It's not
possible (at present) to specify the PEC flag through existing
interfaces, right?

For me, this would be the deciding factor to go for a kernel approach,
in that we otherwise cannot properly describe ARPed devices to the i2c
subsystem. We *could* push a new_device with a UDID, but I'm not sure
that's a great idea.

> - With the static (not hotplugged) devices you need to assign the
> =C2=A0 correct ACPI node (or what ever fwnode) to the ARP-device.

Is that possible at present? how are you planning to represent ARPed
devices in the DT - or more importantly, correlate DT (or other fwnode)
nodes to discovered devices?

> - When the device is hotplugged, you would need new ABI, like I think
> =C2=A0 you already noticed, but this really does not make any sense. We
> =C2=A0 simply don't need it, because the kernel can process this
> =C2=A0 information on its own very simply.

Even this "very simple" implementation may have bugs.

Assuming we go with a kernel approach: For the MCTP case, for full ARP
support of MCTP endpoints, we would still need to consume a hotplug
event that indicates that the device is available at its new address
- there is no kernel driver bound for the remote MCTP endpoints. This
event would be consumed by the (existing) MCTP infrastructure in order
to start MCTP enumeration. Is this something you have looked at
already? If so, if you can send an example of an actual event, I will
look at the mctpd part of this.

Cheers,


Jeremy

