Return-Path: <netdev+bounces-97798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBF8CD4BC
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254A61F23160
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8F14830E;
	Thu, 23 May 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/zY2jAc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B413A897
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470904; cv=none; b=kOgieatiaJ/p4yx6EK2dikMdM0B3UpddA9iMvny4QFYjBGEyYGouLTJLEN4e003LF33U50tKQKBYv0xu9bNT6LAcXBsaImb1BKV1iqwndp7QS2ARUdT7BaUkFNc4cmicjdAvVxjjw06BCDd30zXnZqDzb62XUE+LCA9Wto3a8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470904; c=relaxed/simple;
	bh=NfIim7fZPkeF4uAgufGDRIHQYxp5OZBMaazYqcwVhAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y66Ism3Gc4tEmVxw1Gw8QFzzTPO6OQidgjAK3sQnr24a/hwe7WmZyId+Aorheglqi2JlIkKtyHL4vBd0Ycf41KBb0o1EXPCQyAqaA6mEkPFeTvoghzeNxRGpK4FB/pNALJ+VGdMxRto1/9wgRv7DzZPhjqdfFI+UgjGwB22n8kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/zY2jAc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42012c85e61so76305e9.0
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716470901; x=1717075701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGkiHXiZlopEqDAbyY39avaP7PMhqGxhWH4GcNFuias=;
        b=n/zY2jAcnNKsBv+2ET9SvdZ7kJgkymQrkwg9lEvRzAS+yrrbdk5qxRtf71b5J2IBts
         xxhUFwMd9zpxtfandGRJDl9V6fDKTMJPZ5rQdPZ+oVHqIrlMfjzAgYzKLEtqZ8HivCKZ
         81WA+VqDMvQo4y4w5IgWJfTNMQHmMqQRT30DTRFmlZCcMNJx3zLlHmlqg69yaM83fZt7
         5V5kWpZUHg5GWlXdlaRyo5GKBs9CGV1iByWzJJUZWLSnE9ZmKZYo/7skBgSeeYyKJULc
         Yj0s8UX/2mCYK+hz1vY1kKvIs3+XrkvHTvs6TAs1zLSIvA1J25V8ILCBzFG7qp00i9sp
         6QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716470901; x=1717075701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGkiHXiZlopEqDAbyY39avaP7PMhqGxhWH4GcNFuias=;
        b=F6QFQCEw2ZGGh3+TfOw9HyFv31E4hdfprdoDMp1bfdwt+2WgVurNa0EBL6Kh7emVv8
         s1QdfBoRTHiXXnH2uCZVYajNybRU17q+TjaS1No91kwXKiTn08g/FZZEe1QUh7ZP0gGy
         knxY8b2tvklYaEmxUvQtLZk8aDUnGz3DQxqzZuDhXvRfav2MPhAyWvX1sPAzhBraxmlJ
         wgh0o/5aPMDJB0Pu4B9E75DJwy9Tv/qYSf8gbZqaSw+DaujlK2Sdmj2+kUYzFy6Fe5gg
         DAK36G0m12zsOo+r12+66InuVF2Fmya2IujMkP+Z8s1OnWvrASi/m8dDqZsWfYdKmSV2
         aKng==
X-Gm-Message-State: AOJu0Yw2OAg/GZmkWPqy/C0p8TLRdQNPuWfXX6mDs/wqNMaz5ke7+FfF
	H1WAucIh/JsNOFxv+xkv3Dq5H3TnaH1iQAH/G72YVROoEcn9xMmsokbIJFWSHBQ517OXdIkOJM2
	Dl7sgT5eA+4AJ6SZLFSKE/xOY1k/iMLy19XsC
X-Google-Smtp-Source: AGHT+IHERK1cpfx0RdZrfAGaZ0b5q56C/TOJwbhRuIu77yKeRsyT98mI7GJ3tYZxxO6NA1Z/m3NEWPaMHrhmNbbRcYw=
X-Received: by 2002:a05:600c:3493:b0:41b:4c6a:de6d with SMTP id
 5b1f17b1804b1-42102430803mr1429515e9.5.1716470901113; Thu, 23 May 2024
 06:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523110257.334315-1-idosch@nvidia.com>
In-Reply-To: <20240523110257.334315-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 May 2024 15:28:07 +0200
Message-ID: <CANn89iKmRhqLWVjQ432-dzmtxiA5ZykEQ1VjJ-SsLPR4bLupjw@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: Fix address dump when IPv4 is disabled on an interface
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, petrm@nvidia.com, cjubran@nvidia.com, 
	ysafadi@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 1:04=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Cited commit started returning an error when user space requests to dump
> the interface's IPv4 addresses and IPv4 is disabled on the interface.
> Restore the previous behavior and do not return an error.
>
> Before cited commit:
>
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state U=
NKNOWN group default qlen 1000
>      link/ether e2:40:68:98:d0:18 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::e040:68ff:fe98:d018/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 67
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 67 qdisc noqueue state UNK=
NOWN group default qlen 1000
>      link/ether e2:40:68:98:d0:18 brd ff:ff:ff:ff:ff:ff
>
> After cited commit:
>
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state U=
NKNOWN group default qlen 1000
>      link/ether 32:2d:69:f2:9c:99 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::302d:69ff:fef2:9c99/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 67
>  # ip address show dev dummy1
>  RTNETLINK answers: No such device
>  Dump terminated
>
> With this patch:
>
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state U=
NKNOWN group default qlen 1000
>      link/ether de:17:56:bb:57:c0 brd ff:ff:ff:ff:ff:ff
>      inet6 fe80::dc17:56ff:febb:57c0/64 scope link proto kernel_ll
>         valid_lft forever preferred_lft forever
>  # ip link set dev dummy1 mtu 67
>  # ip address show dev dummy1
>  10: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 67 qdisc noqueue state UNK=
NOWN group default qlen 1000
>      link/ether de:17:56:bb:57:c0 brd ff:ff:ff:ff:ff:ff
>
> I fixed the exact same issue for IPv6 in commit c04f7dfe6ec2 ("ipv6: Fix
> address dump when IPv6 is disabled on an interface"), but noted [1] that
> I am not doing the change for IPv4 because I am not aware of a way to
> disable IPv4 on an interface other than unregistering it. I clearly
> missed the above case.
>
> [1] https://lore.kernel.org/netdev/20240321173042.2151756-1-idosch@nvidia=
.com/
>
> Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_=
ifaddr()")
> Reported-by: Carolina Jubran <cjubran@nvidia.com>
> Reported-by: Yamen Safadi <ysafadi@nvidia.com>
> Tested-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

