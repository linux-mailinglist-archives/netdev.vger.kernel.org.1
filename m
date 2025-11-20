Return-Path: <netdev+bounces-240373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203AC73E90
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id BE7C62A730
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D3E330D4C;
	Thu, 20 Nov 2025 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1CMpzoz0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA832D4B40
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640759; cv=none; b=RfTOGrC52JwFON0jfgN3yV2gyq1MfZMM2co/QRvqAxRzqsPbZwVGq9ofJN0fmTMlxHkwXOulZynvX6GeRRtUXCamJloh27/twE6SfOJsI+vJbWIwkVrVeuR9fjF6VtBC6Fg+A6JFavaxsE90nl/HEpIaiJ7FryWwDnmMCYSez0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640759; c=relaxed/simple;
	bh=BRyQWGJjMOz8YXDkOmuCC5ztvh9GiLQSmG54+91Ic0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmbeIp57eIDSOqXqGgCdURN1eqH1aYdiaC4AMS2m5pvT1ckX3Zjc+SvXQO+T87P224SNrWH81G0JMjWQhRTNx9ZsxLrJgjYTmxG+hqpZWKQMIRlvhLQBBbxspKuewjZ3h8kgezUMm0YjlHWTO8wpZARz8yjVOf6IzxF2r57Ld9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1CMpzoz0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso1079840a12.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763640755; x=1764245555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=igQkL0hwJSy+45hU8sboipK524syNZD4LXwpNdIPlK4=;
        b=1CMpzoz0n428zsu3dcf26UxAG35NAH1mBuYIFuFjq9KWMIOoUg8UuiTk+WstJjxLIv
         vduNK29VG1b4GHhOHpIHcTo8mLPX3nKEFJMIR2tA2IARECm9GLfSqgq/92iaKZ4BySPB
         MKXvzaeKSZheB4FEX0J2EIqDAvD4Du92xUiBXu5HNNoyKVUaI0mOw3O9IejnoLowB4Ib
         71i8sSoeG4697nZSUGkMaBdXjeo+INft6ahfnYPtLkm9uEk4Y+9Y6NrrvDZCiYEYZbCK
         QOlYUUcWvfuga7LSjrs2x/tFJMlYBFkVM/diQDYzDKwImV4J4+zJ+LWw6TXriju6Qv/S
         +wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763640755; x=1764245555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igQkL0hwJSy+45hU8sboipK524syNZD4LXwpNdIPlK4=;
        b=OQgzFQmY5hbXTYzL9IH1taf33ZCFKU1D9mhqaY7Fx4B7N+BJU2XC7be6pdw3dezTIp
         BUB/35TWvlleiLg7xn1Cx6V0hKIgdY/5Mrwxe8+8cyqQgfAFn8ofEisvKdCcoNpL+EmX
         zJC5kV1KzRzqlJV+HEV1jQ1IBzjYyx9HQ9G8GgShiAjKQwoFDAnPkXG8DywcKMNAt3/q
         YSjm3r7kINSwiRSpWR/yJaWCIFZl687S8DswvD2oOlBJP82J6cK+BMeI2yC7fEWWT4O1
         AXkp8WW0jDtvB/R72PlPkO4dC01TzcNYsN/KNkcL7dG+4+ptMsClL0KPiWiL18g4s1dl
         tVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjhiOZU6e+5H8L3uUSQykBPHeV2V0EnsU9pE7rRrLxGJ5oDppIw5X6Lew13ldOoJsNniQrHOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJUqXmg5jgYzlpUR3Ev2dMu2hCyJyYpCXH/8yTSE5/ws2Mb+E
	cg1VjdF6HOlA0Kweh270btQk26RMhXvSyXyO779Py2J0nmwi6joXFB/MEfZcui4g43s=
X-Gm-Gg: ASbGncumAWFu/yB5/vXa/7fnin/TnOgixJaswqMp6sSvqWf+EPZsv0m9tgOQjizxm5n
	9XocAP+8e0Zmu+bXMhcb2H0I7wf8lUBX/B+mgA2OljKh+T52ZWnLxkCmXrFhmR9G5QHF2f+juKa
	ecaQTFWpwNbF5xezarsqh6GpdhQ01CcjZR+po2J1yHpMzjPZz8NQe0mI4b484E9mllirtlHxSpS
	f6Ru8kYOaChs0uoNaKkawPq3aiYK7o1Vcfi9nIqmKiZHV0VM9j3RrPAZS4+t6YhLYHl7GeV+z/K
	oTr3323EQkTj6U+ZNLB7BSZ1jd/66dLZ6TxBK1wXOpjnuOLac43sS4sKFhmj10lq93AEBIooeVO
	/v1/MISxfLFip7F+oXwknambf4tvJb2qVcEexNNhbbjDpxHNtdmubYh9gjD0ywQ5T6xUK2WF8ST
	CZe+tWIpl/MoQUOBoJ7JQ=
X-Google-Smtp-Source: AGHT+IHEfjUDRSw3XsIoCGUJfKvzP1sM+MewmjFxvo0sdFUq9/jwQ57RTX6W6E/9W3zN5+Kf9XtZqg==
X-Received: by 2002:a05:6402:3549:b0:63f:d245:aec4 with SMTP id 4fb4d7f45d1cf-64536467e18mr3136529a12.32.1763640755390;
        Thu, 20 Nov 2025 04:12:35 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536442993sm2075212a12.27.2025.11.20.04.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 04:12:34 -0800 (PST)
Date: Thu, 20 Nov 2025 13:12:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] team: Move team device type change at the end of
 team_port_add
