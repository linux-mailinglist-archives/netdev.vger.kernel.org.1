Return-Path: <netdev+bounces-206213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE8B02253
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91962A426EF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366052E7165;
	Fri, 11 Jul 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+WIbb5U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9711754B
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253656; cv=none; b=GoaPDBHqAW/coQ/DKp4ainn0r2oHYWphdLH5+g6nYovDpheLmBu8eToM5fcr7vKM1H2NCYuAnx6QiW+Idv29X63JEpES2wSsQuaNBfXXQh0a1tiadcav89y5St4DueP2jLQrKmfQQN1DKYoBZ7fSPk6o2cNf4XLmYSkXS8KrrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253656; c=relaxed/simple;
	bh=TvpoRTlSwQDkIsz3R/mbsJ/LcAHjML2V5TajgtuMqcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhSwjqRJgWrKleiW3/8r1xNgvlqJNsEtGwc3jl0y2ooTLQ2xeNfJaKYtIDxg+9h381v9+GobiPDqEswps/cZbs6HiDD955Jg0oh5qut5n26a1BDc2P7leyxTB3rp5s9hSdwrUirjB4P4aoRzd8z29glwlRWjpPlIqFUDvmYrKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+WIbb5U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752253652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gw5Z+4Z8UOEI198NYrKjwyQ0xwC0ESeghLuPp+GkbU=;
	b=K+WIbb5UgGle49t/6TfUmNz367I2Y07p1RWYDQ6x+qrCfU6POOTI1/vBXATO5EmcZJLOK+
	YhXaxhcu+IbrxqxhG4j42HkJLw+J2/8ek1hS/Ui3HvYVHCGXx9sZuKMUmfbhsxlDkOvRIF
	7/0dWTrKPIDqfTi/kwtJp6uv8dgR0ZQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-1GTURMxTOHuFctc7GcuwFA-1; Fri, 11 Jul 2025 13:07:30 -0400
X-MC-Unique: 1GTURMxTOHuFctc7GcuwFA-1
X-Mimecast-MFC-AGG-ID: 1GTURMxTOHuFctc7GcuwFA_1752253649
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so1131149f8f.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 10:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253649; x=1752858449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gw5Z+4Z8UOEI198NYrKjwyQ0xwC0ESeghLuPp+GkbU=;
        b=mTwD/Hmr41/x/yYZD76PBQ7398UlIL7Tj93/XvX04JmRge1Z021imgXiW/TqdY+iGh
         P5ucal6LLfs73TJfa1ikDpzz5o5y3QZaCqQ998u3NW8nZFbwkBeUl8prmh7EKNR2Gey1
         zQmtuJ8/ziKqlPD1jgyPpQ+XNiMOIcyfzizovOGOu6IkSMkMlfdZHokQg6k+g+jLIQma
         VQy/Yv7mG9vbJxWI+2m4fTLfyIivDgHj7onNT+boIoUyLwc0MFSJGQLmPUBbGfb6Zn1U
         mYRROiBct/d8C35IrMywAJvVxpXqkfcI0aAEbq28Jo/39b6GxPR2znAzpqJtDodG43K8
         dFzw==
X-Forwarded-Encrypted: i=1; AJvYcCW47jU9i7T9/EcAMAGVSL+3O+VpzjnD1DWc7js8isNB6DRTVMJBzzeIu+7dI/407p/6UEVIt6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91NnbXkFxVtT1yqQOpEkJpBjfUHV6iXX8SzuNflD/DJ2Exf7T
	sNAOAEAgNOjvPFbiHBt9O6n75pksGOH8IJvyt7U445xzsm+3a6c8rWJ5eB9KIN+b3oVhB1wmOy2
	a5AmlVJmAI6AtQWAtHA0XewbuMzKwh9x1fDmLpplsLZc0iy+tq5sUgDeVjg==
X-Gm-Gg: ASbGncsRxooVDZrS7g/MKl9KnqUhQl2VGqXG2JGqXvtHBhrKsgYTWfl4g1XdeQzFeK8
	ZVqgMlqK9Jxr+ug/LmGqHEai1fDYp3rerypIduk/1GkeV9PUK/JpJLPztX3vceZyD9V7xQSvsQl
	0NADOGs0DlB7HCeR3MxtRYFPXLVr2UwlV4bqIE947jZpEXm0m98p7hJm61vZosgRzcfIaKu2epS
	HXfatpcpowJnJrXWNEjteZkeL7g+vZoH0Qg4PEteTY16stZgvxpQlCtA/gqkVM/IKCwwVOm8dQE
	+8mxwlkAR4C+8cDWbKb/E+uSeu4=
X-Received: by 2002:a05:6000:1a87:b0:3a5:3930:f57 with SMTP id ffacd0b85a97d-3b5f2e3722amr3333264f8f.51.1752253648932;
        Fri, 11 Jul 2025 10:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4iMeE66EFsSmt5CNrDbBh6nR7kSy6VvwC6UgGrLNozRyVrb+1LGPil4eDlbQE/gFllMIWQQ==
X-Received: by 2002:a05:6000:1a87:b0:3a5:3930:f57 with SMTP id ffacd0b85a97d-3b5f2e3722amr3333234f8f.51.1752253648552;
        Fri, 11 Jul 2025 10:07:28 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26f22sm5033590f8f.94.2025.07.11.10.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:07:27 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:07:25 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Gary Guo <gary@garyguo.net>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Aiden Yang <ling@moedove.com>
Subject: Re: [PATCH net 1/2] gre: Fix IPv6 multicast route creation.
Message-ID: <aHFEzWcTCy4vnlBB@debian>
References: <cover.1752070620.git.gnault@redhat.com>
 <027a923dcb550ad115e6d93ee8bb7d310378bd01.1752070620.git.gnault@redhat.com>
 <20250710135757.60581077@eugeo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710135757.60581077@eugeo>

On Thu, Jul 10, 2025 at 01:57:57PM +0100, Gary Guo wrote:
> On Wed, 9 Jul 2025 16:30:10 +0200
> Guillaume Nault <gnault@redhat.com> wrote:
> 
> > Use addrconf_add_dev() instead of ipv6_find_idev() in
> > addrconf_gre_config() so that we don't just get the inet6_dev, but also
> > install the default ff00::/8 multicast route.
> > 
> > Before commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
> > generation."), the multicast route was created at the end of the
> > function by addrconf_add_mroute(). But this code path is now only taken
> > in one particular case (gre devices not bound to a local IP address and
> > in EUI64 mode). For all other cases, the function exits early and
> > addrconf_add_mroute() is not called anymore.
> > 
> > Using addrconf_add_dev() instead of ipv6_find_idev() in
> > addrconf_gre_config(), fixes the problem as it will create the default
> > multicast route for all gre devices. This also brings
> > addrconf_gre_config() a bit closer to the normal netdevice IPv6
> > configuration code (addrconf_dev_config()).
> > 
> > Fixes: 3e6a0243ff00 ("gre: Fix again IPv6 link-local address generation.")
> > Reported-by: Aiden Yang <ling@moedove.com>
> > Closes: https://lore.kernel.org/netdev/CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com/
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > Tested-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> 
> You probably also want to
> 
> Cc: stable@vger.kernel.org
> 
> so this gets picked up by the stable team after it's merged.

Yeah, I forgot that the policy had changed.
It seems that Jakub took care of it anyway.
Thanks again!

> Best,
> Gary
> 


