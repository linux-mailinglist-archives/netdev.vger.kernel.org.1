Return-Path: <netdev+bounces-146640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 318389D4D18
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 13:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872081F2316F
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD01CD211;
	Thu, 21 Nov 2024 12:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHMN33yc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99241C6F76;
	Thu, 21 Nov 2024 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193244; cv=none; b=oF0w0cJJg7PrOK4ALkAafMil13yK+wzLVpFxBnvx480B/a7fb/BKZhp8QqXdDqcEs2QSDfHctM/SejbPhA/F4/40ABGelZrLYxxJz+NsIjnHK0N87ebr1fZXlGmC99O/Bj6dVfmOTDYbQqDDgyp13E2y+ri5Z8/nH4haBegnxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193244; c=relaxed/simple;
	bh=q4cwBxmYBUkAb5u0U1y/CWARAYnmlPuzU0KkVRM9i3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LozebWiMejVNxVZ0mRk0DisfRnB7QN2BEzuNEmiOgiBTKs6QKh2XXB9FtojHAt7r2g0c0JPAPPIo/Uc3Zef4gR0vwTb4tEWNN4nXy9j19LcgVIZ1Yq+SSNh+RTGT2E70YeiYPHwL4zx1bEnS7A7JvYGRj8qGHVHQ7dRdYCtKVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHMN33yc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315b957ae8so377295e9.1;
        Thu, 21 Nov 2024 04:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732193241; x=1732798041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhVt+OjyMRZnuKr6YGhKFJxFwgV8+CpM8/xF/R36PvM=;
        b=YHMN33yc9QRuBcI+/pGmpdxFHjoSyQZTD3hF24w8ooqPcbGTJUCvD35b2R3ndHBWFz
         JxsYwEsTL9PkN/6hMhkr5n6HwQvhkUZmcJpZG6Erb3OUJjK3mlMGdACCUiego+WemoX2
         FPxprgIqd4I9czy1NADRNt9nT3rP6bAUQ1cQOZ3XVVmwYsMgFtHMtkqKBNMrFY5YX45J
         APaSYfPPVV7hh3XMJOqijv+Ma49GMI9SrQbFJdk9vXphE332peWmSEaMRJyKpYYaIfwE
         83+mJatwS7IfdZOJHCcz5fwrSTmmKLKszkrdF91hHM6VDCNNblSnN7hhZ75XFFjR1Ppp
         C0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732193241; x=1732798041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhVt+OjyMRZnuKr6YGhKFJxFwgV8+CpM8/xF/R36PvM=;
        b=csrOYqjXpi5Pf5aP4x+S8bQe39+VJSYgKfJmTw6t0eOOZj+YU9/XDfQEAnGEvPfs0+
         Hejxtmkmk1WZcYaPX3xznW26WhB42gF+1CNXZJUw1l0UJV+Lq2fUc4XKrnu1Cb1a51Es
         Emu8JZX4+nxGMHDbpjxH/9IDMylXsf8oSZc9oDejeFxQ6qrOjPI8QN3Rb3xBV/0caSKk
         vypz6DriutnaMWZfSRxL1NtA9fpwrslENvLZSm5IbL11VwkUgcUcdQnO7tgyjKU8iiWm
         Y4R4EHskTpeaME5U1bFi7xsOkBFA56aE0lhXyvCmMq3v48hn1f4sx+lgBbEDF8tp9ZWF
         oYGg==
X-Forwarded-Encrypted: i=1; AJvYcCUAMrUrzRFme7oFFbagiktxxIHm/SZ5kSaIQJ2Ks5b9VPUpgbCG52/1Tlf+/KIniyu1a2GQcyb9l8RuGRU=@vger.kernel.org, AJvYcCWASDUK6o/sv8ar8iJ3yCPAu7G0nV50PvwuhuTu+bE6sZTp/z6yfNkFfS8j0K6GKEenfKOgV9lP@vger.kernel.org
X-Gm-Message-State: AOJu0YzJy863k7TtF4j9IOlZoyc0fMcR5qv03at3V7a+r0xdxoPlbQJt
	jCTso5QMFXVgM22gv7fKl6Up4IdDl7UqsFzAVm9bp/BSHiMY/NI/
