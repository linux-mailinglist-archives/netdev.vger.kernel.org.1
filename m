Return-Path: <netdev+bounces-106986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C53D59185D5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD4A1F28079
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E91891D7;
	Wed, 26 Jun 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="p+hBzLtq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81671850A9
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415818; cv=none; b=ak63SQ6kYHGrBUqDsrBSOlEHiEUCq0x1gtAgMn5visUwTS2QB89NsuvCDk1cuo23WDwVZGRsrKIf7Zprqhq/4SlLxVZWaXjHiRlMkvlRON7VsBs92mqIcQzPO8Rl9QSx4ZmvqhN9B1ZznW1ES3o1iDhtADmZIzIYbnx9Kqzl5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415818; c=relaxed/simple;
	bh=xe/FD6mTLEema72nl9XWXavOKUI3fVV1PZZrdQ1KhLU=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=hbnqcBrETxw6ndh7tkkx3hxiRAD4EOxCutxjlGt0wgtjVNyKodC0g/bL91B1Fh6RbMfxKywH4jwN7vqiR8EEYcq2XzW6o+l2hISvCCmGgrk+83gJ4h2YkUAN0PJPHRIC/smwzPfgpb0bvnA9zZbE7lzD0AGTzyiw9rAUOCQPEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=p+hBzLtq; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D1B1D3F735
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719415807;
	bh=aBHuU/tGQ2CFNPC+jHwKnPIGUQ6zOJE5Sqjere1apCc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=p+hBzLtq/xQ/+6EAvNG57UvlrTtJRLzqBqk4jl4I3ek6qCdtxvPVkobmouyiaEg7g
	 SvJ+y3PE6qnvh2vsuf6HAWeRtnnwmbzEY6Ee5ohWXpnUId8oecAm++GnhFirD3SRpl
	 0LfLt8ds7GCCzwo08J4nNQNjWVehNtBIyF7cBDFi70FApPKQMLatuLz4jCCmLXMF/f
	 r6jPtS07k8uMRH5A9hrSqLIok1uNBVktwGmEt2xcFxYCePigFwTtrFjKIPHk+DlHGh
	 gI4pEGTb+rAoV3iSz8OTKET2h0EpfIwXIUXmZ2H/McYK+xK1WLqHum8u8YB7g75W7S
	 f4ziTT2j/+d+A==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-72492056db7so666525a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 08:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719415806; x=1720020606;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBHuU/tGQ2CFNPC+jHwKnPIGUQ6zOJE5Sqjere1apCc=;
        b=YUZY/6yX2XU1yEd7y0kq5Q14tA1tl6AsEJMibRNi3hHmwM/TbXd2dETpjRXGvIBOxM
         a434TGolGiDD3cpb9QCWFxO8VBMZMO88P6NO1lqpJCmS4dGYcY+Snfr7Tv1E6IixBkUa
         0HrGt13zkGAlqksKMu8gzMTxyBJu7aoRdsIIMD2MsYhQpZReX0jxCNYXu3UBz98dKjzw
         L7CvThJ1zwXmkoeFM8De9fdo511sf7LVu9qCVo7MuZmWfWgF/hdeaD0zox6Y7OV0ekwA
         85RVXpS42nRA7jSgEpO7SYNXrGIzHyADp361kPAymg+hrW4Q/Ovjq2AnrEXkQZ4bZmq2
         ooHQ==
X-Gm-Message-State: AOJu0YygKkjO1fAE2r9EMLRLJ79F6fWRzfQiuP2u6DHkteplbechFmcv
	n6uQJ+KXFTAF1Ep6EuIvOQAEWFSlyurn4xQKfmtWIiO1CW25033k425fkT1y5oemdtiA1rO0Xtd
	x/cIWpAkLm8FmBY2WoBGQIW2jN6p4gsdEkiErKv5jUCXqGDtf7ZjcP8FGQsf3Iaj0+19qTA==
X-Received: by 2002:a17:902:74c5:b0:1f9:8cd9:96c9 with SMTP id d9443c01a7336-1fa1d665fe2mr99295155ad.46.1719415806197;
        Wed, 26 Jun 2024 08:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPfyq0ODbnU9+fcHGNxqFkQ7knQoZTeHKcIqMBr5tSLfpfQWly0E9/GMyxTfMSSqCHX2+5xQ==
X-Received: by 2002:a17:902:74c5:b0:1f9:8cd9:96c9 with SMTP id d9443c01a7336-1fa1d665fe2mr99294815ad.46.1719415805603;
        Wed, 26 Jun 2024 08:30:05 -0700 (PDT)
