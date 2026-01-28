Return-Path: <netdev+bounces-254110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBmWOMSleWlMyQEAu9opvQ
	(envelope-from <netdev+bounces-254110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 06:59:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 752A19D4D4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 06:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA4130265A2
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 05:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D3335549;
	Wed, 28 Jan 2026 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MjPRUXhk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F303164CD
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769579933; cv=none; b=JMNmCVosGmRCWTnjbJCx5QBnzL+raFd+kTADTH+09TH4yXG6nesawITeDBixYPq/1auff057b7h29oqV6dih316DYE7xcyyRPOKsYWBFGgFWGo24PVmerNj04UJG6XTU+yqXzH+hj1P1OMFNHmbyvgJk0II83mq3rCJgFZf+bs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769579933; c=relaxed/simple;
	bh=QESmk/KfQtFZmR06vIyAQHoiT9g2GHXkhFBsmqBICUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mANYX/erjaa1lyzrs1ZLGjXagUAEKxue05QMhwZtFwk127nUlUbXElgGVRiztvXcI4hM3DAoEs5c8eoQdsB7enlrvMYSVsFsRwhmwAcSQlVOprVMHoAgRz+VDIQsqijal5gh/+utSY+A/8i3i8c6npaFoTXf8OHb6MvcqeT3WPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MjPRUXhk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0834769f0so42643345ad.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 21:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769579931; x=1770184731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2A3gTla9Ka0dUTRcIrNBeWwULY766TH/z8gAf8M0Oo=;
        b=MjPRUXhk9t8pt3+rX0AUFRPSV2zhgshNPq+8sX47JVh7xVReWR8ic4j8iw1l6KVzAD
         Kd47WpRNtbyRy3HW2eYG2cT7LE+f8m0kMgqg9CgouI99T5GllXEkkHRO0HvRTjE6Aid2
         +c8tQDH8g6iI+6EqXns24qgJHY2Z3eYVASkGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769579931; x=1770184731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2A3gTla9Ka0dUTRcIrNBeWwULY766TH/z8gAf8M0Oo=;
        b=AjTsP682kB+Lell+EJFyK+6KUKCJjUrcmMJTBwLNEvvkXzbUpVUqNystouf+tEn0UG
         s6Fwp2roAt1DNcN7ebYxd/zUIcoyWHRQFXO/Y/lfPpvx02Uu74kXZVqd0LhI5fV0NQqx
         q1sHl9ptFNAgWG/46Bsx5By4NHqbfyXIfqKfDQ6wieeWoVzhRzfxf2Tpz1Nwn9WxFmAw
         m2YkFnAQSfpV6Cy+MYCI8U/1stdBYPmsQd+jpYWPJOfSrYmuj7bGbLRCETazGBWJaf3T
         k+iPS5QBJe9B3K9m5tWDAd5amTv/kUrGb2jvFoCmvkkOqlvBfQ6xZzrxIkpn+CgVqP74
         vtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdU655JHcH36cY60S9jBh3IaaTDRiUWx+1uCNQXF92JAIva1Bo+xyMu3jbHCGptTpTkM2Ezys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTxutPnvFSq8xFWc1FRInkMtvdPwkw8EJCJy2Jrgs94cb4abL
	txYBp/pHbZZZfq64De2C9RzEW6U8p7FEx2aOpGDMJyVC4Kbp7NkHsxPNW9rI7wALbDQ6GWDrCdZ
	lg40=
X-Gm-Gg: AZuq6aIeWT5hw5Qlyj4cTejg1TItJVBdW2ebuF8wmylR/n2z2npVQK0RaYEj8yJxWYB
	NCgWkUo/mupRAgzTY7ZZDeQdlO4hEJKg+dzAUiV3jFQxtYWBQ+usQfTr+qfzLKHo9IkJiPc8zU7
	oMtx1BBjCUf9vgoFBsT99AXff6WJgAQqZ7syXgwqHn4zn0zhx5/bfsiGMgDoCYcCsaf3Xjvk+3S
	SGI9EjxoxlopKp01XiJqDgTaTG5ExofePMI3UgNhsP360kw/t5XFksAM4RQ4Y3aq2m1DEKrzXiE
	fU3bPWQ1VlEAT40lpXv17ykI4HeyPPT8/rTP6LBXoUvnaIuwVP+azOjmmVmnApYh3cGDAWwD+/K
	a3olb8ZLVP9tmrfA/XqVl+CK41H4kMmDc2ueXJ341XKNEBDtUN1018varJGFVgFDFyvk/McdycP
	RJCXXMkwFa2tqyDYxdeO2XxcaK4ACfMtWF/aBvMMGK9gESoz7zPQ==
X-Received: by 2002:a17:902:ce0d:b0:2a7:d7b8:7661 with SMTP id d9443c01a7336-2a870d536c7mr36388135ad.4.1769579930804;
        Tue, 27 Jan 2026 21:58:50 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:bf24:413d:1e8a:6aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e75aasm11007485ad.92.2026.01.27.21.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 21:58:50 -0800 (PST)
Date: Wed, 28 Jan 2026 14:58:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Realtek linux nic maintainers <nic_swsd@realtek.com>, Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net: usb: r8152: resume-reset deadlock
Message-ID: <whsdw44eikzzbzgzobfxxnbt2yibsqbm6o2dhrgmrbvr5srmkr@ic5em5ck5mcz>
References: <a4pjgee3vncuqw5364ajocuipnfudkjnguwmmvjzz3ee3yjxzs@zxldhr5x7dkk>
 <13903eae-7a61-44d6-8e54-1d3f85799f58@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13903eae-7a61-44d6-8e54-1d3f85799f58@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254110-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 752A19D4D4
X-Rspamd-Action: no action

On (25/09/02 10:36), Paolo Abeni wrote:
> On 8/26/25 11:55 AM, Sergey Senozhatsky wrote:
> > I'm looking into the following deadlock
> > 
> > <4>[ 1596.492101] schedule_preempt_disabled+0x15/0x30
> > <4>[ 1596.492170] __mutex_lock_common+0x256/0x490
> > <4>[ 1596.492209] __mutex_lock_slowpath+0x18/0x30
> > <4>[ 1596.492249] __rtl8152_set_mac_address+0x80/0x1f0 [r8152 (HASH:ce6f 4)]
> > <4>[ 1596.492327] dev_set_mac_address+0x7d/0x150
> > <4>[ 1596.492395] rtl8152_post_reset+0x72/0x150 [r8152 (HASH:ce6f 4)]
> > <4>[ 1596.492438] usb_reset_device+0x1ce/0x220
> > <4>[ 1596.492507] rtl8152_resume+0x99/0xc0 [r8152 (HASH:ce6f 4)]
> > <4>[ 1596.492550] usb_resume_interface+0x3c/0xc0
> > <4>[ 1596.492619] usb_resume_both+0x104/0x150
> > <4>[ 1596.492657] ? usb_dev_suspend+0x20/0x20
> > <4>[ 1596.492725] usb_resume+0x22/0x110
> > <4>[ 1596.492763] ? usb_dev_suspend+0x20/0x20
> > <4>[ 1596.492800] dpm_run_callback+0x83/0x1d0
> > <4>[ 1596.492873] device_resume+0x35f/0x3d0
> > <4>[ 1596.492912] ? pm_verb+0xa0/0xa0
> > <4>[ 1596.492951] async_resume+0x1d/0x30
> > <4>[ 1596.493019] async_run_entry_fn+0x2b/0xd0
> > <4>[ 1596.493060] worker_thread+0x2ce/0xef0
> > <4>[ 1596.493101] ? cancel_delayed_work+0x2d0/0x2d0
> > <4>[ 1596.493170] kthread+0x16d/0x190
> > <4>[ 1596.493209] ? cancel_delayed_work+0x2d0/0x2d0
> > <4>[ 1596.493247] ? kthread_associate_blkcg+0x80/0x80
> > <4>[ 1596.493316] ret_from_fork+0x1f/0x30
> > 
> > rtl8152_resume() seems to be tricky, because it's under tp->control
> > mutex, when it can see RTL8152_INACCESSIBLE and initiate a full
> > device reset via usb_reset_device(), which eventually re-enters rtl8152,
> > at which point it calls __rtl8152_set_mac_address() and deadlocks on
> > tp->control (I assume) mutex.
> 
> Decoding the above stack trace will tell for sure.

Apologies for the delay, somehow this slipped through.

> > __rtl8152_set_mac_address() has in_resume flag (added by Takashi in
> > 776ac63a986d), which is set only in "reset_resume" case, wheres what
> > we have is "resume_reset".  Moreover in_resume flag is not for tp->control
> > mutex, as far as I can tell, but for PM lock.  When we set_mac_address
> > from resume_reset, we lose in_resume flat, so not only we deadlock on
> > tp->control mutex, but also we may (I guess) deadlock on the PM lock.
> > 
> > Also, we still call rtl8152_resume() even in reset_resume, which I
> > assume still can end up resetting device and hence in set_mac_address()
> > in non-in_resume mode, potentially triggering the same deadlock that
> > Takashi fixed.  Well, unless I'm missing something.
> > 
> > So I don't think I want to add another flag to mark "current owns tp->control
> > mutex" so that we can handle re-entry.  How about moving usb reset
> > outside of tp->control scope?  Is there any harm in doing that?
> 
> According to commit 4933b066fefbee4f1d2d708de53c4ab7f09026ad, the
> usb_reset_device() call is intentionally under tp->control protection to
> vs double reset.
> 
> At very least the proposed code here could end-up causing an unexpected
> reset when SELECTIVE_SUSPEND is set.
> 
> I *guess* you should track the current status explicitly to restrict the
> reset at in the !test_bit(SELECTIVE_SUSPEND) scenario and explicitly
> avoid delayed reset during resume.

Something like this?

---

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 30f937527cd2..0a570b8ac7dd 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8542,14 +8542,9 @@ static int rtl8152_system_resume(struct r8152 *tp)
 	 * reset. This is important because the usb_lock_device_for_reset()
 	 * that happens as a result of usb_queue_reset_device() will silently
 	 * fail if the device was suspended or if too much time passed.
-	 *
-	 * NOTE: The device is locked here so we can directly do the reset.
-	 * We don't need usb_lock_device_for_reset() because that's just a
-	 * wrapper over device_lock() and device_resume() (which calls us)
-	 * does that for us.
 	 */
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-		usb_reset_device(tp->udev);
+		return -ENODEV;
 
 	return 0;
 }
@@ -8674,6 +8669,14 @@ static int rtl8152_resume(struct usb_interface *intf)
 
 	mutex_unlock(&tp->control);
 
+	/*
+	 * This only happens for !SELECTIVE_SUSPEND and RTL8152_INACCESSIBLE,
+	 * drop tp->control, because reset path can re-acquire it (e.g. for
+	 * MAC address/policy update).
+	 */
+	if (ret == -ENODEV)
+		ret = usb_reset_device(tp->udev);
+
 	return ret;
 }

---

> Ad very least you should add a fixes tag, a proper Sob and use canonical
> commit references.

Well, sure, when we have a fix that we agree on I'll submit it properly.

