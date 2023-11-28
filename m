Return-Path: <netdev+bounces-51585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65E7FB409
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC13B20C12
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5C179AD;
	Tue, 28 Nov 2023 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KSBDjhiT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ACB91
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:26:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso5207493a12.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701159974; x=1701764774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRuNnViwRGNk6EVRKVb1bwQWLZ9WChGiRiRvtDhMi/I=;
        b=KSBDjhiTUkFpwtVXGcPy+EC8/0PE3KaPE8gSK6eNEm3K1mdOb6W786GBRMvujWMdTk
         Gxwqlj8pQDUelbH3fpjpZXlz6bKIbyWGk7hhWgl9nQeyKETflpQ+BOmXFD5fHENyCZL0
         SZ+5+bBP7a1OK1iV3A6OnYWQW7hH5WKt4DZVO09/0V+t+EesVBGaD1Rb5nCQRrr15cO2
         CUUZJgNiezC+eRN5IQMpqnqHoTLW/UoPl956D6psvg7W/mJE5eHfJC+TxJJV3430Eu3G
         0XIh3J4I4UhXnj3/OenQsl4cKMlwFk884A4rTpj8ivmyBWXYI0lTf7aofTQsftJtjmDx
         hFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701159974; x=1701764774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRuNnViwRGNk6EVRKVb1bwQWLZ9WChGiRiRvtDhMi/I=;
        b=LZbBHxk892hf0V1MrVHStNDH2iMomiudzEtvp/+NQiHBeP2lmk3pPD6KXuiH2Trtyi
         nY0Yae/BUVf1x5qjYCiaO+CYljF7ZxP2kEGhzJj04vj+AK4ohvdAAqQk/spTm/zbBBuU
         4qtkdoCCTd03XqQFNEmm/Blg7dUZ2+xscX7oKZfhW5RIwEg3pX/qOfrdq6/wqQqDxvF4
         p1tSmzzdqJxUIug1cT4I/BXT2xNVTeAbjMFGegygmOrs019IIoNB6hLryE/4hDRlKU8U
         ZxcPSpCPy4kmWCSXwvTkzIlsIWjU9CNw/+l1N3WVFfC24yfk/Tpqsl2RGlTiWYN9xdft
         J4WQ==
X-Gm-Message-State: AOJu0Yx2cZxDBGQ9sxm8jEaIy5wM4BcnkbT/uGwmbkPAzGQ3dHuNxoJ/
	aDIoGoUtwbHK+35s7s/Ch8WLxA==
X-Google-Smtp-Source: AGHT+IFcR6ZLccUcxLTulpI5ivVpbPgEbt411AX/arY6lx+kME7L56AH7FOy6IZH01h11RtxakqF3Q==
X-Received: by 2002:a17:906:7497:b0:a0f:1025:b174 with SMTP id e23-20020a170906749700b00a0f1025b174mr5055557ejl.65.1701159974093;
        Tue, 28 Nov 2023 00:26:14 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709060a5600b009c3827134e5sm6485899ejf.117.2023.11.28.00.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:26:13 -0800 (PST)
Date: Tue, 28 Nov 2023 09:26:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Message-ID: <ZWWkJCeKsVG6UVXv@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-9-jiri@resnulli.us>
 <6dbb53ac-ec93-31cd-5201-0d49b0fdf0bb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dbb53ac-ec93-31cd-5201-0d49b0fdf0bb@intel.com>

