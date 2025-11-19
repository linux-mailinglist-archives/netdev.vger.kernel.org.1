Return-Path: <netdev+bounces-239884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E4C6D884
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 176C928B17
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A5314B93;
	Wed, 19 Nov 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kURYeSdG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D4E30AADC
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542568; cv=none; b=lJ399INRbVqcDwtTIk/5aKE5q8ApXho5RHYk0ps51M36MWd5GRI5CXVnEcr6cjkfPDGj3UAfkmIcHru/f8QuMND/8NDfGRvKFlXTxKEdjBj1uITAtiphmvG7+84ja/BL0OcvilUH0n9vPU6qDHRraiNVb4IeNT0+eculjWpf8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542568; c=relaxed/simple;
	bh=aygYqcN6DbPL+9YOMaKjW2uVedrCGUGI/puL8gk1w7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DNf4A06OaB+JmIOaXJXH4uOaVnKH/qREM+OAWuAD9oN56LJvWI60cr5/1BVuH1w9C6eAiE8kbaa5vlAo6o4R95aGae+9DibGM70pIE5hxeCQPbug2ikBxLdf7aIogXRpvIQtfg9e8ENOrI0nUReN8WrEm3aasRyPAcZ0xvVHfAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kURYeSdG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47789cd2083so43839565e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763542564; x=1764147364; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ub8VA87UVhC998u/Q5U1WNuABffKD2IBy+bs92msj4c=;
        b=kURYeSdGu7Hgfg+WrZZh75sbLFlRg76W1hgaipFKAYmwfwhDAojiQXcwGa4nbPj8BZ
         Pfz5sjTuuT6tS+oZqw3C0FPg3wBm68NC36F5cplkHlRdxV64icOklZA5IKMcrkM/1KSH
         6vd97EHq8cH1k7Xn6f2QusvHvKbqDv+Xj3NbZd3urFJ5jg/T6M90OVJQ2amP/kvvlHO8
         0gMbRBcCLQqxeSGHqWcbps84v2HoGu2OU6XsomMJw5DxAGJPbGOfKeCrwZHSGZrQ6jlm
         ydw3MLXAeY+Zs6tp6A9YBIsRhMg/QLZymU9Oe8IBEs/Z7o5BcSL2FFKICsDyUSlTnybZ
         W0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763542564; x=1764147364;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ub8VA87UVhC998u/Q5U1WNuABffKD2IBy+bs92msj4c=;
        b=XVscVJ9MqmPpQVlkxjZTvWe5SAw744kt7d4JfErvkCO3y61FfJZvhXvkNyvmawnhop
         ISsPNlvuefv5Xn0jD9cfyk4LOmVw75wQJjfS6fkMGB2fMufghxEA9PCaYjJpAz0fE7bk
         vmBCzozOyjQHr1rLOMuva9xVxqQ/eLrrSsLYTS6D5WQzY9hgXJeHbB+WScWC7C0yjAk0
         VnhOGa+pOul+WZOtS8RyUCbBy1H4873CqP24pRsXELErrAsRvR6GNJHrx1uVI/1aQa86
         BRlhP3UXKBdYxq0/soCYM+e6x0uVzKpfDNKHAcz2EjX6ut3tUuSfEZHnTo4bbjCxHqDj
         P0ag==
X-Gm-Message-State: AOJu0YzzbOp3a4GW0Nzi/f1IKzIo5VjbNHeJnGmEw5+ClZ6JeXEaG/zH
	xtXDrg39hAVKqfvaFIZihlUg0FciXyaSRVAyX1IsuqZnGMqFsRB3KLshMrbINRpvU+k=
