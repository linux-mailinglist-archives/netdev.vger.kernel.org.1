Return-Path: <netdev+bounces-289822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GECIHz5uDWrgxAUAu9opvQ
	(envelope-from <netdev+bounces-289822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:18:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78D5898D9
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD86D30D4245
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6B3A6B81;
	Wed, 20 May 2026 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIt2rD2G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513D39BFFC
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264629; cv=none; b=PxG8cq34gSztf6SZOsQ/v25HrqWLHOgmFZrThcWIZ3JkofgH19Bzfaw29AyLYpiDpR0uI6L4B0sOyascejr5p6S33vzNKmdsJS04mxxdKV0IZhEqSMKrQaVJMxQP+rsLcz7zXmEl+NfBEEqKmqSi6RnVMqr9a1cNBaM8vsbkwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264629; c=relaxed/simple;
	bh=ysrlFQYbnqdUZbioXLpDwJFsDqDNBDcsFeVNdyXQbLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFUb8SuuaulIYWmM1aERXOBBUR5uIYYcDFQpLGaTlTA5NCYMtZKzEblSTgzYFF+4/yIT80Ke7tbHC0Lg3gbM0Fz8ILO7LhwHk5SQuDGlrx/s9bGPvs5D7zbXEgvX4n15r3pVHlshvD1aXZCRgSiQQGkDhrlnguXDg52k633aBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIt2rD2G; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bab82d75fdso21714955ad.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264626; x=1779869426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zT9gW4My9WtjCFzxGL2IvZPJb7xvVTH1VSTzTxzzIek=;
        b=lIt2rD2GFOU9KCfnOhLc8kCfVdqHqy897uq07T0pdkItlRh6Zp93x4pdjtYwfLatGa
         cdu2lYEkFpFwMt0KoU8Xs2lOnWL+yBvxReCY3SqJ0ktwORroO+A7dXt58ovVgLVrHW9x
         8EQgFIP+kk1Z1k4n41vvL8q/xtYG0ZbGoYeEU8Eir66fqQPEBNV7b6jRmRv0ttp7kJ4K
         gkW24LiNseka3sr6EI5wQcJMlDXIhtOB3IZXPAyjWdyKVAw0T6iJHsIQd3urOKPnmBX6
         zwYHRpVgIHaADaZLQ5jkQ8X69yNS4CpD0iY3Bw2FH9FN4mumcSQ0qXY3CwJwe+XZB10w
         BXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264626; x=1779869426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT9gW4My9WtjCFzxGL2IvZPJb7xvVTH1VSTzTxzzIek=;
        b=JtN3YCg+SKHEw2FGUC0XRFp/bb42crWNUGQ8haT2l2mzqehyNXWgCMsQSIdHQk+ljo
         0Ja3m7yydxIwF/BwF8SzJLQrRmB0dQUYwX1mAx/FnKSUchCjPsZqQRKW8N48OjA22NMI
         E3aLQdBB4Xln/pfZvC4VrF+VK1xnrBhFZGHQdGVUZh3O9oBqP9lva6v/dkfSuPu3NhKT
         nKuAUd/do0MVicEesaWhTkAoscIDVObILHT+yON04Y7EMsOZwfWgkxwPo8vuypHDJkLL
         tnHqFOLnhy3Ta3shrThXjJTIjFMkbEf4VuB1/gUwtRuWGgGJCn+65hNcxkbinIZYRdYJ
         TiWw==
X-Gm-Message-State: AOJu0Yw2B76FRhr2o5YbNr0A3JT0i4YTbB1FZTp6zskrCPt2v1OKiXrO
	jTqXzua0WybcZ9NdSubJaxUs6LaaIaMdorCZ4D4NwvS+z+L/jCpSlk/3rD1vEUUX
X-Gm-Gg: Acq92OFGPQNo7TRdEyzbULV5c99DmQJrHLB78IzxltqPgUZpd7EMddy3EDfZXnGQP3r
	bi7PQMnMjuN4j+zA152xTWiTSjqocScKO9i33DWC8YVBG6dFTbdEG2U/uQH2Yz8ixV9ez3lP+3K
	8nm+cVNldRLomxLfmEx0U8dG8JdpSFKH0cdIUbgfjqyea70IE8MJiSmRloHkTnbg/32lgiAd1dF
	uCrDLrFr2RWbtM/Ru9MHfYh8zxDkwRqXiOK7zFkZzrfTsdDC8/h/2xB4AKz0PdMLq69/USB1m6i
	c69KrGm1qlTp+vd9HeW+Di6puEBvHY4c83CvF730LUhjrU8IXDlEyVEikgreTBv2Xf01Elbg9ba
	2GlLOQHK6/NMsbTZkDsxdZikYXbXKlRP3wBhaJ2AonrsOsebNLUQlohqL/hMkVbRj6zWzBBnAlW
	Hj1m2hcm82e4ib24v6KmY+
X-Received: by 2002:a17:902:d2cf:b0:2ba:6bd7:8f00 with SMTP id d9443c01a7336-2bd7e78228cmr241655625ad.5.1779264626117;
        Wed, 20 May 2026 01:10:26 -0700 (PDT)
Received: from mincom1 ([14.67.155.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d116287sm211632735ad.68.2026.05.20.01.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:10:25 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH RFC net-next 0/4] bonding: support LAG IPsec offload with replicated SAs
Date: Wed, 20 May 2026 17:10:00 +0900
Message-ID: <20260520081004.2232091-1-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289822-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CA78D5898D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This RFC adds a bonding model for IPsec/XFRM hardware offload on
802.3ad and balance-xor LAG devices when the transmit hash policy is
layer3+4. This is an intentional scope limit rather than a hard limit,
as this is the configuration I can test with my gear.

The main idea is to leave the existing upstream single-lower-device XFRM
offload path for active-backup intentionally untouched, while adding a
replicated state model for LAG.

For LAG bonds, the bonding driver installs the same XFRM state on every
eligible running slave and stores the per-slave hardware handles in
bonding-private state. Lower drivers that support this model can then
resolve the handle for the concrete lower netdev used by the datapath.

LAG IPsec features are user controlled. Newly eligible LAG bonds start
with the ESP/XFRM features disabled, but advertise supported mutable
features when all running eligible slaves can support them. Users can
then opt in with ethtool. Feature enable is propagated to the lower
devices and rolled back if a lower device cannot enable the requested
features.

The series also handles LAG membership and eligibility changes by adding
replicated SAs to newly usable slaves, removing the departing lower
instance on down/remove, and flushing bond-owned XFRM offload state when
the bond leaves the supported mode or hash-policy configuration.

This series does not convert any physical NIC driver. A lower driver
must explicitly opt in to the replicated-upper-device model before it can
use these bond-owned states in its datapath.

For example, a driver such as mlx5 would opt in by marking its
xfrmdev_ops and by resolving datapath handles through the helper:

        static const struct xfrmdev_ops mlx5e_ipsec_xfrmdev_ops = {
                ...
                .xdo_dev_state_lower_handle = NULL,
                .flags = XFRMDEV_OPS_F_LOWER_HANDLE,
        };

        handle = xfrm_dev_state_lower_handle(x, netdev);
        if (!handle)
                goto drop;

        sa_entry = (struct mlx5e_ipsec_sa_entry *)handle;

Jihong Min (4):
  xfrm: add a lower-device offload handle resolver
  bonding: replicate XFRM offload state across LAG slaves
  bonding: expose user-controlled IPsec features for LAG
  bonding: handle replicated IPsec SAs across LAG changes

 drivers/net/bonding/bond_main.c    | 855 ++++++++++++++++++++++++++++-
 drivers/net/bonding/bond_options.c |  59 +-
 include/linux/netdevice.h          |  27 +
 include/net/bonding.h              |  29 +-
 include/net/xfrm.h                 |  48 +-
 net/xfrm/xfrm_state.c              |   1 +
 6 files changed, 1000 insertions(+), 19 deletions(-)


base-commit: 27fa82620cbaa89a7fc11ac3057701d598813e87
-- 
2.53.0

