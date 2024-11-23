Return-Path: <netdev+bounces-146900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 209399D6A4F
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A570161643
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FEF2FE33;
	Sat, 23 Nov 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="feUlVgxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4301862A
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732380527; cv=none; b=dXP/HiWUB8B3Vup1K3lNLPpeg38LmczWupiQhW3Pt588xjC+dtHIfrxYX2Mfkiw1GyBOa4LLbvdddke2ju1hBvnBRop4TkqZzykWCuOKKWpLEEe6HFUSa3a6hJhG8QVqTz2anuzJNVnmIbHAYIU0VZ9BpxNvIqFvFa80YsROSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732380527; c=relaxed/simple;
	bh=bPB9eaSNCqsVmCoU8496Fg3t0VKNkqB0lpvtKPdzsL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WW5YoYC9MsdBZ3OLNl/oc1V012uTmyI2rEIfbXCHXVk4870gWD3O+6S9sSbvq7kHsrOQoQJfDRzDN5WKzhNdm1f36PnlKlrLdjGcE7aXQDwzl2z/1iG+mGHBnytCp98bgab/hADoym25VMIcDVYVqpLAvaEV4ZpzDPN3Dq0seEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=feUlVgxR; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa520699becso214782966b.1
        for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 08:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1732380524; x=1732985324; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/ndLfFTb5zT9K/yGcAbC6fybuoZmORzsbyGlmdLoKg=;
        b=feUlVgxRNt+E4F4agQRQKzlusEWVkxlZn755AhZb9ivD2i4qlXaPvt7XL6cMPrHVN1
         8QUNe+whqRZTYhMo1So0G26/FCB4LMAsxBweh1T45o6VyAvbjMqzv88I5NC/Us/zhF8N
         ACvEFwfPBXTjMcaRjvSDwTDVUIv0WgYTgE3/AAx86G0lwTHeaE1LbSYAdjJrDHyrF8zA
         WuRdWSvhF4e6x4w6tTTNBUXhd09syVUhqwyZsoWVmUSuBl+A8hVwxe1f+hKj6g4gNeyQ
         wSTxKNz0I5xrGr5307FLOSHyrvzUAe6e0qwVIni/8CRTUgAvJwM8HSLT077FlM9JbyCd
         oGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732380524; x=1732985324;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/ndLfFTb5zT9K/yGcAbC6fybuoZmORzsbyGlmdLoKg=;
        b=bMXEz7YhmqvOTCJS/aRwPaaatG8UNh3Rt2LFRt4lUW2LxqyKwGUkB0cvpRDhgtuuxI
         vojHUE+SrvUGcxc4lagCmq65jv+Yw+7TrXxcmrs4M/s3N6xlN+l1t52nzWPD5RSwkDlj
         0FPDEgOLKvvrJlW71V19a7BZuFykfPvbsDpLhOwxa75ef9IUgh+GETzLJ+YzaAvwn/UA
         1/ovzDGM5xvFO4i12g9dGjDUKM/lgNkDOIEH8FzebIRqq2CzgPGu0cMitdQndMwgd5sU
         WLgElNvwJfRXUIG5DzRPHxTXRKcgKkXmtoK+Lgiz85rsRgxkw+WWSMYsTBBzDtKaLvgi
         Lqmw==
X-Forwarded-Encrypted: i=1; AJvYcCVNu2fX2EmgidyWJ/HtFjF0/QPAe3TZzYx7MtRswqIYrvqoM66dVNdvlbW5M+YmT+eG+VFvBVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwSycyBD6tuCgVxZrJkE++3lqkmjWsfBZ1CerVO3Rpc9jDCHa
	LTau+SESoUVPTXbqkcfmu1ZACZ9pYBoxe+JoBsXNyX8qWUZ8uQ07ZIovVb7JtW4=
X-Gm-Gg: ASbGncvW5N2a0CUe255/SSGvHtPjFOMz5OlLxBCW1LlB5A42u/N4SFmMP1GO4T9Jfts
	rN+sBM1sh4WC9nbARkO/ALM+uzB/fQxepIgvkQjt6OCDmdUcQQKuZDBUAKmwE93v80lem73jmgt
	m6qZV6mdMjPAKRffA//glfHgYZBFAGdT8A4O4hhM2RUMxlDhW2PiA7oI+F+w7E6BCo7LajcPBS/
	VYkPtwi6ckg0owOfM+v4pz1OHaAoQPM6Ms2w6FZVw==
