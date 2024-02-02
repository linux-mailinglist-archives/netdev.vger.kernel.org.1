Return-Path: <netdev+bounces-68527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB39847168
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18611C20AEF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23D47774;
	Fri,  2 Feb 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThlNwD6e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474846B9F
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881856; cv=none; b=juYNim2wYi5SWuhMgnahUkUNsbST4Z35W8DNiPd7wXtfy3gDyWNwZRLXU3GZAL/MOJPjqwE6KaPTqjy9kyDdZbMKiyb5GP0zPS9TLfZR8bt5GtwPgrPNKOxWYbUdZ5DEb6pa+bQkFZbQk5N2EXGOan9gSStoE3DhyDdl5LEDQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881856; c=relaxed/simple;
	bh=pzkrCDXIOhY9KT5HvRvV8+hIvjPQd2izpaosmJfcVbw=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWz+uIxtw80ldWQbLXMC4Q6Zcj4YzutOn1axpQ/QsTBI1HLhB92N0HW+HUdqytBYxnNPECapYAicV+zm1vQkJTU+02FzqejbO564mOOhxIJsr08AGCHIjS14dSiqvtrD7S/+vxS6z4nA39wtqAfVoZ5QOeLcnEBYt57dgr7Ju78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThlNwD6e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706881853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BFOPx9Ws2+oZ6oWmPtHYc49NwLYW2wbXPD+2M9R0NqQ=;
	b=ThlNwD6e8qIBwTjT556HMyteT2KtAxa+GuNjtY4MYGqSfrENWYKkODgOSuNkETbGmAh9hc
	j2O5VUOoN98QVudfVpyHF+wi2T24sKuEWliz86NC3PN6HB7lySUDLMlVaMdJIkoJfYreJk
	vZZMOejy/RgTuPn7ve9Pah7by6Ql9Sk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-cj0M6ddlNrWXR02YPG1XVg-1; Fri, 02 Feb 2024 08:50:51 -0500
X-MC-Unique: cj0M6ddlNrWXR02YPG1XVg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-559391de41bso1743625a12.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 05:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706881850; x=1707486650;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFOPx9Ws2+oZ6oWmPtHYc49NwLYW2wbXPD+2M9R0NqQ=;
        b=xAOC2UbvO3HETswSqHzOcWOQF9hjKySyxeuFnxDeobkgn2VDxePPgd0xfqCJQbNnz6
         ZSYeA7XiUmPAlVPqs9Z7z/w6Cuh+x3OVzxjf/ltfaD3QT7DKoHMBLBH7CBT7Kc072mnB
         x0VkGk51tbCixpxIykBOwGYU2nfsxap+wCiZKh/1Y0eYA5+tBZznVeh5XUbOdCbCTTC4
         ZeIOfNb67f0M23t/XQAw1lHJ09xlAmdbp4mb/h3g2YGYrwHeodVLWtYDJdU3hNe3o6Mq
         kQ3HQ+A/gGiYifLx73jDJSwIhouqgxcQYK/2Wa1afrWBLUZePhoDUKGsleO8hddJmaeK
         8eBg==
X-Gm-Message-State: AOJu0YyVPrzEMnbvOGpmfJ//uRjbP7ZsEaFmkUk8Wgk4cZ8zsU0Dg7iY
	bzlvRKfn75FFwbux7JQxdD8xsvjakQHCNaH4tG3ywn/t40yGXUFaQwWRg+R9jbDRlfKN/rYZCbK
	O/5hobqMjDs1k9r7k89QnwoYrNZNTxuXU4lez9wDdFbpS1w9o9Nc3sSI8uBVneqt9UE7LwYnxuV
	mrxiLCq3ujrF2nOgAwzzpgUzoxKkCL
X-Received: by 2002:aa7:c687:0:b0:55f:d892:7470 with SMTP id n7-20020aa7c687000000b0055fd8927470mr2139127edq.32.1706881850720;
        Fri, 02 Feb 2024 05:50:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKdZQnLlZsuPHA/5dLa0X1nmnP/K8o5jq6kF2PxePQlahZbAQlEK4fz4SzKq9tA/FdVxyVJ13exLJ6fyRneWg=
X-Received: by 2002:aa7:c687:0:b0:55f:d892:7470 with SMTP id
 n7-20020aa7c687000000b0055fd8927470mr2139100edq.32.1706881850369; Fri, 02 Feb
 2024 05:50:50 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Feb 2024 05:50:49 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-7-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-7-jhs@mojatatu.com>
Date: Fri, 2 Feb 2024 05:50:48 -0800
Message-ID: <CALnP8Za-uSB3grrk9cay8=6BNty9GcTKdStqzUnCv-spXRhe4A@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 06/15] p4tc: add P4 data types
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:52PM -0500, Jamal Hadi Salim wrote:
> Introduce abstraction that represents P4 data types.
> This also introduces the Kconfig and Makefile which later patches use.
> Numeric types could be little, host or big endian definitions. The abstraction
> also supports defining:
>
> a) bitstrings using P4 annotations that look like "bit<X>" where X
>    is the number of bits defined in a type
>
> b) bitslices such that one can define in P4 as bit<8>[0-3] and
>    bit<16>[4-9]. A 4-bit slice from bits 0-3 and a 6-bit slice from bits
>    4-9 respectively.
>
> c) speacialized types like dev (which stands for a netdev), key, etc
>
> Each type has a bitsize, a name (for debugging purposes), an ID and
> methods/ops. The P4 types will be used by externs, dynamic actions, packet
> headers and other parts of P4TC.
>
> Each type has four ops:
>
> - validate_p4t: Which validates if a given value of a specific type
>   meets valid boundary conditions.
>
> - create_bitops: Which, given a bitsize, bitstart and bitend allocates and
>   returns a mask and a shift value. For example, if we have type
>   bit<8>[3-3] meaning bitstart = 3 and bitend = 3, we'll create a mask
>   which would only give us the fourth bit of a bit8 value, that is, 0x08.
>   Since we are interested in the fourth bit, the bit shift value will be 3.
>   This is also useful if an "irregular" bitsize is used, for example,
>   bit24. In that case bitstart = 0 and bitend = 23. Shift will be 0 and
>   the mask will be 0xFFFFFF00 if the machine is big endian.
>
> - host_read : Which reads the value of a given type and transforms it to
>   host order (if needed)
>
> - host_write : Which writes a provided host order value and transforms it
>   to the type's native order (if needed)
>
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


