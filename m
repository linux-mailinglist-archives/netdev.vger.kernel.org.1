Return-Path: <netdev+bounces-278855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJacFxfU32l0ZQAAu9opvQ
	(envelope-from <netdev+bounces-278855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:08:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D51406FF1
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B330B3024111
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB623D649D;
	Wed, 15 Apr 2026 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="R8/25VZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BED3195E4
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276500; cv=pass; b=u581mYWWOT60moYUpnkMZO5dJaec8M2WGbxR7m8cy3GT9MVCz69Z0xkSBuhetSfMC/kinxYDGYslguuMFBR2djD8hSekO18iQ92hopekn9463ZjmxlwxiKnrU56SYC362egBJOVDRYzhMlktF1wD3M3I9KcoSbhIyeYJh7os6s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276500; c=relaxed/simple;
	bh=cJT/V1RaPX7xQlpuUxPMCYhNmPenUvZGVmWNJGcaX2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ep5zOBh3P19H70d805JRMic/rTXe+KYcgJsPjhLXm3XSq2l2h6g/TeClqAsnmzQQH5qDrng8jv0B/1gZMH2G44v05K98aysk8YnPyfKuQMId3AVS7fww4OA9Q+MI4yvHT1zN2JPdf3oGIb8U/sF8af6Iv6eHfd8R5C9bgfCJMEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=R8/25VZH; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so3789423a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776276497; cv=none;
        d=google.com; s=arc-20240605;
        b=gfkCf3DsmY5KqqF+gn1iKKqdonsUIDE0w7ACZqBBEJhpZoFn601LC8cVtb5HUuhINJ
         Co89Jfyl4wr5PrnzB03qTz8F9I5riwAMx1bYwZtdesq8F7lYmKJiSPc1mwDLVZ3cd2Er
         XcYxkWjrb7HwS6BXUkWuitRjqtQ2aQbWajiAr7UsOAZgOeVsc3z3viyULUDkrUK0/T56
         wxIew71EOe0w1GEL1C8yH4bd9lyWUQh/KLiz64PAjSuEn8sdoK/nQqdtoRgIHWZ9O1FH
         /HGp/1Q6X2PjhTu5WNgWtL32nV6oQLuqK4QZEnf4hDR2Tx0n2X8x7wn2uaAwHHXyxE3L
         E2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=26dUy5Nk7fi7bs64cuAGqDvpQjZ4Ui+HpDi9p02QqOk=;
        fh=8i4BkJ7A2sbsgM1+Fe68SjLDkqmJfGNb+pxYd/lDi1E=;
        b=SiwejGDX34m5kSB+qkdeylWHnSqcIwasv6CzKAWRgJ5KJiqJVAv4od38OLCmAx+uJB
         mfbfF/+aLGALWI73TEb4vHEF2pNq0eOkev8YmmEpgXk+rXNI2Shwd+3YIEzIwkgp2fWl
         zkGJXPIOLKeWwzytmZSF94OuFLjiFPiXkIf8e8wJLfW00CqUHSPs6cAu5N3SEH0XjkDQ
         scOmJM7qgKI524uj7//J1UIBWrUThV6BQfLs3/Iya1b8uUeuCCJsVA2pdzyTMy3P/lGt
         WVhXY7Z1h4l5yy75V+hbGXsCO1aAncXdJhBD9US4ie8BWMzeWbV94W0XOc0/01TJ3tbF
         h9eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1776276497; x=1776881297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26dUy5Nk7fi7bs64cuAGqDvpQjZ4Ui+HpDi9p02QqOk=;
        b=R8/25VZHmBbKeW5H5F74axvTK+PElw+LRIQXlsWaiSDOTUcAADUafT6jsDPMKKadWL
         HmJsVT3tXpyvLw51oDkg4ntAhX0u4orkJPieP8+HW8IzSZVsjQsrzLs1g/SdTkYHz5om
         SfaWIcCukb4RruKf4JojQep6s1NWcXyMgHUl4GElzt1YdAyeA+Ut/x2ufnDOIg7m24dE
         C2H3O5vM56V5sBCumLDGgwH5hpg4i+KwDrmZYVdo538NuwzsZ0mOVIJVw5NmPNmYHjbO
         Gn1Dd3h7OwyEukJMEgQ4NPEhSf0ruk0NEVK6RnTHZgVhtGjri2jE5qstlw//VrYD4B3W
         kZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776276497; x=1776881297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26dUy5Nk7fi7bs64cuAGqDvpQjZ4Ui+HpDi9p02QqOk=;
        b=ZMxHgMo4rPnRem9SXLaChc/uzDsoGG7xKCXAnOoJjPR9mBiFQceYKdopqVXmCiTyzk
         lS806UuPps7JQnpHH7T/Zlq1Ec+HfILskXeBsHzYlGJenNXTlcCtBHSXnijpAV5DahCJ
         Sx93PsadZK39r0vG8ETzzqqpSk26YNTNSlHQepWFU0wVPHSCFvsEgsK8v27Sn6NjxZNo
         CpfpsCRvrB8EfWt6k4zrqN5nxqddIUhXId8SebD45RAxxa4hCt4m5JFPpHVq9ioOzTEA
         CmRN35EsI8dsWb5cY54bfWfeJV09ozyGn3UqV4zfER1JdHj06xIZDGZRugahj9TXXAZq
         zfeQ==
X-Gm-Message-State: AOJu0Yzd3g6+k/x5kpXUfLwAFvLV3T+2Ot3hP67mCKhdvmfCARkrRADx
	zJKwI/W4irhQUIGHqFOShM67ZjagsqdgE0iyXZimOO3oTmpWgGRxIkxdQ8uzZKLCJ1ofoq1k15q
	nKc+5YIQQePWMFWMU5b+V6DjyshCDUkdDIS4hTAOP5Q==
X-Gm-Gg: AeBDievN+SzvwxiCEKOOeoMpJZ6A62kHjb7sVhvi5PSvM4DSYlUZ+H4JlAFWq99PbXP
	prV9+70or+MJcN7t721KcQTIpCXYXTI0ZyWSycTkD5JWIS7YA7eUruCIqWbHU1GbZF9uTTABAo3
	Sah1aiiXnrvRuKXN3LLzBCigQZRO9CrYcljZszlF7d4SUxlhLYCpFxND+pNc5sn+4wkBNgnHsXp
	WTkyrM2+FSFd6kRBdPCqCmQdjnmjN1AeKsQOlB2Mrv3/q3jmKlJTvUThTZSpqo4PemoFwljjQpc
	66lFMFMxsHBr12MGLl2b5KmiYlVMi21Aa6fZC9XWs0BD/q1NA/Q=
X-Received: by 2002:a17:907:c448:b0:b9c:30b8:dcad with SMTP id
 a640c23a62f3a-b9d727971cfmr1347727666b.34.1776276496830; Wed, 15 Apr 2026
 11:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
 <20260408152353.276204-5-louis.scalbert@6wind.com> <710787.1776105588@famine>
In-Reply-To: <710787.1776105588@famine>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Wed, 15 Apr 2026 20:08:03 +0200
X-Gm-Features: AQROBzCNYdFMnVDFTJ555v4vX8z3pgzXxzTtnlTHosPKM2wMtaVUI4sIW4lqbjI
Message-ID: <CAJ5u_Oe90J6Kdt1wR=0se4YRWF6LJwzPvyt+oqPe0od-9vACtQ@mail.gmail.com>
Subject: Re: [PATCH net v3 4/5] bonding: 3ad: fix stuck negotiation on recovery
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net, 
	shemminger@vyatta.com, maheshb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278855-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email]
