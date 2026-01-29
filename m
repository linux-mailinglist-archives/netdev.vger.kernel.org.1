Return-Path: <netdev+bounces-254523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFG+HcnOemnU+gEAu9opvQ
	(envelope-from <netdev+bounces-254523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:06:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C91AB51B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 078593011771
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D9435771C;
	Thu, 29 Jan 2026 03:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oGsiqsNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC54B261388
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656003; cv=none; b=G3zbdS4S2ukEn3DYRp0VKUonoC7mLkn/pe5RPJ3RrsKPZlN0TWJLzhhC8VhLGBv0IM0ZtMZF8LSGq+sZS23qLJm5vuirmOu6jmrsADdIHwXm0qouNatsmoiQEUjoHaYv5iXPWHYQ3kPTXkhall3SZhebPRYlYRtIBms5Ab5XDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656003; c=relaxed/simple;
	bh=ClUrFSgjVxReMKfJCaSgfHbEWaq6moGz2Q597pro6uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0n5hk21vunLnrTwRZcuRpPEQ26Rk5MB4LKuXSIqw5bcGLjC1VtfRv41hdnrS8WXYPln/VflCU1ruBUDV8XsCkyCMwiAdFQwptjw6b3OC5dgCtzjEJEVSufe4rIRQ3X+bk97qAEPL3dTLPpyoa5IWECGZpVJOoFkHE4fuyDkBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oGsiqsNB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a12ebe4b74so5333425ad.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 19:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769655998; x=1770260798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66Nk3W8pAT4A9JWYxPUFkCtlkAoYwkhLBGEM5Ej1VxE=;
        b=oGsiqsNB3Ffyn+BEVSkglixvuugAgU1Xla6BOG2nXskoBh+Sterk9yHffrkp3BK2Oz
         L7wdkAodnEhCWz/1a+DIdNWD9H2kcQ9z6kqfPM1M/EO4b049g/kEVZmG7hg61259vZFr
         qC4b3BzeKVX3dfQDEcR/vPQ5x+bPOME5v9pYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769655998; x=1770260798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66Nk3W8pAT4A9JWYxPUFkCtlkAoYwkhLBGEM5Ej1VxE=;
        b=wmHutenDosODBSUPdVNI4Q0KQXE5R6NLlkdb8FY5LRqL+1tfH9+rauehp7hUZFvuPM
         dnPAUSLxyJnvp9Jfs4BzUrzMBiNQ4acjhr19wL+5y1vApSIsO5IeJsuHs0co0gKsV/bU
         Z6fsOKY3tVk4kV1+DPFnNeZJoqFmVBTcoGnTBI6CqRKlsVKkUnqd2nc5ysrAtig3kC//
         Twjos2BXqQTuu6SRITO2Op95vZqdRydNDv8ac5esSIf+mZnpUMcowex2dL2IJdMaJxF/
         0ydYW4vcEOhu/Bx7HM0b/OtxiFvZay3LWlDFUbXI9ACDTMbvOo9K56Ypf1ns4FrAIjuU
         3VZw==
X-Forwarded-Encrypted: i=1; AJvYcCXWmTAU0QFCgbQAO9HmE/412A3bSnC/+cB7WsBau3MDMcZas7Jq3pV1d6vf9L0CumXCm3OhPHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxncKG9gevqH7/VzssMEOdvco9T21x/Lnix6vMQvE0FENDtY8Qx
	8CJ327XbIKo2j7oTt6Uzm2kWcdD44M2vmGLI9GBpXI7QJL5Wh+8Nk+d45enXP9jfkQ==
X-Gm-Gg: AZuq6aJg+C0SuVS/muXqD8RW0PjfmE0TMEuICvK4SxIgYy1AOIqglbWNS/ecnl1QsPe
	upKE/1A8ZOgmBMb8P2YHzmvyM+IUOprZQbi1vvTXcE4im3VKschsqNtQQbRKSsnEOvHGFHC9oYu
	4Fp4KFpxVJ/74irsq/a7TXJlxsis2s9Gi9CJdKd17Tqbn4S7x2L8110wPFswTJ/YwC9pBxbKocq
	sdAPIkAllMleFQRRXGjOrIM1v1KQoUxf968N4mhbwEnxzeQKUleI16VWKc4HoqvTKeLsrpJNYPS
	TqjOihleLLNRl/ZZlvM1FP1Xn0csHbgGzJtbYhC3bqFXOiZVmg6cldXf4dcbw2vYowAnDfR8CmU
	Sn0OcMZ6YBbsDnuyZSiRiR+AK7YX/o90fcu5J6s8X6fES5nn5f2uEHpfFEncfIUtuKaMzwplwwm
	QqLMGW6MOnSfX8xgPUE63MP2carA3sIdefBTq/lDBrVePKGUx6TQ==
X-Received: by 2002:a17:903:2f87:b0:299:bda7:ae3c with SMTP id d9443c01a7336-2a870da0e2fmr68388235ad.14.1769655998304;
        Wed, 28 Jan 2026 19:06:38 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:356d:f98:467f:7e27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22672sm3742764b3a.51.2026.01.28.19.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 19:06:37 -0800 (PST)
Date: Thu, 29 Jan 2026 12:06:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Tomasz Figa <tfiga@chromium.org>, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	George-Daniel Matei <danielgeorgem@chromium.org>
Subject: Re: [PATCH] net: usb: r8152: fix resume reset deadlock
Message-ID: <hexlvtc7l26jvnr7zfl52i7hynnyxkqu7ebzyijw4ucql6irvz@cb222yvs7ikz>
References: <20260128070222.3393746-1-senozhatsky@chromium.org>
 <CAD=FV=WLj0fG6CqN2GwK5DntaRwQP1K4Sm-b-uwtON=-ByJfcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WLj0fG6CqN2GwK5DntaRwQP1K4Sm-b-uwtON=-ByJfcQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254523-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6C91AB51B
X-Rspamd-Action: no action

Hi Doug,

On (26/01/28 10:05), Doug Anderson wrote:
> > rtl8152 can trigger device reset during reset which
> > potentially can result in a deadlock:
> >
> >  **** DPM device timeout after 10 seconds; 15 seconds until panic ****
> >  Call Trace:
> >  <TASK>
> >  schedule+0x483/0x1370
> >  schedule_preempt_disabled+0x15/0x30
> >  __mutex_lock_common+0x1fd/0x470
> >  __rtl8152_set_mac_address+0x80/0x1f0
> >  dev_set_mac_address+0x7f/0x150
> >  rtl8152_post_reset+0x72/0x150
> >  usb_reset_device+0x1d0/0x220
> >  rtl8152_resume+0x99/0xc0
> >  usb_resume_interface+0x3e/0xc0
> >  usb_resume_both+0x104/0x150
> >  usb_resume+0x22/0x110
> >
> > The problem is that rtl8152 resume calls reset under
> > tp->control mutex while reset basically re-enters rtl8152
> > and attempts to acquire the same tp->control lock once
> > again.
> >
> > Reset INACCESSIBLE device outside of tp->control mutex
> > scope to avoid recursive mutex_lock() deadlock.
> >
> > Fixes: 4933b066fefb ("r8152: If inaccessible at resume time, issue a reset")
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/net/usb/r8152.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> This is effectively v2 of:
> 
> https://lore.kernel.org/r/20241018141337.316807-1-danielgeorgem@chromium.org/
> 
> ...and you've incorporated my feedback there. Thanks! :-)

Oh, nice :)

