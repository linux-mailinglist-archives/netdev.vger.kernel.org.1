Return-Path: <netdev+bounces-252348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A6oL9krcmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:53:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9B367933
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB7E3721AAE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B22ECE9D;
	Thu, 22 Jan 2026 13:08:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3742E6CA5
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087311; cv=none; b=lw2eGkPwekxHctTAXDDzpFSMlwhyO2iycvMu8C5xr1ha52/kWp5eVPXTNwPlChJ/KnkzrkiBf+cQ377t/X6UpAcy2DFZkU11k87YHpARHt8TInkIgEuR/sVn429/wTgyRnW2OIKWz+Z0FpywVcYx0JLTv3n3R6lwwr1+X2/Vro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087311; c=relaxed/simple;
	bh=lku/en9+9A6K3Mr80m1/GmSebNT0FLjtZiX1vETaLcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWwHXQeFAjo+02hnM1OScyD3fPdScO+iql3lgB6phZ+twnusQVeae+v28KUnv/HRcIahu1tu0zolzCRZQlGTe9wzxv5/FTzeVFPxRQX+WqugkQwgRht4+5ghPEfX317MH+ngD+inQCX2vfR23JehInBtf5f1PKDRNjn7SPVb1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60MD7nuZ094651;
	Thu, 22 Jan 2026 22:07:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60MD7mrw094647
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 22 Jan 2026 22:07:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5811ec38-907e-4788-8a0e-7758f12dc9d0@I-love.SAKURA.ne.jp>
Date: Thu, 22 Jan 2026 22:07:46 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
To: Steffen Klassert <steffen.klassert@secunet.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc: Boris Pismenny <borisp@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
        Raed Salem <raeds@mellanox.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>,
        Aviad Yehezkel <aviadye@nvidia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
 <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp>
 <aXIGxmCB2QU86-iA@secunet.com>
 <447378de-3cc9-44f5-872e-a1fc477f591e@I-love.SAKURA.ne.jp>
 <aXIKwNJv59KnsnLw@secunet.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aXIKwNJv59KnsnLw@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mellanox.com,davemloft.net,strlen.de,gmail.com,kernel.org,nvidia.com,vger.kernel.org,gondor.apana.org.au];
	TAGGED_FROM(0.00)[bounces-252348-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15]
X-Rspamd-Queue-Id: 6B9B367933
X-Rspamd-Action: no action

On 2026/01/22 20:32, Steffen Klassert wrote:
> On Thu, Jan 22, 2026 at 08:28:31PM +0900, Tetsuo Handa wrote:
>> On 2026/01/22 20:15, Steffen Klassert wrote:
>>> Hm, I'd say we should not try to offload to a device that does
>>> not support NETIF_F_HW_ESP.
>>
>> I was about to post the patch below, but you are suggesting that "do not allow calling
>> xfrm_dev_state_add()/xfrm_dev_policy_add() if (dev->features & NETIF_F_HW_ESP) == 0" ?
> 
> As said, I think this is the correct way to do it. But let's wait
> on opinions from the hardware people.

OK. I guess something like below.

 net/xfrm/xfrm_device.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 52ae0e034d29..19aa61609d24 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -292,6 +292,13 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		dst_release(dst);
 	}
 
+	if (!(dev->features & NETIF_F_HW_ESP)) {
+		NL_SET_ERR_MSG(extack, "Device doesn't support offload");
+		xso->dev = NULL;
+		dev_put(dev);
+		return -EINVAL;
+	}
+
 	if (!dev->xfrmdev_ops || !dev->xfrmdev_ops->xdo_dev_state_add) {
 		xso->dev = NULL;
 		dev_put(dev);
@@ -367,7 +374,8 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 	if (!dev)
 		return -EINVAL;
 
-	if (!dev->xfrmdev_ops || !dev->xfrmdev_ops->xdo_dev_policy_add) {
+	if (!dev->xfrmdev_ops || !dev->xfrmdev_ops->xdo_dev_policy_add ||
+	    !(dev->features & NETIF_F_HW_ESP)) {
 		xdo->dev = NULL;
 		dev_put(dev);
 		NL_SET_ERR_MSG(extack, "Policy offload is not supported");



On 2026/01/22 20:15, Steffen Klassert wrote:
>> But I have a question regarding security_xfrm_state_delete()/security_xfrm_policy_delete().
>>
>> xfrm_dev_state_flush_secctx_check() calls security_xfrm_state_delete() which can make
>> xfrm_dev_state_flush() no-op by returning an error value.
>> xfrm_dev_policy_flush_secctx_check() calls security_xfrm_policy_delete() which can make
>> xfrm_dev_policy_flush() no-op by returning an error value.
>>
>> Since xfrm_dev_state_flush()/xfrm_dev_policy_flush() are called by NETDEV_UNREGISTER
>> event (which is a signal for releasing all resources that prevent "struct net_device"
>> references from dropping), making xfrm_dev_state_flush()/xfrm_dev_policy_flush() no-op (by
>> allowing security_xfrm_state_delete()/security_xfrm_policy_delete() to return an error) is
>> a denial-of-service bug.
> 
> This means that the calling task doesn't have the permission to delete the
> state, some LSM has a policy the does not grant this permission.

But NETDEV_UNREGISTER event can fire without explicit request from a user.
Roughly speaking, current behavior is that

  while (security_xfrm_state_delete() != 0) {
    schedule_timeout_uninterruptible(10 * HZ);
    pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
             dev->name, netdev_refcnt_read(dev));
  }
  while (security_xfrm_policy_delete() != 0) {
    schedule_timeout_uninterruptible(10 * HZ);
    pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
             dev->name, netdev_refcnt_read(dev));
  }

might be executed upon e.g. termination of a userspace process.

> 
>>
>> Therefore, I wonder what are security_xfrm_state_delete() and security_xfrm_policy_delete()
>> for. Can I kill xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy_flush_secctx_check() ?
> 
> This might violate a LSM policy then.

But LSM policy that results in system hung upon automatic cleanup logic is so stupid.
I want to kill xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy_flush_secctx_check()
in order to eliminate possibility of system hung.


