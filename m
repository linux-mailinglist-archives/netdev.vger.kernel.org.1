Return-Path: <netdev+bounces-135976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8293599FE27
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FF7285127
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA17060B8A;
	Wed, 16 Oct 2024 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ejikx1vP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABA101C4;
	Wed, 16 Oct 2024 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041742; cv=none; b=u3Tl2nmr8nqA97EtUVGJ2zczvsCjAtMPl3gJSCFYeJmL4QgIgxzANUjsrgZ1Cyj+4jT5mD2RhYPxyjtoYUA72rVmw6wW8xK6noV/wKfCCvj9ysrdZROjIxB4ii2PpFpEhx0yqJcHdrHY+0IBzhDUTvl5HcsBpDXRFQFZWopajEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041742; c=relaxed/simple;
	bh=734rualSmdrUHKjG/tW1JhjYMpe0YxVIcLOk/cEFfq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DA30SSbFKH+p3EEyLQuB8gpwpmBGMEFbTA52nMBu3ORklLi767+f7n9608kfxmpmK16SFyRPXvBoS97EwpIaK5O2Wl1WCNSYVKrn/5T/A/1m5BUe3Wt9ppk+u0PyyhhifWoS3+HOG6EDHNhhBsOaxhnLAdznydG94KOJDhEdPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ejikx1vP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4B3C4CEC6;
	Wed, 16 Oct 2024 01:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729041742;
	bh=734rualSmdrUHKjG/tW1JhjYMpe0YxVIcLOk/cEFfq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ejikx1vPL3NI0LAqrJnIgAxpBpRgduwD7OXgBNq4WNBBppFPGuZy7dIiE2NK5Dmgu
	 5DcXnu+e/1UEAUBVSfzNUyFN8bbCxol2NJhf4LXVz3A2780N+roWf39jKxs+MZ+VaK
	 b/o+DIK/2U8J1PGMHyeZfj+sNCrBefMKFKTq+Gq5y0LmhgPFTqrT/AmWEcUL4QxLDq
	 vhr8n2myYQm0QcL4rKEkEUuYWa7wt3DF2/sQI0ybGtkb3nSrHNj+waqGHRA769kQJ3
	 C1yxqxwIhnuPeOmBvjQyQhWjJOXgB2sxfy3gPuKjcvi3+CTqkfv5I1qKfGrssC/uw9
	 urb8J3LvwnYFg==
Date: Tue, 15 Oct 2024 18:22:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
 <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <lanhao@huawei.com>,
 <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 6/9] net: hns3: don't auto enable misc vector
Message-ID: <20241015182220.10ea0425@kernel.org>
In-Reply-To: <20241011094521.3008298-7-shaojijie@huawei.com>
References: <20241011094521.3008298-1-shaojijie@huawei.com>
	<20241011094521.3008298-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 17:45:18 +0800 Jijie Shao wrote:
> +	irq_set_status_flags(hdev->misc_vector.vector_irq, IRQ_NOAUTOEN);
>  	ret = request_irq(hdev->misc_vector.vector_irq, hclge_misc_irq_handle,

You can pass IRQF_NO_AUTOEN to request_irq() instead, no?

