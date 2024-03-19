Return-Path: <netdev+bounces-80559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600FE87FCAE
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9331C21CE9
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E647E585;
	Tue, 19 Mar 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="R2lHCizn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AE5810A
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847078; cv=none; b=EBi+a84TGG2eoVPu4IUqdRZrwmMT8ha3hr21E6CzxezhaY5m45Czxul10KFYiRFSGAzaxiFcwuQSTHE71Z91ByIoerkxoXI+pPKInCjv2xc0LKSQznvt4EBAD2RDjYa0O1KYKB6KPRUcJQuxelwkfDpT590l2mcMLpRl8tyvroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847078; c=relaxed/simple;
	bh=qbS/Fq6/ZtBC6Ftwa7pn2jPBmoaqXs1RyTvJMpw3UQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPpehvQ9IqyFp15/0OnAOZSb6LNQKyhLEBCh2tfXmCNqPwnaSYAx74dKmU5/b5LhxXzlsT7ZJktMU4DRhlCbsPxqTCFw8+lnQfMOn1VICY6UHwQT31QACPjvr6uN1gZZemRR6/lMrrYAD5i/hWNsfOqOKjVnJUq77/AeYuIDPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=R2lHCizn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41409fd8b6eso28266745e9.2
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710847075; x=1711451875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcvCGlMHRwj9k6ByHHyaeay4OtVn7NmyScS9HG65Uco=;
        b=R2lHCizneRB+LKYuLEQfSKd6olc5CnyhRIx8n8NRaba+xTEup6yMpkvwRsAIhY44rA
         6BRgwTEkeHNp1ZUFx6Wk9x6nTqT0FXhC/UvJSMJE8vyIUtTTuL9GDy1qJrpoBwTaD1r5
         Rx4ruZR07vVF99oIFV/o45tVb+UPQfYrKfxNeELy5z187biUT99KXuQQomZiPtvNY0Fd
         xA0RiLsdlcN0odBR75YnU2qKVa7KWMZCv89mDdHhsVDOz6tjPsK66j3/fh85FpADghEL
         XRRvH+7P1UsrzFMjsrrPhVi7oJeOa9EGCIkIouAY0vsKaadmxHjhL4sYN5tIDIiy3joe
         /ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710847075; x=1711451875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcvCGlMHRwj9k6ByHHyaeay4OtVn7NmyScS9HG65Uco=;
        b=mNufT1DvXn31XL+mbN6X5nSnoKRIjk1hdHbx/vc7J48EhMvuNmW1+tU0w4VwKCdWzR
         2Ign4Hl0QUlglgI39Z9jIOW4avrVBixMK2QnQ4UMTNtSd7qoiq0taOXSS876b5ripM3k
         JS5HxPDjqDdVrFMl4049Q34gPAER077XspHhWBc+56R9AkAg9nhIOrImI6nVjyoR1l5r
         oAEVgI15diwqwymLYxpWRNfDxs/QbA23WjKrJKuYMYFoQutH6p57Pj4AXRKJubJuIfZg
         TwdInziD8/WYau0KQ+Fa2pGEZ2tVHof3gRFrr3NpLW1kkszh372pjivsqEkS9zpDgoz4
         PUnA==
X-Forwarded-Encrypted: i=1; AJvYcCW4Lm54p09O2EzVWHgg8j9wuV9NUINakqPs1C7Jv0N04n4MMENNJpdylkyd6ZXx81xxDIxOihq/1r72RYyoF1kP4yw4otr2
X-Gm-Message-State: AOJu0YyvOKhlCL+jawnpZCp1uyTJSRAtPze7mhwRdlSDWPULscxHI6jR
	HlBqSv+Vd1/YZq+JTvkhWweg6YEYYFKXFLHTEmk7n+x9e9iM8eVPk1l3oZSYsfA=
X-Google-Smtp-Source: AGHT+IE4g8Wl2ZoiP7Nozc66zsCnp4nObAKcwAoSyvr4KFr0lJ/nsG98UjxjzFxXlsaHKFuKlZZy9Q==
X-Received: by 2002:a05:600c:3556:b0:412:beee:36b3 with SMTP id i22-20020a05600c355600b00412beee36b3mr10520229wmq.7.1710847075115;
        Tue, 19 Mar 2024 04:17:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b0041466d8e33bsm1183307wmq.27.2024.03.19.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:17:54 -0700 (PDT)
Date: Tue, 19 Mar 2024 12:17:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.kubiak@intel.com, rkannoth@marvell.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net 2/3] net: hns3: fix kernel crash when devlink
 reload during pf initialization
Message-ID: <Zfl0Xz3vNNH_3Mfo@nanopsycho>
References: <20240318132948.3624333-1-shaojijie@huawei.com>
 <20240318132948.3624333-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318132948.3624333-3-shaojijie@huawei.com>

Mon, Mar 18, 2024 at 02:29:47PM CET, shaojijie@huawei.com wrote:
>From: Yonglong Liu <liuyonglong@huawei.com>
>
>The devlink reload process will access the hardware resources,
>but the register operation is done before the hardware is initialized.
>so, if process the devlink reload during initialization, may lead to kernel
>crash. This patch fixes this by checking whether the NIC is initialized.

Fix your locking, you should take devl_lock during your init. That would
disallow reload to race with it.

pw-bot: cr

>
>Fixes: b741269b2759 ("net: hns3: add support for registering devlink for PF")
>Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
>Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>---
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
>index 9a939c0b217f..80db4f7b05f6 100644
>--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
>+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
>@@ -40,8 +40,9 @@ static int hclge_devlink_reload_down(struct devlink *devlink, bool netns_change,
> 	struct pci_dev *pdev = hdev->pdev;
> 	int ret;
> 
>-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state)) {
>-		dev_err(&pdev->dev, "reset is handling\n");
>+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
>+	    !test_bit(HCLGE_STATE_NIC_REGISTERED, &hdev->state)) {
>+		dev_err(&pdev->dev, "reset is handling or driver removed\n");
> 		return -EBUSY;
> 	}
> 
>-- 
>2.30.0
>
>

