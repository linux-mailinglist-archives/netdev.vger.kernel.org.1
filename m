Return-Path: <netdev+bounces-163929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A535EA2C0DF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44773A3D92
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C21DE4CC;
	Fri,  7 Feb 2025 10:46:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218A2B9B9
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925188; cv=none; b=DMLKSP7txZNWGXtoEASV3x7v0DvfJb98vrruIwJodxLXsixVXYdgucjg7te8W7ERnVtVpBCykzRtJ+oH8yVYwSb2aTP4ofKY0Te3tVgbqFViTPYkjf2G0aGvvPEEI/lGiRjKoUnchUKv+x9eyI7RGFsOmEO/pIY/3UXxSdx0YuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925188; c=relaxed/simple;
	bh=S8BEUioikGV8EMHN34wnAV9FOY6Vzf810Hmb91jCh1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmmTaNZxeh+8+FeuXaXYIcz02jggADaa1Y8YUdJBqoqDdfNWm9/v02nYwC4yc7eVqjYnb/jkF1ScJIK2ej27b3fWFvcuKDsY0TjOCeLFk2LwAaaPJZD26wcSZX55gGG6AL/TT4zzw6jBJDWDpWLb7A5CzAtsm6NRJMh895nV/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de4d3bbc76so558669a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 02:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738925185; x=1739529985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMML7YI3PexaCVh6ArBfZL4NKuO+g4WP7O8iotQFLRU=;
        b=t2D4fhzLvM1WWP407dr1BjzwUA7ZoLdz8Td0hGEd/xcui5cL+d1wyjH4hEvTupV+lQ
         CfyOhRroNzhU4sD0P+LyEHdAyB5fMWz2rahFLnI/qCuxka1Uxfosc2oLvTg+LMfyX+Jt
         43mfqAQdg0Mhb7yqOUy796GkCIF6xBbpMyKwG2RQDxR9C5bfPI0vThJsn91QaB4ERDBt
         fY/PElZWdYvX2vFdaKZznj2FOQx6FLjqxKKoc3V/hvEYn++Sc3Bx+0v7YxuBKBKBg410
         BWVa7d/o2MHNwA2pBRuiA0jc3ALXebTDgmPD8JQARzn3uG8hCOn+KeSWbP8ff1ip3kec
         n+9A==
X-Forwarded-Encrypted: i=1; AJvYcCXWfvi5sht0u25FFu1S++Uc22ImfsFaOFM09tDYzgZI8C1Asn7yQahxsrkudXcyWGvEvGje83g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBuSoj45a+VN/6l9yegjvy3Ac2HMv8QIFNZdcMk7MNUZNjwC/
	rLTi/wKx7ZMPPu/QHPPGkmOcEv+L0jHvho3uXwp4zWwD+yEnxcJv
X-Gm-Gg: ASbGncuZ7E9d/1cDMnsHuXcmQy62Bfd9v3ImbCesnENydX8zsawJ0HJ0GLGiwjm9Ud1
	GQ/fZBarn9/gP6aO48fhYNa3F/cJwCJhUOuI3zqgrVt5zTHuVm1o53riK3Y0BiEQ1Rn8F4IaXCo
	hsN9QJTY8V+HEGwczFsRxynEh2hfyX795nHpL0hr+4rFgRfKbyaLHC228kG5zqypFL/5XAxZiIs
	HSLaXD+/eJXUvWePUvKnjdNcwOkdnlRnmpYrBOAb2wTu9jsD8OQrpm7rinujjQivEa1VmL5KJRX
	x4RKow==
X-Google-Smtp-Source: AGHT+IGLQLtHKYPj3Aci2Und3oMdmCA9Z0Z/Qz4MS2K84OHd7W7Vi/mHSHaH0ZxkXfZ6V5/QAFpYlw==
X-Received: by 2002:a05:6402:42d6:b0:5dc:5860:6881 with SMTP id 4fb4d7f45d1cf-5de45023562mr3440585a12.19.1738925184521;
        Fri, 07 Feb 2025 02:46:24 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf9f6c4e9sm2246373a12.66.2025.02.07.02.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 02:46:24 -0800 (PST)
Date: Fri, 7 Feb 2025 02:46:21 -0800
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, edumazet@google.com, kernel-team@meta.com,
	kuba@kernel.org, netdev@vger.kernel.org, ushankar@purestorage.com
Subject: Re: for_each_netdev_rcu() protected by RTNL and CONFIG_PROVE_RCU_LIST
Message-ID: <20250207-active-solid-vole-26a2c6@leitao>
References: <20250206-scarlet-ermine-of-improvement-1fcac5@leitao>
 <20250207033822.47317-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207033822.47317-1-kuniyu@amazon.com>

Hello Kuniyuki,

On Fri, Feb 07, 2025 at 12:38:22PM +0900, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Thu, 6 Feb 2025 07:51:55 -0800

> > Are there better approaches to silence these warnings when RTNL is held?
> > Any suggestions would be appreciated.
> 
> We can't use lockdep_rtnl_net_is_held() there yet because most users are
> not converted to per-netns RTNL, so it will complain loudly.

Right, so, I understand the best approach is to leverage
lockdep_rtnl_is_held() only right now. Something as:

	diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
	index 1dcc76af75203..0deee1313f23a 100644
	--- a/include/linux/netdevice.h
	+++ b/include/linux/netdevice.h
	@@ -3217,7 +3217,8 @@ int call_netdevice_notifiers_info(unsigned long val,
	#define for_each_netdev_reverse(net, d)        \
			list_for_each_entry_reverse(d, &(net)->dev_base_head, dev_list)
	#define for_each_netdev_rcu(net, d)            \
	-               list_for_each_entry_rcu(d, &(net)->dev_base_head, dev_list)
	+               list_for_each_entry_rcu(d, &(net)->dev_base_head, dev_list, \
	+                                       lockdep_rtnl_is_held())
	#define for_each_netdev_safe(net, d, n)        \
			list_for_each_entry_safe(d, n, &(net)->dev_base_head, dev_list)
	#define for_each_netdev_continue(net, d)               \

Which brings another problem:

lockdep_rtnl_is_held() is defined in include/linux/rtnetlink.h, so,
we'll need to include 'linux/rtnetlink.h' in linux/netdevice.h, which
doesn't seem correct (!?).

Otherwise drivers using for_each_netdev_rcu() will not be able to find
lockdep_rtnl_is_held().

I suppose we will need to move some of definitions around, but, I am
confident in which way.

--breno

