Return-Path: <netdev+bounces-163579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE9A2AD0C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A017A285C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB6C1F4169;
	Thu,  6 Feb 2025 15:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918734C8E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857122; cv=none; b=mO/uiJ20q1I3n/Qmhxpr7Gzh4JYN5opU4axhsBs4etfmIHbzaalzpSNA837o2/sQ6nl3pdl34zLs2vq1G9/VDL5Z04TGPxzrdxCK+JJy2wnlHOlWhl+DTwdWE0C6snW5PYmAtzJdeIia+kLvGj2VxVNBN0K0nGbFC/+CzbtJarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857122; c=relaxed/simple;
	bh=ukqqqE2k1aVRmMvYA/TAh2FMUzu+oahWgtuLTb9OCRg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dbcWOV9MO98pxydCTT9+KHdEAacAa+Yp1XMc1t491YT6XZskjTopjOwj7ocvqQ9HJkI6gGnptJT85VruQIa7F98VCE7IAV9A85G7Rlsmd5l1+hdAs5cV3+S3auJIXrBcukyWQaY2+JIExud/EaXKNc4/gxpPvEgMR7Mx/axemUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so218990266b.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 07:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738857119; x=1739461919;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ks6HDYNpkanxX5TcHyJb08tU6kgEMiqJau/hJ+RtZio=;
        b=O5h9DgWVaNKL4ajpHZ+P5M44E6jnQiKxP1nzbsMn6Y49iPWgcxila5VTbNUuJshgIu
         XvqeWf5Af6VyPVUJv2yGDmXjqstZD8Uc/05/psGd1eYgsFr5B0aBhwzM820vDblDxgqg
         g+fELB+3VP2Tk23VNDqW5sz33O3YNVxy4pz36rdnGQA2/hxa0LJzPtl4l44uSh9fICRi
         EC7bNn4fMdhjYEGPNccQ6icUC6AhEcI7QjKh0AmUC2mBPAhXqSMMewB8cfRGWem4HyyC
         BKgBkfoovjBjEPl3SVsjaRp7rkT/PEfwexc7JKO16KHAs4exoRi7ZBQXvkPABh0ij2k0
         u4Pg==
X-Gm-Message-State: AOJu0Yx5reqhnxmd6jwTlX+bkVwudC7Vv1JL2Ve9NXGPJH8ZBGgkhbzC
	e2kMpWb125FzusL/M9XPg7Yyj19kY1FGVEwR0EHbGzkiiWq4NzRQ
X-Gm-Gg: ASbGncvVtlo+Bni2QqIieTA/SqcJBqpIQskPDO8wxWRjA1n71y+OGTrR/yoTDLHkFbt
	ezA2y62CubDmhlRC+Ou+c4BcSAmfafh0Mlmsw7CkhyQ0EnTBHHS4YNWTZdEQjTjNFYAmMmQe4ri
	qXKjcR8dbXB8Y5eA380m3izHM7VKsHItxgDwfU01W+ZrK9BPt704w8rjypEGdI8ljkM9QPY322x
	OIWXFGx3SrXflRPV+8GZ/m9p6LKCFKI1QkBr915vqfCrQdtYBZ0aYbec7KBnmqVSu/cco+RjgfV
	pfc9qg==
X-Google-Smtp-Source: AGHT+IG/g5M+wh4c5KYO2Hmd0HNqC9l3FrW6iPYb7yJhEx1HJ0RIzp+MU8p4JX7YN74E0vocHdvkeg==
X-Received: by 2002:a17:907:26cd:b0:ab2:d8e7:682c with SMTP id a640c23a62f3a-ab75e345cb1mr665391966b.38.1738857118532;
        Thu, 06 Feb 2025 07:51:58 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7736468e7sm117774466b.172.2025.02.06.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 07:51:57 -0800 (PST)
Date: Thu, 6 Feb 2025 07:51:55 -0800
From: Breno Leitao <leitao@debian.org>
To: kuniyu@amazon.com, kuba@kernel.org, edumazet@google.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, ushankar@purestorage.com, kernel-team@meta.com
Subject: for_each_netdev_rcu() protected by RTNL and CONFIG_PROVE_RCU_LIST
Message-ID: <20250206-scarlet-ermine-of-improvement-1fcac5@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

We're seeing CONFIG_PROVE_RCU_LIST warnings when for_each_netdev_rcu()
is called with RTNL held. While RTNL provides sufficient locking, the
RCU list checker isn't aware of this relationship, leading to false
positives like:

	WARNING: suspicious RCU usage
	net/core/dev.c:1143 RCU-list traversed in non-reader section!!

The initial discussion popped up in:

	https://lore.kernel.org/all/20250205-flying-coucal-of-influence-0dcbc3@leitao/

I've attempted a solution by modifying for_each_netdev_rcu():

	diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
	index 2a59034a5fa2f..59b18b58fa927 100644
	--- a/include/linux/netdevice.h
	+++ b/include/linux/netdevice.h
	@@ -3210,13 +3210,14 @@ netdev_notifier_info_to_extack(const struct netdev_notifier_info *info)
	int call_netdevice_notifiers(unsigned long val, struct net_device *dev);
	int call_netdevice_notifiers_info(unsigned long val,
					struct netdev_notifier_info *info);
	+bool lockdep_rtnl_net_is_held(struct net *net);

	#define for_each_netdev(net, d)		\
			list_for_each_entry(d, &(net)->dev_base_head, dev_list)
	#define for_each_netdev_reverse(net, d)	\
			list_for_each_entry_reverse(d, &(net)->dev_base_head, dev_list)
	#define for_each_netdev_rcu(net, d)		\
	-		list_for_each_entry_rcu(d, &(net)->dev_base_head, dev_list)
	+		list_for_each_entry_rcu(d, &(net)->dev_base_head, dev_list, lockdep_rtnl_net_is_held(net))
	#define for_each_netdev_safe(net, d, n)	\
			list_for_each_entry_safe(d, n, &(net)->dev_base_head, dev_list)
	#define for_each_netdev_continue(net, d)		\

However, I have concerns about using lockdep_rtnl_net_is_held() since it
has a dependency on CONFIG_DEBUG_NET_SMALL_RTNL.

Are there better approaches to silence these warnings when RTNL is held?
Any suggestions would be appreciated.

Thanks
--breno

