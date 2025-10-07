Return-Path: <netdev+bounces-228071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B13BC0C58
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 10:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5997A4E33B8
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A000121B9D2;
	Tue,  7 Oct 2025 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOc9IjYS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0C230BCC
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826830; cv=none; b=WuxvinsmDuqaUGcIkOVI/brm5Zfmurp2fqWqP/lSSmB8hXhltzSxSa19gC0jK0dMN+hPMdL6KbH0Z9/jkthQYKHxtDvxbswOhZH8TIy8wbXPXxYIEBehf8Mo4yZFHOWfdaDJLxD9+gb+C/8WJTm39FXevvgEXi6GGiKX31j+O8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826830; c=relaxed/simple;
	bh=rm+bKLovVtUaqFIYZA7goACgyL+LzuY61ao1WTueUFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqZtgRIuUwWFKnGbj8f9pI6c+8caUmMqRfDagVINYuv6Ztw2MllRPLEndSu8Gi2xkfQV8JuAjkKwCdiTEbXYiAP3mms1AkKCGEdGpJcVtZlSgkufEimhUNM7qVrwKVRwVIM295cgogyF/GdFbgBZEXwztXgECpPlTAVtH8cBQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOc9IjYS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e9d633b78so890837266b.1
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826826; x=1760431626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WB2grswrUvHVm6dDCjSHe44Kq5peu1fx6ZOaRQMhfes=;
        b=kOc9IjYSdbgeAZ22QObJRaZJxFNcOeOjkdtYtIBpNJZ1fKijvWKGtVCHLUgUO/3Aoz
         d29RzVsqffoX0za1bFqieW8+4d3YURzxpUt8qCbR+H3uD3ZPupmiePTDfqBqTmeLQ3F1
         R/L0NQrBstPb2x+8Y/Zt6xeBgxXo9kCKIUMqX0Bv8eqIem9niw1bvd5o7QeV2iI62B5k
         otdq8Z6mckkfd4OnWowedmuQifLqX3Kbl20zeIWGsy4IeQ0K7JGR8Cwd/6F5HSf0LqXp
         Th5qGL4tvBNG2xdbeTeh4eIAGW1PLASeWyGnWNzvDOOU9ewmjnBAy+8riFG/2IfY2tNc
         9htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826826; x=1760431626;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WB2grswrUvHVm6dDCjSHe44Kq5peu1fx6ZOaRQMhfes=;
        b=N6aLPgaqeCTdk9kboy0fqgOwyHpdqKc30OlCJyTMZVI9QttpK+1865RrZsWraQmWRq
         CuVNBkFBD/4x7nDbFZmX8e/A1RQzjSODWXQosmqdLZAySREfK7GjcrArteAkgynJx9Dt
         XAEEwiIfPyJJqIGOtTWwzW0ez6rdjQaiWFwulIAMILsusv6Ap2zTmlZGvFvihMiNmvaI
         fHVxeH1toSlc+k3eI0v+KEWgHv2yj1PVTV/0xAYTcWOxbTy1ssUtYcyfGloSGZDuMIVd
         o34+1AjHNzLFJMb/61mjEetf4wYQ5AS2WzrJ6O7hXvPj2RAWjL7AYfW29Ksj9NSqhrop
         qADA==
X-Forwarded-Encrypted: i=1; AJvYcCXO7PBC0ay0hQ7QtE0j9Y141mCi3jLMU/kKwIq8aAdBwjd0pVF/cgYnYOzhB9Njdd8UJceOVmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKW0LBqHjz3jKMiSfbUzilSL1TFLfez2I637AGbF+NhjsQ0lJC
	I6gGGn6z3762kwohzvb1Kaao4hzLD8kZw0mZfPu8sCS9c6wOlpLqVvtw
