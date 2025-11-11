Return-Path: <netdev+bounces-237643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE2DC4E519
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED6A3B3B7F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D4232D7CC;
	Tue, 11 Nov 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9niyACQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2487532827A
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870161; cv=none; b=nLvSG66i9ETH7PEXzECLJB12EWp4NnJEIRoVPAgB1nsCbSX8KVqiDWoKL3ooiDulM04tiJBd9R4eBXo7+xi2U9SeXQNnIpE0XvlixuvW/Q5GBO+GRR1Y78DBFNs5X1vFHu/Uv7wVyKY3s+Ulay+AYFHSpbV3x6zngLRRRLJUB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870161; c=relaxed/simple;
	bh=lKvYpwqQnJ6dGU4fs+Qweyj9XLovb4ksA8r4FMq9T/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uk9Xs1NVZPgdtvTTrwZ4ohxpPynk30EZU0iNfn0kQtzDz9hynGxpcC/+nQRRguGmdVYCE2rv3di+l5yYK6ZR2a4bJYpVu3b3HQLzMofHJ1ICOHuLX6xRf2nkMmR5Wv1/qgy5m0xHdB0LE0RdwkHbybTWsJgWsQ9LLG8ROwpJbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9niyACQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-786943affbaso32212277b3.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 06:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762870159; x=1763474959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKvYpwqQnJ6dGU4fs+Qweyj9XLovb4ksA8r4FMq9T/Q=;
        b=A9niyACQ1CLEipFyQLELij2zugvYSaUJu6P9KO5RKH1enUV0S3keqSAtlyCBLo0ywG
         JiGxAyd2XIPcFrMifcM1kW6uMkagAA5GxUae14lU22xPzZ5oM31AKlUo5OVpb7gOUFPM
         ewY1QQajAajEup61GSjV1Tr7d81z0UdVyDfvHznjyntxVaXT4qGDVBEwz71UXfVCR9iF
         cseTOXrLyqcmenyod4owQ4U1LIIn+uen4AYnK8WMy9DEXaAEXEdAuF4xUioAw1m2cBgZ
         5RWWbfBczsaSmAmgoklE8hdfT1J5Dm9Itcm10Gp5SYgUSUhOA9LmNtdY07YpAcVFyXz1
         DJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870159; x=1763474959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lKvYpwqQnJ6dGU4fs+Qweyj9XLovb4ksA8r4FMq9T/Q=;
        b=osa7pUXI2Bl2sSLUiwcmLUF2uCDCV9Lkq0q6VSkWk85jB4RA7RaXV1apnXZL6yMmVZ
         VlzftJbmOB4dgN8uA9E46lddFTQqzMG/VhsUJIULBzBXOI7JnkSzgqd4rKvLKtjPcAI5
         3w68iyvk/TPOgiQXTwloeGTyXvoCXZXtwbAu5El3DC0ubh5GNrbooK9DwPcN9PZwftTV
         TJ/ZRByoY6lORpf+0IZ86XAjRLJ8sVWcLCAjGTxOvjbNyP8gS2oFZWYGIe4ZELa0chdw
         TrHIirL41m9T8i5sxbMBQmnFhgow0hangmhmz8RDoJT5XePSfoLYFRijfOqeeGnrawjn
         W2vg==
X-Forwarded-Encrypted: i=1; AJvYcCUSMZgZ21gCyqeX/N7nZQ56N8Bu8nIbSMHwyV0+XpFxjn6ZyLgbGQ3CF3kG4GMhGcAycKxOmok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4BaXNzE1pQ+8u3jNg5b5n9DJA9CtDUBpLsGBuXPZ6OAsuFK/
	lJyAtldrT3KaD9wZl1fj1HVvU/pn6fuC6rymJhktedwtJ+1kYAnnoXnlO2f5Y2OQNFqgwGBGilb
	OaAmFR0jncR62FPRyEuPXDLYJbRe8FdI=
