Return-Path: <netdev+bounces-179074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A156A7A5F2
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 17:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5049718929E6
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401F2505A6;
	Thu,  3 Apr 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfuRcQlR"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BD2459EE
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692794; cv=none; b=HMDogdosTBX+DF65JbH3Ub5y2nJTF3Ke2GpTajSDR5+mbfHR0aX9Mf7MSeOeUcWTwpNTKK4LPvvsQ9JspzOB8pMqgVWwdbVffAFIxW380wtSjnu6ZPWl3V13+KstAAKtpZhSR8IHMVbKsaUKVhg3kDFiIK90o490oik8vqoOhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692794; c=relaxed/simple;
	bh=5GP5RZmUBQ1wzr5iwwBo7iXHT36Wk+et9xtjaPHEntY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoByESv5M1aanWg8T7ZUwLuRmtGP/+iWxIrAkTmFATXKZAyBnKbszFwvRhjZDxuX3v2dtbjlju1hMDdgqow6GshHavWam1gef1zHRk1FWhhC+GCz11AAnnqm5euYfbsHY4Q6T3SuagIrUo20amKZ4bUe89Pvix6BasaL53MGNwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfuRcQlR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id EF99F13801BC;
	Thu,  3 Apr 2025 11:06:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 03 Apr 2025 11:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743692791; x=1743779191; bh=aUG9w+cbM0DIQtlEf0yUg+GjDVj3j0yl1OK
	HICcgcgA=; b=YfuRcQlRAcVI4n88FG9SQqTxQMpKCJHCBJClV6hkiSiVQF1bBIS
	yPsuxYsDbrJBHwWxBivx4cSp+Nr+mttxxyTyWLvxDHecE4KJxTTFLjeB0ycpVWIe
	/U8TvR26mtqLnr9RPAau/tODWwK9u1Je0EJYcXAlS6oYCIUNxxE2a6ISPq/qVUlc
	GPcloqKWUtBdTAXPlDDO9BV72zihrCnr7CUmaJpTSyfIW8cWt1IY5NIKMg/HKxqq
	TRJ/KeRHUlwA4AjHUMfSDVRg9VkcZGBglMf7JIlxf4VHqBkNlPOj8e2AOVwU9TAl
	HWG+rceOD2GYL5N2B1IZIXcy/2YYY88sG8w==
X-ME-Sender: <xms:96PuZ-OCvvTFdzM0-rikt4UH8yq19Bpm37AL3EkFw4PcT5X2F2iEQA>
    <xme:96PuZ8_I7ynjSZlEdomFC7bmx2eqW3c-EM6QU78u0NK7wmX_5QVAaeKU0Y7mkkyVO
    Nx6DYBeCqkHHxA>
X-ME-Received: <xmr:96PuZ1TStuHkr-nHjnWszTCPxvislPsuVLvMdPdayc6yoeDPNU7GyJQZrV7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgthhgrvghlrd
    gthhgrnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrh
    gvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghp
    thhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghllh
    gvrhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:96PuZ-txIl6Eqygjgltd4MlXtX2Wzye3ZxTzD_ZB2_V3vQKQsE-Qng>
    <xmx:96PuZ2dn6xEQQwjHljosAWWD3-oLKIGaiLLlFX2wDGNRI7lO4pUjTw>
    <xmx:96PuZy0t_EW9RdkMZhd9sP5L3tiZtIvixMG2NARa-_ZCWiNV0MZsfw>
    <xmx:96PuZ687D3uMBEjiU8tsjGlt-Kmibhhoq4TNxSUcwmksB-wbRGXs0A>
    <xmx:96PuZwLjE7gCqC7M7ay4s9hL7ffSfxCez4KMmuTq7DSCCuk1ULBHr7NR>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 11:06:30 -0400 (EDT)
Date: Thu, 3 Apr 2025 18:06:28 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	horms@kernel.org, danieller@nvidia.com,
	damodharam.ammepalli@broadcom.com, andrew.gospodarek@broadcom.com,
	petrm@nvidia.com
Subject: Re: [PATCH net 1/2] ethtool: cmis_cdb: use correct rpl size in
 ethtool_cmis_module_poll()
Message-ID: <Z-6j9F_zF7pBGbOS@shredder>
References: <20250402183123.321036-1-michael.chan@broadcom.com>
 <20250402183123.321036-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402183123.321036-2-michael.chan@broadcom.com>

On Wed, Apr 02, 2025 at 11:31:22AM -0700, Michael Chan wrote:
> From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> 
> rpl is passed as a pointer to ethtool_cmis_module_poll(), so the correct
> size of rpl is sizeof(*rpl) which should be just 1 byte.  Using the
> pointer size instead can cause stack corruption:
> 
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ethtool_cmis_wait_for_cond+0xf4/0x100
> CPU: 72 UID: 0 PID: 4440 Comm: kworker/72:2 Kdump: loaded Tainted: G           OE      6.11.0 #24
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: Dell Inc. PowerEdge R760/04GWWM, BIOS 1.6.6 09/20/2023
> Workqueue: events module_flash_fw_work
> Call Trace:
>  <TASK>
>  panic+0x339/0x360
>  ? ethtool_cmis_wait_for_cond+0xf4/0x100
>  ? __pfx_status_success+0x10/0x10
>  ? __pfx_status_fail+0x10/0x10
>  __stack_chk_fail+0x10/0x10
>  ethtool_cmis_wait_for_cond+0xf4/0x100
>  ethtool_cmis_cdb_execute_cmd+0x1fc/0x330
>  ? __pfx_status_fail+0x10/0x10
>  cmis_cdb_module_features_get+0x6d/0xd0
>  ethtool_cmis_cdb_init+0x8a/0xd0
>  ethtool_cmis_fw_update+0x46/0x1d0
>  module_flash_fw_work+0x17/0xa0
>  process_one_work+0x179/0x390
>  worker_thread+0x239/0x340
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xcc/0x100
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2d/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands)
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

