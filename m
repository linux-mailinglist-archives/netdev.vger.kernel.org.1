Return-Path: <netdev+bounces-241747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 896E6C87E8D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 703EE4E12B8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4030C347;
	Wed, 26 Nov 2025 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bji/YdBL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A975A3C1F
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764126682; cv=none; b=ohnTTQVlBAFminzvMRJ0x+AyQx2LZ0Y/0tYS7KaNURqfQ8ZHOSlckvOpYIfSYc0pyrhHY6g9LgRFSUFMz/5pXKZj3WSf5CmSPW6m5M1D+Nh9F0Y8j+UG4p9+oFHZtbJhgbj0/cN+Zxo+vqrKE8mMau+YtlzTqiySTe9NiRWP8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764126682; c=relaxed/simple;
	bh=8sBshtxomcE7YaHx/b90u6+CUH4tfuLjzf9C7DELKfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bu/VaaQKz8urx7nXyD/l8UYHXDJVHzxgy9T2PFy0rkCG0y8qLdWHoGCGmN6LN1CugXt/37NmIzqitno14jpbyKw551zE9AuyqwnjZrpNAakiFbMZvsgRutLMBkrfMkqPZbT1uXmVXt4KbOLgQK/C12XU6aBboay4LVKxsVR7oFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bji/YdBL; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88057f5d041so59987416d6.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 19:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764126679; x=1764731479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow7IcpbawQUVFaW1lM4yRLUikj6O6rs4Len3+3Yqavc=;
        b=bji/YdBLq0u0Ma/r8Stmxvx5Okxa9SB3xeZhpbhfibPkk5KkJr+zfTGIlHPuiWhzqm
         gf0upGn3IRj6Xqj2gR5lWLgpPUhJHV3jhd9/x/kW8ETaeNt4p7H1lfJULgFKvRwPrBAD
         3CX7iyuzJldtHPxRaiSPwV2L0AwBHb59rTsWAKyL6eSSLd8qg9IU76emLKu5IR48IzDp
         R5vMsW0bLAWr9b+k2jV7yhhcMSmX3CYi+azM5PtuLDvVx79yuqB89qa2IfVAPpzAK4K7
         L9vLomeCF92koCfdazDpQ/5DsAI9eI1rPKTRmQsMeAyA8JJcsyUdPvKUmUza18rZnlGA
         ktpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764126679; x=1764731479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ow7IcpbawQUVFaW1lM4yRLUikj6O6rs4Len3+3Yqavc=;
        b=wtk1n8USSHKYfkugi5G4S+xVqq+t2qPupseZdr/4Eb9Z+6XkepLwnr32/WNwi93w5f
         9bFS7WLyHIJbVBuFYFYFIpp2cvzBrgXXniTPOGMu2khZcpMtK/3P6NaWnM7xpcypfZbN
         ZsxZPnQeimAsIXfXkcMDvIQ3aVNqxQm3o0u1dZC7cYhQzED5wUzuBP7H6/fvbnIhOe+3
         PpBOSGIrSPFVVeE9H0/EABpdCMM7pHa1vwxY4L1rFLI6aiSNS4dvzL1ZM+hyNWEHvqQa
         OfJUrRriOpfOS3dRdJXAqaYz+8Bq+bmYOB+B1eVHagTjp2/PZzR4EOXIFr2cImHQmxAs
         h+aw==
X-Forwarded-Encrypted: i=1; AJvYcCUdx11YWm2hXulpBzGKWAoNc8+dNt1Ku2//BQEZ6qoBfmBCXqdaFv9HPMapqaWO8EBwKBOX5VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxytQPUJVPD/MLHVfe0u9NiYBQqObXc0hydNoMkBKm8jw0ogJOx
	URDr3gDX1c9ZznetwsFAwgGkY/xalfd3TdriaFDVYH1em8NMrO12uI63gognaS2ZEwI=
X-Gm-Gg: ASbGncs84FPINp9Wk7d3ftXQe00IMoPR3aXBEPtoRGYinVpGlHW1vWPqNut5w1fJICn
	Vt34hTxI6SguXWbCJgz06rqXioz5SNIGDyE/oeLHZuLCPoEsAbA3DgBu4879mNkXVSSpcy5IQqE
	7480C0egFBKcPXe8qn7UuhZWXkVbPTUybgL7WgyToNlbcoakO3sfj/lzNNocAm9fxKV78UMIZOJ
	dU1iAyAaKz/w8rrp8V8bALJCQAclUGix4lUC9sZwWRJMBbflIwt0i1txq4ffBE748IV38IVUxKD
	nYxjwRFWNQdihnXoV6IalGFulplbaFWiTwiKSw7gjxfjvvXKd2VefbohjvhupQ3lRphKc+/VVAW
	XgRWxtZOp1a9Ei0zlpeXxSyG1Tci7Ch+FEIxAQ4ZyUfBntYdI8s0XIHVtsT8DhSqt/lEDiX9528
	dOOgzHRLmSdJDEPbBZgH1dF0E/tFZ4PFkoNZtvqjat/a29EFZOP8hu
X-Google-Smtp-Source: AGHT+IFx3NT0NE0vtpyEgFDnBpXTkBXnpNL+YpZBmKn+oMcXC0U1yxaj8U6fjVSkGuE4UW7DzjkDfA==
X-Received: by 2002:a05:6214:4983:b0:729:9b59:bba6 with SMTP id 6a1803df08f44-8863b0030bcmr77169396d6.34.1764126679443;
        Tue, 25 Nov 2025 19:11:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447272sm135036956d6.5.2025.11.25.19.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:11:19 -0800 (PST)
