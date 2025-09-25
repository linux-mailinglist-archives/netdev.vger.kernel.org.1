Return-Path: <netdev+bounces-226422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD645B9FFEE
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDE63A4B41
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424FE2C159E;
	Thu, 25 Sep 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qvx69Yq8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894FA286422
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810389; cv=none; b=VGQw0O+xGmypXYVX6Cf2QPHmMMHR5sLofn+bCiD+GLa5IEzOdP/j6Z+OAH3k/fpIf8YgEeGZ7Tdp2xfjeef2cJ3Y5oSscAxG7J7CBscC8vi4x5uH5IiCUgtNfUQ+m1P4nuuLoZwhqkV5nWVNfJHcq5zI9ThOjJRqV4u8gQUL7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810389; c=relaxed/simple;
	bh=fXF76Zrhj1RMOv916kcRrWRpAOD3FLABQM1r4KxSI4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pM3EiPe4ECcEau0ISpQLvwpRQST6Sj0zb4IP9itYNCSqTa5olodjMDHvGVLUhowRIrs7Ok4epb02+EmLGM8MUm7AfLxxFHGhi0Te3D238/atQQ09XRLlP081/0hwIyz6AK32wjQUvWMyg3UYhxuWSDTY4yew5hB/aW3UNgVO/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qvx69Yq8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758810386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FucIY5KdsJxyaHXyTgMuxe7Icu/BgEuhO+vf9F6BlY=;
	b=Qvx69Yq81JW6JUNEaTyEMJ7VloEO3m0LNowbH9QMT5o5LBNp1ewHuSt0DivdxdWuxsl+yu
	nttvi7TqfjPe9QDDtR4I+ZWSq18kWo05XlA9OofFTDmlJI+PXtWT+8w6IW5uIwBaUymgA9
	C557KbwKlCczTaWCzAJK8/9NGztG3sk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-JtAFKKoIOAGR2rKgmmW19A-1; Thu, 25 Sep 2025 10:26:25 -0400
X-MC-Unique: JtAFKKoIOAGR2rKgmmW19A-1
X-Mimecast-MFC-AGG-ID: JtAFKKoIOAGR2rKgmmW19A_1758810384
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso1003806f8f.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810384; x=1759415184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FucIY5KdsJxyaHXyTgMuxe7Icu/BgEuhO+vf9F6BlY=;
        b=sKS7yv2wcTUZJYzSP/ENDFi90UoDjNYCkgDzAQmOvtAvEs9aDhi82231J3J5FA5NYr
         Kp3NVjWr/r/GRQSoEnseSiEZOsDHWXGzXXMcTqrg7oAkI4gghoJbEz3Gh6gUV9fXQfyZ
         HWjS53p+Gf+2YDkDwwWzPGLRh7uiVpZdDayoK6ZvypYQg65zUsF8i7qUzxy+Spg9gUrW
         Yt46ROXZdb9aSeFhqpRP43Q0ttGRYM4VU9CYwbwhtx+qAXqvaaBUSi/sgdN+9wab5Ahu
         DMsbBGLyYtD+p6QGFkaraAlyXlSwdDTvlif+U/GHN4mizDYI18rbDbEFCY/127gj4VmB
         wI3A==
X-Gm-Message-State: AOJu0Yzq25L3K4htqsWuFpimMMPlgMq7qLUs/ZTTRgcqev+AvyINiAJk
	4Ud/ut4yqGOF7prackNJia/e5rW0/hkXlsJh0HN3EmYko7pjxMoH2gaU5lBzxBgCbkWDOFZw98p
	cMxviXEmhsTGhshMmDd/qML5kk2miQ7769bHEmgwd7vG04cwfjTFosPUhbA==
X-Gm-Gg: ASbGnctT76AmVeWE/UGm8vT159V7qiTSg7LfHQ1/+NiPFxULYBAcYhuVfFujPjmaA/G
	7gUvrqF7f0EnNC82KP4TAY3ng/p64CJwz/D43twyzk8eC40cEdP0U1K3QKK1Oz3OUPmxUv3hH85
	vt2PW5vlaUcSKDHejYyqHcquExomI0PM6UrmDocuxAUkYFHLwmhD/N9F8uOsh1q1qTAUOXod7eM
	izTHmi93rOcjSv7uh98BNtWVUn+N3DIPSFaXdaK5+fKjkbn0z3hTgHjObx4pHsABGy+6sznHT63
	DO/o45YIrHwlNQGNh6bAhyrF9bZBA3ZeF5uV4bfvGiH2yYr3o5pwLBsElnHGOnX0+3PNSSEXnkm
	wxvWAXwmoc2bQ
