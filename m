Return-Path: <netdev+bounces-178136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D60A74DF8
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E48907A4258
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B811C82F4;
	Fri, 28 Mar 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTDO+XQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B771C5F28
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743176638; cv=none; b=pPWPAVhZQeJ4RELjmzfDG3PSBfiSB1fDP1hftki3umN0wsapFKYap/kMWWN8573OQ0GEa5WUXSyVN4HXEy7WN96qpYfznOtwPmqa/xpsyL7QXG9VPuxJFILX05eCwEfUYqke9YDeONSBnT9aHv5XFYRdajwkUQ1K945Z2eXQGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743176638; c=relaxed/simple;
	bh=aM/uOR++5OEtS62Ve7u19hIjWS7ZMq+cJPMp3VCb8H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8eEt2uC7xlTHI2zan8PCyDqLZEnd+rQBbZlrivCh6ABR9Rf8E7jO2Jvo1IYw72aF/hG/fXGCkmSipX0nYGJZTS/Xrf0stpEO5u4OVScdL2ndChXdgp7bJcg+r39QR3CDXKze8znkzNZoVyberIZQR5TyOhVSefzQYYoVWLOb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTDO+XQ2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224341bbc1dso47343955ad.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743176636; x=1743781436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sVhbbzDQ9l30dzJbf/Wz4ciphi5VBBhmH5tpr2sL8lE=;
        b=dTDO+XQ25AaYLoY/khcQz+6xdiW7CLZ0RaSbwa/EGEABdbFWJnTmk27dw2hlGlaj6R
         ZevIt5uB2X7oaGBdkOI4SMvyxkJVQKzTT1T7ID4Y/Opca+sssdKHsR259yLz8MjwxW8A
         VUS199QUPWrJ7EFgOyIilMbgbEc8rxJX1XqJA74n9NPExEZmXqchwG8ijBUwGcEE+pnW
         QogU2J7IZd48yMaewnxVFF4hX36iYU1/X2QIpXMnvJrgfdy65EMzxMntzJR0jcrWmZUY
         ksr9+Q2fbbd1nfeC5dUYFe67M357W6Rk6Gp58pZYM2W4e3R5bzlgJGJoMxvZ6blFd+6L
         Dc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743176636; x=1743781436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVhbbzDQ9l30dzJbf/Wz4ciphi5VBBhmH5tpr2sL8lE=;
        b=O9vJpMCTIqVtesAZkjIcMvjWkQ98dj6gO9QB1KNTs1pDbPmZ0YiFT34sMbToChUWKa
         /cv8Dpl7baqPyRGJW9hB5835XCBTGnIeAEeXjs9RL4SdDhgqVMDlJVY0TDfu80FbwDzE
         GSWB8qHIAG7gDQeZzT0AuRpcr+fErB83mBds0F3BmcY8R9MLflxFLvB4mHe2iGScaHf6
         rRBXxJOXdUe4jno0FyL+3+PD9X4rIe6HWXWVhYPl+LUkscL4ugolsFP4B3E5Xf3oNKnL
         +BB6IDabW4nDXFPFGqQAMVXXZs6JfKhxuQaF0fPDIcyaBXI2pKsPG7ue6+CHG6iFo/4R
         tKIg==
X-Forwarded-Encrypted: i=1; AJvYcCUt04YWt1UgrzW9YAs+VNp6TmtMwIx5/BKz1cbM1m7ITkYW/D7zqYTEjac8mwT3F0NBgkA0sfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjg17iWUVjOeHy6nR+vq4MMhLQjfLtmnKcBBKXFfiglxXyT8lr
	OwPznWaojcPpo0P00y9Zl+J/cRsy6OvlOL9RqDLB92f/1FUKVWk=
X-Gm-Gg: ASbGncuX9OR+bHCGGbypUDSpPzKCbY/mFVlwJskhwjYXyscOk/mhXBQSXssM74l0rOT
	MWmSXyUPVA1/ZdBvOA8wlwcgAEs+I41UR71HYNqWoqRSaFIg2Fl02Rbgv4ZNhPw69/ZdxaarBEY
	PSozguz6LrbvXn4MhMRjsfgxFVwKMzBa2g7X/N2gOtDqC1E9IRRYlpaKWjHR41rnCjJSsuZkBRT
	KHBV54yoI3YVHcx9B+3824Tv7yzxIVvC0bRN9Eww1RKFul3D5+tcqGtiL9Ykv4IHE9JFYQvgATE
	b6H8HQ4Mp1pM6/345TQlNW4eZPKWePB7maQsH86FsAljFDhkyPmuVNQ=
X-Google-Smtp-Source: AGHT+IENs1UvjByAB40mp0rYpqUaOm/mdGxS4A6v3OOL3xRiHmLZ1cj+ciR9PfG+8UjQE+6WNPZ6yg==
X-Received: by 2002:a17:902:e844:b0:223:5ada:88ff with SMTP id d9443c01a7336-228048cc3famr130916385ad.24.1743176636090;
        Fri, 28 Mar 2025 08:43:56 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eee37fdsm19775075ad.102.2025.03.28.08.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:43:55 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:43:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v2 00/11] net: hold instance lock during
 NETDEV_UP/REGISTER/UNREGISTER
Message-ID: <Z-bDuh3oB1ZnIrtj@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
 <CAMArcTV4P8PFsc6O2tSgzRno050DzafgqkLA2b7t=Fv_SY=brw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMArcTV4P8PFsc6O2tSgzRno050DzafgqkLA2b7t=Fv_SY=brw@mail.gmail.com>

On 03/28, Taehee Yoo wrote:
> On Thu, Mar 27, 2025 at 10:57 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> 
> Hi Stanislav,
> Thanks a lot for the patch!
> 
> > Solving the issue reported by Cosmin in [0] requires consistent
> > lock during NETDEV_UP/REGISTER/UNREGISTER notifiers. This series
> > addresses that (along with some other fixes in net/ipv4/devinet.c
> > and net/ipv6/addrconf.c) and appends the patches from Jakub
> > that were conditional on locked NETDEV_UNREGISTER.
> >
> > 0: https://lore.kernel.org/netdev/700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com/
> >
> 
> I tested it using netdevsim/veth and my Broadcom NIC.
> It appears that netdevsim/veth has no issues, but I encountered many
> RTNL assertions in the bnxt driver.
> 
> Reproducer:
>    interface=<bnxt interface>
>    ip a a 10.0.0.1/24 dev $interface
>    ip a a 2001:db8::1/64 dev $interface
>    ip link set $interface up
>    reboot

Ok, so, reboot triggers pci_driver.shutdown which triggers inetdev_event
which asserts rtnl. Looks like I need to bring rtnl_lock back here.

