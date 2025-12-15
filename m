Return-Path: <netdev+bounces-244738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57187CBDD47
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 631163023EB3
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E021B185;
	Mon, 15 Dec 2025 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eD3IuVwU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="grdH/Dd2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF891EB5C2
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801920; cv=none; b=ouicmo0sCLB0yKnIDHQGXAStg3s0fu7Nvx2kEW5M7FFd43mg9vvUGtv+3K4r02xPNueVtxG+Q54O3mqFN662W98+b0IyS7JgQmvXu8kzD9/hUUNqBO7tSCH7WYy8N7qAHmOPx5JCtrModgW+1bvcWLtecyGQNrXLNJsvvinGeqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801920; c=relaxed/simple;
	bh=DwX+1zLWMhG9c5yqMqifXYDlyLFUb+ZqcfpFSbA5yco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ud64CWT1qfDcRK64VvziAoHgA2j5nCpPMdbkE9oRv0ovxH8TKxcExVWiLDe/Bn6chdqHUQ6RmDlsXDrvbdF7X3VdZ0vCoWYhC6XVYGbw0fUa4yPjjnGZexByARVX7n4d6fx1pSyZKRxhFtEt1dwqqm1VUbZu0UqMhONQMsRqJtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eD3IuVwU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=grdH/Dd2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765801918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwX+1zLWMhG9c5yqMqifXYDlyLFUb+ZqcfpFSbA5yco=;
	b=eD3IuVwULQSGbLyHfdmyEp6jpY2rdLOsUvK1xTtOZIqopLwhfuYvCWqKaIx8C+0dftCkff
	oFRmNYtxPDGcO7nFS5BfsoAM+2dOF/UvQMLtith1yHsJ4iRmjMmeot+DaTGcbbJMybwY72
	lbW+sh6rfOFps5CMcT9JKJPzzWcnJMo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-n6xMVSpZNC-PDWWo-hrS6w-1; Mon, 15 Dec 2025 07:31:56 -0500
X-MC-Unique: n6xMVSpZNC-PDWWo-hrS6w-1
X-Mimecast-MFC-AGG-ID: n6xMVSpZNC-PDWWo-hrS6w_1765801916
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b726a3c3214so335151066b.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 04:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765801915; x=1766406715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwX+1zLWMhG9c5yqMqifXYDlyLFUb+ZqcfpFSbA5yco=;
        b=grdH/Dd2uAohm1BUawdllQrHsCbiBSM/wMnPEEgepFTuFl2QW0bH3KjBYojHttu5uo
         Yzz1cw6qoUJ4PhiNZFaI8ts0W3io7tO9anWsUl/fvKHm+INV7o3ATdiSXNNqgJhW41mx
         VtKDrsyIkdTK2VoJMY1qJfNxXdWfP1VBUpxwXtRO3W39ciF72OPEnY8S0vbFvjf41owu
         AaVPej36JjB/oNTDnaI2ihQpz9L2KOkT9ei4JtI2LymhkvzbO6xvJdtiYjPPsq4mfhJ7
         MnGG3cPlm+oL9KUcVKjUmQh104kkPPL3k9yfVJel3JfMLwr8s3xFUtfR+tNMBRC7n0Ko
         6vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765801915; x=1766406715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwX+1zLWMhG9c5yqMqifXYDlyLFUb+ZqcfpFSbA5yco=;
        b=Zss/TYdVpkHOLrLJQdSnljz2OCz05D+QOZ9c80uJDkbWn1SAjByvPWtdXDj89csIWW
         oR755DwjKCZpqPjI3npPrWBP0AiP1ElpgSbYn2jOsJsh6iHQsDih5vys2DDZPiQEYa3N
         HC0VxiDYEWyJWVWPTCYKC8I2LMfT3x7mljxuHUqGMGaO37lvhecHg/jPYuLplkw/BBZK
         vRFALc/uUQ6Ebf7qx3ghYpfjUdaHqUGqrVZyqpkPwtrU66AH6fzuNb/D+5ipUcgvyldk
         LsYONe3JcGr9mlbQGhQRmoqxx0oPjGtP4P4oHWwRsX1Z9K22GA64m5KR5r/09HpA/heL
         m26Q==
X-Forwarded-Encrypted: i=1; AJvYcCUazX6jVvrB/2cC3ndSw0dgqWptVXLBn3dVrNRbP6wS9sMFEjMsAL1B91QVN61Sceov7fIFrUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAE3rt/og4BpL41L5kZU3aW2AA158P2y6253eqn/kbVXsGyNry
	Ei/+Sb+H9Bv44xPypESQkJ5bi54AMwwCJIVzy73eUvRO24EhulGeHuTHYQyJy3hDWm7+j6ywMN0
	OEmHS2FhYqfsgPnXfVhb9ZT+y6MkOcKgfzY890n4XJ00nxe32/q2XeNYDxg==
