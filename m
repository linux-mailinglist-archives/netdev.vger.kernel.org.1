Return-Path: <netdev+bounces-166098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F6CA34868
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A93AEEE8
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849981E766F;
	Thu, 13 Feb 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnVoDBTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFC1E9917
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460934; cv=none; b=YDktDOjSpwqb5kRsrm/oHyXiCv0qJzS9jKzQ33NFd/DmXc2Lv6EIBDIfbhEQFT9dQfHq8jjmpDa9dx8JaU93j+3n5m+c2BlzWi/MLmySX/pD7zgehKSDYRqImPfuepzY9axlA/Ur6ZPw20Gq8L4J6W4PfdbKz+ZKM2VNY0e6tpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460934; c=relaxed/simple;
	bh=Lll1CCPLwkfgIlRh1IaWBjMMzOUz9sjekrX1WzIWZkg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LsD3Y+vLCWkOHcSToRFiES2GJSuqbhaL+p3FuQoU4ARkt1jIktfgodBd+sTmxZJu5T89hWhGbNHMqHPndfNAE4QPdPLrQiPQ48keHmJqxksWHI5i7OUp6xBZ24rm/igU81S+hRexxJ9JiVT4HgUf/YL06JV5jLdDIauafCuTQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnVoDBTA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e436c59113so10526856d6.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739460932; x=1740065732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUuM0AG+RQPU70pb4GEVhPpvGfRZfs7AVxCRMkCj6eE=;
        b=OnVoDBTAGAmGFSi7WH5Sk8j4U2Z+nu6zsiwKx8nx9PnaRCa2Z4mUIfWvb4zvEH9yJk
         XxsCG5h3YZI3dvF4VaDutn72fpPEVi0daqNvRJWy5t3jyJNSbCjBp4s6uY2J5rDgj+fE
         h3nJw3kzDCZg6NbZE2BBPVBb62V6xiqunbtbaf6nzyS5Ufg7c3ytl79rr/LZfKDsQlcE
         oZmHVdVR1ZNZ/26ZfGQ+kbzJIR+7Q71ntSy3I70ymL1IH29YO0JRACW//krKXN/ltrlg
         SiLlG3Nbebnfpirc0o1g+jxOnSlMfxLSz+sOZTaHPZ5zVcP0t6zG+M0dJ/VI89CruSvN
         2qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460932; x=1740065732;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nUuM0AG+RQPU70pb4GEVhPpvGfRZfs7AVxCRMkCj6eE=;
        b=hJNSQssexMDFKUs2gjLgxo51pVEh/NHJ3Wwl6k5Js2Zijk1XNf1/J24wgTtSkqgqPB
         Nd+Dvb1/MYk18sC8K156D9qhpaiWMklYgPFBK83BHpQL+gzx4GMgdzFdYEbVcxrWbQwr
         ikRXBDB+VQJE+cQ6HyP2m5ohOsrkTUcMuwqqu5H+B1afcG80Gxz3NbBKLaQgv8a+ykrv
         wJLc8NzFs66tHjAiWGrkx3BijzTf+EbTWVU9tE0aatQ0QeCrQobtL1HTgIs/MVnt/uhX
         4izmKCkLzzLIvUx2wiXd05HaF++FvhJkfbnCIOXxXtGqO+HrjgNR1bCm7Yqz7JVMeKfA
         9yOA==
X-Forwarded-Encrypted: i=1; AJvYcCUuuKTaWBb59R9WBvcoryBUJxIMUY213mqbb+Syuypdzosct6pdP78d1ptBQDmdWo7Iw9otwt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrU1UHGG0jxfIc5JUCRdsBwOd66h1fwGEme1/HNsIuS67NL7E
	eCsBl2UeWm/ndy20AWMD1APw4AWyIuT9hyXky/U4ALGX4R3jFK4C
X-Gm-Gg: ASbGnctboEWjoYEKBQiUY6inzSps6HX3ibNSVIvIVZ+B+xmSO/63OC+vNHxXx5c6so4
	WRCGwzDslLbCJ+K3q80zykAeiYYk8pZCxtnfjewSydBh0+2W918pd+9xYHtpNPFlhS25enkZ8cL
	WDmiNFyshZpytXnk0ey0zQEN6s76omOxv6J7SR/DOQV43TNbJIgx6ZzsNWLHc8O1esrSuJ77ETD
	Juz5wIDLynpUfQdv2DQlbHWAIaMnUFlLbL+qNdwYJdQHOwISpWBgE+LSQwlYPCP0RRdmthcvWPb
	A/hkzn4lJbAezSEJoL2T9u2Q9MHrRiPBDW7oxUwUzBnOiBh/XoC+Gu/3qGY5qNs=
X-Google-Smtp-Source: AGHT+IGePoksf5y5sn8PBP3RBeB0IqJsndqaFyChV6pEg3ldPvVOA+ghPNAodrlhm24b6RzjT/1lVQ==
X-Received: by 2002:a05:6214:2488:b0:6d8:6a74:ae68 with SMTP id 6a1803df08f44-6e46f8c85bemr92931586d6.29.1739460931729;
        Thu, 13 Feb 2025 07:35:31 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dcf869asm10453776d6.120.2025.02.13.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:35:31 -0800 (PST)
Date: Thu, 13 Feb 2025 10:35:30 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67ae1142e9bdd_24be452947e@willemb.c.googlers.com.notmuch>
In-Reply-To: <d5ff9165-a221-4ab2-ad9a-3f5b025f09a3@redhat.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
 <20250212021142.1497449-3-willemdebruijn.kernel@gmail.com>
 <d5ff9165-a221-4ab2-ad9a-3f5b025f09a3@redhat.com>
Subject: Re: [PATCH net-next v2 2/7] net: initialize mark in sockcm_init
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 2/12/25 3:09 AM, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Avoid open coding initialization of sockcm fields.
> > Avoid reading the sk_priority field twice.
> > 
> > This ensures all callers, existing and future, will correctly try a
> > cmsg passed mark before sk_mark.
> > 
> > This patch extends support for cmsg mark to:
> > packet_spkt and packet_tpacket and net/can/raw.c.
> > 
> > This patch extends support for cmsg priority to:
> > packet_spkt and packet_tpacket.
> 
> I admit I'm a little bit concerned vs possibly impacting existing
> applications doing weird thing like passing the relevant cmsg and
> expecting it to be ignored.

We have a history of expanding support for passing variables by cmsg.

These APIs are intended to be uniform across protocols, at least
across all datagram cases. Existing behavior is arbitrary and
unintentional, where a new feature was added only to the protocol
most on the developer's mind.

The goal of deduplicating is exactly to avoid more such arbitrary
limitations as new fields are added.

> Too paranoid on my side?

Not at all!

For correctness, besides code inspection for this series I also
relied on existing kselftests including cmsg_ipv6.sh and
cmsg_so_priority.sh. I added a cmsg_ipv4.sh to verify the subtle
routing point in patch 4. But that is not ready to submit yet.

