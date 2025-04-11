Return-Path: <netdev+bounces-181811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF421A86820
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE8217A1A9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971CE298CD9;
	Fri, 11 Apr 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcKEIsWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453828FFE2
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406612; cv=none; b=i26O7aZo9r5kctkfXTj51jHIAvHmmowXnRrBANBmQtbVOT0PUgpKH+VF9zEX8EMY8bo/lf2cYLSqCqHFhszpe3TxKqL7W7IKeqRO8ZVyi87gfwiPrPE+/9IHLQ0ukn7Mbk4dCepjIQpJUZ4mpDPYYZ9M9G5HnNmrNhZZkgWxr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406612; c=relaxed/simple;
	bh=TFc1msSVL8TrD7jQmjDQo9WHA9wY5+KQovX3eoWq1jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRQARoc1pFTHwi1Zw02rEDLmDU2Wo+t5UjY25ofX6Ab0d/DKww+7aPWrlFGMMyQDSY9QlN1fJmlX4zabPaosd0BpSj6ntn24bUI+pnygr5dgAzU6hNk6x68oFAvGxcdqoMHXs903ySKyTWMgwazurUabrgak3RTfk+DtXsVWK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcKEIsWM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so197362f8f.0
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744406609; x=1745011409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCGkg5A8EptlYGDTzoh+oO4iHRFfaIxehBH4ncDJ8Nw=;
        b=gcKEIsWMVXnJpRd1coMrVLzVHCArvMCmuxL7Hmg2sBaA7aWmbPAUZObRUvN6bRPOeX
         gssgzxCI+Psro4OdC/1Px4CQStmcq3QETSHTo9xbaBJD80gGQbNudr5/1cJTbMv9FqJW
         dfLXaXXM2W0qMFKi5RyXr2P4tiyV2taf4C69avTetfbs9De6QX3naZRhBru5VIPnFWTW
         QtN8H00B6l6a9+J5X8fIzVZm7qnBWe+fjIBkqvie7ZWXCEHG+OVFk+2MWAlX0dclPQ1O
         qBNs5qOWf54XE7HOxCtoLhk6ijxjwUABdW2ty20J8XcEC6pu2hYkezRYYkSXfbM2fmCa
         E1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744406609; x=1745011409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCGkg5A8EptlYGDTzoh+oO4iHRFfaIxehBH4ncDJ8Nw=;
        b=J22iY1C5+FF/1Bs+FdvlpSaUC9tAtN5CtPqFEkeIir2A5mcuthxwvr1KvbbhnRK2Wf
         nAhu+wSIqWq22yJzZcJQVg2NizprWOja2dF7VOKXXDF0hhoiX/vHmRRVobRr7ZQ2EuOm
         daFvTkT7SOdDTa7g0JruohW3XxzkKq2BUOcqSyeHZuK2W3F7cmc4jclvTDnQccil2D7r
         GbwR54Pyo9vVdebxU0xAbtqXdlkjOeMX+3nW6Tqjlc3toG0mcylENMMb3M1V9SzbYFNj
         uwReZcGBSpU7Uxsbug0C5X2ue7gX2S6xiZQSDmmxm4tlt5l/Xyj2dwyiBwdl/dr3UwKE
         dyzg==
X-Gm-Message-State: AOJu0Yyt5U/C72rpiETiJC5jdMobZsJMJZXjaHklrJjhe0bXqFvngtOv
	vux039LqnTJ6ZvZ+n7vvuaasz84imVnov9C95IRYvIRohDduVnQcC6rBtg==
X-Gm-Gg: ASbGncug5kKWe3uU+mT4AWPnI+T91918vxZRwN98RsLZD1ZDGceCZCiMuINbAxbPD5I
	Hm/K5D0t8f+4Gr6LjWRPHh4ThuvvRt6n2cRcA1F5gI0GeMYkZnAbOLOszv/7U9VLKrPK+2oCMuD
	EbBO4QKOPT/qa38FacC4cPa4usHBsLA8/oISGHf3C4THjW4HldFUGchof2FLZ8kKt8G9kMmP60F
	Vux+AeS+VIHgv54MTsPThk7Lne2rcVl99hPGMcjfQIBBSF1rvtAcPlhe7bWGXyool/f6tzUuUbu
	ADflmxEu1+dn53DQNE2ctL2CgxSb
X-Google-Smtp-Source: AGHT+IGdTxhiNXf6gjNdwNHyZc2Uid4w8GChoHlCP12P6jCf0kArzFmLSzuZjNa3uHKuH1Wn/kTaSA==
X-Received: by 2002:a05:600c:3ca6:b0:439:9c0e:36e6 with SMTP id 5b1f17b1804b1-43f3a93d4b8mr13866715e9.3.1744406608494;
        Fri, 11 Apr 2025 14:23:28 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc8esm101296685e9.30.2025.04.11.14.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 14:23:27 -0700 (PDT)
Date: Sat, 12 Apr 2025 00:23:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Subject: Re: [BUG] 6.14: WARNING: CPU: 0 PID: 478 at net/bridge/br_vlan.c:433
 nbp_vlan_flush+0xc0/0xc4
