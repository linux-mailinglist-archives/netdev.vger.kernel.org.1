Return-Path: <netdev+bounces-245747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F8CD6E14
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 19:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3279E301E5A4
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822ED32ABCA;
	Mon, 22 Dec 2025 18:14:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D442F84F
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766427247; cv=none; b=c7Jjl+j3sRUpXdA8VT93x0ifdmw2I9Su/n0Egf3j/+pyon97Ur1ufUXG5apmWPY61ltt/k8rfQclXsTd4WD3JSPMsMIr2iyXv1eoHpD7tcdgs3x35j1FT62D8VbGJAvrsD3GAiOOfCzFxgTdmvRtjGl9Y3l3S9xmvrPDNZFPipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766427247; c=relaxed/simple;
	bh=KK7AWOhHo5O+oZg+YnBNljTTp9b9QbAvLxB3JO+9Owo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C8CdUb2BPnbV0B9/QnHcghsenFM+p25xkcz3VOcavHC1VI6l+OI9ghVH+wMlsnKQlBxiY9DFRp3FGwkHouwEWtTj3TN1L31t7RKy0h5OLfKqdssuO5piLjIrWz6G5K5Xw7RcqB/ZUdagl1OOL8oeKejw5R9eeRvUh8s+Fn+uD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lja.fi; spf=pass smtp.mailfrom=lja.fi; arc=none smtp.client-ip=62.142.5.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lja.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lja.fi
Received: from mail.lja.fi (80-186-162-127.elisa-mobile.fi [80.186.162.127])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTPSA
	id fc60f06c-df61-11f0-a38e-005056bd6ce9;
	Mon, 22 Dec 2025 20:13:58 +0200 (EET)
Received: by mail.lja.fi (Postfix, from userid 120)
	id A581A156FC5B7; Mon, 22 Dec 2025 20:13:58 +0200 (EET)
X-Spam-Level: 
Received: from [10.202.212.169] (unknown [83.245.227.85])
	by mail.lja.fi (Postfix) with ESMTPSA id CC1AD156FC5AF;
	Mon, 22 Dec 2025 20:13:44 +0200 (EET)
Message-ID: <aceecca9-61ae-454f-957f-875c740c0686@lja.fi>
Date: Mon, 22 Dec 2025 20:13:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC] STCP: secure-by-default transport (kernel-level, experimental)
From: Lauri Jakku <lja@lja.fi>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
References: <73757a9a-5f03-401f-b529-65c2ab6bcc13@paxsudos.fi>
 <CANiq72mE5x70dg_pvM-n3oYY0w2mWJixxmpmrjuf_4cv2Xg8OQ@mail.gmail.com>
 <ac4c2d81-b1fd-4f8f-8ad4-e5083ebc2deb@paxsudos.fi>
 <22035087-9a3f-4abb-8851-9c66e835b777@paxsudos.fi>
 <c6cdc094-6714-437b-ba37-e3e62667f4aa@paxsudos.fi>
In-Reply-To: <c6cdc094-6714-437b-ba37-e3e62667f4aa@paxsudos.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Copyrighted-Material: https://paxsudos.com/

STCP is an experimental, TCP-like transport protocol that integrates 
encryption and authentication directly into the transport layer, instead 
of layering TLS on top of TCP.

The motivation is not to replace TCP, TLS, or QUIC for general Internet 
traffic, but to explore whether *security-by-default at the transport 
layer* can simplify certain classes of systems—particularly embedded, 
industrial, and controlled environments—where TLS configuration, 
certificate management, and user-space complexity are a significant 
operational burden.

Key properties:

  * Connection-oriented, TCP-like semantics

  * Explicit cryptographic handshake during connection setup

  * Encrypted payloads handled at the protocol level

  * No plaintext fallback after handshake

  * Minimal configuration surface

  * Kernel-level implementation (Linux), primarily in Rust

STCP currently uses:

  * ECDH-based key exchange

  * AEAD symmetric encryption (e.g., AES-GCM)

  * Explicit, length-prefixed record framing (64-bit BE length + IV +
    ciphertext)

The project is implemented as a *real, running kernel module*, not a 
paper design. It is *experimental*, not production-ready, and not 
proposed as an Internet standard or upstream replacement.

STCP does *not* aim to:

  * Replace TCP globally

  * Compete with TLS or QUIC for web traffic

  * Provide backward compatibility with existing TCP stacks

Intended discussion points for netdev feedback:

  * Does this class of “secure-by-default transport” have valid
    kernel-level use cases?

  * Are the design trade-offs reasonable compared to TCP+TLS or QUIC?

  * Are there obvious architectural, security, or integration pitfalls?

  * Does this kind of experimentation belong in-kernel, and if so, how
    should it be structured? I got very interested parties (Big IoT
    companies and such) that wait for the module to mature.

Full design RFC (including wire format) is available here:

https://github.com/MiesSuomesta/STCP/blob/main/kernel/OOT/linux/RFC.md *
*
Feedback—critical or otherwise—is very welcome.

--Lauri Jakku
.---<[ Paxsudos IT / Security Screening ]>---------------------------------------------------------------->
| Known viruses: 3626996
| Engine version: 1.4.3
| Scanned directories: 0
| Scanned files: 1
| Infected files: 0
| Data scanned: 0.00 MB
| Data read: 0.00 MB (ratio 0.00:1)
| Time: 12.668 sec (0 m 12 s)
| Start Date: 2025:12:22 20:13:45
| End Date:   2025:12:22 20:13:57
| SPAM hints: []
| SPAM hints: []
| Message not from DMARC.
`-------------------------------------------------------------------->