> > @@ -8674,6 +8662,19 @@ static int rtl8152_resume(struct usb_interface *intf)
> >
> >         mutex_unlock(&tp->control);
> >
> > +       /* If the device is RTL8152_INACCESSIBLE here then we should do a
> > +        * reset. This is important because the usb_lock_device_for_reset()
> > +        * that happens as a result of usb_queue_reset_device() will silently
> > +        * fail if the device was suspended or if too much time passed.
> > +        *
> > +        * NOTE: The device is locked here so we can directly do the reset.
> > +        * We don't need usb_lock_device_for_reset() because that's just a
> > +        * wrapper over device_lock() and device_resume() (which calls us)
> > +        * does that for us.
> > +        */
> > +       if (system_resume && test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > +               ret = usb_reset_device(tp->udev);
> > +
> >         return ret;
> 
> Question when looking at the above again: have you thought about the
> consequences of clobbering `ret` above? I guess it's fine since
> rtl8152_system_resume() always returns 0, but it looks a little
> awkward. It's been long enough since I thought through all this code
> that I'm not 100% sure what it _should_ do if rtl8152_system_resume()
> was ever changed to return an error. Shouldn't it honor the existing
> error instead of trying to reset the device and clearing the error?

Right... so that "ret" thing, I thought about it and at the end I
just decided that returning an actual device reset error from resume
is still better than "return 0 but device is inaccessible" ("mission
failed successfully" kind of a thing).  I'm not entirely sure what
would be the best way to handle this.  Like you said, for the time
being, rtl8152_system_resume() always returns 0.  Do we expect this
to change in the future?  Probably not.  On the other hand if
RTL8152_INACCESSIBLE bit is not cleared then user-space will
figure it out eventually (ioctl calls will fail, etc).  So maybe I
can just keep the existing code and ignore usb_reset_device() return
value.

> Also: I guess you've added the `system_resume` variable here, which is
> different than the earlier patch. It seems fine to me, though maybe
> you want to consistently use the `system_resume` variable earlier in
> the function too?

Sounds good!

> In any case, both of the above are pretty nitty, so I'm OK with:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!