X-Rspamd-Queue-Id: A2D51406FF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le lun. 13 avr. 2026 =C3=A0 20:39, Jay Vosburgh <jv@jvosburgh.net> a =C3=A9=
crit :
>
> Louis Scalbert <louis.scalbert@6wind.com> wrote:
>
> >The previous commit introduced a side effect caused by clearing the
> >SELECTED flag on disabled ports. After all ports in an aggregator go
> >down, if only a subset of ports comes back up, those ports can no
> >longer renegotiate LACP unless all aggregator ports come back up.
> >
> >1. All aggregator ports go down
> >  - The SELECTED flag is cleared on all of them.
> >2. One port comes back up
> >  - Its SELECTED flag is set again.
> >  - It enters the WAITING state and gets its READY_N flag.
> >  - The remaining ports stay UNSELECTED. Because of that, they cannot
> >  enter the WAITING state and therefore never get READY_N.
>
>         This is the part that I think we may be doing something else
> incorrectly.  If the port is UNSELECTED, then that means that no
> aggregator is currently selected for that port, and therefore it
> shouldn't be assigned to an aggregator with other ports (per
> 802.1AX-2014 6.4.8, "Selected").
>
>         I'm not seeing anything in the 6.4.14 Selection Logic that makes
> me think a port that is down (port_enabled =3D=3D FALSE) is disallowed fr=
om
> being SELECTED.

