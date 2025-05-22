Return-Path: <netdev+bounces-192870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD0AAC170B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D65A44252
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A171129DB8C;
	Thu, 22 May 2025 22:55:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0147229B8EC
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954533; cv=none; b=RVDapgSiuia5SWlHEllCaMmCwfUmW+c0jGIqRvHZxyoO+SYvNbuuz/lOaRrYv5yz1rETwRMsI54TWd7PyE8J9OPcHEm5GxfIumYmffZ8JTgUAVpPds2t5y0b+bBACOYWCWVlqfPZy4qgcDhkFQoQIcgbfnzQ5zcL+fET8Vsr4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954533; c=relaxed/simple;
	bh=ou6RSv/x7n9xL2cAtrEQ0u/WhTuETMCtobnEEi6T+u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUywQ3Jj3zm1WY2MwcjGKFIhrWKCYSWX4eD9AdNsxj8UhRo9JoxXd6TqPgMJvExSZfafrNiZLWFV/2iCtaaHebsfPz1uGmGoqALPkPSV6EL9APcO3V024hpup+f/1OWiFEAg/ZMuebYeCuRkaUBvfc2HyY2Ari+AzcRYglDNs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7d664bcd34so1880598276.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 15:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747954531; x=1748559331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adpV2Solr9Pp5IhRdG1YcgE2gI2kY44w0Hxu+crlaGw=;
        b=hVmrfKtgL66QS3HUdQUqGjWlk63DE7vo8ryCR9g5YtU3E7uZ4GWOGTMuSj9ql6PY3s
         6P0eLeJpuOZv5hFyK+1qQnueChcFkOT2kB6pImWozUi6JqhWYDS3wxDzcCCA9hR/UX75
         J9GB0t0Nhqgjrf5sWADZ3PSj/gkRMgmJPk39+3DNjRgZvKc0DbTTH/2mHbos6XLJ0OQm
         ql7VE8m4nFl1IjI9VmjaJklBFYmJFK+kaFQu8UV07juUdmD+Jjuf35xK9+k1qRE+Vh2G
         2bXR8W3KI90jStaBc5oDiAAAeMJO8G17xPBL7FbE2HqbfacmU1ymEsqgYn56OLq+kL7r
         xavw==
X-Forwarded-Encrypted: i=1; AJvYcCV5cM7IaOfo9dZKRD4no3pfXTgsOKcIc3cG5plsGt3QLPU82LNz83lwIkwIetEUsQVm7FJZfQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFMl1NbiDkANKMOENSCWbpuGm39LdSsCCAMSwxk4n0gxIeGhD
	OSFZm9fvu6ZATSmEg++lxbGtaKfB6x3lXeRTNbtD8NI5md29rnlUsiWP8Ww6xlgV
X-Gm-Gg: ASbGncvwNpjw9j5XQVKfqU6zwqi+OTcC96wX5YuwWvqafubNVGOFXF5p9mxMoHpu4y9
	irN/Oc9OanRqPZHzsutm8ZqnE4RD53MoH+ziEMjHHtujQBXFZTxIcNY0SVAUgYbx7ylX6b7VodQ
	g3ZATlt19jaENI88150OJu5L7HbwQ+LOi8/r/5G7DgF6k20OwZGpdcuRxmbNG+BaykXqip/Wgat
	f45xlxrCjqyXmoKMOORlrOpVoDWmkQkmaIE1P85B8KeaXqNIKp3bEBf7aRyXE/pqzkgPxEcjaAz
	bkaKxEMRgRArRKOzJWZTGZ8gZTLn/o2jwVIOdX6DG0hZbt/HqoByRwc833phGV3S6iEswzeXFPv
	FyeH3c4r954Kf
