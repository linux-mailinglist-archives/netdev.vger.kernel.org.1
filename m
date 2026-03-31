Return-Path: <netdev+bounces-273773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHDDDV1SzGmvSQYAu9opvQ
	(envelope-from <netdev+bounces-273773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:01:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5C372901
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 521FF3088E9C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0016466B55;
	Tue, 31 Mar 2026 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS0bsAtE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD4D2DAFBB
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998015; cv=none; b=sa1eKzIY82yGerPn1vA3a3H1JHde6qHLfC8gyrdeXc16JdvUt+8sR6teNNQgol6MepJDfBNWGZIn3wm5TjHww7frBDAcy5UaA9QMdi20AZTEejogY84fifMtcu3gFhmrXfnneKLOAbWmBNBdsn7EQRnZ8NVYZnqMLhAHKP57yLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998015; c=relaxed/simple;
	bh=R65JAFCuMJFnnOQhQ5m+EHIjY3PAjmzzK6UcokIsStM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NR4NILI8AqEdZyl/XF8m2/5GZ4VkUYY8CElcw8u8d1Vl3sa8vbaut3ylmw+oYrnPGtmXEu88yL3r0b0Gy+Yr4DtmvqLnr7HoCLqBxSQYLrZqx/fKtr6n7KYs8YUMP3A2bLSLPPJ9UlDRjNsJG2BYhFBhT5BBOOuegVmDnmgsXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS0bsAtE; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56d89f35940so192017e0c.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998012; x=1775602812; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxovtYuwJ5SxpZyIKT+DbdxI5h9E+Y8aJ9AYcOp9UfM=;
        b=lS0bsAtEwhWmUb+oyVYtNbC315rb2wzQX9tNcaNB5ohVGUx/53H5sJ/fRO4CmogEd1
         iwCaWrgwCW2p0ShF0RIEbF7FlAj166UD4315UrZXFKNaofhVQ3SiShyS3phO6CXjIlco
         l26NxMHvi49UTUUgePwPpXQGEIKdeo7QC/Rt070E7rWhCMLCxnTgNXn+iNUvvIMJVxT5
         5VVVA3XQJqIMKlHKe8EcyjaW02V9IvPVbzwDcev9+VXTFGElvm3dkJWSCnbgj+I0H3w+
         fDwt97st8zjaFm1cvJPBRuRqqdjTNHEBu7lopzqhrhbAxrsIaxerAG1dSR4D+EIZk0gn
         sVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998012; x=1775602812;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxovtYuwJ5SxpZyIKT+DbdxI5h9E+Y8aJ9AYcOp9UfM=;
        b=XIYn7NfU6NNzsO9P5/t+/AasrkOzesk9YP3QIxVyjPP/qvtwCaMgEzkTTQRTGBikzV
         IvEr5xpAKckL+YriuaJiDV45LxZebiq1OBwPM5B4YypD3x6BRWhoaYeCWm9n63oS10OS
         NC5aj4HzMqNyIroIMLbSyJrE5KFrkYYy9rSUQCj6jgEe7IedaibfLyyN8sn1BOtMofj7
         RQOOFPf8Qx9hGgEV31nYmBCATxhZebQ6HcewcKfT+Zx6OZ93cUP8qZjUy0d7sqeiSh1m
         t7HJ3xPvs73eLXQIA40rv64lN7YXNP8hzLeBzC0yFwslenbM9ZYvKlyUwSuTuHNEhC0p
         aOAg==
X-Gm-Message-State: AOJu0Yy8YOOyLZ4KK4QvnKTeVBRLjkDUayfZUtqKD9TYY+6lm/6Mw/Un
	8lM4Dq1HFe9RKuGnYNnGhmgLdl5AyIymgRlRcwo+PD5/3spomPq8l3wg
X-Gm-Gg: ATEYQzxt7GsVmh9QxA9UDllHiWIFkhVCyd5MFQtdqEdCjCgm+Ze9MJAB5Og299sAUvA
	a61QZSRpFlZ97CMSF/kWgd2mTLh43wZw39n+UeHHpBful0q2KbyAACqPU+W7L6K3Fh7iOjSW+Vg
	xb8JVhegN99iGJTK8U0tdhIDoTJZ2Z3x0B8e272h2ArinzYV7pXSrhMLGJOBYCH12T2HI28T0Pk
	em0CeT+WhUKZ3HM2kacyQMeB8yXluJcsBdTTlNWejor2WEDT0v8eY7H+oY5uzr2d6msoPeeHNn/
	J4YKylu+ZbSehoWpmelJWyGZxQC1mRpgGgE0w5Pv/us2wWUD6g1uMo4rq4Xao+5wT8qC77biW7Q
	OSn9mvYmUOsjjLkUS0F1FJ2uB5ehiLyoiqz+IUIx4XYweItd8ohN9SCMg/scQRduKfCJU2FSCmR
	8EZ/sSJ694Quz84bud81mBwvrllB2JF61lDIRvhQ==
X-Received: by 2002:a05:6122:e22d:b0:566:341b:4dde with SMTP id 71dfb90a1353d-56d8a657efdmr725955e0c.0.1774998012202;
        Tue, 31 Mar 2026 16:00:12 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm13948214e0c.17.2026.03.31.16.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:00:10 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH 00/10] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Tue, 31 Mar 2026 20:00:00 -0300
