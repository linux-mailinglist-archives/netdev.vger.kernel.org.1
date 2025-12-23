Return-Path: <netdev+bounces-245834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BD2CD8CD3
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0DB5303C809
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0E635BDD7;
	Tue, 23 Dec 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcXR/eLR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqcg7kit"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1D2BEC43
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485675; cv=none; b=BdNOKtYteraBtHVwJT0cshL5AbOlbgvQ06X0/MK23lH9KCq0znpOe1y6eCqgrBbw2U3RyyrFFJfY8omU0FSUYkV9q9naLKrYRwLZVXaBiCxUiFs8lEGadaRm2lgVYiYfQx71z5fI9PMMmXs+kyxKu639ofePUjBvZqKlnt5+/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485675; c=relaxed/simple;
	bh=sCTEwrWLKqtVrl6SpFKxM5QRhYCfIEKH2rZHvlkAm68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mwfgx5y+GhTvc52247IUcZJ/0B9CBXucaUAqCk0vnfSDBXYN0Fc880HpGYLUBxNAC1A9h5C505cWlGm7Jh6SBkQby9s1XVAa4W4Nl9HFufcsmupbanTKgi3A1rTyvnFLMk5UtN37cavIjYTl1TIbX9MoW0JEtRRGMaJp2ni+8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcXR/eLR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqcg7kit; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766485673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gW6Az7Odb7vsxG49M4eWTPA9mVwU0/De6Xv1KzqFvrI=;
	b=LcXR/eLRL64RelzDt1diQcxoegmKMhOGOgbGF6O/gxCIHvA0nK+4BTf3ZdWrQFMZzPZ+L5
	92S29XyTGNlARz1TA6k1YijYmZYF8tnd/KWg+MS8lAuC2Dlq5ULOjL0PcPgjLWQZPaUUMG
	Yrp+hkraZq7bQ5M90yOc+TpaJDRNepk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-8TK0LFFxMKml7wUF6kvSxw-1; Tue, 23 Dec 2025 05:27:50 -0500
X-MC-Unique: 8TK0LFFxMKml7wUF6kvSxw-1
X-Mimecast-MFC-AGG-ID: 8TK0LFFxMKml7wUF6kvSxw_1766485670
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47a97b785bdso35324315e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 02:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766485669; x=1767090469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gW6Az7Odb7vsxG49M4eWTPA9mVwU0/De6Xv1KzqFvrI=;
        b=bqcg7kit4SPNxtT6Shz6e0/2aarOYR9Dx+ymdnT2/dEtFihNB09r9aOiYDH06qDsT7
         TAWMXP+PCc8Z50mOUG0HhcPy3VqttKDFFdbMlf/kf/Urbt1xDVWpFsx5Wg3gr2NIQoBj
         WyYtHJ/iozu1BKXRGoXKeXmhc2CSlefkHghKQ8FPQPV+c0jLnG3/spyiohk676h0pk3y
         J+cesC092ZrsNlR42VQXVppWMjhoBpFs5sna7A2k+A+noNbQkFYcS/CZw2JJa2syOdM6
         kintmu0ow3+8qeyCYmaGe6wnkahhYQpKgGIUqLhjp7dr5w+XsglnunHc9UMU2zRcB0Ae
         mkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485669; x=1767090469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gW6Az7Odb7vsxG49M4eWTPA9mVwU0/De6Xv1KzqFvrI=;
        b=b2zxqobRZuQr6Be+McGvdNuDO7wpn85rdl4F3TaZHwhKqW70vDjoOmL7KWOELwNhhM
         dg9WntU6iZA9Ive0cqCzrobIXM1LUJA9Jqh9C04QBnxlOdBIloMTvLHmFI6j194PeqDo
         cXPT85hIkoHTy66DIAwwRag0mx4HdsLsBcOG6NDgoZW9D3uIz/7HRwtpWgPqX9rFLM0E
         5YkwXu2t0gINaton2/zeUIVqaB25j+ZP9jv13eI8Ou951AmD73Cvzqt6deDIjSXsnP5W
         6NpfpmFkdah+bhDqiJle6soMEG9yr01baHmJa5aeqGfF5n9CTJfDz8lR3CRrd/hJNjNQ
         PMgA==
X-Forwarded-Encrypted: i=1; AJvYcCWXFbOjUknjwbwf1JNEJMCLRJ9i0yrdWF5Bre1lK1tX3bDeEC9Uet+Ok050Uu0iF5WRdEk6KWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykvImkA+WmeqI+06wPtuQ9/P8hx7cQhuIGhvEtFWLFv8rHxf8R
	HhCE967YoCsEsHe1BPuiXfDwfb40SqwHHTCnWDEmBnmRuxdYCMpvaW+Hye9/2K5RiIdVxjW/mAB
	ziIRPT68qu5uMBxgvtWtPPyCkHOzJKQbifLgldx2bMIGDYm6qx7rxQ3Z7aQ==
