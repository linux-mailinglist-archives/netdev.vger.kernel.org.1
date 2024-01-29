Return-Path: <netdev+bounces-66842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC218412B5
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13CA1F223A3
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F24F157031;
	Mon, 29 Jan 2024 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdhDt8KN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BC6F06C
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553876; cv=none; b=O/b9In1Xvjq6gVBaOlo3dcciok3Ty+wt+WMX6UyVcxdQyJ93B/JDZ/7J3Bv2y/p6j3a3TV8Ks2diBe/imt2dik+Wvm2aKLjlhwVXEkDtkBiV4GDlR1dpmdRqhi/mxsj9lT48ji0Yu9ZRd5bJieMKzH9l3vMKbeoAr3pJin1dX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553876; c=relaxed/simple;
	bh=IOZmRBt0q9IpVG5pXka2+SykfVhTYJvq2mlpTJfpQ3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aURAphCEQxENZfQBy0yci0GJL2rfgJJhLtQONDgU4F27sovMUKkT6lWoahpoExDfvcFT5P3Dxm5kSC7qb3nqk3IqAU3p2QWJo6nokiGlJtSC1BUwUk1lNH+wRN9oI7SkSRUYFzOQQLpP4xqAeFzdqvlX78IUmH9PDTyQEgbdyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdhDt8KN; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bfea28a1c9so79772239f.0
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 10:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706553874; x=1707158674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUXjGQtxHj2/o/ZE+fDwp0c79AdQeZ4I1A6ZiRnp6yw=;
        b=SdhDt8KNbhWYWtQuS1GM6ILg1adKdR48hDkUvMBlrLmGVCpSilv4+ykFmRUPpvpdFK
         hKPnpDh1C5PhFOaaxWa661+nqCcU2DFc93SejzxVKFPvbtlLtBKzTw8iUnRrWJ6VcvWm
         nQPFB9npdK0ZNICd4lmrmBgc1kQIRNdg23wMHLPnAvVuKN93SHQ16kZ0EtBMjZDaynh/
         MO45w0i+YBHZKuD82aIJ3kGJvUih9OueKDWBvPJNPNX9+31vqHflYe0G/IER13/gBoNW
         DJGSYvOQXtzxZ0xvkUbUYOH2EY3zk0wtF2whup2RtG5rxX97DLdSsU830/7WwASiXGJG
         gJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553874; x=1707158674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUXjGQtxHj2/o/ZE+fDwp0c79AdQeZ4I1A6ZiRnp6yw=;
        b=e/OzN+oLtWmye/Hw1b26eWfWRfPoKzPw1z9NmBWP/hejZC8lKUQEMzmxPJlBFCOhOB
         djA68bfGKnjWpQMtlfoqx0PdECiEhLbwAVe9FiXn+LRdE7DPPZ3MSJA8ucUG5GPGZgZN
         z/VAngraZqJ2zdByKVJvLvAC1Mu5d6Sxllshk+7d/UbmKGn7yhFT4oykDnwL8MkmJ92q
         1tSuetJvs2i1+x8fFk/V2I90tCrQX3vXspsFwF0JVzlnRP+UUBhoM7/u6hIfuZnDIHuv
         hoiIxOFCehIZrDkTH8gulwp1Z/WLfs5ZuI691D1YJ/RrdBCG7nZ6maIcC4JkzFc3Ccb+
         pahQ==
X-Gm-Message-State: AOJu0YzhZljmCrCeunK+faa5DqmJanEOmrLeGpfvqAGEeE8wkrg5snad
	CMjp7i4u699uASpemdSd3uq5gKhp5AS9V2DzqmYEByPckcwouIlL
X-Google-Smtp-Source: AGHT+IEC+ouQjIOAvbjERXruohF65dqc9l3anfDMUNxsQALXhwXUriV755gW2XFrh0CCFrARLdqOVg==
X-Received: by 2002:a6b:d90d:0:b0:7bf:96ab:e152 with SMTP id r13-20020a6bd90d000000b007bf96abe152mr8204582ioc.4.1706553873657;
        Mon, 29 Jan 2024 10:44:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXI5QqveKidsuhchrVHEI3s77D6W+AtRqpzBkOAkNZDEPKmtf6OXfscufF4wnrSZ9ahOUz3K9Kka73Q9xfs6t57CkmEOmRvbSe++mKjRvH7LkgjB+7x+D35LiorDIgQRi2ulibKsztF89WytE3ZHPg5HCs9w/wI
Received: from ?IPV6:2601:282:1e82:2350:245c:6a9e:25c1:5469? ([2601:282:1e82:2350:245c:6a9e:25c1:5469])
        by smtp.googlemail.com with ESMTPSA id h27-20020a02cd3b000000b0046e29003e62sm1874886jaq.112.2024.01.29.10.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 10:44:33 -0800 (PST)
Message-ID: <02331777-cf56-4491-91c2-df76eab88032@gmail.com>
Date: Mon, 29 Jan 2024 11:44:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>
Cc: Vincent Bernat <vincent@bernat.ch>, Alce Lafranque <alce@lafranque.net>,
 netdev@vger.kernel.org, stephen@networkplumber.org
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder> <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
 <1793b6c1-9dba-4794-ae0d-5eda4f6db663@bernat.ch>
 <1fb36101-5a3c-4c81-8271-4002768fa0bd@gmail.com>
 <41582fa0-1330-42c5-b4eb-44f70713e77e@bernat.ch>
 <1e2ff78d-d130-46d4-b7ad-31a0f6796e1a@gmail.com>
 <e60e2cc1-02c0-452b-8bb1-b2fb741e7b43@bernat.ch>
 <fa8e2b04-5ddf-4121-be34-c57690f06c63@gmail.com> <ZbZJ-IS20fe8wmQv@shredder>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZbZJ-IS20fe8wmQv@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/24 5:35 AM, Ido Schimmel wrote:
> On Fri, Jan 26, 2024 at 10:17:36AM -0700, David Ahern wrote:
>> On 1/25/24 11:28 PM, Vincent Bernat wrote:
>>> Honestly, I have a hard time finding a real downside. The day we need to
>>> specify both a value and a policy, it will still be time to introduce a
>>> new keyword. For now, it seems better to be consistent with the other
>>> protocols and with the other keywords (ttl, for example) using the same
>>> approach.
>>
>> ok. let's move forward without the new keyword with the understanding it
>> is not perfect, but at least consistent across commands should a problem
>> arise. Consistency allows simpler workarounds.
> 
> I find it weird that the argument for the current approach is
> consistency when the commands are already inconsistent:

I am 5+ years removed from working with tunneling protocols on a regular
basis, and the brain cells holding the details and nuances of vxlan,
geneve, etc command lines have long since been recycled. My attempt here
is to build a consensus on how to move forward by offering some guiding
principles - like the kernel API puts absolutely no constraint on
iproute2 command line syntax and that a package like iproute2 should be
consistent across commands.

This is open source and is best served by voices chiming in with
detailed perspectives. Lacking a decisive reason to choose one option
over another, I will err on the side of consistency. Dealing with subtle
differences in command lines is a real pain to users and it is a shame
that what exists is so radically different.