Mon, Nov 27, 2023 at 04:40:22PM CET, przemyslaw.kitszel@intel.com wrote:
>On 11/23/23 19:15, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Currently the user listening on a socket for devlink notifications
>> gets always all messages for all existing instances, even if he is
>> interested only in one of those. That may cause unnecessary overhead
>> on setups with thousands of instances present.
>> 
>> User is currently able to narrow down the devlink objects replies
>> to dump commands by specifying select attributes.
>> 
>> Allow similar approach for notifications. Introduce a new devlink
>> NOTIFY_FILTER_SET which the user passes the select attributes. Store
>> these per-socket and use them for filtering messages
>> during multicast send.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v3->v4:
>> - rebased on top of genl_sk_priv_*() introduction
>> ---
>>   Documentation/netlink/specs/devlink.yaml | 10 ++++
>>   include/uapi/linux/devlink.h             |  2 +
>>   net/devlink/devl_internal.h              | 34 ++++++++++-
>>   net/devlink/netlink.c                    | 73 ++++++++++++++++++++++++
>>   net/devlink/netlink_gen.c                | 15 ++++-
>>   net/devlink/netlink_gen.h                |  4 +-
>>   tools/net/ynl/generated/devlink-user.c   | 31 ++++++++++
>>   tools/net/ynl/generated/devlink-user.h   | 47 +++++++++++++++
>>   8 files changed, 212 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> index 43067e1f63aa..6bad1d3454b7 100644
>> --- a/Documentation/netlink/specs/devlink.yaml
>> +++ b/Documentation/netlink/specs/devlink.yaml
>> @@ -2055,3 +2055,13 @@ operations:
>>               - bus-name
>>               - dev-name
>>               - selftests
>> +
>> +    -
>> +      name: notify-filter-set
>> +      doc: Set notification messages socket filter.
>> +      attribute-set: devlink
>> +      do:
>> +        request:
>> +          attributes:
>> +            - bus-name
>> +            - dev-name
>> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>> index b3c8383d342d..130cae0d3e20 100644
>> --- a/include/uapi/linux/devlink.h
>> +++ b/include/uapi/linux/devlink.h
>> @@ -139,6 +139,8 @@ enum devlink_command {
>>   	DEVLINK_CMD_SELFTESTS_GET,	/* can dump */
>>   	DEVLINK_CMD_SELFTESTS_RUN,
>> +	DEVLINK_CMD_NOTIFY_FILTER_SET,
>> +
>>   	/* add new commands above here */
>>   	__DEVLINK_CMD_MAX,
>>   	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
>> diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
>> index 84dc9628d3f2..82e0fb3bbebf 100644
>> --- a/net/devlink/devl_internal.h
>> +++ b/net/devlink/devl_internal.h
>> @@ -191,11 +191,41 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
>>   				  DEVLINK_MCGRP_CONFIG);
>>   }
>> +struct devlink_obj_desc {
>> +	struct rcu_head rcu;
>> +	const char *bus_name;
>> +	const char *dev_name;
>> +	long data[];
>> +};
>> +
>> +static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
>> +					    struct devlink *devlink)
>> +{
>> +	memset(desc, 0, sizeof(*desc));
>> +	desc->bus_name = devlink->dev->bus->name;
>> +	desc->dev_name = dev_name(devlink->dev);
>> +}
>> +
>> +int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data);
>> +
>> +static inline void devlink_nl_notify_send_desc(struct devlink *devlink,
>> +					       struct sk_buff *msg,
>> +					       struct devlink_obj_desc *desc)
>> +{
>> +	genlmsg_multicast_netns_filtered(&devlink_nl_family,
>> +					 devlink_net(devlink),
>> +					 msg, 0, DEVLINK_MCGRP_CONFIG,
>> +					 GFP_KERNEL,
>> +					 devlink_nl_notify_filter, desc);
>> +}
>> +
>>   static inline void devlink_nl_notify_send(struct devlink *devlink,
>>   					  struct sk_buff *msg)
>>   {
>> -	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
>> -				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
>> +	struct devlink_obj_desc desc;
>> +
>> +	devlink_nl_obj_desc_init(&desc, devlink);
>> +	devlink_nl_notify_send_desc(devlink, msg, &desc);
>>   }
>>   /* Notify */
>> diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
>> index fa9afe3e6d9b..33a8e51dea68 100644
>> --- a/net/devlink/netlink.c
>> +++ b/net/devlink/netlink.c
>> @@ -17,6 +17,79 @@ static const struct genl_multicast_group devlink_nl_mcgrps[] = {
>>   	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
>>   };
>> +int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
>> +				      struct genl_info *info)
>> +{
>> +	struct nlattr **attrs = info->attrs;
>> +	struct devlink_obj_desc *flt;
>> +	size_t data_offset = 0;
>> +	size_t data_size = 0;
>> +	char *pos;
>> +
>> +	if (attrs[DEVLINK_ATTR_BUS_NAME])
>> +		data_size += nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1;
>> +	if (attrs[DEVLINK_ATTR_DEV_NAME])
>> +		data_size += nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1;
>> +
>> +	flt = kzalloc(sizeof(*flt) + data_size, GFP_KERNEL);
>
>instead of arithmetic here, you could use struct_size()
>
>> +	if (!flt)
>> +		return -ENOMEM;
>> +
>> +	pos = (char *) flt->data;
>> +	if (attrs[DEVLINK_ATTR_BUS_NAME]) {
>> +		data_offset += nla_strscpy(pos,
>> +					   attrs[DEVLINK_ATTR_BUS_NAME],
>> +					   data_size) + 1;
>> +		flt->bus_name = pos;
>> +		pos += data_offset;
>> +	}
>> +	if (attrs[DEVLINK_ATTR_DEV_NAME]) {
>> +		nla_strscpy(pos, attrs[DEVLINK_ATTR_DEV_NAME],
>> +			    data_size - data_offset);
>> +		flt->dev_name = pos;
>> +	}
>> +
>> +	/* Don't attach empty filter. */
>> +	if (!flt->bus_name && !flt->dev_name) {
>> +		kfree(flt);
>> +		flt = NULL;
>> +	}
>> +
>
>(Thanks for pointing out to this place in the other sub-thread)
>
>[here1] Assume that @flt is fine here.
>
>> +	flt = genl_sk_priv_store(NETLINK_CB(skb).sk, &devlink_nl_family, flt);
>> +	if (IS_ERR(flt))
>> +		return PTR_ERR(flt);
>
>and now you got an error from genl_sk_priv_store(),
>which means that you leak old flt as of [here1].
>I am correct? (sorry it's kinda late :/)

You are correct. Thanks. Looks like I'll be rewriting this entirely
anyway.


>
>> +	else if (flt)
>> +		kfree_rcu(flt, rcu);
>> +
>> +	return 0;
>> +}
>> +
>> +static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
>> +				   const struct devlink_obj_desc *flt)
>> +{
>> +	if (desc->bus_name && flt->bus_name &&
>> +	    strcmp(desc->bus_name, flt->bus_name))
>> +		return false;
>> +	if (desc->dev_name && flt->dev_name &&
>> +	    strcmp(desc->dev_name, flt->dev_name))
>> +		return false;
>> +	return true;
>> +}
>> +
>> +int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>> +{
>> +	struct devlink_obj_desc *desc = data;
>> +	struct devlink_obj_desc *flt;
>> +	int ret = 0;
>> +
>> +	rcu_read_lock();
>> +	flt = genl_sk_priv_get(dsk, &devlink_nl_family);
>> +	if (flt)
>> +		ret = !devlink_obj_desc_match(desc, flt);
>> +	rcu_read_unlock();
>> +	return ret;
>> +}
>> +
>>   int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
>>   				 struct devlink *devlink, int attrtype)
>>   {
>> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
>> index 95f9b4350ab7..1cb0e05305d2 100644
>> --- a/net/devlink/netlink_gen.c
>> +++ b/net/devlink/netlink_gen.c
>> @@ -560,8 +560,14 @@ static const struct nla_policy devlink_selftests_run_nl_policy[DEVLINK_ATTR_SELF
>>   	[DEVLINK_ATTR_SELFTESTS] = NLA_POLICY_NESTED(devlink_dl_selftest_id_nl_policy),
>>   };
>> +/* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
>> +static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
>> +	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>> +	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>> +};
>> +
>>   /* Ops table for devlink */
>> -const struct genl_split_ops devlink_nl_ops[73] = {
>> +const struct genl_split_ops devlink_nl_ops[74] = {
>>   	{
>>   		.cmd		= DEVLINK_CMD_GET,
>>   		.validate	= GENL_DONT_VALIDATE_STRICT,
>> @@ -1233,4 +1239,11 @@ const struct genl_split_ops devlink_nl_ops[73] = {
>>   		.maxattr	= DEVLINK_ATTR_SELFTESTS,
>>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>   	},
>> +	{
>> +		.cmd		= DEVLINK_CMD_NOTIFY_FILTER_SET,
>> +		.doit		= devlink_nl_notify_filter_set_doit,
>> +		.policy		= devlink_notify_filter_set_nl_policy,
>> +		.maxattr	= DEVLINK_ATTR_DEV_NAME,
>> +		.flags		= GENL_CMD_CAP_DO,
>> +	},
>>   };
>> diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
>> index 02f3c0bfae0e..8f2bd50ddf5e 100644
>> --- a/net/devlink/netlink_gen.h
>> +++ b/net/devlink/netlink_gen.h
>> @@ -16,7 +16,7 @@ extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_F
>>   extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
>>   /* Ops table for devlink */
>> -extern const struct genl_split_ops devlink_nl_ops[73];
>> +extern const struct genl_split_ops devlink_nl_ops[74];
>>   int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>>   			struct genl_info *info);
>> @@ -142,5 +142,7 @@ int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
>>   int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
>>   				    struct netlink_callback *cb);
>>   int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
>> +int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
>> +				      struct genl_info *info);
>>   #endif /* _LINUX_DEVLINK_GEN_H */
>> diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
>> index bc5065bd99b2..cd5f70eadf5b 100644
>> --- a/tools/net/ynl/generated/devlink-user.c
>> +++ b/tools/net/ynl/generated/devlink-user.c
>> @@ -6830,6 +6830,37 @@ int devlink_selftests_run(struct ynl_sock *ys,
>>   	return 0;
>>   }
>> +/* ============== DEVLINK_CMD_NOTIFY_FILTER_SET ============== */
>> +/* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
>> +void
>> +devlink_notify_filter_set_req_free(struct devlink_notify_filter_set_req *req)
>> +{
>> +	free(req->bus_name);
>> +	free(req->dev_name);
>> +	free(req);
>> +}
>> +
>> +int devlink_notify_filter_set(struct ynl_sock *ys,
>> +			      struct devlink_notify_filter_set_req *req)
>> +{
>> +	struct nlmsghdr *nlh;
>> +	int err;
>> +
>> +	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_NOTIFY_FILTER_SET, 1);
>> +	ys->req_policy = &devlink_nest;
>> +
>> +	if (req->_present.bus_name_len)
>> +		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
>> +	if (req->_present.dev_name_len)
>> +		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
>> +
>> +	err = ynl_exec(ys, nlh, NULL);
>> +	if (err < 0)
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> +
>>   const struct ynl_family ynl_devlink_family =  {
>>   	.name		= "devlink",
>>   };
>> diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
>> index 1db4edc36eaa..e5d79b824a67 100644
>> --- a/tools/net/ynl/generated/devlink-user.h
>> +++ b/tools/net/ynl/generated/devlink-user.h
>> @@ -5252,4 +5252,51 @@ devlink_selftests_run_req_set_selftests_flash(struct devlink_selftests_run_req *
>>   int devlink_selftests_run(struct ynl_sock *ys,
>>   			  struct devlink_selftests_run_req *req);
>> +/* ============== DEVLINK_CMD_NOTIFY_FILTER_SET ============== */
>> +/* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
>> +struct devlink_notify_filter_set_req {
>> +	struct {
>> +		__u32 bus_name_len;
>> +		__u32 dev_name_len;
>> +	} _present;
>> +
>> +	char *bus_name;
>> +	char *dev_name;
>> +};
>> +
>> +static inline struct devlink_notify_filter_set_req *
>> +devlink_notify_filter_set_req_alloc(void)
>> +{
>> +	return calloc(1, sizeof(struct devlink_notify_filter_set_req));
>> +}
>> +void
>> +devlink_notify_filter_set_req_free(struct devlink_notify_filter_set_req *req);
>> +
>> +static inline void
>> +devlink_notify_filter_set_req_set_bus_name(struct devlink_notify_filter_set_req *req,
>> +					   const char *bus_name)
>> +{
>> +	free(req->bus_name);
>> +	req->_present.bus_name_len = strlen(bus_name);
>> +	req->bus_name = malloc(req->_present.bus_name_len + 1);
>> +	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
>> +	req->bus_name[req->_present.bus_name_len] = 0;
>> +}
>> +static inline void
>> +devlink_notify_filter_set_req_set_dev_name(struct devlink_notify_filter_set_req *req,
>> +					   const char *dev_name)
>> +{
>> +	free(req->dev_name);
>> +	req->_present.dev_name_len = strlen(dev_name);
>> +	req->dev_name = malloc(req->_present.dev_name_len + 1);
>> +	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
>> +	req->dev_name[req->_present.dev_name_len] = 0;
>> +}
>> +
>> +/*
>> + * Set notification messages socket filter.
>> + */
>> +int devlink_notify_filter_set(struct ynl_sock *ys,
>> +			      struct devlink_notify_filter_set_req *req);
>> +
>>   #endif /* _LINUX_DEVLINK_GEN_H */
>

