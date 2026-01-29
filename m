Return-Path: <netdev+bounces-254600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFzENAQVe2n5BAIAu9opvQ
	(envelope-from <netdev+bounces-254600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:06:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B42AD1AF
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46A1B3007201
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52209379987;
	Thu, 29 Jan 2026 08:06:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B21DDC2B
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769673973; cv=none; b=i8SN+fPLCAwQuMS22CfhSPtYZSR+SK9d5nMdNjOoP7p2lnpkYEkO+QXkxOEwvL0DQ/o3NTvx2xkBZA/nAvlh2fU8h+M68g4EhRsukw9YGpeWPfPAIahahY8exy+gsTuWcyBR2C0w9ip6Age3ha2bMhOOgR43iv1pFQNBTtaBW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769673973; c=relaxed/simple;
	bh=spQ6ptuyKVcePq/EcEzdBWb3run++SbCN8Gbv0Chm7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvEwIbyr/MRMlBSkQ/GaCJ4ZCl6StEmfbUjsKdDzr1+JSoBTZaZiYcTC1lLktg+x/YkUZZmHOaMICES0/sgOlwXEdrbEUg2P/aM2HF8KLW2pTogE9Jsnfb8A5u6c1u69Avuwa5YYUvzyh9JEB10ew3kQBN+emj04+B+r9VHQjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60T8686d087496;
	Thu, 29 Jan 2026 17:06:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60T867oH087492
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 29 Jan 2026 17:06:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b91432c3-5ed4-4669-8d7c-02cf7ea6f8fa@I-love.SAKURA.ne.jp>
Date: Thu, 29 Jan 2026 17:06:08 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
To: Leon Romanovsky <leon@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Ilan Tayari <ilant@mellanox.com>, Guy Shapiro <guysh@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
 <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
 <20260128123546.GC40916@unreal>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260128123546.GC40916@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254600-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: E3B42AD1AF
X-Rspamd-Action: no action

On 2026/01/28 21:35, Leon Romanovsky wrote:
> On Wed, Jan 28, 2026 at 07:44:02PM +0900, Tetsuo Handa wrote:
>> On 2026/01/28 19:24, Leon Romanovsky wrote:
>>> I think this can work, but IMHO the more robust approach is to ensure that all
>>> states and policies are removed when the NETIF_F_HW_ESP feature bit is cleared.
>>
>> The transaction will become complicated, for dev->features manipulation
>> function can fail.
> 
> Line above returning NOTIFY_OK, check that NETIF_F_HW_ESP is cleared,
> and remove everything.

That answer needs more clarification. I came to get confused about what we should do.

Question 1:

  Since NETIF_F_HW_ESP is a hardware dependent flag, not all "struct net_device"
  support NETIF_F_HW_ESP flag. Is this interpretation correct?

Question 2:

  Sabrina Dubroca commented

    But the current behavior ("ignore NETIF_F_HW_ESP and call
    xdo_dev_state_add for new states anyway") has been established for
    multiple years. Changing that now seems a bit risky.

  at https://lkml.kernel.org/r/aXd3QjzwOVm0Q9LF@krikkit .

  Is that comment saying that we have been permitting a "struct net_device"
  to be selected by xfrm_dev_state_add() even if that "struct net_device"
  does not support NETIF_F_HW_ESP flag. Is this interpretation correct?

Question 3:

  Leon Romanovsky suggested that, as a more robust approach, remove all states
  and policies when the NETIF_F_HW_ESP feature bit is cleared.

  But I consider that such approach will not work, for (according to Q2 above)
  xfrm_dev_state_add() can be called even if the NETIF_F_HW_ESP feature bit is not
  set. Also, I think that there is no guarantee that dev->features manipulation
  function is called after xfrm_dev_state_add() was called.

  Therefore, we need an event that are guaranteed to be called.
  The NETDEV_UNREGISTER event is guaranteed to be called when unregistring
  a "struct net_device", and therefore a good place to remove all states and
  policies.

  Is this interpretation correct?

Question 4:

  If Q1 is correct, Sabrina's comment

    Changing that now seems a bit risky.

  in Q2 might be applicable to xfrm_dev_down().

  That is, someone who is using xfrm with a !NETIF_F_HW_ESP hardware might be
  expecting that state and policy are not flushed upon NETDEV_DOWN event.

  If there is such possibility, I think we should avoid changing xfrm_dev_down()
  and instead re-introduce xfrm_dev_unregister(). What do you think?

 net/xfrm/xfrm_device.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 52ae0e034d29..550457e4c4f0 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -544,6 +544,14 @@ static int xfrm_dev_down(struct net_device *dev)
 	return NOTIFY_DONE;
 }
 
+static int xfrm_dev_unregister(struct net_device *dev)
+{
+	xfrm_dev_state_flush(dev_net(dev), dev, true);
+	xfrm_dev_policy_flush(dev_net(dev), dev, true);
+
+	return NOTIFY_DONE;
+}
+
 static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
@@ -556,8 +564,10 @@ static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void
 		return xfrm_api_check(dev);
 
 	case NETDEV_DOWN:
-	case NETDEV_UNREGISTER:
 		return xfrm_dev_down(dev);
+
+	case NETDEV_UNREGISTER:
+		return xfrm_dev_unregister(dev);
 	}
 	return NOTIFY_DONE;
 }


