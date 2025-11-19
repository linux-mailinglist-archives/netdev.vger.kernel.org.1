Return-Path: <netdev+bounces-240113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5349C70AD1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F9F04E236B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3A5337B8B;
	Wed, 19 Nov 2025 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jnr1Y1/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD030C61B
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577428; cv=none; b=M6tuzXdUl3mreKuiTQGHB67WSsW27g+97c9zqOzWkIr9+hGcODFbpnrN95ZNYM0sEEHpOn/jCVOn9oNaz/0iinwTA3P5RmQx1erMJBkKhAiEwJ+7EnUWLCUhTNZiWmXRDQwtUeFjd0enUc55TJP+xEPRWUtADVnRuQn5gY9MSLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577428; c=relaxed/simple;
	bh=Pljqk6pAVQfOEBJUscF9umbyJ32Tb6yQgcNpGLXNkIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6AymOsFW17esEk6ieOlGbJNDlcx4gpunI+RSRaBcC7fHX4lWL+1bhF0aZpPCZSccWaXUtCBQ7/5xbL2XyPotC8utNXoas76og4qnoGCyz6NrUX2pmymSb61RA+HqM4IeMqRunNlnYPPe7Go3MvhOZMV+t+q+rfVUwsfXgwZCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jnr1Y1/R; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b739ef3f739so17034366b.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763577420; x=1764182220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lf9Cg4Wp0k7y8UsSPnR61aZnXKwNvPdWd+HUA2UGWGU=;
        b=Jnr1Y1/Rn1hJZ4GidGD1JsazFRkpsvrb1LxOE1V8HOD+S8siO4tqhsEGWB7VDo9hyw
         7IHtOFb26IK1IrHbm7HVNK3ZlJcyVuGoXji1wNr0ktUsYW1z4oJtKCByVlL/oynwyxfg
         cX/9euX4hZpcdna8VBAE50/Qrs0SXjKfzkA8aKk1rViBXU4L0/T/mW6a0HQkbZp8q3RP
         khIrAGUOP7htzdWBfzA8tJR2R9WciB2KOPsMa6eHrDYPlW31ltWQh9bUGt/5lD5MFD+p
         z4h6iKDiRrw1Pq/7mjcjK4jUJXjsoa20GnFOvWynIiErkO4Qg+JamHyFXyE4ImzDq66S
         KwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763577420; x=1764182220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lf9Cg4Wp0k7y8UsSPnR61aZnXKwNvPdWd+HUA2UGWGU=;
        b=QnaDEi6bYzZaAh0LLSuT2irYwN3ZYViElKBZ+U5FfgwOQSMMrGf+oKI+Z9Q6Zlxhws
         1mhXHpDZdvJ1V3Kziy444kQS3HC9WTk0csg3xXSpgAIc9MxHvjvkxdYmG/pTTVHLZ0Qc
         ITv2UMXSdxAcoMnzV2DVenmzM3ndcU98QAG2IdxeTHSpTCjhTYj1GZkYnit43My3Q/MR
         ukqnnnuFCURaJzTCZL3p1ZwINz2peXIjk7xMf2jkv63RHIitJcFG7XDXP7GG7sskFd7T
         sr0Gf80NFemLxrXBL5ri2RvSiTkRkQHq3xqN+Ofbf1ee2HcwVIWqVVgbNejUr/oDKvMr
         O/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE1M0dVSY8zyT4zks45ZcIRCPtTFzABhdR4qHyAuTs5x48EAbIvIa0zP+vi7DnqRCFQJeUumo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZIMkYRtuauI0tjOSUc57G34vaj79aPmwfIp1W8c8CykShdHf
	FuIhX671PtUQKtfwsCfRmRefXuw6C7cVRvzypf4vvVARFFqUxyec6VrqF9n7Rg==
X-Gm-Gg: ASbGncvtQdMpc5UwpRY915k/sQgs3F8Hb+CuekYKvAfcfJ5OOj5oaI9ZjK/N6ehrvuy
	lDB+WKmUReJ+U8yWcRmAvX094SNhTFvpQU5dmXGHgYD7HWAdV/MDEO1iU7lNj25FFP4fSKfCSi9
	y3bsfYcJsD/JwuMzwFPKkvr+s9HrVNs5VuMA5CR4LoS2QSMjXD/anqO/Q5V5o0Oqx0FlrOj2t1F
	LDbDdeRY1392oVn83WiwUkRLIVIgOKj5ARQlI8U2TN3DCEof1MpVc9vpe1w3QC0Tu2vaUpo53my
	4PExD0cu6rB3OHO82DmGJ9z0cYjbUivzVRx3prjmxch3T3jabkAbJOHZUq7u5RertW4fWd1+4IO
	7GsJEk9S11sGqDuaiSemUh5eK8QoRoDzyFcCS8li64Jm3Dsa+aWMHw+8J9JvJqKV5I/UQEGDBt1
	ku4Oza/YnyrWZNkp5uureq+VOBQ9i0JgRs
X-Google-Smtp-Source: AGHT+IEjSObOUyY2ZIHcGf7HOqmJrPfEdO5JLEkjTsbFK8Y2A4HZ4NxmmbPrWEcm/MGQHqwjnAgQFg==
X-Received: by 2002:a17:906:9f96:b0:b73:6e0d:4f6b with SMTP id a640c23a62f3a-b7654f9fd70mr12377466b.36.1763577419947;
        Wed, 19 Nov 2025 10:36:59 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d54cf2sm8142966b.18.2025.11.19.10.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:36:59 -0800 (PST)
