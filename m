Return-Path: <netdev+bounces-230648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF7ABEC52D
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 04:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762CA6E4630
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54801212554;
	Sat, 18 Oct 2025 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="efTrg/eo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4A202960
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754462; cv=none; b=uvav6+NgeOw8D/thdjamUykQBqWkn8aDovgWNXz1APNC+/zaGtaus3bO6Q7wtT0SBJm79OtPo0svNO0II5LZLTyyfFjcoryfw73ti7SbelHefouZzk8cBnBf4fRj3zDCoANBqDY0D/pzrQPdmwKb0axZgJfIzhXKw+MZX4L39Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754462; c=relaxed/simple;
	bh=e8SgYXC/sRUXWsOgya55vEos5aeigH8Z+OuvF9YZYi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urW0Y/fLKpeGgxCqNk371YatYId8FnIwW5pilToXcPJcPku7n0J7y67oluewLGFQZNepStvY+AcyPt6rPEYcemVwHR4xpu3Sm+5k6YqYp5eAk4a5Bk9lCHEbI1hjHEzlx6LxVfDxRMO8T9QQDAkDfqpzQzOY6Bkbs3pFlYdqlKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=efTrg/eo; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87c237eca60so21078266d6.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 19:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760754459; x=1761359259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOEczZhXwd8xkJnA7P0xSygINsaZHa1ESl1NQSCsz30=;
        b=efTrg/eoznjl4xqA5pO28PB3R9BVLa9EJb5+I4zGQA2XrDg4TxUKofSa4fymUWyWV9
         lefDtkWMU1P/RFvz2aqvFVOZEBfiQchPOFW6IqAzKYrNOK7l4ZK/Ty5jzCkX66tiJHR4
         FVdMedMmyJLj61fR9eW+85l7ts94n2rvUcEVylbw09W2WvFCgMSw7QqGhE1pyxFF1oaS
         RJN3fZYeuinoaXTBwKeSdfJ6Dwu0gz0G3a7FejEBZ3rcMRE/rBIdQgfrNpLmp4hTOF0t
         7tl9a0crf/1dHD4vHFfAxsFyfGufGlu1CVRaKZBldZmEYHnNDaEtcIgZoIKC17KpzJiz
         3xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760754459; x=1761359259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOEczZhXwd8xkJnA7P0xSygINsaZHa1ESl1NQSCsz30=;
        b=imVtAz42UJX7D8TzxQ8dv03wlLIzjz7mvY8rMf93dSUb0G7tnB35L5IK1qzm8SRY6M
         WisCwJScddQ5A1bgneQEg5H51i7r7A2hThYmuSEWPbyPIPPxV4thrnjtwpx3Lk0pCpGr
         /RHHYcHPgWdtipu86h4FDNw/ClbqZt4HMdjljJ5Qk3DiMhoScJJJ/RPKPFU46hMat/MB
         Ahq/EvyH0kCJUuvcQs45fXjmZxoAwLdHQb05mypBFVclwUxP5Lc3G/3KmQI8I6oPhiqy
         XeH3JcDt316KtrFbXRl8GpRJS8o71lPAa7eEOR3ZjMuOpPx2VhU795M9gCjsc84A3xy9
         USVw==
X-Forwarded-Encrypted: i=1; AJvYcCVKXQcjq3Xk63uBh4EQzVXMyhBDStCMZB/idvKajBZG2YNSq07PxZHkmEpOzGmWo4yp1p/w2DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrdAJHzSP1GbqHQQwa0RvOa9r0DBCuq3RmpVuLAU8F+i0n9XY
	27cPywS6kohHFQw42irDXS7oEnX1gUK70yO886SvJ+SuoeEtosMuCIX2D4k4t24nzw==
X-Gm-Gg: ASbGncscCV/Hx6fNZ4Lj6epiofV/aWerstB+882ekSSbVlnuhDkL8Lea/9nla9ZzUZo
	fR9XWFc1BuHpReGRLsgfbwQzNu9N0p8a+neuPQkZJa/Yoxu6gyf8gl6YTJ32dpeolU0W5/oplSc
	ltDF/eERzvfGZvXR3m5IeP3+m4kCkUQQKq1CTALa07FMrXNnMai8FYPgYyOYz/qnSBsbS2uHd/W
	y7tX//OjFrl9qzJrLcE5QoNcOIeGgkdymDUDSyhc3EjB4TM059YTuU2g5xB8wYuWjRDxlHgWrQf
	s5GoVscuYZ9p3Hr140WaFtF0SsFP0CcrVQEGMxDWWGS5LJc7QHH7vjzT7yqrhWdw7KCtxRjSpHY
	dG6nNkvon9QtG85WN8O0VTmGKhyAlxJRgM5mNUqH/ptRYf6onYwPr/BhhaOTPRLG32c3yiXeM7S
	WaL4pSYvQycSlk
X-Google-Smtp-Source: AGHT+IGNnqcR5l/hkRy88RGvYT440C+wDUVsXK7V+zRv6jwKTSry7Du049+ZAGn0/5kzXNZANG5/KA==
X-Received: by 2002:ad4:5be2:0:b0:81a:236c:c846 with SMTP id 6a1803df08f44-87c207df6d3mr75886946d6.33.1760754459431;
        Fri, 17 Oct 2025 19:27:39 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::a165])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8ce5bsm9015696d6.57.2025.10.17.19.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 19:27:39 -0700 (PDT)
Date: Fri, 17 Oct 2025 22:27:35 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
References: <20251013110753.0f640774.michal.pecio@gmail.com>
 <20251017024229.1959295-1-yicongsrfy@163.com>
 <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
 <20251017191511.6dd841e9.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017191511.6dd841e9.michal.pecio@gmail.com>

On Fri, Oct 17, 2025 at 07:15:11PM +0200, Michal Pecio wrote:
> On Fri, 17 Oct 2025 09:10:22 -0400, Alan Stern wrote:
> > On Fri, Oct 17, 2025 at 10:42:29AM +0800, yicongsrfy@163.com wrote:
> > > Yes, there are many similar code instances in the USB subsystem.
> > > However, I'm primarily focused on the networking subsystem,
> > > so my abstraction work here might not be thorough enough.
> > > Hopefully, an experienced USB developer may can optimize this issue.  
> > 
> > Would it help to have a USB quirks flag that tells the core to prefer 
> > configurations with a USB_CLASS_VENDOR_SPEC interface class when we 
> > choose the device's configuration?  Or something similar to that (I'm 
> > not sure exactly what you are looking for)?
> 
> Either that or just patch usb_choose_configuration() to prefer vendor
> config *if* an interface driver is available. But not 100% sure if that
> couldn't backfire, so maybe only if the driver asked for it, indeed.
> 
> I was looking into making a PoC of that (I have r8152 with two configs)
> but there is a snag: r8152-cfgselector bails out if a vendor-specific
> check indicates the chip isn't a supported HW revision.
> 
> So to to fully replicate r8152-cfgselector, core would neet to get new
> "pre_probe" callback in the interface driver. It gets complicated.
> 
> A less complicated improvement could be moving the common part of all
> cfgselectors into usbnet. Not sure if it's worth it yet for only two?

Without a reasonable clear and quick criterion for deciding when to 
favor vendor-specific configs in the USB core, there's little I can do.  
Having a quirks flag should help remove some of the indecision, since 
such flags are set by hand rather than by an automated procedure.  But 
I'd still want to have a better idea of exactly what to do when the 
quirk flag is set.

Alan Stern

