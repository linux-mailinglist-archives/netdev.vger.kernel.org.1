Return-Path: <netdev+bounces-237723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCE4C4F957
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 20:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB718C1A79
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 19:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE568325730;
	Tue, 11 Nov 2025 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PATnYtYT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16901325717
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888732; cv=none; b=RisoKxr0GEkozwWwbJyG/7uyBXFcLe075B2xsd09qnGFIQf9mJGYqEfV95oIDmHCrPW4/RkjiPehwbhHWv+leWRA3sN2rFZOHdBnhOyWGbJ/qvCSXDKThMOcDVuh737FmnFZgbHEb8DnLgF0NH1fCIKr55fdi+Gb4i7GkIg+zBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888732; c=relaxed/simple;
	bh=WrkIgi+zshvGxhLfLIup6m0PxGHGcR8zBqwWWiSJGUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0O0NXpfnbmaOvhWKSbxNQcP6no+HpkiipYV9kap8aKetR4F5RCkhEW5kDBWsm4Fp33ETg10pTd59Ny+PMaPXOW40eH3ABFWz3+UJ4h44u6Hg51EM2DeyQ0HNAPcSDOfNBpJWwY8WwtOlhR+7MYT0CGU/vhWF6fk9jR56ZHxLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PATnYtYT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso12536f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762888729; x=1763493529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3g2GDGj5AAay/k4tJ+VCCSovbtJsKk41E0hucw1Xl2I=;
        b=PATnYtYTHXDllw9nDBdkh11UnLM9SWJSGe82d1Qs1Nv2d7LDMNZNWlP+e9NhTWk83/
         dB0f1wGo+2KoAFgTptXGAPOrFEHgJxZqXr6znIyisCpz878Ff/P5qDr0i15KjbMME0Wj
         fByCFLGPvMqbk4HWqML8u7tjuxgp/Lgzg0iOzK2ZLyFCl8Vz11WXOxx8oPf+y/DrKhRD
         Tlkbvj7JKmczlof4RmFiL3WS1qAxKLyS71g9+T9/ifo9FyDWcwPLNPOGXO4fGjn4l7ju
         Fu72hdKkD1Wn1BoDEvQm/H9JaaKNWCNjFK0XtfSLpI30epVECPIPCEUCoM/IYu6Ok3oa
         tn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762888729; x=1763493529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g2GDGj5AAay/k4tJ+VCCSovbtJsKk41E0hucw1Xl2I=;
        b=QsQYzZasS9zRiuClI7BcBylsgnb+7oPIcgaRBqrZNZfx6yaanhziJvF8wDWoRI4fTc
         nMAHKvRzz2ev/SX8jehTsaOvctdAmyVDUedx1ycPUr7WT/HEY1XnmnbUZX5a0UXr7nyk
         QZjgybxPq25u1v03UlAe4PwFeGhlE4apYcIafEvhdwKO2EKudvR89szQr8yCjlIpDFYs
         ZiL6K3IdSDisizE+B5gW7dUcaPiyXyVdMWiD5Qu/mMe/d6sFSworxcGgpWCB3Rr77eA7
         Mo7d2j3tgQoXTqyw6SgJ4LimKActmJNx+0oTdsFk5aCW1a3B8ihva6zrDgy4B3xWbbl3
         /Zhg==
X-Forwarded-Encrypted: i=1; AJvYcCUrRqZCUGLu3QpVk7mX2CA8HQzFCnRnJR859nwaPpjSuUVGliza8bTDBMgUpBVdwZlaLQitq7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzScCbkTdpjyQJld5bZK/XnczMXWGiU5bo+bLlMXkm7Sd/8/K14
	HV5OXOtqhDpMO2nrEQ1a7imkcim9Lw51vtzBP6jTkaq6rG3xMCyJmZeB
X-Gm-Gg: ASbGnctZ9Hu1gd3ZUshAf5uXxmXgxQ8ymtIBHAT9yZGBHcvON3iN97AQY57gxgI9xZI
	9Bd4XxnOmks2dvgBWQnUTMsk5tooLc8w8E7rERuMEJfnLL2IYsDYCzJ2i6dAqunaOtSA6WPY9Tb
	Krc1EKIkDM93uJ/fV+zTfQD/O0GC5R9ACNyO02jdSJ4MeXtrPGFFIh4BD07zb9Bax0/aL6/PHtz
	UUZc7CA+x3JIlRa8ZHMEC/ScJYQnCxzcWMU64pAAIwQ3UJQIJLfC0oUyE75YJsFRUnEifTqUvP+
	gL3cVM5RHcWQ5kUfNnRvhFRWQlPjcyeu07RhwV3yHmIsb4MB2S+uCrCVdrpwOPsyDQY06BdHada
	zcTG4R9NdCqPHNy5drh680FRbVFEMvKIRURG+JcD+TO4IoyHEfkzy4As5ortvtYOnZqKpHJ3gKu
	hsFlI5MCY=
