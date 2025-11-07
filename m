Return-Path: <netdev+bounces-236773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C05E2C3FFDF
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 13:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 719284E4EED
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 12:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8206A28507B;
	Fri,  7 Nov 2025 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QNjRTMBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E50C28467C
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519953; cv=none; b=pfgs82ATv7vSbBDk3YmGGretuLzj/L/qZRn0C6p2kJSd3SdYD2Tg3aG01qDVoJImntbKgJY03/7kahnPkMQzeicCFff5l55yNXR0HRGWzD5dJzpM5VnB00i41sPpf1v3fdDOwQ433vZglylEPbGkl1zO4ZU/jCtU5H/0XcrYwwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519953; c=relaxed/simple;
	bh=snI4yqGepDdWNnY0kbg2UNmoXx+IQh7u1C5ywqjd/MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4sG7cknx0x9P8mDMh6BLhhW7Vkfyd8qPlQwhaYZaBZnmIQLkEgZNhTnEpLJMLqVHI9ofgJprJsfhk7BnKpXuKqh3rSN/lWkrPo/9/huH+F6z6Tn0LsP6RnLUbypJ/UsmZiDQ/qeL1jVL/nVmndm+A1IUQEvXy3F2qsC9Xna6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QNjRTMBx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so1478621a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 04:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762519950; x=1763124750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1K/WGyrSvPxGdmHGTAm83AxLQquBqybYtMrmz64lWv4=;
        b=QNjRTMBx9T1Yw861AigEB7mgXG7Psqi/QMo+dMfXkN91Q5iYliuex0rGKMWT6rj7qL
         8bn8ptrpyQWiuGeDyJxQZCFw/EVUlIYCjWK/oi5QxpNtps6YAIKoZDKNgKrHYYjx5KXM
         +oPsZu9VRu6bgzD8v2oHwG/tH6QqH0xs3F/Km7gqEfAMuWX1zCftLp83nmw+3tAhdS9b
         Uu+uI049IB8dMHWkv+JYeJrpV7aiT73Z62y5RnftF9OOh5tFpeaKHfvVo6nD75cU/VWI
         iDE0psv82sm7u9EJk6UjVmVsMW4mZF+8HTa6b1s6uAEJKrydG3LA3bkvZbfCJKohlyiV
         YwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762519950; x=1763124750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K/WGyrSvPxGdmHGTAm83AxLQquBqybYtMrmz64lWv4=;
        b=Ju5LIVaXY1JK0XHx5t6PDnZWvIXsdgQy9awoM1Pcjkabyc8epywO/n+pi2THeei8k8
         gU0l/pNRWiI6SEyaEBP/QXp5Xp/zqbRfHbLBAIvrcxm1ECKjOQfHT0KTODb7G1xyJJUw
         56lZQ9AlgixSNhqMVuje/8PsXRd8TkBSxPCf3bry3An5NWzBPUs9NeaxvJogpZLviZ2A
         lCPKFC07CV5KeAGbv/eEfheGp25f/z+LR2e9BwKy5H8C0MyUhMlJY534e+BPqjpeUV/B
         zYzft1MLpC2iMl9BAnF/OBWFz615DoJiJS99jPMYNZAwooTAG7Mvq/g7NrCARUzph1oD
         5eXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRQAyjsD2J9/WDO7+48zED7a+Nd68MZXPMSKgIc5SzQyE60G1h5JciAgheM8tbbov717b9XmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWzwpAerngXnJTBKKr3Slydme4exwqFHhVxFLq+PCI4xS6XSX
	+kZ9Ml3JDQQKQH+8zuF4uU/XQqEqt0sahgH+V1IFhuNAF56pikyT9W2+9sblOp5bUrA=
X-Gm-Gg: ASbGncuSGFOUoLudkyT1fYF94khkrWW8yEYsohXSkS2DFLykBnSfr1f5rRFciEJeoah
	wm/ZVc2X2AI0HgYAJLf9U67jzM96wyWm3Z//FCgsB0wT4ZC6qfi5oqUy0HlqS2U2ZePlf7gCnYH
	LiAlg+9bAOLRmOmECvniHMhW5pXHao3/Tfy/V4gcdge4ZJRaoUWUZzo8aJ9VZrys9383o83iGCf
	1PvLkPknOiNqNKs5xnraWqB/H7WG/9HcZmaeRnvdbmhl+Z9mS8KnozXCLhytkkYMK4L1qE7fkBH
	EROFLwNM6qR2eaYbUCtRTVAFRqVx+LbEf2MP1GoTGzinxXZdeOTqEyST2p4BuK3MJXQnSgI6Ojb
	WtTW/HWq9ubXLvByk3pfv2UfrujLkaMYlPtzSfKrThrvP0vbE/d2bmqVyZMAJVy4F86AWaSN/eQ
	9RZXc1DhbK5AawQw==
X-Google-Smtp-Source: AGHT+IFRXKZs5/2DM3+3kiNXkbk52MOjdWuG5THbqAxP2FWnWGBNPVkzgPQQurODQzOo7kyJEIWPlg==
X-Received: by 2002:a05:6402:3551:b0:640:c779:909 with SMTP id 4fb4d7f45d1cf-6413f05a3demr3023096a12.27.1762519949785;
        Fri, 07 Nov 2025 04:52:29 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8142b9sm3988302a12.12.2025.11.07.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 04:52:29 -0800 (PST)
Date: Fri, 7 Nov 2025 13:52:27 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Junrui Luo <moonafterrain@outlook.com>,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, tiwai@suse.com,
	perex@perex.cz, linux-sound@vger.kernel.org, mchehab@kernel.org,
	awalls@md.metrocast.net, linux-media@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <aQ3riwUO_3v3UOvj@pathway.suse.cz>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
 <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
 <20251107091246.4e5900f4@pumpkin>
 <aQ29Zzajef81E2DZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ29Zzajef81E2DZ@smile.fi.intel.com>

On Fri 2025-11-07 11:35:35, Andy Shevchenko wrote:
> On Fri, Nov 07, 2025 at 09:12:46AM +0000, David Laight wrote:
> > On Thu, 6 Nov 2025 21:38:33 -0800
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> > > On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:
> 
> ...
> 
> > That is true for all the snprintf() functions.
> > 
> > > I wonder if we should instead implement a kasprintf() version of this
> > > which reallocs each time and then switch all the callers over to that.
> > 
> > That adds the cost of a malloc, and I, like kasprintf() probably ends up
> > doing all the work of snprintf twice.
> > 
> > I'd be tempted to avoid the strlen() by passing in the offset.
> > So (say):
> > #define scnprintf_at(buf, len, off, ...) \
> > 	scnprintf((buf) + off, (len) - off, __VA_ARGS__)

It does not handle correctly the situation when len < off.
Othersise, it looks good.

> > Then you can chain calls, eg:
> > 	off = scnprintf(buf, sizeof buf, ....);
> > 	off += scnprintf_at(buf, sizeof buf, off, ....);
> 
> I like this suggestion. Also note, that the original implementation works directly
> on static buffers.

I would prefer this as well. IMHO, it encourages people to write a better code.

Best Regards,
Petr

