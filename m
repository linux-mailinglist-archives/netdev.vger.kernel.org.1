Return-Path: <netdev+bounces-71810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B3855278
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDC11C228AE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428001272CD;
	Wed, 14 Feb 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nuQq9EJy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB65C605
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936233; cv=none; b=OwYKpmS8j/09g2jS+IZH9thSP4qtPH16wc8pShnaP/OVKTSe3Row3Xo72tOIw+jPuU06ITuP2+HGDq8Pl58zR7B6uV89yfv43YiOJoBAsKBo4Q9ZPpkkUxgBOstVZnukHy/vqVcE+jpGtqs5/O2La4Y9J/fy3uGa0av/j/ajhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936233; c=relaxed/simple;
	bh=gMOqJQ9jGX8BrI2e7uwdbBZnOvPjV2iMIvw9st1KTZ0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=s8mfhldrPZAg3OxpAALgffKe1IxR3oKnBEFUryo7DRA9oFyUKe/PmbTiG7sUeoIIBEpO4ZUrVCxzQM3ajt4QX0Buu3nd0uTgCCZVeV+iMaO14jMUtJd9SivCSSMI8m7R8KHPqc2tTpf2dm6mPCrD8+2VLbmuD3Jz+sYA962FoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nuQq9EJy; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2BA5F3F17F
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707935678;
	bh=rfIT5YDOblrqYOSLL2etqM8BAAl7iVzBIumCF/p5be0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=nuQq9EJyrQ094ylhD+EnW/woQCSMeJLHmlgiPDBGcqGPB26m/lHWOiUTdtaQVEeqP
	 wux/pOwumXIbRy9mHGLxe8sApaU0eGmE++tIr0J/9hIyofdqsczHhqHPA92Vwj4pii
	 EkcKEtvraY+ZO7DIlL5QnZEHd0QlhChf/sK0Uq2jeSxVyxueuPmYipOUEjd6IH0X8+
	 ci2K0fVH6UXUjdMGehRqJBxLPp1WAnU+gheXwYhk5b+mIYALOMfHrklzY5rAt6FaGD
	 5m9rpxiKsowIPrSV363jZoXsywqzmPLlLKWCf72Kdonbz1kuXJVywvmNArDalFwSpB
	 S3PtbHmLtqyaQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2963c93a5e3so62436a91.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 10:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707935676; x=1708540476;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfIT5YDOblrqYOSLL2etqM8BAAl7iVzBIumCF/p5be0=;
        b=cF4mnJ5JcrzymJKzMAwgYpe0DRzrz6PKcLLW6QDf4iZbkNCQ5mG92fXlxTaN9+9rp3
         uVjl2Oi6PH7QzxNbDbraYBtjYIP+5WOqGgRxpBqPgE9yb8pfPkGQkik8bDET14eJNrr9
         kZT7MH84U+stR9LBNX+INPoVbGLO0GqYPP/5s0clMKCd+Dzp+wk5K98xDefWmiA8dJer
         7Q6zH6RoD/Mum45uQvgTT/zrjV8WpIbp7TVdOmYj+QhZ5crw7PDpoOIw6DTA896sfkWl
         mVM1btmzSXIgfmnhRbjL33uVzWsQEIK9WogrxipXuHNS1moDNmLaoQDR5XypivKPAJQr
         uBNg==
X-Forwarded-Encrypted: i=1; AJvYcCUuxINbA9z8ySXEckLARWKHLOpGirDkWRj3pRD3Yzc0VQJZAOlNb2Li2i3e8p9fCUloODUQeHMI7ulco2b2m222sWyrnR7u
X-Gm-Message-State: AOJu0Yw9uHe4e1pNXaMWtYdSoQC99eqhZnE+uK0XMubsP27Mg6ScWE1v
	CkWoxvQQ97T14Qz5uK7vhronouRYvQizUNJeH/YOqBYV8iPrGdQMRz+4sQdHBZMGuINlrHdZiS8
	iK53cnYYpqmDlolVu5ZF3Fjc8FhPx6k3IyncoFKu3K7iEkbV9nZ058Zp3AEMwNyuHpaUixw==
X-Received: by 2002:a17:90a:f28c:b0:295:b440:9751 with SMTP id fs12-20020a17090af28c00b00295b4409751mr3141589pjb.44.1707935676672;
        Wed, 14 Feb 2024 10:34:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0kxGLNO4idnxDh27qUqCYdrXNhWksfjkjNRjMIy63fnj8xY/UmqTFfDa6JYsjMsag+Sr5xg==
X-Received: by 2002:a17:90a:f28c:b0:295:b440:9751 with SMTP id fs12-20020a17090af28c00b00295b4409751mr3141569pjb.44.1707935676328;
        Wed, 14 Feb 2024 10:34:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUw+vjOlHmH9Np0YVJ3KKLC2ZCiH7M4AKGvKnlQWicZzu1Zb9tZwQtaDT1eBAVvGZqcSMUYEb4ARwCqM6fumVp4X5+9u5uq5X3LF2MDbY0UYS7LGCbazKpa7F90/rxaOF7LypHu+kIqwrG07iTkAdUEUhQ7qposWNOB/WhdQNBhB0Gk4VVvXGTrzdOtwN7BBo8CuGc38EXX46L0jxcHgXqIGIq+HB+LNYQb2rrYfu6NW2yrwNNYDKLWkb6aLml4i8pgE4TEB4AFobU8Yt3GKfDLz/W5SWqWDN1zsVcyBMt/jBY7eFQnVUe3bxG2e2Iji3MVdKDrCL7/ZfUl83D2gg+oOwepPWCTlfBBt2kbJx9XDKYXg2F9
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090adb8d00b0029082d10fc4sm1783790pjv.39.2024.02.14.10.34.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2024 10:34:35 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 61E1F5FFF6; Wed, 14 Feb 2024 10:34:35 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 546909FAAA;
	Wed, 14 Feb 2024 10:34:35 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
    rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com
