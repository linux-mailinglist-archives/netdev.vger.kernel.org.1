Return-Path: <netdev+bounces-240097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5BC70696
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 39BFB28FFC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA2304BAB;
	Wed, 19 Nov 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Pmp696kM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154C221F1C
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572764; cv=none; b=E9MUhPZJrRwq6rfRSFsuxxi5CNmLWbCnpHqka4LSecV5c5lQEoBJY0d3o+nxkk72yuSFs5Xn2xbGKRdT/uhWnkApLd/LaN5GLRz+uO/34eGq5TT91cO1kkOB5RR3jHvx5XJiSHRKSGJ4tG8wHeLFzEBwaUDATI3xQqLbqS3USxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572764; c=relaxed/simple;
	bh=gNR2CH6URBSS+x+N11S+9bfKkAM+OJKtD2Lbly//bsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTJ7Ia1SkTVauwzNx8zoPz755udb+EfBraInXRVdJf4Yc1ZZDFnxOrZYOEqS+R3pe8gN5JyYG8CZXRSumEaXWA8iM00GzZ+7IaotS+3VCIUGeRCao1xEIv/Kb2rZvxaMar8BxWdwfGTdOtfbP8K4Lw2l0RBqWjtrTNUZGQ/VIVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Pmp696kM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7277324204so3745266b.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763572760; x=1764177560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36SFT6v0h0oWAaIvAgyj1SIHImWSTq5c974mvaEj1/E=;
        b=Pmp696kME/skZTTqLDIhZbli4xEix2YzegBlm9e6RYMGHv70LwKvkq0PxA5Rgd3yC9
         aY9ogzKPNA+qYIEG4sInXUiplk3omV+ug1mXFpQLmDdgvMuWLzGBpQnX5R8BhXBsT+AF
         N8kmjA801XSgadTXIlfH+MrO2dPSDUZoJi4Huo5xG7o7af3a+rW8qdSeynCXeXispyj8
         FNdN09huYDBOda0Xa+UzJGjHXo8pVYlKkGOR/G6jfrbobsN1Pw96khnJ59NHF5OKANdK
         BBLnueOqjYM7HvzwpWvuXK4sm7Sb+w661oP9m+sKWwp6mm2hTpGkRT/fGaYJ5ihl1Gsw
         uW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572760; x=1764177560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36SFT6v0h0oWAaIvAgyj1SIHImWSTq5c974mvaEj1/E=;
        b=rQm25s/MajJSq40cGriKdl+D4LXjjMN08aASNt2LaThfrmqBxCVj3PP8y/IEgkdBni
         KbdGvq4f0ekeE7qDoVbJ+d+8Wjttmkvy+2Vt1IAw6Xrpc+MHT4oqWF07JqerhsuI8Wm+
         PpUGlQ9Vx4GnUt7VrcXCMdfdFm6pEimArjA1atn+wXMz1lG6gTnZzibIfdtHLVzHrxvn
         jW6IsDb3KSxHmCzK4rPXvTMbELBuzysrNGBFr66/CAxUa50BpkufLboScl8DjwHHFW4o
         WSfGQcmklKAmPhzxQj3KglWTmLXt8A1fAiyVT/HGXJs+a2oSIe+aJiIDnorFz0X8g3Fu
         jSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxsaa4vQBIxbzK3LicZH0PDOpUbsPTeELK/xCjDbDv7lGeWJtZLDgGkf9e6XtR1NfGwZ0RYSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uMHmkvFQi+9Dty3SAwDy7Qn2jPt1LHRKKJ8Wo1xTfIqL1x9N
	7UUt+h2a42+Q1SJCOgMSFtWMbYAv+TsvD3apARoQQKiDUNwDJTp7sDap70lWOYbeTmU=
X-Gm-Gg: ASbGncstiW4MRl3UCcR2fsd1a5fY55LnlYXkolSJa9Wxp8hv3rxvNiUzIVN7yjbTRdW
	734guLXueb82eiQ1cVkYu/baQDI4EPVFs+8Qcy4Lr+KKhe7yOT3ZUjY2VspDOwgjJTIIHxpDyXv
	tCga4Olt2vEfFAQPZNa5uGRqZcO/5K4KgzQiESyqxNA/aMcOQ2yC8zpZb7lHb/EwS5hQm9TC+Ev
	eyrAp79IEdbZjViy2Zi0HyL+vLJV9E/QPzPyDKrKpJIzqWlconDjIN4RBru82Pkcxn+CRZ8vOap
	KfqSzHjnO//DjlzLOoZDnjugua1sTkPMTWLZvIxBHaOEesi8tbxbed4cdCfgLITvGP/PUncbrK4
	Q4M1UFEp4j2OxTVDbJp3zr/h6oE3my+yBAgtJDOaiRI23m6TQG6/qp6Bvaf9Zs2xtNnzqsUTqN0
	qXzjuX7v+zw3YX6NyajxLnMfXdPa+NZdI45A==
