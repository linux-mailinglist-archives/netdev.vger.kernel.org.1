Return-Path: <netdev+bounces-236636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7BC3E867
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 06:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA00188B98F
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 05:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C917F20487E;
	Fri,  7 Nov 2025 05:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f5Qk3bd9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5EC16F0FE;
	Fri,  7 Nov 2025 05:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762493914; cv=none; b=obyEBbJKjimjYZQhzqRp6UZi1XiboJa5HgOhgUYXHEoQma2FYBo/jDpQ5/0weCYz0D537xVBJcLuTLlGlcJSeYbENqKAzjvVY+dWDoDMycz+4ZqaiPo9Kpr4L0RkkB2MKRoCO6uTHE/secvtlniDMLU74875fQGkT/k7jzgtXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762493914; c=relaxed/simple;
	bh=3TfIUSMvsTncvNbcBo1+XXhAgkdL0rKd3KT7E06BRHI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KhssiYNbfK3bUVTXkTKDfJl/0W41Uqu3lbrn/bSkv8qtHD3Ilh5aPDYWk3NSFQnYgEx24rTcf0yo1fQTOv1cMVAQ034XgMyua6n7ZNka+qOJ9GZMd6P1lOquryfwcM8F3cUdfZ+QAyAPM8EzQwCIEJ8DlHo/D6xKsSwZaBs/Y7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f5Qk3bd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F583C4CEF5;
	Fri,  7 Nov 2025 05:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762493914;
	bh=3TfIUSMvsTncvNbcBo1+XXhAgkdL0rKd3KT7E06BRHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f5Qk3bd95j6Mp2Yvi8a8OptR33mdZ5ZAXUjmebdPGjbaeAtxIjKImi6ermTjEGcRV
	 vm7lyHDa2QgRJ43b1wp4RP2Vf6WXxDzTUvvnN3quaoNH8tCu9NdkzzmPyn9s5VFuyG
	 NcAQMroNrorUsYWX5mck9k6u5qJQlUOiow6JGV28=
Date: Thu, 6 Nov 2025 21:38:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org,
 andriy.shevchenko@linux.intel.com, tiwai@suse.com, perex@perex.cz,
 linux-sound@vger.kernel.org, mchehab@kernel.org, awalls@md.metrocast.net,
 linux-media@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-Id: <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
In-Reply-To: <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
	<SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:

> +/**
> + * scnprintf_append - Append a formatted string to a buffer
> + * @buf: The buffer to append to (must be null-terminated)
> + * @size: The size of the buffer
> + * @fmt: Format string
> + * @...: Arguments for the format string
> + *
> + * This function appends a formatted string to an existing null-terminated
> + * buffer. It is safe to use in a chain of calls, as it returns the total
> + * length of the string.
> + *
> + * Returns: The total length of the string in @buf

It wouldn't hurt to describe the behavior when this runs out of space
in *buf.



The whole thing is a bit unweildy - how much space must the caller
allocate for `buf'?  I bet that's a wild old guess.


I wonder if we should instead implement a kasprintf() version of this
which reallocs each time and then switch all the callers over to that.


um,

int kasprintf_append(char **pbuf, gfp_t gfp_flags, const char *fmt, ...);


int caller()
{
	char *buf = NULL;
	while (...) {
		x = kasprintf_append(&buf, GFP_KERNEL, "%whatever", stuff...);
		if (x == -ENOMEM)
			return x;
	}
	...
	kfree(buf);
}

So much nicer!

