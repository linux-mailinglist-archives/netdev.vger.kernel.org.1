Return-Path: <netdev+bounces-191558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAE3ABC21C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D0F18947E7
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B43284665;
	Mon, 19 May 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJzQt/V4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40A1D7985;
	Mon, 19 May 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667875; cv=none; b=F2J9JP7iGPqjNYSwTGkUZYh1LK615OyZK4JidQv0bsRa5MqkfzPhg2zXSZVsXM7er6/+VSvDksFJ2qOquTWcS/CElFQM42vTRQYJuMRB+VaYbLi0dcQtRVxw4kUElB1NlI2c2KJ4WjC2edJm5vcZyP6OX7OvgaeJLSyZ7k+nYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667875; c=relaxed/simple;
	bh=ZoVXkewos47HPIhHvXovxFx7n3VJ0C2TkEtbEFqnjT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buou6XJNhnP+0XY/KfThnjQ5LXhswfthhIjXvjcTwljBkrlnHrEtoxvX2IDG+qpk9S+YwFpDA8592ickJB/BlAJ5sQFNIa4ND/UCJELMy9ynkYFhYtwTBw1b7nRP6jj6YrQlmSv61jHGj3yF4ZpC1QS1/QF6ROWRLiX0qpq51lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJzQt/V4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad56829fabdso216381966b.1;
        Mon, 19 May 2025 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747667871; x=1748272671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USQzdd2RLHSjVPX+F/15cIYHLu9zsiy+9Ft4sZBZKc0=;
        b=TJzQt/V4oVZhCxZuwVt+b1ng1AHjreqI3ndKG2aekiWdI/1Mituroj9ouw6HIxAcKJ
         igHOoFbzY0UYtVL9u8v5tK9h77gLPgxlxTtjELe+9+fFZ2r4Kb+xw3M1WfyVtr8QywoI
         Eel1pfygGNR40Ng+AsWvm/M3RVz6DvNPM6Qob5UjjgDDq55S5i7NRYHZt0BuTG2WRkW2
         OXX8j85a/j3Ng4VjfHAVLKPt0Vz7ZEefMas1cd8+0uLx+9sQagvuyOBOMfkIqfH4cB/f
         mmwqWe9kaPsZxO9AfLV5b37ohBoVeDHXfleaUxRShbJfx63MLsfltf7H2zMcb9drvY5r
         FccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747667871; x=1748272671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USQzdd2RLHSjVPX+F/15cIYHLu9zsiy+9Ft4sZBZKc0=;
        b=m6xIcumRO/1GjHimHSp9donQ+tgFqrK4YmpGvksYs5uTijFN5Zc11i5ik+2OtziHIQ
         m1Pvk/D1yHS6lBKh181q+S/EeJ36RUT3XmTqzusEj1/TYzObvnLoUW/hywIpQkCdzVrY
         DrakLFGIfUE44Uiv8QJHdT2vVqEymxVEPDs4C+EjTzXsjm++TorXKiCEmz1gfNO56mn7
         vnxRk59NGtNZ8b8m8QjCU0CDnhAsHLea0v+LBgMTUgbLKhHCZRpyxtF9NgEUI0mwgAmx
         thEPiYtPmL8dp0UVlT9+SjgNKx/RhYp6rUGCg0Fz8JsjiYDUWBAChazqw60N+H/bE3qq
         CxSA==
X-Forwarded-Encrypted: i=1; AJvYcCWy7aAsHzjiSL9qMXILi2jxHVWYpQfTOueDGlUgcFsBhyoF+9H2q2mmpo4hiQcVfQuyBHgYhnBQa/KesJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8DoTgI6ABdj/uO/X6H9ltWqVCTvzY49uSHYhmTj6TI/IBQpV1
	dk6QW+98+gHd+AoVTrMAA4YITQuJ16OBvlB33uKp1iS0i7ZiH2NQiYAeSgBGvA==
X-Gm-Gg: ASbGncvueAhHLuHMNa61hw5438F1TrAhJCsbWfRImUjSdFF+drIcw3yExeniRgDGnl7
	FGDCZvMHcjtr/3zgk4cJvnPEFbf7x4O4K3sG0ANfTt7J6yTy6FKUN7/J6YfpORQunxzq8bLyWkU
	qQKe476Fvw0h4Gl0BX3t8fIzZD+TYvKDH8dGmr2U69C/trOlYT71SdgjJ3I6W9QFhvxt4oViX8l
	3TkGfScWrekCubrskdcln0IVVnFYbgPXl3h8vZFCFUspMuTIrlOp/zNEPvvwxIim5YPp/BhUGrk
	JBWjf0cRsE1Q8/ETQGwi5neHUjmmWvnb+wOALxa9fvqoopBGS02gkxk9BsiYaHw=
X-Google-Smtp-Source: AGHT+IFrhmHCr4bmaGaz0DVARsxFzCi34fcUBgSL/NJNwo2BLCXXjnNcispXVauUU6XDSr77L6s56g==
X-Received: by 2002:a17:907:3e08:b0:ac3:3cff:268 with SMTP id a640c23a62f3a-ad52d549e01mr1400004166b.30.1747667871305;
        Mon, 19 May 2025 08:17:51 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::71? ([2620:10d:c092:600::1:9cee])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d48ff8bsm598147866b.124.2025.05.19.08.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 08:17:50 -0700 (PDT)
Message-ID: <0665ead7-56b4-4066-a21e-9a759d9af38f@gmail.com>
Date: Mon, 19 May 2025 16:19:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: devmem: drop iterator type check
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sagi@grimberg.me,
 willemb@google.com, almasrymina@google.com, kaiyuanz@google.com,
 linux-kernel@vger.kernel.org
References: <20250516225441.527020-1-stfomichev@gmail.com>
 <ab1959f9-1b94-4e7f-ba33-12453cb50027@gmail.com> <aCtDMJDtP0DxUBqj@mini-arch>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aCtDMJDtP0DxUBqj@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/25 15:41, Stanislav Fomichev wrote:
> On 05/19, Pavel Begunkov wrote:
>> On 5/16/25 23:54, Stanislav Fomichev wrote:
>>> sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
>>> iovs becomes ITER_IOVEC. Instead of adjusting the check to include
>>> ITER_UBUF, drop the check completely. The callers are guaranteed
>>> to happen from system call side and we don't need to pay runtime
>>> cost to verify it.
>>
>> I asked for this because io_uring can pass bvecs. Only sendzc can
>> pass that with cmsg, so probably you won't be able to hit any
>> real issue, but io_uring needs and soon will have bvec support for
>> normal sends as well. One can argue we should care as it isn't
>> merged yet, but there is something very very wrong if an unrelated
>> and legal io_uring change is able to open a vulnerability in the
>> devmem path.
> 
> Any reason not to filter these out on the io_uring side? Or you'll
> have to interpret sendmsg flags again which is not nice?

Right, io_uring would need to walk cmsg for all sends, which is not
great for layering. And then it's really a devmem quirk that it uses
iterators in a non orthodox way, it'd be awkward to check a random
devmem restriction in io_uring, when otherwise they know nothing
about each other. And it's safer to keep local to devmem, because
try to remember if something changes, and what if there is someone
new passing non-iovec iter + cmsg in the future.

-- 
Pavel Begunkov


