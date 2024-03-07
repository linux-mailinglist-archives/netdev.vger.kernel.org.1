Return-Path: <netdev+bounces-78524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A358C875844
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 21:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6BFB2544D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4A137C43;
	Thu,  7 Mar 2024 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkrQicyd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C8136995
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843178; cv=none; b=O22N9AB8hgZV75mdFRxFLcghhRkcVhd+8ybVskxRU60JuwnZzYC1zca3wInulfEZZVzjwRv2iZsc2ZwBVzfb3URCYqcETiaKmAosBWstsj/2aTKx9tU6c6RUL3fjD7lCysybNBuyROgwnB0zWXqQe9kWjo8sxoB2q8hWxx8UnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843178; c=relaxed/simple;
	bh=hCLrozahZx59NoBuAhc190VABzVi2N7RHPseclllnBM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mKSzFoNN6zZXEwJZufBUK5ilVw053tV+0yPp55zVEDcxOHJY7QvEWO6t2HYKihcno2aHawGu2Y5lGevbLideQwvs4PAOHmvnSlTxI1gG6XNiyMoeM0yUnrEEh2HXRKkgJJdEMHa/74ZEtsXKg8Bgcq4ZeMAbKZbOtlHOgX8hVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkrQicyd; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59fb0b5b47eso549109eaf.3
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 12:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709843176; x=1710447976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwQr4XJQXBVsGbJm0SwHUiqLtk1eG1gFa4/tLhAui/E=;
        b=BkrQicydzZDbIQPPkZzONEdgzoe1+wNCMlSesgBbD6YQoPu7tfAKV1AwhBNTQ8qOc+
         wLGULIspt3QoJcApH04Tiupd1rpzZ8WgDmamMCi0CpkU4w8SPC16HjTtVQHdou8pf7WM
         eBfZ3FE2gFj6cfb00+5nT+GbQqIVY37TTshZ8JcmZ9TcRbRtjSfdHLWcnOcOUp+2GE8L
         8gCB8Yrky7hg3/MyA0kp5o94CFKK8MFzrJ3FmKVWx9/Q2efQfUdt4oSBOmNaSAbzqrOC
         lNU2WXjlnIJPRD7SzSPzcu10Xzy0OVptMrP3azogWefnoKtsahBSBV3mEB0tN8WuO59e
         iEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843176; x=1710447976;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lwQr4XJQXBVsGbJm0SwHUiqLtk1eG1gFa4/tLhAui/E=;
        b=PPcret7EWCwDcDl1IdmgK99LppR3gjq7iyMZCUL0e6Ay/IU1WyiOTzJ38XOewggVcv
         iVXXXoqChfL9zZRxo16bbsDjW7fVhXZlHRj853YcWy5edcGN98yQ8ECD9D85RM5ysPVj
         zPqsr4M4HeIk/tiUKSB3z1WoAVjZhm5Bv1rU9z1WC8AaiNAbCzJ6ouy1MkErU0xt/s6e
         z+yedw3zmRtxSyNUvltePxBXUpiOrtFhnECbV+i9VT9UUX+UAcsSCsqYXTwDsLx1KlSP
         j05IhUj+UOB4Cydva7q0p8CCvW4n0ezwotAT5u0gsdwMpqfSF4Wo184Acd911SOQOfiT
         m24w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3XuAnB+8kLIHWxkWPE95ILNIoV6wDh7zSeJ2pay8gXHoExmduXQ8wed2yl9blkeVnxc8RGUhOsfMTtkdOjhfd1WRw1/y
X-Gm-Message-State: AOJu0Yz/yEbxWNtvIoRIHH06/qIg8vFGFMj/uprwQviWHqsLVDfzBaPs
	QMFIpTPalAQ3gPiKM2uvZ077R7salJbrHS9sezcL2ZG5SJ+J1/vR
X-Google-Smtp-Source: AGHT+IEA41QEXG/jeomnHQ/86OUvchv+4JQT1FasZuAuqFrUKvaE1Qwe9FHRoJpbPalcyyD37N1HOg==
X-Received: by 2002:a05:6358:4904:b0:17b:eec9:8ee8 with SMTP id w4-20020a056358490400b0017beec98ee8mr11293541rwn.12.1709843175753;
        Thu, 07 Mar 2024 12:26:15 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id pi36-20020a05620a37a400b00787c0e4ac78sm8053511qkn.106.2024.03.07.12.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:26:15 -0800 (PST)
Date: Thu, 07 Mar 2024 15:26:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <65ea22e73912e_10a0ad294f3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240307163020.2524409-1-edumazet@google.com>
References: <20240307163020.2524409-1-edumazet@google.com>
Subject: Re: [PATCH net-next] ipv4: raw: check sk->sk_rcvbuf earlier
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> There is no point cloning an skb and having to free the clone
> if the receive queue of the raw socket is full.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

