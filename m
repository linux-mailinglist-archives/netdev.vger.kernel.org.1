Return-Path: <netdev+bounces-75998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AE086BE9B
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 02:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF08E1C231C5
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF330364AC;
	Thu, 29 Feb 2024 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="ZkdWAzyI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616736124
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171745; cv=none; b=Za1nuYFdESZatfOE8yWnuYXne+bSKyDrVLHc2iEcuyvhnKmiNTM1L224fqbyYdYyA1zT2JjOAFxO1SS2XBk0QG8ym4SebQoIeoCW1eCDidGjxVPgjm0t10mA0utm8DSpRKGFPD+LWPlgpGNJ2fpCYFRJfo77e0b6LzCh4A7zmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171745; c=relaxed/simple;
	bh=0FKuZF+/77UvZJj7Dp1T/f7NHzts2GeP2TB5tPoHcEM=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=bv+ldLO11txugGNtcZG/dBVfACGImld6ISAnxJa+yq33cxuPq+jzba6iNs/PGgiiPtbwTpqM6RM1U2n29UxjgVLT3sbg7uqLhue++5Fc2+yNFi1XXOhgL3U3HXH+ZF9p5PFnPDpjBEWAOAIzoC8StfetvaL8NxegtgnyRREToY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=ZkdWAzyI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcd6a3da83so2216245ad.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 17:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709171743; x=1709776543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmZRYNFXLdB3MKaMf6C9tFz3DUlJN/FztTh6G+qTvXk=;
        b=ZkdWAzyItg8Kbf6Iv3/muYd7RCPofvAAcMoawj1R9DSg78lVpwC50ZHjjEq/JRlhy5
         TSl+mJDB0p06l9I7iZ4fPqCkon4s+zvLEJUy7WWUIVAmFzdGynXuM629yQrL7uXoq6zJ
         jo8Gz8+pA9iKKN4NeUgaCQdQ1Ws0QvrL4Ha80ASHH44u51IHUyQrjHUTdP7ABVYVxjT+
         T8IGLliML5wIjGZFW4SAsKqmcp1Pt9uBAAJCaexIbg+fDCJMeTESgMyfDzOv6PE1u50I
         eR3ZsI0Zdfmy+ONhcx5kEUIpu7LOMDbqzE/+NmqXk2MSCjMhjR5qDJ1RVZSfxds1+qWP
         18Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709171743; x=1709776543;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmZRYNFXLdB3MKaMf6C9tFz3DUlJN/FztTh6G+qTvXk=;
        b=vztvSMgmnB/PNw2UCKrqg6HqQ9h2XmIZDcxSv+Qsw7NqWCKN5QjQREHj6TnmKTSwFC
         hwPt+PQDSAYGk6K5KB0lb47kubBzEQRVV7/Dq2aPp9INOaM9i0jJSsjv6z//BLeEH+8W
         DqevgFo4+cKX5C9yAaaeDvsydhQJV35nI4bJwnQPy9XL0kvtwR8aurGQLoDIEHtI1d6b
         q01bB0uh08A0QIRafkSEvhhkwVayO++IA0eFGIbwo+X/v3106YIW8NJydD7rn7u6uXfT
         d6vYel1NIlR6mHTYEyKPz30Von/02PGHGa9DBf7ipjiDjGgL6+0cGB1Jxzo/Mn4sRcF4
         2v7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3NvRb2dTfkYv8UBKjkIPx68W/HuvWYnDp/rF0cd7onzwUg5HnV10l5pJDRytuVNDOgYQuVQ8aBl1b6iEWzxmGDsKMdoQ1
X-Gm-Message-State: AOJu0YyglZ9rL27x3bqM5YO9ihKEiG2rrJ5sXkS5LGMnj1cBwUBw4LF/
	xtyNIvmGcqDOPAiAeXioPDpjnbVN90+ZA/YN2u28AGzvAsK5nynDL/Wx9Us5rlM=
X-Google-Smtp-Source: AGHT+IEmnsU3kp+yYe1Yihv9VCe8npCOzmNk5mfnEqfwRyUxQTafz5aYSz9k52ESxS1jdQxPRDGK0w==
X-Received: by 2002:a17:902:da8e:b0:1dc:d4f9:fd16 with SMTP id j14-20020a170902da8e00b001dcd4f9fd16mr1090967plx.10.1709171742967;
        Wed, 28 Feb 2024 17:55:42 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b001dcc158df20sm124729plf.97.2024.02.28.17.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:55:42 -0800 (PST)
Date: Wed, 28 Feb 2024 17:55:42 -0800 (PST)
X-Google-Original-Date: Wed, 28 Feb 2024 17:55:19 PST (-0800)
Subject:     Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
In-Reply-To: <20240228175158.04c0aa1b@kernel.org>
CC: akpm@linux-foundation.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, erhard_f@mailbox.org,
  christophe.leroy@csgroup.eu, davem@davemloft.net
From: Palmer Dabbelt <palmer@dabbelt.com>
To: kuba@kernel.org
Message-ID: <mhng-27f419e8-9551-4a63-a74a-cede3f9d2614@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 28 Feb 2024 17:51:58 PST (-0800), kuba@kernel.org wrote:
> On Tue, 27 Feb 2024 10:06:41 +0100 Paolo Abeni wrote:
>> On Sat, 2024-02-24 at 07:44 +0000, Christophe Leroy wrote:
>> > Hi,
>> > 
>> > Le 23/02/2024 à 11:41, Christophe Leroy a écrit :  
>> > > Commit b38460bc463c ("kunit: Fix checksum tests on big endian CPUs")
>> > > fixed endianness issues with kunit checksum tests, but then
>> > > commit 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and
>> > > ip_fast_csum") introduced new issues on big endian CPUs. Those issues
>> > > are once again reflected by the warnings reported by sparse.
>> > > 
>> > > So, fix them with the same approach, perform proper conversion in
>> > > order to support both little and big endian CPUs. Once the conversions
>> > > are properly done and the right types used, the sparse warnings are
>> > > cleared as well.
>> > > 
>> > > Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> > > Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
>> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>  
>> > 
>> > netdev checkpatch complains about "1 blamed authors not CCed: 
>> > palmer@rivosinc.com; 1 maintainers not CCed: palmer@rivosinc.com "
>> > 
>> > Palmer was copied but as Palmer Dabbelt <palmer@dabbelt.com>. Hope it is 
>> > not a show stopper.  
>> 
>> No, it's not.
>> 
>> Acked-by: Paolo Abeni <pabeni@redhat.com>
>> 
>> I *think* this, despite the subject prefix, should go via Andrew's tree
>> to avoid conflicts.
>> 
>> @Andrew does the above fits you?
>
> I don't see this in linux-next, so unless told otherwise I'll merge it
> and ship to Linus tomorrow.

Sorry, I thought I'd Ack'd this at some point -- I might have just 
gotten lost, though, as IIRC there were a few of these floating around.

I'm fine with anyone taking it, so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!

