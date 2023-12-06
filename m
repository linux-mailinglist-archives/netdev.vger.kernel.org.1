Return-Path: <netdev+bounces-54277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A296780669A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A92D281C39
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245B101C7;
	Wed,  6 Dec 2023 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhH67Wj6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355DBC9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 21:34:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3334d9b57adso284565f8f.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 21:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701840856; x=1702445656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NhwBXXMgpHRCa7LQMG5xlDEGQwNAh/cE1AqtxH7qtbE=;
        b=yhH67Wj6+AthraA+402eRkYKVh2JWnbtE29OUkJ0iSRNBjJ0jBydNOx0xpyiC7mJj9
         q/DyboEvw5CJo0dqCrLgibGpO4msTQ5C/rxXDzILAMnyYpnzxp8bSr4n34EHk7/+Pcwm
         yjZNwDlg7259S5lLUHthB5rsT+WOwsUau0uHyeMBa3ElcWiCVwk1Ho5N6E88YWLnoxyL
         HemDN4WMYepu0XnPaEiMvuSEC7VphmxQ2uAsi5MbZnHKEqElwv+jKq6jjNQy5Z3YEjpz
         /z/gZPXHtB1Es2s8Lk2do9ndXnwYLxid/hSagJG1n2NeV3O9Qx2uekiW7VpUuCSPapNB
         HP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701840856; x=1702445656;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhwBXXMgpHRCa7LQMG5xlDEGQwNAh/cE1AqtxH7qtbE=;
        b=QLwsP5rOSgTHapH8VuJvQIqnovOFmZsX5c97lBTGadQyaJW2CGyQ2KMJtEXhyCJdVS
         ZBjXsZjnD8aRj8z6t71R7xaTYWkCckDsHHeP5FddImkuBF33ikP4XEPtJVwoLhYlbJhn
         fpBRO3IVkiZaWvU4vCUUxCFN93MTWMZWhJC5iNLpytzcAZm6Wua/v0s1Uhyv01HyW3vH
         HBzjPm5oGEu8qeWBJ8SsaLopKQwUY0mAqUNFfum1JDsLGCscng1UroQSsJQidUQFy4uG
         dEwt4gUABQIsV6h2TrfyPOQ132DQsRW+QtO9y+s5wATj/ybgiJOTATop7NyGcuVAxpeK
         zkpA==
X-Gm-Message-State: AOJu0YyIcZ8atFzB4rKns8MFZpRD05FhsSc+MGVkcgFlikY19BSK+qi/
	YOL3OGhZb2lB00Vd7hFvkCQx0Q==
X-Google-Smtp-Source: AGHT+IHpS3LVlFkoOpd1qUnn5oCHFYg028Cols201tRqsXQLIZxnZBGkSZ6CSAFX15SvIw4LnExMzw==
X-Received: by 2002:adf:ea50:0:b0:333:47eb:a278 with SMTP id j16-20020adfea50000000b0033347eba278mr138897wrn.80.1701840856558;
        Tue, 05 Dec 2023 21:34:16 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d17-20020adff851000000b0033335c011e0sm11548261wrq.63.2023.12.05.21.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 21:34:16 -0800 (PST)
Date: Wed, 6 Dec 2023 08:34:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Jamal Hadi Salim <jhs@mojatatu.com>,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, deb.chatterjee@intel.com,
	anjali.singhai@intel.com, namrata.limaye@intel.com,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, jiri@resnulli.us,
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com,
	horms@kernel.org, khalidm@nvidia.com, toke@redhat.com,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v9 13/15] p4tc: add runtime table entry create,
 update, get, delete, flush and dump
Message-ID: <9dc10258-a370-4c8f-8099-36edf40b6f80@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201182904.532825-14-jhs@mojatatu.com>

Hi Jamal,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Jamal-Hadi-Salim/net-sched-act_api-increase-action-kind-string-length/20231202-032940
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231201182904.532825-14-jhs%40mojatatu.com
patch subject: [PATCH net-next v9 13/15] p4tc: add runtime table entry create, update, get, delete, flush and dump
config: powerpc64-randconfig-r081-20231204 (https://download.01.org/0day-ci/archive/20231205/202312052121.NV57fCuG-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312052121.NV57fCuG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312052121.NV57fCuG-lkp@intel.com/

smatch warnings:
net/sched/p4tc/p4tc_tbl_entry.c:2555 p4tc_tbl_entry_dumpit() warn: can 'nl_path_attrs.pname' even be NULL?

vim +2555 net/sched/p4tc/p4tc_tbl_entry.c

0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2529  	pnatt = nla_reserve(skb, P4TC_ROOT_PNAME, P4TC_PIPELINE_NAMSIZ);
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2530  	if (!pnatt)
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2531  		return -ENOMEM;
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2532  
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2533  	ids[P4TC_PID_IDX] = t_new->pipeid;
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2534  	arg_ids = nla_data(tb[P4TC_PATH]);
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2535  	memcpy(&ids[P4TC_TBLID_IDX], arg_ids, nla_len(tb[P4TC_PATH]));
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2536  	nl_path_attrs.ids = ids;
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2537  
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2538  	nl_path_attrs.pname = nla_data(pnatt);

nla_data() can't be NULL

0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2539  	if (!p_name) {
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2540  		/* Filled up by the operation or forced failure */
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2541  		memset(nl_path_attrs.pname, 0, P4TC_PIPELINE_NAMSIZ);
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2542  		nl_path_attrs.pname_passed = false;
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2543  	} else {
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2544  		strscpy(nl_path_attrs.pname, p_name, P4TC_PIPELINE_NAMSIZ);

And we dereference it

0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2545  		nl_path_attrs.pname_passed = true;
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2546  	}
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2547  
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2548  	root = nla_nest_start(skb, P4TC_ROOT);
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2549  	ret = p4tc_table_entry_dump(net, skb, tb[P4TC_PARAMS], &nl_path_attrs,
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2550  				    cb, extack);
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2551  	if (ret <= 0)
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2552  		goto out;
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2553  	nla_nest_end(skb, root);
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01  2554  
0d5bbed1381e54 Jamal Hadi Salim 2023-12-01 @2555  	if (nl_path_attrs.pname) {
                                                            ^^^^^^^^^^^^^^^^^^^
This NULL check can be removed.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


