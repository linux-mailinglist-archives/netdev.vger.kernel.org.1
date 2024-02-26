Return-Path: <netdev+bounces-75036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF550867D81
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 18:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C6E290855
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D712D742;
	Mon, 26 Feb 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WScrg72X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790112C7E1
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966555; cv=none; b=B+eRQtzmwgfProqfTM0+J6KfAXrUODcYmqO0kYbtu7QwMvQbRCgVjgVZPTtojR8QlqwLgeJmCW0XPhk/N/vsGLt8HEWd1zfg9P7oqiOn43hGb0ITclKm1SEuV7vkl60DlzX/DhidrE2T+/xcAbEXIpBBvnp2h2S+o6DaehpNM4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966555; c=relaxed/simple;
	bh=JOq3lqviDtrl9NeNiOhztrgD3KTxEElBq+udq1TblzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLmAF1QnRQnsb0/9aHEUINyhkU4/AkM027kkQcdv9ORZQ22NC5FDrrdFTPxaz1aT4rRWH93x+yAgwL6eO0/iPigu9i9b552twm15jxYWw69732sgWZZrYJphXDH+Ya4yp/6zNXp56bTiT4ST2g5KjLssV9fTmBve4DLgqTh4ACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WScrg72X; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ddebaf810so427293f8f.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708966551; x=1709571351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1SgTDb1TBWZfvYeM1qL0vbi7hXM4603oTckhYEImzY=;
        b=WScrg72XBk9ppGxISZIfD93pVlf/kXPAQj19CA/JQiFjpvMKth1YOFfyopRzkl+jDE
         QvndLGysKmHCes8Pir8dL5ulTapiRTSfwzCq8zI9ZE/CIBH3eX04ulZp8GbV9xDfnxTO
         1JTk6BzqoVYJlsQMGibSVI3bydakzeirH/Wg8yUlD6RNfhhUfNe0cCSof3h/vbPsomhr
         goOUVoX/evs+g1VKjH0PU9u1lfE1fLKbwR6eahboGNo9IUVmwKFr8Jkzfu6Kv7PJQSyA
         F0AWsM4WAmJ/91W+mP2ELBuWo03lKlmce+2TVp6ZCiCpb2QB7z05jD9w3UkdHsxW4qGL
         o02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966551; x=1709571351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1SgTDb1TBWZfvYeM1qL0vbi7hXM4603oTckhYEImzY=;
        b=mFmga6suKrgYuV/8f1vpElJrLtoBjqUQAk3jSurSj1ug5lJprfsIE8gnj1n+NVwvJI
         05p/+MCE9PuqkJ7Opq+iYa+Bg1qTVkaaZ6LtyR9JwVkTqUgOoAd+vazTNVNG8KFaRSsv
         RjchAxl+O7MMHlr7BnGsEHFMxUsipO6OH07H38W7yMKOT7OljadIY4/My5wBVDAVzNEl
         of3TqlwfvXLmvKCwO/syCn644RtgHvDuhpCw2OZmzITM+5vYQXElw56aecyZzPImckoM
         TOJf5sBNKO5HYq9QuPgVyCIfVErs92gvcEVez9iojTz/x/j95CVIr0e900LTWnyBvWao
         dkkA==
X-Forwarded-Encrypted: i=1; AJvYcCULYYkTlFHwAhRsBauhdy0E3AI+sP3KRZYzULU8srq91ODIx4MzNqsSvyHKaK0XXt35DOgnrapOhX2XZTWGK3LrUzNRBe5F
X-Gm-Message-State: AOJu0YwdB/+pBFnB98RjwH19txNBwycqwcuKeMpjfa+nY1DI4m4AxIta
	Enslc3muImS6+g9gH9YeXdNJz14TkvlmfgY+PzIfkgINNcjMZGGRbtvB118XP+o=
X-Google-Smtp-Source: AGHT+IEwaXfaHLMUoU5HShFDZbSJIy3iMt4C009T3hv6YfL3O83376PJZ5h25ClcKvQATmPTxm1HLw==
X-Received: by 2002:a5d:5f49:0:b0:33d:fb3:9021 with SMTP id cm9-20020a5d5f49000000b0033d0fb39021mr6400771wrb.54.1708966551369;
        Mon, 26 Feb 2024 08:55:51 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id i13-20020adfe48d000000b0033ae7d768b2sm8721686wrm.117.2024.02.26.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 08:55:50 -0800 (PST)
Date: Mon, 26 Feb 2024 17:55:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 13/13] ipv6: use xa_array iterator to implement
 inet6_netconf_dump_devconf()
Message-ID: <ZdzCkxLBi_JybU25@nanopsycho>
References: <20240226155055.1141336-1-edumazet@google.com>
 <20240226155055.1141336-14-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226155055.1141336-14-edumazet@google.com>