X-Received: by 2002:a05:600c:3b29:b0:45b:7b00:c129 with SMTP id 5b1f17b1804b1-46e35d31f08mr26102595e9.35.1758810383969;
        Thu, 25 Sep 2025 07:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt6+e7Sjp5Gx01g7AoesSjqAqFYLN+zmoXr/rP27KlAKto0/qvp/0CRQs8vOAazuW8mIiGRQ==
X-Received: by 2002:a05:600c:3b29:b0:45b:7b00:c129 with SMTP id 5b1f17b1804b1-46e35d31f08mr26102255e9.35.1758810383536;
        Thu, 25 Sep 2025 07:26:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc560338csm3331931f8f.41.2025.09.25.07.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:26:22 -0700 (PDT)
Message-ID: <811b3df7-b008-4331-842a-eeff54b96874@redhat.com>
Date: Thu, 25 Sep 2025 16:26:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/17] BIG TCP for UDP tunnels
To: Maxim Mikityanskiy <maxtram95@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tcpdump-workers@lists.tcpdump.org,
 Guy Harris <gharris@sonic.net>, Michael Richardson <mcr@sandelman.ca>,
 Denis Ovsienko <denis@ovsienko.info>, Xin Long <lucien.xin@gmail.com>,
 Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 3:47 PM, Maxim Mikityanskiy wrote:
> From: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> This series consists adds support for BIG TCP IPv4/IPv6 workloads for vxlan
> and geneve. It consists of two parts:
> 
> 01-11: Remove hop-by-hop header for BIG TCP IPv6 to align with BIG TCP IPv4
> 12-17: Fix up things that prevent BIG TCP from working with tunnels.

What about splitting the series in 2, so that both chunks are below the
formal 15 patches limit and you can more easily add test-cases?

> There are a few places that make assumptions about skb->len being
> smaller than 64k and/or that store it in 16-bit fields, trimming the
> length. The first step to enable BIG TCP with VXLAN and GENEVE tunnels
> is to patch those places to handle bigger lengths properly (patches
> 12-17). This is enough to make IPv4 in IPv4 work with BIG TCP, but when
> either the outer or the inner protocol is IPv6, the current BIG TCP code
> inserts a hop-by-hop extension header that stores the actual 32-bit
> length of the packet. This additional hop-by-hop header turns out to be
> problematic for encapsulated cases, because:
> 
> 1. The drivers don't strip it, and they'd all need to know the structure
> of each tunnel protocol in order to strip it correctly.
> 
> 2. Even if (1) is implemented, it would be an additional performance
> penalty per aggregated packet.
> 
> 3. The skb_gso_validate_network_len check is skipped in
> ip6_finish_output_gso when IP6SKB_FAKEJUMBO is set, but it seems that it
> would make sense to do the actual validation, just taking into account
> the length of the HBH header. When the support for tunnels is added, it
> becomes trickier, because there may be one or two HBH headers, depending
> on whether it's IPv6 in IPv6 or not.
> 
> At the same time, having an HBH header to store the 32-bit length is not
> strictly necessary, as BIG TCP IPv4 doesn't do anything like this and
> just restores the length from skb->len. The same thing can be done for
> BIG TCP IPv6 (patches 01-11). Removing HBH from BIG TCP would allow to
> simplify the implementation significantly, and align it with BIG TCP IPv4.
> 
> A trivial tcpdump PR for IPv6 is pending here [0]. While the tcpdump
> commiters seem actively contributing code to the repository, it
> appears community PRs are stuck for a long time (?). We checked
> with Xin Long with regards to BIG TCP IPv4, and it turned out only
> GUESS_TSO was added to the Fedora distro spec file CFLAGS definition
> back then. In any case we have Cc'ed Guy Harris et al (tcpdump maintainer/
> committer) here just in case to see if he could help out with unblocking [0].

@tcpdump crew: any feedback on the mentioned PR would be very
appreciated, thanks!

Paolo


