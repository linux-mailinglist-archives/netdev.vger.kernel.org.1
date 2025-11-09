Return-Path: <netdev+bounces-237052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBE0C43F29
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 14:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8CD3AB17A
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98FE2E172D;
	Sun,  9 Nov 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="fG7eZJTB"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A65263F44
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695986; cv=none; b=NRoTp3ydWkgGH566BHk5xfsWbBV0XmyqD4syE6UixJyJ1XaGJZNamlizx303jEIYexeeqOz5PDysKF12bdZB4+bK1Fme2ibZ43BH8LgurkTy28D8UHIe+hTusBLpsVRq1K9l0iysU3TiISXFmGAzkgy2rEXt+/PFQ3w9KQzF7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695986; c=relaxed/simple;
	bh=oaDvmiad5GEafcx24qyGRiv8OqHVkLAlkuF7smx5/bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pQGHxsrs7zBjSwa9VkJI6YIuRtcuR7OwXj7p965BXmFq3YuHNo32bPFX5O0tGl36eGNFto1HPAxy+o2/XFePxZ03RsAy0yauwIysaKQq7QKvS5IqQqafVX6pSWg/eT/pdDnMLi47uxA07Pj/dfKST7QUOr4d4zvfoPHkvbbRR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=fG7eZJTB; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding; bh=WrjUiJspR5xJulm2pKopqEBqEUVD/+Bhra
	9sFh9vJfQ=; b=fG7eZJTBkWNQN7CiexYQQcGrp3Im41ju1pu9xdexgmyebdpsQj
	9zPm/gl4ur0U8oFqDVHJwE+R8MHbdN0NmHjEXZx9U2sooOJcdpLAMFkGux8kAN80
	Zgag69We3Os3/JNySr0xaaLPdxrjfrZJEvtzYu8oXbz3qFvnZ8/0JbCAs=
Received: from estar-Super-Server.. (unknown [103.233.162.254])
	by web4 (Coremail) with SMTP id ywQGZQAHNqQWmxBp3iH6BQ--.2322S2;
	Sun, 09 Nov 2025 21:46:09 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: Discussion: Potential Hardening Ideas for ICMP Error Handling
Date: Sun,  9 Nov 2025 21:46:00 +0800
Message-Id: <20251109134600.292125-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQAHNqQWmxBp3iH6BQ--.2322S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1DArWkAr1UXr4DJF4DXFb_yoWrXFyUpF
	Wvka4kKw4Ut3Z7WwnrZa18u3yrKrs7Gw45G3W5u34Iya90kFySvF4Sgw42va47Crn8Z3Wa
	qr4jqrWDAF15uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5tOzDUUUUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQIBAWkPJHjWjAAGsl

Dear netdev maintainers,

We previously shared some ICMP Error-related verification issues via
security@kernel.org. These issues make attackers able to spoof ICMP
Error packets and modify FNHE caches without strong validation. As 
these cases involve stateless protocols such as ICMP and UDP, it is 
inherently difficult to propose a complete or definitive fix. However,
in certain deployment scenarios these weaknesses can still be exploitable
in practice — for example by polluting routing or PMTU caches (leading
to unintended fragmentation behavior or route changes), or by leveraging
side channels to infer additional information.

Based on earlier discussions, we would like to share several potential
hardening ideas with the list for broader consideration.

**1. Handling of embedded ICMP packets in ICMP Fragmentation Needed**

From earlier discussions, we revisited how ICMP Fragmentation Needed /
Packet Too Big messages embed an inner ICMP packet (most commonly Echo
Request/Reply). Echo Request may legitimately carry a payload for PMTU
probing and should continue to be handled accordingly. However, other
ICMP types — including Echo Reply — are short to exceed mtu, or passively 
generated and are not used for PMTU discovery, so embedded other types 
of packets should not trigger PMTU updates.

In testing, we also noticed that Linux currently validates an embedded
ping packet in Fragmentation Needed messages primarily by checking the
16-bit identifier. **Without correlating additional context (such as the
destination address of the original flow or the expected packet length)**,
this check can be ambiguous and may allow cache updates based on
insufficiently validated inputs.

One possible hardening direction is to require stronger correlation for
PMTU updates derived from embedded ICMP packets — for example, verifying
the original destination address or additional fields beyond the short
identifier — and ignoring embedded ICMP types that are never used for
PMTU probing.

**2. Deliver ICMP Errors only to connected (private) UDP sockets.**

Requiring a socket to be connected (peer 5-tuple known) forces an attacker
to first infer the peer port/address, raising the bar for off-path 
injection while preserving normal connected UDP use (DNS clients, RTP,
etc.).

**3. Ignore embedded ICMP packets in ICMP Redirect.**

Although Linux exposes accept_redirects to disable processing of
Redirect messages, this setting remains enabled by default on hosts.
This means that hosts may still update their next-hop selection based
on unauthenticated Redirects constructed from embedded packets whose
legitimacy cannot be reliably verified.

Even in environments where Redirects are used for local load balancing,
ICMP itself imposes **negligible bandwidth overhead**, so disabling or
constraining ICMP-triggered routing changes does not materially affect
traffic distribution. At the same time, the stateless nature of ICMP
makes Redirect messages particularly easy to spoof, and the kernel
currently has limited context available to validate them.

**4. Prevent raw sockets from processing ICMP errors**

In current code paths (e.g., icmp_socket_deliver() → raw_icmp_error()), 
raw socket error handling can end up calling the same routing update 
codepaths (FNHE updates) with very weak validation: essentially the 
existence of a raw socket matching IP/protocol is sufficient. This is
risky — tools or servers that open raw sockets (such as NMap) could be 
tricked into causing cache pollution. We propose in the current design,
raw sockets should not be allowed to trigger FNHE updates, **even if it 
is connected, since only IP addresses are checked, without further 
checks like port/sequence numbers**. Or maybe strong checks could be 
applied? But we don't have good ideas yet.

Yours Sincerely,
Yizhou Zhao


