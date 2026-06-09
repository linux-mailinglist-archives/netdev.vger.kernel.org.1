Return-Path: <netdev+bounces-296933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mOGVHyO/J2rl1QIAu9opvQ
	(envelope-from <netdev+bounces-296933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:22:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1CB65D245
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:22:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=Gv05w5BT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296933-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296933-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71E4A30BDA2A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD2386C39;
	Tue,  9 Jun 2026 07:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F23859F9
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 07:19:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989569; cv=none; b=b8iKpImaetQFNxCvgYSJ45emHwIX5me56GGdcOTXGFsNd01vcr/8EHWGrRX6o7Q/TLckmJd0roTWRFFMRjMhb4Im6kYEzulQOMaoPe3OrYRG2UPXMn/JJ6TV081cgxOV2TbMhDuBUL8vp89/qALRdZQTxChnWQVmIzBrWeyubBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989569; c=relaxed/simple;
	bh=hbu9LZPJQJKkJV5RA0xvycBkawmZo+tP6274zj/Z2kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4saEXvtKnPvazwgaLfXbHEWDiOBMp0JVCWuv4iDMLhr9UnhJlfyHrFkQLBYLwC498Am4gq+lQIl1oDKw5x+uG9IBRnGAMstzDINrfD1kea9sThoQHc9QpPCHag7Y0L+bOIQjTQ1kURlvsWMUBVEh3lH0l5y2SThOfNVhP3r9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Gv05w5BT; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so66217875e9.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780989566; x=1781594366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wq+m8phuoZlyVyvQJDDKnLnM7niPzjxS+4T8fLFpKmo=;
        b=Gv05w5BTSlXax/BpBj4ZwAlU3jVrbxHe9nSA7fw3s7Mu85SiO72txegYx1SWAxxxYx
         eyUTxoxrVQ28vvbwaFnarI3thFuLPgE9pLx4KSZ/Hky/1H++l+DeZty2oo3OE0t41Ltf
         ItIHiA+vvedJrS4gM+TGrAeVdTfGM5BN1j30M6ZM5oKbM9WthTPjEMOwe59wHUJSdF6u
         N+a66FAxiZ/VhB02VhORTDzqO5J9+1BlIanyZ7QlCLu0yTuxuFA+zYeStp1x/nfdgspK
         cgflFauvtu7Z6fxXUME+5ePag+cnIqE30QVoB9Z2jB6ULjZU1Gt+ghXTGfkwDm3h+ZH7
         fOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780989566; x=1781594366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq+m8phuoZlyVyvQJDDKnLnM7niPzjxS+4T8fLFpKmo=;
        b=cNi96z3QFtc+IofZAw+9wrFsWkeqSfpDEy0SHoPWpviSim0150SpIM0+aQGt4dNJj+
         Kq2MRNcgpeuPfJ4slaAFgzutZc+GHYsE6kbGMIvfzd0405iqEWwMB1HdiTo5NuynsSYS
         DNntNpqTVOVxN/rg6QIkP/7pL9inFrK+etdTFehXeJPaCROMPhk31bFvw0CSEbokGqlf
         ZCBlXeU7diy5nCeDpT6RynV62jrHMVm/RkiSu6Nv/8u3FjyETn6kRQl8254lxC34xXAs
         CIeaXh8mPmi5ip87Rtzslaz2xgj2mRb8BrSflZnEkltfxvRhbMrIgpr7q79wt8UMtD8Q
         94dA==
X-Gm-Message-State: AOJu0Yyu/yBoskKQ7yMejJ9FdJn3aYcY0sXovV9yiI4n+tKH0UnHYZ+m
	G3wGux5GF+5tT9StFrNwcyyGjMfrt8+dYvM3zIKVM1TDB3t01jqLPJro0dyoUDjwc9g=
X-Gm-Gg: Acq92OFW9CdXai1C0TftP4Wvtabn/bGWwfumsdGQ/Lxnm9oTgLlfDmS0hrOoV/UHyqV
	JeLU43+L3/L6WQCMNNYzfljkrlcoA8Vr9fV+HF8rrbLCvxUF8Xg2qreW6C+Yzo91OrGAp7N51rY
	4n7Gnev26qIzGpiHlRZp3ZkhS7KtE3xPd7Vjg/d+E6hlL9n8SbeHo4WM0+MaBouEyBINiDgUis8
	tfpOR/6ohQSUJrgUR7y7WlAHZ7RLtg1PD2H8zsIq4SH9LQLPyAl10137wAlhYreMR4y5EwlIUOj
	H35vUkXmmMb/T7v9TnilIC1UIp/Y+gp5q5p4KaBM7QcKc6wb6Wg4+5iMJzxHGO/TCrwYBe15TiK
	+2adKKOBRBKlc15aYl55S8BoOehBwJEDjgObjdNvbNg8b5Z/Qsmav5quFAAQm1A5TezxfOneRj6
	6QLLQyqR/GbcPlq9/onDptcvBAbuSfsKRenAmRxOAzUC7HbfDXRvz1AcL2hh/zTuu4qu71dyk8C
	0k=
X-Received: by 2002:a05:600c:6087:b0:490:b294:c652 with SMTP id 5b1f17b1804b1-490c25b0696mr319291365e9.20.1780989565866;
        Tue, 09 Jun 2026 00:19:25 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm401895235e9.4.2026.06.09.00.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 00:19:25 -0700 (PDT)
Message-ID: <099ba3ba-49af-4ed2-8b58-31f8132f0d32@blackwall.org>
Date: Tue, 9 Jun 2026 10:19:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] bridge: cfm: reject invalid CCM interval at
 configuration time
Content-Language: en-US, bg
To: Xiang Mei <xmei5@asu.edu>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bestswngs@gmail.com
References: <20260606215848.1951633-1-xmei5@asu.edu>
 <20260609064613.GA652158@shredder>
 <CAPpSM+QGAARoC2Jq2EfMkXCgBQXy7k64W6rBFdJ8mhpfrR0zXA@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAPpSM+QGAARoC2Jq2EfMkXCgBQXy7k64W6rBFdJ8mhpfrR0zXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.linux.dev,davemloft.net,google.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296933-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:bridge@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF1CB65D245

On 09/06/2026 09:51, Xiang Mei wrote:
> Thanks for your review and the tip. V4 was sent.
> 
> Xiang
> 

Please don't top post on netdev@.

Cheers,
  Nik

> On Mon, Jun 8, 2026 at 11:46 PM Ido Schimmel <idosch@nvidia.com> wrote:
>>
>> On Sat, Jun 06, 2026 at 02:58:48PM -0700, Xiang Mei wrote:
>>> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
>>> the configured exp_interval converted by interval_to_us(). When
>>> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
>>> interval_to_us() returns 0, causing the worker to fire immediately in
>>> a tight loop that allocates skbs until OOM.
>>>
>>> Fix this by validating exp_interval at configuration time:
>>>
>>>   - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
>>>     [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
>>>     netlink policy so userspace cannot set an invalid value.
>>>
>>>   - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
>>>     not yet been configured (defaults to 0 from kzalloc).
>>>
>>> Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.")
>>> Reported-by: Weiming Shi <bestswngs@gmail.com>
>>> Suggested-by: Ido Schimmel <idosch@nvidia.com>
>>> Signed-off-by: Xiang Mei <xmei5@asu.edu>
>>
>> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>>
>> Nit: I don't think that the Suggested-by is appropriate here since I
>> merely had minor comments on the previous version.


