Return-Path: <netdev+bounces-247107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDECF4B0E
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0513A30B6B5F
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFAC32BF22;
	Mon,  5 Jan 2026 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6oFEnlZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A4C231845
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629112; cv=none; b=dAQsTXXPpxfYPFr7rHPYsrNhMxbYfAaoLPz/ipPD7NwZ88AyH72UmxuaYWLq7O0yiDAXYvQYZGH0P+gmkq0d5YGuyJEA9qgMD5qZBAY27H5B/XtEkUhgiOAhUDQkkTFojJS5ZM8RDsCrTBOu9nVP9iXgYbqG2Uzeiui7ZgZi3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629112; c=relaxed/simple;
	bh=OvV1Sv0/ykXDeetgzIzEs1LX6j1noqEFgD4n9YnUn4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmCHklb74s44IWEfS4OIOGSkh68l4UrtHDFozvh1YKZNVtIcFS0d1WI9AhBA/UGfh6jerAlTYkXO/qJce1rpzeytbWxVzY/ecNuLf55X5sNUVSBj5PQ1BgHozXf1r3LNGVceMkE8Imn+1A4XJMpmbTOAV/n8xdk3ceei6RchENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6oFEnlZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79028cb7f92so1045477b3.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767629102; x=1768233902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M84IjyY1kCiZUs3R1uSAC8/ZkpRcc9te4IoZICHe4xk=;
        b=b6oFEnlZUe6bofKOJ7e/E8HTrYYeLHB8pWINnXKlrwz30mV5aRk2+KKfz2GL59MGZh
         74vcPYewh3FNNV5MUUR6V54MXs1MfP/ru/7qMgFe+8xKhZCszDULvQ5OyJClqveVmVH9
         qp1nXxr8FSX+hFHo0UjIhixU7+qt3O554XVbIEkkpv2KuQaawKof6LVYt3zhhGuueC3n
         684CPZDL+BG2A+Fcmvle0ISpgsfKFt0wGRwqXgjEL1692VV9E6XTzNLRslSRQgHcqh+X
         rNxJQbenkump+Ux6iTMe6HDI6FDU4Uqgz5hUCO0XCe1lkzuDDABQ6b8RZargGee+Qrza
         Tl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767629102; x=1768233902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M84IjyY1kCiZUs3R1uSAC8/ZkpRcc9te4IoZICHe4xk=;
        b=n8imz7DIJ4VQ820joZgR/wkJCAVHq7QWOqvxv67tAsmx+Qvtt0cfB/iZhvVnJcfdSM
         f1hgqvUEn2yD1j5FDbwrdFJV5JWZQ+BXJhvT29nNUAYjtGKZQctG/JRqRWcwFpQrsaeV
         OiYRjXx+yyiTxxQIWfO+45uJumLud0HD6F0llAULcvHcCwAfb+UwgiOt1crKsezS/C0f
         POcO95R7MElOl+eXDJDN4+FJsSgjGDUynPtST+CiuyBMcpEnoMKBn61P+fgvsuYQV+SC
         GzfACktYTn2sIa3HdCemMDTHB3T8nm2YCOiRbw+EQ7RTGs1dOyWGYuIwJd+z6MVK/3Qc
         6l3A==
X-Forwarded-Encrypted: i=1; AJvYcCVf/OAQdhyee3oW2JxFmvJ7r2weFpXrTC1MCI49p0YOavGdcTpOeT0HnejqgueCgxhtmadYEK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzasbUn5zcsfZmFw192isiAI1pM3wNaOAVYgQr65yDJRJjF6mLW
	sNuope5qPappcwaSq1FMN2dbOe8yMKGMrdfkNnxTfDsHjmEkhfO9+S1o
X-Gm-Gg: AY/fxX4YNAZHqxLmigFh7YX11DU5koXE9iLJcKCU3ujTc4sZHua08C1B4NfdMQOfhQ2
	n6w4/rtCBZjj7t3bkYdNpa9d5uKKmfyfHFgoXl1MDDgNSuknyUCVopdOR7lxfMwPmwmNww4b4CV
	CNeLISU2ReANAnDihJUUWEdHVhi81CJFRNgmGXR/1wqSLPyQ6GvbM2r2OfvnIl+EMWTYyye6boG
	Yy9BmulfWQTAnm0TZoeNQjBGsix4Z/Y8P1zK9NMs3TbNZYM4G0UOHWuTX/hUu4OuPP3XCZARR8i
	FquaaRiCNi2gum5uQRtYWV1Da85dMRq3tmqWZbfSMufZC7iLLvc6nuk2/u76zmEv/SZwy4MZL8c
	8AtacD2bvbzlXtAHYl5M8tC8DXgUlEoejwjNFlf9Yy2Vc0cibdZl/8YcJWxFQe+88XhlfycS106
	TaXDGl5MYlnt/Q50dvlax5m41PA+hpm4rMdh6v6tram4pRnA+FzRpWxHN9F4iMdPAv4yFHIffo5
	6uKOoqB
X-Google-Smtp-Source: AGHT+IHFkS4y+TVFiwxQd2cB8nQ+oqPnSWL+FzNMasXg8+ydm8LesgOvRSMxqGR4s5SeeB2ofha1uA==
X-Received: by 2002:a05:690c:338f:b0:78f:aa6d:48cf with SMTP id 00721157ae682-790a8b18b82mr227287b3.52.1767629101825;
        Mon, 05 Jan 2026 08:05:01 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790a87f3057sm352577b3.22.2026.01.05.08.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 08:05:01 -0800 (PST)
Message-ID: <9845c197-167f-4507-818c-f4e9189823f7@gmail.com>
Date: Mon, 5 Jan 2026 11:04:59 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
 netdev@vger.kernel.org
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
 <aVuaqij9nXhLfAvN@google.com>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <aVuaqij9nXhLfAvN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/5/26 06:04, Günther Noack wrote:
> Hello!
>
> On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
>> On Wed, Dec 31, 2025 at 1:33 PM Justin Suess <utilityemal77@gmail.com> wrote:
>>> Motivation
>>> ---
>>>
>>> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
>>> identifying object from a policy perspective is the path passed to
>>> connect(2). However, this operation currently restricts LSMs that rely
>>> on VFS-based mediation, because the pathname resolved during connect()
>>> is not preserved in a form visible to existing hooks before connection
>>> establishment.
>> Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
>> and security_unix_may_send() ?
> Thanks for bringing it up!
>
> That path is set by the process that acts as the listening side for
> the socket.  The listening and the connecting process might not live
> in the same mount namespace, and in that case, it would not match the
> path which is passed by the client in the struct sockaddr_un.

Agreed. For the unix_sk(other)->path method you described to work, it requires the 

programs to be in the same mount namespace.


Doing it this way would make it impossible for landlock to restrict sockets mounted into a container,

and would be very confusing behavior for users to deal with, which is exactly the kind of stuff landlock avoids.


Does anyone have any thoughts on ignoring SOCK_COREDUMP? I think ignoring it for this check is correct.

>
> For more details, see
> https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
> and
> https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277
>
> Justin: Maybe we could add that reasoning to the cover letter in the
> next version of the patch?
>
> –Günther

Will do. It's about ready to go, I may resend it today if I have time.



