Return-Path: <netdev+bounces-192141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA5ABEA27
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283191BA6660
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A2E221DB9;
	Wed, 21 May 2025 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3DnZOR7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B8184;
	Wed, 21 May 2025 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796784; cv=none; b=hvtY4/CSQPTTgY3fQL9+o4ZCG0c/UdekEnKyyyHv0wa7PZdzlWqaz48UORMMzdTODyXSVFuh4AtOC705316PrXwNHXC9Xju8RZ9OmJOIRKCIkOKBNXgbY9FDzWN4CjQclCa3Qv5RNDg2XwI2GKZmwjB5IpGJ556JjAKxgr9opOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796784; c=relaxed/simple;
	bh=GUeibuV3EQXGGLiC+SNS3o9Pnm4RJ+FhQAScA/chtKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDi+lGCXtgdFAbpoB/q5Llp9f85KHDjqSJwVNqQpTIWOTlT8Umodbwqs4MIoADWmksNr4hFXSEcUuLPwsGHHnZzUcBhgf/l8sK5TmjQQYu6oA7/PJbhiWxY2/DO2GVFu09gnUKc3KjkHDylu5dM+ezQC0l5QqpIZSiyZn4u2lMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3DnZOR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390C4C4CEE9;
	Wed, 21 May 2025 03:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747796783;
	bh=GUeibuV3EQXGGLiC+SNS3o9Pnm4RJ+FhQAScA/chtKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s3DnZOR7IaZmeLuIGfQXrixHcN1suiK8ak8iSnbjrNTl556RBUjReKSyHxTCqL4L9
	 U3afK34+rcXqqLx+3/8JBw0KmvQ6G8u9S/RPUeNYa7je1L5mGM96oBUSQRKgKeAkEE
	 kOFNiDRazPRPcdjTajnOtHuIfvn8xAojvr6pDabuK5/HSV8ESZv4quilpcZZBSdZsX
	 ptZOK8q9IVPovbaiQxJrUQGvy4FPAaHtm3F1GNp+NLegvaeLWxRKeFAewr8EIIS2sL
	 kRnjzPV6XZtaT+ZsIoTlHMKHpODyzoXJt9sd9E9PwTddjx57ZLPIGla02rKLDG+cmR
	 nu00XYPKBVBcA==
Date: Tue, 20 May 2025 20:06:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Simon
 Horman <horms@kernel.org>, Sanman Pradhan <sanmanpradhan@meta.com>, Su Hui
 <suhui@nfschina.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Replace kzalloc/fbnic_fw_init_cmpl
 with fbnic_fw_alloc_cmpl
Message-ID: <20250520200622.04165f61@kernel.org>
In-Reply-To: <20250516164804.741348-1-lee@trager.us>
References: <20250516164804.741348-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 09:46:41 -0700 Lee Trager wrote:
> Replace the pattern of calling and validating kzalloc then
> fbnic_fw_init_cmpl with a single function, fbnic_fw_alloc_cmpl.
> 
> Signed-off-by: Lee Trager <lee@trager.us>

Applied, thanks!

