Return-Path: <netdev+bounces-117792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788394F591
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B121F218D1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628BD187343;
	Mon, 12 Aug 2024 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIRaW+Y2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C6153810;
	Mon, 12 Aug 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482306; cv=none; b=FFFewJUyRTDnFEdNU1mLs5C29RGUXWasGyLOL1/HMGsggwkzdy5r1fg2kVLdPob03OyXtJcTQsJpfnlvXD5TLgKMuKkGpGNHFcqORuTE4XbrCKRMYxGZRSDKQa6H/j8c3lwE/V8cDmrZUAghD0tGFGE52qwaCponOkzAGtXh7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482306; c=relaxed/simple;
	bh=nGcCW2Z1YAIcXdyifp6GjqczrTw3ORAKWT7d2KqSpGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJz8BKtc2C/3mKZ1dAiRxTdtAzC/GtIJzJCBnd0YzgZZbUHrRUBGOqSpF2J5r5PZpEHvPtfwboPmwA5UR98OklBKQeWYsw+0uwS4Oc4u8RrwhkbdG5mrJWzEM1yiw1iXAtp+n8Y64CEWw89IaV7HjKmiKatCcK9rqEBKSONgreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIRaW+Y2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-691bb56eb65so43063067b3.0;
        Mon, 12 Aug 2024 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723482304; x=1724087104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z78ABYtGsD4PvnFhguI+IBxt4vCLdgWiW9HPbIHJLc=;
        b=MIRaW+Y2VfrCojyOZdRlbUQIKVXDYoMFs6jwpMMDMpmoFMbxN66gsebbSTFv2agJw5
         rl9BgTcmJchz+TJ52GZXb32w4QB9Z1YUvmYBl8kg+0tCUJYoIMKHnVp+HmFQzBQPrx7p
         hrAiWiWJeFsCg/uaaEtgvUKAGfOCtxhG35yQBWozrx0tZBtDrf1Lr6AqXR3yv/Fj2saW
         NMfwdfddttIh/kPdBdzLCGQSEO3uDA1guW2ffSfkjAn8FTcJY2P3x6B4CEncXjNU1j7H
         WlUMBh7VYSynHeCGBRWNd12s9a7mcQ9GLukGMdbohnRZbtNLkdLibk3nMGeq67a5kpNn
         4vtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482304; x=1724087104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z78ABYtGsD4PvnFhguI+IBxt4vCLdgWiW9HPbIHJLc=;
        b=uRyO50cYd3ITed2dFJ+XOqhhFpqyPF2qc9moEmI9nSH9WpCb8rq0EFmBW1DoehuftY
         UWKWyBTfVVFUpgsHhYQrnKafr3Hfl9fUdeHzd1RQTUjxD98kqx7xY9EvdFhji7aI9Pjq
         N/I/MVa7XuYz7KHQTnl8Xl6+wo0+3AIrKhNIT4kq0MejrBOxX7+duDownOhA0VWlu1yt
         koJesdyMzcdL1zFN8oNW2CJw1uU6011DA31WXn4lzd8T2DDbOruwEVx8QxBX4M5n81IZ
         rCqgK+XuL+YZfF+Fm7abppngNGL5X2Vj9+MySfKULnsw1cbPvPvYwm2vMBaRrE4+0f/Y
         0enA==
X-Forwarded-Encrypted: i=1; AJvYcCVPHUaHkHGurGljQK8JIyy/v2Q3zUaVcLWrKiwW8TpVsiyaUb4qPqrYc0fmFXzuLB8P+ApZN/kcU6SLEqpeM4TCm6lcFRjJPsrGo1hL
X-Gm-Message-State: AOJu0YzkYhMka4n5qGWHjyHLPKgUM2ivq4vQwmXluchqhtqSEFsoVeaO
	uox6a8Xx3rehHEMdcCAbOX6s+uJkz2ynKO3acA8u6wRAk1CBbCDdy/NeuRz0W2EiuQ1u9JZRFbh
	vqoZVye3UBTnCG/cC6T9IgsnIG08=
X-Google-Smtp-Source: AGHT+IEpUF/yDgDgrUUfmYhh5k0RJDQ28XT1MWUFp7NtUwXo3wtkGp7z/r0fN6yTc0Uc+B7f8JZP3pBakx907x9paoY=
X-Received: by 2002:a05:690c:270c:b0:664:4b9c:3ec with SMTP id
 00721157ae682-6a971eb6dc6mr10591987b3.10.1723482303696; Mon, 12 Aug 2024
 10:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809044738.4347-1-rosenp@gmail.com> <20240812124224.GA7679@kernel.org>
In-Reply-To: <20240812124224.GA7679@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 12 Aug 2024 10:04:51 -0700
Message-ID: <CAKxU2N-m7SSTxuWQUuMH6E8FnF0RXGUMPepA=DunoZsvzJ-ahg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: octeon_ep_vf: use ethtool_sprintf/puts
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, vburru@marvell.com, sedara@marvell.com, 
	srasheed@marvell.com, sburla@marvell.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 5:43=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Aug 08, 2024 at 09:47:27PM -0700, Rosen Penev wrote:
> > Simplifies the function and avoids manual pointer manipulation.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> Thanks,
>
> The code changes look good to me and my local testing shows that it compi=
les.
> So, from that point of view:
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> But I do have a few points about process, which I hope you will
> give due consideration:
>
> 1. It would be good if the patch description was a bit more verbose.
>    And indicated how you found this problem (by inspection?)
>    and how it was tested (compile tested only?).
Right. This is just an API change. There should be no actual change in
functionality.
>
>    This helps set expectations for reviewers of this patch,
>    both now and in the future.
>
> 2. You have posed a number of similar patches.
>    To aid review it would be best to group these, say in batches of
>    no more than 10.
I plan to do a treewide commit with a coccinelle script but would like
to manually fix the problematic ones before doing so. Having said that
I still need to figure out how to do a cover letter...
>
>    F.e. Point 1, above, doesn't just apply to this patch.
>
> 3. Please do review the Networking subsystem process document
>
>    https://docs.kernel.org/process/maintainer-netdev.html
>
> ...