X-Gm-Gg: ASbGncsolDf3Trr8RJennWiY533e9I7riDn8yxOYxNg3xDJHmBFuuGNl3rKFbbcO5cV
	RV43J82/oXdExXNXIlAl0mGyeK4/7hE//QSSzNUYcgEs5UAkpGlxdi9+FycwzRtDfmILkkc99eM
	BL+NK0u/78L1W1LLYz7wSaTZWti42iKOEPNgPhsd8R8dy0QRu/gqS2ViJDZ81LTgOt8NQBpqto8
	fhQnEO6Z7/6Q96axmVEeZTa/3UlYBXMrCqKWiXxWofIkAGVAap5XM8Ooc0xA1xFfRk/CQ+7FQbp
	MblanbHXZAkE7CXNoPqDvesMJmlAoxhnKMyPR+uum2Fa7LqES1nyWxvp4AcKMY3SqEvyMwrrjf3
	t9NFAMlS34hQFsBtg+89zewl26TzMr8JE3QECTB1AWAmZhDQA5xiM2ah29mLj5zN4D8+WGZuIfa
	YH6dDUT959g8sNAHDsvHD/s+CfRVtG7dbOwnAWPtQsp/TRl2o3McLejnwOZEDKKj8GbkquyeSIy
	ZL4mjb7YC5ehYeC5UEmDooe
X-Google-Smtp-Source: AGHT+IF7h6k8lPFDkNeA/iUAYR/ai7IDjOraNrySsDbHdhxC28f4NjLFCx3wh4KD7aln3iNwlTiNWw==
X-Received: by 2002:a17:906:2689:b0:b4f:f1b9:b02e with SMTP id a640c23a62f3a-b4ff1b9e0e5mr116537266b.31.1759826825706;
        Tue, 07 Oct 2025 01:47:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa040sm1327470266b.20.2025.10.07.01.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 01:47:05 -0700 (PDT)
Message-ID: <346ffcf3-cf42-4227-96c5-84d37837c09f@gmail.com>
Date: Tue, 7 Oct 2025 10:47:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 nf-next 0/2] flow offload teardown when layer 2 roaming
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
References: <20250925182623.114045-1-ericwouds@gmail.com>
 <aN4uKod5GFKry2yL@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aN4uKod5GFKry2yL@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/2/25 9:47 AM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> This patch-set can be reviewed separately from my submissions concerning
>> the bridge-fastpath.
>>
>> In case of a bridge in the forward-fastpath or bridge-fastpath the fdb is
>> used to create the tuple. In case of roaming at layer 2 level, for example
>> 802.11r, the destination device is changed in the fdb.
>                ~~~~~~~~~~~~~~~~~~
> 
> destination device == output port to use for xmit?
> 

Indeed. It is the bridge-port that is being changed for the same
combination of vid and address. In the tuple it is the output port for xmit.

>> The destination
>> device of a direct transmitting tuple is no longer valid and traffic is
>> send to the wrong destination. Also the hardware offloaded fastpath is not
>> valid anymore.
> 
> Can you outline/summarize the existing behaviour for sw bridge, without
> flowtable offload being in the mix here?
> 
> What is the existing behaviour without flowtable but bridge hw offload in place?
> What mechanism corrects the output port in these cases?
> 

What is comes down to is br_fdb_update(), when an existing fdb entry is
found for the vid/address combination. When it appears on a different
bridge port then stored in the fdb entry, the fdb entry is modified.

Also br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH) is called so that
drivers can remove bridge hw offload. This is what I also want to listen
for, as it is the only message that holds to old bridge-port.

Listening in particular when it is called from br_fdb_update(), but it
can be debated if we should respond to all of these calls, or only when
called from br_fdb_update(). If we want to narrow it down, may need to
add an "updating" flag to:

struct switchdev_notifier_fdb_info {
	struct switchdev_notifier_info info; /* must be first */
	const unsigned char *addr;
	u16 vid;
	u8 added_by_user:1,
	   is_local:1,
	   locked:1,
	   offloaded:1;
+	   updating:1;
};

Or something similar.

>> This flowentry needs to be torn down asap.
> 
>> Changes in v4:
>> - Removed patch "don't follow fastpath when marked teardown".
>> - Use a work queue to process the event.
> 
> Full walk of flowtable is expensive, how many events
> are expected to be generated?
> 
> Having a few thousands of fdb updates trigger one flowtable
> walk each seems like a non-starter?

Indeed, this would be an argument to narrow it down. Fully walking
through the flowtable, only when an fdb entry's bridge-port is being
updated.


