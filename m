Return-Path: <netdev+bounces-92348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0078B6BC9
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7FFBB21B24
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F643FE37;
	Tue, 30 Apr 2024 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNKw7SrB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B983BBC2
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462204; cv=none; b=BebNcj3H9GOukOlDhrxUvlHtENqzQMnlaVapmizWvWoOZp+4P7ui9QAsJBW+9CsFg4vLPoqd9730ByvIwKRTyQbuhOjfAAd2oCu8ZU2FB7pIihp1MeN9xP6eM7h5De8c4jVL1TfcaEuHY7xyeIx0LVxudg/we/KhPePNKOj12FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462204; c=relaxed/simple;
	bh=vPRzrz4KHaiKE/Ee8BHlhjHFLIdji5EOgwc/kZSc/PM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eS4pESLItQiOOKaXKpWCyYyR+A7SAhX0uFc5r49p8lbomC+Hr3GtUF5JYOoPF8wafA0HyXGGTCfFsKGdPCgOD15tjociVbKnGPGExqZ/FYRsqplF6N5Q+EsxIHVVN36/CIkiaXUCE8BfbfMySHQBdAelupeu2g2u/20hPm2UmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dNKw7SrB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57222fc625aso5975583a12.3
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714462200; x=1715067000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4O72YgIq0VJOrYsc+awiottllT2PSmLYAMhVusgwnMs=;
        b=dNKw7SrBXWoK8eVXagUTEw8v+s+2hdk42gteXx1buwZsba2azXH9FdzcULf/C+RXek
         tAl0M344fDAqkp5Xa39iPM7aLi7WZE65cGrjhJDY93+GTg7zACOhjBvJSIF8b0PJNsUn
         BAmaIniAgngdX6nWotrEsghnCmKIdCRzXE4us6ssWAvNP6MvKYDJIHeHNi3hzzeVv6NC
         pjSxrBZQEVTkTEqVPDFAYgnEAEGCLY7o2p2EhJKGJJdT+ortkNYTRlWPO+OxsuQHeoiv
         6zNJPET5RqYQuxyaL9RURqeKxmYrHeXKmXHNieec/C5ZOarrZijdPvgSYRk9eGVCP+s0
         HQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714462200; x=1715067000;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4O72YgIq0VJOrYsc+awiottllT2PSmLYAMhVusgwnMs=;
        b=FkkG/Q0K00UBNsB77acG501nFsUwRJ0r+u4qG+IvlY8RaIXVDYdJXE+b9sNbo6qWYW
         y6yW4x3WU3eESTpuf9Ve+aiAMuToCWm4kUUqWviSLNaMwIJTtFiuLEknjo8v/kcqFUGm
         LWBz5Td5BrJ0Aaqf6r7BdO6xYE+WlA5zuRm/E3150b15R5VgmzDvQPvc+cm0OZKTrf6D
         Qax9uVAxjnOtthl0WyVnOFJfPNl/pQ2JPr9UZwkDFyKiKgwDmXDHD1IQTpvExGXn6CJM
         0hZOlmz6kd1B9+L31H82GS4GxoCwdSP484KMnCWx/MjwhnQwznbac0w8TsYuCVdXDmrf
         Kr1w==
X-Forwarded-Encrypted: i=1; AJvYcCUBOZEVgxc79DVIh8y0CXaWGH3XpkIHcbTRje53NpwZuiWkXUemFv+JfaXpOIhurzn+Dmvyo5VoxAqFh0yYfcH4IbPoKFfV
X-Gm-Message-State: AOJu0YxIQjWKBysR5Ktjrqx3UuIIEFX3iJVtmzTEyJi2p0J34BMxFPGC
	U+1xeSsReyYtViAq6usD82Adh9UoLW+kuyr7rFMlVPz7fmXnwrlUeSKU8FKZJ7o=
X-Google-Smtp-Source: AGHT+IEiwkwI3NRc3OGLDX431vIDn+YQEzn0uQmqy6DusWwU7/vYvKI5bJ51fYj0kVF837wMag1+uw==
X-Received: by 2002:a17:906:aed2:b0:a58:a2f9:d795 with SMTP id me18-20020a170906aed200b00a58a2f9d795mr12458252ejb.59.1714462199832;
        Tue, 30 Apr 2024 00:29:59 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906a19300b00a590f9c1f91sm1066066ejy.197.2024.04.30.00.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:29:59 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:29:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Adrian Moreno <amorenoz@redhat.com>,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, aconole@redhat.com,
	echaudro@redhat.com, horms@kernel.org, i.maximets@ovn.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	linux-kernel@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net-next 6/8] net:openvswitch: add psample support
