Return-Path: <netdev+bounces-219167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2767CB4020F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535A65E48FF
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1122DCBF3;
	Tue,  2 Sep 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzJWVy2g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713712DC34E
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818196; cv=none; b=IcIk+wQwLMLxrBDpt1GG4BsJbh4JA0P7W6HtXrwritqKWpxI8/fcE9QnVLfHFI4FfqkHbnwSephQNQ8HYcyWub1pZuKsfDajFq0QE5KMCTvMZKPBTbKIdPZ2KNgdOSgM5diNg9lt7OZ4OKS7+CGOfDq2Gl1/pQn0s5gICbIV4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818196; c=relaxed/simple;
	bh=uIQOOOowz4CN1rhTTJCbXQVsq6MAI3mbDvWnQhC9OPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hnk2SgGprXL/jsRiqhWCgs/PVqDB3i/KXrwo3rsR9QP1Nl298ix9bZ7ly6WUeaxYQx3dTXtGi4VHTrBdXo1WV4Ef0/g64G61R12PiawKD1tohUMxPrgC+jD9KUhdeMbLcFNCceV2AV45C44wY3B5/Ypp5sb3I7b4hKy+LEp7cQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzJWVy2g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756818192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqKOZ77CDWS20D6kmfLQTPPlNJdRjsyD/W9G47iuzwE=;
	b=RzJWVy2gx/B/GazSnXeKViJEJ8XNviGkK8v9HLATyJFX/bGySaBy+LtugH2z6PIaQCorsg
	QtqolTAe3vKl0F1Tjd2HNqSphK768B66KvL47uS9A+iojQD0iSrOBFSLEk3QPJ/zMCuvXM
	tTwaYNPyVgv/mqedUyAXILJXrkkjD74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-WrGrnI0mOH2vXHNZnf0hyA-1; Tue, 02 Sep 2025 09:03:07 -0400
X-MC-Unique: WrGrnI0mOH2vXHNZnf0hyA-1
X-Mimecast-MFC-AGG-ID: WrGrnI0mOH2vXHNZnf0hyA_1756818186
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3cd08f3dfb3so1753205f8f.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 06:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818186; x=1757422986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqKOZ77CDWS20D6kmfLQTPPlNJdRjsyD/W9G47iuzwE=;
        b=ZG/5Am8C3TiHGrr55llNfOsU7Rijy5OgsEctT/ckrMKk+l35ny6+rhPPmsC+XosSEd
         e1nQwANajXd5FqkE+JEi1RDHbPDsmXrCiDS8QJbS4fLO2t8gqKC3mjvtIoF+HTHC/P/+
         LZZTAi8fTQGd/ImpE9oHONotL8Ml1tGqD7FK2NnDQ21tejoYO2hNGrMQ58K4SGb8J0AO
         3gfRmpYpsWjv1izuC3EFyHqtogX7QruSvsk9nylY9NaUJq23MIV6YmznbukBYID4UtGC
         ltF00CxMKNBfMpjQHneuhYfhW2JMtEcjQpK4UHgFCm+vl2nqm7NAAWVudIUTcGTjKQ6t
         2XwA==
X-Forwarded-Encrypted: i=1; AJvYcCXuCIj1czA91IMZD6vcSeqWppp5DURPYukN7BoE/hb5CaL46x1B2fnBY/bmzPYkysNeFcOGS8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0BTNXSaJl6zFTJlauiR6P6luen38yDYvigJncF8BFHpLTUDb0
	Y/4ef+wv3yUItPrHFgaviFwrpo+7AS18Q5fBsycVR5HcO78WlR+YfKl8eyIuAofMQCpjdfzXYnt
	k1NWCj8ep+MkpG5MtpGG9ax4IcOhW5avJurpFb84Am+u/lr7z7ug6o+DTBQ==
X-Gm-Gg: ASbGncsUxLNofd1NNH6Swq/Du3tjBDfs+zEX7B9Fb+dAezHeGwzlpZblQoMgKLOGJyK
	qrsJkGzgl4iLME4MTHUXwNUH0UYyRZ/rdZoL81O6KFn1/og3FY+ANtQpbk2fo0WLGq8L56DdEi5
	ExYDaLlz795wdCpstZz5UuJwqHlDn0FNsOkS/cV9q4TXHjoKZF9uhRsSoZE/c/pBuIeE+Hhlo1p
	CGJP/Q6K+f4xLOoBoxlXyoOkYZmJZ4kbaU1rvtK6G5J4nl5qhV99IWrRte44mS0XleMcL2XwZXD
	NpAYnCzExk+xjcBhAzG/vprEVZYh0TBvfa8dWFNKe1Pd6eCwZ+L1o/g5AyvrAehfPAhCNa88RUb
	EYpEVQlzd6jM=
X-Received: by 2002:a05:6000:1788:b0:3d9:70cc:6dd2 with SMTP id ffacd0b85a97d-3d970cc6fe7mr2689089f8f.40.1756818185703;
        Tue, 02 Sep 2025 06:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0SOySbfKyKJPc+bfs6kR2/ZvH7s2l/8gDpjVSDxCI98orw6qI9d9Ef04CuWtGtZyJJaoVdw==
X-Received: by 2002:a05:6000:1788:b0:3d9:70cc:6dd2 with SMTP id ffacd0b85a97d-3d970cc6fe7mr2689045f8f.40.1756818184939;
        Tue, 02 Sep 2025 06:03:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d66b013b7dsm8838574f8f.28.2025.09.02.06.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 06:03:04 -0700 (PDT)
Message-ID: <e7665da6-5aa3-401f-ba1f-b2905f9821b5@redhat.com>
Date: Tue, 2 Sep 2025 15:03:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] netfilter: nf_tables: Introduce
 NFTA_DEVICE_PREFIX
To: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netfilter-devel@vger.kernel.org
References: <20250901080843.1468-1-fw@strlen.de>
 <20250901080843.1468-6-fw@strlen.de> <20250901134602.53aaef6b@kernel.org>
 <aLYMWajRCGWVxAHk@calendula> <aLY0hh8aBWJpluMI@strlen.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aLY0hh8aBWJpluMI@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 2:04 AM, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>> On Mon, Sep 01, 2025 at 01:46:02PM -0700, Jakub Kicinski wrote:
>>> Why is this not targeting net? The sooner we adjust the uAPI the better.
> 
> I considered it a new feature rather than a bug fix:
> 
> Userspace can't rely on the existing api because kernels before
> 6.16 don't special-case the names provided, and nftables doesn't
> make use of the 6.16 "accident" (the attempt to re-use the existing
> device name attribute for this).
> 
> The corresponding userspace changes (v4 uses the new attribute)
> haven't been merged yet.
> 
> But sure, getting rid of the "accident" faster makes sense,
> thanks for suggesting this.
> 
>> I think there were doubts that was possible at this stage.
>> But I agree, it is a bit late but better fix it there.
> 
> Alright, I'll send a new nf-next PR with this one dropped in a few hours
> and a separate nf.git PR with this patch included.

I agree that this latter option is preferable.

Thanks,

Paolo


