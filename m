Return-Path: <netdev+bounces-250964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C7D39DC1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 06:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C318300102C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 05:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2704533067D;
	Mon, 19 Jan 2026 05:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3XZ9bED"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F75330320
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800454; cv=none; b=b9LLESbjhm2OO68qjtfW31/ZolvgxoIat0O09CXQzqaQ+Ks9yMpDrOUn/0WTbItnLj9/H2PwXEEt/LlvC24FM/+rnzaYt5lBtBLLjSIal+RIuogRvzjiC6j5/mCXgzNbHkD8e/lgt3VA5QIUCtVyYYQUAmlTdV3kL3qgrdZR3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800454; c=relaxed/simple;
	bh=GQyIKVnUIV+o89ZaVPW/6Orx8v9FcnDa0Oajgp1SONE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AdWV+pPQmshO4ZYzKdg7V0nzumnGv2yPelUGwOl7+eJGrJZTDl7KymeIMCUmIo+ZtXJd4dCYXCsk4GGlk2Cvt8HVrVs2JT4UHDE/wlWu38CBsfa6GBRQnfhxl91FAzP2G53ukt7qGw9ehp35jNYHpm3Ey7sSv5UbENxlGMy0mLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3XZ9bED; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so21323455e9.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 21:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768800449; x=1769405249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KcHNJUeHYBB6SOgT0QQnF8ZJgMw39mShpamAL4iiy6o=;
        b=U3XZ9bED9kW2q5ElW4AXCLhN9XrwCQ0AIRSB7FLxYso+CehkA+vIVj0IhafFfkuJfa
         v6ae3tdjRTRIr9zEdj6TDIxwbNh9KAECU7twr9w32djVXG5eg+cXk1YfwXE6bfI1oWda
         2dSOmn3EodaxxgPQztU4qTwpxrl9yvnoK/yd6ibxEILhJ8APe76F8iXt0+zFnnJ/zUjM
         5o43ghGzW9tsoXay+12ldeWOT6EM1K9tAMIvzP/wj8vsAkdJC6SEu/l5XPfDLxUxXBjn
         E/kCm9qy7ETduHRr/h54rMDq/MTjqf6O2QeAP5YsjPSb+Yo5IA4sPv5ZR0y9AWpOicc/
         EskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768800449; x=1769405249;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcHNJUeHYBB6SOgT0QQnF8ZJgMw39mShpamAL4iiy6o=;
        b=nSqukzRgBFQYPMcgeqZXUkOE9nm4IzCx3xrNW3o6OcjEUS/EO0SISA6K/KrjNqr39K
         VBvaSWzsjau2mYIe95n8/+01HnvkOL1P5s9hiE2zlDHZyzzziR/dnm55fMzsaASjCk6u
         84OzEjNhsO7eM41VpJcB0xOJiXI6lOIWBnNWhUh5bXud6aEjOLxjvCoTivATbGhlk+mf
         FUzB9EiMHtEoRpd6EHd42CsCZGU7MAwfX1xIYi1IKhrhKRcQNv4tRM9GPYOxKDen/mB+
         gZgreJWkZTANoBbbU0ek62VEjNMvsws/CAQi85UyK75gXIyB4srK/Rbn3ok7yVqad3UI
         sjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3qByAMCnQDNxzsVuIb+kpuBa+W1raXE0pzDv8GVb0uwDla3fdBPvIx+7mHfB682+sTNz9yUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHe+zyepOYcD2PDx815ohGy56H67FcQU3tTKXcfFa/fzvP8dV/
	bq42pzpFBHlLkAfsrab7kFwUTlpJ9QpB+rxfFOui1Wf7PNZ/Yr60FG3zWu6UYWjwer0=
