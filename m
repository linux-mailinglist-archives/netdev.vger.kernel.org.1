Return-Path: <netdev+bounces-241157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 420EAC80A25
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 710724E2801
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035730149B;
	Mon, 24 Nov 2025 13:01:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52122FC88B
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989300; cv=none; b=jofO+s5Cy9PHhABhrgF8s6txJ0l+bg0IcyeQI5SFn9mSRLOhrxP3GfHFUazUSf3CDe21EuWyHzBSayAm6RQ5NWu6RLtOJbJs81LNgzYkLsJXIwXIZuSJe8rgG7j6aq8hc7rIAqp7wrEmvjSr2eDtQxaHGgWO9NwzFgi2BQtoYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989300; c=relaxed/simple;
	bh=cYyWBhAgVOXTBDQf7+ucDjb2+WssJHRIVP77jgsbhp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shb7v1zykS6gmrImbVNopd3EpBfzqi+ooqc9aWnYyoLdObHqlZ4N5JVRcQIE11j0Hv3blWpDf8y1Vyb+6h4q5PfNefBkMm5VVIh/yTh55Lc7nikx/4lA0je3ZEAnWv+6GFqOkC4UrbMRpfeHIexT/7VRf3HOVxPw0IpdgA8DxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (bharat.asicdesigners.com [10.193.191.68])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 5AOD15i0018808;
	Mon, 24 Nov 2025 05:01:06 -0800
Date: Mon, 24 Nov 2025 18:31:05 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kees@kernel.org" <kees@kernel.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "hariprasad@chelsio.com" <hariprasad@chelsio.com>,
        Jeff Hwang <jhwang@chelsio.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH net] cxgb4: Rename sched_class to avoid type clash
Message-ID: <aSRXEb/X7MAJAeFm@chelsio.com>
References: <20251121181231.64337-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121181231.64337-1-alan.maguire@oracle.com>

