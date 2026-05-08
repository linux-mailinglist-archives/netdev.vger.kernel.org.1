Return-Path: <netdev+bounces-285667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE/zB5l//WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:15:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9678C4F2513
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7AA830A8E87
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 06:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33358377EC1;
	Fri,  8 May 2026 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRUlesgA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U46N8jUI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2E349B15
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220572; cv=none; b=Le7yRR6LxcjDG044FiKyPX644qlGj7DN9kZTXxYR0LbOZqMRNQnoC6Mw97mH7zg0Nt0Zd4Sn18WxAs7/C/Md5eZ5RXjzeTZZez4FEiM9hOiuRstTBpEcNTbr7f+RyXaaVQS+PAg83Bgmbnwn/0jT9kWJTd67pPMj+TxoY2AsNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220572; c=relaxed/simple;
	bh=K5xtDAuyrMvBSiVkIb+d9ftD5LvUthW6cMj49rrgJho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwdBIfUZq4GHdbwSFJ0e9ZOXqo0gZnCjx0GlfGv10BAP9yD9uBNUCUN3L/kJtqoNz2PbKaANTHvAcCMQzJNPTvaTK84Sav/Hcq1yQ5AEL6MIv2Neh1DzN+gPuyreJJ7Hv8A3c+1+bAZ2npEdEBECBbIsaWirofDNdlO66nIWJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRUlesgA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U46N8jUI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778220558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GeECdFhE1e2rNXT3Sj2OPEv03eYYs8feiSdikU8nZxQ=;
	b=hRUlesgAN+BcZ4rQpKV3f8qsSalfdk3LALPD7oqWo80omQlfKU7+ISMeVdXGev8ixIFGLx
	iPdkzPYTLcgRyfyAuxpSu1rYU2LuPhWJ9MaftCb9JteAHLTL0sgT3CVffLK9SzjzJZyowO
	4D1tsk+Z47bk4VFnNoHyZdR1E5HiPdY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-SR0I9c3rNs-_7c77c5GCMQ-1; Fri, 08 May 2026 02:09:16 -0400
X-MC-Unique: SR0I9c3rNs-_7c77c5GCMQ-1
X-Mimecast-MFC-AGG-ID: SR0I9c3rNs-_7c77c5GCMQ_1778220556
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so7779585e9.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778220555; x=1778825355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeECdFhE1e2rNXT3Sj2OPEv03eYYs8feiSdikU8nZxQ=;
        b=U46N8jUIL2Cck8nZyo4+AqV7u/mUEf2njpwAqTYFZ1yGb+ea6RmTsFh9Ds+f7LTcXB
         VQ0efQRGRUFfvzS57B9FTcTx/0f6BgOA7yUiEu6obEF2s+EWKvOKuT6lsC7N0d0oMnqx
         0OcLArOvbRqE4um+7QW/HrY1AEIYC2Br8CkHqChEJT4RvjnlYaDTZqyXy3QAQA46lp7C
         6pdYn5DmVzZn8ETssgO2XrVkgaoZQW0wJfEeB5vviu+lHT/TOPUMnzI/9evE+OA+Lbml
         kUj5qjK/k8QEoq02oS5i/kJSJ76kjO9LZr4H0PE8n7lKT2ZTjjU3897k6VI97HTAEwIt
         8TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220555; x=1778825355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeECdFhE1e2rNXT3Sj2OPEv03eYYs8feiSdikU8nZxQ=;
        b=E+MWkNluO2PQ45Ly9xmV7T/OAOlMmGjHm44xW9lD4kqY3SVlnPnH/3jKae2lBkGSXd
         xqmO3XOblYcWUuHLZRRbGUGU2bgc9oi5Oo2ts7S0xiHbxCVDRs3ZID6Jg1/cWDH4ijW1
         rYeZCQwLtIzMUEehChmEXoEUpjwlln1uUReMFQQ+tvygHqEkaFQjdddOJAN02ItB0/1q
         7KHwePxGXkccFzw/zFtfcG5yxtVJOi/mPFUZ/VAGSF3hFc8+OmDbBObdCe+HW56dHm9T
         kHcOSJe/hocCdIIbRPZQzcWuK7/bEBmEmxbG+/BV3LuAjM1EpRBhucw1BUJb3yhoR/aL
         ev7w==
X-Forwarded-Encrypted: i=1; AFNElJ/IG27t/y6P7Omwws5V4QljnN2zz0mPt3auAwiHbEYU6ebHm3ZCmu4z5dy1eArsVahlbxS/NTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8nI0Vs1qol/gTtozB4EUDTC4l7sfA7eJWWDbuqsgpvDXedSW
	LLy4UCarYIO2JIrXqGFzZMxwDRTThkbg5vluz2nAFGmGP0c9uuFaKGru52rYl4rKHOxZTNHZ7nu
	fkNiMXVrxrqxOvcTXoj3x2Ym/nnP4bAofVPbX3kiT1tD8tRnS3ilSBxnMmg==
X-Gm-Gg: AeBDiesztY9JSoREx3TvmsvCr8FCRyR5+lgYNUnebuhEYGlrw2c/9D2ahoPndQUF8lI
	HwL/AlGuZQA5LxyFh+uTr/mmFcqusgbWLQTnbMomKQBiPaAOOp44Zy6m7N+oCtouiQqXUNfZD++
	w3uoyvLq9363MiBXF3UbiQPiLiDO8GokOxtl/IpmWI2QKYiKrvLH12Znk9W4svGPqTgCgh5ooXP
	W1JLRcZyTmll+/lOV63SQ+eyjDpY71W661SwXKNJsulLcmt1OJCEVChUMfAeXj9T0t5idks4725
	D1CrIigP+Jktb6S1MJYUBLnt3lufLEtOG5ZIDc0bAgAP1nyt2vK+vjpYovbMkTY9ySbkFGlRBp7
	Fe+ZTvREV3ot2oij1GIYNgdRJviEC98IzJe0t7BId
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48e5dfd6a6amr83500555e9.6.1778220555302;
        Thu, 07 May 2026 23:09:15 -0700 (PDT)
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48e5dfd6a6amr83499615e9.6.1778220554672;
        Thu, 07 May 2026 23:09:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f45d72sm13235625e9.9.2026.05.07.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:09:14 -0700 (PDT)
Date: Fri, 8 May 2026 02:09:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [mst-vhost:balloon 6/30] Warning: mm/mempolicy.c:2444 function
 parameter 'user_addr' not described in '__alloc_pages_mpol'
Message-ID: <20260508020425-mutt-send-email-mst@kernel.org>
References: <202605080515.6jRN5wN7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605080515.6jRN5wN7-lkp@intel.com>
X-Rspamd-Queue-Id: 9678C4F2513
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285667-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 05:26:30AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
> head:   9f56ee36fbf6a6d336dc6a9eaeb4f8a67cb42a31
> commit: c4289f5a4e563611a468b4b5379025a4aa4a7c12 [6/30] mm: thread user_addr through page allocator for cache-friendly zeroing
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260508/202605080515.6jRN5wN7-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605080515.6jRN5wN7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605080515.6jRN5wN7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> Warning: mm/mempolicy.c:2444 function parameter 'user_addr' not described in '__alloc_pages_mpol'
> >> Warning: mm/mempolicy.c:2444 expecting prototype for alloc_pages_mpol(). Prototype was for __alloc_pages_mpol() instead
>    Warning: mm/mempolicy.c:2547 expecting prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages() instead
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


kerneldoc messed up with a rebase. will fix in v6.


