Return-Path: <netdev+bounces-218727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB0B3E1BB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DB01A80C31
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C24331AF3F;
	Mon,  1 Sep 2025 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AauLNwVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C6831A56B
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726530; cv=none; b=cpn2gufcyWNWycHTmW0KLYMqh6mSLuflrcclItncyAKBA8JiqE2ypsXlaaNfBc+C5BdjOZCIvoZHNDKMq7vR6eyaWVh5Ecn4MSjW3R0vJ7phd3+R/OD4DL4jvBg262gcT0cc1kiwPvvHV5W2nFrVqQtQGEayIraOAN2F9PlFaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726530; c=relaxed/simple;
	bh=5Su5qnMW/hHYdd9KFxk5sM71atdYkx2Dvh08OZmr2no=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u/QbFbcm5wbApVPFul+DHlTHck8ntOCk2urmrFJ+M/rTC7hRIE6f9j9bWQXwGXJc/tvdtKlhUiu1dYuXN1TY3JVYI1ugIqVDvLXdN2ipO1nP1qm3LdRlHdP+4T6VfTiTs+pmrz0aOr8lvTVDBrUUWvZHkaQMvwRBy/XC+kQz/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AauLNwVV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b86157e18so9552235e9.0
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 04:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756726527; x=1757331327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9cCpZlImVazv64ehQTKhe9f281E06NS/0iMyn5viqg=;
        b=AauLNwVVIjRn7qYZi6llW4+HY0O4kZT+5PC7vWvJFMmBBoZ1/fptMgNH9Py8hgCCsE
         zqIz++IxvZrckFyNyluVq8YgqXSl5Rzhy9zhKCAA+WGKJEBDNUPNGY3bOYwcFWcQBDoo
         2dW/dvJhYZAl6f/doGZXBhl5v4B196KJ8ysAth5QWQkZcZLHzW9k6gkbE9BYw8zp+iBv
         NKn4B0p7AlUF1+d2RTbtAk9J0JxyNGpEFDzfF2Hg8hQ7acbvp3lla4HLDr2MUPGGbpyl
         W0VRNmhowvfbuTcvstMcDMLjihqFWquOxrHIuwLmvFwOO5KH40lmvpH9dAbbtmrysBCX
         dSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726527; x=1757331327;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9cCpZlImVazv64ehQTKhe9f281E06NS/0iMyn5viqg=;
        b=jXd1oUO5OsJPwZ/i6gWGIIGKrxPTLnexe55LHXrrLwWwY1lag5XUwpfLd6P0AVeB0+
         QAy6WQNt/TCbYfo/QZxYrSQudguLCOqHgIdsk4fs07+eHC4f8WiJLD8xdYmF33wgzV1U
         v71PmduauowVcwyoyvS0Ll1jFIeH5Ggkaq5dtcnoeo+AiBzwD3Lw6a5Y04f2/Q+QVcLu
         Ct2T8VW7S7sGwi0hAwkRjzE4kRtC4YNxph/U1BPhUGetrwK39JWfJo8abN0ahFya2ohd
         Ra5Z9IC0XBmmCKCIAYgtSIX1W6cTTHYEJMKEJ2YoDVMfpdVcReWQ4hg/8mRJmQdmDObG
         aAXA==
X-Forwarded-Encrypted: i=1; AJvYcCVIB+gcKRZNJ5FqYfuMM+pQDzq2nbns4pQypKkcRHC9E5fxyGtvQuOGjnE5iRUKkt8JAW6AzyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEqN6/QK5oItUeo3GsT8BRJmuaEgmfN4AI4k9OlsoafoOqj54
	e0oaix6Z5uQstwTDVEpwlf4UQ7rOhAxxadBnwqN4wGTKJxZTPtWbtEE5Ni7q2sex/sc=
X-Gm-Gg: ASbGncsSrixDC2PjYDR8CiczMrRgNEZAEff0qFaXpz0Qa8uvX4FA1zpHtJdX/2elUmN
	H+7blOmg8ywgjL4+qGJbyxYSokt6trOps1yDRdooDWWVKtoGS1C/bxAzT8ZCIuvyl0Nn13yDAie
	4x+SsUAibhyv9zwR/uUTqRALQ20kW7n4Uwtyuvpm88JNkHZq9PKj2kqXZLxOdUrEGcSrtjIh2Ed
	Y0Wc/y54qFymcwahK+8Acqbn2KVJR/SCe15JL36Gi0Enlnk+VwM/gvEHjkUq1VxQpIM+yxvjtt2
	Y9TCCNbF9MpIwQ6OOWNiJX7DWdecP6Ai89EW93F2MWwPraLBwRLg3C37PefAPIok6t8DIBstchq
	jnhYUuSQ3bQv4fwEiwD5CN29M3CKQO8iV4B4nVg==
