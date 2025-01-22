Return-Path: <netdev+bounces-160353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2F2A195F3
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E9C7A27EA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BDE214A69;
	Wed, 22 Jan 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="NSHsIsUJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F0214802
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561579; cv=none; b=fi0jTFlhg7rStiW/Ic4r9gvfg2pnbMtf5+c5KQ3o2q3jYNxDwYjv3TvWXezNZMQTD0dW0KZYabq3vcOqsQf+35Cp36r6ZUI0N+BMtYcD0eR0vq3sQv+J/Hp459TtfuR+fslTB6Z8QJsqi+3EeEeMRK5KHSkBdFxpkjxa13eQnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561579; c=relaxed/simple;
	bh=bn/ywieNYIuHnFcvZ+uO7EqGYqZmz4FSaLXxa3E6N38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Seuec+TGg5qDN27mEJWfIIJt1gVkfR5do+E1qmp4dR/OcHIpJ3DgnizIZe00yV2dY+8h4CgOFFD2kdw0eRHepqr/SjLMTBij6jq78E0IupQzGTMDOgxIPC+10NBkbAo/nQswvktnWQ4Q99yU0QjriV8BWTdBvlUntjkkUaE645U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=NSHsIsUJ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dce7263beaso63028066d6.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 07:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1737561576; x=1738166376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zRpA7lnUjc/1ZNQajgCDxAJrCVD+pLiNeZCNjT+jGDM=;
        b=NSHsIsUJlZDcbcY3btKPLsqkcmJmZ4urFPuaP9vKdrNa3QzcaiSiBGLgLH0EvCXmGW
         0GcZUAskFwtxBbSVJWhE/FD9HmWtAkeFqdBOh/ySbCyolb4zplpyKI15c3sbWN+ahGds
         d/ZsWWVkW2jo26Ql3OFIDYmHaoojxtq/Rlb5nQdyT+bq2PF5EEfwbAg3Z/8ZSA3lQhsH
         7yBNVDGwzY9B58DRv8c+UeZb1ug75pPRBQCNVCKp5jr7ny/54JGGANK6mwgcgDZny75Y
         /CZlQEm2zB2CKj2uHUhe8n+zuCGx79m+qSHXyP0znC85CocwXEH2qU94K3fYSYt8Eyhi
         ep5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737561576; x=1738166376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRpA7lnUjc/1ZNQajgCDxAJrCVD+pLiNeZCNjT+jGDM=;
        b=FVLBVjZ4ayX5LtpsMyoqaWJQGGgzpphjU3Ym/M7FexVxzZalNDSh1D/CNhZypa5Fhd
         w/Ps2Nnn9KsAmsysxXrwgMJq8nPEcAO1vadwaJlKeVuwoFNW/kLO/XwB5J+FInr59zam
         My2YfwO8uhJEAchrQc8jHB5sYoQcmiA/I4FUGgmDcTNPJqkL+cBc8uMf6l7g0Hn7X6ZL
         o6plc8FXBIvPrXz7B/N4ILp/sEWjw63pFM4psqxcOF8LNFeaKXvonWutPP+a/qku3kZg
         R8vQcCHtQLztX58cGwJkDhVaIkVhXbHIRwsNpyeKTjY8z/vZG0CwOgbEKiMQH2fbI5gU
         OEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD9neBguWhmMf1feNVTVvkFYNqH80WjRJFiAu40TOwrGh7+xfxx4bT7E7TRlDuek9SeTquMI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmb45beajc5sn2DNxm9f/iyjf2Tbuq9gO+YaLR6pDBPXe0Aey7
	WJi/lNQW5nCJY5ok/DydMlRfpbz7LegHgYQWOoaKwh1bY4urNbo6Tsp+RB9ljQ==
