Return-Path: <netdev+bounces-144843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B25629C88DC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7442FB2F481
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871BB1F8F0C;
	Thu, 14 Nov 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aq+BYOoM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE421F8185
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582614; cv=none; b=bb0dgdftEs3SNg0i44a6sYhviL7mr1l+oeA6TRGytMnM5ge7gRD7cb0gjPhvsBhIalK44cfLsdZo6arECxgrKkm8CqrKnz05edMU6zNIViwgJYBLnrE0A87Pg2CZO0oYEW2dK8cTb0UhVns5jXQKNgoPDfm5jl0uBuV2Rm/dvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582614; c=relaxed/simple;
	bh=+PJN9W5TUF8ROvz+Dk38kDMAFGpGNYq535RDxbaJqkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoh7fPZagevLoFa2UkY2fopEy0S7eNGgPrjYWHNlLYdqS8oKuW+aQMX0QdDYrW7mjIAyBRmFcxNvDcIwPmkpVgDbRmIdzh7weLMKN0cC1aBmfZ3y0f6t3z2f7gFC4vVPF7tuex+SL4FtUeZD74HjTfvSNee8So+zTHO5CtY/WCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aq+BYOoM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731582611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQSRWxbj4Jr6bem90b/I0QTuf7y4SyjrrPrHgroR4SM=;
	b=Aq+BYOoMvBgvCe9CeWS33MxY9v0t/teSR0obVyRqq74rLaAF38V7pAYf/rmpuXPmyTldrp
	JNA/Jajkpi+lTFsshkrkQ9krWzubNenXGzIruoPH+60tfI3zUKhAWHaNhelxbdPzzU5aYy
	JxBH3eh1wXW+LcRCfTZurKShsulSxOk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-9UUg2b39MYWzW2R9BXIywA-1; Thu, 14 Nov 2024 06:10:10 -0500
X-MC-Unique: 9UUg2b39MYWzW2R9BXIywA-1
X-Mimecast-MFC-AGG-ID: 9UUg2b39MYWzW2R9BXIywA
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460b71eb996so6299461cf.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 03:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582610; x=1732187410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQSRWxbj4Jr6bem90b/I0QTuf7y4SyjrrPrHgroR4SM=;
        b=WC3fAmFi4NJCMV5s0C8d2PkCgNyi3ty3hqUcIGg92Z1zbSzpFb69X2MJHVKXBWCDVa
         WMZtve377DRAmVUmna+iUUzG0zc3b/uB8pCmo1JxirN7Ng5jY8opwtbWFVG/sMUVX457
         6bG6AJc6VfyyiN0XShDU44wazWripnVrzYPCEhcPu2qqdnvqpwJxgy3Yg9jzGdvj3qsc
         Ivf+dlCY+UvepxleM0azAYs+3hTYYqSo1NBh0FB12m7gzbna86b8+FHtNSB/hCYss48d
         1ePNkMyob/4D2NVw2ZEjJdAM+zpldU9fNjG1y2/aNXoXi0106LHLXGsQOZmUFiUFvXrE
         GzbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1LTdGrwv3gha0XbFBi05QbWEV/HDNg/iWrX3Q8At++QlbjToKCkCbJZYaPEbQ2Cwer1tqEkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3HDQUoyWt8MHd6mpU9VsLC15S6X+kALRLoJYgaAYp6nR3q9LO
	SXBlruDD1my8+Viw+l4+GG+BE4acG3iyUki/hGtikcDTdnLV8kk7EsOU8drcKnUZyd6xT5d+HXQ
	PhNgTpn1ALozMndvChocSDcKVPvN6CV4kUc2s1T/a3vBwzLBcDLSnUA==
X-Received: by 2002:ac8:5dc6:0:b0:458:4129:1135 with SMTP id d75a77b69052e-4630930660fmr341014361cf.9.1731582609956;
        Thu, 14 Nov 2024 03:10:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7F+M/vbAnAssFq0op9LX2J4MXfyIul3bpH8Mbu3LUHXaUTQtWRodj5XOTZ0rPlg9LI4bX1w==
X-Received: by 2002:ac8:5dc6:0:b0:458:4129:1135 with SMTP id d75a77b69052e-4630930660fmr341014071cf.9.1731582609592;
        Thu, 14 Nov 2024 03:10:09 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9e97f4sm4224781cf.22.2024.11.14.03.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 03:10:08 -0800 (PST)
Message-ID: <ff1c1622-a57c-471e-b41f-8fb4cb2f233d@redhat.com>
Date: Thu, 14 Nov 2024 12:10:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] netfilter: ipset: add missing range check in
 bitmap_ip_uadt
To: Jeongjun Park <aha310510@gmail.com>, pablo@netfilter.org,
 kadlec@netfilter.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, kaber@trash.net, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+58c872f7790a4d2ac951@syzkaller.appspotmail.com
References: <20241113130209.22376-1-aha310510@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241113130209.22376-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 14:02, Jeongjun Park wrote:
> When tb[IPSET_ATTR_IP_TO] is not present but tb[IPSET_ATTR_CIDR] exists,
> the values of ip and ip_to are slightly swapped. Therefore, the range check
> for ip should be done later, but this part is missing and it seems that the
> vulnerability occurs.
> 
> So we should add missing range checks and remove unnecessary range checks.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+58c872f7790a4d2ac951@syzkaller.appspotmail.com
> Fixes: 72205fc68bd1 ("netfilter: ipset: bitmap:ip set type support")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

@Pablo, @Jozsef: despite the subj prefix, I guess this should go via
your tree. Please LMK if you prefer otherwise.

Cheers,

Paolo


