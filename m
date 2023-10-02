Return-Path: <netdev+bounces-37470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACE57B57DC
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2CBBD284DED
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BAF1DA44;
	Mon,  2 Oct 2023 16:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD71DA36
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 16:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26182C433C8;
	Mon,  2 Oct 2023 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696263636;
	bh=cn3xALDnM1cQ93QfpRjQxFIEQiPqxd5lJVvzPDPuITQ=;
	h=Date:To:Cc:From:Subject:From;
	b=U4JRmh4O13ka6Ccr+r6x7M14zyeRxTejb7Vf2F++t+m+MpBrHlgIN2mENhJPggTuj
	 HNwEsGBfobube03i+3g6ZyftVg3Y78X26KzAl+C53DboTon+CechoCZle9R260UYGS
	 xI9BkRnWteDh5fNo4i7q843GQ2bpLABzV6G9RvpU9SUQi4QAezHTtMJDoN58IbOnno
	 GSW1u33X3jrRqUnmOLgpzn4QnhIFpg7yuIagQ/ExsT7CwzzAw5tI8MCpBBvGY/uLmF
	 itBQFDr3wsUhVTh2zZjp9KC4JJGjhJpW6CCltPBYwLjTT5XHct9jn3wg8QUfUNr/EB
	 hPzPG+MtS2dAw==
Message-ID: <881c23ac-d4f4-09a4-41c6-fb6ff4ec7dc5@kernel.org>
Date: Mon, 2 Oct 2023 10:20:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Xin Long <lucien.xin@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: David Ahern <dsahern@kernel.org>
Subject: tcpdump and Big TCP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Eric:

Looking at the tcpdump source code, it has a GUESS_TSO define that can
be enabled to dump IPv4 packets with tot_len = 0:

        if (len < hlen) {
#ifdef GUESS_TSO
            if (len) {
                ND_PRINT("bad-len %u", len);
                return;
            }
            else {
                /* we guess that it is a TSO send */
                len = length;
            }
#else
            ND_PRINT("bad-len %u", len);
            return;
#endif /* GUESS_TSO */
        }


The IPv6 version has a similar check but no compile change needed:
        /*
         * RFC 1883 says:
         *
         * The Payload Length field in the IPv6 header must be set to zero
         * in every packet that carries the Jumbo Payload option.  If a
         * packet is received with a valid Jumbo Payload option present and
         * a non-zero IPv6 Payload Length field, an ICMP Parameter Problem
         * message, Code 0, should be sent to the packet's source, pointing
         * to the Option Type field of the Jumbo Payload option.
         *
         * Later versions of the IPv6 spec don't discuss the Jumbo Payload
         * option.
         *
         * If the payload length is 0, we temporarily just set the total
         * length to the remaining data in the packet (which, for Ethernet,
         * could include frame padding, but if it's a Jumbo Payload frame,
         * it shouldn't even be sendable over Ethernet, so we don't worry
         * about that), so we can process the extension headers in order
         * to *find* a Jumbo Payload hop-by-hop option and, when we've
         * processed all the extension headers, check whether we found
         * a Jumbo Payload option, and fail if we haven't.
         */
        if (payload_len != 0) {
                len = payload_len + sizeof(struct ip6_hdr);
                if (length < len)
                        ND_PRINT("truncated-ip6 - %u bytes missing!",
                                len - length);
        } else
                len = length + sizeof(struct ip6_hdr);


Maybe I am missing something, but it appears that no code change to
tcpdump is needed for Linux Big TCP packets other than enabling that
macro when building. I did that in a local build and the large packets
were dumped just fine.


