Return-Path: <netdev+bounces-94136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF338BE4F2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641891C21CEC
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46DB15ECFF;
	Tue,  7 May 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="uPVxpRcH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34515ECC9
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090234; cv=none; b=hhjtEy7hDaw3sJuUBxLWUfMjhGmkZITn6XBq2GETUQgyjotiYkoHMjRybW2KE3PqQmF/eLq75eTRLC/DJYT8mIAA5VZNRkbFV++Uvu6ipZlGRqNrzw5GVQs4E9uYh29XuynQ7s0OJDQASHG8MzeQtg3lVeoBMPtevly7N+zUQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090234; c=relaxed/simple;
	bh=t/Cae9PFce0Qb8ltegV4GpFotlCwcdRbxWvgd17w2ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0omMJBiR9XA4MMCUNg9xkwHqj/sgStRuWWsLMjWQfiBT90wTUQIF6vuEFhDdEs21s2MNjQ3ITFE8N7Rj1+b5c2JqynO9g+Lijy+cn7YN++oF1k0AfDBr72X/u1smqdsTtxMNRi+Yi5uQLKP42b/riNIF8rkd+EXdLhUk9fWNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=uPVxpRcH; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78efd1a0022so257027685a.3
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1715090232; x=1715695032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z2A08Jr20kBVPb86rfVv1HDi3tAUKWnBkwp6nOuq83I=;
        b=uPVxpRcHKZ6G2bHjZqLX9bVIdo/p++tsEM6ORgBEimJvj38flHJFT8v00G6iCF7NRy
         F9aQIGgynkjpycLFbBY+u4v6N7hVw4RMQKmLpFPXcT923jNRZtAMid33JjniXfYLoXcW
         cMht7ddaRNXEUdI1omAWELnapvWGereHuXtFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715090232; x=1715695032;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2A08Jr20kBVPb86rfVv1HDi3tAUKWnBkwp6nOuq83I=;
        b=uOwJVK7CwQByry/HuDh09GA/QOZleeT7MebyOrp6hufksW+pJZAbuTLhSiWRhoij2w
         98Sx25k1rMuCVMsAEKVKl73ZbyS0rVRPgDpOs/ozzb5XvufGFxN/SHheppi1Qrvgl965
         Lzg1SBXjvvFl6o9L8+j7b+gVN9VcmdUEPsfh7OMWBa7kveIDXxYgjfisFVqXqFwL752J
         zAFwmeaO6JpLbXZiCRWnj0O2wXit/FVbXAKSXJTOLegSDfo55xb6mBXjAFRTQKEVyIjo
         3PEvCEBw5SFew3Z6YdMJ3dF6d/NG5TTZrpcutrrVNjuxV/cIcIWqEspA9+qPYBBNIOeN
         zdSg==
X-Forwarded-Encrypted: i=1; AJvYcCVDDpokxsyjsN0V7ZEKl29niEPbFIqOruBLhbJFGTztd87zqHX9tmn8XupufcYYW2vO0buDsYVklJ6ZT7GCEU242i+K0x+m
X-Gm-Message-State: AOJu0YxvhJkCBDFvqekN83lgXY6A89xqGkquhfo9996lVgtYcgIGtGqp
	DONV1V8n7abgaJ5s6UalCxRfhKDVtezzV/ZePTGR9Z5C/A3CR8FwxT9xDWxCtTs=
X-Google-Smtp-Source: AGHT+IFcJuvYTFSI+zDsF1MoUWcvxSd5HlkYQG7GeSf4Qz7eqqiv4oOMLXO6CXMsVB4ZbbfOXjGzXQ==
X-Received: by 2002:a05:6214:2683:b0:6a0:69ef:a264 with SMTP id gm3-20020a056214268300b006a069efa264mr19311294qvb.23.1715090232283;
        Tue, 07 May 2024 06:57:12 -0700 (PDT)
Received: from [10.80.67.140] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id a6-20020a0cc586000000b006a0cf4808dfsm4700891qvj.45.2024.05.07.06.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 06:57:11 -0700 (PDT)
Message-ID: <9a2018c6-4efb-4bfe-b90f-531a072f0ef8@citrix.com>
Date: Tue, 7 May 2024 14:57:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xen-netfront: Add missing skb_mark_for_recycle
To: cve@kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, wei.liu@kernel.org,
 paul@xen.org, Jakub Kicinski <kuba@kernel.org>, kirjanov@gmail.com,
 dkirjanov@suse.de, kernel-team@cloudflare.com, security@xenproject.org,
 xen-devel@lists.xenproject.org, George Dunlap <dunlapg@umich.edu>,
 Greg KH <gregkh@linuxfoundation.org>
References: <171154167446.2671062.9127105384591237363.stgit@firesoul>
 <CALUcmU=xOR1j9Asdv0Ny7x=o4Ckz80mDjbuEnJC0Z_Aepu0Zzw@mail.gmail.com>
 <CALUcmUkvpnq+CKSCn=cuAfxXOGU22fkBx4QD4u2nZYGM16DD6A@mail.gmail.com>
 <CALUcmUn0__izGAS-8gDL2h2Ceg9mdkFnLmdOgvAfO7sqxXK1-Q@mail.gmail.com>
 <CAFLBxZaLKGgrZRUDMQ+kCAYKD7ypzsjO55mWvkZHtMTBxdw51A@mail.gmail.com>
 <2024042544-jockstrap-cycle-ed93@gregkh>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <2024042544-jockstrap-cycle-ed93@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Please could we request a CVE for "xen-netfront: Add missing
skb_mark_for_recycle" which is 037965402a010898d34f4e35327d22c0a95cd51f
in Linus' tree.

This is a kernel memory leak trigger-able from unprivileged userspace.

I can't see any evidence of this fix having been assigned a CVE thus far
on the linux-cve-annouce mailing list.

Thanks,

~Andrew


On 25/04/2024 4:13 pm, Greg KH wrote:
> On Thu, Apr 25, 2024 at 02:39:38PM +0100, George Dunlap wrote:
>> Greg,
>>
>> We're issuing an XSA for this; can you issue a CVE?
> To ask for a cve, please contact cve@kernel.org as per our
> documentation.  Please provide the git id of the commit you wish to have
> the cve assigned to.
>
> thanks,
>
> greg k-h


