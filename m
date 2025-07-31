Return-Path: <netdev+bounces-211184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6EFB170FA
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9473F1C2027E
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980D239E68;
	Thu, 31 Jul 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T21xAIUN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2721FF4E;
	Thu, 31 Jul 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964403; cv=none; b=Pwyznncd6MeavI9Q7bGKPKHzS0i2NRbvSWmAJc6TQXh0sEtR6hWWJsrou6ubqCsvsmmsGkd6Q3MpnZ18hlsf0IEjDt5g5kpkKUUmRBors0OSiejq0PxNultCv+clntQWJaPWU4RsH5MkV3a4V83NS8Kc4Y1wjYqt2hyynWtoWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964403; c=relaxed/simple;
	bh=r5dU5y2fVJrNCYluR5ZgBxW0PgLEek1d93tlxQSsntg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKq2CClABlXJyTTSTFLxoP5GV+iNnFNcgPwRhzZb1RvIPVwYqtGyRokMHeGyIAmI1EN4WCC8rzrIdyne84TZQZjnFvit7OmpuD/klP0zRz6DHDkCJ3GTFw6r9EpJVbEKCkGn+Cipv2avkADlGPowYdaS62RxhDPq8oIhJoeXl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T21xAIUN; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e8da9b7386dso858262276.1;
        Thu, 31 Jul 2025 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964400; x=1754569200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5dU5y2fVJrNCYluR5ZgBxW0PgLEek1d93tlxQSsntg=;
        b=T21xAIUN786o1jj9FmDE5qVmVlVogI+yjTBXVUPqpSJNQDG8863KHMC6DvZHImJ2za
         vj0D7MUNUI8Oj/oECpI66a+DCcNYvMXc4zjRA3NDdgH5nlifosA+OVYCGr1xDT9CBGW1
         /tZFC4gsIdXFnBFVfuxJe2ra+ahwe4vs0EXNRMp2b/vnjPSpjff5y2PAJsHk625nWZPB
         zQAXaAZgWcsP+GuJcWeq3x7CxbAzjJDvMVfjauhlmbN20Wcs088hFssH7ArKZmT2KXU1
         crNw+EQ62c1smnURsIuLdpKU4C1D78sCaT102rlMi3m+nv+NUfcy59Hh8/zYa2FAoBOV
         Au9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964400; x=1754569200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5dU5y2fVJrNCYluR5ZgBxW0PgLEek1d93tlxQSsntg=;
        b=P/glcNpc/oOStxkKtAqrfPCePBGTA8XBe7c9Mkfr4mHh7Wbh+LMhc9CreJZPeEapJ0
         yuKjnE2QGTC0+pxXWb+k/pUDcAwTN9BkdpZ/zcnxakDr8nxrDZG4kpmzZyAW/ARDzVX3
         jS6Q8ieQQmWC6CaHJfOesiYBUcdcbPHB2xgs1qE74wTt+oW0umX3SONGMbbTZ/5QOvCs
         b1ySUGZFaoz9tXs2fWfLxt5sjCKque5FpaIo1EEdjS18zRe++tG+j2Ey551j5iAircFW
         a0UJWa1l6brzCEYjcudjHHep4JYT/yAT8l9PVtCkzq02xaNFeoPRBtys6bMpLnOYaZ5S
         7UgA==
X-Forwarded-Encrypted: i=1; AJvYcCURYhK1ziXd45UeR2lUzXOAhgnSfZIiR9VQhMy5bMNRFOVCV3oDw23rXuaH0FLLUES116YC2WBf@vger.kernel.org, AJvYcCUlHx8CTbpZwyyMz4J3ycuMVk0Q6wpFi8qfxlumRAaqzQ4iHJbVcMdS90o28Tx7MmpM7YyJUgQiwYRRv6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv7SbE5xZBxItPyjK7wTKnamukPtfWh6Bgf4m7i4hK1T0WJVTp
	ggn46V0wrg2DC3yIkddsy2/N1iZJnqzV1aI3FLW98gGQ6+7TrFt/nNp+iz25cTu6O3JIuguX2CU
	dd95yRVgGNrw4z1UskT0TGOBl+kQB+j8=
