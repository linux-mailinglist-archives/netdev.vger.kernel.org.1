Return-Path: <netdev+bounces-231347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC02BF7B2A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71C819A07B7
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDA236CDFB;
	Tue, 21 Oct 2025 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="b0xoYG70"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528A36CE02
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064409; cv=none; b=uSNkQfft6UzJ1bdIrP06tJUsB1ZOzya6xjZWsZAqTQv3OrKQNLiHK3uMvYBGGd0jJpC+g1nDRIyrohp2uaLdWR9n5z+p+xA375y1KRxrs83WjNh+RbbAYJt1DXVrveIxmqwO28FEKwTchiBBDSlyNHyGv1jdUVaAYtwgIUj+5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064409; c=relaxed/simple;
	bh=T9YJW5Af6Wu8Thi641lfBrgTNRitbuARTbWNlDEuZXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQzLpVBEuPmugi0kCFuxAdcsLvnVue85Ru7GcXiQO1QY7eP88svw+/D3FPPbFJ2yncDmYP1WY1X/bFa6ksUbOfizdf5a0AotaeFDQr0zchrfpSujYkJqFACw18OrF/VF1sMfeGBcmu3jZfQhzQbMXeCIHjFYwPUIzBpy64agQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=b0xoYG70; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8909f01bd00so665029785a.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1761064405; x=1761669205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhM5Ucb9GGTBQBujjUUdnw6A2KYdnpoz02Fzu1niTBA=;
        b=b0xoYG70gOybakpKGQK3EAxkXuRtOsieJak1ajcVl6elOC7VFVQC0NDgL8TuIb4HKu
         ziuT3Bi5sG6qpfm85fChUj/oNBYNB5pjWvmSuC0xToUz691e6eJcpr4b5FrWwngY2B+X
         vJ8D7SybN9eD3Uy/1ryrTFlza6jiexp54vi4Fng9tfUtZrfmHHLh20nkN1NKBMOLFJ7F
         x5hzYZDbBh+m1JflfvhjEz8oim/aI+xYic6mbHGGBLhsN9RejdN4SzCwST8qoM7ElJHw
         cWubfVFk3KDyyDwUP4oEHa3iUghhDeyeMw/AOWwOkRN4Ukl8yAnQKCNAHBoKiWIZJidg
         Yyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761064405; x=1761669205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhM5Ucb9GGTBQBujjUUdnw6A2KYdnpoz02Fzu1niTBA=;
        b=Knc+9yyVhTCseSk3XMa3yEBmTIl0NhdRBzEIUqCFximsyk4KcrTkKLN6H64co1PlAp
         8Yjx4vY56TzTDlAKh09nP3q2HtVg9yt2PreC7MjNVBkH4QqP2sSXrpzEKHbAWwGEE1co
         cIo6f1OFCGpd8AkkIAXtT9pwkkdAu0hIt4iBroaEeUxlzAIIxcmEavHvvksNUifw+S7L
         fbGkBF2zqwPyn1C6I3ut75IwPcIv6XXboQkakjSj1nri7Us4XuQE+Hp7o5owE6dQ5Dha
         H11gsbOFyGJNkmdCKmXiBBl1ajgb7TAOlUds+q55EgZb5dzkzKTkkGwlpLEO0CKkCk7w
         USiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtJa8EBupPavAbaA802Fprme9XuT4WOZIILSeZH3BoeCdre1jaormx5GfEBA9VFGucwEmWPio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPn7VXwfJR1kB1tGjBCrRYo5Enkk0EfgnIM6YAUwCfUbB+rdzA
	mijAWMMZMwSLBLAjIOW7pGyeFHV79Jcc14AQZm0IpuDV4f3zj3c1FptReCNmW3xDWQ==
