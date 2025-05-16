Return-Path: <netdev+bounces-191078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A113AB9F6E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7702C178ACC
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34A81C4A13;
	Fri, 16 May 2025 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Ph9zdwHy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB41A3178;
	Fri, 16 May 2025 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407856; cv=none; b=VfXm/suxdlDyfWMJZvfs6h0og4wnldAAY+Hkw7Bj6CRGgXLAF1JxiXTlA143HcRr+nO/78JwEfA9IJmtrO2iaVgEhKPKUjVbpnNLboz+QbJKLRo2nngFwHJ9OLqUyxg/bDB+iLEwVxkPTp8ZH6ajNLSRObe/M2nNPC9p0bvflyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407856; c=relaxed/simple;
	bh=DSS78Uadk0D9mNTdK8KcSncPoqOFqWs+tChfvJXDBzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EJLfu365tjd+yLHTwIbcPXBcaMY9lztSWsoBCsrgBuv1Mj4oSToyInwmXpw1KLBLMjeJ5gxLS+kcOWzRwAlaObR1j/TNU/0Ug2x15Ohk2P4GfJgwWiovzzaQgmvKInjOrF/hFRX7AL5a80p+fq9L4QOZyBEqhKbTx/PY+Jn7hTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Ph9zdwHy; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1550f62fe;
	Fri, 16 May 2025 23:04:01 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	dawid.osuchowski@linux.intel.com,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jianhao.xu@seu.edu.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH] ixgbe/ipsec: use memzero_explicit() for stack SA structs
Date: Fri, 16 May 2025 15:04:00 +0000
Message-Id: <20250516150400.512375-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9dd26263-54d9-4abb-bb46-d3cb089a9c21@intel.com>
References: <9dd26263-54d9-4abb-bb46-d3cb089a9c21@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHx0dVhhDSB5KQk9PHh8aQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk9ITFVKS0tVSk
	JLS1kG
X-HM-Tid: 0a96d99fa8d303a1kunm1550f62fe
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzI6Hjo5NDExKjQDCwwLSBYO
	Nz5PCxRVSlVKTE9MT0tMQ09JTkJLVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFKTENLNwY+
DKIM-Signature:a=rsa-sha256;
	b=Ph9zdwHyFdULmgbPsFBaM1pAyP74J747hMqTwy8oMW/QC5b708X9tmRcIcfwZS2i7XucFVBws578JC6CrXWsX96W85FN9i9WBewShXhiNyzUIHsBUC9L1RKZPabJRPR1csgwfAhVqnTBPya/SqPBjVRxPDg8EWEIw7eSJw+TlmY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=r9HPR2Umq66bOFDAt1v/K5AmzV1bsBJKAHkqRRyKngg=;
	h=date:mime-version:subject:message-id:from;

On Thu, May 15, 2025 at 11:27:22AM+0200, Przemek Kitszel wrote:
> the general rule is to memzero_explicit() memory that was holding secure
> content
> --
> to have full picture: it is fine to memset() such storage prior to use,
> it is also fine to combine related changes in one commit/one series
> 
> re stated purpose of the patch:
> I see @rsa cleaned in just one exit point of ixgbe_ipsec_add_sa(),
> instead of all of them, so v2 seems warranted

Hi Przemek,

Thank you for your detailed feedback and clarification.

As Dawid pointed out, while @rsa is cleared at one exit point in 
ixgbe_ipsec_add_sa(), another exit path, at which we fail to acquire the 
RX SA table, leaves rsa.key and rsa.salt zeroed. Does this imply there's
no sensitive data to clear in this case? If so, would using memset() on 
the symmetric error path in @tsa be redundant, or am I overlooking 
something?

I'd appreciate your thoughts on this.

Best regards,
Zilin Guan

