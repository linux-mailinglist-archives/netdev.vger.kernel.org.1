Return-Path: <netdev+bounces-95248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC068C1BA8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4991F2198A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A31612E7E;
	Fri, 10 May 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2fVX+X3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7C12E4D
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300329; cv=none; b=ly0e3HP6rLUuXNAf66CuEC6s/V8JvBc55k397P/OerFk56oPtTufYTFdHqi3CmESsXeblRo3yYgitArZlKi+1wrpERz0tlzVA6HegL1d4OratG1fIRbdehO/N8ZFCII9B3O27sga9KUKxst3PJ0+e5a4eagvuShSl6qqzLJ0cCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300329; c=relaxed/simple;
	bh=SYIWb41BuLUf74Mc0huIrNU/NxhBGlM4BkrfT1XaK0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dg412n9x/N7d9+7CCBZoMbMGhKRSUNnFWgPQkOpWHx3XHFXnvzfHhxJnDrqGJy75UmGQLa517uVVPCgtdAmbWYqeh471By92tBp6SqI+p58Hmqu52QUjkLzUFd9phh1ByxDtsW9NXyYOx/kXuhxUP+SkzHqWXP2EE6nI1fXdH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2fVX+X3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41fd5dc0439so7824975e9.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715300325; x=1715905125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmOAnH+cDkOoXgMSs1Em2+AaQqksVYLMONQ3pN4aPnw=;
        b=l2fVX+X3P6/fnr+bjrSYFEEcayPt7i7N2dLvUwX/LRFHAtHyOv/QMHPC9GJI4j8YFQ
         bpVgMF1vaMR5msKlyd3A4L3x71CJHqvHJx3Zteel+l0Uu8l8ZS3DC4hJUFokWmuIc0OK
         nOrnGm2DJEpA6zfhODy8Yfp4RWRpi7/uvgXGiVP9XhLNk/JA1Gg/biYV8Sk/DF6uyqCs
         BlVGoLonKuxGE5BMGQ5z7DGbynmEnU9+ovJcDRWpzLF/IdGPMvJDJJYphTBKadIcgP7l
         JAuuIItaw7YL0CenNM2ZAVJT0Az6z9aqqeXDcbEs5H+3BbFfha0m8eExHx8PQIGxgZOL
         1rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300325; x=1715905125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmOAnH+cDkOoXgMSs1Em2+AaQqksVYLMONQ3pN4aPnw=;
        b=gDcg1Dq9dIyjlWU3Xw9oY6bYhEYcQK0uXPl3sGFR7zZTDYXVTKxLBEOVWwu2rouAUT
         2lt1FLKZLUIZxW9NZHGnkEubefmWXAU9uNVJng+6PX9QxMPvDCmKZfiWjF5NIrY2WdE/
         gCWC9kDilDndcuDsyKBejXZPDkJ/Tj2gUp8CcmzHB3OzxfBxc/MhC5finqtv+mGNUK+Z
         DNB8oDiNE5JHbQ7D5yK35oQ/vmiXt8cL47pX5r+4qvGW8+1Q/K4tHn+k/BM/k60J57Gd
         EYNOPestqKmedr14ZpKtI9tKzP50KbtC4iRj8OZR2aRYldYN/jT+4OCD+Dkk+XK6mm2F
         kg3w==
X-Gm-Message-State: AOJu0Yw0iHitxejXGR+sQMYzPkH2UzElXiBxClek4VmJOu0HSzktqAI9
	BY2sTbcYs84/rjcj/L4RU6CtThN+j3UrwOJvr9FyKE8yUNkQ1makrqzAk4cmri1JCk/YjX8nXvF
	WdN6uIfntUwMtZrAbhIsyY6mnxnSz63Pz3qna
X-Google-Smtp-Source: AGHT+IH/iPoNOzY1fjoQ4/wDKp9P3mj65Pmyf7H1LKGsVxkJA07ORLWze+aM3RsJbXP2jxa8JgXdFizcvQlmTE36AKE=
X-Received: by 2002:a05:600c:450e:b0:41c:8754:8796 with SMTP id
 5b1f17b1804b1-41feac4960bmr7421265e9.30.1715300324911; Thu, 09 May 2024
 17:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507225945.1408516-1-ziweixiao@google.com>
 <20240507225945.1408516-5-ziweixiao@google.com> <a75ca51c-89b1-4f90-be52-e5fb71ca519a@davidwei.uk>
