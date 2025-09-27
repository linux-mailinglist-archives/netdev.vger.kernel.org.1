Return-Path: <netdev+bounces-226835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610BFBA57A7
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3113A427C
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC01E5B64;
	Sat, 27 Sep 2025 01:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN6wcmB2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE221494D9
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935473; cv=none; b=XJt4vwjgpPitjLuQN03CGYPeOLUBcGuRvsTIflCWGWCBim3L5L6TR6b/Rs1f1o2NqmJTDDaT05evV0Nc34lM9mId52LRBjA74zdWYwKxZ5xTFeLc8ximsNafVXXXhhyAOBAZQNq9fOVwQC1e2aCnh1M8xLYf/dLK1j4ucaJEUgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935473; c=relaxed/simple;
	bh=HMpVCR80K2DV79mjtDi+4B2jbuYtYK8gUJBv4IkP6mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEEhZxgLMoCKBD7ntXnijsIA+mujNTSVHuHjX8E2waIO/5I+ca5dglF/i26pu7ow364EKT93Em1ToATR6TSjAwEHzbYi6v2dOdWGCjxNnQaZP053FKogH77L3H3dYOFVdMAvofUwoC6YMekL+gaFxHmloMi/MeipoCr41iFnFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YN6wcmB2; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-9194a0241aaso9388639f.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 18:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758935471; x=1759540271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMpVCR80K2DV79mjtDi+4B2jbuYtYK8gUJBv4IkP6mQ=;
        b=YN6wcmB2qMmyYW70ED7voYui1U+ZaCYNz9XS4JFp9OiCEDNoCr3PTBXwaNdjvibo6I
         Z13n/+Z9r8jvtFPJfJlZuG1DPwQP2YjqtttxNjILPOggiKxq30yL+wijcBhR/Tg7FqOG
         Bb2j/qXgASVrKvxK7ectwO+dy8Lr7QwuyURwc1F/Kgf9JlfApOCfLzFfPi/lbH3Xag0L
         zL0xwIZ4ijxqaiH/W598+yEhS4AlwYaWjBCOEuZdpt2izzp9KEI/uXapXtjMOoJVxZ9X
         a+9lP0nEqlJc4fY+E9ZnMiRXxP0x/xvOT4yoiT2VOZ2UgvaJp9RF5eOHU//a8lsR0Ro9
         lZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758935471; x=1759540271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMpVCR80K2DV79mjtDi+4B2jbuYtYK8gUJBv4IkP6mQ=;
        b=Xc//oqpGNaqvb4P8iq3DRpZoLoVu7RRLmNGtSVGdKIRayc2oKwZYkBj0Auf+NP7ujd
         iZcviFiJ4iTG6hsr7+DzeOSHEf4iWJrnCiUNihQYz6mgj7knbBSgBxNXPDt6BZT/A9sP
         f1KvhuNV6iJ4g4lQ4Bve93RqQyfTLapcMiCl3Lx8mgmYt+FbtL9wFjTyPVbci0d7DEmj
         TN931Cqk0QmoFmMPhdTPOlt9fkEeBv2jP5dDwCAIsRO3Nfr10muLjlsaGnSF9n+bBuYQ
         +fCnDl1OAQgkDeHuoqA7zLrKXzOIqdtfouZbErrX9ihT6A8FlY+kgv1DA1Jx5MVAKdo0
         lMsw==
X-Forwarded-Encrypted: i=1; AJvYcCVkDscZcLTc7UzeTNbhL0xkY20C8YNRtYbazAOVjhGaZzYC5qf8zLFr1d40SbtQRVVM6Rcm1JM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MK1lWoXEzDnwt2rxFv1+bXvU4BPS2LARbn1rYdDd42eep8zy
	MQXYDRdPap/yvnpeylB3aaZk94ly8MVHguledEX/hFcHL0LMpPPP5cCxCA/gqNzHZuIdC3IYOx7
	W1y9U7Z9N0xDE814hXdDlxkAAEBMzGac=
X-Gm-Gg: ASbGncuX7snnWLDLPMZxSdAa4MDkIXqqvXhEvPe9cJEmrhTrWfIgmrr3FRKkEsw/PQ2
	3fAfF24GZ3AkOarOWThif2kI1COBCizP3ExokrUx4wZ2q5+BfGyVdMUk7Ii0Vn8W2+yUeOTGKx4
	Py5BSKxHCLfF3IHwBzMDIE+fMyF94kgIgkMszODwka+n6QIMBWxuTMZUqgc854DvDybegz9YEK3
	UUtjGTQ5rC3WQvX
X-Google-Smtp-Source: AGHT+IGNjAPclGSL7lsVR7zjGclq548/GJt3u/ghV9wcQmRhznZFCL+mvtfI1uE9TObDPt+cng86Tz0Xqyn6pYuweik=
X-Received: by 2002:a05:6e02:4419:20b0:41f:6b74:e238 with SMTP id
 e9e14a558f8ab-425955d01c5mr118209495ab.1.1758935470900; Fri, 26 Sep 2025
 18:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926151304.1897276-1-edumazet@google.com> <20250926151304.1897276-2-edumazet@google.com>
In-Reply-To: <20250926151304.1897276-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 27 Sep 2025 09:10:34 +0800
X-Gm-Features: AS18NWAiDyXlmCQIn-Y2Sb4gKeUI6jxRifLl72Wf11nOaagtxNWHcJN0iMH3S6s
Message-ID: <CAL+tcoB+w+qPVZVHHU4mADvf1rkKUOw3j2=9zoFa8YbVXWtieg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: make softnet_data.defer_count an atomic
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 11:13=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> This is preparation work to remove the softnet_data.defer_lock,
> as it is contended on hosts with large number of cores.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

