Return-Path: <netdev+bounces-80375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5B87E8DF
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3171F23886
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE00D37159;
	Mon, 18 Mar 2024 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PH2LIwZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9EC364C6
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762403; cv=none; b=mdw6rq/ozpSS609GFtrA5GDu7VPNPgRrCoTFIbPs4PXDhAfWxTYJ9fV/u/TPNHUZqHC1un2ixxSIHqS5X+aFNw0ZeokyFJWCATcXCkUSoWmEY32Dogz24J3RM93kzR1RvBSWbSkcVefj0ITigXcPaT/CrZaLcXn21KJQDyyTxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762403; c=relaxed/simple;
	bh=R7ovyQCXq4JqE74DA5qi0Whd11d4dcJZI4jtH31aC14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od/ZWdtvYpzRRNUbVzpfEEfXVuXD8VNO/6YLKbVxhYrjbVJX5UBBoWqG+eXukxeB6F6TwDTJTkXrwHtyfZK2t85OYE9UCXioUNDitMiYxlYUCp4FKUjmTTJ/Kzx9TGaDdszhktmjl7X208dBRMN9KeuIQMwn3D40vieraORmOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PH2LIwZ0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ec7e38b84so2512986f8f.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710762400; x=1711367200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8A409aN+fBcQklFPlBADZ9jKHPDQaUy+bgX3gYOHe0=;
        b=PH2LIwZ0ZBSpySb9r+xmN3bRjaTA3cEVg2tHbWJrj7TWRXOxp446NgUSzsnmfNHcUl
         oDZCoEBC94XcQ/Lc5TvuKHuF6TPenQ5W6/YBJg0WQEX6VDla7GzjxugujQ9T8VUdoxth
         D+RdgKoFCnuoz6VI2eHU5P9bzTNP8USV1VrGD/FoHdThUdwZEbkyeEoQjFoIsc7vw9kF
         qr/icSxbfzxe/gAks71xecwjqwtQNMxY+eZoLJawdxvvCNnqXFl6C3HbPI3MhkFBLRex
         ta+vQRJalbMm8zL68edHyJlm0K9JoU0i0T7IKzM9ESEwW/sxwnBh2BSXBz2UfTFqkoL3
         RPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710762400; x=1711367200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8A409aN+fBcQklFPlBADZ9jKHPDQaUy+bgX3gYOHe0=;
        b=OsRJat6NjMqnr0yuzcIt/4l40lGJcp7CPrT7My4TDvagLIZffU51G09JiD2YaAlbkF
         /ONeNECTTOs6g60L0c5tdKTV9FZjuFL4tUF1koqVt6xrSYs6kHFp5bl3YYCPofcyoq+i
         NsrsFF6yz/hvxGRf21EEUBXfPgcKAujewBFl1SIpOLzAXYM5TbOP0Rw63DlGD/5tDTLt
         yLHU6WkrVAWMVP8afNPTZQuz6j/RZDuaFtgFx0XStHK32iDKhpeQrFl+3pdQiSoWk4Cg
         u8pznkEHEN4P26pTMywNRdAa0+vCJwJlUmN2CkU9lGhMgJiJNdkd47IqrFxqR/q0kkfN
         5Hvw==
X-Forwarded-Encrypted: i=1; AJvYcCUfm0xnVBdJS9NKy08cKstBh3mUdAUpltxzd/lB15DsE4o3NObpGoWc5TrXcLmNVP13Lbf1IRhhlZ7UFM+PgZ+B6do3oXCF
X-Gm-Message-State: AOJu0YyXIhL5i6QIX2qIX0K7lhKZNLhlZ4dtQOBENGgKVZ69A5XaQ77W
	QKQlb2/oPFI5q2PNMCOCIQeINByoXdgomUrOnq/oXp2KJ5WuGYs5ayWcXhGR7y4=
X-Google-Smtp-Source: AGHT+IFudxVTqDsTL3NiAJF7PgeYJ6xPOb5BxUJ2VTjXU0sS/60+Zkk4r7qaMCwKc3/zN+yqXWZBVw==
X-Received: by 2002:a05:6000:246:b0:33e:78c1:acfa with SMTP id m6-20020a056000024600b0033e78c1acfamr8007701wrz.1.1710762399966;
        Mon, 18 Mar 2024 04:46:39 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ck19-20020a5d5e93000000b0033ec81ec4aesm3338938wrb.78.2024.03.18.04.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:46:39 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:46:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Thinh Tran <thinhtr@linux.ibm.com>
