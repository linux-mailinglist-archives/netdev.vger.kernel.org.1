Return-Path: <netdev+bounces-293170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG85EvHRGWo+zQgAu9opvQ
	(envelope-from <netdev+bounces-293170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:50:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8693606D82
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 238A135F5B83
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159893F1AB1;
	Fri, 29 May 2026 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiTUy1Op"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF83F870E
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073721; cv=none; b=j+a6VkhcXxTpqHbVHgweK29jxGUzS/uYvWHmSQx4spEFSxS7iVmp6a34EA9PnSrGHtTe1/AltLyJyfuN9D8KdLU9Mh/pzBvWzVbYq/LcwC6Dug102WiIMHHWcNzml7Brc6pCyQ0dR3O7M2qZRiCXlSpn1lYAewqNCGgE/bsGHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073721; c=relaxed/simple;
	bh=llW4OxFvtKWFyEC9eRxy9VUDdqj1IBqiGVZmNBrPlP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWh+ChPrZfjZouYk1GBckc5L55uPcUHSMr5Kr4eUOMdciXAdF/CKoU6fsKCMogQWHBnXjdg5/fkKj4Ua+++Pe2ar8twwnAOwYe4zTvWy/6RfvaLcH7tTNUd2Dm7TBtYc9Ioad+/EJ/YiGWClWhu4Le3mQvcvn/5nA211WAN5JK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiTUy1Op; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso76550575e9.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073718; x=1780678518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg88DDtH/8BXfFFdiCpH0Ax+iqDzN9Cpw3OqPjVLSd0=;
        b=aiTUy1Op+lYKoApuLxe7JXrRYO2t/I3uULvMmUsOHz0HkpZGDgZ1iZf97sCp1yHLvu
         0cFlLa4hBdMNEMS4IppVax/VaoCcuiXYFrV6iUupCMRo/7pxUNM/J+AkB9L6yFWBIlvx
         4kJUlQ2ZaPeZXfAqqoyHLvTfRguwpAhCKAPNdV3UtuA8HC7FicRQQM5lUwxOop3dvql8
         loAh1Y6Sto5lfxtAQjA2G+L48fYNc6emeJoUO+JT8W2pvC7jgZA4AzH9qC14GWoU8kgq
         b2VFTb5VW3ECBBPZv2CpkIPqkoZ66dzgC+dQvzLlYbqnAl6H0GQv/2LAdQnXvp7M36bY
         Kepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073718; x=1780678518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kg88DDtH/8BXfFFdiCpH0Ax+iqDzN9Cpw3OqPjVLSd0=;
        b=RiFY/n8R2wS4xD6a5Vy3MBQfr59MX7x5vxFEM+ZYkpRe72/zruc9Nh1VEHvY7MKghH
         F3OT/jH5OQFXI8YckqGFlRBiOwW5SoYWOp5FhEX7AC74zm7jRl6MRn+X/HyLufjFm/Nk
         /xqkU3VmJ5zSKy8FdOmbz6azLPEbdyQsGvKvkfCExtGgNoDMezDa0FA3s5bYv0vGaWRU
         QfXGPOKJYjp62OBPTo+S+4pUzwBSicjKE3NL1m+tl9amXTP8Tukj8HKf5j6oZJ64V5nL
         NlrCIcLTFpf7wSU6b7niMgLZCuh7EFAzTYq+KxeMoTaZdypV2c6HTKS29dQ9MinT6XtA
         1NLg==
X-Forwarded-Encrypted: i=1; AFNElJ/BthyYCxm49gob2JjOYyOUN9tLSZZYgYD0c57FC6Ti/jMOgfL9VLAZc5oUaQT9K/Q3Gvl5oyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx125Wz10cyHSciFqcldkayFm0lad72UPTKXd70dbd0zwX9kLkQ
	+eicXPJE0RXMrOo1Ha8Cfc7wn3EupclBONPTTpQJ4fSaA2/fG7ejO27F
X-Gm-Gg: Acq92OEsxLPxwfljlPSHeguNeCr6RT0wXDlXz3GMtDZLUeOkn2pVQcakin9uAAB2XW7
	FxQ3V5gRDgUnocQwtcmgKn2KXH7dt8xQX9Itop+ummw4kUwBD0sDxqJ4gcXMtAcqdirEVo0150v
	29CTjGSDe7J03Jd4AYuPP9TacI8eM3TJ7Ej7cJpL/RWvd4Gb/CJ8cD3uzMWP1+ZVZDrzKFCBCJt
	uKN/wYQE6qNlYPhWD7AswAFSR2WSvosLFt4Z5S9AoH0Xw2Gorxa5qMLvojNfoXIHWnNbq5c1T5c
	X29ZXqxmL9y5U4wwScb+tCm9/JuNoXZle7Hk1BdQcW38cz0iVEnX7ZEX1oWlFJ7xXrqz0ZAXANJ
	fbXmdWCVBtU74Fn13Ndh06YADLhkwsbyunwulEHetWmzO5GYTHhp8yI2ZCWJznWU6oQEOZy8x60
	oGehwB+suaXTTykxpV7TDA9xT22PmK9NSJPGC9w6yMtXJqqiYwJEGL0pkd7gCpiAy7c8yyDbQ=
X-Received: by 2002:a7b:c3c3:0:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490a2941d7emr4738915e9.18.1780073717867;
        Fri, 29 May 2026 09:55:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0a89sm68444645e9.7.2026.05.29.09.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:55:17 -0700 (PDT)
Date: Fri, 29 May 2026 17:55:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match
 kernel
Message-ID: <20260529175516.06d5788f@pumpkin>
In-Reply-To: <20260529134947.GA128816@nvidia.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
	<6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
	<ahiFxtmspbETiqWw@google.com>
	<20260529134947.GA128816@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293170-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A8693606D82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 10:49:47 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 28, 2026 at 06:13:26PM +0000, David Matlack wrote:
> 
> > Let's put these in tools/arch/arm64/include/asm/io.h so that the tools
> > headers are more aligned with the kernel headers, and so that the arm64
> > io.h overrides are done in the same way as the x86 overrides in
> > tools/arch/x86/include/asm/io.h.
> > 
> > Something like this (untested):  
> 
> Okay, the disassembly says it works:
> 
>     1db8:       ca080108        eor     x8, x8, x8
>     1dbc:       b5000008        cbnz    x8, 1dbc <readl+0x58>
>     1dc0:       f9000fe8        str     x8, [sp, #24]

That looks strange, I suspect the C didn't match any usual pattern.
Normally 'tmp' would get thrown away and 'v' would get kept.
But you seem to have discarded 'v' and written 'tmp' to stack.

I'm probably being stupid again, but how does that work?
The cpu can speculate straight through the control dependency into
the following instructions.
An 'eor x1, x8, x8' may not even have a data-dependency on x8.
(Most x86 cpus just generate a zero for the equivalent instruction.)

-- David

> 
> Jason
> 


