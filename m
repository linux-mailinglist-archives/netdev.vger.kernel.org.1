Return-Path: <netdev+bounces-127497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA7C97594D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3AF1C22E60
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095321B142E;
	Wed, 11 Sep 2024 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwHjrkA7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A251B4C3F
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075541; cv=none; b=GrD798/SimO1kM9h1HPZWbsCBOBxS9lrYvS/qsRZzr3Vire4iu6pMhHYhIN/OnqBc66dIP+67EqyASr7JtoLXWHFeXlkNyOqc0d7MKvT9ikw9OLHz2uByYpXClyWzKcEFCsCafZRF46+v19pnRoiAK/IMC1j/VGH+mgPbKi8t0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075541; c=relaxed/simple;
	bh=2CXGVg6NEhqLRKhGUyW5174lZyw87X6GSvdQUeR5MmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfN2C8bEmqzoaDIyljFP7vBhPe0fGgwWzLzQOEyx9h0fHDEwqJlfl7LQ2T+HFCxDkDPJ7BGHBnXBoJtrCX+bH0urVrlDisdVSSn0B6VU+Gju65Ztu16JjaPD/6+eN3f4tp2P18ughh2w/Yt3NCnC/Pmrz7JELr1g2oBVH3nrPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HwHjrkA7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb806623eso20884515e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726075538; x=1726680338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xmCKuyw0DapJvOtbSWzmF0OL2IUWJWDlS7+rw4t0ojA=;
        b=HwHjrkA7gzRnzqnFdZlE8r6f5osEn/6loIJMeUgfFx4K6WN80pA/kVCIa5Z2V2BRjK
         oBIAS4iyhXLPEyteeDJ2g/iOKbY6g746NyGc8G3DudBVDhzwdzvp4GUFLXSf9kTz6R4W
         OtWw5cnx6+4KIgkTKLzWtNAgIVuhuG3/mq3vhGlM/dcdkWYyxSoFxEjjk3MKjiuI1yZd
         JBjlhTRp9dyISMNvcHvGgYAeA72qQwwQFI/b4w1qlVEWFyjOqVnJ85gJzjm5lBEGBY8N
         JsTslB+5SyT9CRCvWieZ0bprCE0C8qYgGMhya917d5SNnXLn197NHtrzqQ/Eys7coEqA
         8eBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075538; x=1726680338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmCKuyw0DapJvOtbSWzmF0OL2IUWJWDlS7+rw4t0ojA=;
        b=Y+EI8Eh/fuuJB3eapnfJ/AFY1d24lHSN+cK39F8X2Z/F48HIo629OIyk9V/qsxy0nC
         L9BEKOGQfde+/SEjWAWiwkiN91H/BkDIlWDUP8JTUIAKkpiK3JuO4QyrWnys9Tt0//hc
         LHR2r+aQHMSmMzq+koG/MPXWHoyrjTtjYkg37Z9I6vf9IotzDqswoQD/Gqrrvz7qWx2J
         eA/t2R4LDTxDqUyRG0KEQx0VHFRxnq07Wnb3NfVgj3Wc+w32QFObBAvlsk4VKmQFEGQM
         02jMk2jcXabHin1LQwMMKR64ZQdJYRcWQabghZDkve95CLP4BMlm2gM9QPMxbVhKnFKk
         s1KA==
X-Forwarded-Encrypted: i=1; AJvYcCUkZ4Z6zqK1dFqfdhJaWbmnTBAzaidcJqeeZDxa3+z5PPt24k4oz1vhaeXmAp0as3jgh6CTFnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWEFsim+5kcnq13SxkLar0IeE7wHEaKyCcrJCPu1AyzE3Jwzp9
	y5CWoku0jT+Kt7nLD+LIaZx8OM4UT0iw9x5w0xD1vIqX/f+EDZcMDA5zQcL45AQ=
X-Google-Smtp-Source: AGHT+IHwgouVHhx28DMTt5PoacyStj3TzOC4jjzt7G5qL8rZ2fYGdKla/4VYhBMKB9fgtOsriRz47g==
X-Received: by 2002:a5d:6111:0:b0:374:93c4:2f61 with SMTP id ffacd0b85a97d-378b07966dbmr2405056f8f.5.1726075538049;
        Wed, 11 Sep 2024 10:25:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a18asm12049442f8f.15.2024.09.11.10.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:25:37 -0700 (PDT)
Date: Wed, 11 Sep 2024 20:25:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Narron <richard@aaazen.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH hotfix 6.11] minmax: reduce egregious min/max macro
 expansion
Message-ID: <cd6e01fb-4605-4f5f-835e-592ca70ebe03@stanley.mountain>
References: <20240911153457.1005227-1-lorenzo.stoakes@oracle.com>
 <181dec64-5906-4cdd-bb29-40bc7c02d63e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181dec64-5906-4cdd-bb29-40bc7c02d63e@redhat.com>

On Wed, Sep 11, 2024 at 06:24:54PM +0200, Hans de Goede wrote:
> Hi Lorenzo,
> 
> On 9/11/24 5:34 PM, Lorenzo Stoakes wrote:
> > Avoid nested min()/max() which results in egregious macro expansion.
> > 
> > This issue was introduced by commit 867046cc7027 ("minmax: relax check to
> > allow comparison between unsigned arguments and signed constants") [2].
> > 
> > Work has been done to address the issue of egregious min()/max() macro
> > expansion in commit 22f546873149 ("minmax: improve macro expansion and type
> > checking") and related, however it appears that some issues remain on more
> > tightly constrained systems.
> > 
> > Adjust a few known-bad cases of deeply nested macros to avoid doing so to
> > mitigate this. Porting the patch first proposed in [1] to Linus's tree.
> > 
> > Running an allmodconfig build using the methodology described in [2] we
> > observe a 35 MiB reduction in generated code.
> > 
> > The difference is much more significant prior to recent minmax fixes which
> > were not backported. As per [1] prior these the reduction is more like 200
> > MiB.
> > 
> > This resolves an issue with slackware 15.0 32-bit compilation as reported
> > by Richard Narron.
> > 
> > Presumably the min/max fixups would be difficult to backport, this patch
> > should be easier and fix's Richard's problem in 5.15.
> > 
> > [0]:https://lore.kernel.org/all/b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com/
> > [1]:https://lore.kernel.org/lkml/5882b96e-1287-4390-8174-3316d39038ef@lucifer.local/
> > [2]:https://lore.kernel.org/linux-mm/36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local/
> > 
> > Reported-by: Richard Narron <richard@aaazen.com>
> > Closes: https://lore.kernel.org/all/4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com/
> > Fixes: 867046cc7027 ("minmax: relax check to allow comparison between unsigned arguments and signed constants")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Thank you for your patch.
> 
> I must say that I'm not a fan of that this is patching 3 totally
> unrelated files here in a single patch.
> 
> This is e.g. going to be a problem if we need to revert one of
> the changes because of regressions...

These kinds of thing also complicates backporting to stable.  The stable kernel
developers like whole, unmodified patches.  So if we have to fix something in
sDIGIT_FITTING() then we'd want to pull this back instead of re-writing the fix
on top of the original define (unmodified patches).  But now we have to backport
the chunk which changes mvpp2 as well (whole patches).

regards,
dan carpenter


