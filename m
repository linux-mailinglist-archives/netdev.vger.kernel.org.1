Return-Path: <netdev+bounces-74387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E437861246
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BAC2862FA
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30E7E786;
	Fri, 23 Feb 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4FcaqgB+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B417AE5A
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693755; cv=none; b=WrZ6RXYtP//5kaMgzqXk4PKQulg+2GWuWQjMxvcPbBAM04aiQHsFrNFGhAnokw8Tu+oDCFpO+DTEtuu2Vt5gfi9OoI7XZE87o2akOGfmssWtO8zkeg41qYNkI2ylaASA5ugBRYhB3rrfi8LK2Z5/goot09CARxdOrqX+Ra8TlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693755; c=relaxed/simple;
	bh=5oxnAR9jOd/xn82V3EZsBR2nFCo/zbhDKEhxECbBMz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWGLH2V4Dr7Kn7ri/Vy2f1BFEhZE13u3AgRJxKmMzW8BvsTWU2leofLpQwfWY2UKgJqlh9vTlgyaiju0EcfNFzYENz9l39RO5R8fBGlerBt2j1LIKHg8zGJwyY2gBJgoVTepxpdAcWWYL8Vdf0rJ9RtSHmvdoTUB7vIGLe6z88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4FcaqgB+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso9963a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708693751; x=1709298551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oxnAR9jOd/xn82V3EZsBR2nFCo/zbhDKEhxECbBMz4=;
        b=4FcaqgB+1C078eAoaafRDL4fqu4DIzPKbAx3ENigfkSUQp0m2u6lXWpMtVcuGuQEeA
         aGc4FDqO7AxjO/eSMc6FX7QDMyQ62QV3/KKiLEd6+i6YTCKC2Cr1HchCU1dbmjUztVGZ
         huAQvTGQRl8bP0XMhiMLoXolKWRUBpFhvP7xzBuDbFGsTEb/EzC62cXsXgpgvZK1Jiki
         HyGdWFURDKfh7UppE7q12/NqFAg6iHgMLdGtCeMGQjCXn261QMOyhixXM6fwVHCJBYFA
         g3u7UAyzktOSWIU6V1dPIoEpBrIVf9cUediXE3Mvcd/uc8NXgs2/kn92xs4odXcZtKCf
         z+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693751; x=1709298551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oxnAR9jOd/xn82V3EZsBR2nFCo/zbhDKEhxECbBMz4=;
        b=sibBT/pEtC2K1/EA9ntwLSfMpFciEyAMqQqsVzDIaq3tho9hFdy+DV4G7574RsUxMe
         WojzNvgS1rwDPXx6m6KOhQBqDn/CDfMHVWG7nCWH85omchlm+0KQJlf0XhRU6SplYec+
         QyorzQ6RobnOfE3ZMZDltF0Xy4U1Hk9ejzCWX552RB+cxzGNQYXgPOLcUF96Q37q7URP
         H/yZuKwvfcphm9/QCRJOi9l0GKC/5F+N6E4SY/1OHTVMjawcNzFFh+8Qgjn6zG1veUzb
         kLY+e4gGCI5dsIb3Qjo63qkKpEUwMy9LsINscvynyDpyudNYDybAPt+45DWhgOXclc4T
         c0Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXxWn8r1BdUH4wGBADRA1CVa+3Z0xOdGSHAlD8CcxoKAaMDb2B5DxEvuZiFbezOWc/OG0s4ACIvhxiIF9/KkZJFrjeGhdzx
X-Gm-Message-State: AOJu0Yxo5QkqP30iXOU26iyYOKivA87pmGG1T/gjbZH/xS/Pza8b/IVU
	uYUaUEk7SgZ/lLbUs1+qBQhXAwlewMjSyzZ0iRLRgtbuEPzuYpKyww2XucUtWvHq6j8po4wl8sG
	fFUgWa7q6HV/pqY8vkcj4A67FhV5KxClMt3zO
X-Google-Smtp-Source: AGHT+IFTFVekIAS/syom6ama+ratNO4vACdmLnCwK3G2sDq+DMZJbrVO0ynz19qzO8cib1qXIYaUCR67YLUqPfbyCLA=
X-Received: by 2002:a50:9f04:0:b0:562:9d2:8857 with SMTP id
 b4-20020a509f04000000b0056209d28857mr700687edf.6.1708693751255; Fri, 23 Feb
 2024 05:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223115839.3572852-1-leitao@debian.org> <20240223115839.3572852-2-leitao@debian.org>
In-Reply-To: <20240223115839.3572852-2-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Feb 2024 14:08:57 +0100
Message-ID: <CANn89iLKdX1owfY3w2Bh=E0rb0v8pJVF2Z3ZtXRE0osAVKtuQw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/vsockmon: Do not set zeroed statistics
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:58=E2=80=AFPM Breno Leitao <leitao@debian.org> w=
rote:
>
> Do not set rtnl_link_stats64 fields to zero, since they are zeroed
> before ops->ndo_get_stats64 is called in core dev_get_stats() function.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

