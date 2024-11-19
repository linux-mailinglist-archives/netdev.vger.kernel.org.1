Return-Path: <netdev+bounces-146055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507989D1D97
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D391F21C0E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2649C7DA84;
	Tue, 19 Nov 2024 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="n9F05P7n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BC3398A
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980955; cv=none; b=jpjKQDfp67cfwILO/9ByXt2pComxteGAGFx/nkm1HkOZqOHL0xBdhjcfomq6dlrTOlDs44h/0BP0M2yRfzGiCx5VA5ofvVVUSZ0nSH03osJZ8jgjT88fSpBan/0Su4VVQJWl5U+tQ5W/UQZARWj9QoQb5VCStY6GWsVEJGMbwXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980955; c=relaxed/simple;
	bh=dLvMTYjrgb9BFkA94XrWUwyB+9EF+9QP227OXd1/PXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IV8DMm3kMSaDhClU2FkT2mzer1Dv8uuEB/uEunnt7VtDKixiq8eUIftnjFpVUCyGboF4tFB+2o+IZ/CPGwO3PGosvHSfvHKi/Va2sQFOH6nrtmHzD56RGIL5fdEKR8/euC2i5A/KFgNGlHLZ9FyBoQPGCTpC7GPEOIBFrlwQQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=n9F05P7n; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f8cc29aaf2so253839a12.3
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 17:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1731980952; x=1732585752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAYr5IUzD4C4m6DtTnVUzjgzDzT8VdlHo09rLjkfrsk=;
        b=n9F05P7nBPTDc9pOy3CDNhtzKgyZI2wrLa6GUllSNm+sBfKa/aK+f8g5zh2qP/LjdP
         +V/fGfjXppCdJXvn9B8sbO7tsaF9JjGvLE/dyrqs5kT3GmWM7+b8iDLuxO0kyPwSzAgI
         BjJz42PCD4UBY4phvNpt/hj50wQ5U13YEE+6PXb6ArP//RSRDnwYt9//018iQS4Hq1lQ
         5JXbZNRoXPprfHTZQstskPinaZNhhBxG/HVUJgv/ezBN3EIfF4DJqo7PtVcGheIJl55L
         fbhp6xsvpWOsDdSebPCXlykC+f5Xiqs6THiuzDCTsyQLJq85PxcoG7Tk0QGv7gqw3c7w
         5Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731980952; x=1732585752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAYr5IUzD4C4m6DtTnVUzjgzDzT8VdlHo09rLjkfrsk=;
        b=ByhX/dNDih7CrDtrauXqjN2NHO3PDApJrj5WGiRE9iM7dZNHiS40/PjmMDlMCyDTpp
         BwlHIYah/vhaC0TUsoHAcN5uMV258wEknVe380UjaTNVKdtGVmxlaICrx43cRGuEBuwC
         do8R/xFYXHgUb7d6SCSSbBv/ciln8UkLuO76HoSBWaBctx1nxmNgDOgjwdTpZR0LLOTf
         fktl/wWtwcMW0hGKaS7eu6HApHxcYRsy/ZIEu4LkpqtbLGs3eWo8vGntPV3B1UcN2RIO
         vdTO8mAzorKUsBeP+7kutQhCu4DapiPznwzFLSNe9bEWY8KTLpWt/hD3yb0ZlZAU6QSd
         lxzA==
X-Forwarded-Encrypted: i=1; AJvYcCXy3m3c0cP57TPCCMlm9V1Fa67+1zBchM77trqJhPAUiPmKwTf91RdswdX22EK/190OK1MDpnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTl7rU6sc+AfwOf6qFebwfQYGn0gM0pkc2YYyrKuE8/C5xKasB
	8yFDrxH1GUUZ2G6Q1Zh4uWHzkJQ5jg5pq6d/aO96AYtht2VGaG6cYffm+mtoqlqkO3PiyEm9LPN
	w
X-Google-Smtp-Source: AGHT+IHv+FZwuIDJm03Wo2JticPfdjNytAqYHYS00rai/LV7Ja4gZ2Oav57Rnao5XvbDTt70SOVlCw==
X-Received: by 2002:a05:6a20:7344:b0:1db:f960:bda8 with SMTP id adf61e73a8af0-1dc90bde950mr20283286637.34.1731980952534;
        Mon, 18 Nov 2024 17:49:12 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477203a26sm6903821b3a.200.2024.11.18.17.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 17:49:12 -0800 (PST)
