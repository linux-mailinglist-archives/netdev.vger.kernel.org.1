Return-Path: <netdev+bounces-69942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAEE84D1CA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107411F2773A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB76127B52;
	Wed,  7 Feb 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="w5XqJT7s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1C127B65
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331822; cv=none; b=oCLRXge+mfcxQAh7pdMm63b3xSFPynhIBBV23KTjwLjtcLEsPE5Qcg5xFbuh7vjlwGY0G3HYKvhlIcU+64G/MNcCJu1g3e3Nx730Poyk61wDDcSXrRL++yiDOE7kWdHnLrJXR18DFY1HtCuDUHvIowbuJ0LEa3IkayZvRVt1QDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331822; c=relaxed/simple;
	bh=FHpj/xXyQLYjyor2xeXAMKuWhBGCAUI46q76hCBjf4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioSsedbv7QkiSNxVlvo8h54UQX3jd5q807IxCc1jK6vtumhxyESfK2zaDB4Hgnqq9h5FjdkD84nwKmrm32ly8j5ktaLn+Fb7HZbwlpQq7b7WiBFGUWb9VYeAr5j/aRWCWA9hZc/gDTTuhed5aVR+V/i3bIze4kHz27ct+PABcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=w5XqJT7s; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so686406a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 10:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707331819; x=1707936619; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQf4+IgLEkSw22mx7uyDkWbJAHHHB9UuyZ0jbaQX1VQ=;
        b=w5XqJT7suxBW6Q6QnZ/SQgRGMZ3g1jqfYNtQR9l75F2Ii1ziWHIJTYedhArdnPnNjY
         eASfq0rVeodWARrPeDxYGtg7lAtJ+KPZa4qLPe5pXGQ61wXM1tsC/y0+eyQHSyEXXkca
         oR32mLE9wTkv+87POJr4snks3FV/CNEPjHBr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331819; x=1707936619;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQf4+IgLEkSw22mx7uyDkWbJAHHHB9UuyZ0jbaQX1VQ=;
        b=Gaxn/eTs1j3mOr1kdylEp841L0jHl753jVQgP62u6VNQYL5gBGz6fP/XORme028mcl
         jmdmCNUZyQYoPA17cVT8AmupVo3PvQZhdo/cZ9+6NlqOSavby6Lf7pNX9Q2eTThKOqI5
         oQx09LPXrLtJMnBMWeApvZdoGFWsrOrsZNwi6vNR+mO2jgrwV5VruMVAhfPOYaU00uB1
         A/6BQynLk6t2C1stNXpxO+YV/tarFK2HpEQcVSes1KMhsxM2MBZt3pNR1R6t8CtiDOoq
         OUfs53/xhn1yooJ1rl1ZpZtWre0NpaJ7DAwSGNpdvX3eHn9ycbX8LZ9zmkAMFjTw6Tnn
         8qTg==
X-Forwarded-Encrypted: i=1; AJvYcCXX6A4q/XI9pzE2TSvoJll3L9/Fq4aLmNm1dYPEztjokhO02A5Stnhc8G+eJBYTPwKZerLOjylOziuv8lrJa7+ESYgb9LWN
X-Gm-Message-State: AOJu0YzdMd5KgyWdBIR9GHMmoXTR27jGbTZgw1LBlybuglv8+i+1UJEe
	6RXC9VX+hOjnKz7FoHBsc8HPhVkSHGKVv9nvPAlHIHCFJiy50nGDMtry0CSQKao=
