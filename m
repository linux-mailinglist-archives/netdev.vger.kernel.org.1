Return-Path: <netdev+bounces-214295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6423FB28C7B
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 11:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DC25C3398
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BCC23C4E1;
	Sat, 16 Aug 2025 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtUmIY0c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731423F40F;
	Sat, 16 Aug 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336887; cv=none; b=P666V70I37kEA4LG/w0zZp3aIUGjuNxUYFnyCLLfzZyWtAHJZ9swsuh10h/17+dADcYBpGLySlcvqZrU/FkzBhRGtxUw0AHbo3R+ZXg3QhIJvaHFvMq9GgmEWL3qcWnO5V4bwVuHpF/v0pgXv2RLcr75VNbZpx2c3ks9TYar+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336887; c=relaxed/simple;
	bh=UzPkeUJpFFIz5NZn5MQP9WNh5qcQOGMY0RszBW7vCwU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rgB6MF6CbLg69YY/tc4tUTbXfLXcvDVNJp1IYUcWHyFBKhXp3kzjbuYm0hx6R1tbht1xBTqZd98d1gl2l19pG3Pu4PL5EtKrltlE+nCfDnQo4hykHD0T3e5jQUi2VMaqFpK5qipv5GJDUSu3tjQmdHgBeFKktNBYUcefNRAF1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtUmIY0c; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-50f8b94c6adso666880137.3;
        Sat, 16 Aug 2025 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755336884; x=1755941684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGEFmcc706ihZ0upVBFGijpGh8qPNo2j6S0svytZHMQ=;
        b=BtUmIY0caeD3AtM4Kv+wZwAeW71UwH9GfoATnk5nsDCe4t/VCGR/935FP+zT1O9n1y
         8x+fT4c5TbtkJnkn4AGdJ3qZCaYRi0GPi47tTk9FuONyS05szpOzWGBybTurXVEItAe/
         ZgfXE9wxNpz1Sw6O9xC5l2e5cSrYx8VfjbqLjf3AMNBOzCiHF8UY+g1GW4qWBBQ+g0Iv
         ru/Ob+9hesqmDsGsCybqswzi/8YlM7j8SkzdAlnM9OVNUNusHAzqxHy4j9xgc2OQ7T0z
         WLo8bdZYmnUQPWm62EybpIA/PjddDM3Uxq4/Z+4sHkDbgK6EvjGLWBVBfzMeyUJplJto
         FKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755336884; x=1755941684;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OGEFmcc706ihZ0upVBFGijpGh8qPNo2j6S0svytZHMQ=;
        b=k579QmcoIzS1syUfTgtVY7bnHhjq4lwK8cEodfruvu1bgsE2Mxpy9atyeb3svn9OSh
         OwDW890ttd66TtkRpB2nj3Wj4uWnhhb0Am7ue1eefOk1OLp2ZpYlYkFDyEF2NW+Nw66o
         u+afYaYKTOyU2sQ9Kzt0RrPTLkoCGTuXrubwNWlhIuouCWFNSrrwgqbCmnrtrAcbakfp
         isfSNrvf8pupvSvhCtmSPhk4uv0AV+N/qhaYvTamP+LbaaefEQ1fpSOJWaPqVyfFpJwf
         TERHpXXIJdVTWRniIAqrUOoE0BNyVz77NX+VbG7YInHzj6EItmwhK6u2fJEiPmkEVuvF
         ZFDA==
X-Forwarded-Encrypted: i=1; AJvYcCVu+6RLMg2PQrcHs0FmVNKPIuqDysaLSBUG86nU4StUbddr1ggDEL5bHKQDTgMF32AkUm/rIYsQ@vger.kernel.org, AJvYcCVxOu6gEz+LKnCRO6YA3xv0kbLlWyzKTeO9mrIFvXvon3RmedSBdmb2e9mGVtLYyYZ3C/MFZQNlJpRYgtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPrzUbKLjNc3aIMb8twxbx8Cn+7PPgdpuNfO+A+dj9XFhg4TZ
	u6cRRVtbfoghbcN7LB75/BAbUwhw5xJNRQXBQ0JHJT4r6RCt55B2kCgjqM9+89iY
X-Gm-Gg: ASbGncvYcJbD51IM6iLceGP82xvd/UYyQoLLv7Yjbko+ak/k/8e62k8gFaEhBW1IMG+
	qr2/oy8sj1eSInyMPO0b41y4L2kRcuk1LfCt6i2TAkY6aSUHU93TV2JdMB+wLy/wy1aglMti39z
	8YyGjU512mznyJS8qMiU2LazFce1MwXh/ZdkcGao/N1vrXE+IQ339k3dmZiWPL2m/FbvbABzLOm
	0Q0hjNUXCInGWhvB2eDA/IdC4MmRfhMhOTOhyg46JSX0IZYJnXj3wv+hsVXUIsZgtUX9cyK9cHE
	pcmbO9dEsVFvgKf7dVbpPWjTfu/aCz8ac1+sEnSOJ4g4Wyc5uoAB8GQCR5ikdQiQGDqHl/38mgh
	gpemq9VY28/nKTtG5AG0CnNX2u6A0pSDPdDTl0lMU+DVgJzDoEVz2lAYRhXJvy8yqkHZqlw==
X-Google-Smtp-Source: AGHT+IFMl3BEqyBUZWA6WoiCtiouNPFnKV7x/pY+D6CDUDwdFhqIC+6ZOsO6pvpFXzWMyJQhM5UnQw==
X-Received: by 2002:a05:6102:26cf:b0:4e5:9380:9c25 with SMTP id ada2fe7eead31-5126ad1e206mr1982168137.3.1755336884432;
        Sat, 16 Aug 2025 02:34:44 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-890277bf746sm681112241.5.2025.08.16.02.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 02:34:43 -0700 (PDT)
Date: Sat, 16 Aug 2025 05:34:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Xin Zhao <jackzxcui1989@163.com>
Message-ID: <willemdebruijn.kernel.1096d5f9f114f@gmail.com>
In-Reply-To: <20250816024831.1451167-1-jackzxcui1989@163.com>
References: <20250816024831.1451167-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v3] net: af_packet: Use hrtimer to do the retire
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Use hrtimer instead of timer
> to help compensate for the shortcomings in real-time performance.
> In HZ=100 or HZ=250 system, the update of TP_STATUS_USER is not real-time
> enough, with fluctuations reaching over 8ms (on a system with HZ=250).
> This is unacceptable in some high real-time systems that require timely
> processing of network packets. By replacing it with hrtimer, if a timeout
> of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
> 3 ms.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

Discussion in v2 is still ongoing. This will have to be respun based
on that.

