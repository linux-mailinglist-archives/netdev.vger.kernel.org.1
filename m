Return-Path: <netdev+bounces-255179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDkjOkfXfGlbOwIAu9opvQ
	(envelope-from <netdev+bounces-255179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:07:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75285BC62C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6876E300D9E3
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80302346774;
	Fri, 30 Jan 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="nHIftM4R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0004833ADB0
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789253; cv=none; b=jtWxpyrMYHqz3ftATb1U9hAb/X5bTxI1nRmc74k35jgKFCgrvFbvf0M6rGrj4QlWAHT50JqAY9nGv+tOoiNyWMyRdQA3ESS7pbGmOfoG68PRLqma8XB8Ow/IR47kq9p4O96Ujv37pfZJDIMyeWIpkreez4UjQ/8K+4yDriE34/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789253; c=relaxed/simple;
	bh=glDWBkFLkq2Rpl2t6YYy5nXPsLXkzRXunN1b3fSz9KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayOSia9Nrb8W3EOic6RN8+OTkHhiQEMkZcR10+0+a3ku3St5wYqqadItBch7DQrqhzovcKNjt/0v1jGaCUuYQ8L5TGD43MXjSPDqUcC+ZfwjFq44S0fYLwFMr+sOnwpuvmFT3w04LkItTcni+7ljY5NwyeWmJkBXVRR/3lb0np8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=nHIftM4R; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48069a48629so23551195e9.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1769789250; x=1770394050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHXRqF/L3co4cy+9Ekt13qLFwgpbfOD/ThjuH1VDpow=;
        b=nHIftM4Rq0AGgvhye3CXLApVDcZikRgtuUGsOLskezI8eqwhFgXhiylFqWPbl9hgwN
         a2R5FwQwBS6hVewTQqF5VqBDDZQiPFG2Oo+c5U1Sisw34EtCJi8e3ly0LsznN2OD9SD/
         L1KqPGTm8Cf4t9voB7RCYlNDoikl3EKtBIg5VsA/Fc+9EKtyhw9tRWSb7yVVglbNEgVD
         HzIlmYL0ShVF9h767U/0dgLsr20LfDmWQyOOnO1sSBRjFgROTxDADUfRDkwjgnnaiWTw
         XpjGygnzhCDCBY8CLSIBZOo68rcB9YnpyvvbuPuy9WBT/3sYDBcQw3Npwmhn3cqxn4qq
         GEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769789250; x=1770394050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHXRqF/L3co4cy+9Ekt13qLFwgpbfOD/ThjuH1VDpow=;
        b=s7S5x+3y/Un7M4h7oXXX1uFWEzQa5vca0Kxk9F0UphkEm/a1c1wifxI1pJDE/BXk9Y
         jS2jKw415sVisYnC83aBYBdxuqhcLwIj8VBn85M1M7uchxWo8aWLYJXKbk2oeXkRn1z9
         2WlqcbgoMZIrs1Gv9sRdvX06zlyyuwqPnFM1aV1gN1Tnu/DP0PQU56SmAXDKxFtSR6mS
         dbXXyDKFEwf+HwgvlKOmxeQks87JI54ksQJO4DILHzmajnZoGgi2WKhLsn4ASEwSYmvH
         Tx6wrjIJraKfsVTJxxlI6Htj7keRCvqx0sIrvojirxDAUjcMKOfIPjGyLjkUtuYyJJFJ
         bIhw==
X-Forwarded-Encrypted: i=1; AJvYcCWCuYvcCigHoDtdoSdSbzO5kH05OBSXrJmPUizsoDJgrtFe52DNXM0kBUFNcwz2oLtJGUObp0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyNWk/TILuw577J+7HVc6hFG7qkpcKGO3qOIkVIF5VA/5AyxA
	faYkC1jPGx/yPgak8ASXCQnjzk6ct020sqJP0MLu/RBn3kh9e6zcQSVd5C0g5dQKEiw=
X-Gm-Gg: AZuq6aJDUM9B8txQi3mDfDYhsIbqMNUW7kS6UfxPOXn4k9tnsEaVGYAdIyQp9qyTAtd
	fW0mf0W7Fh0YGry4I3gQK3GVDRONhxx610vtD3HbplPGU6C2uXaqW4z5zuUNJHtceckBGOzyUsi
	IfljuZax5p/gpUIrN8verdsiWWDLsyRe8SWoU4TKbA5IBDPPvLcd19k2ezrqgVhuoOZSeJn85v/
	kAOU+ckCiDGxZweGok/lX2JBlNdpEzZNWUlERnoFmq4TRmpHrwEpZntYTc6LapLwNWK4qRSjiZd
	z5sWiv9hDMgFqNmbCjhpZXyN35NMMbZWZdt/LTxmS/Of4kY0dToLE+rJtYx/rDqkHF1CTEHmdv7
	jTC8yU25OAAqvCSGTdt12aV3hyZOZRR5AMvKnrcRjlx+dRfndubDx3R3EsKE1afyDH5tGMg5CRh
	DyMFyaSKcUJle7HlKKudnWPTwrrkbcIwo8HhtggOCx2A==
X-Received: by 2002:a05:600c:a413:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-482dbc0ecb8mr31923295e9.12.1769789250044;
        Fri, 30 Jan 2026 08:07:30 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e25444c0sm16824625e9.8.2026.01.30.08.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 08:07:29 -0800 (PST)
Message-ID: <fef5419d-081d-4601-9ce6-f597beed7716@blackwall.org>
Date: Fri, 30 Jan 2026 18:07:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: only set speed/duplex to unknown, if getting
 speed failed
To: Jay Vosburgh <jv@jvosburgh.net>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130111904.144024-1-tbogendoerfer@suse.de>
 <aXylwyr2pV0rZAW3@fedora> <3932974.1769787530@famine>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <3932974.1769787530@famine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255179-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[jvosburgh.net,gmail.com];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75285BC62C
X-Rspamd-Action: no action

On 30/01/2026 17:38, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
>> On Fri, Jan 30, 2026 at 12:19:04PM +0100, Thomas Bogendoerfer wrote:
>>> bond_update_speed_duplex() first set speed/duplex to unknown and
>>> then asks slave driver for current speed/duplex. Since getting
>>> speed/duplex might take longer there is a race, where this false state
>>> is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:
>>
>> The patch looks good to me. But based on your description, I don't think
>> the fixes tag is correct.
> 
> 	Agreed on both points; I suspect the origin of the race window
> is:
> 
> commit e9fe8efeeae11f19bb6fafd6153ec77deaeb4b83
> Author: Nikolay Aleksandrov <razor@blackwall.org>
> Date:   Tue Sep 9 23:17:01 2014 +0200
> 
>      bonding: procfs: clean bond->lock usage and use RCU
> 
> 	as this patch converted some locking in the procfs logic to be
> solely RCU.
> 
> 	-J
> 

I don't think so. :-)
bond_update_speed_duplex() can sleep and has never been called with the write_lock.
See for example:
  commit 876254ae2758
  Author: Veaceslav Falico <vfalico@redhat.com>
  Date:   Tue Mar 12 06:31:32 2013 +0000

     bonding: don't call update_speed_duplex() under spinlocks

It seems to me that behaviour has always been there, regardless of having a
read_lock in procfs or not.

Cheers,
  Nik