Subject: Re: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
In-reply-to: <20240214044245.33170-1-praveen.kannoju@oracle.com>
References: <20240214044245.33170-1-praveen.kannoju@oracle.com>
Comments: In-reply-to Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
   message dated "Wed, 14 Feb 2024 10:12:45 +0530."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7712.1707935675.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 10:34:35 -0800
Message-ID: <7713.1707935675@famine>

Praveen Kumar Kannoju <praveen.kannoju@oracle.com> wrote:

>Rate limit bond driver log messages, to prevent a log flood in a run-away
>situation, e.g couldn't get rtnl lock. Message flood leads to instability
>of system and loss of other crucial messages.
>
>Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
>---
> drivers/net/bonding/bond_main.c | 34 +++++++++++++++++++---------------
> include/net/bonding.h           | 11 +++++++++++
> 2 files changed, 30 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 4e0600c..32098dd 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2610,12 +2610,13 @@ static int bond_miimon_inspect(struct bonding *bo=
nd)
> 			commit++;
> 			slave->delay =3D bond->params.downdelay;
> 			if (slave->delay) {
>-				slave_info(bond->dev, slave->dev, "link status down for %sinterface,=
 disabling it in %d ms\n",
>-					   (BOND_MODE(bond) =3D=3D
>-					    BOND_MODE_ACTIVEBACKUP) ?
>-					    (bond_is_active_slave(slave) ?
>+				bond_info_rl(bond->dev, slave->dev,
>+					     "link status down for %sinterface, disabling it in %d ms\n",
>+					     (BOND_MODE(bond) =3D=3D
>+					     BOND_MODE_ACTIVEBACKUP) ?
>+					     (bond_is_active_slave(slave) ?
> 					     "active " : "backup ") : "",
>-					   bond->params.downdelay * bond->params.miimon);
>+					     bond->params.downdelay * bond->params.miimon);

	Why not use net_info_ratelimited() or net_ratelimit()?  The rest
of the bonding messages that are rate limited are almost all gated by
the net rate limiter.

	-J

> 			}
> 			fallthrough;
> 		case BOND_LINK_FAIL:
>@@ -2623,9 +2624,10 @@ static int bond_miimon_inspect(struct bonding *bon=
d)
> 				/* recovered before downdelay expired */
> 				bond_propose_link_state(slave, BOND_LINK_UP);
> 				slave->last_link_up =3D jiffies;
>-				slave_info(bond->dev, slave->dev, "link status up again after %d ms\=
n",
>-					   (bond->params.downdelay - slave->delay) *
>-					   bond->params.miimon);
>+				bond_info_rl(bond->dev, slave->dev,
>+					     "link status up again after %d ms\n",
>+					     (bond->params.downdelay - slave->delay) *
>+					     bond->params.miimon);
> 				commit++;
> 				continue;
> 			}
>@@ -2648,18 +2650,20 @@ static int bond_miimon_inspect(struct bonding *bo=
nd)
> 			slave->delay =3D bond->params.updelay;
> =

> 			if (slave->delay) {
>-				slave_info(bond->dev, slave->dev, "link status up, enabling it in %d=
 ms\n",
>-					   ignore_updelay ? 0 :
>-					   bond->params.updelay *
>-					   bond->params.miimon);
>+				bond_info_rl(bond->dev, slave->dev,
>+					     "link status up, enabling it in %d ms\n",
>+					     ignore_updelay ? 0 :
>+					     bond->params.updelay *
>+					     bond->params.miimon);
> 			}
> 			fallthrough;
> 		case BOND_LINK_BACK:
> 			if (!link_state) {
> 				bond_propose_link_state(slave, BOND_LINK_DOWN);
>-				slave_info(bond->dev, slave->dev, "link status down again after %d m=
s\n",
>-					   (bond->params.updelay - slave->delay) *
>-					   bond->params.miimon);
>+				bond_info_rl(bond->dev, slave->dev,
>+					     "link status down again after %d ms\n",
>+					     (bond->params.updelay - slave->delay) *
>+					     bond->params.miimon);
> 				commit++;
> 				continue;
> 			}
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 5b8b1b6..ebdfaf0 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -39,8 +39,19 @@
> #define __long_aligned __attribute__((aligned((sizeof(long)))))
> #endif
> =

>+DEFINE_RATELIMIT_STATE(bond_rs, DEFAULT_RATELIMIT_INTERVAL,
>+		       DEFAULT_RATELIMIT_BURST);
>+
>+#define bond_ratelimited_function(function, ...)	\
>+do {							\
>+	if (__ratelimit(&bond_rs))		\
>+		function(__VA_ARGS__);			\
>+} while (0)
>+
> #define slave_info(bond_dev, slave_dev, fmt, ...) \
> 	netdev_info(bond_dev, "(slave %s): " fmt, (slave_dev)->name, ##__VA_ARG=
S__)
>+#define bond_info_rl(bond_dev, slave_dev, fmt, ...) \
>+	bond_ratelimited_function(slave_info, fmt, ##__VA_ARGS__)
> #define slave_warn(bond_dev, slave_dev, fmt, ...) \
> 	netdev_warn(bond_dev, "(slave %s): " fmt, (slave_dev)->name, ##__VA_ARG=
S__)
> #define slave_dbg(bond_dev, slave_dev, fmt, ...) \
>-- =

>1.8.3.1
>
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

