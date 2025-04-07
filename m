Return-Path: <netdev+bounces-179524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845F5A7D6F3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C641889247
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37F82253FF;
	Mon,  7 Apr 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/dQG2zQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348901A8F93;
	Mon,  7 Apr 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012635; cv=none; b=YI7LdGphph8l3Y5TzTJAeVFGkiu9PGoAY6ycYSm4K2lkFKfs441fFp5GbOv41fa14VfvX4M68Wtu+MMOr7jedn4uosZb2GCX+KOI+aHE/hBMg7zhUo+vak4CtcaV6DaGVFC1PlU3qfmvqttMarD6gJZM653zl5HqBgl3mJJ7pwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012635; c=relaxed/simple;
	bh=bt92100q8tdkl5vY+RJN4GQR/4KBzXjuLLCjPpRgb0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjyzzHBHPWu59UVyncK7SYq7FxZoHCfk4gpbx/dRR+mi+b2wS5HI3Tb3nOoDuTvB98Pa5cyypznXnYmqV6w5hzCirpZCgWgwWFH00c4mmnG4X7+/+iLSZdktbizZx2+Ly+Dv8mwe1/Q8Hw+T/gcmdaMRU2n5VBOyg5X0R4Grfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/dQG2zQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7396f13b750so4135250b3a.1;
        Mon, 07 Apr 2025 00:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744012633; x=1744617433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0APgzzLBBEMmyyLsOgicTUxIPxJFFTMMFuvPfAMqCE=;
        b=K/dQG2zQSud9rjLoBysRDydQ1qTtFjP/k4qhky01O0dF11cr5uN84MmnSpUR1jlcJM
         461hRBe+8ESM4PO3HmRY2k0cMFm5IYVbPzUg0Kdjjw0r8tlGB60APO9XndHoq+trkb+U
         byi1yD0acS0ZTCy5c06WLzBE6X67Ryn9TxqTKxAFujHaj8WBpxc9EZJ7/QSdiU/hdGSV
         7arXA5tmg2BT1vd6Nh4wxMoN5SItSe5+IRnnGToMT8nFL2244FZFJRZcEFfpPhySCzfO
         h3YPRmVmHEXE+1QK7hPaKlnXda9y1tXsVZQsZNu3H8+GViw3nAGgdjDJqacIx/pF7LYb
         REtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744012633; x=1744617433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0APgzzLBBEMmyyLsOgicTUxIPxJFFTMMFuvPfAMqCE=;
        b=ozxvAbgCaG4VeBTU2kz8KExaz7hLCRKp/pRSzxjBkgk2pAtMkFzKYLHbcFbVpYTiYu
         mKiiWxB79gtvpvfSwf6ZHkmUFPAunHoOEf++8nIFZWiHv2zORnFYKfsykub+s2d9Cbpm
         CXnQERe980VYksb+igoQttU81f/3ckIumiDwvQx6Ba/QoY9PO70/M3eZ6Q2INU3lt9Ww
         QSb0A0ocFeCYNR2VVQnqewIHe0s0lwDhKI5NvO1LG2JBaqqEPaJMQZEbqWVzKtAwVRNY
         nKXF/q0L3aOQEQbWjkZEb8190Vb6A/xKTDYKoilceAV0eNMSnGEihvYWtoBtnnS6Xp4c
         aKLA==
X-Forwarded-Encrypted: i=1; AJvYcCVSlWqv//wpSzJQuTmKy3auReV4a02tPkbMncCQieew/mo3UUmPg9DM1vKVhblc3ZjNRd5+KlAvZrVdAMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2Z15f72TgtAGeAkWkkjIAyfS5/r19tghr4fFIjd4TwYWdBJ1
	fUjKXXBh4KOKMYBV1QeQtbh2X06JneQv8HOEqVVdAEIFxD/Puziw
X-Gm-Gg: ASbGncu2hI5WamagcDnAJ0j/XStHG2z0Ngfkn/lUqMVKEbuAXU/Y92nAKy92LcicVwR
	pxmqFUSQ/823kd76pUnKpr665dNtD1YMvwnHYokxJ9Uh3AuX2Y1KDC5rwIKlhKlSh7IBJOX0yq8
	aWUD1TppeIhZPclWQiJms9+kLDNOK7SlMbKixOiQ0rI7w9wwb6EFzea6Irw+JbwWcimYxXXDaba
	I/qOVX6FHgXoXDjNNCaAz0ggkVYCEQ9bjVKamIGKNufb1X7eR4h4rJC6/XwJMxBFLD8SwMN1/W3
	j8rPaDtuC7dyNXYRhpobUFceMIlgsGs9UngETx1SSkKhRbb1nJnL5SLc9+0V
X-Google-Smtp-Source: AGHT+IEkI7xynWBdZQXRIHFIofzZPHRUKy2ojEAZzUR9vRgWo9bX3j/cGl6WdQQ7T7e/tWc282/Eow==
X-Received: by 2002:a05:6a00:1482:b0:730:97a6:f04 with SMTP id d2e1a72fcca58-73b6aa3dca6mr10478734b3a.7.1744012633292;
        Mon, 07 Apr 2025 00:57:13 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ef3c2sm8113043b3a.59.2025.04.07.00.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:57:12 -0700 (PDT)
Date: Mon, 7 Apr 2025 07:57:05 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <Z_OFUaeotDYJ31o7@fedora>
References: <20250319080947.2001-1-liuhangbin@gmail.com>
 <d99b52d7-bdd7-4c67-9be5-f5c48edc8afa@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d99b52d7-bdd7-4c67-9be5-f5c48edc8afa@redhat.com>

On Thu, Apr 03, 2025 at 04:02:33PM +0200, Paolo Abeni wrote:
> On 3/19/25 9:09 AM, Hangbin Liu wrote:
> > Similar with a951bc1e6ba5 ("bonding: correct the MAC address for "follow"
> > fail_over_mac policy"). The fail_over_mac follow mode requires the formerly
> > active slave to swap MAC addresses with the newly active slave during
> > failover. However, the slave's MAC address can be same under certain
> > conditions:
> > 
> > 1) ip link set eth0 master bond0
> >    bond0 adopts eth0's MAC address (MAC0).
> > 
> > 1) ip link set eth1 master bond0
> >    eth1 is added as a backup with its own MAC (MAC1).
> > 
> > 3) ip link set eth0 nomaster
> >    eth0 is released and restores its MAC (MAC0).
> >    eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.
> 
> It was not immediately clear to me that the mac-dance in the code below
> happens only at failover time.
> 
> I second Jakub's doubt, I think it would be better to change eth0 mac
> address here (possibly to permanent eth1 mac, to preserve some consistency?)

I have talked about one of the duplicate mac issue with Jay before [1]. We
decided to print a warning for that. I will discuss with Jay for this one
in one new patch thread.

[1] https://lore.kernel.org/netdev/Z49yXz1dx2ZzqhC1@fedora

Thanks
Hangbin
> 
> Doing that in ndo_del_slave() should allow bonding to change the mac
> while still owning the old slave and avoid races with user-space.
> 
> WDYT?
> 
> Thanks,
> 
> Paolo
> 

