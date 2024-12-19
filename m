Return-Path: <netdev+bounces-153429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BCF9F7E99
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0B418934E7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39A227B82;
	Thu, 19 Dec 2024 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yt2lxh2z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C183228380
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623626; cv=none; b=qJ+DaQzCdLUpzBDpsD5Rf78HHPL271Zx9fod9460oZgcjmPrttYGqGSWcAtLkFbsytger/SaJdQE2+vou9JNkP9+EcdrV6v3sYltpMoI8+rXQ0vUVlBEz/8WhBpX35D1lQQAvgwLiUqELLKkpwjy7lTVe6qbbcxI9lPO2tvGVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623626; c=relaxed/simple;
	bh=rnvHP+C4riUxbSKSCL7EmYWz6H/iMG9FSDKw+Wf8q4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cROyzyJXN1fOV16Z3v//WUs7QXsjP7QtWCWAuqFZNNpKkNhJNpIgSaRA/k5+FhYUcO8Wdugst2Ge6JOeZ/RW9NndDbOEVP1+9GJz5YcwRpeZal9c0Os6Um3SGWnVAE6U1JGe8D8VkKcI2rh0bXxL8PPDIqOdlavK9A4RkvqWNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yt2lxh2z; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so1236770a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734623623; x=1735228423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnvHP+C4riUxbSKSCL7EmYWz6H/iMG9FSDKw+Wf8q4k=;
        b=Yt2lxh2z5A6Mmpa63H7xgKmdf6Sy43dCqSoBh1+6tj9FGDhPqxelFdlNElYXtgENLR
         rvsffkUWO54lmWmKUVA0PJaJEie/dt/GhL0Rgs9WRmeUlbtcK/EXAtZfcLz8awOfr860
         1EFc+aMgq0etCDIxEgjo3kfjyDhTwV4GmrPH5GVzAF4Lz1mn7jvy1Xv7ctnLycvhFqBn
         NfdlUWat36txTyWvE1uBgwhPB58BSZlQYsRqFcfTC+8Uc4aGOU5lCuBLUmv2++E2gs5z
         dVZgMLw98rM9fJWI0mmOQHNG4ikxlONHca+3Uf7/4hmnyezadJ4Vkt1Eh3JYFRRqSjht
         zsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734623623; x=1735228423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnvHP+C4riUxbSKSCL7EmYWz6H/iMG9FSDKw+Wf8q4k=;
        b=BkboQ83qSTGlrcU1JK+cPT1pgxd4Bpe4hOfX3j+ZMt51xuBqvZBWUtjlcaucXZ1mfO
         Um9qcJfyysBSEjDsWU4oxbIUnIauWPzMNasEiiks4tzbdUqfO59fKFssK8HQI02ijRs5
         H7mH37VDPUmbUxcsRt2Eb8Pz+8onk2UerONn+WMoa2vAY+Cc2ICyTlKB0XQYCTjCktfl
         hO3IM1wNjwmbFbEnzwS5/8HsV3m7RNxCBSs5A39Nh9jlAnOqevrIraYXNxsSTxTu+iYW
         1x0ZQ+WxlLWzeNeQcbntD9qiKQF6b0wPhJLmkXspxaX92pMNIplrZSfyTJatfN8xJY/S
         +CJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPC0b0WrvECQy6jk0U8htZdGkzEsBE5VI56vAuKabvCj2m33Kl1k81BT4BYv9HUYYAZyvBB1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ciKPwYaUqvMRpOVLfHG21l7tBMu8FzfbsCrswGL4qvYfcST4
	eZnI/Hrnh2rkHDMzT19UY9fj1t25ZvSEzIEzKmRCK5FEwCoY7/Jy5YgybS7WIAWgXhJNwlBai9g
	7OyPAQADyNoaGNTHJ4EdZ/u0E+iswOpk3WoGW
X-Gm-Gg: ASbGncuXF8wLjmYUPs6LXvc2nNyLL0D00hhlxXWx4nXNIHNONZidKsjsG6clTZLJRqA
	fPpxR6h/Zmpw9PzrwO9nmXdc9xD0mxSFrY++Xd7LUd4OflhIKlsOv72LrPSSh2m5Gq5buQ8Do
X-Google-Smtp-Source: AGHT+IGLys00P45WQrmwL2PSaA/obn05pxpAHTtsL5Rj51BHRLTmBWAIuKsjdpS0IJBMjbLfLuWST+luvXNwnrg75KE=
X-Received: by 2002:a05:6402:3596:b0:5d3:ce7f:abee with SMTP id
 4fb4d7f45d1cf-5d7ee406068mr6746170a12.25.1734623622525; Thu, 19 Dec 2024
 07:53:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219132644.725161-1-yuyanghuang@google.com>
 <CANn89iKcVDM-na-kF+o3octj16K-8ZRLFZvShTR_rLAKb-CSoA@mail.gmail.com>
 <CANn89i+SMrCH1XqL8Q9-rr7k2bez1DNqeQNhO0rBrrHiyOrFXw@mail.gmail.com>
 <CADXeF1Gg7H+e+47KihOTMdSg=KXXe=eirHD01=VbAM5Dvqz1uw@mail.gmail.com>
 <CADXeF1GvpMOyTHOYaE5v6w+4jpBKjnT=he3qNpehghRWY+hNHQ@mail.gmail.com> <CADXeF1E16ffcJ2tsYDHWr5OX=9B9u0_t3QoKus=RnuQw_e_0EQ@mail.gmail.com>
In-Reply-To: <CADXeF1E16ffcJ2tsYDHWr5OX=9B9u0_t3QoKus=RnuQw_e_0EQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 19 Dec 2024 16:53:31 +0100
Message-ID: <CANn89iJEz=HWXN9fV4iLX6uGumBuOvcup6pEJvPWs3efy4=4OA@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: correct nlmsg size for multicast notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com, 
	netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:35=E2=80=AFPM Yuyang Huang <yuyanghuang@google.co=
m> wrote:
>
> >Same remark for inet_ifmcaddr_notify()
>
> Moreover, for both IPv4 and IPv6, when a device is up, the kernel
> joins the all-hosts multicast addresses (224.0.0.1/ff02::1). I guess
> this logic also does not run in process context?
>

Hopefully all these paths are stressed in kselftest.

A wrong gfp would trigger issues when you run the selftests before
submission, or in netdev CI.

