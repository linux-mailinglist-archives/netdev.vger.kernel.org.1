Return-Path: <netdev+bounces-54317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FEA8068F9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 08:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40B7281CEF
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE3182CA;
	Wed,  6 Dec 2023 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="giv24QfG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B69D65
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 23:53:56 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca208940b3so5703051fa.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 23:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701849234; x=1702454034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0HKekEiaC+hgm7YlUHFNWq+Xaz94fy3Pwc/4RQIjig=;
        b=giv24QfGOKUp36/K5NExvxslz/InqBrI1+bcQDPNSd+gKa0Z4q4PF3U/hai1VyPPg8
         46A3iVaLskR0DQOoTxIWInBt8VQxcZMXaf2HUzLIkUicUOLRdK4PvaLWc0eg2SVRRhRL
         HnGiwu/yG80Tx9+SJVbLK6FqZCtHGR9i3VLrKN+D8G+vE8+RX2ie0eBoq06C5ZQfr4i+
         +Jv/cZHrM0TNsnhS8ssb13et9Vx0FLSkI26INjzOV8gmw8x3ogipY3bWs76wSchgGgBg
         bDiyMHuCaWOW7x3WFIzDwG7CrqNAvKtyWvxHdNN4PotKxe5CVjtQf+Q772d+7K5hLgqA
         umHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701849234; x=1702454034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0HKekEiaC+hgm7YlUHFNWq+Xaz94fy3Pwc/4RQIjig=;
        b=HaTnsZvXR9b44G/e6pKtHyHxJtMUMjPMvFT8c9JWFpgmaWv5eGUZS/1xXwTY7p0MFf
         WhoJEhtrxWkfWzl+SFrCTRN48r6dWtBiyaYKIzKU7keF4dAF+bg6hivLpRZBAUoJoXXh
         zg57HaXg/9j2hrbJEiWj66JQXBrH79AHpARKWwryHRPAH3CSPZWiDJIIbBEVsPjPYbOF
         hzWKA49TL5AGAtblUW1yswCMb7fXHqtezKl+yOBVhtEDsfweLkHWIlx69DcjM2svFRBj
         29US2b7RmKeMTUMVmyDKxx65iVO5BFEUhLpOYc8WO0aShijxFuPrebmSoh2wDm67urZh
         brWQ==
X-Gm-Message-State: AOJu0YwftHspJYsv8u19p8gZcMK6Kx7a9Ite1uSLTbVCpeSEGya4VJQp
	pgWnDHAlYGjoHhx8dryHfUKHig==
X-Google-Smtp-Source: AGHT+IG8+ocv6jcfXZr/sCm4koVHZ/ZSXkJS5VbfiMqTROMDWgZJV09JBC1NkXF7vPmVdSuG9kVL+w==
X-Received: by 2002:a2e:86da:0:b0:2c9:f985:457b with SMTP id n26-20020a2e86da000000b002c9f985457bmr298305ljj.3.1701849234328;
        Tue, 05 Dec 2023 23:53:54 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id bf17-20020a0564021a5100b0054ca1d90410sm2071733edb.85.2023.12.05.23.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:53:53 -0800 (PST)
Date: Wed, 6 Dec 2023 08:53:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com,
	vladbu@nvidia.com
Subject: Re: [PATCH net-next v2 4/5] net/sched: act_api: conditional
 notification of events
Message-ID: <ZXAokByEQY//QqXm@nanopsycho>
References: <20231204203907.413435-1-pctammela@mojatatu.com>
 <20231204203907.413435-5-pctammela@mojatatu.com>
 <ZW8KaANgu0DpryWV@nanopsycho>
 <6a70805b-953d-494e-a9b9-a2cb0e0aff18@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a70805b-953d-494e-a9b9-a2cb0e0aff18@mojatatu.com>

Tue, Dec 05, 2023 at 03:45:52PM CET, pctammela@mojatatu.com wrote:
>On 05/12/2023 08:32, Jiri Pirko wrote:
>> Mon, Dec 04, 2023 at 09:39:06PM CET, pctammela@mojatatu.com wrote:
>> > As of today tc-action events are unconditionally built and sent to
>> > RTNLGRP_TC. As with the introduction of tc_should_notify we can check
>> > before-hand if they are really needed.
>> > 
>> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> > ---
>> > net/sched/act_api.c | 105 ++++++++++++++++++++++++++++++++------------
>> > 1 file changed, 76 insertions(+), 29 deletions(-)
>> > 
>> > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
>> > index c39252d61ebb..55c62a8e8803 100644
>> > --- a/net/sched/act_api.c
>> > +++ b/net/sched/act_api.c
>> > @@ -1780,31 +1780,45 @@ static int tcf_action_delete(struct net *net, struct tc_action *actions[])
>> > 	return 0;
>> > }
>> > 
>> > -static int
>> > -tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
>> > +static struct sk_buff *tcf_reoffload_del_notify_msg(struct net *net,
>> 
>> I wonder, why this new function is needed? If I'm reading things
>> correctly, tcf_reoffload_del_notify() with added check would be just ok,
>> woundn't it?
>> 
>> Same for others.
>
>In V1 we had it like what you are suggesting[1].
>Jakub suggested to refactor the functions a bit more. The main argument was
>the code duplication introduced for the delete routines.

Okay.

>Note that for the case that no notification is needed, we still need to do
>the action delete etc...
>I agree that code duplication is bad in the long term, so I did the changes,
>but I don't have a strong opinion here (either way is fine for me).
>Let's see what he has to say, perhaps I overdid what he was suggesting :)
>
>[1]
>https://lore.kernel.org/all/20231201204314.220543-4-pctammela@mojatatu.com/
>
>> 
>> > +						    struct tc_action *action)
>> > {
>> > 	size_t attr_size = tcf_action_fill_size(action);
>> > 	struct tc_action *actions[TCA_ACT_MAX_PRIO] = {
>> > 		[0] = action,
>> > 	};
>> > -	const struct tc_action_ops *ops = action->ops;
>> > 	struct sk_buff *skb;
>> > -	int ret;
>> > 
>> > -	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
>> > -			GFP_KERNEL);
>> > +	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
>> 
>> I don't see how this is related to this patch. Can't you do it in separate
>> patch?
>> 
>> Same for others.
>
>Sure, will split it out.
>
>> 
>> > 	if (!skb)
>> > -		return -ENOBUFS;
>> > +		return ERR_PTR(-ENOBUFS);
>> > 
>> > 	if (tca_get_fill(skb, actions, 0, 0, 0, RTM_DELACTION, 0, 1, NULL) <= 0) {
>> > 		kfree_skb(skb);
>> > -		return -EINVAL;
>> > +		return ERR_PTR(-EINVAL);
>> > 	}
>> > 
>> > +	return skb;
>> > +}
>> > +
>> 
>> [...]
>