X-Google-Smtp-Source: AGHT+IEIg14BCh/MvTFM8zMUPDwzSAPlSz5/+0VBZJxt8k8qV9/8IPFlPxgvs5CsxqfGwfmV9u0z9w==
X-Received: by 2002:a05:6000:401e:b0:42b:3dbe:3a54 with SMTP id ffacd0b85a97d-42b4bb98aa5mr278784f8f.17.1762888729119;
        Tue, 11 Nov 2025 11:18:49 -0800 (PST)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm28745773f8f.9.2025.11.11.11.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:18:48 -0800 (PST)
Date: Tue, 11 Nov 2025 19:18:46 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] netconsole: resume previously
 deactivated target
Message-ID: <h5tdoarzjg2b5v3bvkmrlwgquejlhr5xjbrb6hn2ro4s46dpfs@4clrqzup6szk>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-5-1654c280bbe6@gmail.com>
 <e4loxbog76cspufl7hu37uhdc54dtqjqryikwsnktdncpqvonb@mu6rsa3qbtvk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4loxbog76cspufl7hu37uhdc54dtqjqryikwsnktdncpqvonb@mu6rsa3qbtvk>

On Tue, Nov 11, 2025 at 02:12:26AM -0800, Breno Leitao wrote:
> > + *		disabled. Internally, although both STATE_DISABLED and
> > + *		STATE_DEACTIVATED correspond to inactive netpoll the latter is>
> > + *		due to interface state changes and may recover automatically.
> 
>  *		disabled. Internally, although both STATE_DISABLED and
>  *		STATE_DEACTIVATED correspond to inactive targets, the latter is
>  *		due to automatic interface state changes and will try
>  *		recover automatically, if the interface comes back
>  *		online.
> 

This is much clearer, thanks for the suggestion. 

> > +	ret = __netpoll_setup_hold(&nt->np, ndev);
> > +	if (ret) {
> > +		/* netpoll fails setup once, do not try again. */
> > +		nt->state = STATE_DISABLED;
> > +	} else {
> > +		nt->state = STATE_ENABLED;
> > +		pr_info("network logging resumed on interface %s\n",
> > +			nt->np.dev_name);
> > +	}
> > +}
> 
> I am not sure that helper is useful, I would simplify the last patch
> with this one and write something like:
> 

The main reason why I opted for a helper in netpoll was to keep reference
tracking for these devices strictly inside netpoll and have simmetry between
setup and cleanup. Having said that, this might be an overkill and I'm fine with 
dropping the helper and taking your suggestion.

> > +
> > +/* Check if the target was bound by mac address. */
> > +static bool bound_by_mac(struct netconsole_target *nt)
> > +{
> > +	return is_valid_ether_addr(nt->np.dev_mac);
> > +}
> 
> Awesome. I liked this helper. It might be useful it some other places, and
> eventually transformed into a specific type in the target (in case we need to
> in the future)
> 
> Can we use it egress_dev also? If so, please separate this in a separate patch.

In order to do that, we'd need to move bound_by_mac to netpolland make it available
to be called by netconsole. Let me know if you'd like me to do this in this series,
otherwise I'm also happy to refactor this separately from this series.

> > +		if (nt->state == STATE_DEACTIVATED && event == NETDEV_UP &&
> > +		    target_match(nt, dev))
> > +			list_move(&nt->list, &resume_list);
> 
> I think it would be better to move the nt->state == STATE_DEACTIVATED to target_match and use
> the case above. As the following:
> 
> 	if (nt->np.dev == dev) {
> 		switch (event) {
> 		case NETDEV_CHANGENAME:
> 		....
> 		case NETDEV_UP:
> 			if (target_match(nt, dev))
> 				list_move(&nt->list, &resume_list);
> 

We are not able to handle this inside this switch because when target got deactivated, 
do_netpoll_cleanup sets nt->np.dev = NULL. Having said that, I can still move nt->state == STATE_DEACTIVATED
to inside target_match (maybe calling it deactivated_target_match) to make this slightly more readable. 

> >  		netconsole_target_put(nt);
> >  	}
> >  	spin_unlock_irqrestore(&target_list_lock, flags);
> >  	mutex_unlock(&target_cleanup_list_lock);
> >  
> 
> Write a comment saying that maybe_resume_target() might be called with IRQ
> enabled.

Ack.

> Also, extract the code below in a static function. Similar to
> netconsole_process_cleanups_core(), but passing resume_list argument.
> 
> Let's try to keep netconsole_netdev_event() simple to read and reason about.

Ack.

Thanks for the review!

-- 
Andre Carvalho

