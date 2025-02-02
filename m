Return-Path: <netdev+bounces-161954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B91A24C6E
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 02:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312E73A516A
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 01:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBCA4A04;
	Sun,  2 Feb 2025 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN1yrBpd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38752C8DF
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738459429; cv=none; b=AJ8yPu5dM/ns68AALcZj5pVOsBSiIT3tP1MhdEe2xPJztad65YYnNzXZL0WdBLjyJimbKDj42DHaJGkLP9M9DF2qvdZ5GQfdyKw3rai4LU1xHnOj2qvRFLLSEDopnLAR5pjZG9U+a9W8awUzUz8+uEhsTRdpPMR3wkyS5wSyrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738459429; c=relaxed/simple;
	bh=udEJWriXwcSRj1qPpx/ReotmbK0PpEqHIItlFRjEND8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNQOvlnsr6lH2eIX4vF0BGFcEGxe5H9Aon9p/vTUfZm5Pc+Qwh9LUX7sUv7Lh5v13qFbzK8e2POgqulcDo1OXLQG5dl/czq+J11OZ3pcGsOeY5kzIaQem0XQT4ZSTca1+uJ95vWOP9P3B5WhXLM5KUYHkwhT6AC0TkR87wfGoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN1yrBpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AFBC4CED3;
	Sun,  2 Feb 2025 01:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738459428;
	bh=udEJWriXwcSRj1qPpx/ReotmbK0PpEqHIItlFRjEND8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BN1yrBpdfqxOI1vAROI8mT7/Wqz0JQRIXd9084uPiLAKLDVkNzmr55KRQq6aqEnX4
	 ME7VF9XTUdxuRCpYSXiHKZVbBb6o7QbDMEGjdD8SwJpfjDk/U5OBoMYDHw4/8mwwBD
	 VY6nAHLabWmTqhfBChud5l2+0neLS0Jk3/xi/ysfmMt7nXGhAK9SgbgcJmSvUqdQrR
	 sladMbJ+f4hiYJ98iplxx3IvdqvCkXCFV48xQuUteZ+1IokQXATCfKsNz++oaWmy0u
	 1pqzlgkgE1ZzGIH8Iv0+8eT8P6Fz8urdMzDJZSHlr8y7Xvlv+4sZjvNB7dOzifReJb
	 UxxFC1O8T/wFQ==
Date: Sat, 1 Feb 2025 17:23:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH net] net: armonize tstats and dstats
Message-ID: <20250201172347.75497656@kernel.org>
In-Reply-To: <2e1c444cf0f63ae472baff29862c4c869be17031.1738432804.git.pabeni@redhat.com>
References: <2e1c444cf0f63ae472baff29862c4c869be17031.1738432804.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Feb 2025 19:02:51 +0100 Paolo Abeni wrote:
> Subject: [PATCH net] net: armonize tstats and dstats

How very French of you :)

Code looks good:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

