Return-Path: <netdev+bounces-145053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225229C9395
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89D81F2220B
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3EB1AF0B2;
	Thu, 14 Nov 2024 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GieqKtto"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5E1AF0A0
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617830; cv=none; b=BoWmnbxWW87MfgAJygmMzFE2WcEcXECXo5jv6C8jhUJQVPY0PSclXOfCfRwawiwGYHiH6OOxOcd7830OqfwkqfTsGG54/82pceSAKFYxZweaSrgkq5tlthVio22W27PRdjIxH5bsTFD2VSVfxxFqmUwkhA2moYZNZS8dfC5xcao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617830; c=relaxed/simple;
	bh=Bqpwhbh1PsrXfelNtedaQFAIVcYOpe4+tBfIF852w9c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WL6dwC0o34eQQhK8pALNQVRjH6NHVzWzhcnzOs+HpfIiA/EnBLqmmO1aMp+kI4ZveRR1UYwx+AivjxSB8W0hhIUuMfktts/+yX14d7b5czwFIyn8fW7JhBZDYDpI+xLiWNQ/mXDj/AVK9igHO89r7h9xPNhRV3a1a9OhjGxWFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GieqKtto; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50d3998923dso503984e0c.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731617827; x=1732222627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDHRZd0HO3yKe5La4wlVf9arfCmAo/lcCm4r66g+uFA=;
        b=GieqKttoi14RkU+hmkqNzcH8tcrC8gVz1EWVuFePENR+tZXJSfM7Fp5Et4FsrdD3w+
         nbPfXbTb4GzjqwG3gfvztBW3x1KgoBrybwkOIzUq43xQxsOWOWuKtWvWIZKpoFj2BDoA
         Kn1wx9EOggCi1dbLAc8xLFeY/9mjJwlHWp/C91qgT++1vaC5xlQ3JehVTlHQXJFqJPGg
         EN8XMO7Qgm5BKLL+WdlLjBXXqaI+yHBCuKOxcWjIZkOIiWf58rHxJroZK1UgyPr96+xX
         2clu6yqjWYtO+uHGquTB2BJuGGayU8E7rMzaQUHE+HYqOKJ8l7lmmEkekvVsQTvj3NE/
         QNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731617827; x=1732222627;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sDHRZd0HO3yKe5La4wlVf9arfCmAo/lcCm4r66g+uFA=;
        b=nZ0uhpenzIu2wYrNVOYxEjTOSBGNTlLfCtR0WttxFZrDNExIeRivQ5RyXOIXQZnWJz
         m/wUHsy5XPan1yXTTECpsQL+2BvokPlk4YvqVBbbrKqWNRXolivxWa3oqyMTrNTnAfS1
         HKFr2GK5kGhKdGhObD64i/1FxcdobOB3PnR9FgJYnA9sqzX2MV50OsWMxs6Vn0ZyIydJ
         N7KUsSiKcXj3OE8vU/3Jc25M2NfWIEQnW4of+tH8RChDzpa8iuQzNWFFytfIkUVirug4
         E4tHXeeb0YnvrdPSHsyhsiIqyblst+Sl5/m/z8Xzvyyw4Dk2a9H2A7iFun49esZcY2bO
         abpg==
X-Gm-Message-State: AOJu0YwXy47rlBNo+Rg4SP0VXad0+OVJ/59TnUmzVaWvImMYPTi7sb8s
	/5T+Ty+3MKjwJODrYOXHVVoZTjAxK9xXX79Rs9kQgfP5fR7wvpjh
X-Google-Smtp-Source: AGHT+IF6v0PkMl7E7WRPqXN9CkYVVvMdcbpjFhr4UxsHqJ2uMXEYyNMaD/a190OwMlGOhFBPcQ4psw==
X-Received: by 2002:a05:6122:789:b0:50c:4707:df0 with SMTP id 71dfb90a1353d-51477ebdddbmr719640e0c.5.1731617827303;
        Thu, 14 Nov 2024 12:57:07 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca305a5sm88865585a.71.2024.11.14.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:57:06 -0800 (PST)
Date: Thu, 14 Nov 2024 15:57:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <6736642260849_3379ce29445@willemb.c.googlers.com.notmuch>
In-Reply-To: <ebf7e086-829e-4266-bef5-b4d746aea45c@linux.dev>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-5-milena.olech@intel.com>
 <ebf7e086-829e-4266-bef5-b4d746aea45c@linux.dev>
Subject: Re: [PATCH iwl-net 04/10] idpf: negotiate PTP capabilies and get PTP
 clock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:

> > +/**
> > + * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer value
> > + * @adapter: Driver specific private structure
> > + * @sts: Optional parameter for holding a pair of system timestamps from
> > + *	 the system clock. Will be ignored when NULL is given.
> > + *
> > + * Return: the device clock time on success, -errno otherwise.
> > + */
> > +static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter,
> > +					    struct ptp_system_timestamp *sts)
> > +{
> > +	struct idpf_ptp *ptp = adapter->ptp;
> > +	u32 hi, lo;
> > +
> > +	/* Read the system timestamp pre PHC read */
> > +	ptp_read_system_prets(sts);
> > +
> > +	idpf_ptp_enable_shtime(adapter);
> > +	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
> > +
> > +	/* Read the system timestamp post PHC read */
> > +	ptp_read_system_postts(sts);
> > +
> > +	hi = readl(ptp->dev_clk_regs.dev_clk_ns_h);
> > +
> > +	return ((u64)hi << 32) | lo;
> > +}
> 
> Am I right that idpf_ptp_enable_shtime() "freezes" the time in clk
> registers and you can be sure that no changes will happen while you are
> doing 2 transactions? If yes, then what does unfreeze it? Or does it
> just copy new values to the registers and they will stay until the next
> command?

Yep, these are shadow registers.

I guess they remain until overwritten on the next latch.