In-Reply-To: <a75ca51c-89b1-4f90-be52-e5fb71ca519a@davidwei.uk>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Thu, 9 May 2024 17:18:33 -0700
Message-ID: <CAG-FcCPnrN8Wodn0+UYPJ4XpvDpVyhCzvGPx2CnDit8adwKYSg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] gve: Add flow steering adminq commands
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com, 
	shailend@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	hramamurthy@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:24=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-05-07 15:59, Ziwei Xiao wrote:
> > From: Jeroen de Borst <jeroendb@google.com>
> >
> > Adding new adminq commands for the driver to configure and query flow
> > rules that are stored in the device. Flow steering rules are assigned
> > with a location that determines the relative order of the rules.
> >
> > Flow rules can run up to an order of millions. In such cases, storing
> > a full copy of the rules in the driver to prepare for the ethtool query
> > is infeasible while querying them from the device is better. That needs
> > to be optimized too so that we don't send a lot of adminq commands. The
> > solution here is to store a limited number of rules/rule ids in the
> > driver in a cache. This patch uses dma_pool to allocate 4k bytes which
> > lets device write at most 46 flow rules(4k/88) or 1k rule ids(4096/4)
> > at a time.
> >
> > For configuring flow rules, there are 3 sub-commands:
> > - ADD which adds a rule at the location supplied
> > - DEL which deletes the rule at the location supplied
> > - RESET which clears all currently active rules in the device
> >
> > For querying flow rules, there are also 3 sub-commands:
> > - QUERY_RULES corresponds to ETHTOOL_GRXCLSRULE. It fills the rules in
> >   the allocated cache after querying the device
> > - QUERY_RULES_IDS corresponds to ETHTOOL_GRXCLSRLALL. It fills the
> >   rule_ids in the allocated cache after querying the device
> > - QUERY_RULES_STATS corresponds to ETHTOOL_GRXCLSRLCNT. It queries the
> >   device's current flow rule number and the supported max flow rule
> >   limit
> >
> > Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> > Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> > Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve.h         |  42 ++++++
> >  drivers/net/ethernet/google/gve/gve_adminq.c  | 133 ++++++++++++++++++
> >  drivers/net/ethernet/google/gve/gve_adminq.h  |  75 ++++++++++
> >  drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
> >  drivers/net/ethernet/google/gve/gve_main.c    |  54 ++++++-
> >  5 files changed, 307 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index 58213c15e084..355ae797eacf 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -60,6 +60,10 @@
> >
> >  #define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
> >
> > +#define GVE_FLOW_RULES_CACHE_SIZE (GVE_ADMINQ_BUFFER_SIZE / sizeof(str=
uct gve_flow_rule))
> > +#define GVE_FLOW_RULE_IDS_CACHE_SIZE \
> > +     (GVE_ADMINQ_BUFFER_SIZE / sizeof(((struct gve_flow_rule *)0)->loc=
ation))
> > +
> >  #define GVE_XDP_ACTIONS 5
> >
> >  #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
> > @@ -678,6 +682,39 @@ enum gve_queue_format {
> >       GVE_DQO_QPL_FORMAT              =3D 0x4,
> >  };
> >
> > +struct gve_flow_spec {
> > +     __be32 src_ip[4];
> > +     __be32 dst_ip[4];
> > +     union {
> > +             struct {
> > +                     __be16 src_port;
> > +                     __be16 dst_port;
> > +             };
> > +             __be32 spi;
> > +     };
> > +     union {
> > +             u8 tos;
> > +             u8 tclass;
> > +     };
> > +};
> > +
> > +struct gve_flow_rule {
> > +     u32 location;
> > +     u16 flow_type;
> > +     u16 action;
> > +     struct gve_flow_spec key;
> > +     struct gve_flow_spec mask;
> > +};
> > +
> > +struct gve_flow_rules_cache {
> > +     bool rules_cache_synced; /* False if the driver's rules_cache is =
outdated */
> > +     struct gve_flow_rule *rules_cache;
> > +     u32 *rule_ids_cache;
> > +     /* The total number of queried rules that stored in the caches */
> > +     u32 rules_cache_num;
> > +     u32 rule_ids_cache_num;
> > +};
> > +
> >  struct gve_priv {
> >       struct net_device *dev;
> >       struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> > @@ -744,6 +781,8 @@ struct gve_priv {
> >       u32 adminq_report_link_speed_cnt;
> >       u32 adminq_get_ptype_map_cnt;
> >       u32 adminq_verify_driver_compatibility_cnt;
> > +     u32 adminq_query_flow_rules_cnt;
> > +     u32 adminq_cfg_flow_rule_cnt;
> >
> >       /* Global stats */
> >       u32 interface_up_cnt; /* count of times interface turned up since=
 last reset */
> > @@ -788,6 +827,9 @@ struct gve_priv {
> >       bool header_split_enabled; /* True if the header split is enabled=
 by the user */
> >
> >       u32 max_flow_rules;
> > +     u32 num_flow_rules; /* Current number of flow rules registered in=
 the device */
> > +
> > +     struct gve_flow_rules_cache flow_rules_cache;
> >  };
> >
> >  enum gve_service_task_flags_bit {
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 85d0d742ad21..7a929e20cf96 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -287,6 +287,8 @@ int gve_adminq_alloc(struct device *dev, struct gve=
_priv *priv)
> >       priv->adminq_report_stats_cnt =3D 0;
> >       priv->adminq_report_link_speed_cnt =3D 0;
> >       priv->adminq_get_ptype_map_cnt =3D 0;
> > +     priv->adminq_query_flow_rules_cnt =3D 0;
> > +     priv->adminq_cfg_flow_rule_cnt =3D 0;
> >
> >       /* Setup Admin queue with the device */
> >       if (priv->pdev->revision < 0x1) {
> > @@ -526,6 +528,12 @@ static int gve_adminq_issue_cmd(struct gve_priv *p=
riv,
> >       case GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY:
> >               priv->adminq_verify_driver_compatibility_cnt++;
> >               break;
> > +     case GVE_ADMINQ_QUERY_FLOW_RULES:
> > +             priv->adminq_query_flow_rules_cnt++;
> > +             break;
> > +     case GVE_ADMINQ_CONFIGURE_FLOW_RULE:
> > +             priv->adminq_cfg_flow_rule_cnt++;
> > +             break;
> >       default:
> >               dev_err(&priv->pdev->dev, "unknown AQ command opcode %d\n=
", opcode);
> >       }
> > @@ -1188,3 +1196,128 @@ int gve_adminq_get_ptype_map_dqo(struct gve_pri=
v *priv,
> >                         ptype_map_bus);
> >       return err;
> >  }
> > +
> > +static int
> > +gve_adminq_configure_flow_rule(struct gve_priv *priv,
> > +                            struct gve_adminq_configure_flow_rule *flo=
w_rule_cmd)
> > +{
> > +     int err =3D gve_adminq_execute_extended_cmd(priv,
> > +                     GVE_ADMINQ_CONFIGURE_FLOW_RULE,
> > +                     sizeof(struct gve_adminq_configure_flow_rule),
> > +                     flow_rule_cmd);
> > +
> > +     if (err) {
> > +             dev_err(&priv->pdev->dev, "Timeout to configure the flow =
rule, trigger reset");
> > +             gve_reset(priv, true);
> > +     } else {
> > +             priv->flow_rules_cache.rules_cache_synced =3D false;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_=
flow_rule *rule, u32 loc)
> > +{
> > +     struct gve_adminq_configure_flow_rule flow_rule_cmd =3D {
> > +             .opcode =3D cpu_to_be16(GVE_RULE_ADD),
> > +             .location =3D cpu_to_be32(loc),
> > +             .rule =3D *rule,
> > +     };
> > +
> > +     return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
> > +}
> > +
> > +int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc)
> > +{
> > +     struct gve_adminq_configure_flow_rule flow_rule_cmd =3D {
> > +             .opcode =3D cpu_to_be16(GVE_RULE_DEL),
> > +             .location =3D cpu_to_be32(loc),
> > +     };
> > +
> > +     return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
> > +}
> > +
> > +int gve_adminq_reset_flow_rules(struct gve_priv *priv)
> > +{
> > +     struct gve_adminq_configure_flow_rule flow_rule_cmd =3D {
> > +             .opcode =3D cpu_to_be16(GVE_RULE_RESET),
> > +     };
> > +
> > +     return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
> > +}
> > +
> > +/* In the dma memory that the driver allocated for the device to query=
 the flow rules, the device
> > + * will first write it with a struct of gve_query_flow_rules_descripto=
r. Next to it, the device
> > + * will write an array of rules or rule ids with the count that specif=
ied in the descriptor.
> > + * For GVE_FLOW_RULE_QUERY_STATS, the device will only write the descr=
iptor.
> > + */
> > +static int gve_adminq_process_flow_rules_query(struct gve_priv *priv, =
u16 query_opcode,
> > +                                            struct gve_query_flow_rule=
s_descriptor *descriptor)
> > +{
> > +     struct gve_flow_rules_cache *flow_rules_cache =3D &priv->flow_rul=
es_cache;
> > +     u32 num_queried_rules, total_memory_len, rule_info_len;
> > +     void *descriptor_end, *rule_info;
> > +
> > +     total_memory_len =3D be32_to_cpu(descriptor->total_length);
> > +     if (total_memory_len > GVE_ADMINQ_BUFFER_SIZE) {
> > +             dev_err(&priv->dev->dev, "flow rules query is out of memo=
ry.\n");
>
> The error doesn't seem to match the inequality used. Also, how can the
> HW write more than GVE_ADMINQ_BUFFER_SIZE?
Will remove this check and add another check as suggested below.
>
> > +             return -ENOMEM;
> > +     }
> > +
> > +     num_queried_rules =3D be32_to_cpu(descriptor->num_queried_rules);
> > +     descriptor_end =3D (void *)descriptor + total_memory_len;
>
> This isn't being used.
Will remove it. Thank you!
>
> > +     rule_info =3D (void *)(descriptor + 1);
> > +
> > +     switch (query_opcode) {
> > +     case GVE_FLOW_RULE_QUERY_RULES:
> > +             rule_info_len =3D num_queried_rules * sizeof(*flow_rules_=
cache->rules_cache);
>
> Do you need to verify what the HW has written matches your expectations
> i.e. is sizeof(*descriptor) + rule_info_len =3D=3D total_memory_len?
Will add a check here. Thanks for the suggestion!
>
> > +
> > +             memcpy(flow_rules_cache->rules_cache, rule_info, rule_inf=
o_len);
> > +             flow_rules_cache->rules_cache_num =3D num_queried_rules;
> > +             break;
> > +     case GVE_FLOW_RULE_QUERY_IDS:
> > +             rule_info_len =3D num_queried_rules * sizeof(*flow_rules_=
cache->rule_ids_cache);
> > +
> > +             memcpy(flow_rules_cache->rule_ids_cache, rule_info, rule_=
info_len);
> > +             flow_rules_cache->rule_ids_cache_num =3D num_queried_rule=
s;
> > +             break;
> > +     case GVE_FLOW_RULE_QUERY_STATS:
> > +             priv->num_flow_rules =3D be32_to_cpu(descriptor->num_flow=
_rules);
> > +             priv->max_flow_rules =3D be32_to_cpu(descriptor->max_flow=
_rules);
> > +             return 0;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return  0;
> > +}
> > +
> > +int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcod=
e, u32 starting_loc)
> > +{
> > +     struct gve_query_flow_rules_descriptor *descriptor;
> > +     union gve_adminq_command cmd;
> > +     dma_addr_t descriptor_bus;
> > +     int err =3D 0;
> > +
> > +     memset(&cmd, 0, sizeof(cmd));
> > +     descriptor =3D dma_pool_alloc(priv->adminq_pool, GFP_KERNEL, &des=
criptor_bus);
>
> Why is adminq_pool only used for 2 commands?
>
The adminq_pool is not new added. It's also used for the other adminq comma=
nds.

> > +     if (!descriptor)
> > +             return -ENOMEM;
> > +
> > +     cmd.opcode =3D cpu_to_be32(GVE_ADMINQ_QUERY_FLOW_RULES);
> > +     cmd.query_flow_rules =3D (struct gve_adminq_query_flow_rules) {
> > +             .opcode =3D cpu_to_be16(query_opcode),
> > +             .starting_rule_id =3D cpu_to_be32(starting_loc),
> > +             .available_length =3D cpu_to_be64(GVE_ADMINQ_BUFFER_SIZE)=
,
> > +             .rule_descriptor_addr =3D cpu_to_be64(descriptor_bus),
> > +     };
> > +     err =3D gve_adminq_execute_cmd(priv, &cmd);
> > +     if (err)
> > +             goto out;
> > +
> > +     err =3D gve_adminq_process_flow_rules_query(priv, query_opcode, d=
escriptor);
> > +
> > +out:
> > +     dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
> > +     return err;
> > +}
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net=
/ethernet/google/gve/gve_adminq.h
> > index e64a0e72e781..9ddb72f92197 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> > @@ -25,11 +25,21 @@ enum gve_adminq_opcodes {
> >       GVE_ADMINQ_REPORT_LINK_SPEED            =3D 0xD,
> >       GVE_ADMINQ_GET_PTYPE_MAP                =3D 0xE,
> >       GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY  =3D 0xF,
> > +     GVE_ADMINQ_QUERY_FLOW_RULES             =3D 0x10,
> >
> >       /* For commands that are larger than 56 bytes */
> >       GVE_ADMINQ_EXTENDED_COMMAND             =3D 0xFF,
> >  };
> >
> > +/* The normal adminq command is restricted to be 56 bytes at maximum. =
For the
> > + * longer adminq command, it is wrapped by GVE_ADMINQ_EXTENDED_COMMAND=
 with
> > + * inner opcode of gve_adminq_extended_cmd_opcodes specified. The inne=
r command
> > + * is written in the dma memory allocated by GVE_ADMINQ_EXTENDED_COMMA=
ND.
> > + */
> > +enum gve_adminq_extended_cmd_opcodes {
> > +     GVE_ADMINQ_CONFIGURE_FLOW_RULE  =3D 0x101,
> > +};
> > +
> >  /* Admin queue status codes */
> >  enum gve_adminq_statuses {
> >       GVE_ADMINQ_COMMAND_UNSET                        =3D 0x0,
> > @@ -434,6 +444,66 @@ struct gve_adminq_get_ptype_map {
> >       __be64 ptype_map_addr;
> >  };
> >
> > +/* Flow-steering related definitions */
> > +enum gve_adminq_flow_rule_cfg_opcode {
> > +     GVE_RULE_ADD    =3D 0,
> > +     GVE_RULE_DEL    =3D 1,
> > +     GVE_RULE_RESET  =3D 2,
> > +};
>
> Could these be more descriptive?
>
Could you be more specific on which needs to be improved? Is the enum
name or the field name?

> > +
> > +enum gve_adminq_flow_rule_query_opcode {
> > +     GVE_FLOW_RULE_QUERY_RULES       =3D 0,
> > +     GVE_FLOW_RULE_QUERY_IDS         =3D 1,
> > +     GVE_FLOW_RULE_QUERY_STATS       =3D 2,
> > +};
> > +
> > +enum gve_adminq_flow_type {
> > +     GVE_FLOW_TYPE_TCPV4,
> > +     GVE_FLOW_TYPE_UDPV4,
> > +     GVE_FLOW_TYPE_SCTPV4,
> > +     GVE_FLOW_TYPE_AHV4,
> > +     GVE_FLOW_TYPE_ESPV4,
> > +     GVE_FLOW_TYPE_TCPV6,
> > +     GVE_FLOW_TYPE_UDPV6,
> > +     GVE_FLOW_TYPE_SCTPV6,
> > +     GVE_FLOW_TYPE_AHV6,
> > +     GVE_FLOW_TYPE_ESPV6,
> > +};
> > +
> > +/* Flow-steering command */
> > +struct gve_adminq_flow_rule {
> > +     __be16 flow_type;
> > +     __be16 action; /* RX queue id */
> > +     struct gve_flow_spec key;
> > +     struct gve_flow_spec mask;
> > +};
> > +
> > +struct gve_adminq_configure_flow_rule {
> > +     __be16 opcode;
> > +     u8 padding[2];
> > +     struct gve_adminq_flow_rule rule;
> > +     __be32 location;
> > +};
> > +
> > +static_assert(sizeof(struct gve_adminq_configure_flow_rule) =3D=3D 92)=
;
> > +
> > +struct gve_query_flow_rules_descriptor {
> > +     __be32 num_flow_rules; /* Current rule counts stored in the devic=
e */
> > +     __be32 max_flow_rules;
> > +     __be32 num_queried_rules;
>
> nit: more comments here are appreciated.
Will add

>
> > +     __be32 total_length; /* The memory length that the device writes =
*/
> > +};
> > +
> > +struct gve_adminq_query_flow_rules {
> > +     __be16 opcode;
> > +     u8 padding[2];
> > +     __be32 starting_rule_id;
> > +     __be64 available_length; /* The dma memory length that the driver=
 allocated */
> > +     __be64 rule_descriptor_addr; /* The dma memory address */
> > +};
> > +
> > +static_assert(sizeof(struct gve_adminq_query_flow_rules) =3D=3D 24);
> > +
> >  union gve_adminq_command {
> >       struct {
> >               __be32 opcode;
> > @@ -454,6 +524,7 @@ union gve_adminq_command {
> >                       struct gve_adminq_get_ptype_map get_ptype_map;
> >                       struct gve_adminq_verify_driver_compatibility
> >                                               verify_driver_compatibili=
ty;
> > +                     struct gve_adminq_query_flow_rules query_flow_rul=
es;
> >                       struct gve_adminq_extended_command extended_comma=
nd;
> >               };
> >       };
> > @@ -488,6 +559,10 @@ int gve_adminq_verify_driver_compatibility(struct =
gve_priv *priv,
> >                                          u64 driver_info_len,
> >                                          dma_addr_t driver_info_addr);
> >  int gve_adminq_report_link_speed(struct gve_priv *priv);
> > +int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_=
flow_rule *rule, u32 loc);
> > +int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
> > +int gve_adminq_reset_flow_rules(struct gve_priv *priv);
> > +int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcod=
e, u32 starting_loc);
> >
> >  struct gve_ptype_lut;
> >  int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
> > diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/ne=
t/ethernet/google/gve/gve_ethtool.c
> > index 156b7e128b53..02cee7e0e229 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > @@ -74,7 +74,8 @@ static const char gve_gstrings_adminq_stats[][ETH_GST=
RING_LEN] =3D {
> >       "adminq_create_tx_queue_cnt", "adminq_create_rx_queue_cnt",
> >       "adminq_destroy_tx_queue_cnt", "adminq_destroy_rx_queue_cnt",
> >       "adminq_dcfg_device_resources_cnt", "adminq_set_driver_parameter_=
cnt",
> > -     "adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "admin=
q_get_ptype_map_cnt"
> > +     "adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "admin=
q_get_ptype_map_cnt",
> > +     "adminq_query_flow_rules", "adminq_cfg_flow_rule",
> >  };
> >
> >  static const char gve_gstrings_priv_flags[][ETH_GSTRING_LEN] =3D {
> > @@ -458,6 +459,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >       data[i++] =3D priv->adminq_report_stats_cnt;
> >       data[i++] =3D priv->adminq_report_link_speed_cnt;
> >       data[i++] =3D priv->adminq_get_ptype_map_cnt;
> > +     data[i++] =3D priv->adminq_query_flow_rules_cnt;
> > +     data[i++] =3D priv->adminq_cfg_flow_rule_cnt;
> >  }
> >
> >  static void gve_get_channels(struct net_device *netdev,
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index cabf7d4bcecb..eb435ccbe98e 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -141,6 +141,52 @@ static void gve_get_stats(struct net_device *dev, =
struct rtnl_link_stats64 *s)
> >       }
> >  }
> >
> > +static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
> > +{
> > +     struct gve_flow_rules_cache *flow_rules_cache =3D &priv->flow_rul=
es_cache;
> > +     int err =3D 0;
> > +
> > +     if (!priv->max_flow_rules)
> > +             return 0;
> > +
> > +     flow_rules_cache->rules_cache =3D
> > +             kvcalloc(GVE_FLOW_RULES_CACHE_SIZE, sizeof(*flow_rules_ca=
che->rules_cache),
> > +                      GFP_KERNEL);
> > +     if (!flow_rules_cache->rules_cache) {
> > +             dev_err(&priv->pdev->dev, "Cannot alloc flow rules cache\=
n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     flow_rules_cache->rule_ids_cache =3D
> > +             kvcalloc(GVE_FLOW_RULE_IDS_CACHE_SIZE, sizeof(*flow_rules=
_cache->rule_ids_cache),
> > +                      GFP_KERNEL);
> > +     if (!flow_rules_cache->rule_ids_cache) {
> > +             dev_err(&priv->pdev->dev, "Cannot alloc flow rule ids cac=
he\n");
> > +             err =3D -ENOMEM;
> > +             goto free_rules_cache;
> > +     }
> > +
> > +     return 0;
> > +
> > +free_rules_cache:
> > +     kvfree(flow_rules_cache->rules_cache);
> > +     flow_rules_cache->rules_cache =3D NULL;
> > +     return err;
> > +}
> > +
> > +static void gve_free_flow_rule_caches(struct gve_priv *priv)
> > +{
> > +     struct gve_flow_rules_cache *flow_rules_cache =3D &priv->flow_rul=
es_cache;
> > +
> > +     if (!priv->max_flow_rules)
> > +             return;
>
> Is this needed? Is kernel style just kvfree() w/o checks?
>
Will remove


> > +
> > +     kvfree(flow_rules_cache->rule_ids_cache);
> > +     flow_rules_cache->rule_ids_cache =3D NULL;
> > +     kvfree(flow_rules_cache->rules_cache);
> > +     flow_rules_cache->rules_cache =3D NULL;
> > +}
> > +
> >  static int gve_alloc_counter_array(struct gve_priv *priv)
> >  {
> >       priv->counter_array =3D
> > @@ -521,9 +567,12 @@ static int gve_setup_device_resources(struct gve_p=
riv *priv)
> >  {
> >       int err;
> >
> > -     err =3D gve_alloc_counter_array(priv);
> > +     err =3D gve_alloc_flow_rule_caches(priv);
> >       if (err)
> >               return err;
> > +     err =3D gve_alloc_counter_array(priv);
> > +     if (err)
> > +             goto abort_with_flow_rule_caches;
> >       err =3D gve_alloc_notify_blocks(priv);
> >       if (err)
> >               goto abort_with_counter;
> > @@ -575,6 +624,8 @@ static int gve_setup_device_resources(struct gve_pr=
iv *priv)
> >       gve_free_notify_blocks(priv);
> >  abort_with_counter:
> >       gve_free_counter_array(priv);
> > +abort_with_flow_rule_caches:
> > +     gve_free_flow_rule_caches(priv);
> >
> >       return err;
> >  }
> > @@ -606,6 +657,7 @@ static void gve_teardown_device_resources(struct gv=
e_priv *priv)
> >       kvfree(priv->ptype_lut_dqo);
> >       priv->ptype_lut_dqo =3D NULL;
> >
> > +     gve_free_flow_rule_caches(priv);
> >       gve_free_counter_array(priv);
> >       gve_free_notify_blocks(priv);
> >       gve_free_stats_report(priv);