X-Google-Smtp-Source: AGHT+IGQvVbGz3QeVBRU8HV3lCSe/k/gC1Nc5AYsNKsNaVbI7gyDoJvv5HG9mp3ZWoAk6Hf1n3N7rw==
X-Received: by 2002:a05:6a20:9591:b0:19e:9a7b:230f with SMTP id iu17-20020a056a20959100b0019e9a7b230fmr6248711pzb.9.1707331819370;
        Wed, 07 Feb 2024 10:50:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXP5D3VQWJvH341gnT+Kd3ij2X9pcq/8IUse138FBGQNGJccLxkgLD2TM0AwzoBb01V4wXRQ8fbHgtULuINUB8Y/cxELr2RSGSBAfKAZfN99uFvTQqVcbq5W+r3G9y0oxGFzQHz3WmqevKYI0h74KkSnxYmWDJInDxxkZeg01gg3CWEMX7GL5+xicM7k+NiIWMjIDPki4i6jgA2IVfimCAUhjQA9hBk2OnHOdnwsDfATSSaJNQnShizjcz4DihQpkWrNx1mJQ/wJtOUQTuhsO1CYiKH3aWhIFSY4NjQgS3JsZOJRrF7oc77+3HWOj5IwxH8WIndAFjJltCJCvcGVmhUxc0GRHJhsNL69SXnkdTcGBzKaKMJ553KmuMPlExje1oaOGFgeoQFVNWBeGi1+FLloGZOCiVE4kauNft3oQkvt6UtwdLaAZ5+r9O9sXsMenW7fGapT7YsARoOOper3smD/bP9+/jSDJhi6MNM7Eu3/JpdoDEI4PYJoNG/T1PKGqKhZfLjs9gLHFlwp+m2CA308c+PRY27XP84589ZCbCOXkkOxPpkiluPBOgwaQYXuZHzKoUQWlef+RdIdxwsqaMihyTrqo7PhAE2fNUJIsyVKN9F32xz7CuIr8k2X0Qy3khgNWXxSLTRfmgSTge8+X9ciH/6kwccaXB5Q01DSY6TMZwYi7qqeoj9ix0tJkO9mndOpMnhJUK0aihqQtMlJF775VydIHgryimfw3GCDCMyK1Wct1PEURkvYuqkjiLjLeinlWbbAtcyY/TEo/iHKkDWxe9ZGKxbcdxHiZHq4YojB3hIrOfZ0JVD1qrEgsx88SgnFKCYV2vu6zOehvnElqSRwCtWNZahQk8eOeRrF+z67tHlUaqeFmfp8nP5fchWpXMhNVHls813y7ChVBbKYPjLlUdOpmoZTLSpwcL3sd/oi5xiEs+z2sgY724v47/Qp6uHGM
 X/7KGpggItlob7VfLZi8g=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id cb11-20020a056a02070b00b005d7b18bb7e2sm1766169pgb.45.2024.02.07.10.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 10:50:19 -0800 (PST)
Date: Wed, 7 Feb 2024 10:50:15 -0800
From: Joe Damato <jdamato@fastly.com>
To: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	David.Laight@ACULAB.COM, arnd@arndb.de, sdf@google.com,
	amritha.nambiar@intel.com, Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 4/4] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240207185014.GA1221@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
 <20240205210453.11301-5-jdamato@fastly.com>
 <ec9791cf-d0a2-4d75-a7d6-00bcab92e823@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec9791cf-d0a2-4d75-a7d6-00bcab92e823@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 07, 2024 at 09:37:14AM +0100, Jiri Slaby wrote:
> On 05. 02. 24, 22:04, Joe Damato wrote:
> >Add an ioctl for getting and setting epoll_params. User programs can use
> >this ioctl to get and set the busy poll usec time, packet budget, and
> >prefer busy poll params for a specific epoll context.
> >
> >Parameters are limited:
> >   - busy_poll_usecs is limited to <= u32_max
> >   - busy_poll_budget is limited to <= NAPI_POLL_WEIGHT by unprivileged
> >     users (!capable(CAP_NET_ADMIN))
> >   - prefer_busy_poll must be 0 or 1
> >   - __pad must be 0
> >
> >Signed-off-by: Joe Damato <jdamato@fastly.com>
> ...
> >--- a/fs/eventpoll.c
> >+++ b/fs/eventpoll.c
> ...
> >@@ -497,6 +498,50 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
> >  	ep->napi_id = napi_id;
> >  }
> >+static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
> >+				  unsigned long arg)
> >+{
> >+	struct eventpoll *ep;
> >+	struct epoll_params epoll_params;
> >+	void __user *uarg = (void __user *) arg;
> >+
> >+	ep = file->private_data;
> 
> This might have been on the ep declaration line.
> 
> >+	switch (cmd) {
> >+	case EPIOCSPARAMS:
> >+		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
> >+			return -EFAULT;
> >+
> >+		if (memchr_inv(epoll_params.__pad, 0, sizeof(epoll_params.__pad)))
> >+			return -EINVAL;
> >+
> >+		if (epoll_params.busy_poll_usecs > U32_MAX)
> >+			return -EINVAL;
> >+
> >+		if (epoll_params.prefer_busy_poll > 1)
> >+			return -EINVAL;
> >+
> >+		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT &&
> >+		    !capable(CAP_NET_ADMIN))
> >+			return -EPERM;
> >+
> >+		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
> >+		ep->busy_poll_budget = epoll_params.busy_poll_budget;
> >+		ep->prefer_busy_poll = !!epoll_params.prefer_busy_poll;
> 
> This !! is unnecessary. Nonzero values shall be "converted" to true.
> 
> But FWIW, the above is nothing which should be blocking, so:
"> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

netdev maintainers: Jiri marked this with Reviewed-by, but was this review
what caused "Changes Requested" to be the status set for this patch set in
patchwork?

If needed, I'll send a v7 with the changes Jiri suggested and add the
"Reviewed-by" since the changes are cosmetic, but I wanted to make sure
this was the reason.

Thanks.

