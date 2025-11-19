Return-Path: <netdev+bounces-240085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A98C2C70684
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F14FED40
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD72D349B1E;
	Wed, 19 Nov 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Nd+1lxY8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15325341068
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571108; cv=none; b=hwKNDlPXqch2IxB7vGBiSrne9bZcnYfJk3Y5q520oq3dJnCzA8XUgctetcZBgD2z72gC2H2g1y+XZtcxydDYqQVyuYCXrCtDQKwmHCxe7fm0PT08xJL29PQYhdPk6rQVfiwfZSe1lFSk8Ayo29aQM13fMXae8W9GASA+++05zv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571108; c=relaxed/simple;
	bh=9N1sUiO5CeMoefLRcd5UKkK7JgP2YFmRoYgJ+RGvCRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIZointjzsDrvI0lcrES/Q5nsz7ASYpZ48Etuw70L1paknbTSw+WMfNidPohUXOGj3Pqn9q4aDMr0IWHzw4gRlmu9hxbDp9xpnckbq4xCJ+B6kVsOe3WjYq0XCLaKWRVZV2buKN1LBXRIBtlZkJ0ns8TuzcA6G6S2O5YACP5ouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Nd+1lxY8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b73669bdcd2so983899266b.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763571104; x=1764175904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ReEEmWGIWZkShqG3AnUB9jXISOu1RTm6ECnZ2pbpzpw=;
        b=Nd+1lxY8OgTExDhvN+oo/YPRvsPSam8CMhGwDCKENbvifRlEm4ARLXvWtKSWsuPj4Q
         Cpl4WPypDK6+1nYSE2jLbwU/0kFJ7HpevVSMcJbCl53eM/KqWtRi2J0TFSMEcC+oL4OT
         FJoHLkkMYQpopIwZzR0mtOMQzTz7XE/NWvW9buimMPJybmJj7pQeyzF4Xx4Mlf3bz0uC
         xtxnajPQ1RlYgM/jANt7KvhjIKPCdvd08z8m40KbcYnC4AYUuACYBNlo1LbxQZjLz4nY
         DCDnmHX1g9WG8f/wPhn8nAiawQblm0aoNhCJ2G8523orPB2ixcBqS5r1rSDPGH2f8uny
         HQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571104; x=1764175904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReEEmWGIWZkShqG3AnUB9jXISOu1RTm6ECnZ2pbpzpw=;
        b=SGByxbQwhG6WNp0IesizT+Wkhcnawr/JL1kEC55T4BoFVHQuUdEtLQ6up2FQaltr4l
         EcYLTJ6GwiU0Yxo1LKn8ubuI0V+DZbrALGC/ZDzjm8ZyaCNI7snR+XwmTPWxR1YLD5BS
         w+8ofSSk2fFQufGXuaXHRF1Cz5wjR3EoSsH5EOIo3JBgaNtxQOYAEF4RvK/ZbewIE125
         6SHhvjRYwthCV5NEvt2H1OzSE0qJwKwCmP2JB26c42QNM5606jC2tgUWZBjS29TV/3/i
         +OdGpgOJW8aLSb05y4xiISNQHKL5NdQ/58S3ThH8raT4Gj8SbVAabhgO25nze0qXRL+u
         nhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5pth/3pvsN+tpdNfWx2k9pK1TSFO1sodxCHN/ASR/XQlhTS0/shEh1YWOrRQr1+Cyt6vVopo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBcSnzIwK1YwkcAfDZrlMyqOseIYpD29VVJVvbczT15bswa7d
	3ULZvMs5S2enmzr7aY1NwS4xgdKOznIl7uWqSmtbOCtpbQnHHjPqzPhlOesNPq+UAEc=
X-Gm-Gg: ASbGncuizsQ/RyfJdIOwLDhWtkbz3TcNpWXlzsrfFgmGNIl49eh7TpCkn+F3WRz+0Zp
	21Kty9JI20a0TnUn2AWkcg2jj8xYSoICMDL9vOFKjcW+lRQFPusJVPb+/FsYdYmHRCWY1iFAkAf
	8y6jl2Qwknpko2dg5D9D1sv3ZWiUTIWnSHOUOB7IQzcouiZ24i15MvFWM93ikp/QYIMNoQ9D4Sy
	Z12G0GCPeHNMbNC/vO0cuF9TwWTwG2FGgv17Zqd/xzP62Oa504r97TQSbpA+ttj1n0bdWU3eW+3
	aIFroiXOw7Idg1qYJeLvNM/UTFVLG95XNKp573NCmcn+XFDMaXGNoJunMWyhT11uu99vBHmTp3+
	D0uK44sTbiQ2vpUAnnkRPO47qAUOJzSwiQTbxMVR1aDlma+rKJkTOnK2E5xZSQPD3gTtwX9DERA
	RTXU4NJ5tVGG8K3e1BkH3u5kMCfvy+qekQ5A==
