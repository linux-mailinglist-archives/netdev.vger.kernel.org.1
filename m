Return-Path: <netdev+bounces-306167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VZ/zIWx5T2rhhgIAu9opvQ
	(envelope-from <netdev+bounces-306167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:35:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 835EF72FADC
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:35:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=a1tQ9V74;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306167-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306167-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4357F305D10A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722E40BCD5;
	Thu,  9 Jul 2026 10:13:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC63409635
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 10:13:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592021; cv=none; b=ncBYFzInjTD/P4p+TR6dIpKoBOPCuVU0D7xCSQwWhv2jCBqTLwdTgjHKS3xyGPTBFXpZrqxsNopFis4BaT68H5LKDCodQ5EioOmzUhQdAx8EMgyMGGrSSv9TPutSY84WS5yr7zERwXdMBGGRCJSCcOkeUHNIqDzEZwahGM4fivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592021; c=relaxed/simple;
	bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUzwwkhm78xmq+l6/sdIg9JVYWrgOdjaohRdXZU+bfuZPOsQsa4cK0AuXY+GY4tW9AxABAA31YNoN9aNEqbXWxltgCpdnUh7HmBdED0qr8f0QKnC2rQGPcI128698hPanKoSXIyESCQ1yxecFZ08Q6KaN5h+c26rOHJYtN6Ltt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1tQ9V74; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381065a7a03so1170394a91.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783592019; x=1784196819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
        b=a1tQ9V74DAsM5NBDHGa2IFBd6HkM2fDLdkXmM1gSeVz7Pd3B7GPOvmIuPzneR4R70I
         1vkjaGVHGrUpho4k840zDoL5UKT1F6CQn3ztONvHaKoBGmqoq8zV0RFLoLJgdhj74sBH
         iLF2PfOdMKEoKrfOigOWORRhaZqxORbcO/AwaQwBEU+ZTtMo8wl9Im6pt86qBkFfnnvG
         jnQkYwqEozQ8D8iZ7Fc7AQVhD4PO/G7sIAEyj7MU9+hVkal1AJQ1zBIy3bpcaz3QbFx3
         woJ2D5ndDgOwcIDnrlHYUeQIMCr/96eXoFbnqYkCR62Tkw8FT8GMmJr2Lbq+DG9LuIO8
         V52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592019; x=1784196819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQmBxphDa1xFrmI6W+JXkKRcOnX9uJkuJ+MRhIqYj0o=;
        b=P1BQNMuWYEx30jciKTZv1vmVDKTP2NFBVhHAyiuiyyedrwSg3lUuYMWzf10BZKBe97
         6rTgldL0JgU7l0DkXrNek53PiZdDIctn9ODAdtkOepmEZlmIDQcG7ORMjJj6v+DKlKaE
         TVz2j8+4vfNW/RluPt+27GQ5LylIZx9SZ9ZxMNoeZprDIBtfpkUGPoBAWHb8Nf+XrfXa
         F3VEEvqK5HS3OsCv+yabvcbAo0kKngIed8AA9/iUj0/wtXD7JSYVLIO2KM9NUpVjOaJw
         YYzQ8wEo2CmiCN9OKRe3n1rdAgVGw/UVOjbu4D2o5QC9yVaDM07UreFHGLdUQP2FgOcO
         jimQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfVF1xU+dAhTC44yulQFE0JD8XQJSMyeVZwBjucPptwNxmcYsuhVRXdHwfbkezL66/+cJ/Uec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtescYSwdvqUKBlUBNLGbQY9qrcmzFsZt4QzstSWASTSdoUKXO
	/ZrBuvxPrzLoLmdITFhaRsCadRVsULpeEKN8k76r0+nL3UX/4JXpWjyS
X-Gm-Gg: AfdE7cmEKqayq5NWno2l2Q2hrlDaC6C/hIgUdaCjWxckurKP3ToJtS/UgmSDGggI5OD
	0lKpaossf2Kv92/PPhSchY1X4KeM6c2m9moCZdayUoWDalDC5MXV3dBT1RTgewckDpcywVeaphW
	sDksYYVw8Tc5Uy4RGAEACVCHTA5SDGMYFIEFn9s2bop3ZntaCrJhkd5zO2oPTd/3kQJPn5fUjWw
	BBvvmd7K1nBx6g83wnL9gi7gSDUwgF8KcyNz7NriPrrMnpAHy2sL6CeJZqljofokgLVwsMXrSfO
	EhN+NDzdkLPr0JOhs6lak5nmOHohAe1ukVYc+uyBF/JmDbrPXD1CBOUWVu2n94sVBgXlf92zGGq
	/A3ABCF31unl8p9nXTR0pGKh3JTwwEtp75S589bcmIDQTwhqkXM0nloIj3l8RAMgiGjPG4bRj7T
	wWvlnvfe7vKOaUGSAYG35NFpg2+AJ2J/KlRdNItg==
X-Received: by 2002:a17:90b:3849:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-389402490c1mr6834337a91.10.1783592018896;
        Thu, 09 Jul 2026 03:13:38 -0700 (PDT)
Received: from DESKTOP-82PPU4A.www.groyaloy.local ([202.8.116.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm32071423eec.31.2026.07.09.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:13:38 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: Linux Stable <stable@vger.kernel.org>,
	Greg KH <greg@kroah.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Please backport bridge multicast exponential field encoding fix series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
Date: Thu,  9 Jul 2026 10:13:27 +0000
Message-ID: <20260709101327.9508-1-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306167-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:greg@kroah.com,m:gregkh@linuxfoundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 835EF72FADC

Hi Greg,

Please consider backporting the following bridge multicast fix series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.

726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation")
12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
e51560f4220a ("ipv6: mld: encode multicast exponential fields")
529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding tests")

This series was merged via: db314398f618 ("net: bridge: mcast: support
exponential field encoding")

I checked that the above upstream commits cherry-picked cleanly onto the following stable branches:

linux-7.0.y
linux-6.18.y
linux-6.12.y
linux-6.6.y
linux-6.1.y

Thanks,
Ujjal