X-Gm-Gg: AY/fxX4pc+CIslHvKRxCtUJJ0PIhQlmbt02QUId5NMOSY0y8XVqA+X3EYnmnvhR9rOf
	780BLHvGM9nBJKVaph2sWVi9okGJN5bftYnUkbTDBVCHybgYS85kyQ4WQnPQ8n9NQfzQbUAWo3S
	52I/2ZZTE/tdAgu57ZpPprP07zyRXaNA1aVUGJBl7QoGVVOpMq+P4t3LNDSK/WPhmDFAUNaliCr
	zdFKv0WpRoQnVDUWgZCn63sakNWqhaItQ0Jqe4frl0nsNSI6WufdaOINCQQXoUYn6gdY500mmW2
	+SmrxbBTstZlIQ6+avk9ID07T2mZ+W9O05NEJvsL3HXmd/2xwtYrtt/9HvHmWYexbRDi0GIm+ct
	TlfvKXKZeqSdMckLnFGTPPxlkebhm+XSZUHsWoQ2vgs4Nf72zUZQFGrjPC9yuTfYUc0nNHeaftd
	8MXTuzNK6GOJd+iXul
X-Received: by 2002:a05:600c:4f8a:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-4801e2f90camr128220315e9.6.1768800449052;
        Sun, 18 Jan 2026 21:27:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699980e5sm20818492f8f.41.2026.01.18.21.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 21:27:28 -0800 (PST)
Date: Mon, 19 Jan 2026 08:27:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH ipsec-next v2 4/4] xfrm: add XFRM_MSG_MIGRATE_STATE for
 single SA migration
Message-ID: <202601190605.ZVkgcUYl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951cb30ac3866c6075bc7359d0997dbffc3ce6da.1768679141.git.antony.antony@secunet.com>

