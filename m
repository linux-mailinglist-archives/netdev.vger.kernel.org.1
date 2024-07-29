Return-Path: <netdev+bounces-113520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DD693EDA9
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F51C214D2
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 06:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1CA83A0E;
	Mon, 29 Jul 2024 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="W/VttwCg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397042119
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722235873; cv=none; b=RMAhKKrP0dBXVy4Dkcr/RgtYaARqZeBNIZccEeSd4onvUyfeWCJ/gn5qGWkDp5ypX5TVe+ssaphuLkh1UlqJLuYeAxrbcy7L+m+vhDmPEPaMlGbSLXJU3KmRJYuJq3d0Sq7MkcjhzYiQtrwQttQkXzjXOAxXqLcUW8WQgReOgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722235873; c=relaxed/simple;
	bh=79iaHNtGzI4j6ieUbQzbrAfGyLDbapCl/EG2Vo0//EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5XKwG9TgPHQMod+V2ggrmw8aG+49MI4GDSMEVU32ZmS1/BfHwko8j5P9JCgayxf3cGGeMzcSb361AUohCU+nR84F/O1H1s4MqNHv2xfWOO/gs+KlzEOOzJ4wUtNPROHjgPqZX9Da2NDWf+cxoeUFXvPlkFacKL2+dvfRUc8wR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=W/VttwCg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-426526d30aaso14157335e9.0
        for <netdev@vger.kernel.org>; Sun, 28 Jul 2024 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722235867; x=1722840667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAeqV68+syRSPxL0L9ZcxR7La0jmpQBLxORqfeO9f68=;
        b=W/VttwCgZ0K6cHucLX3pvdM1exd0KXyyWXnzwCg2PRH2uhZJumiZpKcEUAw+69GbQ/
         httX7oIq0OsjwpY99O5W3tgsqMRLbmPJRVaGHGIAKQTkWQiyMuTge/8MkbIOeXSvQFLp
         nA3anxHYL8p0o5S+/QkNWRrzUCSElO2Scwye2kbNPwtjjbDdB9HTxkyF9akTx89LTwV/
         /4PD3MrpPkmgtI+uCX34/shzwf9GGJWLBiNsOhgI84yykgaghoQRrl+AdZcXPqedOEwN
         jL0hIU8tyjrqpb09rgdOoQwNpkH22ZNzg4e9hJeGrm9LKdRSxoKVymJFjlWNTRw37trj
         wsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722235867; x=1722840667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAeqV68+syRSPxL0L9ZcxR7La0jmpQBLxORqfeO9f68=;
        b=bxkh7c2c1fC9InpttHgPFMWrfjBRVwIU505l3j7zROx2LYmVN0wRJXHYHwfZb5tY0y
         RDYoyYH2gbXoVlLJXL0E6CEcFEznZqcDBDJb3d1Zrv8ML292Ykpwftc1Srb3+0apBPaB
         Ey2SALWdRdA8tCZgciy4QAKDsbI3R+s6NuDBdJNKvprSxoX5h+lEUcBlXwcMk2qaEKwR
         KnKKnQiqX1BRwhxZm2rd74v+T8wH8fN0W6smvbdyKrVXbucMSA2y+R0lAvF/OkGuSilM
         cIeCVmNayIyqy22CLjSFuk4AmdgSDEXgrx2ymKhXEOPdG0u8lR3f8mgM1LSTKWzun60F
         wByw==
X-Gm-Message-State: AOJu0YyvtqqqgXWBzzkJOJ0p3bfbyEINMtBWhif3HB9lvXNN7TaCpvMv
	GrEN2IeNgrf8xwUlbk5H6uf/8PKfGcRAaCTlwZTp6RRAIMbpXZqKPhHh18X4X2c=
X-Google-Smtp-Source: AGHT+IF89LRy5yYijbVe9UvoIpeUrKbAZu37EZCSr3RNAbskw5XWu7SCcs4lLksOoXv5ncdLj61DIw==
X-Received: by 2002:a05:600c:3c96:b0:426:6000:565a with SMTP id 5b1f17b1804b1-42811d9c562mr41715635e9.16.1722235867199;
        Sun, 28 Jul 2024 23:51:07 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281e72c21esm13174405e9.40.2024.07.28.23.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 23:51:06 -0700 (PDT)
Date: Mon, 29 Jul 2024 08:51:03 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH RFC net-next] bonding: Remove support for use_carrier
Message-ID: <Zqc71wrJfSKwMuqZ@nanopsycho.orion>
References: <2730097.1721581672@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2730097.1721581672@famine>

Sun, Jul 21, 2024 at 07:07:52PM CEST, jv@jvosburgh.net wrote:
>	Remove the implementation of use_carrier, the link monitoring
>method that utilizes ethtool or ioctl to determine the link state of an
>interface in a bond.  The ability to set or query the use_carrier option
>remains, but bonding now always behaves as if use_carrier=1, which
>relies on netif_carrier_ok() to determine the link state of interfaces.
>
>	To avoid acquiring RTNL many times per second, bonding inspects
>link state under RCU, but not under RTNL.  However, ethtool
>implementations in drivers may sleep, and therefore this strategy is
>unsuitable for use with calls into driver ethtool functions.
>
>	The use_carrier option was introduced in 2003, to provide
>backwards compatibility for network device drivers that did not support
>the then-new netif_carrier_ok/on/off system.  Device drivers are now
>expected to support netif_carrier_*, and the use_carrier backwards
>compatibility logic is no longer necessary.
>
>Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
>Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
>Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>

Looks great. This should have been done like 15 years ago :)

