Return-Path: <netdev+bounces-287199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMZ5FAU4A2qK1wEAu9opvQ
	(envelope-from <netdev+bounces-287199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:24:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5B5225EC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E948302C4FB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA98B3AFAF9;
	Tue, 12 May 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IKKoP8MZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A513AF670
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595466; cv=none; b=XrsfQwrwXbyGVvdLOyzQAdoQ+MIwPsOl/229kXsTV8vSrtSVWl4pO/oQt+dp7hgMXJEDVUvLHrZi84+C8wE3y/OnlXd006iBHVGxcQJpWLUFvEXbtqf8Ym1JdRscORH5tnlpdkttqiLWe72cLS10ARqc/AdCg1QCJveByFUx5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595466; c=relaxed/simple;
	bh=NVggfJLPOArhx8otVfCM2tXZ5uP0At3kls0Rgg9Ls2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVl20DVk3zggBZrpPzCuI0eMl1fRhAZ6AOEc4BtJuByGYzxpBgKMlbD9Y3GT8Bw0WvGMnyJOxBc/f1WPqvd0mR2OTsMnkFG3lxWk2IK7NtsMWn39SDeNkg89WVwn/UKYUEhxwevSV+86YQEahBToKF9y0VVkcpCONGcbfI/SLIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IKKoP8MZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso34890185e9.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778595461; x=1779200261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ir04jsaDaoE/Fgj2pkJq5xz4Zo9Hfr5WjmH+ZtcvAI4=;
        b=IKKoP8MZhvVVK7sCrTAljPeObZPRzoHEvHEm4lrHtAwmVbNF74UqWRmWLjGjbErxBE
         +Asn6dUOLn9163uNanfMkX/YZQllKRMzaiPlLyiRoOEb3dfWwdEfDifV/uugQgKHhngY
         h+oBX4GkTwo9bypSAIv2HUrng7Y0rk7R7JTd+9p1dN+PXs7LhmW8HfuKyZWdriKdwtRV
         iuTkszaf8jsT0n+sFBaat0ahyxTN0X+8BSA5ArUf9rkyplaJnYItETXYfeCAes+d9swB
         pijRPBvvEM3828YtkeM0iW46CzJ/36id1uKO/ITus4XkP/K3zI5CPSBp3bFSxgUJigmX
         8E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778595461; x=1779200261;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir04jsaDaoE/Fgj2pkJq5xz4Zo9Hfr5WjmH+ZtcvAI4=;
        b=L2gcyyfe4qgQ/LbT9KgynsiRiEZo3mti7qdFlz9IujdR/BUn9NPx98DlBObrnpbv7r
         7j/e5pxu3Y1T6hiN5HkeZSoYSzaKWA0WkBakqKn1+XEjAACR6/nfsEF3P5bG7SZfhPyH
         C86y4X/YgmtgKEUdUsln30ZcLvqyiXjovtS/JxpLC9Sz91iZ/R7PwdWdgqQh93Z43wTF
         SR1lXsr78ANh+PykG2qWJrybLiKhNXC1qICzTsA4VQoyq5RRv6abAwOWEt3VJEmtdhKG
         1MawgqxCmatOBbc1mQzHRbFaTHSj1oUbItVzKYxAJbBgTspcxKwzDGJs+OKbbVVJzI5e
         Nt3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+TIaTX4qa9Nd0+b9fDax/1eubvnuVwhiX6aPKn0UDjhYpoRMZGNhLb5YGT4q1uWAAPaqDoDyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvkjaOAUNrZOnyAXrctklkHqTKFwHjwFRCttoOQCsyI1/HCgXg
	H1rn3jOkGcF7dWmaKgqWSpOgqLCLpzXmzBD8Dl1P8g5E+vrKDM6Vk8FmuvPmr5neIQlYjAA8YLu
	KPM6WLK1CGdUT12iWHOVXozzO8A7mVzlzkVk6Ie5qOHmL7p5No9Q=
X-Gm-Gg: Acq92OH3lZM3bFf6mf8EjrYFABubvb262Qmf7g9rWac8l3uToasUwXrd1NV8FD7FL/S
	JaIHvDBU/Zlflbj5sztN7yfDIVdByp6/Zz1Gk8BaLbpI5+iu0YhXjczEuUHRA5qSSqmEtgJqqmv
	ibrf0ruQ5P56z5wRLqLbRCid7G6DD6ppFPv17UToDQf0Gsp8uoQvati9drWT0QZKsAUctI+vTLV
	ZuZwMHHB9yT80Bb0nVdwAEX7HoVInQWM+UKqkrHITtpiKXSJx0DD72NJVFtoYYb5OjYwb/driXT
	f9LMNLrjk1wbTooBCEt2iOsnX2dXbKNoi7UftsWsUWvCwtG5KxUoZZ9AimQWR8xjm5S9xIMsZG4
	tT82BVBtr3HQXSMZIXe/3BSnjLB/XT1oD5SQBCRVOD+NE9dQvXcO4c0OWLUm9/0+iNsRLOUT7N5
	JkK93XBPaE8o2wygVYzEfoc3xhnBFOMp4hhH2Z++79hOqIxKzMX38f/P+VRd1mr5nYbTeKuwpS
X-Received: by 2002:a05:600c:524e:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48e676c14b9mr297461955e9.29.1778595460908;
        Tue, 12 May 2026 07:17:40 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:7245:d44f:b95f:a2c6? ([2001:67c:2fbc:1:7245:d44f:b95f:a2c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm34893875e9.2.2026.05.12.07.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 07:17:40 -0700 (PDT)
Message-ID: <a2cbd426-cf71-40d5-9b5e-220758775660@openvpn.net>
Date: Tue, 12 May 2026 16:17:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ovpn: tcp - use cached peer pointer in
 ovpn_tcp_close()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: David CARLIER <devnexen@gmail.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20260512042036.19870-1-devnexen@gmail.com>
 <20260512042036.19870-2-devnexen@gmail.com>
 <CANn89i+qfzW_S-Z_vT3=UH00Qu2KodJf=V7O3o=yMVgfjK82xg@mail.gmail.com>
 <CA+XhMqy50a8zq1foi564r2niHzJo54E3TCpT-YmYa=r2n75Uyg@mail.gmail.com>
 <4ff6590a-6695-4c6c-b677-a7891b249165@openvpn.net> <agM1LMZ30jZDRqZ3@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <agM1LMZ30jZDRqZ3@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0DD5B5225EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287199-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openvpn.net:mid,openvpn.net:dkim]
X-Rspamd-Action: no action

On 12/05/2026 16:11, Sabrina Dubroca wrote:
> 2026-05-12, 15:55:39 +0200, Antonio Quartulli wrote:
>> Hi,
>>
>> On 12/05/2026 06:56, David CARLIER wrote:
>>>     Same multi-read pattern shows up in ovpn_tcp_recvmsg(),
>>>     ovpn_tcp_sendmsg(), ovpn_tcp_data_ready() and ovpn_tcp_write_space()
>>>     - happy to roll those into v2 as well, or punt to a follow-up,
>>>     whichever you'd prefer.
>>
>> @Eric, if you have no objection, I'd pick this patch up in my tree and let
>> David follow with a new patch for net-next.
> 
> But this patch is not fixing any problem either, right?

Mh, because the sock outlives the peer, so there is no risk in accessing 
sock->peer in this case, right?

 >  Then just wait until David sends the whole change at once?

Yap.

> 
> And since the "rcu_dereference_sk_user_data + !sock || !sock->peer ||
> !ovpn_peer_hold(sock->peer)" pattern is used multiple times, it would
> be better to turn it into a helper (ovpn_tcp_get_peer()?). That way
> the caller can't be tempted to play with sock->peer.
> 
> (also, please wait at least the usual 24 hours before applying)

ACK


Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.