X-Gm-Gg: AY/fxX55XikRPIDsWFPrUrTuQXNDlAqMsAXX5l9AHkUGPu/OOjZl0zaYwT6NbbvKovM
	/Uc3bITthyZ6H5N5npDJSedOnHP1RZaEZTapgf9N6SRYBEN3IvX52yJDHu622fidAcqoiidzDVU
	Ee/i96zTNstRuUwo48XYDD/9tefZVVwRFYWa6rYhVuXmv1KHZd045FSz/wAPS4HB49j8eEkF21z
	oc5XHVx7CvoT+09AtrSgMc6PFM+yaBLBpNRGkXvuT1Rs5xIJPihV0gb83+4Is7uZO+utjIOTFMI
	Uiq13qYhRyKtVIbNstNw2u5EDZ9ExpMfM3lD2GeBFmTbo0duJh0sQpaGycXb3UgiSEHDEkSVMp/
	Wc+7IYySpLUwL
X-Received: by 2002:a05:600c:350b:b0:477:aed0:f403 with SMTP id 5b1f17b1804b1-47d19549a95mr128307735e9.8.1766485669533;
        Tue, 23 Dec 2025 02:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo2375ubP3NGR4G/066i7ZpeEj+Z0OlHm2MPrvB8YlHkxm/CeEdo9o2skjUY6UCqpZioUlDA==
X-Received: by 2002:a05:600c:350b:b0:477:aed0:f403 with SMTP id 5b1f17b1804b1-47d19549a95mr128307235e9.8.1766485669030;
        Tue, 23 Dec 2025 02:27:49 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830f3sm26613687f8f.22.2025.12.23.02.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:27:48 -0800 (PST)
Message-ID: <a10a9239-ea4b-4a78-a5e6-d38d6ba749a9@redhat.com>
Date: Tue, 23 Dec 2025 11:27:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] finalize removing the page pool members in struct
 page
To: Byungchul Park <byungchul@sk.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com, harry.yoo@oracle.com,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, sfr@canb.auug.org.au,
 dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
References: <20251216030314.29728-1-byungchul@sk.com>
 <776b0429-d5ae-4b00-ba83-e25f6d877c0a@suse.cz>
 <20251218001749.GA15390@system.software.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251218001749.GA15390@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 1:17 AM, Byungchul Park wrote:
> On Wed, Dec 17, 2025 at 02:43:07PM +0100, Vlastimil Babka wrote:
>> On 12/16/25 04:03, Byungchul Park wrote:
>>> Since this patch requires to use newly introduced APIs in net tree, I've
>>> been waiting for those to be ready in mm tree.  Now that mm tree has
>>> been rebased so as to include the APIs, this patch can be merged to mm
>>> tree.
>>>
>>> This patch has been carried out in a separate thread so far for the
>>> reviews [1]:
>>>
>>>  [1] https://lore.kernel.org/all/20251119012709.35895-1-byungchul@sk.com/
>>> ---
>>> Changes from v1:
>>>       1. Drop the finalizing patch removing the pp fields of struct
>>>          page since I found that there is still code accessing a pp
>>>          field via struct page.  I will retry the finalizing patch
>>>          after resolving the issue.
>>
>> Could we just make that necessary change of
>> drivers/net/ethernet/intel/ice/ice_ethtool.c part of this series and do it
>> all at once? We're changing both mm and net anyway.
> 
> Yes.  That's what I think it'd better do.  1/2 can be merged separately
> and Andrew took it.  I'd like to re-post 'ice fix' + 2/2 in a series if
> it's allowed.
> 
>> Also which tree will carry the series? I assume net will want to, as the
> 
> I'm trying to apply changes focused on mm to mm tree, and changes
> focused on net to net tree.  However, yeah, it'd make things simpler if
> I can go with a single series for mm tree.

I *think* that the ice patch should go via the net-next tree (and
ideally via the iwl tree first). Also it looks like both patches could
cause quite a bit of conflicts, as the page pool code and the ice driver
are touched frequently.

Perhaps the easier/cleaner way to handle this is publishing a stable
branch somewhere based on the most recent common ancestor and let both
the mm and the net-next tree pull from it? Other opinions welcome!

Anyway the net-next tree is and will be closed up to Jan 2.

Cheers,

Paolo