X-Google-Smtp-Source: AGHT+IH9+XFQyArsdxNHpXss93zNBGsU+2ybJ8OEmLFx5FM9wyytGdQWCT435AKHss7589fWckxsBA==
X-Received: by 2002:a17:907:7283:b0:b74:984c:a3de with SMTP id a640c23a62f3a-b74984ca8e1mr1047109466b.28.1763572760228;
        Wed, 19 Nov 2025 09:19:20 -0800 (PST)
Received: from FV6GYCPJ69 ([213.195.231.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdaa15asm1625232566b.57.2025.11.19.09.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 09:19:19 -0800 (PST)
Date: Wed, 19 Nov 2025 18:19:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [bug report] devlink: Move devlink dev reload code to dev
Message-ID: <35ekvmjyb4ty5vdkyspwirz4qoahotpow22zt4vkonqjmtqziz@yk6pwla34ayn>
References: <aR2GHqHTWg0-fblr@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2GHqHTWg0-fblr@stanley.mountain>

Wed, Nov 19, 2025 at 09:55:58AM +0100, dan.carpenter@linaro.org wrote:
>Hello Moshe Shemesh,
>
>Commit c6ed7d6ef929 ("devlink: Move devlink dev reload code to dev")
>from Feb 2, 2023 (linux-next), leads to the following Smatch static
>checker warning:
>
>	net/devlink/dev.c:408 devlink_netns_get()
>	error: potential NULL/IS_ERR bug 'net'
>
>net/devlink/dev.c
>    378 static struct net *devlink_netns_get(struct sk_buff *skb,
>    379                                      struct genl_info *info)
>    380 {
>    381         struct nlattr *netns_pid_attr = info->attrs[DEVLINK_ATTR_NETNS_PID];
>    382         struct nlattr *netns_fd_attr = info->attrs[DEVLINK_ATTR_NETNS_FD];
>    383         struct nlattr *netns_id_attr = info->attrs[DEVLINK_ATTR_NETNS_ID];
>    384         struct net *net;
>    385 
>    386         if (!!netns_pid_attr + !!netns_fd_attr + !!netns_id_attr > 1) {
>    387                 NL_SET_ERR_MSG(info->extack, "multiple netns identifying attributes specified");
>    388                 return ERR_PTR(-EINVAL);
>    389         }
>    390 
>    391         if (netns_pid_attr) {
>    392                 net = get_net_ns_by_pid(nla_get_u32(netns_pid_attr));
>
>Smatch thinks that the "net = get_net(nsproxy->net_ns);" could mean that
>get_net_ns_by_pid() returns NULL.  I don't know if that's correct or not.
>If someone could tell me, then it's easy for me to add a line
>"get_net_ns_by_pid 0" to the smatch_data/db/kernel.delete.return_states
>file but I'd prefer to be sure before I do that...

I don't see how get_net() can return NULL.


>
>    393         } else if (netns_fd_attr) {
>    394                 net = get_net_ns_by_fd(nla_get_u32(netns_fd_attr));
>    395         } else if (netns_id_attr) {
>    396                 net = get_net_ns_by_id(sock_net(skb->sk),
>    397                                        nla_get_u32(netns_id_attr));
>    398                 if (!net)
>    399                         net = ERR_PTR(-EINVAL);
>    400         } else {
>    401                 WARN_ON(1);
>    402                 net = ERR_PTR(-EINVAL);
>    403         }
>    404         if (IS_ERR(net)) {
>    405                 NL_SET_ERR_MSG(info->extack, "Unknown network namespace");
>    406                 return ERR_PTR(-EINVAL);
>    407         }
>--> 408         if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
>    409                 put_net(net);
>    410                 return ERR_PTR(-EPERM);
>    411         }
>    412         return net;
>    413 }
>
>regards,
>dan carpenter
>

