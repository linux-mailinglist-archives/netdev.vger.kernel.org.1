Return-Path: <netdev+bounces-216002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B219B31549
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D791D20043
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09192D6E73;
	Fri, 22 Aug 2025 10:23:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA273D987
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858232; cv=none; b=gWanAaKe8BfIj3O2TUfOfz6+tYkOf3GZ/iPGwVM81IUAEDQ1ePF9R4ols90mM6+orPHKeOmpHo6BOhPIdfQw8MzEO85a6yvU6O3d5T5IHSV5jQz5jnhhcnLiiUYdfWugLV+M3k1kuOTcmwiNP8D8fOVkLFnsPW9eQWfEoIWJpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858232; c=relaxed/simple;
	bh=EuP5AqH3b3XOrYEptDqVYNEWFMdxAyiErg60KbJ6JGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbsogGEkE9kWsZGJ/sGQkZufjnfAud2UHS5lTGsnBsqaOPo9O4Kl3o77YpCcFhxkuOXhfyCqrfS6uwzadDS06OmDnZDJdqMOi4U568Lpx1lmKf+1H42+8n52pgvOO8NJZj1O1QI9RNBGougm3/lpeBrfdWiI9sLwoM4xrtF/akk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57MANl4X026917;
	Fri, 22 Aug 2025 19:23:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57MANlB2026912
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 22 Aug 2025 19:23:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bb595640-0597-4d18-a9e1-f6eb8e6bb50e@I-love.SAKURA.ne.jp>
Date: Fri, 22 Aug 2025 19:23:48 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: can/j1939: hung inside rtnl_dellink()
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <50055a40-6fd9-468f-8e59-26d1b5b3c23d@I-love.SAKURA.ne.jp>
 <aKg9mTaSxzBVpTVI@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aKg9mTaSxzBVpTVI@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

(Adding netdev ML to ask for hints from different network protocols...)

On 2025/08/22 18:51, Oleksij Rempel wrote:
> Hello Tetsuo,
> 
> On Sat, Aug 16, 2025 at 03:51:54PM +0900, Tetsuo Handa wrote:
>> Hello.
>>
>> I made a minimized C reproducer for
>>
>>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
>>
>> problem at https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 , and
>> obtained some data using debug printk() patch. It seems that the cause is
>> net/can/j1939/ does not handle NETDEV_UNREGISTER notification
>> while net/can/j1939/ can directly call rtnl_dellink() via sendmsg().
> 
> Sorry for long delay and than you for your investigation!
> 
>> The minimized C reproducer is shown below.
> ....
> 
>> Therefore, I guess that either
>>
>>   j1939_netdev_notify() is handling NETDEV_UNREGISTER notification

Oops. I wanted to write

     j1939_netdev_notify() is *not* handling NETDEV_UNREGISTER notification

>>
>> or
>>
>>   rtnl_dellink() can be called via sendmsg() despite the j1939 socket
>>   are in use
>>
>> is wrong. How to fix this problem?
> 
> I assume the first variant is correct. Can you please test following change:
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -370,6 +370,7 @@
>  		goto notify_done;
>  
>  	switch (msg) {
> +	case NETDEV_UNREGISTER:
>  	case NETDEV_DOWN:
>  		j1939_cancel_active_session(priv, NULL);
>  		j1939_sk_netdev_event_netdown(priv);
> 

Such change is not sufficient.

As far as I tested, the only way that can drop the refcount to 1 is to
call j1939_sk_release() (which involves sock_put()) on all j1939 sockets
(i.e. something like shown below).


diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 31a93cae5111..81f58924b4ac 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -212,6 +212,7 @@ void j1939_priv_get(struct j1939_priv *priv);

 /* notify/alert all j1939 sockets bound to ifindex */
 void j1939_sk_netdev_event_netdown(struct j1939_priv *priv);
+void j1939_sk_netdev_event_unregister(struct j1939_priv *priv);
 int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk);
 void j1939_tp_init(struct j1939_priv *priv);

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 7e8a20f2fc42..e568b5928a39 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -377,6 +377,11 @@ static int j1939_netdev_notify(struct notifier_block *nb,
                j1939_sk_netdev_event_netdown(priv);
                j1939_ecu_unmap_all(priv);
                break;
+       case NETDEV_UNREGISTER:
+               pr_info("NETDEV_UNREGISTER notification on %px start\n", ndev);
+               j1939_sk_netdev_event_unregister(priv);
+               pr_info("NETDEV_UNREGISTER notification on %px end\n", ndev);
+               break;
        }

        j1939_priv_put(priv);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 3d8b588822f9..4e53a1b10907 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1300,6 +1313,24 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
        read_unlock_bh(&priv->j1939_socks_lock);
 }

+void j1939_sk_netdev_event_unregister(struct j1939_priv *priv)
+{
+       struct j1939_sock *jsk;
+       struct socket sock = { };
+
+ rescan:
+       read_lock_bh(&priv->j1939_socks_lock);
+       list_for_each_entry(jsk, &priv->j1939_socks, list) {
+               read_unlock_bh(&priv->j1939_socks_lock);
+               pr_info("Releasing %px\n", &jsk->sk);
+               sock.sk = &jsk->sk;
+               //sock_hold(&jsk->sk);
+               j1939_sk_release(&sock);
+               goto rescan;
+       }
+       read_unlock_bh(&priv->j1939_socks_lock);
+}
+
 static int j1939_sk_no_ioctlcmd(struct socket *sock, unsigned int cmd,
                                unsigned long arg)
 {


Of course, calling sk_j1939_sk_release() upon NETDEV_UNREGISTER event
causes refcount underflow bug. But calling sock_hold() before calling
j1939_sk_release() prevents the refcount from dropping to 1. :-(

I think we need to somehow make it possible to logically close j1939
sockets without actually closing. Maybe something like 
"struct in_device"->dead flag which is set by inetdev_destroy() upon
NETDEV_UNREGISTER event is needed by j1939 sockets...

My build environment is very slow (testing on VMWare on a Windows PC).
Running my simplified reproducer on your build environment would be
much faster.