X-Gm-Gg: ASbGncsP4AJn1c1KG4dDisVi0/owugYgwtSfjxu2A6K26/JkzL+X8T5MstUeN75n3MM
	8NgZ/NxXA6+OJF3B9IpLU4Db7OgoKkpHKZfcXnw5PdN7LRnjQzNsAZcrrGXmibGxPN9iBZ3RNRZ
	+6c7D+a1H27HRR8VOaKXjmRUCs791tMowXaAqlqPI0yN4QW6k8UZnSyy2o+5RAJD8PGG72lPghe
	B2mLaOySDClREHNaYLSFCghMyfDJQpHlOXcdkIEb2y43K33YqGQ6EemxkbmlEgrRPCiDMCPf7Ct
	zKFaFSjcJCRp
X-Google-Smtp-Source: AGHT+IHmyXx6dZA7Q9isGcgRjicXHJNRUA6kVmF8MGLZO7Ur9ya8u/S3gMIDiMjyPlJZCWXlVyJZYw==
X-Received: by 2002:a05:6214:408:b0:6d8:9065:2033 with SMTP id 6a1803df08f44-6e1b2213e69mr372030346d6.31.1737561575855;
        Wed, 22 Jan 2025 07:59:35 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc22ee7sm62310746d6.49.2025.01.22.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:59:35 -0800 (PST)
Date: Wed, 22 Jan 2025 10:59:33 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: usb: rtl8150: enable basic endpoint checking
Message-ID: <f099be8f-0ae0-49c7-b0bc-02770d9c1210@rowland.harvard.edu>
References: <20250122104246.29172-1-n.zhandarovich@fintech.ru>
 <20250122124359.GA9183@bender.k.g>
 <f199387d-393b-4cb4-a215-7fd073ac32b8@fintech.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f199387d-393b-4cb4-a215-7fd073ac32b8@fintech.ru>

On Wed, Jan 22, 2025 at 05:20:12AM -0800, Nikita Zhandarovich wrote:
> Hi,
> 
> On 1/22/25 04:43, Petko Manolov wrote:
> > On 25-01-22 02:42:46, Nikita Zhandarovich wrote:
> >> Syzkaller reports [1] encountering a common issue of utilizing a wrong usb
> >> endpoint type during URB submitting stage. This, in turn, triggers a warning
> >> shown below.
> > 
> > If these endpoints were of the wrong type the driver simply wouldn't work.

Better not to bind at all than to bind in a non-working way.  Especially 
when we can tell by a simple check that the device isn't what the driver 
expects.

> > The proposed change in the patch doesn't do much in terms of fixing the issue
> > (pipe 3 != type 1) and if usb_check_bulk_endpoints() fails, the driver will just
> > not probe successfully.  I don't see how this is an improvement to the current
> > situation.

It fixes the issue by preventing the driver from submitting an interrupt 
URB to a bulk endpoint or vice versa.

> > We should either spend some time fixing the "BOGUS urb xfer, pipe 3 != type 1"
> > for real or not touch anything.
> > 
> > 
> > 		Petko
> > 
> > 
> 
> Thank you for your answer, I had a couple thoughts though.
> 
> If I understand correctly (which may not be the case, of course), since
> the driver currently does not have any sanity checks for endpoints and
> URBs' pipes are initialized essentially by fixed constants (as is often
> the case), once again without any testing, then a virtual, weirdly
> constructed device, like the one made up by Syzkaller, could provide
> endpoints with contents that may cause that exact warning.
> 
> Real-life devices (with appropriate eps) would still work well and are
> in no danger, with or without the patch. And even if that warning is
> triggered, I am not certain the consequences are that severe, maybe on
> kernels with 'panic_on_warn' set, and that's another conversation.
> However, it seems that the change won't hurt either. Failing probe() in
> such situations looks to be the standard.
> 
> If my approach is flawed, I'd really appreciate some hints on how you
> would address that issue and I'd like to tackle it. I'd also ask if
> other recipients could provide some of their views on the issue, even if
> just to prove me wrong.

I agree with this approach; it seems like the best way to address this 
issue.

Alan Stern