On Friday, November 11/21/25, 2025 at 23:42:31 +0530, Alan Maguire wrote:
> drivers/net/ethernet/chelsio/cxgb4/sched.h declares a sched_class
> struct which has a type name clash with struct sched_class
> in kernel/sched/sched.h (a type used in a field in task_struct).
> 
> When cxgb4 is a builtin we end up with both sched_class types,
> and as a result of this we wind up with DWARF (and derived from
> that BTF) with a duplicate incorrect task_struct representation.
> When cxgb4 is built-in this type clash can cause kernel builds to
> fail as resolve_btfids will fail when confused which task_struct
> to use. See [1] for more details.
> 
> As such, renaming sched_class to ch_sched_class (in line with
> other structs like ch_sched_flowc) makes sense.
> 
> [1] https://lore.kernel.org/bpf/2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org/
> 
> Fixes: b72a32dacdfa ("cxgb4: add support for tx traffic scheduling classes")
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Thanks.
Acked-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
>  .../chelsio/cxgb4/cxgb4_tc_matchall.c         |  4 +-
>  .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  |  2 +-
>  drivers/net/ethernet/chelsio/cxgb4/sched.c    | 44 +++++++++----------
>  drivers/net/ethernet/chelsio/cxgb4/sched.h    | 12 ++---
>  5 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index 392723ef14e5..ac0c7fe5743b 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -3485,7 +3485,7 @@ static int cxgb_set_tx_maxrate(struct net_device *dev, int index, u32 rate)
>  	struct adapter *adap = pi->adapter;
>  	struct ch_sched_queue qe = { 0 };
>  	struct ch_sched_params p = { 0 };
> -	struct sched_class *e;
> +	struct ch_sched_class *e;
>  	u32 req_rate;
>  	int err = 0;
>  
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
> index 1672d3afe5be..f8dcf0b4abcd 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
> @@ -56,7 +56,7 @@ static int cxgb4_matchall_egress_validate(struct net_device *dev,
>  	struct port_info *pi = netdev2pinfo(dev);
>  	struct flow_action_entry *entry;
>  	struct ch_sched_queue qe;
> -	struct sched_class *e;
> +	struct ch_sched_class *e;
>  	u64 max_link_rate;
>  	u32 i, speed;
>  	int ret;
> @@ -180,7 +180,7 @@ static int cxgb4_matchall_alloc_tc(struct net_device *dev,
>  	struct port_info *pi = netdev2pinfo(dev);
>  	struct adapter *adap = netdev2adap(dev);
>  	struct flow_action_entry *entry;
> -	struct sched_class *e;
> +	struct ch_sched_class *e;
>  	int ret;
>  	u32 i;
>  
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
> index 338b04f339b3..a2dcd2e24263 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
> @@ -330,7 +330,7 @@ static int cxgb4_mqprio_alloc_tc(struct net_device *dev,
>  	struct cxgb4_tc_port_mqprio *tc_port_mqprio;
>  	struct port_info *pi = netdev2pinfo(dev);
>  	struct adapter *adap = netdev2adap(dev);
> -	struct sched_class *e;
> +	struct ch_sched_class *e;
>  	int ret;
>  	u8 i;
>  
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.c b/drivers/net/ethernet/chelsio/cxgb4/sched.c
> index a1b14468d1ff..38a30aeee122 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/sched.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/sched.c
> @@ -44,7 +44,7 @@ static int t4_sched_class_fw_cmd(struct port_info *pi,
>  {
>  	struct adapter *adap = pi->adapter;
>  	struct sched_table *s = pi->sched_tbl;
> -	struct sched_class *e;
> +	struct ch_sched_class *e;
>  	int err = 0;
>  
>  	e = &s->tab[p->u.params.class];
> @@ -122,7 +122,7 @@ static void *t4_sched_entry_lookup(struct port_info *pi,
>  				   const u32 val)
>  {
>  	struct sched_table *s = pi->sched_tbl;
> -	struct sched_class *e, *end;
> +	struct ch_sched_class *e, *end;
>  	void *found = NULL;
>  
>  	/* Look for an entry with matching @val */
> @@ -166,8 +166,8 @@ static void *t4_sched_entry_lookup(struct port_info *pi,
>  	return found;
>  }
>  
> -struct sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
> -					     struct ch_sched_queue *p)
> +struct ch_sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
> +						struct ch_sched_queue *p)
>  {
>  	struct port_info *pi = netdev2pinfo(dev);
>  	struct sched_queue_entry *qe = NULL;
> @@ -187,7 +187,7 @@ static int t4_sched_queue_unbind(struct port_info *pi, struct ch_sched_queue *p)
>  	struct sched_queue_entry *qe = NULL;
>  	struct adapter *adap = pi->adapter;
>  	struct sge_eth_txq *txq;
> -	struct sched_class *e;
> +	struct ch_sched_class *e;
>  	int err = 0;
>  
>  	if (p->queue < 0 || p->queue >= pi->nqsets)
> @@ -218,7 +218,7 @@ static int t4_sched_queue_bind(struct port_info *pi, struct ch_sched_queue *p)
>  	struct sched_queue_entry *qe = NULL;
>  	struct adapter *adap = pi->adapter;
>  	struct sge_eth_txq *txq;
> -	struct sched_class *e;
> +	struct ch_sched_class *e;
>  	unsigned int qid;
>  	int err = 0;
>  
> @@ -260,7 +260,7 @@ static int t4_sched_flowc_unbind(struct port_info *pi, struct ch_sched_flowc *p)
>  {
>  	struct sched_flowc_entry *fe = NULL;
>  	struct adapter *adap = pi->adapter;
> -	struct sched_class *e;
> +	struct ch_sched_class *e;
>  	int err = 0;
>  
>  	if (p->tid < 0 || p->tid >= adap->tids.neotids)
> @@ -288,7 +288,7 @@ static int t4_sched_flowc_bind(struct port_info *pi, struct ch_sched_flowc *p)
>  	struct sched_table *s = pi->sched_tbl;
>  	struct sched_flowc_entry *fe = NULL;
>  	struct adapter *adap = pi->adapter;
> -	struct sched_class *e;
> +	struct ch_sched_class *e;
>  	int err = 0;
>  
>  	if (p->tid < 0 || p->tid >= adap->tids.neotids)
> @@ -322,7 +322,7 @@ static int t4_sched_flowc_bind(struct port_info *pi, struct ch_sched_flowc *p)
>  }
>  
>  static void t4_sched_class_unbind_all(struct port_info *pi,
> -				      struct sched_class *e,
> +				      struct ch_sched_class *e,
>  				      enum sched_bind_type type)
>  {
>  	if (!e)
> @@ -476,12 +476,12 @@ int cxgb4_sched_class_unbind(struct net_device *dev, void *arg,
>  }
>  
>  /* If @p is NULL, fetch any available unused class */
> -static struct sched_class *t4_sched_class_lookup(struct port_info *pi,
> -						const struct ch_sched_params *p)
> +static struct ch_sched_class *t4_sched_class_lookup(struct port_info *pi,
> +						    const struct ch_sched_params *p)
>  {
>  	struct sched_table *s = pi->sched_tbl;
> -	struct sched_class *found = NULL;
> -	struct sched_class *e, *end;
> +	struct ch_sched_class *found = NULL;
> +	struct ch_sched_class *e, *end;
>  
>  	if (!p) {
>  		/* Get any available unused class */
> @@ -522,10 +522,10 @@ static struct sched_class *t4_sched_class_lookup(struct port_info *pi,
>  	return found;
>  }
>  
> -static struct sched_class *t4_sched_class_alloc(struct port_info *pi,
> -						struct ch_sched_params *p)
> +static struct ch_sched_class *t4_sched_class_alloc(struct port_info *pi,
> +						   struct ch_sched_params *p)
>  {
> -	struct sched_class *e = NULL;
> +	struct ch_sched_class *e = NULL;
>  	u8 class_id;
>  	int err;
>  
> @@ -579,8 +579,8 @@ static struct sched_class *t4_sched_class_alloc(struct port_info *pi,
>   * scheduling class with matching @p is found, then the matching class is
>   * returned.
>   */
> -struct sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
> -					    struct ch_sched_params *p)
> +struct ch_sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
> +					       struct ch_sched_params *p)
>  {
>  	struct port_info *pi = netdev2pinfo(dev);
>  	u8 class_id;
> @@ -607,7 +607,7 @@ void cxgb4_sched_class_free(struct net_device *dev, u8 classid)
>  	struct port_info *pi = netdev2pinfo(dev);
>  	struct sched_table *s = pi->sched_tbl;
>  	struct ch_sched_params p;
> -	struct sched_class *e;
> +	struct ch_sched_class *e;
>  	u32 speed;
>  	int ret;
>  
> @@ -640,7 +640,7 @@ void cxgb4_sched_class_free(struct net_device *dev, u8 classid)
>  	}
>  }
>  
> -static void t4_sched_class_free(struct net_device *dev, struct sched_class *e)
> +static void t4_sched_class_free(struct net_device *dev, struct ch_sched_class *e)
>  {
>  	struct port_info *pi = netdev2pinfo(dev);
>  
> @@ -660,7 +660,7 @@ struct sched_table *t4_init_sched(unsigned int sched_size)
>  	s->sched_size = sched_size;
>  
>  	for (i = 0; i < s->sched_size; i++) {
> -		memset(&s->tab[i], 0, sizeof(struct sched_class));
> +		memset(&s->tab[i], 0, sizeof(struct ch_sched_class));
>  		s->tab[i].idx = i;
>  		s->tab[i].state = SCHED_STATE_UNUSED;
>  		INIT_LIST_HEAD(&s->tab[i].entry_list);
> @@ -682,7 +682,7 @@ void t4_cleanup_sched(struct adapter *adap)
>  			continue;
>  
>  		for (i = 0; i < s->sched_size; i++) {
> -			struct sched_class *e;
> +			struct ch_sched_class *e;
>  
>  			e = &s->tab[i];
>  			if (e->state == SCHED_STATE_ACTIVE)
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.h b/drivers/net/ethernet/chelsio/cxgb4/sched.h
> index 6b3c778815f0..4d3b5a757536 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/sched.h
> +++ b/drivers/net/ethernet/chelsio/cxgb4/sched.h
> @@ -71,7 +71,7 @@ struct sched_flowc_entry {
>  	struct ch_sched_flowc param;
>  };
>  
> -struct sched_class {
> +struct ch_sched_class {
>  	u8 state;
>  	u8 idx;
>  	struct ch_sched_params info;
> @@ -82,7 +82,7 @@ struct sched_class {
>  
>  struct sched_table {      /* per port scheduling table */
>  	u8 sched_size;
> -	struct sched_class tab[] __counted_by(sched_size);
> +	struct ch_sched_class tab[] __counted_by(sched_size);
>  };
>  
>  static inline bool can_sched(struct net_device *dev)
> @@ -103,15 +103,15 @@ static inline bool valid_class_id(struct net_device *dev, u8 class_id)
>  	return true;
>  }
>  
> -struct sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
> -					     struct ch_sched_queue *p);
> +struct ch_sched_class *cxgb4_sched_queue_lookup(struct net_device *dev,
> +						struct ch_sched_queue *p);
>  int cxgb4_sched_class_bind(struct net_device *dev, void *arg,
>  			   enum sched_bind_type type);
>  int cxgb4_sched_class_unbind(struct net_device *dev, void *arg,
>  			     enum sched_bind_type type);
>  
> -struct sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
> -					    struct ch_sched_params *p);
> +struct ch_sched_class *cxgb4_sched_class_alloc(struct net_device *dev,
> +					       struct ch_sched_params *p);
>  void cxgb4_sched_class_free(struct net_device *dev, u8 classid);
>  
>  struct sched_table *t4_init_sched(unsigned int size);
> -- 
> 2.39.3
> 