X-Gm-Gg: ASbGncvLr4N6sHJvf86SKE9tZnfFRaRwwc+7Hdb/+IxkBGI3ySKzDmRMb1DASawkZH6
	AqCffzRYu+kSrAzgdGDgkwMrMrpUNSSZTAyjvKR/5StcN/oRK73Z5RckTLnLoSStjfK3TZSo/o8
	THZVnhsh5ioQi0vXoesS9I81BKZBEHIS2tY/NEl7A7c/oyKhTGb9BzwNMN0Y/K8KwSnL30orHRs
	csnUkKxTVwLUCrnfMV1a/73OBJ5kQKhN9N72NA=
X-Google-Smtp-Source: AGHT+IHeFV/Jhu9bSkOoMfpbrwsRcidD7VBe2rYDYWnphr2b82M0eKqJvhRetyOoj+c5xCmnBqeDOQ==
X-Received: by 2002:a05:600c:3b24:b0:42c:ba83:3efa with SMTP id 5b1f17b1804b1-43348905629mr25935845e9.0.1732193240942;
        Thu, 21 Nov 2024 04:47:20 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ab5fsm56906095e9.27.2024.11.21.04.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:47:20 -0800 (PST)
Date: Thu, 21 Nov 2024 14:47:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Cong Yi <yicong.srfy@foxmail.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
Message-ID: <20241121124718.7behooc2khmgyfvm@skbuf>
References: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
 <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>
 <20241121105044.rbjp2deo5orce3me@skbuf>
 <Zz8Xve4kmHgPx-od@shell.armlinux.org.uk>
 <20241121115230.u6s3frtwg25afdbg@skbuf>
 <Zz8jVmO82CHQe5jR@shell.armlinux.org.uk>
 <20241121121548.gcbkhw2aead5hae3@skbuf>
 <Zz8nBN6Z8s7OZ7Fe@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz8nBN6Z8s7OZ7Fe@shell.armlinux.org.uk>

On Thu, Nov 21, 2024 at 12:26:44PM +0000, Russell King (Oracle) wrote:
> On Thu, Nov 21, 2024 at 02:15:48PM +0200, Vladimir Oltean wrote:
> > On Thu, Nov 21, 2024 at 12:11:02PM +0000, Russell King (Oracle) wrote:
> > > On Thu, Nov 21, 2024 at 01:52:30PM +0200, Vladimir Oltean wrote:
> > > > I don't understand what's to defend about this, really.
> > > 
> > > It's not something I want to entertain right now. I have enough on my
> > > plate without having patches like this to deal with. Maybe next year
> > > I'll look at it, but not right now.
> > 
> > I can definitely understand the lack of time to deal with trivial
> > matters, but I mean, it isn't as if ./scripts/get_maintainer.pl
> > drivers/net/phy/phylink.c lists a single person...
> 
> Trivial patches have an impact beyond just reviewing the patch. They
> can cause conflicts, causing work that's in progress to need extra
> re-work.
> 
> I have the problems of in-band that I've been trying to address since
> April. I have phylink EEE support that I've also been trying to move
> forward. However, with everything that has happened this year (first,
> a high priority work item, followed by holiday, followed by my eye
> operations) I've only _just_ been able to get back to looking at these
> issues... meanwhile I see that I'm now being asked for stuff about
> stacked PHYs which is also going to impact phylink. Oh, and to top it
> off, I've discovered that mainline is broken on my test platform
> (IRQ crap) which I'm currently trying to debug what has been broken.
> Meaning I'm not working on any phylink stuff right now because of
> other people's breakage.
> 
> It's just been bit of crap after another after another.
> 
> Give me a sodding break.

I just believe that any patch submitter has the right for their proposal
to be evaluated based solely on its own merits (even if time has to be
stretched in order for that to happen), not based on unrelated context.

At the end of the day, somebody other than you should be able to come in
and say "I think this looks fine" and that should be sufficient, no?
Especially since the dispute you've raised of this change's technical
merit seems to be out of the way now.