Mon, Feb 26, 2024 at 04:50:55PM CET, edumazet@google.com wrote:
>1) inet6_netconf_dump_devconf() can run under RCU protection
>   instead of RTNL.
>
>2) properly return 0 at the end of a dump, avoiding an
>   an extra recvmsg() system call.
>
>3) Do not use inet6_base_seq() anymore, for_each_netdev_dump()
>   has nice properties. Restarting a GETDEVCONF dump if a device has
>   been added/removed or if net->ipv6.dev_addr_genid has changed is moot.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>---
> net/ipv6/addrconf.c | 103 +++++++++++++++++++-------------------------
> 1 file changed, 44 insertions(+), 59 deletions(-)
>
>diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
>index 74c33b132073934290632a953bce8ee6a5124ca9..08b4728733e3ed16d139d2bd4b50328552b3c27f 100644
>--- a/net/ipv6/addrconf.c
>+++ b/net/ipv6/addrconf.c
>@@ -727,17 +727,18 @@ static u32 inet6_base_seq(const struct net *net)
> 	return res;
> }
> 
>-
> static int inet6_netconf_dump_devconf(struct sk_buff *skb,
> 				      struct netlink_callback *cb)
> {
> 	const struct nlmsghdr *nlh = cb->nlh;
> 	struct net *net = sock_net(skb->sk);
>-	int h, s_h;
>-	int idx, s_idx;
>+	struct {
>+		unsigned long ifindex;
>+		unsigned int all_default;
>+	} *ctx = (void *)cb->ctx;
> 	struct net_device *dev;
> 	struct inet6_dev *idev;
>-	struct hlist_head *head;
>+	int err = 0;
> 
> 	if (cb->strict_check) {
> 		struct netlink_ext_ack *extack = cb->extack;
>@@ -754,64 +755,47 @@ static int inet6_netconf_dump_devconf(struct sk_buff *skb,
> 		}
> 	}
> 
>-	s_h = cb->args[0];
>-	s_idx = idx = cb->args[1];
>-
>-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
>-		idx = 0;
>-		head = &net->dev_index_head[h];
>-		rcu_read_lock();
>-		cb->seq = inet6_base_seq(net);
>-		hlist_for_each_entry_rcu(dev, head, index_hlist) {
>-			if (idx < s_idx)
>-				goto cont;
>-			idev = __in6_dev_get(dev);
>-			if (!idev)
>-				goto cont;
>-
>-			if (inet6_netconf_fill_devconf(skb, dev->ifindex,
>-						       &idev->cnf,
>-						       NETLINK_CB(cb->skb).portid,
>-						       nlh->nlmsg_seq,
>-						       RTM_NEWNETCONF,
>-						       NLM_F_MULTI,
>-						       NETCONFA_ALL) < 0) {
>-				rcu_read_unlock();
>-				goto done;
>-			}
>-			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
>-cont:
>-			idx++;
>-		}
>-		rcu_read_unlock();
>+	rcu_read_lock();
>+	for_each_netdev_dump(net, dev, ctx->ifindex) {
>+		idev = __in6_dev_get(dev);
>+		if (!idev)
>+			continue;
>+		err = inet6_netconf_fill_devconf(skb, dev->ifindex,
>+					         &idev->cnf,
>+						 NETLINK_CB(cb->skb).portid,
>+						 nlh->nlmsg_seq,
>+						 RTM_NEWNETCONF,
>+						 NLM_F_MULTI,
>+						 NETCONFA_ALL);
>+		if (err < 0)
>+			goto done;
> 	}
>-	if (h == NETDEV_HASHENTRIES) {
>-		if (inet6_netconf_fill_devconf(skb, NETCONFA_IFINDEX_ALL,
>-					       net->ipv6.devconf_all,
>-					       NETLINK_CB(cb->skb).portid,
>-					       nlh->nlmsg_seq,
>-					       RTM_NEWNETCONF, NLM_F_MULTI,
>-					       NETCONFA_ALL) < 0)
>+	if (ctx->all_default == 0) {
>+		err = inet6_netconf_fill_devconf(skb, NETCONFA_IFINDEX_ALL,
>+						 net->ipv6.devconf_all,
>+						 NETLINK_CB(cb->skb).portid,
>+						 nlh->nlmsg_seq,
>+						 RTM_NEWNETCONF, NLM_F_MULTI,
>+						 NETCONFA_ALL);
>+		if (err < 0)
> 			goto done;
>-		else
>-			h++;
>-	}
>-	if (h == NETDEV_HASHENTRIES + 1) {
>-		if (inet6_netconf_fill_devconf(skb, NETCONFA_IFINDEX_DEFAULT,
>-					       net->ipv6.devconf_dflt,
>-					       NETLINK_CB(cb->skb).portid,
>-					       nlh->nlmsg_seq,
>-					       RTM_NEWNETCONF, NLM_F_MULTI,
>-					       NETCONFA_ALL) < 0)
>+		ctx->all_default++;
>+	}
>+	if (ctx->all_default == 1) {
>+		err = inet6_netconf_fill_devconf(skb, NETCONFA_IFINDEX_DEFAULT,
>+						 net->ipv6.devconf_dflt,
>+						 NETLINK_CB(cb->skb).portid,
>+						 nlh->nlmsg_seq,
>+						 RTM_NEWNETCONF, NLM_F_MULTI,
>+						 NETCONFA_ALL);
>+		if (err < 0)
> 			goto done;
>-		else
>-			h++;
>+		ctx->all_default++;
> 	}
>-done:
>-	cb->args[0] = h;
>-	cb->args[1] = idx;
>-
>-	return skb->len;
>+done:	if (err < 0 && likely(skb->len))

It is common to not mix label and other statement on the same line,
could you split?

Otherwise the patch and the set looks good to me. Thanks!


>+		err = skb->len;
>+	rcu_read_unlock();
>+	return err;
> }
> 
> #ifdef CONFIG_SYSCTL
>@@ -7503,7 +7487,8 @@ int __init addrconf_init(void)
> 	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETNETCONF,
> 				   inet6_netconf_get_devconf,
> 				   inet6_netconf_dump_devconf,
>-				   RTNL_FLAG_DOIT_UNLOCKED);
>+				   RTNL_FLAG_DOIT_UNLOCKED |
>+				   RTNL_FLAG_DUMP_UNLOCKED);
> 	if (err < 0)
> 		goto errout;
> 	err = ipv6_addr_label_rtnl_register();
>-- 
>2.44.0.rc1.240.g4c46232300-goog
>
>

