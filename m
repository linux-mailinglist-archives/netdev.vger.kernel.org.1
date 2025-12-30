Return-Path: <netdev+bounces-246353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 868EACE987A
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 426F930145BF
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA029D28A;
	Tue, 30 Dec 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkYVE+qW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5B21D3E2
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767093953; cv=none; b=he7dmZ6C2mHGkbPlXe+sIjBi759axTlwJmghXekROU9FBIviVE/QZ1rnBQe1t4ZyxRc8ap0N5u9khBehOOaUDu6Y/9W2zlXpm7KJew7ZzKeoUbpDJrRgtPA03zjAKDWCwo14Ml9wqNVB2wI9HiH8NTGGYI23rZs6hn7mkd2nbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767093953; c=relaxed/simple;
	bh=Q0KRh2WlU0rrKUhW+BjP73w4A7nFzy7ylPQjuTCBZR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHQjunlMSjYKVNubRu4djDWipxrRMwxfbC0GaYaI0BjwTbV1D6y2vl2tYeZonuK18XygqSvxjHGdJuUvRErQtyZpTBz0LI7nUhmQDl8aXGAEtRV1Ttw4oO9yynz9KUaDggxOLub3LSKLNvGKZ+BBGGmNze6FYMzh+4QwTBvI0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkYVE+qW; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88059c28da1so94660056d6.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 03:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767093951; x=1767698751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NgXrCD6DfjuWE7xs5Gh4b7iTZBbDyZNJYn5FtumHBg=;
        b=RkYVE+qWg/mPyNbrazQWxxXJlZ+mbbJivCcffTWkSwPQKHixc1J6YTT/XLT+hoYt9d
         Y968m0FnQTp5HDhSw48t40/AH/VDzMJAJIALLP4NFCtTlpE0Ip2mwQt0SUw6XaJv9Ea6
         3vhJdQ5TNGxwj2aHCIsIhlb/v3jSTt7KixAEU/S9yGmFDGntm7+yGfhoz10eqJ1cuY5T
         dq7d5cLwmwedRsuYjxqGCR3KEO5m/5RwSXxWSzRu3quRzxZ26sFkD5f5BVgQaiLtwtMS
         5pxtJG5jRkg+pqrTau65v5/N9GGAhgHSI1rMIlK15j3Ub4UUEPJRPBev/cA8NQlnqOnT
         /AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767093951; x=1767698751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+NgXrCD6DfjuWE7xs5Gh4b7iTZBbDyZNJYn5FtumHBg=;
        b=mDUdH6ICsEAn7/2Dr7qcyD9dcLy57wA+QUAjeuHiIb5KddE71OrCDKjhiphrDMDDIe
         y6tHyr6nSgTsTHhHcGdYXjYbiphNNf9bu89XzBIKnNZ5tceQFoTT8nDEw0PAcJRmx6AN
         z52i2iXZcazayjMfd7KQSYRUVThRPWp7iUhL50hpCzs5KqfFB8bMiT0uSUJviP3hsaJ/
         gB7UEP+kKlaU9jr2FFdPR8BEOt9hpPldIAeHyX09luaZa4tqwubnG0NdWaxGJNUXyYSd
         lCzWAqxVPMS4D0+5a6rfDvjZgemAGv5BqZ9QfvC4NK/2n3+2Tz0Vk5WOh4SAwiQq9jrR
         jpmQ==
X-Gm-Message-State: AOJu0YzRZZ26ibfJVNp7Ap7sgE+rmfRD4aewLafD+QjYIKvVT98sVO5L
	JpPacTUf77IJVx7mDgPb9HA4/c9e5O266oJOQZU588kQZdwn5k8O8JWIaMDUvHlc4pmfgtwBiOL
	JPv4dCsCBG24GlhwmJCYriT6OnCjlfl0=
X-Gm-Gg: AY/fxX6RSWOFeI1mdfhFk83eKJsNovAIVBU20H9Bi7YG3aCov+G8av6/DxIU+e9qjw1
	E7Yv8orMEeByviJ1u9q7AMUeu5GrZDA4on6novHIs1ncpJuEDtYh/FA1C1FiJIpy6Jn+dQ8w8bY
	AiyfTiA9co8mnysVWExNAfp9meQk9g5gPzCmswsMUMnVf9yALs8hPCKOf0byhum7YQI9wcL2cLP
	BWoFIP1dXRpw117nqyjjAmmW6Qs7BhvGFa0gbewweXnx0l1UgLb83F1cqqPA1PNFaeTj99FCE3W
	2VBdpVEU6bX1dM+cmQJbISUMGftzmw==