X-Google-Smtp-Source: AGHT+IE0WxFzdJ3aRVO6sc51DU+Q3HyYpOYu9hEWkX9XdWHUI/131Nu2Ndnr2qsURTGOYhh4lIW+zA==
X-Received: by 2002:a17:906:1da9:b0:aa5:3950:10ea with SMTP id a640c23a62f3a-aa5395015ddmr157637166b.36.1732380524096;
        Sat, 23 Nov 2024 08:48:44 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:18c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28f8d7sm249430666b.22.2024.11.23.08.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 08:48:43 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,  David Ahern
 <dsahern@kernel.org>,  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,  Ivan Babrou
 <ivan@cloudflare.com>,  stable@vger.kernel.org
Subject: USO tests with packetdrill? (was [PATCH net v2] udp: Compute L4
 checksum as usual when not segmenting the skb)
In-Reply-To: <20241011-uso-swcsum-fixup-v2-1-6e1ddc199af9@cloudflare.com>
	(Jakub Sitnicki's message of "Fri, 11 Oct 2024 14:17:30 +0200")
References: <20241011-uso-swcsum-fixup-v2-1-6e1ddc199af9@cloudflare.com>
Date: Sat, 23 Nov 2024 17:48:42 +0100
Message-ID: <87h67xsxp1.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Willem,

On Fri, Oct 11, 2024 at 02:17 PM +02, Jakub Sitnicki wrote:
> If:
>
>   1) the user requested USO, but
>   2) there is not enough payload for GSO to kick in, and
>   3) the egress device doesn't offer checksum offload, then
>
> we want to compute the L4 checksum in software early on.
>
> In the case when we are not taking the GSO path, but it has been requested,
> the software checksum fallback in skb_segment doesn't get a chance to
> compute the full checksum, if the egress device can't do it. As a result we
> end up sending UDP datagrams with only a partial checksum filled in, which
> the peer will discard.
>
> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
> Reported-by: Ivan Babrou <ivan@cloudflare.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> Acked-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: stable@vger.kernel.org
> ---

I'm finally circling back to add a regression test for the above fix.

Instead of extending the selftest/net/udpgso.sh test case, I want to
propose a different approach. I would like to check if the UDP packets
packets are handed over to the netdevice with the expected checksum
(complete or partial, depending on the device features), instead of
testing for side-effects (packet dropped due to bad checksum).

For that we could use packetdrill. We would need to extend it a bit to
allow specifying a UDP checksum in the script, but otherwise it would
make writing such tests rather easy. For instance, the regression test
for this fix could be as simple as:

---8<---
// Check if sent datagrams with length below GSO size get checksummed correctly

--ip_version=ipv4
--local_ip=192.168.0.1

`
ethtool -K tun0 tx-checksumming off >/dev/null
`

0   socket(..., SOCK_DGRAM, IPPROTO_UDP) = 3
+0  bind(3, ..., ...) = 0
+0  connect(3, ..., ...) = 0

+0  write(3, ..., 1000) = 1000
+0  > udp sum 0x3643 (1000) // expect complete checksum

+0  setsockopt(3, IPPROTO_UDP, UDP_SEGMENT, [1280], 4) = 0
+0  write(3, ..., 1000) = 1000
+0  > udp sum 0x3643 (1000) // expect complete checksum
--->8---

(I'd actually like to have a bit mode of syntax sugar there, so we can
simply specify "sum complete" and have packetdrill figure out the
expected checksum value. Then IP address pinning wouldn't be needed.)

If we ever regress, the failure will be straightforward to understand.
Here's what I got when running the above test with the fix reverted:

~ # packetdrill dgram_below_gso_size.pkt
dgram_below_gso_size.pkt:19: error handling packet: live packet field l4_csum: expected: 13891 (0x3643) vs actual: 34476 (0x86ac)
script packet:  0.000168 udp sum 0x3643 (1000)
actual packet:  0.000166 udp sum 0x86ac (1000)
~ #

My patched packetdrill PoC is at:

https://github.com/jsitnicki/packetdrill/commits/udp-segment/rfc1/

If we want to go with the packetdrill-based test, that raises the
question where do keep it? In the packetdrill repo? Or with the rest of
the selftests/net?

Using the packetdrill repo would make it easier to synchronize the
development of packetdrill features with the tests that use them. But we
would also have to hook it up to netdev CI.

WDYT?

-jkbs

