Return-Path: <netdev+bounces-61554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2754682440A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681351F2236F
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6738D22F1E;
	Thu,  4 Jan 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="WFfcqiE2"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA322F1A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4T5Tr65thBz9ss0;
	Thu,  4 Jan 2024 15:44:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1704379462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMM96rq+r3gpDKgQmkheYSRg5mCay3Trxmeoi9MipHc=;
	b=WFfcqiE2GLSGEx11YHVF7Vmg3SQHbPfNDx6ux3WNNfrLeoKKj2oX63CGwspcmfdWBPxECR
	HeIMZpmdlRzW3AeKj/xe39nsd+1eFfw/jpMsWiGTdISn27u6xNiJ91svVqLN87uASxf+I0
	5wrcpK959RTkeW0um+zuhpLwQp2mbq3wEjW5M2Bboj/8MLGVKdM9zHhisFfUEb+a+ajB/0
	nKpKOtY1sMWUGuQ7vB7GTZturN/P/sDnjYrQJ5GM4kfo9wYe5f+Dhss7YU6Z11m1Y++xRM
	As8zfw6c44CCS4RHoZF7Zwfbk43ckReF/ejpZUgkrNCj8bP0hvV+aI25OG0NAg==
References: <20240104011422.26736-1-stephen@networkplumber.org>
 <20240104011422.26736-7-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: leon@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2 6/6] rdma: do not mix newline and json object
Date: Thu, 04 Jan 2024 15:29:48 +0100
In-reply-to: <20240104011422.26736-7-stephen@networkplumber.org>
Message-ID: <87r0ix5fay.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4T5Tr65thBz9ss0


Stephen Hemminger <stephen@networkplumber.org> writes:

> Mixing the semantics of ending lines with the json object
> leads to several bugs where json object is closed twice, etc.
> Replace by breaking the meaning of newline() function into
> two parts.
>
> Now, lots of functions were taking the rdma data structure as
> argument but never using it.

Oh, I see, this is where the newline_indent() issue I pointed out in 2/6
is resolved. The two patches should be swapped, first print_nl() should
stop closing JSON, then we can safely invoke it in non-JSON context.

