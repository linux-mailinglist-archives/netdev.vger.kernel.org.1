Return-Path: <netdev+bounces-147989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B49DFBD1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 09:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B24B20A49
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7771F9AAD;
	Mon,  2 Dec 2024 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Ez2hoGti"
X-Original-To: netdev@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0971F943D
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127864; cv=none; b=IbRmSdUVuvpa+7LQzJkSu7zwIor+CG8s8Xv/uvhj4FPLI7LKOGB7lmxRGj614r2VLdQOn2SZChXDzYJUcls5Ng4ZRkId4CALscwfaEIBjLvX972f9cYYCA7PNrJdoubsmmmrAChb9QGNppwcryMJu4Oib0NVmCp4a6lepIH8vAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127864; c=relaxed/simple;
	bh=/ZHSv0vZid3O406LMuPtfLpuD5C4UcF09GoLOSYaEhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbURdiFdTGXCZOLtPlAbdxgY8h5iQ8uIeXEup4xd//WeRbeXGkC/ZDqtzoJ2W+RyH781T5225/7zt29/Qt14OacPq3MKEcSfJPiPBxr0Dtai1VyJDbC8vWT+ERyEdX4W6GoYxI0p3YB6JBt22Uik1NKBcXdtU+KXgK+kfwPUlWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Ez2hoGti; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=Ez2hoGti;
	dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 047EB9C7
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 17:24:22 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2156fcd6d8dso12142705ad.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 00:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1733127861; x=1733732661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/h3ksscezU2AFx7jalcVKwx+o7bQGfGeG3iipVTlMA=;
        b=Ez2hoGtivPU06UYAm/IRVXG3fw9ZU68MDrMiRy4+DOHS5nyHOtTj/bzBcKo0VP7GD3
         xv3dv5V4ryO/d+zwTYtMw8ffKetVi9oiH9axQ5zJ7gH2xh6PHJNexwJ6NB7o7Sk6iP09
         KGqwT033IT58t5iY8q2xHuFxyoC94YblHOsrBU8aTrNVbzq1vCwFI0sAgIaQoQ4YgOIj
         WSRanzviSEqkL1PzC30QX70uK7xtHSyevDvT8N5iRIXZjmFPR06ew2E4I2yl74BMt2rv
         Jr3bWXrqnISUQU5+wxG6ZYo5kq+1dIe079Xi2+0Uy8+RUIqKSrBzmwrUrybEkaWxRLMO
         x7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127861; x=1733732661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/h3ksscezU2AFx7jalcVKwx+o7bQGfGeG3iipVTlMA=;
        b=AN819ZN//rK8VU20j375c2LQkiVCccysdS/SDB6J7+ompUT7/os5H7d3ATpK4cGdlD
         pPCLmuQjhdZAKLljbcbCvKAvRFRKSxSewpUznmN3Ii3uMpOVjoLLq954JJ6nJMfBnyuI
         hONkFvhcixoYIj/8rB6OeTE2Pz/xBkDjXceRaNpRMFbiFWrsbBKDk/Bt9MpZaSYUQmNe
         stxl63jh4mwGi1X6sZjEeoxxzWXIENB/FNeG3aUIaJjRjGdfQZMfeEThbvrUub611Wwt
         ZPl2RmW1o/hNFJ0LhiwZEByXmBzMvDlHD/4cltSzn4qaWevyk4RPxKz15xQB2wuvKMzO
         jcUA==
X-Forwarded-Encrypted: i=1; AJvYcCUZdfVbUv7pSBYA04RCK3BmmFUMmeZ/1ifDwE1YwPqp5HrTXkOkndx+WuO4bXo9Oku7Y54Yav4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQrBlLTdX5kOHtV64QdHmk6XIFmpDhjlJ8Yw+huziUcMJ8HfS
	yV09u5HMnNjny0Q7QKig8bcD5G+RCeO+GX5FaQoauP6Lk5dhctj/YPS1w1ziRA7bL8TxXITYcPa
	Llje/2YN5Bxs4Bv6J2nOeflIMPkyPRYuSonZQydqh9QJ2pZSqE62bQBA=
X-Gm-Gg: ASbGncuw1XnWtBo8GqZkIB+i/i4WzaCEnD8HGjdXz5WCbe1uCPPsVpJ2OynVXo4W/9p
	enMx7osBUmvSgZhBLwcmtY4U50B3jx4f+OJvxYFGpD2l1S61IszWsFJK50PQA8VW3adYxd5/hxt
	aFofVGCA/+yY/ob8BvFK3C32uHZXhLMXDkGW9FLxfSe4ZpJ6PcH/O8eD/LmR3sDPUuqCAl6bw7C
	8dEOqdWakTySj86vPgTuh11D1IWYRsuLnH7mPMlMNB0adfDXD3C0ob9B6aZX5jNXqRa3HTKvN5+
	BE5rY1/iGb1LV8NIi9w2zfAlzPFDLNc=
