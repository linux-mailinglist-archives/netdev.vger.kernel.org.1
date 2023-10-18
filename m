Return-Path: <netdev+bounces-42339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F8A7CE5C1
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45453B20EA3
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C34E3FE38;
	Wed, 18 Oct 2023 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRploEu5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E0154AC
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F4AC433C8;
	Wed, 18 Oct 2023 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697652033;
	bh=fwBe8jxgE+4u2AB8YE8yDH3Vb62bVELd+j7oqk5Rn4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GRploEu5vVGFSUtxMPZlDvYI8uwkxN8TXTL7FTK2BH7RYIJP/SbXnThNur53RqICi
	 BbyvFT7Vu/7JLmlTIcwQImHqyXgm0lsQt1Hw4Q1yRHSZvWMbBthgzaigI/aiJ4zvJB
	 6tXPEmAvjzNI5hR8SN3w8G+zf9S/Hm18QUcwsCEl5VEhjjIPRMUZ2y7W78Tojnksgk
	 U93LqcGSiE7mPcEnr2cV40SE8BHyU/uDmFE29TTTEj84eMtRqJjPSSNk1s30NjIM5S
	 xkeFN1jZ+1KudK4rUOOOEAOGlQIAttXMmjfCU890omzq4SHZBYFuYhxNeCrwbxv7n2
	 oIppS4TtQ1xwg==
Date: Wed, 18 Oct 2023 11:00:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net/smc: correct the reason code in
 smc_listen_find_device when fallback
Message-ID: <20231018110032.13322b8e@kernel.org>
In-Reply-To: <20231017124234.99574-3-guangguan.wang@linux.alibaba.com>
References: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
	<20231017124234.99574-3-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 20:42:34 +0800 Guangguan Wang wrote:
> The ini->rc is used to store the last error happened when finding usable
> ism or rdma device in smc_listen_find_device, and is set by calling smc_
> find_device_store_rc. Once the ini->rc is assigned to an none-zero value,
> the value can not be overwritten anymore. So the ini-rc should be set to
> the error reason only when an error actually occurs.
> 
> When finding ISM/RDMA devices, device not found is not a real error, as
> not all machine have ISM/RDMA devices. Failures after device found, when
> initializing device or when initializing connection, is real errors, and
> should be store in ini->rc.
> 
> SMC_CLC_DECL_DIFFPREFIX also is not a real error, as for SMC-RV2, it is
> not require same prefix.

If it's important enough to be a fix this late in the release cycle,
it better come with a Fixes tag...
-- 
pw-bot: cr