X-Gm-Gg: ASbGncsi6VlO4HuDCQbyd0LL7rjT+/EBs5EXBRfZLrmGfWTRBdY9GWSQ6KPl+oOH6PD
	dYOo2vWR9YiqhKR/JUt3MaauWp4VIE3uSzq4d0H3A/DUdHtEnRnoDHT+6XBe9vunYBWx79hTo5d
	vG7/b2pysQj7Vipm36btwH/qSZfz6qZ8lL+t0voyb/pq3gmlQ2FRAVqHp51oGt1/diD6QI4+8qC
	J7VzVH76YsePHOKI5yBBnlhGcEACK9eTjzNEwA23nmJZ2XaJkpCKyPX7jW7iEU/tGT6yg==
X-Google-Smtp-Source: AGHT+IEReJBfVSAk0eoYfnzdrR93k21w91Zsnv9N733OFz6C+DIbne/NcUIcbDC568iFDoZTIzaULrqDzX2W1sQibCc=
X-Received: by 2002:a0d:e7c5:0:b0:786:3ee8:6703 with SMTP id
 00721157ae682-787d54288f9mr99307027b3.48.1762870159175; Tue, 11 Nov 2025
 06:09:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
 <20251110214443.342103-4-jonas.gorski@gmail.com> <20251110222501.bghtbydtokuofwlr@skbuf>
 <CAOiHx=k8q7Zyr5CEJ_emKYLRV9SOXPjrrXYkUKs6=MbF_Autxw@mail.gmail.com> <20251111115627.orks445s5o2adkbu@skbuf>
In-Reply-To: <20251111115627.orks445s5o2adkbu@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 11 Nov 2025 15:09:08 +0100
X-Gm-Features: AWmQ_bl0mnwrpftQx5GbB_wrINGDGSTdQZRRKJwrjBBVitFGV3hI3aNAoZlnpDc
Message-ID: <CAOiHx=naX6RbV0qBFZP3QhpKCnZ2KWdq8L23rUh4D7xwmGARbw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: deny 8021q uppers on vlan
 unaware bridged ports
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 12:56=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:
>
> On Tue, Nov 11, 2025 at 11:06:48AM +0100, Jonas Gorski wrote:
> > But I noticed while testing that apparently b53 in filtering=3D0 mode
> > does not forward any tagged traffic (and I think I know why ...).
> >
> > Is there a way to ask for a replay of the fdb (static) entries? To fix
> > this for older switches, we need to disable 802.1q mode, but this also
> > switches the ARL from IVL to SVL, which changes the hashing, and would
> > break any existing entries. So we need to flush the ARL before
> > toggling 802.1q mode, and then reprogram any static entries.
>
> I'm not clear on what happens. "Broken" FDB entries in the incorrect
> bridge vlan_filtering mode sounds like normal behaviour (FDB entries
> with VID=3D0 while vlan_filtering=3D1, or FDB entries with VID!=3D0 while
> vlan_filtering=3D0). They should just sit idle in the ARL until the VLAN
> filtering mode makes them active.

When in SVL mode (vlan disabled), the ARL switches from mac+vid to
just mac for hashing ARL entries. And I don't know if mac+vid=3D0 yields
the same hash as only mac. It would it the switch uses vid=3D0 when not
vlan aware, but if it skips the vid then it wouldn't.

And we automatically install static entries for the MAC addresses of
ports (and maybe other non-dsa bridged devices), so we may need to
have these twice in the ARL table (once for non-filtering, once for
filtering).

If the hash is not the same, this can happen:

vlan_enabled=3D1, ARL hashing uses mac+vid
add static entry mac=3Dabc,vid=3D0 for port 1 =3D> hash(mac, vid) -> entry =
123
vlan_enabled =3D> 0, ARL hashing uses only mac
packet received on port 2 for mac=3Dabc =3D> hash(mac) =3D> entry 456 =3D> =
no
entry found =3D> flood (which may not include port 1).

when trying to delete the static entry =3D> lookup for mac=3Dabc,vid=3D0 =
=3D>
hash(mac) =3D> entry 456 =3D> no such entry.

Then maybe we ignore the error, but the moment we enable vlan again,
the hashing changes back to mac+vid, so the "deleted" static entry
becomes active again (despite the linux fdb not knowing about it
anymore).

And even if the hash is the same, it would mean we cannot interact
with any preexisting entries for vid!=3D1 that were added with vlan
filtering =3D 1. So we cannot delete them when e.g. removing a port from
the bridge, or deleting the bridge.

So the safest would be to remove all static entries before changing
vlan filtering, and then re-adding them afterwards.

Best regards,
Jonas

