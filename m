Return-Path: <netdev+bounces-290420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Is2DzQKD2oHEgYAu9opvQ
	(envelope-from <netdev+bounces-290420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:35:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B1C5A5FEE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D77E3136603
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7E63E5561;
	Thu, 21 May 2026 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmofE2sK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4993DA7D3
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368762; cv=none; b=TNRhbRwb0ZujBNrzZcJlUXUZPFXoDNJjdRRouoT8gcyyknHGVrz9xe9bkr9nuymYLAxLDlVLy0E7bxMe7LWNoEtFp6Mf1Lk/ObZez5dkveR6sdbdF9WqXvmmcrkHEyV0r5NFz5Bn7wIbLdOtQKlu6R26w4f3br98bTcQYx0p/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368762; c=relaxed/simple;
	bh=hqKiK8juCbX/72r301i/Aho+LcG34a9WwFp2trnFGUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yya3ZX1I1bUcCoj0IQta+Rmro/WT6MpHhMzMtpHKL1xygKlokYVcDMeGD5nh2sUdMy9TzZaJs32FXDIeQVyUDzrYTmPteiN4yI9SOaTuXILJrcTrOL9fuJyGF8XQ0gMNrRSBp4gWJj6pu1K7RiVsg4DDXbzfKXf4WGBz5OsaLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmofE2sK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8367df48711so2624558b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368761; x=1779973561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7BA6oMBZIOnaYJGcA6PYPSFSAoPLy1EkjtV5+/qOxqk=;
        b=XmofE2sK9jS0l4e2Hu7o2ckyacrOa76T9z5cjA1D93kOVIvj6G2Y5QUT4Va0oGbPo1
         HQiOKNtV6nNmlBGr1da1lB27xT0lPhXo6c98VNxq0/VA+1tafS+ssIDfbrf+g1hFYfQH
         c8cirSgKYamaUorTK+u5vavJ9CX9IH2JLderYXKCNGNcGQJSFirx3xgoAwOI2YBti3tH
         EHL4hFLxOCWJwFMddUuK7YT8qq+iz0y6yTxlaNLSJSmiN20dYuOu2t3odgSUudvW8R52
         qL7jnqfLGUNJnMOceqlnQrcofBpEaYU3gew5Nx9ivl/gg38C0tLzmuhHwux05TwrofAW
         +fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368761; x=1779973561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BA6oMBZIOnaYJGcA6PYPSFSAoPLy1EkjtV5+/qOxqk=;
        b=BLDyVmCHr2MMUdAqd31xZv4o5Eb79u413NPdLqvnMIkoKVAVaLTWsUjI//xL8YVxpX
         zz81Ovh/1xOkjo4+vL7Fj0nGNVwZXDR0v1nblDo0YVstE48wGHRu206ftccSIDFPd+9F
         hMOksNUaq2LDxd8P+sRg9zU2jZGxI22QeF8DS+DOi2fT28LEUWcP+p0xvTT0yNzACv+0
         wQ4qLpipnDTY03NRm+XtZ7q/9hHv7wjRLH5OyJC/DgYqbURUGsAMkzqF5C3UbsnniNnr
         ALXh/P3/huft8y0PHPucFKHklHKY0lSQcTwwu6bfRHloVwrt7x4J2MYx9Fav+R7eDM4O
         F27A==
X-Forwarded-Encrypted: i=1; AFNElJ/r6bfa6VRMwKLZ0qm6eYQuOeyvGpg796zxmJvizRupJHAQ3ZulZaZsbWKHEi8uLkQ5+YDGXec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3Dn7i09rxENrJRJNMMY5ba7ITxqrbIk4Gr5a6Z2AwPFgD1Ns
	Q2JoG4XL9tx4ZWz7N/FrqacCGld+jySfaGrXSJvZgmZ3g92rAfLfOU58
X-Gm-Gg: Acq92OHaH/TGx2zr7HhlFq0k5NGQj/Yq6ukwEaUYfbONTpnoekZlKRjRDFObxCXqNIK
	s4vnnAjtcf48UZ+2vHPxLyCjQsGjU/9fsE7CQ33tbpqVxcYTOUYeXJtXuUaL0z+/PvKVnSyHh4Z
	q10KZckEl49NvBubDMxMlRTT29JteiF6NacAc7PL4BKCKJK4lwKbYO61euI1eB4dtrMFgUSot7A
	CBhsIPrTYzPYlJig/Sp9Zt+8Y/DnbZZNS2P+4EVI/UCPa3SAOag8iBHCZavHTMFPbzsg0IfFFmI
	z2N5gjaDE2Tm9w88RLoS+7M8m1W3sP5aMyCecryKPNUHDx7b4PkiowEThW14YD26EQyXS3huDGA
	qOJ4WjF2AGKmVv6X7rV3Mw39WAtUgybdCeVbBaVsb2E2d2QPEdyyIElBkHa86GivSISHR4UBlki
	8809TugStKe0cpcM8LNpu3Np6u2bTEcThp7Qa2boLTL0Oj2eob
X-Received: by 2002:a05:6a00:4392:b0:83c:928:6e5a with SMTP id d2e1a72fcca58-8414acdc882mr3105878b3a.13.1779368760666;
        Thu, 21 May 2026 06:06:00 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549be20fsm1693993b3a.12.2026.05.21.06.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:06:00 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 0/2] ip6_vti: vti6_changelink and vti6_siocdevprivate netns fixes
Date: Thu, 21 May 2026 21:05:53 +0800
Message-Id: <20260521130555.3421684-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290420-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,secunet.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Queue-Id: 46B1C5A5FEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3 -> v4

 - Update Fixes tag on both patches to commit 61220ab34948
   ("vti6: Enable namespace changing"). Xiao noted the old tag
   5e72ce3e3980 is not the introducing commit. dev_net(dev) and
   t->net first diverge when 61220ab34948 dropped
   NETIF_F_NETNS_LOCAL and made vti6 devices movable through
   IFLA_NET_NS_FD. Same Fixes shape Jakub took for the sibling
   fix 1d324c2f43f7.

 - 2/2 adds ns_capable(self->net->user_ns, CAP_NET_ADMIN) inside
   the non fallback SIOCCHGTUNNEL branch. The check at the top
   of the case is against dev_net(dev)->user_ns only. A caller
   in the migrated netns can pick params absent from self->net,
   the lookup returns NULL, t becomes self, and vti6_update()
   inserts the device into self->net's hash. v3 did not close
   that path.

1/2 carries forward Eric Dumazet's Reviewed-by. Only the Fixes
tag changes there. 2/2 changes the Fixes tag and adds the
ns_capable hunk.

Kuniyuki Iwashima (1):
  ip6: vti: Use ip6_tnl.net in vti6_changelink().

Maoyi Xie (1):
  ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().

 net/ipv6/ip6_vti.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--
2.34.1

