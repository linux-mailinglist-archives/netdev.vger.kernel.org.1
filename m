Return-Path: <netdev+bounces-260182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFQxAVqznGmxJwQAu9opvQ
	(envelope-from <netdev+bounces-260182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:06:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B217CB8A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5630830185BE
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B72374749;
	Mon, 23 Feb 2026 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+7D4nw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6EE33C524
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877205; cv=none; b=HmJv4QZgQmw7jqOwjJiVmKpQlajyZsjJ9TTwQVihCS6eD2N7IZP2AoVw1Yz/Cas5+K60BxNVpt5QwzqDc2ZpUs3QYBmxlW0kBBYOPyLttRl0i2rd5kOPYPX1EgbWFPqFL5Cq3RQNR1vv8k2V+Hd3y5Btjk+sjJ6+L1mzfsIMqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877205; c=relaxed/simple;
	bh=g6LAETa0R0tegKR8qD+PpFoU0jkpjO6qf2H9CzOhyjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brZ7t3OGiLzkxACD/38xfhHVh80ex8jlSBWV4SWnqmueJObIZTa1bOXYYbxJRdu3MN53YTGwp95tnxh9i1UuaMWXtC5VSyXXUNKlTCHrqRqn4NZUokF0cXZETQUtdVC5yw95SyAY6jp67oxPz3gwaSxUFVSVBv2fGsjc3A8sHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+7D4nw+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso53911045e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771877203; x=1772482003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuEmWWstgxoR/PSZFyQl/62rmQdomS+A0XRrzus9+Vo=;
        b=F+7D4nw+cmI+yqa6ys+zAwCmRJAvj517qHI+NmrI+vd4UoFSg0E7LdJQfcYOOS+tp+
         kfpZOCWyyLciIuSKNYi2tRUNzyskEbKLN41FR+NSIUjJCXkCWTBLVM5LnjoGrlufKJrT
         Ik30X/rYvg4+zFezFVZZ651eZc6fzmVOMTb8w/3ftQ2iVatgIiQP31T05PWGz5hN4uVo
         kw1AcJs9vu4lTj5pOFcvni3xtBXiQv+JGUUvTD+GCBLZw77DY9kE99gKDemJxc587dXX
         LfJClCoQ1OU3s2WfZbUpiQXWwBCDimyyCrJclWzt28om/Yub3VOyPqY283X/4SKsiquJ
         Pvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771877203; x=1772482003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuEmWWstgxoR/PSZFyQl/62rmQdomS+A0XRrzus9+Vo=;
        b=rNvw9H9CEzTWLwo+FyeBE3AU+4OHujNbWAXeLiIbUDNVTRnjkpxn3CV4N3iMGPiEvG
         a+EQ86Tt0qTvUJwXV3nx6LyTI8YrOqvzzizukpMvtHTi/IH8+tX89fUPDGHMY3ujY+9c
         2EMEw74W9woMpdwW2kzTebqFj4bge5ItEypcY9wgAWbSdj5y+m6rZbtqnJVFAmE8ZyrA
         TCG3/nzS1Ejf3L0rMDOOkvtu1fUbBhTi+K73sPnxiOi4a+Jcm2y0PpcaeXtCuDzdVeip
         +Qnsr0TcmZ2ED/us48pheEk1gfPAeFTJLW8y50uX6x7zf/aG66/xGy7LY38xWRTmN2OR
         a2zA==
X-Forwarded-Encrypted: i=1; AJvYcCUr+nXqBMtfsZh025zM2On32VII+JUhZw8zGI26I4R8yXTNgjeLrQ84JUBJlZt8VPlVnLNsCCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcrzq3cxG80pH2Kj9uD2Jz3E1PTMU7io5XQAl5kEV2E1acR1N
	m59XLE1E8yqethBDxjS23RH9c1eOHkl2mtjSAVrBKWvxQ4aMgXDBGudz
X-Gm-Gg: AZuq6aJdMKsfgUO/4zCGY0ZBYUbQBVMnP+uZ7ktOsdk1NxRP5n4B72ydSb+8GC+bi7w
	IpL0oYr2vuVOaZo/c3iGP0Obuxu5XCqFQQli5l39rEDjZurDWtQhyK3SOgnuBVq5kVEmjk97PA2
	piBPzGmH2qQW8Ywa0MDhyHQchJiVhRdcMpxpyXIqGIkkO/uY7m0Bp6dNIlu3tqjijEY9sR0H8vn
	XCMP8oIsj3hkpEpPvMLaafirroAE+Q4JXx3sgFqVm9kz6XqxghIUfCD7DTQp90qzX97nl9k4LYE
	NjP0SWO5eFcwHkGmisIchQiwdblLB8/HGTvL63ylK86alIgpwROnC8dDRlx3Fb+z/O1R46PawMS
	aOVP1ivXs+jCX2md7HooGCWCQ1hsm5Fhy4X7n223CJBLgA5riVZrIzeJwZTu1/16NWrb5SrR4VW
	4kvGCGDSMz2nCUbJlgiJFu/LMBSKaLYLjh6jW67s063QOZNEVncYlhyE82CBUPj1c+pPy0BWwBM
	uIn
X-Received: by 2002:a05:600c:8183:b0:483:5310:dc67 with SMTP id 5b1f17b1804b1-483a962e158mr155739705e9.20.1771877202519;
        Mon, 23 Feb 2026 12:06:42 -0800 (PST)
Received: from [10.0.0.98] (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm262435565e9.5.2026.02.23.12.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 12:06:41 -0800 (PST)
Message-ID: <a2cb0831-1454-4dfa-83e1-28b6738a5de8@gmail.com>
Date: Mon, 23 Feb 2026 21:06:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
To: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>
Cc: Frank <Frank.Sae@motor-comm.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
 <3e9812a5-401b-400d-9d9b-eec8ec8d0acf@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Jakub_Van=C4=9Bk?= <linuxtardis@gmail.com>
In-Reply-To: <3e9812a5-401b-400d-9d9b-eec8ec8d0acf@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[motor-comm.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-260182-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C7B217CB8A
X-Rspamd-Action: no action

Hello,

An alternative approach was suggested to me earlier today: changing the
probing order in (of_)mdiobus_register() so that PHY address 0 is always
probed last. The offending PHYs would be reconfigured to not listen for
broadcasts on address 0 either via the PHY driver .probe callbacks or
via non-board-specific PHY fixups.

Do you think such an approach could reliably avoid the address-0
conflict, and would a patch along these lines be acceptable upstream?

This issue does not appear to be specific to the Motorcomm YT8821.
I have found other PHYs that also respond on MDIO address 0 in addition
to their strapped address, including:

* Realtek RTL8221B and RTL8211F PHYs,
* Micrel KSZ8081, where this is acknowledged in commit 57a38effa598
  ("net: phy: micrel: disable broadcast for KSZ8081/KSZ8091")

My understanding is that this behavior may stem from differing
interpretations of IEEE 802.3-2005 Clause 22.2.4.5.5. As I read it,
the clause requires a PHY connected via a specific cable to always
respond on address 0; some vendors appear to have interpreted this
as the address 0 being a reserved broadcast address.

I also received some feedback on replacing the bootloader in various
routers. While the U-Boot can be replaced in the Cudy M3000, this may
not be the case for all manufacturers. On those platforms, a kernel-
level fix would be necessary, although it could remain as a downstream
patch in OpenWrt if the fix is unsuitable for mainline.

What are your thoughts on this?

Best regards,
Jakub