Message-ID: <29e82a41-5e10-4135-9928-468e5d3abf39@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424135109.3524355-7-amorenoz@redhat.com>

Hi Adrian,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Moreno/net-netlink-export-genl-private-pointer-getters/20240424-215821
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240424135109.3524355-7-amorenoz%40redhat.com
patch subject: [PATCH net-next 6/8] net:openvswitch: add psample support
config: i386-randconfig-141-20240430 (https://download.01.org/0day-ci/archive/20240430/202404300611.kJOZL2KI-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404300611.kJOZL2KI-lkp@intel.com/

New smatch warnings:
net/openvswitch/actions.c:1097 sample() error: uninitialized symbol 'ret'.

vim +/ret +1097 net/openvswitch/actions.c

ccb1352e76cff0 Jesse Gross        2011-10-25  1061  static int sample(struct datapath *dp, struct sk_buff *skb,
ccea74457bbdaf Neil McKee         2015-05-26  1062  		  struct sw_flow_key *key, const struct nlattr *attr,
798c166173ffb5 andy zhou          2017-03-20  1063  		  bool last)
ccb1352e76cff0 Jesse Gross        2011-10-25  1064  {
ccc0b9e4657efd Adrian Moreno      2024-04-24  1065  	const struct sample_arg *arg;
798c166173ffb5 andy zhou          2017-03-20  1066  	struct nlattr *sample_arg;
798c166173ffb5 andy zhou          2017-03-20  1067  	int rem = nla_len(attr);
ccc0b9e4657efd Adrian Moreno      2024-04-24  1068  	struct nlattr *actions;
bef7f7567a104a andy zhou          2017-03-20  1069  	bool clone_flow_key;
ccc0b9e4657efd Adrian Moreno      2024-04-24  1070  	int ret;
ccb1352e76cff0 Jesse Gross        2011-10-25  1071  
798c166173ffb5 andy zhou          2017-03-20  1072  	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
798c166173ffb5 andy zhou          2017-03-20  1073  	sample_arg = nla_data(attr);
798c166173ffb5 andy zhou          2017-03-20  1074  	arg = nla_data(sample_arg);
798c166173ffb5 andy zhou          2017-03-20  1075  	actions = nla_next(sample_arg, &rem);
e05176a3283822 Wenyu Zhang        2015-08-05  1076  
798c166173ffb5 andy zhou          2017-03-20  1077  	if ((arg->probability != U32_MAX) &&
a251c17aa558d8 Jason A. Donenfeld 2022-10-05  1078  	    (!arg->probability || get_random_u32() > arg->probability)) {
798c166173ffb5 andy zhou          2017-03-20  1079  		if (last)
9d802da40b7c82 Adrian Moreno      2023-08-11  1080  			ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
ccb1352e76cff0 Jesse Gross        2011-10-25  1081  		return 0;
ccb1352e76cff0 Jesse Gross        2011-10-25  1082  	}
651887b0c22cff Simon Horman       2014-07-21  1083  
ccc0b9e4657efd Adrian Moreno      2024-04-24  1084  	if (arg->flags & OVS_SAMPLE_ARG_FLAG_PSAMPLE) {
ccc0b9e4657efd Adrian Moreno      2024-04-24  1085  		ret = ovs_psample_packet(dp, key, arg, skb);
ccc0b9e4657efd Adrian Moreno      2024-04-24  1086  		if (ret)
ccc0b9e4657efd Adrian Moreno      2024-04-24  1087  			return ret;
ccc0b9e4657efd Adrian Moreno      2024-04-24  1088  	}
ccc0b9e4657efd Adrian Moreno      2024-04-24  1089  
ccc0b9e4657efd Adrian Moreno      2024-04-24  1090  	if (nla_ok(actions, rem)) {
ccc0b9e4657efd Adrian Moreno      2024-04-24  1091  		clone_flow_key = !(arg->flags & OVS_SAMPLE_ARG_FLAG_EXEC);
ccc0b9e4657efd Adrian Moreno      2024-04-24  1092  		ret = clone_execute(dp, skb, key, 0, actions, rem, last,
bef7f7567a104a andy zhou          2017-03-20  1093  				    clone_flow_key);
ccc0b9e4657efd Adrian Moreno      2024-04-24  1094  	} else if (last) {
ccc0b9e4657efd Adrian Moreno      2024-04-24  1095  		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);

ret is uninitialized on this last path.

ccc0b9e4657efd Adrian Moreno      2024-04-24  1096  	}
ccc0b9e4657efd Adrian Moreno      2024-04-24 @1097  	return ret;
971427f353f3c4 Andy Zhou          2014-09-15  1098  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


