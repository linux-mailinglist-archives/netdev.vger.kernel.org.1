Return-Path: <netdev+bounces-251619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEQ9Fm7wb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:15:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B12034C12B
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6583A50B783
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ECC3A962D;
	Tue, 20 Jan 2026 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QQDzjRg+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8433A7E16
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943092; cv=none; b=immC2dojTHdWKNLZO9vbSkHnrLQyPe8wlVvhxb9riB+wbK/bapKB7if81KgsHn3qZU06r2rBo6bSZVbZ7hpGDdmtMlz6pJ9QtMtMPnkFCPQYtKSEkGFMLBVZIVIh/VYqBXc1DzYuZcO4CJfAY4ErvYYK6eMJaftBD2axls+tQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943092; c=relaxed/simple;
	bh=UXP7g/BBPk/YWgk0/upubrDKRWdkIInmrHekkfzLkNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bF6qsHoz/caEPvaOtO9wPABnrCji4tF3mv1EhZrPG+I+H2BMFPoVINLV7L/Avc83ffdUwl0LdZractf7N7hOOTtY3CHUZyyO9EiTm+Q3YnfCdcSk8M+IOdjaluGeVohS/r/tbmuUhzN9Ggv0dcNQ9pauEnS+UCztkJObYcKxvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QQDzjRg+; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12336f33098so4809177c88.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 13:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768943088; x=1769547888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ai1otIKDYCwf2Y8TFssFgbpLXbDAkZ98nVLTsrDMfKQ=;
        b=QQDzjRg+EfNb9xU2noNNQVPU9wAh+1jsVztkHkbzYogqHdQeZPHpCd1eH7tBsYLmX/
         9RztlgV8QwqUmcdGJK6wdlxY8qta/xwv/1KdSOyoz0E6yd/YIVcmcVRCIFKKFobyQc2I
         JkwYLN5ugRCTL+uuJmjxjWXr4NA6TjTb32FWf5cy2ZQL0gtRogGZd9oV1ehQUdZLeABK
         k+8Ec8C9pCigtApIEYZHA6iR+Jab4xy98uIjQi6a78WA9mqs7ZmnxWDb4dJkocmw6VhT
         3UggRPWVbidqmqzhqPc1BQ5pli9ZuCFr6kYhkRr2OuarTxyi7Gk1DPXZGeEK466qYlm/
         /HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768943088; x=1769547888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ai1otIKDYCwf2Y8TFssFgbpLXbDAkZ98nVLTsrDMfKQ=;
        b=ZN0v0oenreY5mv2qO3ta7FDGvOP3hLG106J9n4+q2SDg/hNFOogjID8FhnD82MOTJH
         7G5yiZ/0svqAHbzTla/JMjLPGoRGhUzc2Pce3xy4jFhTgbxPIm1btPymEnJ3sMDgFQTd
         NKRbSJ1e0MSQgzQR3G6UpywKbBJveIcUJC16DkmbLEXrUOqOHSylmYsWlxR1h7T+W7dq
         kN03Wi0a8F9HRxrScNv7j37+MKKOpkMYWW1cZeGlsA36yxfhbEfbCTYepDzXpPmcvUyL
         Ck+SnXhy5zpNTU0dI9sbwPb7j45K+U5CW1nP5RQIOt0RSJ+7kLxNKciQsGGCOzIhK/x9
         tr9A==
X-Forwarded-Encrypted: i=1; AJvYcCUZBcF6fHrcUt6uNRGkyDkLubeIHYpDPTJ1d0Q9Fwxn4axOK2k7kf9GglS239yGPqb22SWJfcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2ZTeEorBLeu3IdqGY7PA0W8Kd0DGXp/ODJisbC/vK/RAbmpM
	11SKCz2bM4ESCgGFT6HnSfiBNuiqnEHIdvooSj+1Jre5XQt4/Vzafk4qvic7M4w8HA==