Message-ID: <20250411212325.knn3a3id3p7oidug@skbuf>
References: <Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk>
 <20250411184902.ajifatz3dmx6cqar@skbuf>
 <Z_mAFvJ9w4kn0v_G@shell.armlinux.org.uk>
 <Z/mA27oWj2eSvTTF@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/mA27oWj2eSvTTF@shell.armlinux.org.uk>

On Fri, Apr 11, 2025 at 09:51:39PM +0100, Russell King (Oracle) wrote:
> On Fri, Apr 11, 2025 at 09:48:22PM +0100, Russell King (Oracle) wrote:
> > On Fri, Apr 11, 2025 at 09:49:02PM +0300, Vladimir Oltean wrote:
> > > From 508d912b5f6b56c3f588b1bf28d3caed9e30db1b Mon Sep 17 00:00:00 2001
> > > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > Date: Fri, 11 Apr 2025 21:38:52 +0300
> > > Subject: [PATCH] net: dsa: mv88e6xxx: fix -ENOENT while deleting user port
> > >  VLANs
> > > 
> > > Russell King reports that on the ZII dev rev B, deleting a bridge VLAN
> > > from a user port fails with -ENOENT:
> > > https://lore.kernel.org/netdev/Z_lQXNP0s5-IiJzd@shell.armlinux.org.uk/
> > > 
> > > This comes from mv88e6xxx_port_vlan_leave() -> mv88e6xxx_mst_put(),
> > > which tries to find an MST entry in &chip->msts associated with the SID,
> > > but fails and returns -ENOENT as such.
> > > 
> > > But we know that this chip does not support MST at all, so that is not
> > > surprising. The question is why does the guard in mv88e6xxx_mst_put()
> > > not exit early:
> > > 
> > > 	if (!sid)
> > > 		return 0;
> > > 
> > > And the answer seems to be simple: the sid comes from vlan.sid which
> > > supposedly was previously populated by mv88e6xxx_vtu_loadpurge().
> > > But some chip->info->ops->vtu_loadpurge() implementations do not look at
> > > vlan.sid at all, for example see mv88e6185_g1_vtu_loadpurge().
> > 
> > This paragraph isn't accurate. It's actually:
> > 
> > mv88e6xxx_port_vlan_leave()
> > {
> > 	struct mv88e6xxx_vtu_entry vlan;
> > 
> > 	err = mv88e6xxx_vtu_get(chip, vid, &vlan);
> > 
> > and _this_ leaves vlan.sid uninitialised when mv88e6xxx_vtu_get()
> > ends up calling mv88e6185_g1_vtu_getnext().

Correct, vtu_getnext() reads the SID and vtu_loadpurge() writes it.
I got carried away when I found a plausible explanation for the issue,
and I was in too much of a haste to post it (plus, I had no equipment to
test).

> > I posioned to vlan (using 0xde) and then hexdump'd it after this call,
> > and got:
> > 
> > [   50.748068] mv88e6085 mdio_mux-0.4:00: p9 dsa_port_do_vlan_del vid 1
> > [   50.754802] e0b61b08: 01 00 02 00 de 01 de 03 03 03 03 03 03 03 03 03
> > [   50.761343] e0b61b18: 00 de de 00 00 00 00 00 00 00 00 00 00 de de de
> > [   50.767855] mv88e6085 mdio_mux-0.4:00: p9 vid 1 valid 0 (0-10)
> > [   50.773943] mv88e6085 mdio_mux-0.4:00: p9 !user err=-2
> > 
> > Note byte 4, which is the sid, is the poison value.
> > 
> > So, should mv88e6xxx_vtu_get(), being the first caller of the iterator,
> > clear vlan entirely before calling chip->info->ops->vtu_getnext()
> > rather than just initialising a few fields? Or should
> > mv88e6185_g1_vtu_getnext() ensure that entry->sid is set to zero?
> 
> Or maybe test mv88e6xxx_has_stu() before calling mv88e6xxx_mst_put() ?
> 
> If mv88e6xxx_has_stu() is not sufficient, then mv88e6xxx_vlan_msti_set()
> is another site where mv88e6xxx_vtu_get() is used followed by use of
> vlan.sid.

mv88e6xxx_has_stu() is sufficient, the question is whether it is necessary.

Testing for sid == 0 covers all cases of a non-bridge VLAN or a bridge
VLAN mapped to the default MSTI. For some chips, SID 0 is valid and
installed by mv88e6xxx_stu_setup(). A chip which does not support the
STU would implicitly only support mapping all VLANs to the default MSTI,
so although SID 0 is not valid, the behavior coincidentally is the same.
I'm not a huge fan of coincidence, being explicit is more helpful to a
human reader.

In my opinion, I would opt for both changes. To be symmetric with
mv88e6xxx_mst_get() which has mv88e6xxx_has_stu() inside, I would also
like mv88e6xxx_mst_put() to have mv88e6xxx_has_stu() inside. But that
means the caller will have to dereference vlan.sid, which means it will
access uninitialized memory, which is not nice even if it ignores it
later. So I would also add the memset() in mv88e6xxx_vtu_get(), prior to
the chip->info->ops->vtu_getnext() call.

