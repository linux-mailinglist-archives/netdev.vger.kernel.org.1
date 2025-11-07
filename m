Return-Path: <netdev+bounces-236874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13292C41272
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 18:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A85188377A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540F4336EDD;
	Fri,  7 Nov 2025 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELrQNNZt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E6334C25
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537889; cv=none; b=FbFq5rIK9KpRK7xxiWUrZkxFQyIu+BFNMZximefCT6PMcWeuF0ACgshYZyjtdj36bIn6b4zO7ALd66MRC9kO1paNTFUOunHBL26DMyswtAgN1bVd9VN7oA306FdpWvtuzB+ryk9bgq8VD6KNG+xuN+2BRsSsIJMs+rB5PIVHuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537889; c=relaxed/simple;
	bh=zH5Y5kzfZDqM6XSPZXHd+xDsjJay/Ois7rZjMY6UsPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0kuX8miSZwQBPvjnt6PZIMgd6Gh1da+G+7p0hVXBWnHE14+dqRj9k7ytHETf4AIgShVSni+XdFbSF6qdnYbenuPJwyWMzYW2LqbQP24MuvfHjlP+Toi1f3TJYgBnU75oci6cNWJxUUywWIuf7FSAew5aT5CBuGLIAMHUOYKE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELrQNNZt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710683a644so6853775e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762537886; x=1763142686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Tucutz7IrOhRztkZU3smHLVMxqcaOobL5jt095lc2k=;
        b=ELrQNNZtZ8xpyrUTaNVMrMLq6edSahgtODjiKm1IKWRWjWseiPqOOQhk1anKez3R3S
         8T+u+cMNZ7ztTu0DnveXsu7TuI93hL0HOIUEG4uMv+Fbfa2ls1yVSCKK8p/fCbDSC+cm
         UVNvMrpIn4Y1pzdQWBN7WcbtmJopnlnzNsOmV3c6WrcGlVVwdiZbVTO2BvBdtWuLYhqV
         qk741iJpVI6iTsleB0+cO0DAi80Wsdt43uMhT8Mxjxo2/h0Z8tFvMESZLdyCV8AhyaM/
         5QXnZR1Q0oUIjeN+7442j8mCLFcl4Z0SFtewxSlgIKOh0eyzSxJQTcORp34lE4LhEveK
         QALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762537886; x=1763142686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Tucutz7IrOhRztkZU3smHLVMxqcaOobL5jt095lc2k=;
        b=SzWceyDlbD9Got6cAHqNu25V+n5pu1pHPmCnPXqejPaTZ/T5dF+uNFY3HNe3a0YrTI
         ZszSpNGh/3ulBL+iiw5PBuwCYChzlFRUYqR1RqUpIfcJtcRE0TnPr0VWrvdo+7zAEHe5
         ru4y3GQwyWGmFpps5kN3TriISO2dM7Wydm41Dr/RxkWhl9NOfNGYA8SjWveYOtL9D/OU
         u/FfQ3/01etw0yXKrmCTaiZPr8lWxg+J68LKrB22V5+dgL1p/dBg1VSKS1aqficRQrM7
         60VBFlSwoaYCGyWyjJgqcTf3FHC0RGpgVHIuChykc0mf1GYFmsivRXbdwHxGT8LJmmyn
         3mJw==
X-Forwarded-Encrypted: i=1; AJvYcCUeTdcXx9lrLhAo6qYmAGPod8iA8zSb5R0a+/p55Bv8PlH3N1/aRxM5sNcP9/EZWeCWzrzKaUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFGwkyTUtLAuijXQ/evvMZhF37oIFswuMmnmgp3d+yDcbgUVg
	D+dpX0sB3SrfTz9vJt2AD31I22ArKZ/JgG3c3FWMYOCu+EKGnTI5c+ty
