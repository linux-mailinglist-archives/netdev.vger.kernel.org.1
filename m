Return-Path: <netdev+bounces-128260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1CD978C45
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 02:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B1E1C24B58
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 00:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478E44C7D;
	Sat, 14 Sep 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPWqP5wL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0884400;
	Sat, 14 Sep 2024 00:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726274952; cv=none; b=uXZca9aHHK4qH10ClvgL29RG/rMAPDXtr53ZvtVuwVci7tmEDnO+iIA9Tn/EJqoUF8htz1EaSsKoeI12AIwNbnfpv5IXFdZ4X8GVL4xEQ/SyukloHp26LdBGGXARCE9LsQQWrytonpcYO1HGSOdXZ1X4pfCntZUvORnODChQ9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726274952; c=relaxed/simple;
	bh=K9xivYU0+hrTZwM4Ojyq18f8RFbDnzkF86AwTofRwrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSTvuvrG1llr9r4KBmD21GtAGumqHNiQ9KzCMoGqDhKF6zyuz1P8sFVNhPGtGIuUoJbrmy3P/XjK2PsO24/bmSPBX+yaRY5b67hKbkaDsZW4PP7ZCqdv6Rjzq6G+zAmTbtbuzI2C91J5ET5zW69+sj4GnAHDP1Cfuu/TT7nPi/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPWqP5wL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-206bd1c6ccdso13796015ad.3;
        Fri, 13 Sep 2024 17:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726274950; x=1726879750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eX+p74hRvbhEN0eluUV1sJA76UE/eCdpbwGeO4gkg1g=;
        b=kPWqP5wL58YgH6svLUxbyxI4eEw8AL8yfjkrXjqafO+udy/JQOiQ+hBLo3V0YmdblY
         92qLPpX+3M/5JzEQd3dlVc8YIpQtfCZVswSM63H7yjCNPefryJQEBXSEN1ZkJppmIv1B
         EF9IqNTE4MMvHr0bKYTb5J2G40gwOE4oE/RtOOOy9yxVh0d8O2lLTFR48/dijntHu48s
         r5oT5c6SwwWsrpVM2Hgbqoy7dWB1yDvXRGchOKwgEnaFjF7fGTnM4tjHGqA9fB87OcUq
         otbF5Iyeln9RT5hS1Xghke2l82EjyuKtkR2aupk/8jY9t/yDi8yxmFE9hWQqeC6nTmnW
         RCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726274950; x=1726879750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX+p74hRvbhEN0eluUV1sJA76UE/eCdpbwGeO4gkg1g=;
        b=loQliOwSbsw0zEKIUoRFNEjmE8UZZYcNnfCo8OoDwQr3383xQpU82AVcWpNJZA4JMy
         op0dkpiiKVL1D5bxpaHTjpiA0FzNu2hwhU3sAUsLVC9GffEL7XthM0g3UtHBRHIqSPsE
         9YygaiPO1mEvjghH/kEkpCNBWGLx1l5kx47cCb9onrLrbs9/r3yDyWA4DaVKjcDktKks
         0df77gQ//fx5FZi7UKEFLgid076on5DKpbcwerMyQHGPFEhEjzwAOzfoXf46hbYKwyXL
         6wx7BUQz39cCc3vADrdBu3utQ2LB9zlEGcBtcwGh++HwqsWiniB0lz7SWhgYmZPS3X0W
         TnJA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1a5jwEPC7ddah/AH6kt1HPcqvsV/DE4Fmybba2A2rfE/vikKl4itYXqSf0uClr6UVKHD+zG9@vger.kernel.org, AJvYcCWrYCAk2BsHdkkK8fLteKn68tAIv0v4iw+iSUeIpJ7PunR1mAS0Jpsz1JT3Ql/ALV1JEgT8GZiDYlZaHds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdepV62VM3wTneohYmWEt3WOlLZR1DdJ4HpEBK3LQ5Erwuiyr
	YUoBDviXwm05VX9Ej9thNUo3mf2zmF96l2/+6iarZ09KeTTwxBin
X-Google-Smtp-Source: AGHT+IE0PtymA6lAtF1ZyDn+8ZVmXxiHgC1WVLOghFvoPybpDHssv1n4rE8Si2rwJ8H6jnvBhKSPYg==
X-Received: by 2002:a17:903:183:b0:206:cbf0:3089 with SMTP id d9443c01a7336-20782b6942dmr65005575ad.54.1726274950060;
        Fri, 13 Sep 2024 17:49:10 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:97be:e4c7:7fc1:f125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794714d8bsm1829995ad.201.2024.09.13.17.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 17:49:09 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:49:08 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Qianqiang Liu <qianqiang.liu@163.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
Message-ID: <ZuTdhIZtw8Hc7LXP@pop-os.localdomain>
References: <20240911050435.53156-1-qianqiang.liu@163.com>
 <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
 <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
 <ZuHMHFovurDNkAIB@pop-os.localdomain>
 <CANn89iJkfT8=rt23LSp_WkoOibdAKf4pA0uybaWMbb0DJGRY5Q@mail.gmail.com>
 <ZuHU0mVCQJeFaQyF@pop-os.localdomain>
 <ZuHmPBpPV7BxKrxB@mini-arch>
 <ZuHz9lSFY4dWD/4W@pop-os.localdomain>
 <ZuH4B7STmaY0AI1m@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuH4B7STmaY0AI1m@mini-arch>

On Wed, Sep 11, 2024 at 01:05:27PM -0700, Stanislav Fomichev wrote:
> On 09/11, Cong Wang wrote:
> > On Wed, Sep 11, 2024 at 11:49:32AM -0700, Stanislav Fomichev wrote:
> > > Can you explain what is not correct?
> > > 
> > > Calling BPF_CGROUP_RUN_PROG_GETSOCKOPT with max_optlen=0 should not be
> > > a problem I think? (the buffer simply won't be accessible to the bpf prog)
> > 
> > Sure. Sorry for not providing all the details.
> > 
> > If I understand the behavior of copy_from_user() correctly, it may
> > return partially copied data in case of error, which then leads to a
> > partially-copied 'max_optlen'.
> > 
> > So, do you expect a partially-copied max_optlen to be passed to the
> > eBPF program meanwhile the user still expects a complete one (since no
> > -EFAULT)?
> > 
> > Thanks.
> 
> Partial copy is basically the same as user giving us garbage input, right?
> That should still be handled correctly I think.

Not to me.

For explict garbage input, users (mostly syzbot) already expect it is a
garbage.

For partial copy, users expect either an error (like EFAULT) or a success
with the _original_ value.

It is all about expectation of the API.

Thanks.