X-Google-Smtp-Source: AGHT+IG9aNj8SEGv4Ji6u8r+OCmVe/mks/EiQqhXiFlQdoMj0ow8ye3sH9v5VUv82bG2Cr+fTxXGAw==
X-Received: by 2002:a05:6902:1684:b0:e7c:3db3:9a1e with SMTP id 3f1490d57ef6-e7c3db39b1fmr24021440276.12.1747954530689;
        Thu, 22 May 2025 15:55:30 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7d5d2b447fsm1372715276.4.2025.05.22.15.55.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:55:29 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70dec158cb7so33400587b3.2
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 15:55:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzRz4u2ijgL4fSWRmllI8JR7eZZOLcVqoQcfC0FYODoOudWMm9pPDfn1r7gNHrkUIKTV6Upuw=@vger.kernel.org
X-Received: by 2002:a05:690c:650e:b0:70d:f237:6a6a with SMTP id
 00721157ae682-70df2377852mr133458987b3.11.1747954529644; Thu, 22 May 2025
 15:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174794271559.992.2895280719007840700.reportbug@localhost>
In-Reply-To: <174794271559.992.2895280719007840700.reportbug@localhost>
From: Luca Boccassi <bluca@debian.org>
Date: Thu, 22 May 2025 23:55:18 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSsy3t+7uppThVVf2610iCTTSdg+YG5q9FEa=tBn_aLpw@mail.gmail.com>
X-Gm-Features: AX0GCFvgn8QgRgIGFMJhTNArgoPPGhjrwpCbwuUo-zBZ1egEnTqiXP-0DJbnrHg
Message-ID: <CAMw=ZnSsy3t+7uppThVVf2610iCTTSdg+YG5q9FEa=tBn_aLpw@mail.gmail.com>
Subject: Re: Bug#1106321: iproute2: "ip monitor" fails with current trixie's
 linux kernel / iproute2 combination
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern <dsahern@kernel.org>
Cc: 1106321@bugs.debian.org, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 May 2025 at 20:41, Adel Belhouane <bugs.a.b@free.fr> wrote:
>
> Package: iproute2
> Version: 6.14.0-3
> Severity: normal
> X-Debbugs-Cc: bugs.a.b@free.fr
>
> Dear Maintainer,
>
> Having iproute2 >= 6.14 while running a linux kernel < 6.14
> triggers this bug (tested using debian-13-nocloud-amd64-daily-20250520-2118.qcow2)
>
>     root@localhost:~# ip monitor
>     Failed to add ipv4 mcaddr group to list
>
> More specifically this subcommand, which didn't exist in iproute2 6.13
> is affected:
>
>     root@localhost:~# ip mon maddr
>     Failed to add ipv4 mcaddr group to list
>     root@localhost:~# ip -6 mon maddr
>     Failed to add ipv6 mcaddr group to list
>
> causing the generic "ip monitor" command to fail.
>
> As trixie will use a 6.12.x kernel, trixie is affected.
>
> bookworm's iproute2/bookworm-backports is also affected since currently
> bookworm's backport kernel is also 6.12.x
>
> Workarounds:
> * upgrade the kernel to experimental's (currently) 6.14.6-1~exp1
> * downgrade iproute2 to 6.13.0-1 (using snapshot.d.o)
> * on bookworm downgrade (using snapshot.d.o)
>   iproute2 backport to 6.13.0-1~bpo12+1
>
> Details I could gather:
>
> This appears to come from this iproute2 6.14's commit:
>
> https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?h=v6.14.0&id=7240e0e40f8332dd9f11348700c0c96b8df4ca5b
>
> which appears to depend on new kernel 6.14 rtnetlink features as described
> in Kernelnewbies ( https://kernelnewbies.org/Linux_6.14#Networking ):
>
> Add ipv6 anycast join/leave notifications
>
> with this (kernel 6.14) commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=33d97a07b3ae6fa713919de4e1864ca04fff8f80

Hi Stephen and David,

It looks like there's a regression in iproute2 6.14, and 'ip monitor'
no longer works with kernels < 6.14. Could you please have a look when
you have a moment? Thanks!

