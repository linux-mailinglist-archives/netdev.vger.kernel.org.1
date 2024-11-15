Return-Path: <netdev+bounces-145248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA55C9CDEAF
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FAD1F24276
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA741BBBFE;
	Fri, 15 Nov 2024 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="PUZD5uU1"
X-Original-To: netdev@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE090558BB;
	Fri, 15 Nov 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675170; cv=none; b=PegACFTB0M4stgukUEm7VMe+ownyRTmW5NY6CC3ceLm6PgXdIitSeL+mVeYZIHxYDJPkeOgw7XR4PgC3V8WY2tN1pibe2TcHfuNx6ewIUHAPxIGXn5FX2Lz2+9FLBJlevUtCexkrMV+dNy3lN30999PU3FNR1Bo0wokpdSVEXVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675170; c=relaxed/simple;
	bh=2juy4Ylv4MaM8LY8xJ4un4V+EwF5mFscetSWP49J2vM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=u8B8MsZFYc/uE6hpzkU9VpHsYlxvSpJm4PgILmur0coNKKdFzMZIfPZ9WstxpNXyLr7cWYG/ytRKlv9fZFt/GB+jEkKoBKvn3KKGV8VnzP6MkTxF+zskDL4XiVZMhytGSHEAEiqmRLK4Qc0xaTkRbV/pNAyQ8tpvZ3tIyqEsleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=PUZD5uU1; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c07:109:0:640:efe1:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 7B33B60912;
	Fri, 15 Nov 2024 15:52:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aqMiAU8Or0U0-2DXNa1et;
	Fri, 15 Nov 2024 15:52:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731675157; bh=Loh55YzRdUYifYSRVv6NI6kFX5r8vY1rNPibfZfJwAU=;
	h=Subject:From:Cc:To:Date:Message-ID;
	b=PUZD5uU1cHz8jBZUDFEaHPYeF9fuR3S84Dli4uWkLaEjJ3RvNohXFcfj8CS7blT80
	 cKDxtkXLb/iJQZj6SqSqnYmIWWqUKwHQjuYhavFAAIWhuYeBJjVtgBYG7YI2F7bQl0
	 nE4dKhVk0bDvP2nVI2FNzpf6NzoXUjAiP2LsXpkE=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <1f9e278a-6590-4ede-a74a-3923ebe4d154@yandex.ru>
Date: Fri, 15 Nov 2024 15:52:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev <netdev@vger.kernel.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Andrew Bird (Sphere Systems)" <ajb@spheresystems.co.uk>
From: stsp <stsp2@yandex.ru>
Subject: tun: group check overrides user, is this intentional?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello.

I've found that the user that is an owner
of tun device, can't access it if it is not
in the tun's group.
I.e. the following command:
$ sudo tunctl -u stas -g root

is insufficient for the user "stas"
to access tun, unless he has group
"root" in his supplementary list.
This is somewhat very strange, as
the group check usually enlarges
the scope, not restricts it.

I am going to send the patch below,
but I'd like to ask if maybe this is
intentional?

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9a0f6eb32016..d35b6a48d138 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -574,14 +574,18 @@ static u16 tun_select_queue(struct net_device 
*dev, struct sk_buff *skb,
         return ret;
  }

-static inline bool tun_not_capable(struct tun_struct *tun)
+static inline bool tun_capable(struct tun_struct *tun)
  {
         const struct cred *cred = current_cred();
         struct net *net = dev_net(tun->dev);

-       return ((uid_valid(tun->owner) && !uid_eq(cred->euid, 
tun->owner)) ||
-                 (gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
-               !ns_capable(net->user_ns, CAP_NET_ADMIN);
+       if (ns_capable(net->user_ns, CAP_NET_ADMIN))
+               return 1;
+       if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
+               return 1;
+       if (gid_valid(tun->group) && in_egroup_p(tun->group))
+               return 1;
+       return 0;
  }

  static void tun_set_real_num_queues(struct tun_struct *tun)
@@ -2778,7 +2782,7 @@ static int tun_set_iff(struct net *net, struct 
file *file, struct ifreq *ifr)
                     !!(tun->flags & IFF_MULTI_QUEUE))
                         return -EINVAL;

-               if (tun_not_capable(tun))
+               if (!tun_capable(tun))
                         return -EPERM;
                 err = security_tun_dev_open(tun->security);
                 if (err < 0)


