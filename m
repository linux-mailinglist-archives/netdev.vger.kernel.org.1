Return-Path: <netdev+bounces-229203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01795BD94E5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA571925B93
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5D31354B;
	Tue, 14 Oct 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="3CHCTdBm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4C131353A
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444376; cv=none; b=nbGMEB0tzbXocL0MfvDzwn5LNoltxapDOkJwRaafxRPO+3VnR3mYqU51ZVKmjDK3BK6NUoSIoFKbp6KwoWsRUa8O0y2Xok4pzBhIvmvaZsZnn65TGrFajO7R9PHqa+qQlzGRquBCHH3w5Q8HBRCAEd1M9sh7BcuaeLsA/Am4y8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444376; c=relaxed/simple;
	bh=W4pEz8ejbdyaM55bKvu6Qd6fjptRvTzvnD2jERuEVNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vChMCfmQe42IebrfQ3dsJWNunWEUOisa7VOti3KgIEsn2alTZk/v17DFDBB6LJClkhHm4UhNQkROfYy7Kq0vtCFJohGhskj15E3v1YJ42nV5C9Tef+qD8Lgfqu29WEYyOj7OtH2H5kAeB+Sk3ai9WksyEEPqrl8rUQEomx/WsVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=3CHCTdBm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so4615667f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760444372; x=1761049172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4pEz8ejbdyaM55bKvu6Qd6fjptRvTzvnD2jERuEVNI=;
        b=3CHCTdBm4Xrj6aH1hr4VdSxzpCswGy610ePvCC8FtDcOxxYsUi4GJ/1cjjfDC40OSs
         p/AUl7vneunZCp7oZZNFdhkzSkRyEmkMr8BMYnZ8QxeQ1FzMFH6MtJnfXp+dHL5NC8rm
         jtAoUniRljVQIv731a0N9qg745RSKjiXqKDuh/7G0YXZuckFWFDqEu+azA8jvg+uNEde
         VHf0fOLviIojPTZYJaLVr/bNiYTJdloS9eNO+PdxSsO5ZX1k7XX3oFOwTP0Thz3wAX2R
         NeMiy22/EYKhiIOdX1HT8uZ5DY5xyxbhZ2urZEUDDkNooXQeL2nnAOe71kBBaNJAkvb9
         haXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444372; x=1761049172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4pEz8ejbdyaM55bKvu6Qd6fjptRvTzvnD2jERuEVNI=;
        b=u6frCB+W4NhdW0cLkCmQpljfubAZSeZ5ZQK98PkVXaZumNiLE3h+0qyWzUP4wQF7mZ
         DClEUH3xo+PtC/tTpLZ+O52P27tm4nzLR29fZJCKUvgyeVKgYVmUvMZU4Kp4MOjz1/xo
         SnO1EdwPhwbxcrkPP3ZhOx1pW2BJ6hhWiNy6e+bgUbfsxzjiiBBbKHPdUVO2tGZWl1fm
         1CLCCjzwAI4i91i5GZvJm0I5uD42BfZIo6XwkjE4pVQKNDN7aaHm9p8FOiINCiSem5LC
         DohiD5a8yEsF+llCTsqlWjNR2IWGoCH7PJP6B7YlWRf6KBqRq5xV0xpT2Mx5gcESdBXW
         hxoQ==
X-Gm-Message-State: AOJu0YylLCEE6Wl4vRSw4wwL8ileDBt9bCTYYH+8BaKEbZ31818dLK5Y
	T+gP3mhbFGftknxGT6PqzWpIzpPnvjUUXspbkw5ClBOtz6XWwVxvN58F98+Zdjd1eOphhAhH04r
	kqqoTF9ifvg==
X-Gm-Gg: ASbGncvNyrvkxF4Lv1tR+LC+GXAgfwZxTqmgrrOQP+4yVKHZccVxUS4qxyGs5vbMHj9
	JNdlTjMdL+0fr4B45o482bG9OJn2XJMQhBaOvHALbeGv9yU81Zy4Q5rdogNmFo8YoqR65FPl4iK
	zb2KxXp4kkLdWoKrUQsyNLfgYGnl27r0hH2FPyYj11ylF9k/+OiAM4IhBa4fi5ti1JAWWGEyiaU
	jjVpu97eGPEmROpzC+KdSuqHp8PSrl9lBZAD8umcCk1NYC8gMqZAsj4kkyDclgevU/8yHIxTPTQ
	G6mhDSFG9R1P87I/Vh84bsqXWktEBVOOTX3/5MlmiGONrqX2cdSqKzpcupbR5QQbSPLmtJjxOCR
	WNMDjhr/V1p7Vjht+rCHgXwJuPM/m33Un9OUhi6v59cDJvj4aUVwZILC02bVPvAbk6TV694banF
	R3gLY=
X-Google-Smtp-Source: AGHT+IF2QyHV9Fw9qzIcvYizVk7lAnX7OPWUV/Y6ze1OA514KvYKL7jUGGpRrAQwC9g3J3uGCZYIMA==
X-Received: by 2002:a05:6000:2283:b0:3ff:17ac:a34b with SMTP id ffacd0b85a97d-4266e8db451mr16024307f8f.42.1760444372126;
        Tue, 14 Oct 2025 05:19:32 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe4esm22870880f8f.26.2025.10.14.05.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:19:31 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:19:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Philo Lu <lulie@linux.alibaba.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Dust Li <dust.li@linux.alibaba.com>, alok.a.tiwari@oracle.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v5] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <jhvl3gx63kt3xcgx3o4ppsqftgzupjojf3ygblnrapcneuks5w@cgfydxsalyii>
References: <20251013021833.100459-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013021833.100459-1-xuanzhuo@linux.alibaba.com>

Mon, Oct 13, 2025 at 04:18:33AM +0200, xuanzhuo@linux.alibaba.com wrote:
>Add a driver framework for EEA that will be available in the future.
>
>This driver is currently quite minimal, implementing only fundamental
>core functionalities. Key features include: I/O queue management via
>adminq, basic PCI-layer operations, and essential RX/TX data
>communication capabilities. It also supports the creation,
>initialization, and management of network devices (netdev). Furthermore,
>the ring structures for both I/O queues and adminq have been abstracted
>into a simple, unified, and reusable library implementation,
>facilitating future extension and maintenance.

Is this another fbnic-like internally used hw which no-one outside
Alibaba will ever get hands on, do I understand that correctly?

