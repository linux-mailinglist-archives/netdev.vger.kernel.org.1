Return-Path: <netdev+bounces-142739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9614F9C0289
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB808B22649
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F11EF94F;
	Thu,  7 Nov 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPmzia1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE561EF92A
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975943; cv=none; b=jBV0Whvws0qN4K+lPVOb6lAM6r4ookOUyJ4AykL63WPREqpzLQmyLAMvN0KCVHBX4TIdRCjSPyIiGqqyCPr8Qm3dvOGzEuNUbl7jmgH9QhART3nTf/5Yt1UKmETLTaIBJdDPoTayY3H9amJGzLRpFIHIsDKZG0rQfCZb98VeEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975943; c=relaxed/simple;
	bh=lJMdumzOaAkNiNGo6zimgII+G/snXw0TvT8mnuAxvk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V37PQgUHDFgIZG/n5zSzSp0g1xWcYKWqd3UyYYuWjR4lzRjmq5AClyDFnJKtZ5UqHYAwMpDrUaNkXEEI4U8Xt11DIof8CDnJpNjpWffGxu15phaX0vVTt3OyghNvKWQKzjcp9wbTCaG3MjMGboJeHxBEacVHVzZYi9NUTUHUC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HPmzia1j; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso656539e87.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730975939; x=1731580739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JH98gemjJTaUPfUlmHX1OFqIrt84z9GbUn53JGi6HVE=;
        b=HPmzia1jgHLczLSaASNfJb3DDrmALDZaZB4r0L+3GbgI2yjYd62B1c3E+R+3vah9XN
         UUo4ui/DojkXZ40D5tuNdaSMj3D2y00gyK+z15aGCjl8BfUZAkKlAGVBR5339+jd+MCp
         MZn68wXXbYSp2BbDzRuPhXZEgXToU82w2575m70DucKVdcXFtqImLW2K2/mqbS05oskq
         PtNvJvyjpQf+OohLOnRiALMs4G4yYJoAS3G3qCq/GbiyVevUWC5DsrO2sPP00siFCpXg
         EUXVI4Vj5j961mcH8dapt7ESiKnH/YiyBJ1aE8gQB37XEdq3TaLD5Z0HfR6e3hX/Qf9d
         C4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975939; x=1731580739;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JH98gemjJTaUPfUlmHX1OFqIrt84z9GbUn53JGi6HVE=;
        b=VqxDh3zbaM4BPa2HTMl0VswVhHbGJo1XJECEgA6YZcM9MSarWdiOwBlDZn482JnAI8
         KmkNIvMQ1ysV5e4ALPqnOFpX5wDxKB5Muxkm9dCerjrddtQPfyOs6oUKr8313dXcV10U
         jOsVhZEd36sFYSYOzyy956AqWyuoTDdG0vA8YNTXnse8qiceFgP+Bc8TOyMGf6moleXb
         uNQaYfqkyoADHFU57IHaAQICK/JbhIZl65zXbsHX+sH0/YhElP7PfGPDWn7/bingj/rD
         +5eYift5o1yr2ypHptGkRpRsDJWbxZyD2VMNmbkPF/x0HGn8pPkap6KskbrTaJLFgk5H
         vLTA==
X-Forwarded-Encrypted: i=1; AJvYcCW6KMoFfGgW7Mo/WZ2zplPDtpxQyg+yfO9hUsvNte8Y3cSDUq6LOb+J0MfWbETJR5i2dv9BS/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHYsySBU5Sq9goCsqVyaymeitd8tREQqvrcpAWfwtyc0Rq7bK
	boE4vVMyoKacOlVL8FIZMdDC5U1qkUcbIsssNhWFLf1FgIqMfSx5GVoPpn2+Jao=
X-Google-Smtp-Source: AGHT+IGso3elzbiaDw8i00w0KjqQ5KFuPi/CIIkjajhtEha2FDZ5ZKCSRCL4vAbs4WzAVjhcuNJGcQ==
X-Received: by 2002:a05:6512:158f:b0:539:8a7d:9fbf with SMTP id 2adb3069b0e04-53d8409e39bmr376911e87.46.1730975939310;
        Thu, 07 Nov 2024 02:38:59 -0800 (PST)
Received: from localhost ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a2ccsm58130555e9.31.2024.11.07.02.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:38:58 -0800 (PST)
Date: Thu, 7 Nov 2024 13:38:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 5/9] vhost: Add kthread support in function
 vhost_worker_queue()
Message-ID: <247f4cd6-5653-4eef-9436-5699b44c4b82@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105072642.898710-6-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-parameter-to-allow-user-select-kthread/20241105-153254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20241105072642.898710-6-lulu%40redhat.com
patch subject: [PATCH v3 5/9] vhost: Add kthread support in function vhost_worker_queue()
config: x86_64-randconfig-161-20241106 (https://download.01.org/0day-ci/archive/20241107/202411071251.tQLG8K6C-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411071251.tQLG8K6C-lkp@intel.com/

New smatch warnings:
drivers/vhost/vhost.c:241 vhost_worker_queue() error: we previously assumed 'worker' could be null (see line 241)

Old smatch warnings:
drivers/vhost/vhost.c:311 vhost_dev_flush() warn: iterator 'i' not incremented
drivers/vhost/vhost.c:678 vhost_attach_cgroups() error: uninitialized symbol 'ret'.
drivers/vhost/vhost.c:673 vhost_attach_cgroups() warn: iterator 'i' not incremented

vim +/worker +241 drivers/vhost/vhost.c

228a27cf78afc63 Mike Christie      2023-06-26  238  static void vhost_worker_queue(struct vhost_worker *worker,
0921dddcb589803 Mike Christie      2023-06-26  239  			       struct vhost_work *work)
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  240  {
001268765c12bbf Cindy Lu           2024-11-05 @241  	if (!worker && !worker->fn)

|| was intended instead of &&.

001268765c12bbf Cindy Lu           2024-11-05  242  		return;
001268765c12bbf Cindy Lu           2024-11-05  243  
04b96e5528ca971 Jason Wang         2016-04-25  244  	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
04b96e5528ca971 Jason Wang         2016-04-25  245  		/* We can only add the work to the list after we're
04b96e5528ca971 Jason Wang         2016-04-25  246  		 * sure it was not in the list.
635abf01918157e Peng Tao           2016-12-07  247  		 * test_and_set_bit() implies a memory barrier.
04b96e5528ca971 Jason Wang         2016-04-25  248  		 */
0921dddcb589803 Mike Christie      2023-06-26  249  		llist_add(&work->node, &worker->work_list);
001268765c12bbf Cindy Lu           2024-11-05  250  		worker->fn->wakeup(worker->dev->inherit_owner ?
001268765c12bbf Cindy Lu           2024-11-05  251  					   (void *)worker->vtsk :
001268765c12bbf Cindy Lu           2024-11-05  252  					   (void *)worker->task);
3a4d5c94e959359 Michael S. Tsirkin 2010-01-14  253  	}
ac9fde2474d04bd Qin Chuanyu        2013-06-07  254  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