X-Received: by 2002:a17:902:f64f:b0:20c:a0a5:a181 with SMTP id d9443c01a7336-21501381b6fmr305187355ad.19.1733127861003;
        Mon, 02 Dec 2024 00:24:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF67NsKV2/CWe50pDLshUkUs6WDDf2ByoBORdWZB1Kq2UVOK27KewyrPjxmWntBKQjczEsiyA==
X-Received: by 2002:a17:902:f64f:b0:20c:a0a5:a181 with SMTP id d9443c01a7336-21501381b6fmr305186825ad.19.1733127859875;
        Mon, 02 Dec 2024 00:24:19 -0800 (PST)
Received: from localhost (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21584fbbb9esm19347595ad.153.2024.12.02.00.24.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2024 00:24:19 -0800 (PST)
Date: Mon, 2 Dec 2024 17:24:08 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Greg Thelen <gthelen@google.com>,
	John Sperbeck <jsperbeck@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <Z01uqI7hUNyCGFcw@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
 <Z00udyMgW6XnAw6h@atmark-techno.com>
 <2024120259-diaphragm-unspoken-5fe0@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024120259-diaphragm-unspoken-5fe0@gregkh>

Greg Kroah-Hartman wrote on Mon, Dec 02, 2024 at 07:29:52AM +0100:
> On Mon, Dec 02, 2024 at 12:50:15PM +0900, Dominique MARTINET wrote:
> > So we hit the exact inverse problem with this patch: our device ships an
> > LTE modem which exposes a cdc-ethernet interface that had always been
> > named usb0, and with this patch it started being named eth1, breaking
> > too many hardcoded things expecting the name to be usb0 and making our
> > devices unable to connect to the internet after updating the kernel.
> > 
> > 
> > Long term we'll probably add an udev rule or something to make the name
> > explicit in userspace and not risk this happening again, but perhaps
> > there's a better way to keep the old behavior?
> > 
> > (In particular this hit all stable kernels last month so I'm sure we
> > won't be the only ones getting annoyed with this... Perhaps reverting
> > both patches for stable branches might make sense if no better way
> > forward is found -- I've added stable@ in cc for heads up/opinions)
> 
> Device names have NEVER been stable.  They move around and can change on
> every boot, let alone almost always changing between kernel versions.
> That's why we created udev, to solve this issue.

Yes, I agree and we will add an udev rule to enforce the name for later
updates (I really am just a messenger here as "the kernel guy", after
having been asked why did this change), and I have no problem with this
behavior changing on master whatever the direction this takes
(... assuming the check was written as intended)

Now you're saying this I guess the main reason we were affected is that
alpine never made the "stable network interface name" systemd-udev
switch, so for most people that interface will just be named
enx028072781510 anyway and most people will probably not notice this...
(But then again these don't use the "new" name either, so they just
don't care)


With that said, and while I agree the names can change, I still think
there's some hierarchy here -- the X part of ethX/usbX can change on
every boot and I have zero problem with that, but I wouldn't expect the
"type" part to change so easily, and I would have assume stable kernels
would want to at least try to preserve these unless there is a good
reason not to.
The two commits here (8a7d12d674ac ("net: usb: usbnet: fix name
regression") and bab8eb0dd4cb ("usbnet: modern method to get random
MAC") before it) are just cleanup I see no problem reverting them for
stable kernels if they cause any sort of issue, regardless of how
userspace "should" work.


> But how is changing the MAC address changing the device naming here?
> How are they linked to suddenly causing the names to switch around?

That's also something I'd like to understand :)

Apparently, usbnet had a rule that said that if a device is ethernet,
and either (it's not point-to-point) or (mac[0] & 0x2 == 0) then we
would rename it to ethX instad of the usbX name.

commit 8a7d12d674ac ("net: usb: usbnet: fix name regression") made it so
the last part of the check would rename it to ethX if the mac has been
set by any driver, so my understanding is that all drivers that used to
set the mac to something that avoided the 0x2 would now get renamed?...
But as you can see above from the stable device name I gave, the mac
address does start with 02, so I don't understand why it hadn't been
renamed before or what this rules mean and why it's here...?

The commit message mentions commit bab8eb0dd4cb ("usbnet: modern method
to get random MAC") which changed the timing usbnet would set a random
mac, but in my case the mac does come from the hardware (it's stable
across reboots), so I guess I wasn't affected by that commit but the new
one trying to make it better for people with a random mac made it worse
for my case?


Anyway, as said above we'll try to figure something for udev, and this
will hopefully be a heads up for anyone else falling here doing a web
search.
(Our users are rather adverse to changes so I don't see myself enabling
static interface names anytime soon, but time will tell how that turns
out...)

Cheers,
-- 
Dominique