X-Gm-Gg: ASbGncvXULVYi4+DJ3Im/Iqzy/BZnwUxC0D3O8hBkcqNwDY8KUYTVNm72Bb2U+kbOwd
	imdPhrhqYW0WwHgU/0jyzXlWoW7W2WKS8tqMFwoG1AxP/mx4j14aUpwUhsSBCJyPcRqC18Q5vnL
	NTy6O6FvDWYWnUmbvyIQaHSJ/7cWB1NsKpCV/Y3bsP4ggWz6ib+xOWIYjnBptMM/YRyyMuuNvpu
	c6pdfw=
X-Google-Smtp-Source: AGHT+IGEdgU1M3wi9PcdX0mmZ1lYvQoPdWNmcYCoBoBu2HMFkSJxOp2Ct3UaNiySZv6edloK1Luqh+WLXIx8KoKKbuM=
X-Received: by 2002:a25:2b4a:0:b0:e84:3b85:2e0d with SMTP id
 3f1490d57ef6-e8fd5360ce5mr1454841276.9.1753964400496; Thu, 31 Jul 2025
 05:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731112219.121778-1-dongml2@chinatelecom.cn> <aItcuFGx1S7ySE3y@shredder>
In-Reply-To: <aItcuFGx1S7ySE3y@shredder>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 31 Jul 2025 20:19:49 +0800
X-Gm-Features: Ac12FXzaZMSpzi1Brb5xPSnswfFUu6mzf6kLD_J-GOE5lN1tiB2f8PT11t83Zss
Message-ID: <CADxym3YzJPRDPCz5rN7uQC6MNSo+FnGPB5sg2hVv+WOZj18PKg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: vrf: don't down netif when add slave
To: Ido Schimmel <idosch@idosch.org>
Cc: dsahern@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 8:08=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Thu, Jul 31, 2025 at 07:22:19PM +0800, Menglong Dong wrote:
> > For now, cycle_netdev() will be called to flush the neighbor cache when
> > add slave by downing and upping the slave netdev. When the slave has
> > vlan devices, the data transmission can interrupted.
> >
> > Optimize it by notifying the NETDEV_CHANGEADDR instead, which will also
> > flush the neighbor cache. It's a little ugly, and maybe we can introduc=
e
> > a new event to do such flush :/
>
> Cycling the netdev is not only about neighbors, but also about moving
> routes to the correct table (see the comment above the function):
>
> ip link add name dummy1 up type dummy
> sysctl -wq net.ipv6.conf.dummy1.keep_addr_on_down=3D1
> ip address add 192.0.2.1/24 dev dummy1
> ip address add 2001:db8:1::1/64 dev dummy1
> ip link add name vrf1 up type vrf table 100
> ip link set dev dummy1 master vrf1
> ip -4 route show table 100
> 192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1
> local 192.0.2.1 dev dummy1 proto kernel scope host src 192.0.2.1
> broadcast 192.0.2.255 dev dummy1 proto kernel scope link src 192.0.2.1
> ip -6 route show table 100
> local 2001:db8:1::1 dev dummy1 proto kernel metric 0 pref medium
> 2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
> local fe80::f877:f7ff:fecb:bfb dev dummy1 proto kernel metric 0 pref medi=
um
> fe80::/64 dev dummy1 proto kernel metric 256 pref medium
> multicast ff00::/8 dev dummy1 proto kernel metric 256 pref medium
>
> And it doesn't happen with your patch:
>
> ip link add name dummy1 up type dummy
> sysctl -wq net.ipv6.conf.dummy1.keep_addr_on_down=3D1
> ip address add 192.0.2.1/24 dev dummy1
> ip address add 2001:db8:1::1/64 dev dummy1
> ip link add name vrf1 up type vrf table 100
> ip link set dev dummy1 master vrf1
> ip -4 route show table 100
> ip -6 route show table 100

You are right, something is missing in this patch :/

>
> You can try configuring the VLAN devices with "loose_binding on".

Great! I'll have a try on this param.

Thanks!
Menglong Dong

