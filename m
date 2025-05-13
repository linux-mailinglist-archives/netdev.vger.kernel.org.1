Return-Path: <netdev+bounces-190163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9C4AB5618
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF03189534F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86F123BF9F;
	Tue, 13 May 2025 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fH+YppnT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE81DA0E0;
	Tue, 13 May 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143123; cv=none; b=J3d9tu9x2p78CsWu8l4QVCR14v44Xg7zZSKv2SMqBJPwtFWY3gbB1Ahy4z56kRTdHoCmOLvYGnrymH7e7WIszypfpBje4XtIBZUfsoKa7O/OX0MUbML1lzKqa3D9em3zmi9/kRkjY+79lGY4JcSNwdfqzwIdRIQJRIOInc89gpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143123; c=relaxed/simple;
	bh=YsIKILfQNS7UinbPrFtQtobq+mN8hl8flRW8Cn9zmqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YlfDpE1JjTKuhMMczu3hGNp5/RYunXDaHoadL77NAF9le5UM//DoBTuEC26qFvqd2ltM+1fHPm1hGUbyUsDmYfkVOfxFIj93hf0+drPlLY0UOs4u6SXyXzb7QoFHZqe1fUJPjAtFkGyTQhRQsXVWoMJkpGhsfwygCLT2mFd0O7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fH+YppnT; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 14e429d87;
	Tue, 13 May 2025 21:31:53 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: dawid.osuchowski@linux.intel.com
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jianhao.xu@seu.edu.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH] ixgbe/ipsec: use memzero_explicit() for stack SA structs
Date: Tue, 13 May 2025 13:31:52 +0000
Message-Id: <20250513133152.4071482-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170f287e-23b1-468b-9b59-08680de1ecf1@linux.intel.com>
References: <170f287e-23b1-468b-9b59-08680de1ecf1@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT01DVk0eSEsfTktKQxhNTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk9ITFVKS0tVSk
	JLS1kG
X-HM-Tid: 0a96c9d83ba403a1kunm14e429d87
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRg6Djo5CTE9UToUMzEhHyIT
	CSMwCktVSlVKTE9MSk9ISkpPQktMVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFKSU5INwY+
DKIM-Signature:a=rsa-sha256;
	b=fH+YppnTV23L9Mdg8mnyZ3T6Y6/o30N+4dgO+bUS8CZP/+3Kp6jRymt7IwrA0ZPYFKwIBJuDr0hGwW8CgxD8RDsk0pZidqIGCoIH97c0uhPxxWv+jPbYzFY7Z2BkDudLBPpR0aPtu+FrngPUX9oF7DACN+xu+bj9N2vKUpEmUwU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=l8Yr1CSkPkOtqf6fgw4DQxke/6uqpIqLiUd46wrdXKo=;
	h=date:mime-version:subject:message-id:from;

On Tue, May 13, 2025 at 12:24:41PM+0000, Zilin Guan wrote:
> Both paths return immediately on key-parsing failure, should I add a 
> memzero_explicit(&rsa, sizeof(rsa)) before Rx-SA's return or remove the 
> memset(&tsa, ...) in the Tx-SA path to keep them consistent?
> 
> Best Regards,
> Zilin Guan

If this change is required, should I submit it as a new standalone patch, 
or include it in a v2 of the existing patch series?

