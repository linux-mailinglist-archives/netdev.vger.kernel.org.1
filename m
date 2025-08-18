Return-Path: <netdev+bounces-214460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16CB29A9B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BAC5E2923
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B82798EA;
	Mon, 18 Aug 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CVaR7okJ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055127978B;
	Mon, 18 Aug 2025 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501248; cv=none; b=f8UH0zjqfHOnyCu6Cu8/aimoS0ynasMlwu0eqif6ogPvqONa5/RmDr3GMAp9zMAo/hLi2HjHE2uc0p5zZbRzjxnoGYdTuNnpdMzgxDf2Q/mZULhc0oJKlM9/x+xKORusEQQstLjZFiAQfS3pHb9bJyEUrvRpUSMtcyJmIym5OLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501248; c=relaxed/simple;
	bh=FGb4UwrWywcSB3tZNn9tiihK3YGb6MlCyHl4JcBhygU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S0AAs9jByvwEiABQLLR+9Awvwq2ArtkKLv7bfGFREqdtRrE172IPrZXAd00Egp4FzMST5ySWYEEhaVAq4tchabXPLhXKThfICuEWbEGkSXWz+ybE5l39HAAjMXu5vP4pXCbxV+ZOPCVB33PYBqeSbAnIhS517KzXZPcXk8gcca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CVaR7okJ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Z2
	UmjGkjZM9k3ZI8mTUmtYKnE0zL9Lra6xvHugeaaZM=; b=CVaR7okJb8tw5dkJDr
	gOnXn93hkI6DNo+cgTBs3pinNF0W8K5AX2lZD2vOLOXL5H6d4KMlMhVEfd6w24/C
	f9uZQyC1F8odtgu5QeHKF2IvmqoyQjIrSOgFK7Ks4YxMJAnLSb8s8ITJv8y5l5Bn
	gif5m9fETKBDOYzD1HOVwJ92g=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHFEie0qJoYZ87CQ--.18753S2;
	Mon, 18 Aug 2025 15:13:35 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: af_packet: Use hrtimer to do the retire operation
Date: Mon, 18 Aug 2025 15:13:34 +0800
Message-Id: <20250818071334.240913-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHFEie0qJoYZ87CQ--.18753S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF17Ww1xKFyUXr1fCw4UArb_yoWDCrgE9r
	yDZF1jkw43GF4fGF43Gr43XrW3tFWUta45GayrArn2gryUZFZrCFs09ryDCa1rGa1vkasI
	kFWDXrW7Gw12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU10zutUUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibgOtCmiizdOAJAAAs6

On Sun, 2025-08-17 at 21:28 +0800, Willem wrote:

> Here we cannot use hrtimer_add_expires for the same reason you gave in
> the second version of the patch:
> 
> > Additionally, I think we cannot avoid using ktime_get, as the retire
> > timeout for each block is not fixed. When there are a lot of network packets,
> > a block can retire quickly, and if we do not re-fetch the time, the timeout
> > duration may be set incorrectly.
> 
> Is that right?
> 
> Otherwise patch LGTM.


Dear Willem,

While reviewing the code, I suddenly realized that previously I used 
hrtimer_set_expires instead of hrtimer_forward_now to resolve the situation when
handling the retire timer timeout while run into prb_open_block simultaneously.
However, since there is now a distinction with the bool start variable in PATCH v4,
it seems that we no longer need to use hrtimer_set_expires and can directly use
hrtimer_forward_now instead. Therefore, I plan to make this change immediately and
resend PATCH v4. Please take a look at it then.

Thanks
Xin Zhao