Date: Mon, 18 Nov 2024 17:49:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Etienne Buira <etienne.buira@free.fr>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug] Linux sends poisonous ARP replies on ethernet
Message-ID: <20241118174910.7fe410bc@hermes.local>
In-Reply-To: <ZzuuSDQZux8uof5O@Z926fQmE5jqhFMgp6>
References: <ZzuuSDQZux8uof5O@Z926fQmE5jqhFMgp6>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 22:14:48 +0100
Etienne Buira <etienne.buira@free.fr> wrote:

> Hi all,
> 
> I found problematic behaviours in linux network stack, which all look
> so related i make a single bug-report.
> 
> The underlying bug(s) might be ancient (i previously had strange
> behaviours that could be caused by this), therefore fixes should
> probably find their way to stable@vger.kernel.org.
> 
> The configuration:
> Two boxes are present on a dedicated virtual hub, both run
> linux-torvalds b5a24181e461e8bfa8cdf35e1804679dc1bebcdd configured with
> attached linux.config file and untainted, under qemu (Gentoo's version
> 8.2.3) as kvm guests using virtio NICs.
> 
> box1:
>   # ip a
> 	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
> 	    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 	    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
> 	       valid_lft forever preferred_lft forever
> 	2: nic0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
> 	    link/ether 00:16:3e:00:00:04 brd ff:ff:ff:ff:ff:ff
> 	    inet 10.0.1.1/24 brd 10.0.1.255 scope global nic0
> 	       valid_lft forever preferred_lft forever
> 	3: nic1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
> 	    link/ether 00:16:3e:00:00:01 brd ff:ff:ff:ff:ff:ff
> 	    inet 10.0.0.1/24 brd 10.0.0.255 scope global nic1
> 	       valid_lft forever preferred_lft forever
> 	4: nic2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
> 	    link/ether 00:16:3e:00:00:02 brd ff:ff:ff:ff:ff:ff
> 	    inet 10.0.0.2/24 brd 10.0.0.255 scope global nic2
> 	       valid_lft forever preferred_lft forever
> 
> box2:
>   # ip a
> 	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
> 	    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 	    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
> 	       valid_lft forever preferred_lft forever
> 	2: nic3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
> 	    link/ether 00:16:3e:00:00:03 brd ff:ff:ff:ff:ff:ff
> 	    inet 10.0.0.3/24 brd 10.0.0.255 scope global nic3
> 	       valid_lft forever preferred_lft forever
> 
> 
> 
> The problem i found is that linux replies to ARP requests not directed
> at it, this behaviour is not complying with RFC826:
> box2# arping -c 5 10.0.0.2 -I nic3
> 	ARPING 10.0.0.2 from 10.0.0.3 nic3
> 	Unicast reply from 10.0.0.2 [00:16:3e:00:00:04] 2.285ms
> 	Unicast reply from 10.0.0.2 [00:16:3e:00:00:01] 2.357ms
> 	Unicast reply from 10.0.0.2 [00:16:3e:00:00:02] 2.368ms
> 	Unicast reply from 10.0.0.2 [00:16:3e:00:00:02] 0.598ms
> 	Unicast reply from 10.0.0.2 [00:16:3e:00:00:02] 0.771ms
> 	Unicast reply from 10.0.0.2 [00:16:3e:00:00:02] 0.600ms
> 	Unicast reply from 10.0.0.2 [00:16:3e:00:00:02] 0.627ms
> 	Sent 5 probe(s) (0 broadcast(s))
> 	Received 7 response(s) (0 request(s), 0 broadcast(s))
> 
> Here, all box1's NICs have replied with their own ethernet address(!),
> including 00:16:3e:00:00:04 which is not even on the same IP network.

> 
> Unfortunately, i cannot afford to get familiar enough with linux's
> network stack to fix it without sponsorship.
> 
> Best wishes.
> 

It is not a bug.


Linux uses the weak host model https://en.wikipedia.org/wiki/Host_model

You can control how ARP is handled via the arp_ignore sysctl as
documented here:

https://www.kernel.org/doc/html/latest/networking/ip-sysctl.html