Date: Tue, 25 Nov 2025 19:11:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 xiyou.wangcong@gmail.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2] net/sched: Introduce qdisc quirk_chk op
Message-ID: <20251125191107.6d9efcfb@phoenix.local>
In-Reply-To: <20251125224604.872351-1-victor@mojatatu.com>
References: <20251125224604.872351-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 19:46:04 -0300
Victor Nogueira <victor@mojatatu.com> wrote:

> There is a pattern of bugs that end up creating UAFs or null ptr derefs.
> The majority of these bugs follow the formula below:
> a) create a nonsense hierarchy of qdiscs which has no practical value,
> b) start sending packets
> Optional c) netlink cmds to change hierarchy some more; It's more fun if
> you can get packets stuck - the formula in this case includes non
> work-conserving qdiscs somewhere in the hierarchy
> Optional d dependent on c) send more packets
> e) profit
> 
> Current init/change qdisc APIs are localised to validate only within the
> constraint of a single qdisc. So catching #a or #c is a challenge. Our
> policy, when said bugs are presented, is to "make it work" by modifying
> generally used data structures and code, but these come at the expense of
> adding special checks for corner cases which are nonsensical to begin with.
> 
> The goal of this patchset is to create an equivalent to PCI quirks, which
> will catch nonsensical hierarchies in #a and #c and reject such a config.
> 
> With that in mind, we are proposing the addition of a new qdisc op
> (quirk_chk). We introduce, as a first example, the quirk_chk op to netem.
> Its purpose here is to validate whether the user is attempting to add 2
> netem duplicates in the same qdisc tree which will be forbidden unless
> the root qdisc is multiqueue.
> 
> Here is an example that should now work:
> 
> DEV="eth0"
> NUM_QUEUES=4
> DUPLICATE_PERCENT="5%"
> 
> tc qdisc del dev $DEV root > /dev/null 2>&1
> tc qdisc add dev $DEV root handle 1: mq
> 
> for i in $(seq 1 $NUM_QUEUES); do
>     HANDLE_ID=$((i * 10))
>     PARENT_ID="1:$i"
>     tc qdisc add dev $DEV parent $PARENT_ID handle \
>         ${HANDLE_ID}: netem duplicate $DUPLICATE_PERCENT
> done
> 
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
> v1 -> v2:
> - Simplify process of getting root qdisc in netem_quirk_chk
> - Use parent's major directly instead of looking up parent qdisc in
>   netem_quirk_chk
> - Call parse_attrs in netem_quirk_chk to avoid issue caught by syzbot
> 
> Link to v1:
> https://lore.kernel.org/netdev/20251124223749.503979-1-victor@mojatatu.com/
> ---
>  include/net/sch_generic.h |  3 +++
>  net/sched/sch_api.c       | 12 ++++++++++++
>  net/sched/sch_netem.c     | 40 +++++++++++++++++++++++++++------------
>  3 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 94966692ccdf..60450372c5d5 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -313,6 +313,9 @@ struct Qdisc_ops {
>  						     u32 block_index);
>  	void			(*egress_block_set)(struct Qdisc *sch,
>  						    u32 block_index);
> +	int			(*quirk_chk)(struct Qdisc *sch,
> +					     struct nlattr *arg,
> +					     struct netlink_ext_ack *extack);
>  	u32			(*ingress_block_get)(struct Qdisc *sch);
>  	u32			(*egress_block_get)(struct Qdisc *sch);
>  
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index f56b18c8aebf..a850df437691 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1315,6 +1315,12 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  		rcu_assign_pointer(sch->stab, stab);
>  	}
>  
> +	if (ops->quirk_chk) {
> +		err = ops->quirk_chk(sch, tca[TCA_OPTIONS], extack);
> +		if (err != 0)
> +			goto err_out3;
> +	}
> +
>  	if (ops->init) {
>  		err = ops->init(sch, tca[TCA_OPTIONS], extack);
>  		if (err != 0)
> @@ -1378,6 +1384,12 @@ static int qdisc_change(struct Qdisc *sch, struct nlattr **tca,
>  			NL_SET_ERR_MSG(extack, "Change of blocks is not supported");
>  			return -EOPNOTSUPP;
>  		}
> +		if (sch->ops->quirk_chk) {
> +			err = sch->ops->quirk_chk(sch, tca[TCA_OPTIONS],
> +						  extack);
> +			if (err != 0)
> +				return err;
> +		}
>  		err = sch->ops->change(sch, tca[TCA_OPTIONS], extack);
>  		if (err)
>  			return err;
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index eafc316ae319..ceece2ae37bc 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -975,13 +975,27 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
>  
>  static const struct Qdisc_class_ops netem_class_ops;
>  
> -static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
> -			       struct netlink_ext_ack *extack)
> +static int netem_quirk_chk(struct Qdisc *sch, struct nlattr *opt,
> +			   struct netlink_ext_ack *extack)
>  {
> +	struct nlattr *tb[TCA_NETEM_MAX + 1];
> +	struct tc_netem_qopt *qopt;
>  	struct Qdisc *root, *q;
> +	struct net_device *dev;
> +	bool root_is_mq;
> +	bool duplicates;
>  	unsigned int i;
> +	int ret;
> +
> +	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt));
> +	if (ret < 0)
> +		return ret;
>  
> -	root = qdisc_root_sleeping(sch);
> +	qopt = nla_data(opt);
> +	duplicates = qopt->duplicate;
> +
> +	dev = sch->dev_queue->dev;
> +	root = rtnl_dereference(dev->qdisc);
>  
>  	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
>  		if (duplicates ||
> @@ -992,19 +1006,25 @@ static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
>  	if (!qdisc_dev(root))
>  		return 0;
>  
> +	root_is_mq = root->flags & TCQ_F_MQROOT;
> +

What about HTB or other inherently multi-q qdisc?
Using netem on HTB on some branches is common practice.

