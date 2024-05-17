Return-Path: <netdev+bounces-96989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBA28C8926
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D251F21D79
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0E12CDAA;
	Fri, 17 May 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqKk7SPV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E03848E;
	Fri, 17 May 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959036; cv=none; b=bL+9px7ogT9ad6g6h/73SXqH6KKayQF7+baS3IcNuQslFQ5U8i7MQSnIUFTuV1uytcNIjVlPvQYeBRBsxN9LxW/rcbc+SUy3nrGJZcw5qCmKz1lizsztqiSRjzIJGezNSsrIlFXYZypoHf/0RDVlPkfU7zJVr2gv+xcmbmxVI2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959036; c=relaxed/simple;
	bh=XDE1XXacg5P0IujpikfAHU0Y9gPieO3/IVfHjQkcZlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8moc8xYo1kixVTszHhrQn17PFulRLENQKshKFhsBA2KYcQEx0GPn+n7UgJ9lKkFFwctqQVIKY27iIFpVbEJjxyJFL6V/cWCGD5IQSwZYOf7c+rT//rTgJXyuMmPgOIo8pXl3ibrHeJ4GQTtD1hxvk8VkCN/n7odicpF9D6+Dg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqKk7SPV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so1905475e9.2;
        Fri, 17 May 2024 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715959033; x=1716563833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSlOywFdXmSejH1bm86IT6wJWx8CxpiYUzDNA5leXbQ=;
        b=cqKk7SPVD/HZwGZOKMvN1eS/EIjM7A/IhvJT2Jsbd/SYQuqD6n2uhIwUXdOKKFxnS6
         xRIOHLl/U198MJXIMvZtZgumNTAD/qTraeHYmNsGFxHhIsDQ2tvuou3V02LyCtdQaXRq
         7J8lSraO+CYMvdDrVUMsfuDtF17gdb/Zjudlgn7+qFLtSlwAH2bYmW3pnPrFzAODfA70
         GotBqJllWWtXajXGeB13Lgp9axLP4EPOotREUdHXUxtkc00f8PQIzSpFvQxlOAYZiMft
         5IKr4rAaSfkod6YP7702/8k0azy82HIsSBMRqNRzS5RGFj8xZQfbuDy2SQZaFvqtIlgB
         e2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959033; x=1716563833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSlOywFdXmSejH1bm86IT6wJWx8CxpiYUzDNA5leXbQ=;
        b=RDFBjpapK/zV0nFMsSbWJ0XAJqjzFGbdbHmFZ4NzO23LKrIzlntN1md526MSTR80xS
         x7vWqS/Yi5S1EUVBYUOONuWhBliOKXsJlg97Xp0NHrOSn1GQTENotmsXcdFHSOYpT+On
         AcWkSn4PiRwuj+btZtMNLPx0mH0pioZFaYJ+IBk2EoEOZ8Ly7fnEmVtTTJ/rNynjdNGn
         ZZRY6yGPq2UywAs/PATXtOts0dfhnt4PLoM4o7b+HFJZwRKzh9nTmu9910zOW2Vx8zFV
         C/l5w8qUVec1EAxvmMhBVhWj3ugAhJzBHCpDalvsIbnz/l8cgw7ZuUHFD+7If39pgtm2
         axtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8YzRGDaPUYLB1uAFJ/jlo6UxB6LMR6UsQljHWBk7jQVoBDJgyWxVMQknuGhxmLDdHz9BQUfyyL0unCtvLi59ce7R6lr+y33RtWX4t
X-Gm-Message-State: AOJu0Yzlbw5ohYJLaSKGsr2KEi8ydzx5s0cCjd/lwghIQgTTgPHOE+iO
	E3OkpXc7MWSBWEv6TFlFXgfAysY7KzsvrFlMa14Uo9pL9Ltzw7y4
X-Google-Smtp-Source: AGHT+IG6feH5w7YXMu/zEGOHkxQGCZya2MNVcnOpPRMS98PzupdrkzDPetdrLk33AKaw7YnycpeUTA==
X-Received: by 2002:adf:f0cf:0:b0:34d:86ef:eefa with SMTP id ffacd0b85a97d-3504aa66a84mr15858711f8f.65.1715959033241;
        Fri, 17 May 2024 08:17:13 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad0absm21818639f8f.69.2024.05.17.08.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 08:17:12 -0700 (PDT)
Date: Fri, 17 May 2024 18:17:09 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, stephenlangstaff1@gmail.com,
	aleksander.lobakin@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alexander Lobakin <alobakin@pm.me>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: Always descend into dsa/ folder with
 CONFIG_NET_DSA enabled
Message-ID: <20240517151709.tb65wut2ue76ghqs@skbuf>
References: <20240516165631.1929731-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516165631.1929731-1-florian.fainelli@broadcom.com>

On Thu, May 16, 2024 at 09:56:30AM -0700, Florian Fainelli wrote:
> Stephen reported that he was unable to get the dsa_loop driver to get
> probed, and the reason ended up being because he had CONFIG_FIXED_PHY=y
> in his kernel configuration. As Masahiro explained it:
> 
>   "obj-m += dsa/" means everything under dsa/ must be modular.
> 
>   If there is a built-in object under dsa/ with CONFIG_NET_DSA=m,
>   you cannot do  "obj-$(CONFIG_NET_DSA) += dsa/".
> 
>   You need to change it back to "obj-y += dsa/".
> 
> This was the case here whereby CONFIG_NET_DSA=m, and so the
> obj-$(CONFIG_FIXED_PHY) += dsa_loop_bdinfo.o rule is not executed and
> the DSA loop mdio_board info structure is not registered with the
> kernel, and eventually the device is simply not found.
> 
> To preserve the intention of the original commit of limiting the amount
> of folder descending, conditionally descend into drivers/net/dsa when
> CONFIG_NET_DSA is enabled.
> 
> Fixes: 227d72063fcc ("dsa: simplify Kconfig symbols and dependencies")
> Reported-by: Stephen Langstaff <stephenlangstaff1@gmail.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

