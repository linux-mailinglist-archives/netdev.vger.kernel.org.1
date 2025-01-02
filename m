Return-Path: <netdev+bounces-154752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E79FFAAD
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CD8161CD7
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DAAEEBB;
	Thu,  2 Jan 2025 15:01:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15F522F;
	Thu,  2 Jan 2025 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830102; cv=none; b=fm6px8vi26tN4sioHL8Zju+2YzVD0XMV61NgcL6p1cE8UAVDkUCiWJg8GqbMKfQEdpD6wSAx9Y/oQqMb59WqF99rTW2QZd7LCFZGR36GIgIvRdXGUbAqb7hrt9szywHZJS1EbtxnR/4fJV+94mNoZ/uZbaPSdRNmJ2/4OPk0dxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830102; c=relaxed/simple;
	bh=Cfyv4UbvprYQeksKp29VyrtqkBVvgsiQxvl7EUURDas=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni9e6iHfqgmEVY8DStBuVXIBcdJOe4imsrIcO1WtwTrhyAJ1IZWCALr0Xf3UQaJD4S9sXdEt3VI48Ie8IX2MS32ekJ8lA3khNBOU2u+X65K3KH0L/oUchB/xArTID/9Uwch5DxqUEveJfOuCu3d/sFvhWxj8bsm/b6Z2d0HCe3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YP8v33J8mz6K5lW;
	Thu,  2 Jan 2025 22:57:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 64BB4140A9C;
	Thu,  2 Jan 2025 23:01:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 Jan
 2025 16:01:37 +0100
Date: Thu, 2 Jan 2025 15:01:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 13/27] cxl: prepare memdev creation for type2
Message-ID: <20250102150136.00003ff0@huawei.com>
In-Reply-To: <20241230214445.27602-14-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
	<20241230214445.27602-14-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Dec 2024 21:44:31 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected.
> 
> Create a new cxl_mem device type with no attributes for Type2.
> 
> Avoid debugfs files relying on existence of cxl_memdev_state.

"Avoid debugfs files that rely on existence of cxl_memdev_state."

Currently it means you keep the files but break their reliance
on that state. So subtly different from what is implemented.

> 
> Make devm_cxl_add_memdev accesible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



