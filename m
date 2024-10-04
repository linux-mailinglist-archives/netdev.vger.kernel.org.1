Return-Path: <netdev+bounces-132127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C9299085D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E831F21B5B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B91C75E8;
	Fri,  4 Oct 2024 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="L5YBQtlU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58041C75F1
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057434; cv=none; b=ekPYlvWJSwnmgzcNS/fBd8hmXavLCzLR7xyEJxM7XvaJqIw2iLDVysH2AB81IOdD2192frWMTuGUm65HfYTvdYo7VRwVk46/7eHEJpETqAGgrMZv1+2mcDfVli8sOjan5Fz8bVaFPFMlV2d+ne/vakA83Ew0zTer/eM8oeqxfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057434; c=relaxed/simple;
	bh=6qUnhJ3HkOiQMqVPEwg1FZLFHL8MK4xO8kJJsUz2lbU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HS9651s910uE6j07spZ95dMBJiX4EEqO3zGJGEAXE/yHutjUYh3hIzTEtk9/Rh/V9ZHJHX1bMPBOFGuFpLclOKxukTHXJQwtFKTzNDN8OrqdeAbSJeQl1NthLVMBTOlY6Ittj0oYTZrV6yp4kj1lLXGCnvYb+q7VUYI99EaHGjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=L5YBQtlU; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2876ef56d8bso812268fac.3
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1728057431; x=1728662231; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qiCRUv8sasmLrgKlNrOmkIPMkO4O5RpewPhLiBDPj4w=;
        b=L5YBQtlU5GBtvCZra+KxljZAK4kyvw9XK1TFVhMGlqy2ahlSe42fQcl7WPvLaeG6me
         b7F0fas2jPNCN8GX3YZwwFXrZteQbQ3O41M5VKEeA0R1oVNbJ870PXs6FqKmeUZh4irI
         ivkbrEimaGeyAjJbRmUdlUasjJ1x1UCrBVokWtuVEqZmIZV2dkFBX7rhdMrJZDO/Rdan
         6uEjfPpf14FY83+tfRwF/r8fWRYO5V6rI8ZiSiX0+DbKbht0979HpLWbaKcPaKR07Uzr
         ZV9qDvpkJnLZbLZFBxOP+oSiZfAtUOlBs3iBI6aywFOusyF/L2O5S/aHfNzUBRjCeUaq
         Fb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728057431; x=1728662231;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiCRUv8sasmLrgKlNrOmkIPMkO4O5RpewPhLiBDPj4w=;
        b=ahOVlXwOPRQHmM/8r0cjIttuClC8qU5g9uHrqg8pa1JFQ5WTa4J+LFDu4PBI2jp6Ns
         AuQUeXBvuZ243TBFBykymaRSu8ejx6UVFTX2Icq3asir3ilKGwMsBvWa1TL20YmAQqdZ
         utGRIi9KyyodVtANWNpxQuMD0BGYNc1kOZjkAjhd3IIe9+xFZn33EI2i9knlOvvBk2ay
         4F8ngZ5Qc/FoI2iymA2LBhAQc65FgRQS5VsYyBiFLJ4genn4se6V0ZPswaSCKh4SW4rv
         RgTMQetmZZEF4+PWnF3shsDZqoz1bvdW1M/rHBigm7Hs4F9Am7W9o1fIvRIwysb2Cjrm
         Rn2w==
X-Gm-Message-State: AOJu0YwiPzqhoyl+4th7I7AdyaAU/8ExhlI0HfEVA7VppNStVXyNH2TW
	MRvwN++ZZHPXA7OAwVLRVKu8riG6Wc8YWoM5Le+C0IWJAPGsM6EaT+alKVIJSQurUKA5RALPpgw
	JaspW+0nQYAYFQ+toYURbuSXhZmdIfub4T4EGnSWFaET1CGp13pFPdQ==
X-Google-Smtp-Source: AGHT+IF3jHrztHAz9ipuuGkl40uYWuAQnFyFwiehCcPOH/H+2pub2mw1j04DDILsCstsci52Pr22E6sWDETMLxIa5tM=
X-Received: by 2002:a05:6871:689:b0:26c:5312:a13b with SMTP id
 586e51a60fabf-287c2007c2cmr2141930fac.30.1728057430875; Fri, 04 Oct 2024
 08:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ryan Raymond <ryanray@umich.edu>
Date: Fri, 4 Oct 2024 11:57:00 -0400
Message-ID: <CAFd0U8WBDCzoKrV1FR-tqpXF6bFhMK+5oxC=tVuaBfKg7EmE4Q@mail.gmail.com>
Subject: IP Forward src address cannot match network interface address Inbox
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, all

I am working on a Linux networking project. I have two interfaces:

tun0: Address 10.1.0.1
eth0: Address 141.14.41.4

I want to write to tun0 (from userspace) so that packets are
transmitted through my virtual network and out eth0 onto the internet.
I can do that easily if I say that the source address is something
random, like 1.2.3.4, but if the source address matches any interface
(e.g. 10.1.0.1, 141.14.41.4) the packets are not transmitted.
I think this is a routing issue with RTNETLINK, since you can also
test this with route:

$ ip route get 1.1.1.1
1.1.1.1 via 141.14.41.4 dev eth0 src 141.14.41.4 uid 1000
   cache
$ ip route get 1.1.1.1 from 1.2.3.4 iif eth0
1.1.1.1 from 1.2.3.4 via 141.14.41.4 dev eth0
   cache iif eth0
$ ip route get 1.1.1.1 from 10.1.0.1 iif eth0
RTNETLINK answers: Invalid argument
$
Does anyone know what to do about this?
Please put my address ryanray@umich.edu in the address field since I
am not subbed to this mailing list.
Thanks,
Ryan