X-Gm-Gg: AY/fxX6BcKlZadwAdmfCzRccvQ/n0w8qJWU6GrDUUjuvPLh4usjEtuFCkwBZX7FayI/
	U22owebjwuc9duRKIFdKOUJ2ow/eO0WnJUGuXSC7Ifwl2N5D/zO5Hx6sjePkOwKtOtVajEgEUxG
	YeyQIF6XH6YkMhtkH1Nr7qlVKRvRSDIQzzC8s6rPr0/krqw99flbedoTZDuB+njbqlZEeA57OdD
	Fd4xWoPtePqWBURCZnAqdy1aiWa54nFE31R4ZMxMn4bbvViUUcMq+2nNxmpxy0XiyeyJOFf55b9
	h9BLXwb3JUD4tDJs8iu5B7yuiYXqMfpOxW22XvvzWlqowa1PPEI9kYvTbRmynaWd4U3jwOUaYsj
	f8DKhqx5mpTSE072ZeNmjyfIb4L1P/Mr61Nldv6FGgOUq6C88Tc7YV8leA8WDzKKl+WvWG6TVus
	+GkYunWavEQG6dd0wUHHBJEQ==
X-Received: by 2002:a05:7022:6183:b0:123:35cb:96e3 with SMTP id a92af1059eb24-1244b37e603mr12727280c88.46.1768943088165;
        Tue, 20 Jan 2026 13:04:48 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac58140sm19748304c88.4.2026.01.20.13.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 13:04:47 -0800 (PST)
Message-ID: <bff53f0a-2c94-46b2-bb49-b05d10ae420e@mojatatu.com>
Date: Tue, 20 Jan 2026 18:04:43 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/sched: act_gate: fix schedule updates with RCU
 swap
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260120004720.1886632-1-p@1g4.org>
 <20260120004720.1886632-2-p@1g4.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260120004720.1886632-2-p@1g4.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251619-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,act_gate_ops.net_id:url,mojatatu.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B12034C12B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/01/2026 21:48, Paul Moses wrote:
> Switch act_gate parameters to an RCU-protected pointer and update schedule
> changes using a prepare-then-swap pattern. This avoids races between the
> timer/data paths and configuration updates, and cancels the hrtimer
> before swapping schedules.
> 
> A gate action replace could free and swap schedules while the hrtimer
> callback or data path still dereferences the old entries, leaving a
> use-after-free window during updates. The deferred swap and RCU free
> close that window. A reproducer is available on request.
> 
> Also clear params on early error for newly created actions to avoid
> leaving a dangling reference.
> [...]
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c1f75f2727576..3ee07c3deaf97 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -6,6 +6,7 @@
>   #include <linux/kernel.h>
>   #include <linux/string.h>
>   #include <linux/errno.h>
> +#include <linux/limits.h>

Do you really need to include this?

