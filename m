Return-Path: <netdev+bounces-247785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED28CFE66D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D42F5301D5D3
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F9A355809;
	Wed,  7 Jan 2026 14:49:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F3355804
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797396; cv=none; b=IDRRnY5oBdulh4GpUiEmkQ40+lrj1wEIqbi3KW00BOGpfuokzsLSesOyiRtLK8U8K0M9tmOVEMT1qRGUf5dWSWeZdtggZnWNkBpFvbT3XlOTiKOLVlG1DS7ZfTs8+aO2To6DzYhrn6iblJyLZ3J+Xx6i0c7Swy8mlu2yhSNLAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797396; c=relaxed/simple;
	bh=osl6vrBt0IXGyZBefxMFeDDLnbTP5uGuV4aS82yutQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGbBcxLBpaekY0GAUGKO2LBossmYYTL3GLzNu7aQvo+vde7w9CncvSblNt6Fo6X8R25SBBzCMSdjHi0FtG8iHv9ccjt3idt0E2YvltDX2YYmpWlqHFSslliJuxGw6dBCXTDSfObDpAxf0BBFu/uHUMCrqt5Yin1moQIAZwBXSZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-65cfb4beabcso1303129eaf.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767797393; x=1768402193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQkY59DeE1vgVLwbeSLHnvYnYwGjrhZ6pudLKjncWzQ=;
        b=L/ZyjwQJ2PwlEgugWBSbpqhyI35Om5lOdOA6bPtURm8dP5I75BVAfVwWaBvZWnTCQm
         bH+LOrTatpdNR3VFKbT5G2FuhfCcj0PSpteQuToXNVTFPaeW/ukQvKMUl7dCBYS79c7h
         gJiBlA1g+S6Dln/VPV4bb9epOSRfzLdPps83yTqK+PCauRcmy6DEdDua5rslUZcvo4fe
         xPwsbjJWAbG8dBAlWNshcJku4LlqJQnNHYIO/e1izf5N0/mxhtsCrx9dwiFs4/8os724
         BbLUVYTs7ZS09ySTO65u+lbuo7TWKIqxo8mcNcoYSwRXUGpTxZpEXCbIDnotUnIWnW+y
         fkPg==
X-Gm-Message-State: AOJu0Yww5u1H4wQIAYjrBKE+jIl1RjYqatfKPisrgt/HwdPSmQACVSu+
	dF3+SfVL3s93oLmN3Kb5Q5Lq+Nt8KqXpjG9LWCrAdc6bjwMiauAhlc9hmFWgvA==
X-Gm-Gg: AY/fxX45tA590cfmLUEoy5B2FuZnGUqhXGYNHyp/gJ/P4bapsiPoSE+avS5Sr4BKSFl
	qhqHCJbh5CJjfGGGxE4H4d6MRwjjqzIB7YO53z0J6YuTWUm0tCw4m6O41iZQPVae4pDesOtvREs
	iwGqMaNRwTagC9L6V66X/FMlMqXTRd3S+mNVH2leDgJVTnQc11JsbJjkhAdaWg7F2CrQ1OU8jkY
	GrMjHd3YqTJGX1/20TlK9/JWTcg9yN/3EGMGC906+Xg2pJj7vizoOEwAgcb/oOUqQRYr9T59y6B
	oVeuuWxzNKaJqTmsh7cTCJgDdbp7RRX4qBy/U+dKUJkQ6ELTX5Sop4xFpWm3ICAolBm9E9SzUbg
	y1RmJ8i0aR8tSVPkWzzJIiCRETPttB4MLYJ5fdsi9o3mlD6AqDg76wjmLVK2JyYF3rxSFq0ltVy
	JWtRchwKBmi46/Iw==
X-Google-Smtp-Source: AGHT+IF6jhhRB4Njfs4SvcunYwv34l2OH0EunFy0CT188DAhMUx3PPAoxevnG3G1usEIdAfSWEJFEA==
X-Received: by 2002:a05:6820:4006:b0:65f:5451:d80b with SMTP id 006d021491bc7-65f55086554mr1051996eaf.68.1767797393296;
        Wed, 07 Jan 2026 06:49:53 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ced969sm2087609eaf.17.2026.01.07.06.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:49:52 -0800 (PST)
Date: Wed, 7 Jan 2026 06:49:51 -0800
From: Breno Leitao <leitao@debian.org>
To: pmladek@suse.com, john.ogness@linutronix.de, mpdesouza@suse.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, 
	jv@jvosburgh.net, kernel-team@meta.com, Petr Mladek <pmladek@suse.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222-nbcon-v1-0-65b43c098708@debian.org>

Hello Petr, John and Marcos,

On Mon, Dec 22, 2025 at 06:52:09AM -0800, Breno Leitao wrote:
> This series adds support for the nbcon (new buffer console) infrastructure
> to netconsole, enabling lock-free, priority-based console operations that
> are safer in crash scenarios.

I've been reflecting further on this port and encountered a potential
roadblock that I'd like to discuss to ensure I'm heading in the right
direction.

Netconsole appends additional data (sysdata) to messages, specifically
the CPU and task_struct->comm fields.

Basically, it appends current->comm and raw_smp_processor_id()
when sending a message.
(For more details, see sysdata_append_cpu_nr() and
sysdata_append_taskname())

With nbcon, since netconsole will operate on a separate thread, this
sysdata may become inaccurate (the data would reflect the printk thread
rather than the original task or CPU that generated the message).

Upon reviewing the printk subsystem, I noticed that struct
printk_info->caller_id stores similar information, but not exactly the
same. It contains either the CPU *or* the task, not both, and this data
isn't easily accessible from within the ->write_thread() context. 

One possible solution that comes to my mind is to pass both the CPU ID
and the task_struct/vpid to struct printk_info, and then integrate this
into struct nbcon_write_context *wctxt somehow.

This way, netconsole could reliably query the original CPU and task that
generated the message, regardless of where the netconsole code is
executed.

How crazy is this approach?