Cc: jacob.e.keller@intel.com, kuba@kernel.org, netdev@vger.kernel.org,
	VENKATA.SAI.DUGGI@ibm.com, abdhalee@in.ibm.com, aelior@marvell.com,
	davem@davemloft.net, drc@linux.vnet.ibm.com, edumazet@google.com,
	manishc@marvell.com, pabeni@redhat.com, simon.horman@corigine.com,
	skalluru@marvell.com
Subject: Re: [PATCH v11] net/bnx2x: Prevent access to a freed page in
 page_pool
Message-ID: <ZfgpnMtB0nDbMVJa@nanopsycho>
References: <20240315205535.1321-1-thinhtr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315205535.1321-1-thinhtr@linux.ibm.com>

Fri, Mar 15, 2024 at 09:55:35PM CET, thinhtr@linux.ibm.com wrote:
>Fix race condition leading to system crash during EEH error handling
>
>During EEH error recovery, the bnx2x driver's transmit timeout logic
>could cause a race condition when handling reset tasks. The
>bnx2x_tx_timeout() schedules reset tasks via bnx2x_sp_rtnl_task(),
>which ultimately leads to bnx2x_nic_unload(). In bnx2x_nic_unload()
>SGEs are freed using bnx2x_free_rx_sge_range(). However, this could
>overlap with the EEH driver's attempt to reset the device using
>bnx2x_io_slot_reset(), which also tries to free SGEs. This race 
>condition can result in system crashes due to accessing freed memory
>locations in bnx2x_free_rx_sge()
>
>799  static inline void bnx2x_free_rx_sge(struct bnx2x *bp,
>800				struct bnx2x_fastpath *fp, u16 index)
>801  {
>802	struct sw_rx_page *sw_buf = &fp->rx_page_ring[index];
>803     struct page *page = sw_buf->page;
>....
>where sw_buf was set to NULL after the call to dma_unmap_page() 
>by the preceding thread.
>
>
>[  793.003930] EEH: Beginning: 'slot_reset'
>[  793.003937] PCI 0011:01:00.0#10000: EEH: Invoking bnx2x->slot_reset()
>[  793.003939] bnx2x: [bnx2x_io_slot_reset:14228(eth1)]IO slot reset initializing...
>[  793.004037] bnx2x 0011:01:00.0: enabling device (0140 -> 0142)
>[  793.008839] bnx2x: [bnx2x_io_slot_reset:14244(eth1)]IO slot reset --> driver unload
>[  793.122134] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
>[  793.122143] BUG: Kernel NULL pointer dereference on read at 0x00000000
>[  793.122147] Faulting instruction address: 0xc0080000025065fc
>[  793.122152] Oops: Kernel access of bad area, sig: 11 [#1]
>.....
>[  793.122315] Call Trace:
>[  793.122318] [c000000003c67a20] [c00800000250658c] bnx2x_io_slot_reset+0x204/0x610 [bnx2x] (unreliable)
>[  793.122331] [c000000003c67af0] [c0000000000518a8] eeh_report_reset+0xb8/0xf0
>[  793.122338] [c000000003c67b60] [c000000000052130] eeh_pe_report+0x180/0x550
>[  793.122342] [c000000003c67c70] [c00000000005318c] eeh_handle_normal_event+0x84c/0xa60
>[  793.122347] [c000000003c67d50] [c000000000053a84] eeh_event_handler+0xf4/0x170
>[  793.122352] [c000000003c67da0] [c000000000194c58] kthread+0x1c8/0x1d0
>[  793.122356] [c000000003c67e10] [c00000000000cf64] ret_from_kernel_thread+0x5c/0x64
>
>To solve this issue, we need to verify page pool allocations before
>freeing.
>
>Fixes: 4cace675d687 ("bnx2x: Alloc 4k fragment for each rx ring buffer element")
>
>Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