Date: Wed, 19 Nov 2025 20:36:57 +0200
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] team: Move team device type change at the end of
 team_port_add
Message-ID: <kpcqanotwzhukk6oemmopw77m5v6lvbubikmk6gotfmwhezbnq@ofz2e2zq4mot>
References: <20251113211142.245216-1-zlatistiv@gmail.com>
 <gbashnabbmnsqwwno5rc4piiwkluriytfcnvfdejn4abwovfkl@furcaobquk5t>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gbashnabbmnsqwwno5rc4piiwkluriytfcnvfdejn4abwovfkl@furcaobquk5t>

On Wed, Nov 19, 2025 at 05:51:42PM +0100, Jiri Pirko wrote:
> Thu, Nov 13, 2025 at 10:11:42PM +0100, zlatistiv@gmail.com wrote:
> >Attempting to add a port device that is already up will expectedly fail,
> >but not before modifying the team device header_ops.
> >
> >In the case of the syzbot reproducer the gre0 device is
> >already in state UP when it attempts to add it as a
> >port device of team0, this fails but before that
> >header_ops->create of team0 is changed from eth_header to ipgre_header
> >in the call to team_dev_type_check_change.
> >
> >Later when we end up in ipgre_header() struct *ip_tunnel points to nonsense
> >as the private data of the device still holds a struct team.
> >
> >Example sequence of iproute commands to reproduce the hang/BUG():
> >ip link add dev team0 type team
> >ip link add dev gre0 type gre
> >ip link set dev gre0 up
> >ip link set dev gre0 master team0
> >ip link set dev team0 up
> >ping -I team0 1.1.1.1
> >
> >Move team_dev_type_check_change down where all other checks have passed
> >as it changes the dev type with no way to restore it in case
> >one of the checks that follow it fail.
> >
> >Also make sure to preserve the origial mtu assignment:
> >  - If port_dev is not the same type as dev, dev takes mtu from port_dev
> >  - If port_dev is the same type as dev, port_dev takes mtu from dev
> >
> >Testing:
> >  - team device driver in-tree selftests
> >  - Add/remove various devices as slaves of team device
> >  - syzbot
> >
> >Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
> >Closes: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
> >Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> >Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> >---
> >Changes since v1:
> >  - Add a "Fixes" tag
> >  - Add a simple reproducer in the commit log
> >  https://lore.kernel.org/netdev/20251111171341.4c6d69be@kernel.org/T/#u
> >
> > drivers/net/team/team_core.c | 19 +++++++++++--------
> > 1 file changed, 11 insertions(+), 8 deletions(-)
> >
> >diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> >index 29dc04c299a3..94c149e89231 100644
> >--- a/drivers/net/team/team_core.c
> >+++ b/drivers/net/team/team_core.c
> >@@ -1134,10 +1134,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
> > 		return -EPERM;
> > 	}
> > 
> >-	err = team_dev_type_check_change(dev, port_dev);
> >-	if (err)
> >-		return err;
> >-
> > 	if (port_dev->flags & IFF_UP) {
> > 		NL_SET_ERR_MSG(extack, "Device is up. Set it down before adding it as a team port");
> > 		netdev_err(dev, "Device %s is up. Set it down before adding it as a team port\n",
> >@@ -1155,10 +1151,12 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
> > 	INIT_LIST_HEAD(&port->qom_list);
> > 
> > 	port->orig.mtu = port_dev->mtu;
> >-	err = dev_set_mtu(port_dev, dev->mtu);
> >-	if (err) {
> >-		netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
> >-		goto err_set_mtu;
> >+	if (dev->type == port_dev->type) {
> >+		err = dev_set_mtu(port_dev, dev->mtu);
> 
> I'm probably missing something. Why you made this conditional? Didn't
> find mentioning that in patch description.
> 

Hi Jiri,

This is related to keeping the original MTU assignment logic.

Basically I see 2 cases:

if dev->type == port_dev->type then team_dev_type_check_change will
do nothing and dev_set_mtu will later assign port_dev->mtu = dev->mtu

if dev->type != port_dev->type then team_dev_type_check_change will
assign dev->mtu = port_dev->mtu and dev_set_mtu will do nothing
as they will already be the same.

Now since the patch moves the call to team_dev_type_check_change
past dev_set_mtu it changes this logic.

The conditional is there to maintain the original behavior.

If necessary I can update the commit log to address this in
more detail.

> 
> 
> >+		if (err) {
> >+			netdev_dbg(dev, "Error %d calling dev_set_mtu\n", err);
> >+			goto err_set_mtu;
> >+		}
> > 	}
> > 
> > 	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
> >@@ -1233,6 +1231,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
> > 		}
> > 	}
> > 
> >+	err = team_dev_type_check_change(dev, port_dev);
> >+	if (err)
> >+		goto err_set_dev_type;
> >+
> > 	if (dev->flags & IFF_UP) {
> > 		netif_addr_lock_bh(dev);
> > 		dev_uc_sync_multiple(port_dev, dev);
> >@@ -1251,6 +1253,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
> > 
> > 	return 0;
> > 
> >+err_set_dev_type:
> > err_set_slave_promisc:
> > 	__team_option_inst_del_port(team, port);
> > 
> >-- 
> >2.51.0
> >