Message-ID: <tdtkaqqlfivf4r4wxgoztv6ogzmp4dprbcz32psoj2sbtgphkg@bvwiovmnxtgi>
References: <20251113211142.245216-1-zlatistiv@gmail.com>
 <gbashnabbmnsqwwno5rc4piiwkluriytfcnvfdejn4abwovfkl@furcaobquk5t>
 <kpcqanotwzhukk6oemmopw77m5v6lvbubikmk6gotfmwhezbnq@ofz2e2zq4mot>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kpcqanotwzhukk6oemmopw77m5v6lvbubikmk6gotfmwhezbnq@ofz2e2zq4mot>

Wed, Nov 19, 2025 at 07:36:57PM +0100, zlatistiv@gmail.com wrote:
>On Wed, Nov 19, 2025 at 05:51:42PM +0100, Jiri Pirko wrote:
>> Thu, Nov 13, 2025 at 10:11:42PM +0100, zlatistiv@gmail.com wrote:
>> >Attempting to add a port device that is already up will expectedly fail,
>> >but not before modifying the team device header_ops.
>> >
>> >In the case of the syzbot reproducer the gre0 device is
>> >already in state UP when it attempts to add it as a
>> >port device of team0, this fails but before that
>> >header_ops->create of team0 is changed from eth_header to ipgre_header
>> >in the call to team_dev_type_check_change.
>> >
>> >Later when we end up in ipgre_header() struct *ip_tunnel points to nonsense
>> >as the private data of the device still holds a struct team.
>> >
>> >Example sequence of iproute commands to reproduce the hang/BUG():
>> >ip link add dev team0 type team
>> >ip link add dev gre0 type gre
>> >ip link set dev gre0 up
>> >ip link set dev gre0 master team0
>> >ip link set dev team0 up
>> >ping -I team0 1.1.1.1
>> >
>> >Move team_dev_type_check_change down where all other checks have passed
>> >as it changes the dev type with no way to restore it in case
>> >one of the checks that follow it fail.
>> >
>> >Also make sure to preserve the origial mtu assignment:
>> >  - If port_dev is not the same type as dev, dev takes mtu from port_dev
>> >  - If port_dev is the same type as dev, port_dev takes mtu from dev
>> >
>> >Testing:
>> >  - team device driver in-tree selftests
>> >  - Add/remove various devices as slaves of team device
>> >  - syzbot
>> >
>> >Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
>> >Closes: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
>> >Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>> >Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
>> >---
>> >Changes since v1:
>> >  - Add a "Fixes" tag
>> >  - Add a simple reproducer in the commit log
>> >  https://lore.kernel.org/netdev/20251111171341.4c6d69be@kernel.org/T/#u
>> >
>> > drivers/net/team/team_core.c | 19 +++++++++++--------
>> > 1 file changed, 11 insertions(+), 8 deletions(-)
>> >
>> >diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
>> >index 29dc04c299a3..94c149e89231 100644
>> >--- a/drivers/net/team/team_core.c
>> >+++ b/drivers/net/team/team_core.c
>> >@@ -1134,10 +1134,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>> > 		return -EPERM;
>> > 	}
>> > 
>> >-	err = team_dev_type_check_change(dev, port_dev);
>> >-	if (err)
>> >-		return err;
>> >-
>> > 	if (port_dev->flags & IFF_UP) {
>> > 		NL_SET_ERR_MSG(extack, "Device is up. Set it down before adding it as a team port");
>> > 		netdev_err(dev, "Device %s is up. Set it down before adding it as a team port\n",
>> >@@ -1155,10 +1151,12 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>> > 	INIT_LIST_HEAD(&port->qom_list);
>> > 
>> > 	port->orig.mtu = port_dev->mtu;
>> >-	err = dev_set_mtu(port_dev, dev->mtu);
>> >-	if (err) {
>> >-		netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
>> >-		goto err_set_mtu;
>> >+	if (dev->type == port_dev->type) {
>> >+		err = dev_set_mtu(port_dev, dev->mtu);
>> 
>> I'm probably missing something. Why you made this conditional? Didn't
>> find mentioning that in patch description.
>> 
>
>Hi Jiri,
>
>This is related to keeping the original MTU assignment logic.
>
>Basically I see 2 cases:
>
>if dev->type == port_dev->type then team_dev_type_check_change will
>do nothing and dev_set_mtu will later assign port_dev->mtu = dev->mtu
>
>if dev->type != port_dev->type then team_dev_type_check_change will
>assign dev->mtu = port_dev->mtu and dev_set_mtu will do nothing
>as they will already be the same.
>
>Now since the patch moves the call to team_dev_type_check_change
>past dev_set_mtu it changes this logic.
>
>The conditional is there to maintain the original behavior.
>
>If necessary I can update the commit log to address this in
>more detail.

Please do. Also, a brief comment at this check in the code it self would
be certainly nice for the reader.

Thanks!


>
>> 
>> 
>> >+		if (err) {
>> >+			netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
>> >+			goto err_set_mtu;
>> >+		}
>> > 	}
>> > 
>> > 	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
>> >@@ -1233,6 +1231,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>> > 		}
>> > 	}
>> > 
>> >+	err = team_dev_type_check_change(dev, port_dev);
>> >+	if (err)
>> >+		goto err_set_dev_type;
>> >+
>> > 	if (dev->flags & IFF_UP) {
>> > 		netif_addr_lock_bh(dev);
>> > 		dev_uc_sync_multiple(port_dev, dev);
>> >@@ -1251,6 +1253,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>> > 
>> > 	return 0;
>> > 
>> >+err_set_dev_type:
>> > err_set_slave_promisc:
>> > 	__team_option_inst_del_port(team, port);
>> > 
>> >-- 
>> >2.51.0
>> >

