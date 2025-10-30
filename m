Return-Path: <netdev+bounces-234479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62980C21541
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480DA189B79F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D952EDD50;
	Thu, 30 Oct 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nEvFbdoz"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AF2EBB81;
	Thu, 30 Oct 2025 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843261; cv=none; b=uC2/zTTJaJFGLVhPOkxHJIGARvlMQcmiMXsVhZFJ02jW2NaT0bXxEJ102UlJDdHLUl3+rC9NDZI5TvWGrUQNJKFotjoLQ2jF13X69xedCpDgp2+RGJEL57R/Gmyos2/IYU7TctkWS++e6wwyvhL5MSQbsB2bwd6mT/YN7O7hPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843261; c=relaxed/simple;
	bh=IAa3g1dCS+JQYUlzG8wtI5nxRXw7u3GnYsaf9pUaHBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQcjR7bYlXQhT/ms8jyIQDYqX7zPuwIs+bn6rAFMJFnU8VQlEGmCWNVdTnpB/hI/553z7AAwIwR2E6BXP+n4DEGC6Ov3/NIX30MX3Ay5+1HjmgvYLKL2ibVvcB/c7ukT1vKVENkSHqkBzEN3VN+i6c5c0AZOlcZjlnKK51vuOzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nEvFbdoz; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 292EC40AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761843258; bh=3TQG9ZKbIk35Xrzl9XV4HOWfqcpUjDw8Xyqu2bLMh4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nEvFbdozJpVyAQL6v2ZT51qOqIZi8IK5a1GHA/z/BGchX/M4GUc123Hl1br/IVFW2
	 NBO94ZvLjWbFn6WfWNGTdhmsz47H6uI90RLblBoGamVo+RlGsd/Cq2xy3mHe6oVSBq
	 h9Dwn1slnVVL9Q6tebNC2cNTLSKdCZGUo+9M/H1sViCphOQYsa3KHi3vZ0VDxTIQYF
	 FQQLcPzT1GrkT+1WNCLB/0iXLHCaPaWduS+wTjUArymkSi3Nj7ID77UKeU3DYoPyhe
	 rWaH48VdpTHnFi8oX+9bpFV8spm11PsEdTfKepNWArFnYxM3UKEel8APFgTmH4y8xJ
	 hSFzjfwu/v3wg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 292EC40AED;
	Thu, 30 Oct 2025 16:54:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jacob Keller <jacob.e.keller@intel.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH] docs: kdoc: fix duplicate section warning message
In-Reply-To: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
References: <20251029-jk-fix-kernel-doc-duplicate-return-warning-v1-1-28ed58bec304@intel.com>
Date: Thu, 30 Oct 2025 10:54:17 -0600
Message-ID: <87frb0miti.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> The python version of the kernel-doc parser emits some strange warnings
> with just a line number in certain cases:
>
> $ ./scripts/kernel-doc -Wall -none 'include/linux/virtio_config.h'
> Warning: 174
> Warning: 184
> Warning: 190
> Warning: include/linux/virtio_config.h:226 No description found for return value of '__virtio_test_bit'
> Warning: include/linux/virtio_config.h:259 No description found for return value of 'virtio_has_feature'
> Warning: include/linux/virtio_config.h:283 No description found for return value of 'virtio_has_dma_quirk'
> Warning: include/linux/virtio_config.h:392 No description found for return value of 'virtqueue_set_affinity'
>
> I eventually tracked this down to the lone call of emit_msg() in the
> KernelEntry class, which looks like:
>
>   self.emit_msg(self.new_start_line, f"duplicate section name '{name}'\n")
>
> This looks like all the other emit_msg calls. Unfortunately, the definition
> within the KernelEntry class takes only a message parameter and not a line
> number. The intended message is passed as the warning!
>
> Pass the filename to the KernelEntry class, and use this to build the log
> message in the same way as the KernelDoc class does.

So I would like to thrash the logging more thoroughly in a number of
ways.  Having separate log() and warn() functions would be a good start.

Failing that, though, this looks to me like a reasonable fix.

However: it doesn't apply to docs-next.  I can try to make a version
that does in the next day or three, but if you could respin it against
the current docs, that would be great...?

Thanks,

jon