Also, this would be much clearer as two patches, each for one paragraph
of the commit message.

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  rdma/dev.c      | 34 ++++++++++++++++--------------
>  rdma/link.c     | 34 ++++++++++++++++--------------
>  rdma/rdma.h     |  7 ++++---
>  rdma/res-cmid.c | 37 +++++++++++++++------------------
>  rdma/res-cq.c   | 31 ++++++++++++++--------------
>  rdma/res-ctx.c  | 11 +++++-----
>  rdma/res-mr.c   | 26 ++++++++++++-----------
>  rdma/res-pd.c   | 21 +++++++++----------
>  rdma/res-qp.c   | 41 ++++++++++++++++++------------------
>  rdma/res-srq.c  | 24 +++++++++++----------
>  rdma/res.c      | 29 ++++++++++++--------------
>  rdma/res.h      | 18 +++++++---------
>  rdma/stat-mr.c  | 10 ++++-----
>  rdma/stat.c     | 46 +++++++++++++++++++++--------------------
>  rdma/stat.h     |  4 +---
>  rdma/utils.c    | 55 +++++++++++++++++++++++++------------------------
>  16 files changed, 216 insertions(+), 212 deletions(-)
>
> diff --git a/rdma/dev.c b/rdma/dev.c
> index 31868c6fe43e..f495b7138b34 100644
> --- a/rdma/dev.c
> +++ b/rdma/dev.c
> @@ -84,7 +84,7 @@ static const char *dev_caps_to_str(uint32_t idx)
>  	return "UNKNOWN";
>  }
>  
> -static void dev_print_caps(struct rd *rd, struct nlattr **tb)
> +static void dev_print_caps(struct nlattr **tb)
>  {
>  	uint64_t caps;
>  	uint32_t idx;
> @@ -106,9 +106,10 @@ static void dev_print_caps(struct rd *rd, struct nlattr **tb)
>  	close_json_array(PRINT_ANY, ">");
>  }
>  
> -static void dev_print_fw(struct rd *rd, struct nlattr **tb)
> +static void dev_print_fw(struct nlattr **tb)
>  {
>  	const char *str;
> +
>  	if (!tb[RDMA_NLDEV_ATTR_FW_VERSION])
>  		return;
>  
> @@ -116,7 +117,7 @@ static void dev_print_fw(struct rd *rd, struct nlattr **tb)
>  	print_string(PRINT_ANY, "fw", "fw %s ", str);
>  }
>  
> -static void dev_print_node_guid(struct rd *rd, struct nlattr **tb)
> +static void dev_print_node_guid(struct nlattr **tb)
>  {
>  	uint64_t node_guid;
>  	uint16_t vp[4];
> @@ -132,7 +133,7 @@ static void dev_print_node_guid(struct rd *rd, struct nlattr **tb)
>  			   str);
>  }
>  
> -static void dev_print_sys_image_guid(struct rd *rd, struct nlattr **tb)
> +static void dev_print_sys_image_guid(struct nlattr **tb)
>  {
>  	uint64_t sys_image_guid;
>  	uint16_t vp[4];
> @@ -147,7 +148,7 @@ static void dev_print_sys_image_guid(struct rd *rd, struct nlattr **tb)
>  	print_string(PRINT_ANY, "sys_image_guid", "sys_image_guid %s ", str);
>  }
>  
> -static void dev_print_dim_setting(struct rd *rd, struct nlattr **tb)
> +static void dev_print_dim_setting(struct nlattr **tb)
>  {
>  	uint8_t dim_setting;
>  
> @@ -174,7 +175,7 @@ static const char *node_type_to_str(uint8_t node_type)
>  	return "unknown";
>  }
>  
> -static void dev_print_node_type(struct rd *rd, struct nlattr **tb)
> +static void dev_print_node_type(struct nlattr **tb)
>  {
>  	const char *node_str;
>  	uint8_t node_type;
> @@ -187,7 +188,7 @@ static void dev_print_node_type(struct rd *rd, struct nlattr **tb)
>  	print_string(PRINT_ANY, "node_type", "node_type %s ", node_str);
>  }
>  
> -static void dev_print_dev_proto(struct rd *rd, struct nlattr **tb)
> +static void dev_print_dev_proto(struct nlattr **tb)
>  {
>  	const char *str;
>  
> @@ -208,23 +209,26 @@ static int dev_parse_cb(const struct nlmsghdr *nlh, void *data)
>  	mnl_attr_parse(nlh, 0, rd_attr_cb, tb);
>  	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX] || !tb[RDMA_NLDEV_ATTR_DEV_NAME])
>  		return MNL_CB_ERROR;
> +
>  	open_json_object(NULL);
>  	idx =  mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
>  	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
>  	print_uint(PRINT_ANY, "ifindex", "%u: ", idx);
>  	print_string(PRINT_ANY, "ifname", "%s: ", name);
>  
> -	dev_print_node_type(rd, tb);
> -	dev_print_dev_proto(rd, tb);
> -	dev_print_fw(rd, tb);
> -	dev_print_node_guid(rd, tb);
> -	dev_print_sys_image_guid(rd, tb);
> +	dev_print_node_type(tb);
> +	dev_print_dev_proto(tb);
> +	dev_print_fw(tb);
> +	dev_print_node_guid(tb);
> +	dev_print_sys_image_guid(tb);
>  	if (rd->show_details) {
> -		dev_print_dim_setting(rd, tb);
> -		dev_print_caps(rd, tb);
> +		dev_print_dim_setting(tb);
> +		dev_print_caps(tb);
>  	}
>  
> -	newline(rd);
> +	close_json_object();
> +	newline();
> +
>  	return MNL_CB_OK;
>  }
>  
> diff --git a/rdma/link.c b/rdma/link.c
> index d7d9558b49f2..853181733f00 100644
> --- a/rdma/link.c
> +++ b/rdma/link.c
> @@ -86,7 +86,7 @@ static const char *caps_to_str(uint32_t idx)
>  	return "UNKNOWN";
>  }
>  
> -static void link_print_caps(struct rd *rd, struct nlattr **tb)
> +static void link_print_caps(struct nlattr **tb)
>  {
>  	uint64_t caps;
>  	uint32_t idx;
> @@ -108,7 +108,7 @@ static void link_print_caps(struct rd *rd, struct nlattr **tb)
>  	close_json_array(PRINT_ANY, ">");
>  }
>  
> -static void link_print_subnet_prefix(struct rd *rd, struct nlattr **tb)
> +static void link_print_subnet_prefix(struct nlattr **tb)
>  {
>  	uint64_t subnet_prefix;
>  	uint16_t vp[4];
> @@ -123,7 +123,7 @@ static void link_print_subnet_prefix(struct rd *rd, struct nlattr **tb)
>  	print_string(PRINT_ANY, "subnet_prefix", "subnet_prefix %s ", str);
>  }
>  
> -static void link_print_lid(struct rd *rd, struct nlattr **tb)
> +static void link_print_lid(struct nlattr **tb)
>  {
>  	uint32_t lid;
>  
> @@ -134,7 +134,7 @@ static void link_print_lid(struct rd *rd, struct nlattr **tb)
>  	print_uint(PRINT_ANY, "lid", "lid %u ", lid);
>  }
>  
> -static void link_print_sm_lid(struct rd *rd, struct nlattr **tb)
> +static void link_print_sm_lid(struct nlattr **tb)
>  {
>  	uint32_t sm_lid;
>  
> @@ -145,7 +145,7 @@ static void link_print_sm_lid(struct rd *rd, struct nlattr **tb)
>  	print_uint(PRINT_ANY, "sm_lid", "sm_lid %u ", sm_lid);
>  }
>  
> -static void link_print_lmc(struct rd *rd, struct nlattr **tb)
> +static void link_print_lmc(struct nlattr **tb)
>  {
>  	uint8_t lmc;
>  
> @@ -167,7 +167,7 @@ static const char *link_state_to_str(uint8_t link_state)
>  	return "UNKNOWN";
>  }
>  
> -static void link_print_state(struct rd *rd, struct nlattr **tb)
> +static void link_print_state(struct nlattr **tb)
>  {
>  	uint8_t state;
>  
> @@ -192,7 +192,7 @@ static const char *phys_state_to_str(uint8_t phys_state)
>  	return "UNKNOWN";
>  };
>  
> -static void link_print_phys_state(struct rd *rd, struct nlattr **tb)
> +static void link_print_phys_state(struct nlattr **tb)
>  {
>  	uint8_t phys_state;
>  
> @@ -204,7 +204,7 @@ static void link_print_phys_state(struct rd *rd, struct nlattr **tb)
>  		     phys_state_to_str(phys_state));
>  }
>  
> -static void link_print_netdev(struct rd *rd, struct nlattr **tb)
> +static void link_print_netdev(const struct rd * rd, struct nlattr **tb)
>  {
>  	const char *netdev_name;
>  	uint32_t idx;
> @@ -242,17 +242,19 @@ static int link_parse_cb(const struct nlmsghdr *nlh, void *data)
>  	print_uint(PRINT_JSON, "ifindex", NULL, idx);
>  	print_string(PRINT_ANY, "ifname", "link %s/", name);
>  	print_uint(PRINT_ANY, "port", "%u ", port);
> -	link_print_subnet_prefix(rd, tb);
> -	link_print_lid(rd, tb);
> -	link_print_sm_lid(rd, tb);
> -	link_print_lmc(rd, tb);
> -	link_print_state(rd, tb);
> -	link_print_phys_state(rd, tb);
> +	link_print_subnet_prefix(tb);
> +	link_print_lid(tb);
> +	link_print_sm_lid(tb);
> +	link_print_lmc(tb);
> +	link_print_state(tb);
> +	link_print_phys_state(tb);
>  	link_print_netdev(rd, tb);
>  	if (rd->show_details)
> -		link_print_caps(rd, tb);
> +		link_print_caps(tb);
> +
> +	close_json_object();
> +	newline();
>  
> -	newline(rd);
>  	return MNL_CB_OK;
>  }
>  
> diff --git a/rdma/rdma.h b/rdma/rdma.h
> index 65e3557d4036..1f8f83269457 100644
> --- a/rdma/rdma.h
> +++ b/rdma/rdma.h
> @@ -135,9 +135,10 @@ int rd_attr_cb(const struct nlattr *attr, void *data);
>   */
>  void print_driver_table(struct rd *rd, struct nlattr *tb);
>  void print_raw_data(struct rd *rd, struct nlattr **nla_line);
> -void newline(struct rd *rd);
> -void newline_indent(struct rd *rd);
> -void print_raw_data(struct rd *rd, struct nlattr **nla_line);
> +void newline_indent(void);
> +void newline(void);
> +
>  #define MAX_LINE_LENGTH 80
>  
> +
>  #endif /* _RDMA_TOOL_H_ */
> diff --git a/rdma/res-cmid.c b/rdma/res-cmid.c
> index fb32c58a695a..8b6b349798f9 100644
> --- a/rdma/res-cmid.c
> +++ b/rdma/res-cmid.c
> @@ -37,20 +37,17 @@ static const char *cm_id_ps_to_str(uint32_t ps)
>  	}
>  }
>  
> -static void print_cm_id_state(struct rd *rd, uint8_t state)
> +static void print_cm_id_state(uint8_t state)
>  {
> -	print_string(PRINT_ANY, "state", "state %s ",
> -			   cm_id_state_to_str(state));
> +	print_string(PRINT_ANY, "state", "state %s ", cm_id_state_to_str(state));
>  }
>  
> -static void print_ps(struct rd *rd, uint32_t ps)
> +static void print_ps(uint32_t ps)
>  {
> -	print_string(PRINT_ANY, "ps", "ps %s ",
> -			   cm_id_ps_to_str(ps));
> +	print_string(PRINT_ANY, "ps", "ps %s ", cm_id_ps_to_str(ps));
>  }
>  
> -static void print_ipaddr(struct rd *rd, const char *key, char *addrstr,
> -			 uint16_t port)
> +static void print_ipaddr(const char *key, char *addrstr, uint16_t port)
>  {
>  	int name_size = INET6_ADDRSTRLEN + strlen(":65535");
>  	char json_name[name_size];
> @@ -181,24 +178,24 @@ static int res_cm_id_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	open_json_object(NULL);
> -	print_link(rd, idx, name, port, nla_line);
> -	res_print_u32(rd, "cm-idn", cm_idn,
> -		       nla_line[RDMA_NLDEV_ATTR_RES_CM_IDN]);
> -	res_print_u32(rd, "lqpn", lqpn, nla_line[RDMA_NLDEV_ATTR_RES_LQPN]);
> +	print_link(idx, name, port, nla_line);
> +	res_print_u32("cm-idn", cm_idn, nla_line[RDMA_NLDEV_ATTR_RES_CM_IDN]);
> +	res_print_u32("lqpn", lqpn, nla_line[RDMA_NLDEV_ATTR_RES_LQPN]);
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_TYPE])
> -		print_qp_type(rd, type);
> -	print_cm_id_state(rd, state);
> -	print_ps(rd, ps);
> -	res_print_u32(rd, "pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> -	print_comm(rd, comm, nla_line);
> +		print_qp_type(type);
> +	print_cm_id_state(state);
> +	print_ps(ps);
> +	res_print_u32("pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> +	print_comm(comm, nla_line);
>  
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_SRC_ADDR])
> -		print_ipaddr(rd, "src-addr", src_addr_str, src_port);
> +		print_ipaddr("src-addr", src_addr_str, src_port);
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_DST_ADDR])
> -		print_ipaddr(rd, "dst-addr", dst_addr_str, dst_port);
> +		print_ipaddr("dst-addr", dst_addr_str, dst_port);
>  
>  	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  
>  out:
>  	return MNL_CB_OK;
> diff --git a/rdma/res-cq.c b/rdma/res-cq.c
> index b4dcc026ed4b..420e935ac926 100644
> --- a/rdma/res-cq.c
> +++ b/rdma/res-cq.c
> @@ -17,14 +17,14 @@ static const char *poll_ctx_to_str(uint8_t idx)
>  	return "UNKNOWN";
>  }
>  
> -static void print_poll_ctx(struct rd *rd, uint8_t poll_ctx, struct nlattr *attr)
> +static void print_poll_ctx(uint8_t poll_ctx, struct nlattr *attr)
>  {
>  	if (!attr)
>  		return;
>  	print_string(PRINT_ANY, "poll-ctx", "poll-ctx %s ", poll_ctx_to_str(poll_ctx));
>  }
>  
> -static void print_cq_dim_setting(struct rd *rd, struct nlattr *attr)
> +static void print_cq_dim_setting(struct nlattr *attr)
>  {
>  	uint8_t dim_setting;
>  
> @@ -45,9 +45,10 @@ static int res_cq_line_raw(struct rd *rd, const char *name, int idx,
>  		return MNL_CB_ERROR;
>  
>  	open_json_object(NULL);
> -	print_dev(rd, idx, name);
> +	print_dev(idx, name);
>  	print_raw_data(rd, nla_line);
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  
>  	return MNL_CB_OK;
>  }
> @@ -110,19 +111,19 @@ static int res_cq_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	open_json_object(NULL);
> -	print_dev(rd, idx, name);
> -	res_print_u32(rd, "cqn", cqn, nla_line[RDMA_NLDEV_ATTR_RES_CQN]);
> -	res_print_u32(rd, "cqe", cqe, nla_line[RDMA_NLDEV_ATTR_RES_CQE]);
> -	res_print_u64(rd, "users", users,
> -		       nla_line[RDMA_NLDEV_ATTR_RES_USECNT]);
> -	print_poll_ctx(rd, poll_ctx, nla_line[RDMA_NLDEV_ATTR_RES_POLL_CTX]);
> -	print_cq_dim_setting(rd, nla_line[RDMA_NLDEV_ATTR_DEV_DIM]);
> -	res_print_u32(rd, "ctxn", ctxn, nla_line[RDMA_NLDEV_ATTR_RES_CTXN]);
> -	res_print_u32(rd, "pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> -	print_comm(rd, comm, nla_line);
> +	print_dev(idx, name);
> +	res_print_u32("cqn", cqn, nla_line[RDMA_NLDEV_ATTR_RES_CQN]);
> +	res_print_u32("cqe", cqe, nla_line[RDMA_NLDEV_ATTR_RES_CQE]);
> +	res_print_u64("users", users, nla_line[RDMA_NLDEV_ATTR_RES_USECNT]);
> +	print_poll_ctx(poll_ctx, nla_line[RDMA_NLDEV_ATTR_RES_POLL_CTX]);
> +	print_cq_dim_setting(nla_line[RDMA_NLDEV_ATTR_DEV_DIM]);
> +	res_print_u32("ctxn", ctxn, nla_line[RDMA_NLDEV_ATTR_RES_CTXN]);
> +	res_print_u32("pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> +	print_comm(comm, nla_line);
>  
>  	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  
>  out:
>  	return MNL_CB_OK;
> diff --git a/rdma/res-ctx.c b/rdma/res-ctx.c
> index 500186d9ff59..0a84d0169327 100644
> --- a/rdma/res-ctx.c
> +++ b/rdma/res-ctx.c
> @@ -41,13 +41,14 @@ static int res_ctx_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	open_json_object(NULL);
> -	print_dev(rd, idx, name);
> -	res_print_u32(rd, "ctxn", ctxn, nla_line[RDMA_NLDEV_ATTR_RES_CTXN]);
> -	res_print_u32(rd, "pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> -	print_comm(rd, comm, nla_line);
> +	print_dev(idx, name);
> +	res_print_u32("ctxn", ctxn, nla_line[RDMA_NLDEV_ATTR_RES_CTXN]);
> +	res_print_u32("pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> +	print_comm(comm, nla_line);
>  
>  	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  
>  out:
>  	return MNL_CB_OK;
> diff --git a/rdma/res-mr.c b/rdma/res-mr.c
> index fb48d5df6cad..693d98c142b6 100644
> --- a/rdma/res-mr.c
> +++ b/rdma/res-mr.c
> @@ -14,9 +14,10 @@ static int res_mr_line_raw(struct rd *rd, const char *name, int idx,
>  		return MNL_CB_ERROR;
>  
>  	open_json_object(NULL);
> -	print_dev(rd, idx, name);
> +	print_dev(idx, name);
>  	print_raw_data(rd, nla_line);
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  
>  	return MNL_CB_OK;
>  }
> @@ -75,19 +76,20 @@ static int res_mr_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	open_json_object(NULL);
> -	print_dev(rd, idx, name);
> -	res_print_u32(rd, "mrn", mrn, nla_line[RDMA_NLDEV_ATTR_RES_MRN]);
> -	print_key(rd, "rkey", rkey, nla_line[RDMA_NLDEV_ATTR_RES_RKEY]);
> -	print_key(rd, "lkey", lkey, nla_line[RDMA_NLDEV_ATTR_RES_LKEY]);
> -	print_key(rd, "iova", iova, nla_line[RDMA_NLDEV_ATTR_RES_IOVA]);
> -	res_print_u64(rd, "mrlen", mrlen, nla_line[RDMA_NLDEV_ATTR_RES_MRLEN]);
> -	res_print_u32(rd, "pdn", pdn, nla_line[RDMA_NLDEV_ATTR_RES_PDN]);
> -	res_print_u32(rd, "pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> -	print_comm(rd, comm, nla_line);
> +	print_dev(idx, name);
> +	res_print_u32("mrn", mrn, nla_line[RDMA_NLDEV_ATTR_RES_MRN]);
> +	print_key("rkey", rkey, nla_line[RDMA_NLDEV_ATTR_RES_RKEY]);
> +	print_key("lkey", lkey, nla_line[RDMA_NLDEV_ATTR_RES_LKEY]);
> +	print_key("iova", iova, nla_line[RDMA_NLDEV_ATTR_RES_IOVA]);
> +	res_print_u64("mrlen", mrlen, nla_line[RDMA_NLDEV_ATTR_RES_MRLEN]);
> +	res_print_u32("pdn", pdn, nla_line[RDMA_NLDEV_ATTR_RES_PDN]);
> +	res_print_u32("pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> +	print_comm(comm, nla_line);
>  
>  	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
>  	print_raw_data(rd, nla_line);
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  
>  out:
>  	return MNL_CB_OK;
> diff --git a/rdma/res-pd.c b/rdma/res-pd.c
> index 66f91f42860f..40a3f9bd561d 100644
> --- a/rdma/res-pd.c
> +++ b/rdma/res-pd.c
> @@ -63,21 +63,20 @@ static int res_pd_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	open_json_object(NULL);
> -	print_dev(rd, idx, name);
> -	res_print_u32(rd, "pdn", pdn, nla_line[RDMA_NLDEV_ATTR_RES_PDN]);
> -	print_key(rd, "local_dma_lkey", local_dma_lkey,
> +	print_dev(idx, name);
> +	res_print_u32("pdn", pdn, nla_line[RDMA_NLDEV_ATTR_RES_PDN]);
> +	print_key("local_dma_lkey", local_dma_lkey,
>  		  nla_line[RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY]);
> -	res_print_u64(rd, "users", users,
> -		       nla_line[RDMA_NLDEV_ATTR_RES_USECNT]);
> -	print_key(rd, "unsafe_global_rkey", unsafe_global_rkey,
> +	res_print_u64("users", users, nla_line[RDMA_NLDEV_ATTR_RES_USECNT]);
> +	print_key("unsafe_global_rkey", unsafe_global_rkey,
>  		  nla_line[RDMA_NLDEV_ATTR_RES_UNSAFE_GLOBAL_RKEY]);
> -	res_print_u32(rd, "ctxn", ctxn, nla_line[RDMA_NLDEV_ATTR_RES_CTXN]);
> -	res_print_u32(rd, "pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> -	print_comm(rd, comm, nla_line);
> +	res_print_u32("ctxn", ctxn, nla_line[RDMA_NLDEV_ATTR_RES_CTXN]);
> +	res_print_u32("pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> +	print_comm(comm, nla_line);
>  
>  	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
> -	newline(rd);
> -
> +	close_json_object();
> +	newline();
>  out:
>  	return MNL_CB_OK;
>  }
> diff --git a/rdma/res-qp.c b/rdma/res-qp.c
> index 2390c0b5732b..145292aa375f 100644
> --- a/rdma/res-qp.c
> +++ b/rdma/res-qp.c
> @@ -28,24 +28,24 @@ static const char *qp_states_to_str(uint8_t idx)
>  	return "UNKNOWN";
>  }
>  
> -static void print_rqpn(struct rd *rd, uint32_t val, struct nlattr **nla_line)
> +static void print_rqpn(uint32_t val, struct nlattr **nla_line)
>  {
>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_RQPN])
>  		return;
>  	print_uint(PRINT_ANY, "rqpn", "rqpn %d ", val);
>  }
>  
> -static void print_type(struct rd *rd, uint32_t val)
> +static void print_type(uint32_t val)
>  {
>  	print_string(PRINT_ANY, "type", "type %s ", qp_types_to_str(val));
>  }
>  
> -static void print_state(struct rd *rd, uint32_t val)
> +static void print_state(uint32_t val)
>  {
>  	print_string(PRINT_ANY, "state", "state %s ", qp_states_to_str(val));
>  }
>  
> -static void print_rqpsn(struct rd *rd, uint32_t val, struct nlattr **nla_line)
> +static void print_rqpsn(uint32_t val, struct nlattr **nla_line)
>  {
>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_RQ_PSN])
>  		return;
> @@ -53,7 +53,7 @@ static void print_rqpsn(struct rd *rd, uint32_t val, struct nlattr **nla_line)
>  	print_uint(PRINT_ANY, "rq-psn", "rq-psn %d ", val);
>  }
>  
> -static void print_pathmig(struct rd *rd, uint32_t val, struct nlattr **nla_line)
> +static void print_pathmig(uint32_t val, struct nlattr **nla_line)
>  {
>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_PATH_MIG_STATE])
>  		return;
> @@ -68,9 +68,10 @@ static int res_qp_line_raw(struct rd *rd, const char *name, int idx,
>  		return MNL_CB_ERROR;
>  
>  	open_json_object(NULL);
> -	print_link(rd, idx, name, rd->port_idx, nla_line);
> +	print_link(idx, name, rd->port_idx, nla_line);
>  	print_raw_data(rd, nla_line);
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  
>  	return MNL_CB_OK;
>  }
> @@ -159,24 +160,24 @@ static int res_qp_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	open_json_object(NULL);
> -	print_link(rd, idx, name, port, nla_line);
> -	res_print_u32(rd, "lqpn", lqpn, nla_line[RDMA_NLDEV_ATTR_RES_LQPN]);
> -	print_rqpn(rd, rqpn, nla_line);
> +	print_link(idx, name, port, nla_line);
> +	res_print_u32("lqpn", lqpn, nla_line[RDMA_NLDEV_ATTR_RES_LQPN]);
> +	print_rqpn(rqpn, nla_line);
>  
> -	print_type(rd, type);
> -	print_state(rd, state);
> +	print_type(type);
> +	print_state(state);
>  
> -	print_rqpsn(rd, rq_psn, nla_line);
> -	res_print_u32(rd, "sq-psn", sq_psn,
> -		       nla_line[RDMA_NLDEV_ATTR_RES_SQ_PSN]);
> +	print_rqpsn(rq_psn, nla_line);
> +	res_print_u32("sq-psn", sq_psn, nla_line[RDMA_NLDEV_ATTR_RES_SQ_PSN]);
>  
> -	print_pathmig(rd, path_mig_state, nla_line);
> -	res_print_u32(rd, "pdn", pdn, nla_line[RDMA_NLDEV_ATTR_RES_PDN]);
> -	res_print_u32(rd, "pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> -	print_comm(rd, comm, nla_line);
> +	print_pathmig(path_mig_state, nla_line);
> +	res_print_u32("pdn", pdn, nla_line[RDMA_NLDEV_ATTR_RES_PDN]);
> +	res_print_u32("pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> +	print_comm(comm, nla_line);
>  
>  	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  out:
>  	return MNL_CB_OK;
>  }
> diff --git a/rdma/res-srq.c b/rdma/res-srq.c
> index e702fecd1f34..1d35900af7d1 100644
> --- a/rdma/res-srq.c
> +++ b/rdma/res-srq.c
> @@ -20,7 +20,7 @@ static const char *srq_types_to_str(uint8_t idx)
>  	return "UNKNOWN";
>  }
>  
> -static void print_type(struct rd *rd, uint32_t val)
> +static void print_type(uint32_t val)
>  {
>  	print_string(PRINT_ANY, "type", "type %s ", srq_types_to_str(val));
>  }
> @@ -168,9 +168,10 @@ static int res_srq_line_raw(struct rd *rd, const char *name, int idx,
>  		return MNL_CB_ERROR;
>  
>  	open_json_object(NULL);
> -	print_dev(rd, idx, name);
> +	print_dev(idx, name);
>  	print_raw_data(rd, nla_line);
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  
>  	return MNL_CB_OK;
>  }
> @@ -231,17 +232,18 @@ static int res_srq_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	open_json_object(NULL);
> -	print_dev(rd, idx, name);
> -	res_print_u32(rd, "srqn", srqn, nla_line[RDMA_NLDEV_ATTR_RES_SRQN]);
> -	print_type(rd, type);
> +	print_dev(idx, name);
> +	res_print_u32("srqn", srqn, nla_line[RDMA_NLDEV_ATTR_RES_SRQN]);
> +	print_type(type);
>  	print_qps(qp_str);
> -	res_print_u32(rd, "pdn", pdn, nla_line[RDMA_NLDEV_ATTR_RES_PDN]);
> -	res_print_u32(rd, "cqn", cqn, nla_line[RDMA_NLDEV_ATTR_RES_CQN]);
> -	res_print_u32(rd, "pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> -	print_comm(rd, comm, nla_line);
> +	res_print_u32("pdn", pdn, nla_line[RDMA_NLDEV_ATTR_RES_PDN]);
> +	res_print_u32("cqn", cqn, nla_line[RDMA_NLDEV_ATTR_RES_CQN]);
> +	res_print_u32("pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> +	print_comm(comm, nla_line);
>  
>  	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  
>  out:
>  	return MNL_CB_OK;
> diff --git a/rdma/res.c b/rdma/res.c
> index f64224e1f3eb..3e024134d4fe 100644
> --- a/rdma/res.c
> +++ b/rdma/res.c
> @@ -29,7 +29,7 @@ static int res_help(struct rd *rd)
>  	return 0;
>  }
>  
> -static int res_print_summary(struct rd *rd, struct nlattr **tb)
> +static int res_print_summary(struct nlattr **tb)
>  {
>  	struct nlattr *nla_table = tb[RDMA_NLDEV_ATTR_RES_SUMMARY];
>  	struct nlattr *nla_entry;
> @@ -51,8 +51,7 @@ static int res_print_summary(struct rd *rd, struct nlattr **tb)
>  
>  		name = mnl_attr_get_str(nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_NAME]);
>  		curr = mnl_attr_get_u64(nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
> -		res_print_u64(rd, name, curr,
> -			      nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
> +		res_print_u64(name, curr, nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
>  	}
>  	return 0;
>  }
> @@ -65,7 +64,6 @@ static int res_no_args_idx_parse_cb(const struct nlmsghdr *nlh, void *data)
>  static int res_no_args_parse_cb(const struct nlmsghdr *nlh, void *data)
>  {
>  	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
> -	struct rd *rd = data;
>  	const char *name;
>  	uint32_t idx;
>  
> @@ -80,8 +78,10 @@ static int res_no_args_parse_cb(const struct nlmsghdr *nlh, void *data)
>  	open_json_object(NULL);
>  	print_uint(PRINT_ANY, "ifindex", "%u: ", idx);
>  	print_string(PRINT_ANY, "ifname", "%s: ", name);
> -	res_print_summary(rd, tb);
> -	newline(rd);
> +	res_print_summary(tb);
> +	close_json_object();
> +	newline();
> +
>  	return MNL_CB_OK;
>  }
>  
> @@ -153,7 +153,7 @@ const char *qp_types_to_str(uint8_t idx)
>  	return (idx == 0xFF) ? "DRIVER" : "UNKNOWN";
>  }
>  
> -void print_comm(struct rd *rd, const char *str, struct nlattr **nla_line)
> +void print_comm(const char *str, struct nlattr **nla_line)
>  {
>  	char tmp[18];
>  
> @@ -167,13 +167,13 @@ void print_comm(struct rd *rd, const char *str, struct nlattr **nla_line)
>  	print_string(PRINT_ANY, "comm", "comm %s ", tmp);
>  }
>  
> -void print_dev(struct rd *rd, uint32_t idx, const char *name)
> +void print_dev(uint32_t idx, const char *name)
>  {
>  	print_int(PRINT_ANY, "ifindex", NULL, idx);
>  	print_string(PRINT_ANY, "ifname", "dev %s ", name);
>  }
>  
> -void print_link(struct rd *rd, uint32_t idx, const char *name, uint32_t port,
> +void print_link(uint32_t idx, const char *name, uint32_t port,
>  		struct nlattr **nla_line)
>  {
>  	char tmp[64] = {};
> @@ -190,13 +190,12 @@ void print_link(struct rd *rd, uint32_t idx, const char *name, uint32_t port,
>  	print_string(PRINT_FP, NULL, "link %s ", tmp);
>  }
>  
> -void print_qp_type(struct rd *rd, uint32_t val)
> +void print_qp_type(uint32_t val)
>  {
>  	print_string(PRINT_ANY, "qp-type", "qp-type %s ", qp_types_to_str(val));
>  }
>  
> -void print_key(struct rd *rd, const char *name, uint64_t val,
> -	       struct nlattr *nlattr)
> +void print_key(const char *name, uint64_t val, struct nlattr *nlattr)
>  {
>  	if (!nlattr)
>  		return;
> @@ -204,8 +203,7 @@ void print_key(struct rd *rd, const char *name, uint64_t val,
>  	print_hex(PRINT_ANY, name, " 0x%" PRIx64 " ", val);
>  }
>  
> -void res_print_u32(struct rd *rd, const char *name, uint32_t val,
> -		    struct nlattr *nlattr)
> +void res_print_u32(const char *name, uint32_t val, struct nlattr *nlattr)
>  {
>  	if (!nlattr)
>  		return;
> @@ -213,8 +211,7 @@ void res_print_u32(struct rd *rd, const char *name, uint32_t val,
>  	print_uint(PRINT_FP, NULL, " %" PRIu32 " ", val);
>  }
>  
> -void res_print_u64(struct rd *rd, const char *name, uint64_t val,
> -		    struct nlattr *nlattr)
> +void res_print_u64(const char *name, uint64_t val, struct nlattr *nlattr)
>  {
>  	if (!nlattr)
>  		return;
> diff --git a/rdma/res.h b/rdma/res.h
> index e880c28be569..fd09ce7dc084 100644
> --- a/rdma/res.h
> +++ b/rdma/res.h
> @@ -185,16 +185,12 @@ struct filters srq_valid_filters[MAX_NUMBER_OF_FILTERS] = {
>  RES_FUNC(res_srq, RDMA_NLDEV_CMD_RES_SRQ_GET, srq_valid_filters, true,
>  	 RDMA_NLDEV_ATTR_RES_SRQN);
>  
> -void print_dev(struct rd *rd, uint32_t idx, const char *name);
> -void print_link(struct rd *rd, uint32_t idx, const char *name, uint32_t port,
> -		struct nlattr **nla_line);
> -void print_key(struct rd *rd, const char *name, uint64_t val,
> -	       struct nlattr *nlattr);
> -void res_print_u32(struct rd *rd, const char *name, uint32_t val,
> -		    struct nlattr *nlattr);
> -void res_print_u64(struct rd *rd, const char *name, uint64_t val,
> -		    struct nlattr *nlattr);
> -void print_comm(struct rd *rd, const char *str, struct nlattr **nla_line);
> +void print_dev(uint32_t idx, const char *name);
> +void print_link(uint32_t idx, const char *name, uint32_t port, struct nlattr **nla_line);
> +void print_key(const char *name, uint64_t val, struct nlattr *nlattr);
> +void res_print_u32(const char *name, uint32_t val, struct nlattr *nlattr);
> +void res_print_u64(const char *name, uint64_t val, struct nlattr *nlattr);
> +void print_comm(const char *str, struct nlattr **nla_line);
>  const char *qp_types_to_str(uint8_t idx);
> -void print_qp_type(struct rd *rd, uint32_t val);
> +void print_qp_type(uint32_t val);
>  #endif /* _RDMA_TOOL_RES_H_ */
> diff --git a/rdma/stat-mr.c b/rdma/stat-mr.c
> index 2ba6cb07693e..8f9eb17f00b7 100644
> --- a/rdma/stat-mr.c
> +++ b/rdma/stat-mr.c
> @@ -21,17 +21,17 @@ static int stat_mr_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	open_json_object(NULL);
> -	print_dev(rd, idx, name);
> -	res_print_u32(rd, "mrn", mrn, nla_line[RDMA_NLDEV_ATTR_RES_MRN]);
> +	print_dev(idx, name);
> +	res_print_u32("mrn", mrn, nla_line[RDMA_NLDEV_ATTR_RES_MRN]);
>  
>  	if (nla_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS]) {
> -		ret = res_get_hwcounters(
> -			rd, nla_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS], true);
> +		ret = res_get_hwcounters(nla_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS], true);
>  		if (ret != MNL_CB_OK)
>  			return ret;
>  	}
>  
> -	newline(rd);
> +	close_json_object();
> +	print_nl();
>  out:
>  	return MNL_CB_OK;
>  }
> diff --git a/rdma/stat.c b/rdma/stat.c
> index e90b6197ceb7..46ed17651790 100644
> --- a/rdma/stat.c
> +++ b/rdma/stat.c
> @@ -62,8 +62,7 @@ static struct counter_param auto_params[] = {
>  	{ NULL },
>  };
>  
> -static int prepare_auto_mode_str(struct nlattr **tb, uint32_t mask,
> -				 char *output, int len)
> +static int prepare_auto_mode_str(uint32_t mask, char *output, int len)
>  {
>  	char s[] = "qp auto";
>  	int i, outlen = strlen(s);
> @@ -105,7 +104,6 @@ static int qp_link_get_mode_parse_cb(const struct nlmsghdr *nlh, void *data)
>  	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
>  	uint32_t mode = 0, mask = 0;
>  	char output[128] = {};
> -	struct rd *rd = data;
>  	uint32_t idx, port;
>  	const char *name;
>  
> @@ -128,15 +126,17 @@ static int qp_link_get_mode_parse_cb(const struct nlmsghdr *nlh, void *data)
>  		if (!tb[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK])
>  			return MNL_CB_ERROR;
>  		mask = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK]);
> -		prepare_auto_mode_str(tb, mask, output, sizeof(output));
> +		prepare_auto_mode_str(mask, output, sizeof(output));
>  	} else {
>  		snprintf(output, sizeof(output), "qp auto off");
>  	}
>  
>  	open_json_object(NULL);
> -	print_link(rd, idx, name, port, tb);
> +	print_link(idx, name, port, tb);
>  	print_string(PRINT_ANY, "mode", "mode %s ", output);
> -	newline(rd);
> +	close_json_object();
> +	newline();
> +
>  	return MNL_CB_OK;
>  }
>  
> @@ -184,7 +184,7 @@ static int stat_qp_get_mode(struct rd *rd)
>  	return rd_exec_cmd(rd, cmds, "parameter");
>  }
>  
> -int res_get_hwcounters(struct rd *rd, struct nlattr *hwc_table, bool print)
> +int res_get_hwcounters(struct nlattr *hwc_table, bool print)
>  {
>  	struct nlattr *nla_entry;
>  	const char *nm;
> @@ -208,8 +208,8 @@ int res_get_hwcounters(struct rd *rd, struct nlattr *hwc_table, bool print)
>  
>  		nm = mnl_attr_get_str(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
>  		v = mnl_attr_get_u64(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE]);
> -		newline_indent(rd);
> -		res_print_u64(rd, nm, v, hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
> +		newline_indent();
> +		res_print_u64(nm, v, hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
>  	}
>  
>  	return MNL_CB_OK;
> @@ -278,17 +278,17 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
>  			return MNL_CB_OK;
>  	}
>  
> -	err = res_get_hwcounters(rd, hwc_table, false);
> +	err = res_get_hwcounters(hwc_table, false);
>  	if (err != MNL_CB_OK)
>  		return err;
>  	open_json_object(NULL);
> -	print_link(rd, index, name, port, nla_line);
> +	print_link(index, name, port, nla_line);
>  	print_uint(PRINT_ANY, "cntn", "cntn %u ", cntn);
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_TYPE])
> -		print_qp_type(rd, qp_type);
> -	res_print_u64(rd, "pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> -	print_comm(rd, comm, nla_line);
> -	res_get_hwcounters(rd, hwc_table, true);
> +		print_qp_type(qp_type);
> +	res_print_u64("pid", pid, nla_line[RDMA_NLDEV_ATTR_RES_PID]);
> +	print_comm(comm, nla_line);
> +	res_get_hwcounters(hwc_table, true);
>  	isfirst = true;
>  	open_json_array(PRINT_JSON, "lqpn");
>  	print_string(PRINT_FP, NULL, "%s    LQPN: <", _SL_);
> @@ -308,7 +308,9 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
>  		isfirst = false;
>  	}
>  	close_json_array(PRINT_ANY, ">");
> -	newline(rd);
> +	close_json_object();
> +	newline();
> +
>  	return MNL_CB_OK;
>  }
>  
> @@ -757,7 +759,6 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
>  	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
>  	struct nlattr *nla_entry;
>  	const char *dev, *name;
> -	struct rd *rd = data;
>  	int enabled, err = 0;
>  	bool isfirst = true;
>  	uint32_t port;
> @@ -801,7 +802,7 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
>  			} else {
>  				print_string(PRINT_FP, NULL, ",", NULL);
>  			}
> -			newline_indent(rd);
> +			newline_indent();
>  
>  			print_string(PRINT_ANY, NULL, "%s", name);
>  		}
> @@ -809,7 +810,8 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
>  
>  	if (!isfirst) {
>  		close_json_array(PRINT_JSON, NULL);
> -		newline(rd);
> +		close_json_object();
> +		newline();
>  	}
>  
>  	return 0;
> @@ -1052,7 +1054,6 @@ static int stat_unset(struct rd *rd)
>  static int stat_show_parse_cb(const struct nlmsghdr *nlh, void *data)
>  {
>  	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
> -	struct rd *rd = data;
>  	const char *name;
>  	uint32_t port;
>  	int ret;
> @@ -1068,9 +1069,10 @@ static int stat_show_parse_cb(const struct nlmsghdr *nlh, void *data)
>  	open_json_object(NULL);
>  	print_string(PRINT_ANY, "ifname", "link %s/", name);
>  	print_uint(PRINT_ANY, "port", "%u ", port);
> -	ret = res_get_hwcounters(rd, tb[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS], true);
> +	ret = res_get_hwcounters(tb[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS], true);
>  
> -	newline(rd);
> +	close_json_object();
> +	newline();
>  	return ret;
>  }
>  
> diff --git a/rdma/stat.h b/rdma/stat.h
> index b03a10c9eef6..5adcf4f37e20 100644
> --- a/rdma/stat.h
> +++ b/rdma/stat.h
> @@ -9,9 +9,7 @@
>  
>  #include "rdma.h"
>  
> -int res_get_hwcounters(struct rd *rd, struct nlattr *hwc_table,
> -		       bool print);
> -
> +int res_get_hwcounters(struct nlattr *hwc_table, bool print);
>  int stat_mr_parse_cb(const struct nlmsghdr *nlh, void *data);
>  int stat_mr_idx_parse_cb(const struct nlmsghdr *nlh, void *data);
>  
> diff --git a/rdma/utils.c b/rdma/utils.c
> index aeb627be7715..27595a387faa 100644
> --- a/rdma/utils.c
> +++ b/rdma/utils.c
> @@ -642,6 +642,7 @@ int rd_exec_dev(struct rd *rd, int (*cb)(struct rd *rd))
>  	}
>  out:
>  	delete_json_obj();
> +
>  	return ret;
>  }
>  
> @@ -771,28 +772,29 @@ struct dev_map *dev_map_lookup(struct rd *rd, bool allow_port_index)
>  
>  #define nla_type(attr) ((attr)->nla_type & NLA_TYPE_MASK)
>  
> -void newline(struct rd *rd)
> +/* End of device object always print a newline */
> +void newline(void)
>  {
> -	close_json_object();
> -	print_nl();
> +	putchar('\n');
> +	fflush(stdout);
>  }
>  
> -void newline_indent(struct rd *rd)
> +/* End of partial multi-line segment of a device object */
> +void newline_indent(void)
>  {
> -	newline(rd);
> -	print_string(PRINT_FP, NULL, "    ", NULL);
> +	if (!is_json_context())
> +		printf("%s    ", _SL_);
>  }
>  
> -static int print_driver_string(struct rd *rd, const char *key_str,
> -				 const char *val_str)
> +static int print_driver_string(const char *key_str, const char *val_str)
>  {
>  	print_string(PRINT_ANY, key_str, key_str, val_str);
>  	print_string(PRINT_FP, NULL, " %s ", val_str);
>  	return 0;
>  }
>  
> -static int print_driver_s32(struct rd *rd, const char *key_str, int32_t val,
> -			      enum rdma_nldev_print_type print_type)
> +static int print_driver_s32(const char *key_str, int32_t val,
> +			    enum rdma_nldev_print_type print_type)
>  {
>  	if (!is_json_context()) {
>  		switch (print_type) {
> @@ -808,8 +810,8 @@ static int print_driver_s32(struct rd *rd, const char *key_str, int32_t val,
>  	return 0;
>  }
>  
> -static int print_driver_u32(struct rd *rd, const char *key_str, uint32_t val,
> -			      enum rdma_nldev_print_type print_type)
> +static int print_driver_u32(const char *key_str, uint32_t val,
> +			    enum rdma_nldev_print_type print_type)
>  {
>  	if (!is_json_context()) {
>  		switch (print_type) {
> @@ -825,8 +827,8 @@ static int print_driver_u32(struct rd *rd, const char *key_str, uint32_t val,
>  	return 0;
>  }
>  
> -static int print_driver_s64(struct rd *rd, const char *key_str, int64_t val,
> -			      enum rdma_nldev_print_type print_type)
> +static int print_driver_s64(const char *key_str, int64_t val,
> +			    enum rdma_nldev_print_type print_type)
>  {
>  	if (!is_json_context()) {
>  		switch (print_type) {
> @@ -842,8 +844,8 @@ static int print_driver_s64(struct rd *rd, const char *key_str, int64_t val,
>  	return 0;
>  }
>  
> -static int print_driver_u64(struct rd *rd, const char *key_str, uint64_t val,
> -			      enum rdma_nldev_print_type print_type)
> +static int print_driver_u64(const char *key_str, uint64_t val,
> +			    enum rdma_nldev_print_type print_type)
>  {
>  	if (!is_json_context()) {
>  		switch (print_type) {
> @@ -859,9 +861,8 @@ static int print_driver_u64(struct rd *rd, const char *key_str, uint64_t val,
>  	return 0;
>  }
>  
> -static int print_driver_entry(struct rd *rd, struct nlattr *key_attr,
> -				struct nlattr *val_attr,
> -				enum rdma_nldev_print_type print_type)
> +static int print_driver_entry(struct nlattr *key_attr, struct nlattr *val_attr,
> +			      enum rdma_nldev_print_type print_type)
>  {
>  	int attr_type = nla_type(val_attr);
>  	int ret = -EINVAL;
> @@ -872,19 +873,19 @@ static int print_driver_entry(struct rd *rd, struct nlattr *key_attr,
>  
>  	switch (attr_type) {
>  	case RDMA_NLDEV_ATTR_DRIVER_STRING:
> -		ret = print_driver_string(rd, key_str, mnl_attr_get_str(val_attr));
> +		ret = print_driver_string(key_str, mnl_attr_get_str(val_attr));
>  		break;
>  	case RDMA_NLDEV_ATTR_DRIVER_S32:
> -		ret = print_driver_s32(rd, key_str, mnl_attr_get_u32(val_attr), print_type);
> +		ret = print_driver_s32(key_str, mnl_attr_get_u32(val_attr), print_type);
>  		break;
>  	case RDMA_NLDEV_ATTR_DRIVER_U32:
> -		ret = print_driver_u32(rd, key_str, mnl_attr_get_u32(val_attr), print_type);
> +		ret = print_driver_u32(key_str, mnl_attr_get_u32(val_attr), print_type);
>  		break;
>  	case RDMA_NLDEV_ATTR_DRIVER_S64:
> -		ret = print_driver_s64(rd, key_str, mnl_attr_get_u64(val_attr), print_type);
> +		ret = print_driver_s64(key_str, mnl_attr_get_u64(val_attr), print_type);
>  		break;
>  	case RDMA_NLDEV_ATTR_DRIVER_U64:
> -		ret = print_driver_u64(rd, key_str, mnl_attr_get_u64(val_attr), print_type);
> +		ret = print_driver_u64(key_str, mnl_attr_get_u64(val_attr), print_type);
>  		break;
>  	}
>  	free(key_str);
> @@ -920,7 +921,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
>  	if (!rd->show_driver_details || !tb)
>  		return;
>  
> -	newline_indent(rd);
> +	newline_indent();
>  
>  	/*
>  	 * Driver attrs are tuples of {key, [print-type], value}.
> @@ -932,7 +933,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
>  	mnl_attr_for_each_nested(tb_entry, tb) {
>  
>  		if (cc > MAX_LINE_LENGTH) {
> -			newline_indent(rd);
> +			newline_indent();
>  			cc = 0;
>  		}
>  		if (rd_attr_check(tb_entry, &type) != MNL_CB_OK)
> @@ -945,7 +946,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
>  			print_type = mnl_attr_get_u8(tb_entry);
>  		} else {
>  			val = tb_entry;
> -			ret = print_driver_entry(rd, key, val, print_type);
> +			ret = print_driver_entry(key, val, print_type);
>  			if (ret < 0)
>  				return;
>  			cc += ret;