X-Google-Smtp-Source: AGHT+IEzLMBCDRHwKO55KVT8oJ8QExhciJCThHZS9S9CuM3yQ83u3ZpN76rvKWx3vuw9CcSdP1Sv/g==
X-Received: by 2002:a17:907:3c90:b0:b73:4006:1883 with SMTP id a640c23a62f3a-b7367b8d6d5mr2014953066b.30.1763571104042;
        Wed, 19 Nov 2025 08:51:44 -0800 (PST)
Received: from FV6GYCPJ69 ([213.195.231.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fb12c87sm1643091266b.31.2025.11.19.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:51:43 -0800 (PST)
Date: Wed, 19 Nov 2025 17:51:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] team: Move team device type change at the end of
 team_port_add
Message-ID: <gbashnabbmnsqwwno5rc4piiwkluriytfcnvfdejn4abwovfkl@furcaobquk5t>
References: <20251113211142.245216-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113211142.245216-1-zlatistiv@gmail.com>

Thu, Nov 13, 2025 at 10:11:42PM +0100, zlatistiv@gmail.com wrote:
>Attempting to add a port device that is already up will expectedly fail,
>but not before modifying the team device header_ops.
>
>In the case of the syzbot reproducer the gre0 device is
>already in state UP when it attempts to add it as a
>port device of team0, this fails but before that
>header_ops->create of team0 is changed from eth_header to ipgre_header
>in the call to team_dev_type_check_change.
>
>Later when we end up in ipgre_header() struct *ip_tunnel points to nonsense
>as the private data of the device still holds a struct team.
>
>Example sequence of iproute commands to reproduce the hang/BUG():
>ip link add dev team0 type team
>ip link add dev gre0 type gre
>ip link set dev gre0 up
>ip link set dev gre0 master team0
>ip link set dev team0 up
>ping -I team0 1.1.1.1
>
>Move team_dev_type_check_change down where all other checks have passed
>as it changes the dev type with no way to restore it in case
>one of the checks that follow it fail.
>
>Also make sure to preserve the origial mtu assignment:
>  - If port_dev is not the same type as dev, dev takes mtu from port_dev
>  - If port_dev is the same type as dev, port_dev takes mtu from dev
>
>Testing:
>  - team device driver in-tree selftests
>  - Add/remove various devices as slaves of team device
>  - syzbot
>
>Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
>Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
>---
>Changes since v1:
>  - Add a "Fixes" tag
>  - Add a simple reproducer in the commit log
>  https://lore.kernel.org/netdev/20251111171341.4c6d69be@kernel.org/T/#u
>
> drivers/net/team/team_core.c | 19 +++++++++++--------
> 1 file changed, 11 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
>index 29dc04c299a3..94c149e89231 100644
>--- a/drivers/net/team/team_core.c
>+++ b/drivers/net/team/team_core.c
>@@ -1134,10 +1134,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
> 		return -EPERM;
> 	}
> 
>-	err = team_dev_type_check_change(dev, port_dev);
>-	if (err)
>-		return err;
>-
> 	if (port_dev->flags & IFF_UP) {
> 		NL_SET_ERR_MSG(extack, "Device is up. Set it down before adding it as a team port");
> 		netdev_err(dev, "Device %s is up. Set it down before adding it as a team port\n",
>@@ -1155,10 +1151,12 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
> 	INIT_LIST_HEAD(&port->qom_list);
> 
> 	port->orig.mtu = port_dev->mtu;
>-	err = dev_set_mtu(port_dev, dev->mtu);
>-	if (err) {
>-		netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
>-		goto err_set_mtu;
>+	if (dev->type == port_dev->type) {
>+		err = dev_set_mtu(port_dev, dev->mtu);

I'm probably missing something. Why you made this conditional? Didn't
find mentioning that in patch description.



>+		if (err) {
>+			netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
>+			goto err_set_mtu;
>+		}
> 	}
> 
> 	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
>@@ -1233,6 +1231,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
> 		}
> 	}
> 
>+	err = team_dev_type_check_change(dev, port_dev);
>+	if (err)
>+		goto err_set_dev_type;
>+
> 	if (dev->flags & IFF_UP) {
> 		netif_addr_lock_bh(dev);
> 		dev_uc_sync_multiple(port_dev, dev);
>@@ -1251,6 +1253,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
> 
> 	return 0;
> 
>+err_set_dev_type:
> err_set_slave_promisc:
> 	__team_option_inst_del_port(team, port);
> 
>-- 
>2.51.0
>