X-Gm-Gg: AY/fxX5HcZ4povZ6lUcr2G9UDD38HdBJFCL5qCdtgxcjm9BkcuXR52p5L89LlMh4HAZ
	Pm3BjTPeQlVspI3nLfRHU/Clis8ulwpHLWetGwAY1RrIEzJSfY1G4BCu/HMJuPvr4lOjCtRzgiZ
	VVKKylsS2XlAv05NKuIeDCmfPQjetW88s9t9PxrgoCPCd/UU7ekMJnheRBi8osuRrwkTjBjEz8Y
	Ef+7cC6VZC6AE0kcSmSBfKXVkwg03ypIzEDbFTYeot5DBhznnA5mzyZYGkNRRY73sXrcmTCGRk3
	s+DniIf+WH+KTCYkc3bJw64Q5UfGPyGX06/7x/tUPZaDZ8Q8GK+Fg8LSTYWnF65UWMgf9EJ/35u
	LRfzi6VeG70o0Utrqp3Gl2jjSk/Xa0bRR/wbNXFOon84exxfR5KdSPSooFkI=
X-Received: by 2002:a17:906:ef03:b0:b79:b910:fd45 with SMTP id a640c23a62f3a-b7d238bb08emr1115742266b.38.1765801915482;
        Mon, 15 Dec 2025 04:31:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH/zmTEBETCcU5nGWAabRKLe7SiWJwjBA2DBtyA/t1RuG13frO9+qbmZ3D0bUOqE483xpIbg==
X-Received: by 2002:a17:906:ef03:b0:b79:b910:fd45 with SMTP id a640c23a62f3a-b7d238bb08emr1115738766b.38.1765801915012;
        Mon, 15 Dec 2025 04:31:55 -0800 (PST)
Received: from [10.44.33.154] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7fe8a956a5sm13997866b.29.2025.12.15.04.31.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2025 04:31:54 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Adrian Moreno <amorenoz@redhat.com>, Aaron Conole <aconole@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Alexei Starovoitov <ast@kernel.org>,
 Jesse Gross <jesse@nicira.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH v2] net: openvswitch: Avoid needlessly taking the RTNL on
 vport destroy
Date: Mon, 15 Dec 2025 13:31:53 +0100
X-Mailer: MailMate (2.0r6290)
Message-ID: <E6D49A6B-A0F7-46B6-BC32-A5C4ADAFD6DC@redhat.com>
In-Reply-To: <87qzswklc7.fsf@toke.dk>
References: <20251211115006.228876-1-toke@redhat.com>
 <198C2570-F384-4385-8A6B-84DCC38BB5F5@redhat.com> <87qzswklc7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15 Dec 2025, at 12:58, Toke Høiland-Jørgensen wrote:

> Eelco Chaudron <echaudro@redhat.com> writes:
>
>> On 11 Dec 2025, at 12:50, Toke Høiland-Jørgensen wrote:
>>
>>> The openvswitch teardown code will immediately call
>>> ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notification.
>>> It will then start the dp_notify_work workqueue, which will later end up
>>> calling the vport destroy() callback. This callback takes the RTNL to do
>>> another ovs_netdev_detach_port(), which in this case is unnecessary.
>>> This causes extra pressure on the RTNL, in some cases leading to
>>> "unregister_netdevice: waiting for XX to become free" warnings on
>>> teardown.
>>>
>>> We can straight-forwardly avoid the extra RTNL lock acquisition by
>>> checking the device flags before taking the lock, and skip the locking
>>> altogether if the IFF_OVS_DATAPATH flag has already been unset.
>>>
>>> Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
>>> Tested-by: Adrian Moreno <amorenoz@redhat.com>
>>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> Guess the change looks good, but I’m waiting for some feedback from
>> Adrian to see if this change makes sense.
>
> OK.
>
>> Any luck reproducing the issue it’s supposed to fix?
>
> We got a report from the customer that originally reported it (who had
> their own reproducer) that this patch fixes their issue to the point
> where they can now delete ~2000 pods/node without triggering the
> unregister_netdevice warning at all (where before it triggered at around
> ~500 pod deletions). So that's encouraging :)

That’s good news; just wanted to make sure we are not chasing a red herring :)

Acked-by: Eelco Chaudron echaudro@redhat.com


