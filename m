Return-Path: <netdev+bounces-132335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05158991454
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 06:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9255A1F244E1
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 04:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93B25761;
	Sat,  5 Oct 2024 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLZBw+Pv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89945C14;
	Sat,  5 Oct 2024 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728103153; cv=none; b=NCCsAmzG0cu/ve9OKceGQ2ZXjSXIJ+3SyJV3HNPbm5qk540YZ/CR/1II7F/DBVyWN+U3Xybj31euus3rLTj6cdP9TcrhAOIppwuvH2/GQy7WRsmRFt3eckE2aXL2HsOaMfmtEFb9eSiv3nc7MxWlYcwrtNqPKBoSthvsPJSJEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728103153; c=relaxed/simple;
	bh=EnAa6NGA4V2q6WOYAXC4Cb73ghzqqRX04lsYm/I/9go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhOHA7xWKoXcdBMe4yR5EVXKUwV1rvf5OmNdpjvlNlc0oofpXwZsUZN4p2jHQqoYyUoDVrHbUJg45mH4cAKgk7IlX4Z6Qca9/LBGzNPV7YDi4YS0hklk1fBRXlQQK0sC14jOovye32bQTFlRcQJmRq4XtU47AQ6mfoY+fwAv23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLZBw+Pv; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb2f272f8bso23665536d6.0;
        Fri, 04 Oct 2024 21:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728103151; x=1728707951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly0zwz6jtcDwv/YYeb/3GBI3NjGskGr2bWS4kP26DnU=;
        b=mLZBw+Pv2FurwyqyNXQAkU/KcboTr9Ah+RMkxXTJoOk1HOEywmGSFW3BsNBN9B9abG
         f65h9SqOFGBnDk9ZoRGIe91tnHwtA/E2UdgfoOrqeRt+Sla23AMl9xSXSy3/T4+m706y
         pa6x1dusShZhrQNLxmbFytThvILn0ms/5XMhsj1fR7q/rSO/lzfbbCTolRBuvgxjbdS9
         1fSsGSvtwODM2fdDyH7qbGUcLWTGdMOi6ApcqypAdMXx8l+4q03/xR2WIbXnwWgi291f
         lOv9tlAQVzrxKfmkEagBrljl1kIOrOLtdnhe17U/2T7a/Fag9df4XemqzFBRXwvUNUeV
         zE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728103151; x=1728707951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly0zwz6jtcDwv/YYeb/3GBI3NjGskGr2bWS4kP26DnU=;
        b=C7qhG54hQqLgf/oPrcwrgWgGcQjM7yooEqpbbmKCUT45Y7+kAads6AM4MKkN9m4UVl
         RTkd/FiMO6VubpCJucEcadHDNMTb4kmrV4wlkVFsySJxgpSxErhQqa5f6zmtXzrmOzQ+
         aVbqBE0XEbbJyRA/0POe5rVPE7ZeYvkR3O7Hm8maLkNnKYOwlCdq0a8TkF5v7o+FU9/U
         ZAH18e2NiJTbDukDMW4rWQZsFJYEX2uMynnkI9WMAlzql1l78Twg1XHiGcoxyAmXTGHQ
         hLiVNcu3QJvGBio10X/ujpPGd06xmx7jmkKEpDXXAU7wopd3J2/1B1VGSPtqp42tDMhC
         wb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUC7X6cy67Z2n0OHx6nJxpa5hiiE1iCEeZ3fOXXTTdJE6B2fh/qIMYGHY3CnSttkkbI4QqEXupcJ44=@vger.kernel.org, AJvYcCUL65EaWFwZm3aoyJUjHHs+vfevhWC73vGevWjK5CyrT0bYa5XijDRweWakuCfy6eYBSbWO756R@vger.kernel.org, AJvYcCWSq63U/9sD9HDVUdg4h3abQiTUHeWOVuk0MEjlLPbxbh9Cz+derJcjuil/rC0LrCa/LXru0Ia2aP3Q0qw3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7orjDRRMvQgOnVGaYPc+7YcpZuMyFyGTeiZZFHgim6TVt4WtY
	Mh1eVbOPIMrOMXn/VR3l2cLwd62Z8g3DRLhTErTFuJrqdy00iKizuV7rFgSQlyzyddbGjPhtoF6
	nEPNX6dxetsdK/dGkHUdeBdIuTWE=
X-Google-Smtp-Source: AGHT+IEQ4aOefgbRPtK7gQetfNSpu6UVZHXpVAWr8zIMcdq424mAljO19O57h8QNx0l+jPomY0NkKg75rk/NmoDt1tg=
X-Received: by 2002:a05:6214:5904:b0:6cb:3cbb:6031 with SMTP id
 6a1803df08f44-6cb9a1ef79fmr79083876d6.7.1728103150810; Fri, 04 Oct 2024
 21:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002113316.2527669-1-leitao@debian.org>
In-Reply-To: <20241002113316.2527669-1-leitao@debian.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 5 Oct 2024 13:38:59 +0900
Message-ID: <CAC5umyjkmkY4111CG_ODK6s=rcxT_HHAQisOiwRp5de0KJkzBA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Implement fault injection forcing skb reallocation
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, Jonathan Corbet <corbet@lwn.net>, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B410=E6=9C=882=E6=97=A5(=E6=B0=B4) 20:37 Breno Leitao <leitao@de=
bian.org>:
>
> Introduce a fault injection mechanism to force skb reallocation. The
> primary goal is to catch bugs related to pointer invalidation after
> potential skb reallocation.
>
> The fault injection mechanism aims to identify scenarios where callers
> retain pointers to various headers in the skb but fail to reload these
> pointers after calling a function that may reallocate the data. This
> type of bug can lead to memory corruption or crashes if the old,
> now-invalid pointers are used.
>
> By forcing reallocation through fault injection, we can stress-test code
> paths and ensure proper pointer management after potential skb
> reallocations.
>
> Add a hook for fault injection in the following functions:
>
>  * pskb_trim_rcsum()
>  * pskb_may_pull_reason()
>  * pskb_trim()
>
> As the other fault injection mechanism, protect it under a debug Kconfig
> called CONFIG_FAIL_SKB_FORCE_REALLOC.
>
> This patch was *heavily* inspired by Jakub's proposal from:
> https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/
>
> CC: Akinobu Mita <akinobu.mita@gmail.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

This new addition seems sensible.  It might be more useful to have a filter
that allows you to specify things like protocol family.