Hi Antony,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antony-Antony/xfrm-remove-redundant-assignments/20260118-041031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/951cb30ac3866c6075bc7359d0997dbffc3ce6da.1768679141.git.antony.antony%40secunet.com
patch subject: [PATCH ipsec-next v2 4/4] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
config: hexagon-randconfig-r072-20260118 (https://download.01.org/0day-ci/archive/20260119/202601190605.ZVkgcUYl-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
smatch version: v0.5.0-8985-g2614ff1a

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202601190605.ZVkgcUYl-lkp@intel.com/

New smatch warnings:
net/xfrm/xfrm_user.c:3299 xfrm_do_migrate_state() warn: missing error code? 'err'

Old smatch warnings:
net/xfrm/xfrm_user.c:1024 xfrm_add_sa() warn: missing error code? 'err'
net/xfrm/xfrm_user.c:2248 xfrm_add_policy() warn: missing error code? 'err'
net/xfrm/xfrm_user.c:3018 xfrm_add_acquire() warn: missing error code 'err'

vim +/err +3299 net/xfrm/xfrm_user.c

d3019c1db87425 Antony Antony 2026-01-17  3240  static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
d3019c1db87425 Antony Antony 2026-01-17  3241  				 struct nlattr **attrs, struct netlink_ext_ack *extack)
d3019c1db87425 Antony Antony 2026-01-17  3242  {
d3019c1db87425 Antony Antony 2026-01-17  3243  	int err = -ESRCH;
d3019c1db87425 Antony Antony 2026-01-17  3244  	struct xfrm_state *x;
d3019c1db87425 Antony Antony 2026-01-17  3245  	struct net *net = sock_net(skb->sk);
d3019c1db87425 Antony Antony 2026-01-17  3246  	struct xfrm_encap_tmpl *encap = NULL;
d3019c1db87425 Antony Antony 2026-01-17  3247  	struct xfrm_user_offload *xuo = NULL;
d3019c1db87425 Antony Antony 2026-01-17  3248  	struct xfrm_migrate m = { .old_saddr.a4 = 0,};
d3019c1db87425 Antony Antony 2026-01-17  3249  	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
d3019c1db87425 Antony Antony 2026-01-17  3250  
d3019c1db87425 Antony Antony 2026-01-17  3251  	if (!um->id.spi) {
d3019c1db87425 Antony Antony 2026-01-17  3252  		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
d3019c1db87425 Antony Antony 2026-01-17  3253  		return -EINVAL;
d3019c1db87425 Antony Antony 2026-01-17  3254  	}
d3019c1db87425 Antony Antony 2026-01-17  3255  
d3019c1db87425 Antony Antony 2026-01-17  3256  	err = copy_from_user_migrate_state(&m, um);
d3019c1db87425 Antony Antony 2026-01-17  3257  	if (err)
d3019c1db87425 Antony Antony 2026-01-17  3258  		return err;
d3019c1db87425 Antony Antony 2026-01-17  3259  
d3019c1db87425 Antony Antony 2026-01-17  3260  	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
d3019c1db87425 Antony Antony 2026-01-17  3261  
d3019c1db87425 Antony Antony 2026-01-17  3262  	if (x) {
d3019c1db87425 Antony Antony 2026-01-17  3263  		struct xfrm_state *xc;
d3019c1db87425 Antony Antony 2026-01-17  3264  
d3019c1db87425 Antony Antony 2026-01-17  3265  		if (!x->dir) {
d3019c1db87425 Antony Antony 2026-01-17  3266  			NL_SET_ERR_MSG(extack, "State direction is invalid");
d3019c1db87425 Antony Antony 2026-01-17  3267  			err = -EINVAL;
d3019c1db87425 Antony Antony 2026-01-17  3268  			goto error;
d3019c1db87425 Antony Antony 2026-01-17  3269  		}
d3019c1db87425 Antony Antony 2026-01-17  3270  
d3019c1db87425 Antony Antony 2026-01-17  3271  		if (attrs[XFRMA_ENCAP]) {
d3019c1db87425 Antony Antony 2026-01-17  3272  			encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]),
d3019c1db87425 Antony Antony 2026-01-17  3273  					sizeof(*encap), GFP_KERNEL);
d3019c1db87425 Antony Antony 2026-01-17  3274  			if (!encap) {
d3019c1db87425 Antony Antony 2026-01-17  3275  				err = -ENOMEM;
d3019c1db87425 Antony Antony 2026-01-17  3276  				goto error;
d3019c1db87425 Antony Antony 2026-01-17  3277  			}
d3019c1db87425 Antony Antony 2026-01-17  3278  		}
d3019c1db87425 Antony Antony 2026-01-17  3279  		if (attrs[XFRMA_OFFLOAD_DEV]) {
d3019c1db87425 Antony Antony 2026-01-17  3280  			xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
d3019c1db87425 Antony Antony 2026-01-17  3281  				      sizeof(*xuo), GFP_KERNEL);
d3019c1db87425 Antony Antony 2026-01-17  3282  			if (!xuo) {
d3019c1db87425 Antony Antony 2026-01-17  3283  				err = -ENOMEM;
d3019c1db87425 Antony Antony 2026-01-17  3284  				goto error;
d3019c1db87425 Antony Antony 2026-01-17  3285  			}
d3019c1db87425 Antony Antony 2026-01-17  3286  		}
d3019c1db87425 Antony Antony 2026-01-17  3287  		xc = xfrm_state_migrate(x, &m, encap, net, xuo, extack);
d3019c1db87425 Antony Antony 2026-01-17  3288  		if (xc) {
d3019c1db87425 Antony Antony 2026-01-17  3289  			xfrm_state_delete(x);
d3019c1db87425 Antony Antony 2026-01-17  3290  			xfrm_send_migrate_state(um, encap, xuo);
d3019c1db87425 Antony Antony 2026-01-17  3291  			err = 0;
d3019c1db87425 Antony Antony 2026-01-17  3292  		} else {
d3019c1db87425 Antony Antony 2026-01-17  3293  			if (extack && !extack->_msg)
d3019c1db87425 Antony Antony 2026-01-17  3294  				NL_SET_ERR_MSG(extack, "State migration clone failed");
d3019c1db87425 Antony Antony 2026-01-17  3295  			err = -EINVAL;
d3019c1db87425 Antony Antony 2026-01-17  3296  		}
d3019c1db87425 Antony Antony 2026-01-17  3297  	} else {
d3019c1db87425 Antony Antony 2026-01-17  3298  		NL_SET_ERR_MSG(extack, "Can not find state");
d3019c1db87425 Antony Antony 2026-01-17 @3299  		return err;

s/err/-ESRCH/.  err is zero/success here.

d3019c1db87425 Antony Antony 2026-01-17  3300  	}
d3019c1db87425 Antony Antony 2026-01-17  3301  error:
d3019c1db87425 Antony Antony 2026-01-17  3302  	xfrm_state_put(x);
d3019c1db87425 Antony Antony 2026-01-17  3303  	kfree(encap);
d3019c1db87425 Antony Antony 2026-01-17  3304  	kfree(xuo);
d3019c1db87425 Antony Antony 2026-01-17  3305  	return err;
d3019c1db87425 Antony Antony 2026-01-17  3306  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


