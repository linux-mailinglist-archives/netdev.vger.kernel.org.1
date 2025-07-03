Return-Path: <netdev+bounces-203778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229C8AF72B8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5145E17E0FB
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F1224BBF0;
	Thu,  3 Jul 2025 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epVRt9UH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888CB676;
	Thu,  3 Jul 2025 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543099; cv=none; b=Qj0axi/xCRw5ZPoEqTScGOrNDxyN2qkO9n3FJOjgRxgyRL8d//treonjdH/BaSxO5k760p/PAT+N5XHz2T3riCKuUGS428zYJtAHwp9lW7tKV+kee00Q7jWrbKxiYE/5ZLB09YykZ6WzOnRC552dTAkbegZojKWwlHjVryy3TXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543099; c=relaxed/simple;
	bh=uBUjONmwbn8v/AAfxz8Lbc8VDb7rf37tWkb0CBGxo4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7mN4PPPmz3li8sFnGLYNMXzlDnU590I7aA8ZnYXoc1puvBi2iIpxHtiH8kbZEybqvEp3l8cFSB//b/7TmTN44pQ+Fxlk56dyuky4JVLAMEc+1tLvZC/X6ETAUeopSpDMJduVxoelFmNlVqluJD151fF81VHAwDkiK3GpmA82NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epVRt9UH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so43816035e9.3;
        Thu, 03 Jul 2025 04:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751543096; x=1752147896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k9QClSQ8ICwQ6dLl8pnu9ysAhTMsX6Xb60vNSqN+9o=;
        b=epVRt9UHnJFcdLWfGDNisyMS/FMdPQVu5GXr7oeq9ysTP/0ZwgcwF2CUq9p2ECQGoQ
         yw7jB3DdDH1Rsr6pZcOc8aTdj9pdl6ooU78qM3fNy85bwTIWXvvfHAuOVzUssFaq7uZa
         GVZAdCgziV7YmqYtQ3rFTmyWPu8LZ2a/FECQDJaLE+Xboz46tq7DFJkpNOzNFpy35oRT
         QywbWBpk/bmFFmMf/imFyKyFSlR0wleDpBvWNmmyb0NPltBo2rkbOKLx05sQ7MakBFXJ
         v6HvR9y5PkmHNzg3cxUGT92O+gzask0Ej0OeMDq2Ak2Hr20I9lteBfp+P6EF1ZWIxC56
         5U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751543096; x=1752147896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k9QClSQ8ICwQ6dLl8pnu9ysAhTMsX6Xb60vNSqN+9o=;
        b=sylmlIPuLFL4tvRZGw//XKX+/WQ4nGmMq0Kmc6m3ijXMuoc0VBozPVtx2jbmcW1tcJ
         NL4Ivp86wilgN1bsq8c9Dn/vTNj6EW4Uc/bs6HjVyGpkWdS6lNQ0j2AB5CU8ZtIy8Ycf
         JupUGuIQFJShW8yHfYDHz9cVbyMyLS1HQYDHbnpM541lrdAXYoHvGKCEABpJ8lmI8bUb
         pobufrtOWU1CCfxBWTV4TRJbUBVLg+hjZXYWZKltpp+T9MJAr/wMsgEz+MkMRx2LXYxL
         vAB7xpifltlBnsGTHapf6wFIR8bipLIHSVDTxf+olitB4kUbN0rjG1biQVSyPNeX+wFx
         b20g==
X-Forwarded-Encrypted: i=1; AJvYcCVv/YUD3wFXeluGIp1XgBjZ2A9t2ZWLF8DVo9RxQZIdEFXMZ5aYXxholPKaMhM6nULmVNcfHavAwJhevUM=@vger.kernel.org, AJvYcCXtM4x+asMKhI2XYVpbzA+S+tak2V0K3Pz6dKq7b9XbwwTBC/cQZgJ0dL4e4XQH22uN/1oVwxld@vger.kernel.org
X-Gm-Message-State: AOJu0YwZi6QJ1ruWem4O79Z+wrPBkBpjuURKmK56S5M/6jJsSwKjF1vd
	Q6fd4BrdfPop6+vDkjV57xStlfK4l3rEXdQxfZMd2y9rNVljbiiut5Sn
X-Gm-Gg: ASbGncvZaturL3TP5OC30tS+EJ4UExfodaposoq8HqXhwWAwn0aZG6WK2c8PgofpLls
	v48/P3CaQ7IQVoOuFruCMktFWcOGnNzZJPODV3UpfS+RN68ddJ0spqnZpy6GQMZYFTnW1qbLJJV
	UXw5W5WRm2jfiynHb0Kv+OYyXIl/7WieIdtn28y1uBy5qdMJYJA3I4Ovqv4gIZDaWHCY7JzTELB
	ImQ03fXUu2iryAJs9tQ/pERJmGKesdtTheFvLx501svMHFEE178GPmf9iEcXSFJt0yySWhGGOps
	OkF+c9CEsJKLvXxCg6erQaBStJh+ChQZRX31MqQ9VnNdfaBelwBc4jTVY54qRzchu2nTtVJUg4G
	A45pr0V1BLH5LYChoGw==
X-Google-Smtp-Source: AGHT+IGf43gfMfzl0TZZrRJIvNkgxoDqDSXV/tGVc7FGBGnLX0cjt4oLacTns9SQIRGExEHDCvPVEQ==
X-Received: by 2002:a05:6000:26cb:b0:3a5:1471:d89b with SMTP id ffacd0b85a97d-3b2019b6a21mr4968036f8f.53.1751543095974;
        Thu, 03 Jul 2025 04:44:55 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e6214fsm18647264f8f.98.2025.07.03.04.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:44:55 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:44:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Feng Yang <yangfeng59949@163.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, willemb@google.com,
 almasrymina@google.com, kerneljasonxing@gmail.com, ebiggers@google.com,
 asml.silence@gmail.com, aleksander.lobakin@intel.com, stfomichev@gmail.com,
 yangfeng@kylinos.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] skbuff: Add MSG_MORE flag to optimize large packet
 transmission
Message-ID: <20250703124453.390f5908@pumpkin>
In-Reply-To: <e7275f92-5107-48d2-9a47-435b73c62ef4@redhat.com>
References: <20250630071029.76482-1-yangfeng59949@163.com>
	<e7275f92-5107-48d2-9a47-435b73c62ef4@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 10:48:40 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 6/30/25 9:10 AM, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> > 
> > The "MSG_MORE" flag is added to improve the transmission performance of large packets.
> > The improvement is more significant for TCP, while there is a slight enhancement for UDP.  
> 
> I'm sorry for the conflicting input, but i fear we can't do this for
> UDP: unconditionally changing the wire packet layout may break the
> application, and or at very least incur in unexpected fragmentation issues.

Does the code currently work for UDP?

I'd have thought the skb being sent was an entire datagram.
But each semdmsg() is going to send a separate datagram.
IIRC for UDP MSG_MORE indicates that the next send() will be
part of the same datagram - so the actual send can't be done
until the final fragment (without MSG_MORE) is sent.

None of the versions is right for SCTP.
The skb being sent needs to be processed as a single entity.
Here MSG_MORE tells the stack that more messages follow and can be put
into a single ethernet frame - but they are separate protocol messages.

OTOH I've not looked at where this code is called from.
In particular, when it would be called with non-linear skb.

	David

