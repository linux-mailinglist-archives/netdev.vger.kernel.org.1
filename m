Return-Path: <netdev+bounces-53908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8908052EF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDADB20AAC
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F07697A0;
	Tue,  5 Dec 2023 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FUQoGTGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E7194
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:32:59 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1b54b58769so314172966b.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 03:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701775978; x=1702380778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tv9XLg6MlJCdPv406C0pq2rG0T1o4izYF5fwvfAV4Ow=;
        b=FUQoGTGH3WKQdA8oqoHVLd0FYr7la8l5SiqeJtBYuE8u3XXhfkTpN70aOqQkzVjowI
         wdXx0pyUs26TDW9x98kyzjZYtdZizitjQvF/G7VfQORZYKcijpqa+ZWrklRks/OMvx/S
         MhBjEaryeMzesoCnEB501iJMZ3i0eiVAnb1oqkmdSfDAKhqg7ppv+5++IDu5zwgLnObe
         CaqC5qLnQPuraEqrif98vSFS4Tk1uqaYiPVfkv7xmoksHYejC+eDICdHwmsX8nmOO4Zp
         AKAINGHEHPI1F/VKGN8irnk+qNnfBnNV0IJ9mNCqoVt0gJqvITnvuH2Jw4aXVksVRsee
         nt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775978; x=1702380778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv9XLg6MlJCdPv406C0pq2rG0T1o4izYF5fwvfAV4Ow=;
        b=eehUzlwt8S06aaOeOFibMaiWbj7qAiJ/YFuZ7vzgQEY9sbuUnd2ewZlNPmB3kmIs3s
         bzponHjZbzuSNY3qqnALTdrhc7i/KsirpEgpo/mHmZfIXOf39ZF4sDqmxhp8oLrhnyCj
         m4k8+3c3Ri4NvvyncLEjA/4+JBR2hLTWmVKlLCXHzcpQKjZoetafeBrwBOjjZf40Ymrx
         uO7vQI41WJkz2/Ab09isG7p7zzMhJzVbh0I8nHXudbCrfVB9Re31RsmLZAOLzI+IlQ6W
         XOowEZ3cUesmSYZBOpogEhB1dQCqwo7iVX5cxFRFwL8vuvVbrXMftz0SUCaKRZxU8RWI
         uFCA==
X-Gm-Message-State: AOJu0Yx7pLkpDWzynWf8DrCEl0Az6/6E//DkiMpF6xugmlZbbPq/DNAr
	H91DYgiPkchd1ADQkbToBaEvEzfjhYdTmxcNPoQ=
X-Google-Smtp-Source: AGHT+IH2UUp+xAHdTHpItaVUPmVHfPdTAtFKuKE9cR6DV/lGWOwgPWZNY9bLxwaKCMFrV+Xi7VUs9w==
X-Received: by 2002:a17:906:201:b0:a0c:d99b:7ad with SMTP id 1-20020a170906020100b00a0cd99b07admr402377ejd.23.1701775978356;
        Tue, 05 Dec 2023 03:32:58 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id gn8-20020a1709070d0800b00a1b721dded0sm2572448ejc.208.2023.12.05.03.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:32:57 -0800 (PST)
Date: Tue, 5 Dec 2023 12:32:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com,
	vladbu@nvidia.com
Subject: Re: [PATCH net-next v2 4/5] net/sched: act_api: conditional
 notification of events
Message-ID: <ZW8KaANgu0DpryWV@nanopsycho>
References: <20231204203907.413435-1-pctammela@mojatatu.com>
 <20231204203907.413435-5-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204203907.413435-5-pctammela@mojatatu.com>

Mon, Dec 04, 2023 at 09:39:06PM CET, pctammela@mojatatu.com wrote:
>As of today tc-action events are unconditionally built and sent to
>RTNLGRP_TC. As with the introduction of tc_should_notify we can check
>before-hand if they are really needed.
>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>---
> net/sched/act_api.c | 105 ++++++++++++++++++++++++++++++++------------
> 1 file changed, 76 insertions(+), 29 deletions(-)
>
>diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>index c39252d61ebb..55c62a8e8803 100644
>--- a/net/sched/act_api.c
>+++ b/net/sched/act_api.c
>@@ -1780,31 +1780,45 @@ static int tcf_action_delete(struct net *net, struct tc_action *actions[])
> 	return 0;
> }
> 
>-static int
>-tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
>+static struct sk_buff *tcf_reoffload_del_notify_msg(struct net *net,

I wonder, why this new function is needed? If I'm reading things
correctly, tcf_reoffload_del_notify() with added check would be just ok,
woundn't it?

Same for others.

>+						    struct tc_action *action)
> {
> 	size_t attr_size = tcf_action_fill_size(action);
> 	struct tc_action *actions[TCA_ACT_MAX_PRIO] = {
> 		[0] = action,
> 	};
>-	const struct tc_action_ops *ops = action->ops;
> 	struct sk_buff *skb;
>-	int ret;
> 
>-	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
>-			GFP_KERNEL);
>+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);

I don't see how this is related to this patch. Can't you do it in separate
patch?

Same for others.

> 	if (!skb)
>-		return -ENOBUFS;
>+		return ERR_PTR(-ENOBUFS);
> 
> 	if (tca_get_fill(skb, actions, 0, 0, 0, RTM_DELACTION, 0, 1, NULL) <= 0) {
> 		kfree_skb(skb);
>-		return -EINVAL;
>+		return ERR_PTR(-EINVAL);
> 	}
> 
>+	return skb;
>+}
>+

[...]