X-Google-Smtp-Source: AGHT+IGY3XLgBvbAOA+BxsBfgsqcvLQc0XaHOfZqjdx+tbBO1ejwTxk6K2fCvSHoufEarI4t7yBgjH+uX7WotYBCwa0=
X-Received: by 2002:a05:6214:4520:b0:888:8913:89b0 with SMTP id
 6a1803df08f44-88d833b57c3mr533981266d6.41.1767093950979; Tue, 30 Dec 2025
 03:25:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228020057.2788865-1-knecht.alexandre@gmail.com>
 <7cde982c-a9c1-4b9e-8d73-458ebede9bcc@blackwall.org> <d9558681-3113-4993-81a1-ff22873908cf@blackwall.org>
In-Reply-To: <d9558681-3113-4993-81a1-ff22873908cf@blackwall.org>
From: Alexandre Knecht <knecht.alexandre@gmail.com>
Date: Tue, 30 Dec 2025 12:25:39 +0100
X-Gm-Features: AQt7F2o07DpKB96mPPXoIsoWu27uXiIjIqLkl1Nr9b2QMAeMblocTyT3MsT-CGI
Message-ID: <CAHAB8Wx39LZUO72uh11aEbdFbFYe0XGJxn_UW6X8X-ESjryksA@mail.gmail.com>
Subject: Re: [PATCH net] bridge: fix C-VLAN preservation in 802.1ad
 vlan_tunnel egress
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, roopa@nvidia.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ido, Nik, thanks for the review. I'm sorry for the missing
maintainers, I felt so bad when I saw the bot result after posting,
will not happen ever again.

> It's not clear from the commit message why 802.1Q bridges are
> unaffected. I think you mean that in 802.1Q bridges the C-VLAN is never
> in the payload and always in hwaccel (even when Tx VLAN offload is
> disabled, thanks to commit 12464bb8de021).

You're right that I should clarify, but I think we may be talking
about different scenarios.

The 802.1Q bridge I mentioned is specifically the case with
vlan_tunnel enabled (for VXLAN bridging). In this setup:

1. The bridge uses per-vlan br_tunnel_info to map C-VLAN (0x8100) to VNI
2. On egress via br_handle_egress_vlan_tunnel(), the C-VLAN is cleared
from hwaccel and used to set the tunnel_id in dst_metadata
3. After skb_vlan_pop() clears hwaccel, skb->protocol is the actual
payload type (e.g., IPv4), not a VLAN ethertype, so the second phase
of skb_vlan_pop() that pops nested VLANs from payload never triggers

So in this 802.1Q + vlan_tunnel path, there's no C-VLAN in hwaccel at
the VXLAN driver entry point.

For 802.1ad bridges, here is what I understood of the flow at egress
in br_handle_egress_vlan_tunnel():

  // 1. S-VLAN is in hwaccel at this point (bridge put it there)
  tunnel_id =3D READ_ONCE(vlan->tinfo.tunnel_id);
  if (!tunnel_id || unlikely(!skb_vlan_tag_present(skb))) // =E2=86=90 chec=
ks hwaccel!
  return 0;

  // 2. Set tunnel metadata (VNI) : this goes in skb_dst, NOT hwaccel
  skb_dst_drop(skb);
  // ... creates metadata_dst with tunnel_id ...
  skb_dst_set(skb, &tunnel_dst->dst);

  // 3. Now remove the S-VLAN from hwaccel (it's been "consumed" for VNI lo=
okup)
  err =3D skb_vlan_pop(skb); // =E2=86=90 BUG: also pops C-VLAN from payloa=
d

So at the moment skb_vlan_pop() is called:
- S-VLAN: in hwaccel (skb->vlan_tci) : needs to be cleared
- C-VLAN: in packet payload : should NOT be touched
- VNI: already set in skb_dst() metadata : separate from VLAN

The S-VLAN was used to lookup the VNI, but it's still sitting in
hwaccel and needs to be removed before the packet goes into the VXLAN
tunnel. The problem is skb_vlan_pop() does more than just clear
hwaccel, it also "normalizes" any nested VLAN it finds in the payload.
The fix uses __vlan_hwaccel_clear_tag() instead, which only clears
hwaccel without touching the payload.

