Return-Path: <netdev+bounces-86335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F1F89E691
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15BD282E22
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B767B170;
	Wed, 10 Apr 2024 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFmGV8M2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C677F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707414; cv=none; b=mjlNVeOnpuPDp81exfH/Ocolp+s3WecH23O2TzgVjxuVDVyHWPLdYahDIv2KPehjPSfxYL86adxS3V41P13Rjp2BRJFg6kuimezmC+eLshRf9XjbL8KUk0CdFdYgCNM8r/gPly4CBCvyYGna3yqVSiquevmrF6q3mhIwj4PTExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707414; c=relaxed/simple;
	bh=eumGdjyOCoFTyo5XNfyC/ItzGUMdc+Om6RcZ+Tlwys4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izXgqLGYfEvbKgc+DvkNKRkjwxmqkksN/aD4qsP1CYtHwNrEC0Lh0Ejo/xJIv320oXVnqM89K9vaohSz/c+ZeZmP9+aA1SGJNJaTFoPO9dqyPGKuCxHw6JNHd/r8tvgVwFZcPLhARhfoFOpCWK4Ab0jvuQcY5ajJ10wegrYv0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFmGV8M2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E960C433F1;
	Wed, 10 Apr 2024 00:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712707414;
	bh=eumGdjyOCoFTyo5XNfyC/ItzGUMdc+Om6RcZ+Tlwys4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dFmGV8M22FP+AAHY1fGcrFj0T46Mbx/8oyW505wJ6hv0230eApTiCED3gP8BqJTaC
	 N5c2Df9ULy2ng2NG+u/Y7lX1RPXqj20JpA1+Goj02zSD9E/g8pbJst2PWgrrUf0woq
	 taMtDgce/DUVXZiOvO2X8C2EbMJMMUcJqfufIuHMyDPI5Xrape9oZ3DhaOglo81IM+
	 8sGpRV09olJ211HolXmSlEkL270c1x/9/1p9TFQzrghNqFUddNslDIusHkIOQ/k45G
	 kSPqKYh8uu44SxCUBTmn6eE47Ccr/2de1JTTkINYO/tAmGMbUn9a2FPnlH0PRaF09b
	 96xCcaoOAs19g==
Date: Tue, 9 Apr 2024 17:03:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net 1/3] net: add copy_safe_from_sockptr() helper
Message-ID: <20240409170332.244941a1@kernel.org>
In-Reply-To: <20240408082845.3957374-2-edumazet@google.com>
References: <20240408082845.3957374-1-edumazet@google.com>
	<20240408082845.3957374-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 08:28:43 +0000 Eric Dumazet wrote:
> + * Returns
> + *  * -EINVAL: @optlen < @ksize
> + *  * -EFAULT: access to userspace failed.
> + *  * 0 : @ksize bytes were copied

We enabled the "kdoc returns" validation, because people were nit
picking on the list. Apparently there needs to be a colon at the end:

          here
          v
 * Returns:
 *  * -EINVAL: @optlen < @ksize

Fixed when applying.

