Return-Path: <netdev+bounces-76128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7F086C712
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB161F284E3
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5579DA7;
	Thu, 29 Feb 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S98YRIFu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F8651A1
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203046; cv=none; b=kpoR5ztSFuNSqbtGYOrcaso8+ThhTZU6gdZVk7C5OH0yXMUO8bi1mLnz8ozD/DF+iNh32JL/095XeZjHsFR+rwrYgmOIvWcxMQyfXQPuxb13/INeNMeRBz4s0VzXC+jkmj+FwaZVFhNSWmym+7IZYFMgN3xYylcGZDiUXsIVW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203046; c=relaxed/simple;
	bh=1uP6ppIuzb6JcAiltD8pD+1RusOOirH+ZmPuCJbJl0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE2Ea9mDz0FX3eLbP09CUrpOiuI7qo5sof84/KQ+Ik7biwnd86MebUHXhM2gznOhp03gqJN2agJF3dejUvgWJRwMlUpg+DGgR9BRQkAOE1yhbNvklPwttTspwJVr8cv4XZCZYw6RwuMLHFe9G46KkvNXDyYQC7DAgggy7PT6gb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S98YRIFu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709203045; x=1740739045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1uP6ppIuzb6JcAiltD8pD+1RusOOirH+ZmPuCJbJl0E=;
  b=S98YRIFuvmcjFC2BibaufbmWQ21h7/NulXsZz2A7QZuu0nmlhA5jnOcK
   DfIWuhcXedvanqs/e3mFaUyFDQqoBmeCou7PZBhMyimQdt9X1qTRVaVTp
   FrGaDuGVGvZ6Z7Pgh90oFE6Y9B3drrY2HTBKIcSzW5tdtZMqi0peYJ/gH
   pbJZjHv0gsOMv7uySvgCIzjKP9HUfHspd16L2v5MeYUMbXnr8N1+0d844
   l5n9+GlVubYbiVcx0uXQ1JGGoRzQ0WNrpG19Wp2aWk56xm/mEMlqxoQ+L
   Y0FrT0gqmeRNvAINdHcGqzRAUTQRDb89ny2Ew2+MItcnLdfPlRPQbeD4E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3828185"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3828185"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:37:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="45290512"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 29 Feb 2024 02:37:22 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfdmx-000Crr-0Y;
	Thu, 29 Feb 2024 10:37:19 +0000
Date: Thu, 29 Feb 2024 18:35:17 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 3/6] virtio_net: support device stats
Message-ID: <202402291808.cmzZAiYX-lkp@intel.com>
References: <20240227080303.63894-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-4-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-introduce-device-stats-feature-and-structures/20240227-161123
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240227080303.63894-4-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net-next v3 3/6] virtio_net: support device stats
config: x86_64-randconfig-121-20240229 (https://download.01.org/0day-ci/archive/20240229/202402291808.cmzZAiYX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240229/202402291808.cmzZAiYX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402291808.cmzZAiYX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/virtio_net.c:3571:57: sparse: sparse: cast to restricted __le64

vim +3571 drivers/net/virtio_net.c

  3466	
  3467	static int virtnet_get_hw_stats(struct virtnet_info *vi,
  3468					struct virtnet_stats_ctx *ctx)
  3469	{
  3470		struct virtio_net_ctrl_queue_stats *req;
  3471		struct virtio_net_stats_reply_hdr *hdr;
  3472		struct scatterlist sgs_in, sgs_out;
  3473		u32 num_rx, num_tx, num_cq, offset;
  3474		int qnum, i, j,  qid, res_size;
  3475		struct virtnet_stats_map *m;
  3476		void *reply, *p;
  3477		u64 bitmap;
  3478		int ok;
  3479		u64 *v;
  3480	
  3481		if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
  3482			return 0;
  3483	
  3484		qnum = 0;
  3485		if (ctx->bitmap_cq)
  3486			qnum += 1;
  3487	
  3488		if (ctx->bitmap_rx)
  3489			qnum += vi->curr_queue_pairs;
  3490	
  3491		if (ctx->bitmap_tx)
  3492			qnum += vi->curr_queue_pairs;
  3493	
  3494		req = kcalloc(qnum, sizeof(*req), GFP_KERNEL);
  3495		if (!req)
  3496			return -ENOMEM;
  3497	
  3498		res_size = (ctx->size_rx + ctx->size_tx) * vi->curr_queue_pairs + ctx->size_cq;
  3499		reply = kmalloc(res_size, GFP_KERNEL);
  3500		if (!reply) {
  3501			kfree(req);
  3502			return -ENOMEM;
  3503		}
  3504	
  3505		j = 0;
  3506		for (i = 0; i < vi->curr_queue_pairs; ++i) {
  3507			if (ctx->bitmap_rx) {
  3508				req->stats[j].vq_index = cpu_to_le16(i * 2);
  3509				req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_rx);
  3510				++j;
  3511			}
  3512	
  3513			if (ctx->bitmap_tx) {
  3514				req->stats[j].vq_index = cpu_to_le16(i * 2 + 1);
  3515				req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_tx);
  3516				++j;
  3517			}
  3518		}
  3519	
  3520		if (ctx->size_cq) {
  3521			req->stats[j].vq_index = cpu_to_le16(vi->max_queue_pairs * 2);
  3522			req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_cq);
  3523			++j;
  3524		}
  3525	
  3526		sg_init_one(&sgs_out, req, sizeof(*req) * j);
  3527		sg_init_one(&sgs_in, reply, res_size);
  3528	
  3529		ok = virtnet_send_command(vi, VIRTIO_NET_CTRL_STATS,
  3530					  VIRTIO_NET_CTRL_STATS_GET,
  3531					  &sgs_out, &sgs_in);
  3532		kfree(req);
  3533	
  3534		if (!ok) {
  3535			kfree(reply);
  3536			return ok;
  3537		}
  3538	
  3539		num_rx = VIRTNET_RQ_STATS_LEN + ctx->num_rx;
  3540		num_tx = VIRTNET_SQ_STATS_LEN + ctx->num_tx;
  3541		num_cq = ctx->num_tx;
  3542	
  3543		for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
  3544			hdr = p;
  3545	
  3546			qid = le16_to_cpu(hdr->vq_index);
  3547	
  3548			if (qid == vi->max_queue_pairs * 2) {
  3549				offset = 0;
  3550				bitmap = ctx->bitmap_cq;
  3551			} else if (qid % 2) {
  3552				offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
  3553				offset += VIRTNET_SQ_STATS_LEN;
  3554				bitmap = ctx->bitmap_tx;
  3555			} else {
  3556				offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
  3557				bitmap = ctx->bitmap_rx;
  3558			}
  3559	
  3560			for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
  3561				m = &virtio_net_stats_map[i];
  3562	
  3563				if (m->stat_type & bitmap)
  3564					offset += m->num;
  3565	
  3566				if (hdr->type != m->reply_type)
  3567					continue;
  3568	
  3569				for (j = 0; j < m->num; ++j) {
  3570					v = p + m->desc[j].offset;
> 3571					ctx->data[offset + j] = le64_to_cpu(*v);
  3572				}
  3573	
  3574				break;
  3575			}
  3576		}
  3577	
  3578		kfree(reply);
  3579		return 0;
  3580	}
  3581	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