X-Gm-Gg: ASbGncsOCKN1wiSzj+Txb5aiBeFkVALh35aOaVAwcFfwcgMP3fTZMDUiTv/p3AsvLx+
	3sd0oyvRUtED0ExuP7rJM5I2hTOvf8Y4tMs/FiW9hQaFsRTI3nErWKeTtKrElN1NzGJgDyenZrm
	h4ddwhpF+A6HuLUWItP5+/D0G+6qXKnXG8Qd485pF2PeR2Npf5cSboMMtF/cMWh92NUh0BKBDzB
	2nIjq2eG4lqrsfbj8qPepr8ugh9lTgKs7dnp4U3sPu+4kgzFGaVdpP04Ylrc6ryvdee2WGJPi7y
	TpJDMLXJnnf50TRZKqIgZjkX1toEDTf5i0JvZ+SdzMyJhRVFQXy2CTM2M88AYoadoOL9HC+sH61
	PKZa2ZwpWt0mkRyItNibnOB4y2n26COhLlM3EkUuUerW4comWZqswFCvrFSbI9vVhew7vIVpNco
	v9OozESJszDr70
X-Google-Smtp-Source: AGHT+IGME+QR/xNkuNUNTrrBSsXlbHU4QeRMMdVuluvan2L9NrgTJB4OLvdr6uS3jhON+ZwDAun3KQ==
X-Received: by 2002:a05:620a:2586:b0:844:c04c:6a9f with SMTP id af79cd13be357-89070603bf9mr1910302885a.72.1761064404968;
        Tue, 21 Oct 2025 09:33:24 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::ba76])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd098591sm798737085a.15.2025.10.21.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:33:23 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:33:21 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, yicongsrfy@163.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <fe42645d-0447-4bf4-98c5-ea288f8f6f5a@rowland.harvard.edu>
References: <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
 <20251017191511.6dd841e9.michal.pecio@gmail.com>
 <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
 <20251018172156.69e93897.michal.pecio@gmail.com>
 <6640b191-d25b-4c4e-ac67-144357eb5cc3@rowland.harvard.edu>
 <20251018175618.148d4e59.michal.pecio@gmail.com>
 <e4ce396c-0047-4bd1-a5d2-aee3b86315b1@rowland.harvard.edu>
 <20251020182327.0dd8958a.michal.pecio@gmail.com>
 <3c2a20ef-5388-49bd-ab09-27921ef1a729@rowland.harvard.edu>
 <3cb55160-8cca-471a-a707-188c7b411e34@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cb55160-8cca-471a-a707-188c7b411e34@suse.com>

On Tue, Oct 21, 2025 at 11:13:29AM +0200, Oliver Neukum wrote:
> On 20.10.25 18:59, Alan Stern wrote:
> 
> > Another possibility is simply to give up on handling all of this
> > automatically in the kernel.  The usb_modeswitch program certainly
> > should be capable of determining when a USB network device ought to
> > switch to a different configuration; that's very similar to the things
> > it does already.  Maybe userspace is the best place to implement this
> > stuff.
> 
> That would make usb_modeswitch or yet a new udev component mandatory.
> That is the exact opposite of what we would like to achieve.

In the same way that usb_modeswitch or a udev script is already 
mandatory for a bunch of other devices?

In this case, it wouldn't be quite as mandatory since the user can 
always change the configuration by hand.  Some of the things 
usb_modeswitch does probably aren't so easy to accomplish.

I agree, it would be great if the kernel could handle all these things 
for people.  But sometimes it's just a lot easier to do stuff in 
userspace.

> > Furthermore, with usb_modeswitch it's not at all uncommon to have some
> > drivers bind momentarily before being kicked off.  People don't care
> > about it very much, as long it all happens reliably and automatically.
> 
> That is probably not wise in the long run. If the device whose driver
> we kick off is a CD-ROM, nobody cares. If it is a network interface,
> we'll have to deal with ugly cases like user space already having
> sent a DHCP query when we kick the old driver off the interface.

Doesn't the same concern apply every time a network interface goes down?

Alan Stern