X-Gm-Gg: ASbGncuqfavExueXBilYVPRIjLIG4dMt/OJY+E03p1lYWq/ley9cV/5RF6oxQyyitIz
	PMIzVY2wJnB86BhsFBxUxv23mTWB6Yb2FJ+DGLV3TZrvZMqhDuqzKZtjqv81nwygMV2DMCCuqvp
	XFyxX9reKKaHJXZbBgsI0VKVY6XHt5lZKjdridbF4dlnEjNGWMoto8wT6LO5IL+QYjcqd0Lys9f
	JYWvkHUIWa7X9Mqudqhwcwuu3TZcxCRQdPPjxDFKCCeNxOcPJVxzG+BZnQVs+FRP4MdDmg45udO
	/vDr4/dCWNuhJihfs9cI53TxEAm+OfHXEm4O5vFpZPYzPCFbIuaFiDeDRlCrPAuuPkfUxg8wBEM
	eB5rW75p1w8zKOrmtmFkDt78RXVU5EzhY2NPnu3FPdQgA+KQ2zNWk0LYodmORxQgcTExoSRU87P
	+af8NAzBqjB9xORz/9q7eaRRURCfY=
X-Google-Smtp-Source: AGHT+IE1LyNOXB27xzO2V909q4sd8b9P1658pihIg+a1peM8WFSDvphctbUhcaLLXqLuuLLBrg7u0g==
X-Received: by 2002:a05:600c:3b12:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-4778fe5c87amr177672355e9.9.1763542563914;
        Wed, 19 Nov 2025 00:56:03 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477b0faf295sm38299435e9.0.2025.11.19.00.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 00:56:03 -0800 (PST)
Date: Wed, 19 Nov 2025 11:55:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] devlink: Move devlink dev reload code to dev
Message-ID: <aR2GHqHTWg0-fblr@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Moshe Shemesh,

Commit c6ed7d6ef929 ("devlink: Move devlink dev reload code to dev")
from Feb 2, 2023 (linux-next), leads to the following Smatch static
checker warning:

	net/devlink/dev.c:408 devlink_netns_get()
	error: potential NULL/IS_ERR bug 'net'

net/devlink/dev.c
    378 static struct net *devlink_netns_get(struct sk_buff *skb,
    379                                      struct genl_info *info)
    380 {
    381         struct nlattr *netns_pid_attr = info->attrs[DEVLINK_ATTR_NETNS_PID];
    382         struct nlattr *netns_fd_attr = info->attrs[DEVLINK_ATTR_NETNS_FD];
    383         struct nlattr *netns_id_attr = info->attrs[DEVLINK_ATTR_NETNS_ID];
    384         struct net *net;
    385 
    386         if (!!netns_pid_attr + !!netns_fd_attr + !!netns_id_attr > 1) {
    387                 NL_SET_ERR_MSG(info->extack, "multiple netns identifying attributes specified");
    388                 return ERR_PTR(-EINVAL);
    389         }
    390 
    391         if (netns_pid_attr) {
    392                 net = get_net_ns_by_pid(nla_get_u32(netns_pid_attr));

Smatch thinks that the "net = get_net(nsproxy->net_ns);" could mean that
get_net_ns_by_pid() returns NULL.  I don't know if that's correct or not.
If someone could tell me, then it's easy for me to add a line
"get_net_ns_by_pid 0" to the smatch_data/db/kernel.delete.return_states
file but I'd prefer to be sure before I do that...

    393         } else if (netns_fd_attr) {
    394                 net = get_net_ns_by_fd(nla_get_u32(netns_fd_attr));
    395         } else if (netns_id_attr) {
    396                 net = get_net_ns_by_id(sock_net(skb->sk),
    397                                        nla_get_u32(netns_id_attr));
    398                 if (!net)
    399                         net = ERR_PTR(-EINVAL);
    400         } else {
    401                 WARN_ON(1);
    402                 net = ERR_PTR(-EINVAL);
    403         }
    404         if (IS_ERR(net)) {
    405                 NL_SET_ERR_MSG(info->extack, "Unknown network namespace");
    406                 return ERR_PTR(-EINVAL);
    407         }
--> 408         if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
    409                 put_net(net);
    410                 return ERR_PTR(-EPERM);
    411         }
    412         return net;
    413 }

regards,
dan carpenter