X-Google-Smtp-Source: AGHT+IEsyjfAmj4sww84+pgQzOLWH82jjfVxE1+yTMurN84goWigwlJr78Akd0Qt+QV+xZ/JTMH/Jw==
X-Received: by 2002:a05:600c:1c0c:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-45b85587d3cmr51042365e9.19.1756726527175;
        Mon, 01 Sep 2025 04:35:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e74b72esm156739695e9.0.2025.09.01.04.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 04:35:26 -0700 (PDT)
Date: Mon, 1 Sep 2025 14:35:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Mina Almasry <almasrymina@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Mina Almasry <almasrymina@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v1] net: devmem: NULL check
 netdev_nl_get_dma_dev return value
Message-ID: <202508310205.YQmsa9gY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829220003.3310242-1-almasrymina@google.com>

Hi Mina,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Mina-Almasry/net-devmem-NULL-check-netdev_nl_get_dma_dev-return-value/20250830-060251
base:   4f54dff818d7b5b1d84becd5d90bc46e6233c0d7
patch link:    https://lore.kernel.org/r/20250829220003.3310242-1-almasrymina%40google.com
patch subject: [PATCH net-next v1] net: devmem: NULL check netdev_nl_get_dma_dev return value
config: x86_64-randconfig-161-20250830 (https://download.01.org/0day-ci/archive/20250831/202508310205.YQmsa9gY-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508310205.YQmsa9gY-lkp@intel.com/

New smatch warnings:
net/core/netdev-genl.c:1102 netdev_nl_bind_tx_doit() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +1102 net/core/netdev-genl.c

8802087d20c0e1 Stanislav Fomichev 2025-05-08  1046  int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
8802087d20c0e1 Stanislav Fomichev 2025-05-08  1047  {
bd61848900bff5 Mina Almasry       2025-05-08  1048  	struct net_devmem_dmabuf_binding *binding;
bd61848900bff5 Mina Almasry       2025-05-08  1049  	struct netdev_nl_sock *priv;
bd61848900bff5 Mina Almasry       2025-05-08  1050  	struct net_device *netdev;
512c88fb0e884c Dragos Tatulea     2025-08-27  1051  	struct device *dma_dev;
bd61848900bff5 Mina Almasry       2025-05-08  1052  	u32 ifindex, dmabuf_fd;
bd61848900bff5 Mina Almasry       2025-05-08  1053  	struct sk_buff *rsp;
bd61848900bff5 Mina Almasry       2025-05-08  1054  	int err = 0;
bd61848900bff5 Mina Almasry       2025-05-08  1055  	void *hdr;
bd61848900bff5 Mina Almasry       2025-05-08  1056  
bd61848900bff5 Mina Almasry       2025-05-08  1057  	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
bd61848900bff5 Mina Almasry       2025-05-08  1058  	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD))
bd61848900bff5 Mina Almasry       2025-05-08  1059  		return -EINVAL;
bd61848900bff5 Mina Almasry       2025-05-08  1060  
bd61848900bff5 Mina Almasry       2025-05-08  1061  	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
bd61848900bff5 Mina Almasry       2025-05-08  1062  	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
bd61848900bff5 Mina Almasry       2025-05-08  1063  
bd61848900bff5 Mina Almasry       2025-05-08  1064  	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
bd61848900bff5 Mina Almasry       2025-05-08  1065  	if (IS_ERR(priv))
bd61848900bff5 Mina Almasry       2025-05-08  1066  		return PTR_ERR(priv);
bd61848900bff5 Mina Almasry       2025-05-08  1067  
bd61848900bff5 Mina Almasry       2025-05-08  1068  	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
bd61848900bff5 Mina Almasry       2025-05-08  1069  	if (!rsp)
bd61848900bff5 Mina Almasry       2025-05-08  1070  		return -ENOMEM;
bd61848900bff5 Mina Almasry       2025-05-08  1071  
bd61848900bff5 Mina Almasry       2025-05-08  1072  	hdr = genlmsg_iput(rsp, info);
bd61848900bff5 Mina Almasry       2025-05-08  1073  	if (!hdr) {
bd61848900bff5 Mina Almasry       2025-05-08  1074  		err = -EMSGSIZE;
bd61848900bff5 Mina Almasry       2025-05-08  1075  		goto err_genlmsg_free;
bd61848900bff5 Mina Almasry       2025-05-08  1076  	}
bd61848900bff5 Mina Almasry       2025-05-08  1077  
bd61848900bff5 Mina Almasry       2025-05-08  1078  	mutex_lock(&priv->lock);
bd61848900bff5 Mina Almasry       2025-05-08  1079  
bd61848900bff5 Mina Almasry       2025-05-08  1080  	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
bd61848900bff5 Mina Almasry       2025-05-08  1081  	if (!netdev) {
bd61848900bff5 Mina Almasry       2025-05-08  1082  		err = -ENODEV;
bd61848900bff5 Mina Almasry       2025-05-08  1083  		goto err_unlock_sock;
bd61848900bff5 Mina Almasry       2025-05-08  1084  	}
bd61848900bff5 Mina Almasry       2025-05-08  1085  
bd61848900bff5 Mina Almasry       2025-05-08  1086  	if (!netif_device_present(netdev)) {
bd61848900bff5 Mina Almasry       2025-05-08  1087  		err = -ENODEV;
bd61848900bff5 Mina Almasry       2025-05-08  1088  		goto err_unlock_netdev;
bd61848900bff5 Mina Almasry       2025-05-08  1089  	}
bd61848900bff5 Mina Almasry       2025-05-08  1090  
ae28cb114727dd Mina Almasry       2025-05-08  1091  	if (!netdev->netmem_tx) {
ae28cb114727dd Mina Almasry       2025-05-08  1092  		err = -EOPNOTSUPP;
ae28cb114727dd Mina Almasry       2025-05-08  1093  		NL_SET_ERR_MSG(info->extack,
ae28cb114727dd Mina Almasry       2025-05-08  1094  			       "Driver does not support netmem TX");
ae28cb114727dd Mina Almasry       2025-05-08  1095  		goto err_unlock_netdev;
ae28cb114727dd Mina Almasry       2025-05-08  1096  	}
ae28cb114727dd Mina Almasry       2025-05-08  1097  
512c88fb0e884c Dragos Tatulea     2025-08-27  1098  	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
512c88fb0e884c Dragos Tatulea     2025-08-27  1099  	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
512c88fb0e884c Dragos Tatulea     2025-08-27  1100  					 dmabuf_fd, priv, info->extack);
991dbef67e2c35 Mina Almasry       2025-08-29  1101  	if (IS_ERR_OR_NULL(binding)) {
bd61848900bff5 Mina Almasry       2025-05-08 @1102  		err = PTR_ERR(binding);
bd61848900bff5 Mina Almasry       2025-05-08  1103  		goto err_unlock_netdev;

net_devmem_bind_dmabuf() can't return NULL.  See my blog for more
details:
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

bd61848900bff5 Mina Almasry       2025-05-08  1104  	}
bd61848900bff5 Mina Almasry       2025-05-08  1105  
bd61848900bff5 Mina Almasry       2025-05-08  1106  	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
bd61848900bff5 Mina Almasry       2025-05-08  1107  	genlmsg_end(rsp, hdr);
bd61848900bff5 Mina Almasry       2025-05-08  1108  
bd61848900bff5 Mina Almasry       2025-05-08  1109  	netdev_unlock(netdev);
bd61848900bff5 Mina Almasry       2025-05-08  1110  	mutex_unlock(&priv->lock);
bd61848900bff5 Mina Almasry       2025-05-08  1111  
bd61848900bff5 Mina Almasry       2025-05-08  1112  	return genlmsg_reply(rsp, info);
bd61848900bff5 Mina Almasry       2025-05-08  1113  
bd61848900bff5 Mina Almasry       2025-05-08  1114  err_unlock_netdev:
bd61848900bff5 Mina Almasry       2025-05-08  1115  	netdev_unlock(netdev);
bd61848900bff5 Mina Almasry       2025-05-08  1116  err_unlock_sock:
bd61848900bff5 Mina Almasry       2025-05-08  1117  	mutex_unlock(&priv->lock);
bd61848900bff5 Mina Almasry       2025-05-08  1118  err_genlmsg_free:
bd61848900bff5 Mina Almasry       2025-05-08  1119  	nlmsg_free(rsp);
bd61848900bff5 Mina Almasry       2025-05-08  1120  	return err;
8802087d20c0e1 Stanislav Fomichev 2025-05-08  1121  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


