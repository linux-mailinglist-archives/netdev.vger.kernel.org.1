Return-Path: <netdev+bounces-102060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57769014EA
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 10:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77A51C20D1B
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B04D18EB0;
	Sun,  9 Jun 2024 08:17:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ECDA3F
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921075; cv=none; b=nMAiE7oisd8RsemVrc6wp2X/eAcfVHlymyF1edGvDJnKfA049vr7A8ofePgZ1Y2mayzLLu7P6wZAIgJHyc8xwoRaqD33dr4p6mjblt9YbbpPd4SnITWBYdmz4BdW0oF5EMBEBMQLt7uoehL8MsVXgRrfy/3JrizF8yYbbFr7nxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921075; c=relaxed/simple;
	bh=SFKUrA8AAGTjwnfzlh9Ce7Wk4QLXaabWszoMYiTbdGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjjzuvssHAlAxe26tE5Nu/aUzMCB4OciXR8tN00AnFKFgryDjjovHzrXWoZFJ5q1wLh3FHSsvkfeeY7YPs5rTUBicjMt5N6rWFAEBgrahDUBUXOijakXpRXG5q06n+y5qmaZQxhEQSj8/lLf4sG6YUYAQH+HYlAuhwbAM9Y0qg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4598Hn96001113;
	Sun, 9 Jun 2024 17:17:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sun, 09 Jun 2024 17:17:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4598HnKe001109
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 9 Jun 2024 17:17:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cbbd6e2d-39da-4da3-b239-1248ac8ded10@I-love.SAKURA.ne.jp>
Date: Sun, 9 Jun 2024 17:17:48 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/14] netlink: hold nlk->cb_mutex longer in
 __netlink_dump_start()
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
References: <20240222105021.1943116-1-edumazet@google.com>
 <20240222105021.1943116-7-edumazet@google.com> <Zdd0SWlx4wH-sXbe@nanopsycho>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Zdd0SWlx4wH-sXbe@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello.

While investigating hung task reports involving rtnl_mutex, I came to
suspect that commit b5590270068c ("netlink: hold nlk->cb_mutex longer
in __netlink_dump_start()") is buggy, for that commit made only
mutex_lock(nlk->cb_mutex) side conditionally. Why don't we need to make
mutex_unlock(nlk->cb_mutex) side conditionally?

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index fa9c090cf629..c23a8d4ddcae 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2352,7 +2352,8 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 
 	if (nlk->dump_done_errno > 0 ||
 	    skb_tailroom(skb) < nlmsg_total_size(sizeof(nlk->dump_done_errno))) {
-		mutex_unlock(&nlk->nl_cb_mutex);
+		if (!lock_taken)
+			mutex_unlock(&nlk->nl_cb_mutex);
 
 		if (sk_filter(sk, skb))
 			kfree_skb(skb);
@@ -2386,13 +2387,15 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	WRITE_ONCE(nlk->cb_running, false);
 	module = cb->module;
 	skb = cb->skb;
-	mutex_unlock(&nlk->nl_cb_mutex);
+	if (!lock_taken)
+		mutex_unlock(&nlk->nl_cb_mutex);
 	module_put(module);
 	consume_skb(skb);
 	return 0;
 
 errout_skb:
-	mutex_unlock(&nlk->nl_cb_mutex);
+	if (!lock_taken)
+		mutex_unlock(&nlk->nl_cb_mutex);
 	kfree_skb(skb);
 	return err;
 }


