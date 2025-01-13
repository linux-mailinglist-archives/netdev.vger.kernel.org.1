Return-Path: <netdev+bounces-157810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3EFA0BD28
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0553A16431C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393025760;
	Mon, 13 Jan 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVCQ+9KW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF881537A8
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785330; cv=none; b=W5mgn+TZlUyt/3Xc9d1fitLbQrtzeKyt2ZkacSS/1otkHl2Mo56T+YCNtwc9S7mjSlqm+r6KqMM5BrYWYkaEg0BIDPSr2HSzOS7HVM+iIVkWLP+KLLltjlxdWJ8p1zWtsMVPP7VVe5qTWaNChht/c5CgT2h/LLula98A4lknuX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785330; c=relaxed/simple;
	bh=EhdZ+oJnpZ5T/ef2hYA0Zwlh05z+fTX+uOwqFs5p9Ec=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=tbRKNBg7xQqfkK0Bp23xdOH+uraOO4xE726W2hmKNDo07/A717ojPQBdHVDCsygW+3th7ArNht2k42tv//pZLg377Zq4AOdOJw6f7xErzv79LnZ8vN+s43veaoI4CejcAb3r2V6MrvTwLm0dApNxjklJBNTGq+EqmTLPD6uJ/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVCQ+9KW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38632b8ae71so3252764f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736785325; x=1737390125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYvSq/ed/LRLc9AQwx2DPq8gnX9t01feqP4113YjQSk=;
        b=nVCQ+9KWgFM2pM/SR5jakJsmRhLK7kJI2WVlZEO9Z8/n/ecVw5yIBHFouBmEgQdeC+
         BLDsIDHuUY2AmeTJpv3EDCPlPw5Vp9RnRSf6CmjVnv7uIn8+hNZ1V0lSw/r9OeGKGiJa
         pq6+P3kr8DdHdA1d+gGN7fi70HclCFttPv2ntIzED4/7TtFIkiEiBUMflMBGIHvfzvbs
         qpNZbor/tblXtwwk4nQrmnYsYFgVLBOR7RxKXJMH9HRS16pXNLAT+rEFkpYFuUna9zR1
         6YIXat8dj7jbkg08sNYs2FqjNqFIlSzd/XtA5oYC17CXEUF8EtSvXobFWQlFhzRabHNj
         X1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736785325; x=1737390125;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dYvSq/ed/LRLc9AQwx2DPq8gnX9t01feqP4113YjQSk=;
        b=F3loaFqWN4mJauIRCW8lGzUTx9r4hLyMfZJW77hTs7zowBhtLuYI04GEqeNNxdEBhP
         SJKObuYb9l3p9uH8xlzS11xsSSgdsUuo25fqSlN89HgAn42DbxFxX7I0rS2UZyu4Eni1
         afhbz/if7BtMNhbaGcRf71xpVOcebGfzu0p8jh4WkCNw6tdmHdn6ZdsORfwBqUT8rwLi
         b3e6HWvZt3Bykh8KEB+aQ90j+a6LKyAvDSfwe0/F+mdLzw65i+fLY1Z4Do2LG0cnp3SK
         TQwC92e5tEXxnr9DDQ1QGHb6sv5Ib5vapVWExmetQEl2koTnVpbg0x+ss0ss/sBIFpfD
         WJIw==
X-Gm-Message-State: AOJu0Ywdci9SDUnaTJgN9FCZyh7Jbp9u7VzpBbVKsacc55PlSWSI5Gh+
	cxbH+cRHsaF78emP3bjOhJ0kX9SMb3uPBVjH8o4K8+Omr1FhjpWPHeR8lGZl
X-Gm-Gg: ASbGnctcqp5y4Z31pEd7vwDdSn5Bk0h4sr3JdDIlW5SknTgkMQP4iWhYCDhz3j4shnN
	zI4LmttxlhF3bcqz/AtIty30kuUFYDZOVrpMGAlvXJgoYkAqgCBjeVPMUJEtkNAMpTx7kzIq7bg
	xGjgdM9XdKp0oSc7mcg2wqcxPcc2qHUBs5zMXPxViUU1jOG5V71BN+TaLm/egkNBbeatTWbw9PG
	MhLSAp5QogKoL/mkQjeDEMDVEW8tQO2r5S5jCvcq2zeMsspwtz95OVz2gDbWtulQrw=
X-Google-Smtp-Source: AGHT+IFgkLkfyfE1tSjLIcvVF6EE6OpvYYfuwurVE5Zyr5AS/ZYuNUsns15OtCImphdf7P1xJ9eSow==
X-Received: by 2002:adf:b1db:0:b0:38a:2658:bbc7 with SMTP id ffacd0b85a97d-38a8730cef4mr12487393f8f.29.1736785324811;
        Mon, 13 Jan 2025 08:22:04 -0800 (PST)
Received: from [192.168.1.57] ([82.66.150.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38f176sm12811156f8f.63.2025.01.13.08.22.04
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:22:04 -0800 (PST)
Message-ID: <6a9db6fc-63ce-4070-87f8-ace141c89645@gmail.com>
Date: Mon, 13 Jan 2025 17:22:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandre Cassen <acassen@gmail.com>
Subject: [ANN] fastSwan: XFRM offload via XDP
To: netdev@vger.kernel.org
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This quick pop-up to introduce fastSwan OpenSource project. Long story 
short : a kernel netlink reflector at XFRM GRP mirrors XFRM policies to 
eBPF prog for fast path routing when using HW offload.

This initial minimalist version only supports kernel Packet offload 
mode, but can be extended for Crypto mode to support ESP encap/decap.

more details here : www.fastswan.org

GitHub here : https://github.com/acassen/fastswan.git

Cheers,
Alexandre