X-Gm-Gg: ASbGncv7vzMTypZeUyF7I+ST0oVj9pTVL1x+HJtc33jdRpWLCVt2DDdJBpZvumKjyMD
	UvfIoJA/mNP7pDaEy2w+Pu3Ym4LUwNM0Y1K6WONI//10g9/fsFSVSg47eWubaCSH2qLTZyypRbM
	KHGpf3JEjGVeXwhX8jZEPOjgxG1xbw4yKkmuiHa3iqbc2xkesSTAFZAEpLuMBssdgJvnZ1zdd+s
	KeFt9nigdrrrGV3lsgwPeZt+QTOsDn1Kd7vBwChQmVxcMR+pjsWuPhbzobCsBNRteAo/jwR/r6d
	bq3swnPSHxWhquytfMfvE+apqc/jMX1tc3xiPugXK+zMajZcE8EY2EEnJQ+WMiKFlwD2Or239xa
	u9Tocmq2j/nMG0X1EtkIvqW8O1ecOJJ4kp+wGdvB1w8zuqxjYRyBvTI8KbqJv+vJdmPV0In/NNd
	DwrW9maxRUxgQbpRS9L+fc79s3LV7rywv4CeL0UD3IS0cF9M32XNr+
X-Google-Smtp-Source: AGHT+IEoWHsw26cGBlNpbuXd/J8PJbsclbLScfONHz/78/yXn3dKVEpgZr30FQ4+9RfcD30Gp2hhjg==
X-Received: by 2002:a05:600c:c0c9:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-4776e57b741mr22139575e9.16.1762537885623;
        Fri, 07 Nov 2025 09:51:25 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f89fsm49280675e9.3.2025.11.07.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 09:51:25 -0800 (PST)
Date: Fri, 7 Nov 2025 17:51:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Junrui Luo <moonafterrain@outlook.com>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, tiwai@suse.com,
 perex@perex.cz, linux-sound@vger.kernel.org, mchehab@kernel.org,
 awalls@md.metrocast.net, linux-media@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <20251107175123.70ded89e@pumpkin>
In-Reply-To: <aQ3riwUO_3v3UOvj@pathway.suse.cz>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
	<SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
	<20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
	<20251107091246.4e5900f4@pumpkin>
	<aQ29Zzajef81E2DZ@smile.fi.intel.com>
	<aQ3riwUO_3v3UOvj@pathway.suse.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 13:52:27 +0100
Petr Mladek <pmladek@suse.com> wrote:

> On Fri 2025-11-07 11:35:35, Andy Shevchenko wrote:
> > On Fri, Nov 07, 2025 at 09:12:46AM +0000, David Laight wrote:  
> > > On Thu, 6 Nov 2025 21:38:33 -0800
> > > Andrew Morton <akpm@linux-foundation.org> wrote:  
> > > > On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:  
> > 
> > ...
> >   
> > > That is true for all the snprintf() functions.
> > >   
> > > > I wonder if we should instead implement a kasprintf() version of this
> > > > which reallocs each time and then switch all the callers over to that.  
> > > 
> > > That adds the cost of a malloc, and I, like kasprintf() probably ends up
> > > doing all the work of snprintf twice.
> > > 
> > > I'd be tempted to avoid the strlen() by passing in the offset.
> > > So (say):
> > > #define scnprintf_at(buf, len, off, ...) \
> > > 	scnprintf((buf) + off, (len) - off, __VA_ARGS__)  
> 
> It does not handle correctly the situation when len < off.
> Othersise, it looks good.

That shouldn't happen unless the calling code is really buggy.
There is also a WARN_ON_ONCE() at the top of snprintf().

	David

> 
> > > Then you can chain calls, eg:
> > > 	off = scnprintf(buf, sizeof buf, ....);
> > > 	off += scnprintf_at(buf, sizeof buf, off, ....);  
> > 
> > I like this suggestion. Also note, that the original implementation works directly
> > on static buffers.  
> 
> I would prefer this as well. IMHO, it encourages people to write a better code.
> 
> Best Regards,
> Petr