> [...]
> @@ -69,12 +71,14 @@ static enum hrtimer_restart gate_timer_func(struct hrtimer *timer)
>   {
>   	struct tcf_gate *gact = container_of(timer, struct tcf_gate,
>   					     hitimer);
> -	struct tcf_gate_params *p = &gact->param;
> +	struct tcf_gate_params *p;

When adding/editing local variables, you should adhere to the
reverse xmas tree style [1].

>   	spin_lock(&gact->tcf_lock);

Shouldn't you call rcu_read_lock before this line now?

> +	p = rcu_dereference_protected(gact->param,
> +				      lockdep_is_held(&gact->tcf_lock));
> [...]
>   static int tcf_gate_init(struct net *net, struct nlattr *nla,
> @@ -296,20 +296,26 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>   			 struct netlink_ext_ack *extack)
>   {
>   	struct tc_action_net *tn = net_generic(net, act_gate_ops.net_id);
> -	enum tk_offsets tk_offset = TK_OFFS_TAI;
> -	bool bind = flags & TCA_ACT_FLAGS_BIND;
>   	struct nlattr *tb[TCA_GATE_MAX + 1];
>   	struct tcf_chain *goto_ch = NULL;
> -	u64 cycletime = 0, basetime = 0;
> -	struct tcf_gate_params *p;
> -	s32 clockid = CLOCK_TAI;
> +	struct tcf_gate_params *p, *oldp;
>   	struct tcf_gate *gact;
>   	struct tc_gate *parm;
> -	int ret = 0, err;
> -	u32 gflags = 0;
> -	s32 prio = -1;
> +	struct tcf_gate_params newp = { };

Abide by reverse xmas tree when adding local variables.

> [...]
> +	bool clockid_set = false;

I could be missing something, but I don't believe you need this
boolean.

> [...]
> @@ -323,6 +329,7 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>   
>   	if (tb[TCA_GATE_CLOCKID]) {
>   		clockid = nla_get_s32(tb[TCA_GATE_CLOCKID]);
> +		clockid_set = true;
>   		switch (clockid) {

Instead of using clockid_set and repeating the switch statament.
You could put this if-statement after you already have oldp and do the
following:

          if (tb[TCA_GATE_CLOCKID]) {
                  clockid = nla_get_s32(tb[TCA_GATE_CLOCKID]);
                  switch (clockid) {
                  case CLOCK_REALTIME:
                          tk_offset = TK_OFFS_REAL;
                          break;
                  case CLOCK_MONOTONIC:
                          tk_offset = TK_OFFS_MAX;
                          break;
                  case CLOCK_BOOTTIME:
                          tk_offset = TK_OFFS_BOOT;
                          break;
                  case CLOCK_TAI:
                          tk_offset = TK_OFFS_TAI;
                          break;
                  default:
                          NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
                          return -EINVAL;
                  }
          } else if (ret != ACT_P_CREATED) {
                  clockid = oldp->tcfg_clockid;
                  tk_offset = gact->tk_offset;
          }

> [...]
> -	if (tb[TCA_GATE_CYCLE_TIME])
> +	if (ret == ACT_P_CREATED)
> +		update_timer = true;
> [...]

Here you are assigning update_timer to true when the op is a create...

> [...]
> +	if (update_timer && ret != ACT_P_CREATED)
> +		hrtimer_cancel(&gact->hitimer);

.. however in the if-statement where it is used you are only allowing
updates. This looks weird.

> [...]
> +free_p:
> +	release_entry_list(&p->entries);
> +	kfree(p);

The 2 lines of code above are being repeated below and in
tcf_gate_params_release. You should put them in a common function.

> +release_new_entries:
> +	release_entry_list(&newp.entries);
> +put_chain:
>   	if (goto_ch)
>   		tcf_chain_put_by_act(goto_ch);
>   release_idr:
> -	/* action is not inserted in any list: it's safe to init hitimer
> -	 * without taking tcf_lock.
> -	 */
> -	if (ret == ACT_P_CREATED)
> -		gate_setup_timer(gact, gact->param.tcfg_basetime,
> -				 gact->tk_offset, gact->param.tcfg_clockid,
> -				 true);
> +	if (ret == ACT_P_CREATED) {
> +		p = rcu_dereference_protected(gact->param, 1);
> +		if (p) {
> +			release_entry_list(&p->entries);
> +			kfree(p);
> +			rcu_assign_pointer(gact->param, NULL);
> +		}
> +	}
>   	tcf_idr_release(*a, bind);

Also, the AI review [2] pointed out a real issue.
It's easy to reproduce by running something like:

tc action add action gate base-time 200000000000ns \
      sched-entry close 0ns index 10

I think overall you have the right idea - RCU seems like a good fit here.
The issue is that this patch is confusing because it seems like you are
trying to fix the bug and perform cleanups at the same time.
If that is the case, can you try breaking this patch into two? Do one to
fix the bug (introducing RCU and etc) and another for the cleanups.

[1] 
https://www.kernel.org/doc/html/v6.3/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
[2] 
https://netdev-ai.bots.linux.dev/ai-review.html?id=cdc17d0d-fd59-41a8-9c8d-1a42699167fd#patch-0

cheers,
Victor

