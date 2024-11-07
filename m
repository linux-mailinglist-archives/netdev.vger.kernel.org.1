Return-Path: <netdev+bounces-142755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ED09C03D3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F1D28298D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923AB1F582B;
	Thu,  7 Nov 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9N3pgzM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542081F1303
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978645; cv=none; b=Ofa9bqk06RULKSdOemeisM4glyyxxQwJCd5j8Kn//NcwUjDuDROKdy3M5QzlXi4puWtJzl8s+PdlMQbKE8udvi0JcekSYhg2Bh/cmk3YFsxgzEdIyha6n6SZ2wGM894UbPfo5hp/qOXpqpRI5I62YlRND4hY6uIgm08glLWjkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978645; c=relaxed/simple;
	bh=2GsD4FM0iXQ9ZQgHNEDuqIySpEr5mZ0z+3AwGF26ZN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZUE4Qt4blIaJ57+OYhnduBIdlULcDc9pfyfiZ5+G12ZsxPR8r1CNvtI8bk4bV1h3zU3qFrQJxOXXGIux2K7hae5l5+O+dlz0TXf798p0HUfGuXhnwHQV0kvzwYYVN8ycEn0IBq/jnRQ1iPeFNqoeBV+g5dxcILjesP+KnIwwF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q9N3pgzM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431481433bdso7308385e9.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 03:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730978642; x=1731583442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YI7D6pYZ3MPTsBn2X/3v3EZ17avH4kCX3waBbepnJPk=;
        b=q9N3pgzMl+08HrP2oztqOAiyP+GdciMnoXp7lczrBtg7CJgL/Qp4UndsP/zgWaPcB8
         BNUUNu69hWMITP8u0Y8hQRq0gZUHuPzHMEUYQfjcvws6RoxgO8/mFSf/vAjhNptjJWBR
         nz0DEfjOk7lwOq/xTfobA/u2gKqkS6Z0nPlU2KpJuiwlLOLtkRtdLzDsoXSobm2aK0V7
         XrUd3fbDDF0lCXfUkWvBz40BrqP2+zlbK5o15C5H+u2luwNDV6BiOD+QEPorvNlBCtj3
         t0XFYuTWdFEjhoPb2DdXJ4kyTNsIn5g4mJsJ6q/e4WnqJFoIkgTuEyM7yMXove6AIfG+
         VRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978642; x=1731583442;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YI7D6pYZ3MPTsBn2X/3v3EZ17avH4kCX3waBbepnJPk=;
        b=JrKlNyM5D4nerjLgX/6WEIh2NZNPWmojtMj/vkePq7cUw5ZfnedDvu9ueoJzpcKT86
         OY6V4ZPCZGhPkfD6tocpl3oEueMfR3w+MyKInj2G1lBGqhiFCN+pDzHLyxMsphYD2ZyX
         WML3MnNoUUghv46o8Ip4WQ5HFGvSIhL5iXzAzD3CUgm++JOS0n+33KitbTf1wQfOhAFG
         10lBK2Xx/SGWpNO6SxYgUjJ6Hi4Y9GInLyqi9GoBkHKaZ2gkcQ3xsYdOWjDm6RQzRGSU
         R8SUn3W3pMi4IMWsnEafr6sQLIjBUJrRzZyRP8pGVmrASi9wJl7LTUjqLKnB+lBhYOLP
         U/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWITJFbLBZOZq5rOziKMkyonc0QjMSkw9flN950OPDJsyLzEDrd0e1ow/c1aaJQSA6qb8VcKXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBs/LIEv3We1St9FKxXz9usbePcC5/sKXSLqU8WZrRDVocuN4
	o+z2aBwSPFhhtDKiPtsSeMPzbmPmoG5es+E97CMuTOISeLCziduN8/9NVspRFKw=
X-Google-Smtp-Source: AGHT+IFBpowv+bSWYC6j4VAMIQVR8u8yrWok5kaYTtpzwW5CbfWm5qUgpBko8chZf+PgyCz8MppP4g==
X-Received: by 2002:a05:600c:348e:b0:42c:b74c:d8c3 with SMTP id 5b1f17b1804b1-432b30a15femr7963805e9.32.1730978641744;
        Thu, 07 Nov 2024 03:24:01 -0800 (PST)
Received: from localhost ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e56sm59261885e9.2.2024.11.07.03.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:24:01 -0800 (PST)
Date: Thu, 7 Nov 2024 14:24:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 6/9] vhost: Add kthread support in function
 vhost_worker_destroy()
Message-ID: <ed23b4b1-1aa8-414a-856c-15e072541dee@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105072642.898710-7-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-parameter-to-allow-user-select-kthread/20241105-153254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20241105072642.898710-7-lulu%40redhat.com
patch subject: [PATCH v3 6/9] vhost: Add kthread support in function vhost_worker_destroy()
config: x86_64-randconfig-161-20241106 (https://download.01.org/0day-ci/archive/20241107/202411071945.ExiEHgoX-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411071945.ExiEHgoX-lkp@intel.com/

New smatch warnings:
drivers/vhost/vhost.c:721 vhost_worker_destroy() error: we previously assumed 'worker' could be null (see line 721)

Old smatch warnings:
drivers/vhost/vhost.c:241 vhost_worker_queue() error: we previously assumed 'worker' could be null (see line 241)

vim +/worker +721 drivers/vhost/vhost.c

1cdaafa1b8b4ef Mike Christie 2023-06-26  718  static void vhost_worker_destroy(struct vhost_dev *dev,
1cdaafa1b8b4ef Mike Christie 2023-06-26  719  				 struct vhost_worker *worker)
1a5f8090c6de99 Mike Christie 2023-03-10  720  {
e4dec2edddbd54 Cindy Lu      2024-11-05 @721  	if (!worker && !worker->fn)

Same thing.  && vs ||.

1a5f8090c6de99 Mike Christie 2023-03-10  722  		return;
1a5f8090c6de99 Mike Christie 2023-03-10  723  
1cdaafa1b8b4ef Mike Christie 2023-06-26  724  	WARN_ON(!llist_empty(&worker->work_list));
1cdaafa1b8b4ef Mike Christie 2023-06-26  725  	xa_erase(&dev->worker_xa, worker->id);
e4dec2edddbd54 Cindy Lu      2024-11-05  726  	worker->fn->stop(dev->inherit_owner ? (void *)worker->vtsk :
e4dec2edddbd54 Cindy Lu      2024-11-05  727  					      (void *)worker->task);
e4dec2edddbd54 Cindy Lu      2024-11-05  728  	kfree(worker->fn);
1cdaafa1b8b4ef Mike Christie 2023-06-26  729  	kfree(worker);
1cdaafa1b8b4ef Mike Christie 2023-06-26  730  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