Yes. Clearing SELECTED when port_enabled =3D=3D FALSE is incorrect.
That means my previous patch was wrong.

>
>         Looking at the Receive machine state diagram (Figure 6-18), I
> tend to think that in this case the port would transition to
> PORT_DISABLED state, as we're not asserting a BEGIN (reinitialization of
> the LACP protocol entity), so the port variables can remain unchanged.
> There's even some language that suggests this is intentional:
>
>         "If the Aggregation Port becomes inoperable and the BEGIN
>         variable is not asserted, the state machine enters the
>         PORT_DISABLED state. [...] This state allows the current
>         Selection state to remain undisturbed, so that, in the event
>         that the Aggregation Port is still connected to the same Partner
>         and Partner Aggregation Port when it becomes operable again,
>         there will be no disturbance caused to higher layers by
>         unnecessary re-configuration.
>
>         So, perhaps the actual bug is that these ports are attached to
> the aggregator but not SELECTED.

Yes. According to the Mux state machine diagram, the correct behavior
when port_enabled =3D=3D FALSE is to transition to the WAITING state,
except when already in the DETACHED state.

The WAITING state should then be responsible for clearing the
Synchronization, Collecting, and Distributing flags.

I will address this in the previous patch, so this one will no longer
be necessary.

best regards,

Louis Scalbert


>
>         -J
>
>
> >  - __agg_ports_are_ready() returns 0 because it finds a port without
> >  READY_N.
> >  - As a result, __set_agg_ports_ready() keeps the READY flag cleared on
> >  all ports.
> >  - The port that came back up is therefore not marked READY and cannot
> >  transition to ATTACHED.
> >  - LACP negotiation becomes stuck, and the port cannot be used.
> >3. All aggregator ports come back up
> >  - They all regain SELECTED and READY_N.
> >  - __agg_ports_are_ready() now returns 1.
> >  - __set_agg_ports_ready() sets READY on all ports.
> >  - They can then transition to ATTACHED.
> >  - Negotiation resumes and the aggregator becomes operational again.
> >
> >Consider only ports currently in the WAITING mux state for READY_N in
> >order to avoid __agg_ports_are_ready() to return 0 because of a disabled
> >port. That matches 802.3ad, which states: "The Selection Logic asserts
> >Ready TRUE when the values of Ready_N for all ports that are waiting to
> >attach to a given Aggregator are TRUE.".
> >
> >Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
> >Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
> >---
> > drivers/net/bonding/bond_3ad.c | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3=
ad.c
> >index 3a94fbcbf721..3f56d892b101 100644
> >--- a/drivers/net/bonding/bond_3ad.c
> >+++ b/drivers/net/bonding/bond_3ad.c
> >@@ -700,7 +700,8 @@ static void __update_ntt(struct lacpdu *lacpdu, stru=
ct port *port)
> > }
> >
> > /**
> >- * __agg_ports_are_ready - check if all ports in an aggregator are read=
y
> >+ * __agg_ports_are_ready - check if all ports in an aggregator that are=
 in
> >+ * the WAITING state are ready
> >  * @aggregator: the aggregator we're looking at
> >  *
> >  */
> >@@ -716,6 +717,8 @@ static int __agg_ports_are_ready(struct aggregator *=
aggregator)
> >               for (port =3D aggregator->lag_ports;
> >                    port;
> >                    port =3D port->next_port_in_aggregator) {
> >+                      if (port->sm_mux_state !=3D AD_MUX_WAITING)
> >+                              continue;
> >                       if (!(port->sm_vars & AD_PORT_READY_N)) {
> >                               retval =3D 0;
> >                               break;
> >--
> >2.39.2
> >
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net