Message-Id: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPBRzGkC/x3MQQqDMBBG4avIrA1oUiJ4lVJkGn91sMQyCSqId
 2/o8lu8d1GCChL11UWKXZJssaCtKwoLxxlGxmKyjfWNs84o+JOxDtOmB+to2jcHx10XvH9Qqb6
 KSc7/8UkR2UScmV73/QNFUiD1awAAAA==
X-Change-ID: 20260323-realtek_forward-1bac3a77c664
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,rasmusvillemoes.dk:email,lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: A9B5C372901
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series introduces bridge offloading, FDB management, and VLAN support
for the Realtek rtl8365mb DSA switch driver. The primary goal is to
enable hardware frame forwarding between bridge ports, reducing CPU
overhead and providing advanced features like VLAN and FDB isolation.

Some of these patches are based on original work by Alvin Šipraga, 
subsequently adapted and updated for the current net-next state.

---
I attempted to reach Alvin for review of the final version but was
unable to establish contact. Any regressions in this version are my
responsibility.

Patch 04 introduces FIELD_WIDTH() in include/linux/bitfield.h. Although
not strictly part of the driver itself, it is required by subsequent
patches. I am happy to split this into a separate submission if
preferred.

To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Linus Walleij <linusw@kernel.org>
To: Alvin Šipraga <alsi@bang-olufsen.dk>
To: Yury Norov <yury.norov@gmail.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

---
Alvin Šipraga (8):
      net: dsa: tag_rtl8_4: update format description
      net: dsa: realtek: rtl8365mb: set STP state to disabled early
      net: dsa: realtek: rtl8365mb: prepare for multiple source files
      net: dsa: realtek: rtl8365mb: add table lookup interface
      net: dsa: realtek: rtl8365mb: add VLAN support
      net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
      net: dsa: realtek: rtl8365mb: add FDB support
      net: dsa: realtek: rtl8365mb: add bridge port flags

Luiz Angelo Daros de Luca (2):
      bitfield.h: add FIELD_WIDTH()
      net: dsa: tag_rtl8_4: set KEEP flag

 drivers/net/dsa/realtek/Makefile                   |   4 +
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 465 ++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  59 ++
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 711 +++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 255 +++++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 133 ++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 805 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  30 +
 include/linux/bitfield.h                           |  13 +
 net/dsa/tag_rtl8_4.c                               |  21 +-
 10 files changed, 2481 insertions(+), 15 deletions(-)
---
base-commit: 1a8dd88469bf742fd5eda91cd8e0f720a983ec5a
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


