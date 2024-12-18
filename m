Return-Path: <netdev+bounces-152995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4281A9F68C6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C792172790
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA6F1C173D;
	Wed, 18 Dec 2024 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="XVdx/QuC"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248D1F4E52
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532712; cv=none; b=FVRWVtILrAjE3pklA3V+FGXOraGsFzWJC28Ti9SCqWGSahWJfBLzbwoeGvaSd5pe+Bs4O99Euyix86R+XmY0U7KpO2OKHSaBkpymiqBLReh1yl4T2A6x6Ud9+1xG2lonqpVNeckm5VXuD3Wbw2GCO7kgaxuSUN9sC/4ROm7ZyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532712; c=relaxed/simple;
	bh=uMmFbVCTRat4dNYAiTug4x/Qd0svvTDndjbW0XaB/4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAGw/4+hif3izRDl3JOsWKsqbUvg5gLtCmcBJbIMc86XB7+xSH5ToT1lUKo4KRtbr7BQ6E3dgdfTeKYeCIOcp4344sneB9nh/pPVJ5WMfWGngxjx3uqGRk1jEHYaQ6pk389nsKMgkR6ue3jXpAlMDxZTJEQH+Q0TNlRo0XHkG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=XVdx/QuC; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tNvBz-004sgL-C7; Wed, 18 Dec 2024 15:38:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=c5x931FVhSQnVoyKesY6NH4T1m7uU8HBNGBaFotNpUk=; b=XVdx/QuCoR+zamfO8F8v/iTU26
	aMq7Zn/9S3+Ni4oITjo5DJcCTNAPIsRfFyxfvgEhMFeihZ0F2RYITi5l6LZxzJ9q2/GtumgNtzdvR
	yY8WuzsGS/Xz0hpAZrrPZzl9XjA7sMzOI3Odh6nMGSB3uac48dCRM7VFv+6zDMtN23Enr+E3tBjdg
	S6R1NljzeGASWmDEfL2xSL3AGAKb1eCspkjE3udmH1q66KAQ1MQLWyNLG6IEc7ARZZtueelt1IhLt
	QkGqJV781bx1E1sbaY61Yfd2gzmYbkRW7Mvtu1uxQ8cXY/BhZzKEj/EZVP1dts3S4Dmb1Am0b1n8b
	4tkmiBpw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tNvBt-0000xy-S8; Wed, 18 Dec 2024 15:38:22 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tNvBq-006Pgn-6N; Wed, 18 Dec 2024 15:38:18 +0100
Message-ID: <03ae1a3e-9dde-4cb0-b617-b03bcaadab64@rbox.co>
Date: Wed, 18 Dec 2024 15:38:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/7] vsock/test: Tests for memory leaks
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 15:32, Michal Luczaj wrote:
> Series adds tests for recently fixed memory leaks[1]:
> 
> commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory leak")
> commit fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak")
> commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error handling")
> 
> Patch 1/6 is a non-functional preparatory cleanup.
> Patch 2/6 is a test suite extension for picking specific tests.
> Patch 3/6 explains the need of kmemleak scans.
> Patches 4-5-6 add the tests.
> 
> NOTE: Test in patch 6/6 ("vsock/test: Add test for MSG_ZEROCOPY completion
> memory leak") may stop working even before this series is merged. See
> changes proposed in [2]. The failslab variant would be unaffected. [...]

Bah, I've added one more patch: "vsock/test: Adapt send_byte()/recv_byte()
to handle MSG_ZEROCOPY" and broke the numbering above, sorry.

Michal


