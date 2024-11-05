Return-Path: <netdev+bounces-142030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FD49BD1AE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD25B24BA4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8983B1791ED;
	Tue,  5 Nov 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf7/8l7a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148315380B
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822778; cv=none; b=t0zz8RbdgGQE969xYctgMf1x0J6bPMCY8j694RCTDG2viKRbmplG0ePMFIUwO5trCQC6hUKM3MuYH5B3HlT/GtLPlVde++lov6933gST6VuxW74xszOy0LqJMA+PS1FtqbPqRB86k38Pzc2osCZMRTlBusuWxRzAFzFX9vBdhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822778; c=relaxed/simple;
	bh=2Yd25+AzkVFGhjL2YsJvZFz27QCOqGzzjXdhKQillXg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fu9X/u6H5srDolnrQGlNNzjLGgEhAUUmvGbFrH+E0RgU1ihwERG44PNys6MVTXgI8Nxd6bYX4tChvSqYBKubid5FJVfO2+aJn/m/8UMzP6PEroZ9x5P+LvGnEqoewnw9KvoBHDgGS3iwoReo+g7lXD+fFz8iGrf6dVX+Mrw+zFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf7/8l7a; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so50237745e9.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 08:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822775; x=1731427575; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFa62HHOLc47yazK3lP26lvHtNm60ih86PmZv2WPlRw=;
        b=Mf7/8l7a/4pze+Ar07pH4vhda+n38RrfAXXwplQmAJOBYGmHscgnObMPEcGFg13vVY
         oIZlNv6iywTmbP6S1uL3sy9MZcRYlDBP3/SK1YSoRZ34Fh+g0JfEdSxha0NtLGmrzb+O
         MGFFdmjD6o27s3R4aDSW8Fgre0cDnr97qfJqVBoxOVsBiD6rhM3xEDzAX8y7BV2aMsUb
         a48Q+Jjru9ICA7FJ0HwNexZJoiuys2XQ8v3JhLNM4ccmwWFOieubx62VQj6urwTmQ+O6
         B8WOorr7U9SJ/+MDYPxCa32zOEyrz/PTEb//DkKjwI8Z1NFRv+ka12lG+P9JMnLvogeZ
         Y1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822775; x=1731427575;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFa62HHOLc47yazK3lP26lvHtNm60ih86PmZv2WPlRw=;
        b=F0V2KU+nZ/45JTaiw+uEKNXgqeGVA7eT/8d/ykqALuyJCU8134FaKMzoN0eDG2O7wF
         ZefzGVMZGE5jajzu1+3f4EiZf4+1nhvPBbRLsKOXs564/ODWAZXT6Ozr1rpCjIdZybBv
         hKTEn4c5ODrZdK3RbntVVA/uMuSJj6M+jASblHXThdM+cbgxm8ypKPUgg3fA79wzBEPS
         uR5W+zHxHh+J6l8cCx6MTUsBQGAm10SLg2mzTFIyZB+/O8NNBSPla/YsfS/2Iggip7YE
         KzLPT/v0kRiajlsH5VU/zpmYg3gOPNBuZnUme73rr1ULpEf+Hd7R0rlWfK79TlP7VFX8
         Lhkw==
X-Gm-Message-State: AOJu0YyzDIHz24QC406DJHSiGqteW3NE54Agep1Ot7KX0xINV8hdMkdY
	ujEME1w45+CECDdQuuG2xOm44x5zF8+sfnu7un35cVbKSW9i06YJ
X-Google-Smtp-Source: AGHT+IHPzZft5gIMD5zle+LAvprQn063dVKkrEpHnRLLulU/VQxgl6vJOF3x0v0CqNxsK1P7G+j0Ow==
X-Received: by 2002:a05:600c:1f91:b0:426:66a2:b200 with SMTP id 5b1f17b1804b1-4327b6c79f7mr185726285e9.0.1730822774902;
        Tue, 05 Nov 2024 08:06:14 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e89b:101d:ffaa:c8dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5e7c51sm191612105e9.25.2024.11.05.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:06:14 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  donald.hunter@redhat.com,  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 2/2] netlink: specs: Add a spec for FIB rule
 management
In-Reply-To: <ZyotMdGb23YbCBiK@shredder> (Ido Schimmel's message of "Tue, 5
	Nov 2024 16:35:29 +0200")
Date: Tue, 05 Nov 2024 15:28:29 +0000
Message-ID: <m2ldxxvgwy.fsf@gmail.com>
References: <20241105122831.85882-1-donald.hunter@gmail.com>
	<20241105122831.85882-3-donald.hunter@gmail.com>
	<ZyotMdGb23YbCBiK@shredder>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ido Schimmel <idosch@nvidia.com> writes:

> On Tue, Nov 05, 2024 at 12:28:31PM +0000, Donald Hunter wrote:
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> One question below (didn't notice it before)
>
> [...]
>
>> +    -
>> +      name: getrule
>> +      doc: Dump all FIB rules
>> +      attribute-set: fib-rule-attrs
>> +      dump:
>> +        request:
>> +          value: 34
>> +          attributes:
>> +            - nsid
>
> What is the significance of 'nsid' here?

Hmm, looks like a couple of lines I need to remove.

Thanks for catching this!

