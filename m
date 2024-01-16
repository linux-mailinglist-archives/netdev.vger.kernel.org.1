Return-Path: <netdev+bounces-63742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9182F21F
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 17:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CC01F239B9
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB41C68C;
	Tue, 16 Jan 2024 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MhPqBXfi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3891C294
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-680b1335af6so85367066d6.1
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705421098; x=1706025898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRhpAqwcPI8Xedzyd3oP/0D0SjQEOOToY+gFZWdA9gY=;
        b=MhPqBXfiShJ2cbOLVecDMUX4xETSSJHbCwssn852THkCXMgDABGFgJE3IP0JAUBaxg
         zZ60t6HtdrZ2gAs0Ty4f57Ct5yDrfbwWmu5hpHtQjKXoZvIssRQrFQ16GjsKa3lESZxd
         sBosWlkgicgRt9kZldC3N+OE7iIIuFsD5JEfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421098; x=1706025898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRhpAqwcPI8Xedzyd3oP/0D0SjQEOOToY+gFZWdA9gY=;
        b=U0cGAjMylSHfpf4SdVrtS+QDTQaN4I+cMCQC816utjWnFqXchRafQK+ehkoNg+7aYR
         Ra4emHCi661Z4ch5lBqXEcW0jkISnov6++ETtgbQqc5090/dU5H5ZpMfzbrbcNxkE+gI
         LvsQLmkU2VTkpR2qPNu+viAs5XrOGPfeLRy1V1lf/6xnyK0uo5Heq8z5ZtYMHBqDRhR0
         +9nqdQwINf7AjQuwueXjRrDYx1AxuWcWBHoVK/h/K1Rfs1LdSwUXRuseNW9+1x5eaSHW
         nRy9OxdiOyQ0nQ/rwM9Lt/ngiYBtzgKVIpA2pqfQ7u6IK6X8rONpso4j3DtCyzNcVn+P
         wZmQ==
X-Gm-Message-State: AOJu0YzDKH2LOOf9+OgSWojH5jZhfeYEO6vMzgaqSvSXMBuFv5DCTNig
	ihyxZwH/jnDVx2k45BTw81MFNT4yZ65s
X-Google-Smtp-Source: AGHT+IG++kpNljjNh5ascnwnyOg0Iq9ipKzFH8C9HXVklnkiz0WdQK3f6wDKCnRcpTA47pk6Ed92HA==
X-Received: by 2002:a05:6214:234e:b0:680:d315:5dea with SMTP id hu14-20020a056214234e00b00680d3155deamr8841196qvb.33.1705421097932;
        Tue, 16 Jan 2024 08:04:57 -0800 (PST)
Received: from C02YVCJELVCG ([136.54.24.230])
        by smtp.gmail.com with ESMTPSA id e10-20020ad4418a000000b0067f80dbd535sm4301767qvp.8.2024.01.16.08.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:04:57 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Tue, 16 Jan 2024 11:04:51 -0500
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jan 16th
Message-ID: <ZaapI9zDaP1YI7AA@C02YVCJELVCG>
References: <20240115175440.09839b84@kernel.org>
 <Zaaek6U6DnVUk5OM@C02YVCJELVCG>
 <65a6a0cf8a810_41466208c2@john.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a6a0cf8a810_41466208c2@john.notmuch>

On Tue, Jan 16, 2024 at 07:29:19AM -0800, John Fastabend wrote:
> Andy Gospodarek wrote:
> > On Mon, Jan 15, 2024 at 05:54:40PM -0800, Jakub Kicinski wrote:
> > > Hi,
> > > 
> > > The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> > > is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).
> > > 
> > > There's a minor CI update. Please suggest other topics.
> > > 
> > 
> > I would like to discuss a process question for posting a fix to a stable kernel
> > that isn't needed in the latest upstream as it was fixed another way.
> > 
> > This is related to this thread:
> > 
> > https://lore.kernel.org/linux-patches/ZZQqGtYqN3X9EuWo@C02YVCJELVCG.dhcp.broadcom.net/
> > 
> > Thanks.
> > 
> 
> If you send it to stable with a tag like,
> 
>   CC: <stable@vger.kernel.org> # 5.15.x
> 
> or whatever kernel you need this has worked from me. This has worked for
> me if I understood the above question correctly. The relevant docs are in
> Documentation/process/stable-kernel-rules.rst. The following bit seems to
> explain it.
> 
>  * For patches that may have kernel version prerequisites specify them using
>    the following format in the sign-off area:
> 
>    .. code-block:: none
> 
>      Cc: <stable@vger.kernel.org> # 3.3.x
> 
>    The tag has the meaning of:
> 
>    .. code-block:: none
> 
>      git cherry-pick <this commit>
> 
>    For each "-stable" tree starting with the specified version.
> 
>    Note, such tagging is unnecessary if the stable team can derive the
>    appropriate versions from Fixes: tags.
> 
>  * To delay pick up of patches, use the following format:
> 
>    .. code-block:: none
> 
>      Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
> 
>  * For any other requests, just add a note to the stable tag. This for example
>    can be used to point out known problems:
> 
>    .. code-block:: none
> 
>      Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.3

Thanks, John.

This one is a bit odd what happened is that by the time this problem was
reported (on an older kernel), the code changed out from underneath.
The new code was bug-compatible with the old code (whic is an indicator
that a good job was done porting bnxt_en to use DMA mapping from the
page pool infra.

So at the time when the patch was posted, the tip of tree code did need
a fixes tag of:

Fixes: 578fcfd26e2a ("bnxt_en: Let the page pool manage the DMA mapping")

In any kernel pre-6.6 (or if we found the patch a few months back) the
patch would have been different (since the dma mapping was handled
differently) and the fixes tag would have been:

Fixes: a7559bc8c17c ("bnxt: support transmit and free of aggregation buffers")

Greg's concern (at least as I read it) is that it looks like I'm asking
him to take a patch that is not upstream.  That totally makes sense, but
now what?

Based on what I see in Documentation, I think I need to just resubmit to
stable as that would follow "Option 2" and explain why it 'deviates from
the original' patch.