Received: from famine.localdomain ([50.35.97.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa3d6a5b3asm58561905ad.212.2024.06.26.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:30:05 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id A5CED9FC97; Wed, 26 Jun 2024 08:30:04 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id A2E199FC01;
	Wed, 26 Jun 2024 08:30:04 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
    Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>,
    Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
In-reply-to: <20240626075156.2565966-1-liuhangbin@gmail.com>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 26 Jun 2024 15:51:56 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1413992.1719415804.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Jun 2024 08:30:04 -0700
Message-ID: <1413993.1719415804@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Currently, administrators need to retrieve LACP mux state changes from
>the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
>this process, let's send the ifinfo notification whenever the mux state
>changes. This will enable users to directly access and monitor this
>information using the ip monitor command.
>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
>v3: forgot to use GFP_ATOMIC. (Nikolay Aleksandrov)
>    export symbol for rtmsg_ifinfo. It's weird that my build succeed with
>    tools/testing/selftests/drivers/net/bonding/config without export
>    the symbol, but build failed with tools/testing/selftests/net/config.

	I would hazard to guess that bonding/config works without export
because it has

CONFIG_BONDING=3Dy

	which builds bonding into the main image (not as a module),
which wouldn't need the EXPORT_SYMBOL.

	I think the change is fine, the only question is whether it's
better to have a wrapper for rtmsg_ifinfo() in net/core/dev.c (where all
current callers are).  I don't see a particular need, but others might
want some consistency.

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J


>v2: don't use call_netdevice_notifiers as it will case sleeping in atomic
>    context (Nikolay Aleksandrov)
>
>After this patch, we can see the following info with `ip -d monitor link`
>
>7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqu=
eue master bond0 state UP group default
>    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promi=
scuity 0 allmulti 0 minmtu 68 maxmtu 65535
>    veth
>    bond_slave state BACKUP mii_status UP ... ad_aggregator_id 1 ad_actor=
_oper_port_state 143 ad_actor_oper_port_state_str <active,short_timeout,ag=
gregating,in_sync,expired> ad_partner_oper_port_state 55 ad_partner_oper_p=
ort_state_str <active,short_timeout,aggregating,collecting,distributing> .=
..
>7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqu=
eue master bond0 state UP group default
>    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promi=
scuity 0 allmulti 0 minmtu 68 maxmtu 65535
>    veth
>    bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor=
_oper_port_state 79 ad_actor_oper_port_state_str <active,short_timeout,agg=
regating,in_sync,defaulted> ad_partner_oper_port_state 1 ad_partner_oper_p=
ort_state_str <active> ...
>7: veth1@if6: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqu=
eue master bond0 state UP group default
>    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff link-netns b promi=
scuity 0 allmulti 0 minmtu 68 maxmtu 65535
>    veth
>    bond_slave state ACTIVE mii_status UP ... ad_aggregator_id 1 ad_actor=
_oper_port_state 63 ad_actor_oper_port_state_str <active,short_timeout,agg=
regating,in_sync,collecting,distributing> ad_partner_oper_port_state 63 ad=
_partner_oper_port_state_str <active,short_timeout,aggregating,in_sync,col=
lecting,distributing> ...
>---
> drivers/net/bonding/bond_3ad.c | 3 +++
> net/core/rtnetlink.c           | 1 +
> 2 files changed, 4 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index c6807e473ab7..b57c5670b31a 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -11,6 +11,7 @@
> #include <linux/etherdevice.h>
> #include <linux/if_bonding.h>
> #include <linux/pkt_sched.h>
>+#include <linux/rtnetlink.h>
> #include <net/net_namespace.h>
> #include <net/bonding.h>
> #include <net/bond_3ad.h>
>@@ -1185,6 +1186,8 @@ static void ad_mux_machine(struct port *port, bool =
*update_slave_arr)
> 		default:
> 			break;
> 		}
>+
>+		rtmsg_ifinfo(RTM_NEWLINK, port->slave->dev, 0, GFP_ATOMIC, 0, NULL);
> 	}
> }
> =

>diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>index eabfc8290f5e..4507bb8d5264 100644
>--- a/net/core/rtnetlink.c
>+++ b/net/core/rtnetlink.c
>@@ -4116,6 +4116,7 @@ void rtmsg_ifinfo(int type, struct net_device *dev,=
 unsigned int change,
> 	rtmsg_ifinfo_event(type, dev, change, rtnl_get_event(0), flags,
> 			   NULL, 0, portid, nlh);
> }
>+EXPORT_SYMBOL(rtmsg_ifinfo);
> =

> void rtmsg_ifinfo_newnet(int type, struct net_device *dev, unsigned int =
change,
> 			 gfp_t flags, int *new_nsid, int new_ifindex)
>-- =

>2.45.0
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

