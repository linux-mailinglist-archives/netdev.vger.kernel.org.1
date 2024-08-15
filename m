Return-Path: <netdev+bounces-121306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA4E95CAA2
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E531F23465
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C808A28EA;
	Fri, 23 Aug 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htjR725T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8413AD33
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409634; cv=none; b=M0d/ZTuZxGJjqiBEInOxYxImtaBpvNNl0RpWRb5AuIHJdbVN1JpJG3FFLn6P5F0P4356Usw1Uhozog/Pe8uufGQbOKETaQHOh8+/8Ujj6RpadSUNowpL8zBWeTuvKu//aKQh5idhmzv6CyD5/DLRmYNbZt2Lmkk5FCqQUEgPD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409634; c=relaxed/simple;
	bh=fTZR+4M7daE2PyFo26QUaS2yo2FJ2Ilu8BEnXfP3vWU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Joo+wWbzbbNewnT8xopWJuBn3kVzRU9em2lcmldAYjv35InMs7BuT8NPApZjGsTwzoArwtqSOUdqdd8PYBS0XNnNWxc2mEI9Yma1Rs/sHEIRV1Lt9DiBUUCjR5R61JbtiUHN+bw1iUhobAnneY8e6LIwCs0ww2fMTZVg+xwRoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htjR725T; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a80eab3945eso206902766b.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724409631; x=1725014431; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=usyME+T9kXyAcjztCNwhiRSJMfuQDw8mTZWGoNY2OXo=;
        b=htjR725ThcrzYo8u4I1t3mZ2Y9kM8AGWWdNp+vBApnFIy05qAacXMdeLbFWnG9KRnQ
         j808EN+jO+x/DyggCqwfOOTFvU0ldOzknH1SDY5BwZgBIN2PfAhOEfessc72lv9WCo21
         f6fibOsW26slH5dqJ9Rj+Hsh5XmBK4mxUWukSfNkwTJZJQoBSb29s7R5QQJBx12JkRkE
         HYYMGpXG00xdburcXTou3NiJFibNrlzVhGuD0gGc9FUmF16OmB63brNnVqaZRXKKmWyr
         8xEXaclrONAz9eic2JI/ZxVycuURMWQqaV5PuAjbGQsjsY9t0LvCzf4KszRsTthjIYSZ
         VXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724409631; x=1725014431;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usyME+T9kXyAcjztCNwhiRSJMfuQDw8mTZWGoNY2OXo=;
        b=NxHuGq/teTtb/tVmok1v02b7jPVx+O89smiFJYC150wEe1+T4wk4rE1Ie6KbmFmXFg
         C6BY+bXEWH/87UBy9orCocbqveS68wAQbRI/wxl7jHWT6G1vHke96FKVoTv0+Gy2KeNl
         vz0TbW1IVMszKwAABtbPabO0K8I3L+X2mKfx8cHFopsfPzkaVL5GXP6J3JFwO6XUtHm8
         7NnPIbwr3jRpPr+tweJW3rMo0ZQPhJktNT+gPD+Xr3QDvrbXwCwjc27kZBqIoiGbljZ+
         azI9DwRu5+8HrB4YM7o6Tuh+Qdpi22tbOd1LTlrtPE0FHjMFOHNgRCCkEr58njTwsK5a
         Tp/g==
X-Forwarded-Encrypted: i=1; AJvYcCU6JqKVhA/GQDvvsZDqjDIXe0TrdncEQaXIw1IKumSVtRbw3Ndzm2bLv7aqONOv0CINHAdPe5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YziwRlMhUWua1omn6m7QDsn9chx9lZPDypSfauzYNhQkrDZsdEg
	3frI9r+b1hxi4r134GYbWIRNKYdgcUZMaPKvHb1fgyVhuB0vq1lKKmL4sQ==
X-Google-Smtp-Source: AGHT+IGI789caT2bBhGefqefh+gafD665J1Dj6zV7fIeiOb9dpMYZ8VpDSyZPNKQDe+2LaLUCAcHVA==
X-Received: by 2002:a17:907:e249:b0:a86:9487:f1d2 with SMTP id a640c23a62f3a-a86a52c65d0mr114811666b.40.1724409630832;
        Fri, 23 Aug 2024 03:40:30 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2159:e77a:3088:8b3a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f5085absm238872466b.224.2024.08.23.03.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:40:29 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  Jiri Pirko <jiri@resnulli.us>,
  netdev@vger.kernel.org,  Madhu Chittim <madhu.chittim@intel.com>,
  Sridhar Samudrala <sridhar.samudrala@intel.com>,  Simon Horman
 <horms@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,  Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
In-Reply-To: <638cd906-e3b4-4236-9c33-79413f030a4c@redhat.com> (Paolo Abeni's
	message of "Wed, 14 Aug 2024 16:21:52 +0200")
Date: Thu, 15 Aug 2024 10:07:48 +0100
Message-ID: <m2ttfmjgrf.fsf@gmail.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	<ZquJWp8GxSCmuipW@nanopsycho.orion>
	<8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
	<Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
	<74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
	<ZrHLj0e4_FaNjzPL@nanopsycho.orion>
	<f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
	<20240812082544.277b594d@kernel.org> <m2ed6sl52j.fsf@gmail.com>
	<638cd906-e3b4-4236-9c33-79413f030a4c@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paolo Abeni <pabeni@redhat.com> writes:

> On 8/13/24 19:12, Donald Hunter wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> 
>>> On Mon, 12 Aug 2024 16:58:33 +0200 Paolo Abeni wrote:
>>>>> It's a tree, so perhaps just stick with tree terminology, everyone is
>>>>> used to that. Makes sense? One way or another, this needs to be
>>>>> properly described in docs, all terminology. That would make things more
>>>>> clear, I believe.
>>>>
>>>> @Jakub, would you be ok with:
>>>>
>>>> 'inputs' ->  'leaves'
>>>> 'output' -> 'node'
>>>> ?
>>>
>>> I think the confusion is primarily about th parent / child.
>>> input and output should be very clear, IMO.
>> input / output seems the most intuitive of the different terms that have
>> been suggested.
>
> Since a sort of agreement was reached about using root / leaf instead, and (quoting someone
> smarter then me) a good compromise makes every party equally unhappy, would you consider such
> other option?

Sure, if that is the general consensus. Though I do find it confusing
because there are not any tree-like ops. Does that mean you are shifting
away from using 'inputs' and 'output' for the group op?

