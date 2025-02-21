Return-Path: <netdev+bounces-168665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6D9A4015B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498A57A98CF
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1AC2505BD;
	Fri, 21 Feb 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Hj2w0isa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D81EE028
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171211; cv=none; b=F8WkjaHgUd73G0/B6A8uG+4B9C6IJPYNdmvmBDGLiRvTdCEJHzAipUP7NW0vvtm2BqhH887ZttlAWA+HHmvDXGOdjVLebsvKc+YL+3QsBCe1oFWz1jR5gTohSFM15bDoIeCtMIVONavzW4GRUWkZ9vIdEn11W8vLLt20vF0ERrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171211; c=relaxed/simple;
	bh=DKBUOxs/YvTIrkUUMo2exkSzPdju0uIiiP93MMD8XZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRrxyKpvjbfwn+o22Tc1Zm/7Rq2WN3Pg4KXBhrSW/HNPMDeJ1Ygy6M4MjjIWwvB7CJjDyNKhpAFZ836sxIx7/f8i6eddp6kBU4oqUFX+JPilaPYRUsBGf+1jnca8Og6cGnMIEYI485i/MR6onAmfTaLk2qRmP52Q6iUcW7RtAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Hj2w0isa; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e67f377236so20048776d6.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740171208; x=1740776008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoEJ05B0k2QKvLULjk6ScEGJs4y1XCNwR5ARbRdfbJg=;
        b=Hj2w0isauANNWUQzKwM/hfmGqtAobTcF7hCjaeKluckkIHsODzAm1skPzpdqSKvCxD
         QKq7uBXfUtZ44Kv64yCyPbjt25I067xsV2giBx2F7OtXrqaI9tnDOoyXjJ3LndZYbtrY
         wyFCCEOhSqKdfG+mYCPLQdhh/mxjEpO36K7ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740171208; x=1740776008;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoEJ05B0k2QKvLULjk6ScEGJs4y1XCNwR5ARbRdfbJg=;
        b=sr/gm2c17uDykO0Qqlszt+uU2GYlFYxmnf2Vv0iyalLLaYi4fInPq3ub/nBSuwQqDj
         v6jclzzGjBw59aRqPNY6NcOVYPs6o/GiezVfZC3K2d1t9HnohB2kbVCeUXdJXJFYflqn
         dezA3tP7e762E+1OlDIjaQqllWeNjpwbYlzfoJo06ty9alBK3WnCG4RvH0qdS77Zf516
         XRBTYOpAmmxjwvlz0AmZRXzaDktLyXJymcgwdajNs4M484ZYKuCSNu0bRi0k2W3kznVC
         2oCO1NVUM5KThkSifO6TEkc2ii0Tkw7Fy6yyz98M3wDVrTyDFums1zqdUvqUhICFFxF0
         GIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBf5Wh/xj8H4kI4Ha4YVrvL05f4aLID5la6P9iqUNOKnUAwnr2WAwXNV2icAg/cu9F/Y5P8Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK56OE95r+UbqAcA0hs1+Olwv7ldtXdsvd6xxlBxeWVXIgOnhG
	li+amIia3kiFgCsAyp4gaaN6gP0WK47zUiBjSrwie4Ev/XcHb0ciE3wMHRgLyWs=
X-Gm-Gg: ASbGncv4GTxefpA+RAFf1KDCfdYdD63qNl5ov+jg+9+G92dmLiRzVQvRvtcYWTxHn9/
	00g0fw0L4V3+SpLeH2ZaSptiwKdWakAmjSDAJ/e2xtRbTfvKcR4xe3XVcxzlshkom1nsMgDIjBN
	3ODwC9sLf+a6uJFwhL9KnJuRToO54oXWH07YHTjIyZzhtYYpawTevhW5885SF9hopLyw8MfS67m
	hdiJsMSA5kFRsS68x/iLxh+Ix7mPxeHzBz2BHR5YkPZUGW3DsXyuTslKFu3xGWySkMwnyiSN4L2
	iIU4FssHq6vZJqq8pZFgTLX3cZruP/Q6KxwMi53Qwi63p1E17Afcecx0lA6FPipT
X-Google-Smtp-Source: AGHT+IFJ7FpVMjmW9zCHBqwF+fT7qqQnhfBLVFH/v2oLp+6xAwmp6qgigq6Pi/kJVk8ru1yhaHTEXw==
X-Received: by 2002:a05:6214:223:b0:6e6:61a5:aa4f with SMTP id 6a1803df08f44-6e6b01d78e8mr49854816d6.45.1740171208687;
        Fri, 21 Feb 2025 12:53:28 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a436esm102248016d6.62.2025.02.21.12.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:53:28 -0800 (PST)
Date: Fri, 21 Feb 2025 15:53:26 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/4] igb: XDP/ZC follow up
Message-ID: <Z7jnxolsaLICS6zD@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <Z7T5G9ZQRBb4EtdG@LQ3V64L9R2>
 <878qq22xk3.fsf@kurt.kurt.home>
 <20250219180651.0ea6f33d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219180651.0ea6f33d@kernel.org>

On Wed, Feb 19, 2025 at 06:06:51PM -0800, Jakub Kicinski wrote:
> On Wed, 19 Feb 2025 08:39:08 +0100 Kurt Kanzenbach wrote:
> > > My comment from the previous series still stands, which simply that
> > > I have no idea if the maintainers will accept changes using this API
> > > or prefer to wait until Stanislav's work [1] is completed to remove
> > > the RTNL requirement from this API altogether.  
> > 
> > I'd rather consider patch #2 a bugfix to restore the busy polling with
> > XDP/ZC. After commit 5ef44b3cb43b ("xsk: Bring back busy polling
> > support") it is a requirement to implement this API.
> > 
> > The maintainers didn't speak up on v1, so i went along and sent v2.
> > 
> > @Jakub: What's your preference? Would you accept this series or rather
> > like to wait for Stanislav's work to be finished?
> 
> No strong preference. If rtnl_lock is not causing any issues 
> in this driver, the we can merge as is. I haven't followed 
> the past discussions, tho.

Don't mean to side-track this thread, but does this mean you've
changed your mind on the previous virtio_net thread [1] ?

Or maybe I'm just misreading your response there? And instead I
could re-spin the virtio_net but dropping the first patch and
dealing with RTNL in the code like this series is doing?

For some reason I was under the impression that the virtio_net
series and others like it (like this igb series) were being held
back until locking work Stanislav is doing is done.

[1]: https://lore.kernel.org/netdev/20250127133756.413efb24@kernel.org/

