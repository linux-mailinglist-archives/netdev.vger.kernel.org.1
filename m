Return-Path: <netdev+bounces-201331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A5BAE9087
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429187A2CBD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 21:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7614921FF5B;
	Wed, 25 Jun 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVxswTzP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0C1C861D
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888534; cv=none; b=MsTp0j5hDQ9uul3hOaLQdSbaluBewNMIO836EH1ByYqKPi7yupx46DdVWjgqFUUYHEpjDT73HBh4JxCuotPXWvIWtgRGfMSGw+P22jw+xG37Ka5uM9KsQlLdYiqzSVxlXo8RPkKsOhR9ya6jwJVsNNX6QtILeqe2Tgj1PNBF0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888534; c=relaxed/simple;
	bh=R6aK2SK5xaIKJ76e7VmDZNW2fVzddiWqi7/tspnSAI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRemEvluHk3LL/CJtuwVizI9avTmia2fgvp4LnFQ4cg71NrTcoaW2qMPe/mO6WqYILriBvouNNpeWEIVmYM/kgGmp2zIT8Hrd2UJ/i5ZGVmICZFSXwJ4YoSK+k94VGUVZb6jSXLDdv+EXG3zm+9nDX4jJ+cWfIYIIjtVwlHrLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVxswTzP; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-735b9d558f9so61324a34.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750888532; x=1751493332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LcsPrnmwpdiAREPonW5wzUj1lxJu3d13dOaUL9gTq0Q=;
        b=QVxswTzPPV2EmvcPqzMpRWhZFxl+hc64RJSh3iZXgpligKllonWJr+9c5g3w/OysDu
         Q72HKbSpoOdMVe+PEkk5zmp33xuRCS8cC730M68/82DoCTDXOtqje35FQ6gOTkKMYX/o
         +HaJ0sKprSe8xNJzwBdUmyzBpyIfXdcor8ojRz8uDcsPM0WbG99p8Vr3gsnB88zcbHoa
         7FHwBqf0wWRWnWfkWTN6BUeuR6wS6+y7h1w5XB9g7ieueJxCvxMNcNATk/Rmzvr6ZwsB
         3WzuVallrNM7/68vJCaqOoAhXn9aj5RSulDLrW08TDqYFD2MXQx0kTedJJGmgZ6aAuIF
         UaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750888532; x=1751493332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcsPrnmwpdiAREPonW5wzUj1lxJu3d13dOaUL9gTq0Q=;
        b=n8uErTDHd/EmJxSWgOPwUqzSmbXVbXvfgqEsjhEiUgCInqed5yfVAHULR50cK3zgCK
         xyPZygLlGavD9WULmKjGTAL7oIuZj5MkHKA8JQqxHYm/THM/5oKVtLgGTQWW6WAOLTGR
         Q7+/w+4rn2xDS1OvdVEggg9UfmYM683qgIfDQWndV63Ci+syx0jWCQRxo2rtMYCFWfig
         KfRSl/8X8nT4RXDef0pXQmBJUkcWA+hKDpzxgRXg7hgD3THEVLt1dtbUSfcgcyPAuqjM
         XrcT+Ket7YkoVsvHEM/IB0OE0ZU1I4wj/rNgjpFFLLbJ7JI2hLFciNrAv8AhO687dU7r
         tQFA==
X-Forwarded-Encrypted: i=1; AJvYcCVdENYx/aATNXVCRdL1VT7bqdbGAKDcAkAvR6MgMvh+JepYULeCMlsdIm8ShkGM/HtcCyXlsuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/gS6jDBG3qxQJQb8c7mmmTTRRXNN0ytohvRKZtbmgkKT01RF
	Oa53tWYyLGMQ9DIAxCiijlcn/kUu+ogw4INk7zrDyR1eXjlmiM/1USBDO2dqwDiVVdijN9bntn6
	Tp0R6/RkIUlEm+eXbMfXsUnLBnB3pikA=
X-Gm-Gg: ASbGnctnl22PAN2EUT9nQHBJsWi+znx4XW86LtEkwI1iFjySL8s1fXn9o6YB+dt+9+5
	zYOhmAtuAQeo12mj/KeO8M/BnkbmJ4TLUlcqLFItyzsjCmLlHZJ3mCH8dJYnBnl5r1JwjwPpRYp
	Y+CWT7+idryofknlh4FIlTfp4wCXEn+JQWG/pG3GGwHtWmk1XvtEABw0JaEVncTER9Gv9JrJIAc
	A==
X-Google-Smtp-Source: AGHT+IHGtVMItDAB/wzAYFCY9guHVXhh5dB23gJcm105MYLqOui7mNddewqAxCNelrCjs38i+mPXDUou5h2Y3rLbrpQ=
X-Received: by 2002:a05:6871:7422:b0:2d4:e420:926c with SMTP id
 586e51a60fabf-2efb1da077dmr3511815fac.0.1750888532008; Wed, 25 Jun 2025
 14:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623231720.3124717-1-kuba@kernel.org> <20250623231720.3124717-9-kuba@kernel.org>
 <m2sejocfw2.fsf@gmail.com> <20250625130404.6c8fa985@kernel.org>
In-Reply-To: <20250625130404.6c8fa985@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 25 Jun 2025 22:55:21 +0100
X-Gm-Features: Ac12FXxTLWKClWGwz53fNgT5vSP3xVVsORrfkU0kI5QVps_HvuYk1e7DTIz7bcQ
Message-ID: <CAD4GDZy-8RNgLvXcS6BmgvAiCW8iEtJCw8+B+1QDOM7gzkzgyA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 8/8] selftests: drv-net: test RSS Netlink notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	maxime.chevallier@bootlin.com, sdf@fomichev.me, jdamato@fastly.com, 
	ecree.xilinx@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 21:04, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 25 Jun 2025 10:46:53 +0100 Donald Hunter wrote:
> > > +def _ethtool_create(cfg, act, opts):
> > > +    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
> > > +    # Output will be something like: "New RSS context is 1" or
> > > +    # "Added rule with ID 7", we want the integer from the end
> > > +    return int(output.split()[-1])
> >
> > I think .split() is not required because you can access strings as
> > arrays.
> >
> > Will this only ever need to handle single digit values?
>
> nosir, IIUC split splits on whitespace, so from:
>
>         "Added rule with ID 7"  -> [.."ID", "7"]
>         "Added rule with ID 71" -> [.."ID", "71"]
>
> and we take the last elem, the ID. We use similar code in the rss_ctx
> test, I think it works..

Ah, my bad. Ignore my rambling and sorry for the noise.

> Unfortunately there is no plan to migrate the flow steering to netlink.
> And ethtool only supports JSON output in the netlink code :S
> Mountains of technical debt :)

