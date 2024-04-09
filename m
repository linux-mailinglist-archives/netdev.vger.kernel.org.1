Return-Path: <netdev+bounces-85944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6689CF5A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 02:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B466B22F8F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 00:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC519B;
	Tue,  9 Apr 2024 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oNhqUvFG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F958376
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622601; cv=none; b=rmHOSD1ks0kErc1D4c90UNLP3rVJjk0wuEukHQf0DpWxuzVQaOpdGXCcaIlrXdpWTEGAcYikVuuonqhJqFFEVs64fNJ2O25tGPBzFk2+uKqIhEnm7sqF4nFWdWQv5fcGjqMUyXSmbPOOXCFW1W6FVAvsm7TDCG838EYZqoIebXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622601; c=relaxed/simple;
	bh=oZLDBlA1nPevI7FROhEMGCvMso7FO137XbHDw0bkEUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4meIuOnG40dHoxkyKJj0FYy8daeBI8bsoqaLfwJlrLCr4/V2uub93gd3n1Gow6OQweb6mzrMbvb+4zVNM7PmL2nSsLjs4UBC3j17mQyMuim/D6SXIKA5RjcLKpFslAVR5oFgKjBtuowthYpW9Yz3Yta0CDhKFzAyy5QEWGjehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=oNhqUvFG; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4199461a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 17:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1712622597; x=1713227397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvTUU2S3iT1pKlvxP6nFgnJOI9ifHnEu5c/nHYKCF4U=;
        b=oNhqUvFGSYtNBcpn+V5PJqLLcbwIrTTuPtH1ib89zpzaPleZRfaqY0z6S/AzI9i0qG
         74Y8CzGIDtIFD7p5ufBmxfGpwtq2zzFE5RPVeD5nit5XCD2oTgJdo6OJQ8BBAmNPM2wG
         nDeysvgY1l6uN4rd+l0X8To23YxctsM6ZTzwP7puVPdeBeWhn2ex6RbF4wYl6jXVHXAP
         Mzbacs7dmxWZEPoUtYYAsDX58OuVqQN9DSne4SUghHXgGnW/XCJf2wec7nif2XVP6bs5
         05coLtJvUgEzjqhYOGZmtzaBZZ/W+mcuLxc4XiWuM9bj9xIuLq1ujNxd20TJf51afzAq
         0bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622597; x=1713227397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvTUU2S3iT1pKlvxP6nFgnJOI9ifHnEu5c/nHYKCF4U=;
        b=OdQ981MVaUGOuvcNO3m939t1sC1qXPHEmsC0XwivFLFYRGhCWX01u49v3Z43rzewe+
         IKEw1y1sKneA8EJqJfwYMFv4mN42eYzB8uRntze9lsEhUdUnu7D3MaJgP6BeJWkU9SrT
         eO0TD26Yeet1ssavmJlrBNwqzkkisnWiaBeK7m8x4PLW9K7wgTtPjG9Li57dcT2Ce/yO
         OG+BIA7vIaSytsean5ND47P3Y3QmCa3G4gnCI1JwkGfur6WwgBWfYrWJkOv4itYV0DBz
         7lTCWpABonykTROsHM4dLXHLB72PsogsceqI/Vgv96dLxeYDooktxmHcm8rDKRw1uoV3
         YIiw==
X-Forwarded-Encrypted: i=1; AJvYcCXLeTIslb4lQgU5Otsm2aa+ETvbQzbybMImaQmFv6QpJ0bTz9oK7O67mybp0VjCaMiMKK1QjY/IMQZ/Sen8zIbZUvyTUXyF
X-Gm-Message-State: AOJu0Yxsw4J2NyPnojEnCdjST/hWw7JWlKVftkytzEnISL1AqFb3VUDM
	HTLj9hUpdin8Z1uKWMWFR37RIFOKsQhx/FFB56d6y1O4U/3ypndzMO3N7hDPyBI=
X-Google-Smtp-Source: AGHT+IGmdKyCEjVPdysefUJpM6HuKaHjMSRYMw62tZJdMXuUSyaHpiDY3wi2cCL3lWGC8UfZl+AI2Q==
X-Received: by 2002:a17:903:234f:b0:1e4:5b89:dbfe with SMTP id c15-20020a170903234f00b001e45b89dbfemr3041427plh.25.1712622597273;
        Mon, 08 Apr 2024 17:29:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b001e3cfb853a2sm6133388plg.183.2024.04.08.17.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:29:57 -0700 (PDT)
Date: Mon, 8 Apr 2024 17:29:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: renmingshuai <renmingshuai@huawei.com>
Cc: <dsahern@gmail.com>, <liaichun@huawei.com>, <netdev@vger.kernel.org>,
 <yanan@huawei.com>
Subject: Re: [PATCH] iplink: add an option to set IFLA_EXT_MASK attribute
Message-ID: <20240408172955.13511188@hermes.local>
In-Reply-To: <20240408123458.50943-1-renmingshuai@huawei.com>
References: <20240403032021.29899-1-renmingshuai@huawei.com>
	<20240408123458.50943-1-renmingshuai@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Apr 2024 20:34:58 +0800
renmingshuai <renmingshuai@huawei.com> wrote:

> >> Kernel has add IFLA_EXT_MASK attribute for indicating that certain
> >> extended ifinfo values are requested by the user application. The ip
> >> link show cmd always request VFs extended ifinfo.
> >> 
> >> RTM_GETLINK for greater than about 220 VFs truncates IFLA_VFINFO_LIST
> >> due to the maximum reach of nlattr's nla_len being exceeded.
> >> As a result, ip link show command only show the truncated VFs info
> >> sucn as:
> >> 
> >>     #ip link show dev eth0
> >>     1: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 ...
> >>         link/ether ...
> >>         vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
> >>         ...
> >>     Truncated VF list: eth0
> >> 
> >> Add an option to set IFLA_EXT_MASK attribute and users can choose to
> >> show the extended ifinfo or not.
> >> 
> >> Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>  
> >
> > Adding a new option with on/off seems like more than is necessary.
> > If we need an option it should just be one word. Any new filter should
> > have same conventions as existing filters.  Maybe 'novf'
> > 
> > And it looks like not sending IFLA_EXT_MASK will break the changes
> > made for the link filter already done for VF's.  
> 
> Thanks for your reply. As you suggested, I've added an option
> named noVF, which has same conventions as existing filter.
> Also, this new patch does not send RTEXT_FILTER_VF instead of
> IFLA_EXT_MASK, and it does not break the changes made for the link
> filter already done for VF's.
> Please review it again.

Did you read my comment. Any new option should look the same as all
the other options in the command.  Is there any option to ip commands
that uses mixed case? No. Please stick to lower case.

