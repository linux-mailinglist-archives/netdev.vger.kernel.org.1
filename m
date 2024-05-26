Return-Path: <netdev+bounces-98091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6268CF4BB
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 17:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C871F21153
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFBB175A1;
	Sun, 26 May 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0SeE7jU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868EC8F40;
	Sun, 26 May 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716737146; cv=none; b=KcPUmme1vnGXSWCi+AiixyDMBQQrUVLbPZMHyck9P2wyOpsi3VydJwgHK4LFzrMBfn5m4X55BKkSkA4GqgQj43ANFua6Rxeq1hjSnwLeyMSvkiqCIFhPtJ/EcgXuTjHxuDN6TjAhrHv0tryLM8G4L6Qu90sOo//jgBnSo0PAw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716737146; c=relaxed/simple;
	bh=6R89WTgi0G5SP1DkMP+ZFwqx8ARm0GBb5pJEeVOXDV8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G3waNrHHSCf4BNmz/JG4nE/YZkBsk84Ntmu7avhdnt8sdr/MS7HBykCu4pbWc0VhVT7kkU7ZTtI1HMLaDUiAXgYCXB7zGDIK7ALGQUb0F7IQEDFyvnxNuOeHvKWIyKZJ1rV8ao3B9AY3u8kOWqBGd1tQSvP8wszi+d2+R/zeVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0SeE7jU; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-794ab181ff7so168492185a.2;
        Sun, 26 May 2024 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716737144; x=1717341944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=louWz9TZ0OcBxeP6RxFmCfU2E06wYI5extN9BJ94M1w=;
        b=e0SeE7jUZcxXn3FVpaCVSAQR8hWQWtfmca4EkssApmBHUMt0tgDzef6ICesljPPVjm
         FZ3N4dwzHcCGRnOqhZ4hJPjwwcekP9rd7Gxi5NmejNxKSKGt3YO/N9DQrhTgOTco095W
         aP2bUr+/7zN1Y0eQynFsA/Y/vsKZ96d5ibdzOVVs1Zco8gxYodYtaK4HE5yTAF5gGqT8
         VaEXpUyc3D14+Ec/hMChaWyppPpfrHTqkszwGEuKFE2ihjGC20Ly/Yof83panQLMRctR
         tnfwFhAyGy9egS3Qbe5QwEgHJCfMbg1Xu7k81nA6ieS8AePdxHJMbMTdyUcUIafo0xWY
         Qg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716737144; x=1717341944;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=louWz9TZ0OcBxeP6RxFmCfU2E06wYI5extN9BJ94M1w=;
        b=QpbX2Ry2JBtDjPgOfeJRgsmBabmNjxYGjL/8Z0rtEgAEyPYIz9mAO1eOsg6nn1oYUs
         OrtqZR8xQhn24EVXOA08o4O86rjBMS1mCgZndL4qbCutfQ3iHhhW5HDqDw4GFaoEwcjz
         jxMZuz4DTO3WVuAd3HFevUQ8JJgd6DSlTtOmQBOKXoWDI4tyYUHoFibrpLayknp5sIQf
         61Mdr9j3x44BZ0awSNmB76Z97zRXGO1/fkdr+h8kao90c3QmV+n5G17SGiQWNwO/SK/g
         hUlh4SrthSghv6YlX29mqSqRznMmRNnyc6gTjgMRtTarin1uCvNnx/lPWsM26LiiV1NF
         Edcg==
X-Forwarded-Encrypted: i=1; AJvYcCXfq0nt2nt9iAvuDXEQN6pDCts83Wn0sKbC3YKMxIQHPm0GAD8HtAEtfG8xZwvQOD+zbstoDmvdPJwr6tvW6Ds4MxCNGzXi8R9C6FsIL7ifSrCLHkHFRn0FEKcuCjmkk7XevCrh
X-Gm-Message-State: AOJu0YzhncEVOHHGwMXHpxwXCI/9aelYoFQUps8PTLB/H8/J6z2xTGUW
	zGYvQlPO0e/0I+y8zJACNgND5O22QY0thQvsFkhJv1BwBzLA+KCW
X-Google-Smtp-Source: AGHT+IF7KdBDW5l34T0qSTfPj0CAtNo/+tnkhrMFrXgN4Z/krZe1a9f7UsrcEjpBXhQjHTPRVI2DJw==
X-Received: by 2002:a05:620a:440b:b0:792:e153:111b with SMTP id af79cd13be357-794ab08452dmr845713785a.30.1716737144236;
        Sun, 26 May 2024 08:25:44 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd32d1esm233613485a.121.2024.05.26.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 08:25:43 -0700 (PDT)
Date: Sun, 26 May 2024 11:25:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: alexandre.ferrieux@orange.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chengen Du <chengen.du@canonical.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6653547768757_23ef3529455@willemb.c.googlers.com.notmuch>
In-Reply-To: <3acef339-cdeb-407c-b643-0481bfbe3c80@orange.com>
References: <20240520070348.26725-1-chengen.du@canonical.com>
 <664f5938d2bef_1b5d2429467@willemb.c.googlers.com.notmuch>
 <CAPza5qc+m6aK0hOn8m1OxnmNVibJQn-VFXBAnjrca+UrcmEW4g@mail.gmail.com>
 <66520906120ae_215a8029466@willemb.c.googlers.com.notmuch>
 <3acef339-cdeb-407c-b643-0481bfbe3c80@orange.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

alexandre.ferrieux@ wrote:
> On 25/05/2024 17:51, Willem de Bruijn wrote:
> > 
> > First, we need to even understand better why anything is using
> > SOCK_DGRAM when access to L2.5 headers is important, and whether the
> > process can convert to using SOCK_RAW instead.
> 
> For libpcap, it seems to be linked to the fact that the "any" device can 
> aggregate links with varied L2 header sizes, which in turn complicates filtering 
> (see Guy Harris' comment on this [1]).
> 
> Given that 99% of useful traffic is Ethernet, such considerations look awkward 
> now. I for one would love to see an "any2" based on SOCK_RAW. And while you're 
> at it, please let the new variant of SLL contain the full Ethernet header at the 
> end, so that a simple offset gives access to the whole linear wire image...

Complicating factors are loopback and tunnel devices, which are
common. Loopback (ARPHRD_LOOPBACK) is pseudo Ethernet. Libpcap does
convert this to DLT_EN10MB. But it converts ARPHRD_TUNNEL to DLT_RAW,
as can be expected.

I don't think a new DLT_LINUX_SLL3 is a solution. The application
just wants to receive the full L2.5 header, not yet another parsed
version.

Libpcap can conceivably already read with SOCK_RAW and still convert
each frame to SLL internally.

Separate from this, I'd like to see where exactly these L2.5 tags are
inserted and whether any besides VLAN (incl. QinQ special case) are
even susceptible.

For VLAN on the normal egress path, like the ICMP reproducer, this
probably is in vlan_insert_tag_set_proto. Not 100% sure. That indeed
inserts the header and updates skb->protocol, without changing the
network header.

MPLS in mpls_forward does appear to update network_header, and uses
this in mpls_hdr. So perhaps the issue does not extend beyond VLAN.

