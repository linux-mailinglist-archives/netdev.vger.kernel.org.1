Return-Path: <netdev+bounces-152634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC459F4F15
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E170188C9E4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B20B1F7080;
	Tue, 17 Dec 2024 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vb1VdRuc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AEA1F7571
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448299; cv=none; b=CLrwVV3QosoQLl143+XbYHYjF5wkjgnHDXGm0l6O4uYZrt3WBp7JADg6Cb6rq54AVtmhsxWWDHpZe7NlNo1ufNQKJW9YyUpH03azJQwcD1groKJuyXxHzCO/6Ip476REiC6FaKf4H9k7a1OCJpxIUpNSNgZUNTQWp+A45PZa434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448299; c=relaxed/simple;
	bh=3vdtslznFlau/IIKpnpAX9khJOjvyT2k2Unfnr81K1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrieJWFtK8xaLmSKrnC/5Qc65+FS8BFlyInLxhLXRAkAWyuzFEkbOp/sxQO93QThxSIDNVV566ckDylGYFGIwNqpQFLoQAGK8PjZ9HqXinDhk19H9qNK6RH2X0o8nPLXGQ94ROX/l7ae8DGW6Jd0V6Kfy1fPZ1YnU9UUgCKIUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vb1VdRuc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734448296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5eA38m2GxvNU/dLIOnc1BQum9+UOA/0HsJWGFSLPmY=;
	b=Vb1VdRucb0yYVXgRtu6tRkZjBejnvxHZ1wS6WFy006PR9REzD6qbeecDdX002kdGZSJZJy
	g2pXfYG468vXOlbBj6sqePKOQnHSL7hONHl9wK30+v7wFgWLHLRsLhSAHN/HvMGMgbgeen
	abfzxIZasilitg0+iUP7E1AhTXqPCM8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-zrv0CARSOAaBKCFAlI372A-1; Tue, 17 Dec 2024 10:11:35 -0500
X-MC-Unique: zrv0CARSOAaBKCFAlI372A-1
X-Mimecast-MFC-AGG-ID: zrv0CARSOAaBKCFAlI372A
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6dcccc8b035so72667836d6.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 07:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734448295; x=1735053095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5eA38m2GxvNU/dLIOnc1BQum9+UOA/0HsJWGFSLPmY=;
        b=fxp3c+cPP2gCUmXeVOzdvqxUPmjVTyetbe9b9Gvct9SDlu+d2YwzITuIXI4Ild2tkt
         x8EBPgT8XZPNxdWTYt79DLBxkQUSuvP7EDXMU7UcCFXFF9XoynsObNEcxlkVgkUXBPMH
         Ocrs/6+yt0lSw7U35zEMjOvioW7YdoZIuX1zY1ZQRc6JgLJTdiayfEs2HGlRQC6lRU7P
         3m5ccLopIQe9ATSl0srFvPnBRbCDN7XItFLkCDkuUjVUTQCno08YLGMJxMLP+0m0Ozbx
         m6lnaHL7UrgFQ6jeQ2KPmrtpkaA6b4ykeTagKSG1JpommnxE5XSHehnOFssWCI0CdlKo
         c+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU17CM0OUEmiEGbzhOyYy0spJES8zQqYF6Dd+hCU17rRjJQP5CcGKqRuiqQeDK3J5sk6JWLqqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4AMpQu1Ni434O24cnRJz5tMbayMUpqUpJfwj8gVy42On/ZwEx
	MRiK/hcw5pEqorNNg3LPnDABN4XnHZGHyTmPf2q1YkHaz/36ejlhG1Ji/XbPo9KPgrJzWX3Gvj/
	I4QWj4PlZb88te4x5r5mBi/m7KeqEz+v1bybnSCH1CfgnWF9ewDtWCw==
X-Gm-Gg: ASbGncsovfJKdcTivyXp2pt/kk+ohJ05cXPPc0wATsViFzUTQ8sBVdWyZXR9RsJlgoj
	q9cXFZdNukOvkIgI7q9gHd8V0DYTsFY6wQobntQP+9XQbC0hliM6kDL21R1wZsMYhtXbvwRqea/
	dAfnOeT0KH8+/0bDRz5oov6t2wuUmcNO/kESdtLcKRZgHNYAQqo1mhKqf78b7q9ASUtTz+p5504
	6hjQqs6LGajzS8qCugGrOUXIFZqcHH5PFD8cIASxJDhlfyYLQm4+dc9B6luO7zxUFZlguUvlZOQ
	xNenxVrldg==
X-Received: by 2002:a05:6214:2486:b0:6d8:a3f2:4cc with SMTP id 6a1803df08f44-6dcf4c385demr65027726d6.5.1734448294416;
        Tue, 17 Dec 2024 07:11:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzP57X/BweuIG/kHJ9/JmT/cEseWmJofpVUL+Fb/1flSIptNOX/KnR0C4pN3YCP3WvTPvOXg==
X-Received: by 2002:a05:6214:2486:b0:6d8:a3f2:4cc with SMTP id 6a1803df08f44-6dcf4c385demr65026936d6.5.1734448293817;
        Tue, 17 Dec 2024 07:11:33 -0800 (PST)
Received: from [192.168.88.24] (146-241-69-227.dyn.eolo.it. [146.241.69.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd22f494sm39601816d6.18.2024.12.17.07.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 07:11:33 -0800 (PST)
Message-ID: <b701482d-760a-437b-b3fb-915dc3fc2296@redhat.com>
Date: Tue, 17 Dec 2024 16:11:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] rust: net::phy fix module autoloading
To: Jakub Kicinski <kuba@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, davem@davemloft.net,
 edumazet@google.com, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, aliceryhl@google.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, netdev@vger.kernel.org
References: <20241212130015.238863-1-fujita.tomonori@gmail.com>
 <778db676-9719-4139-a9e3-8b64ffa87fd2@redhat.com>
 <20241217065439.25e383fe@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241217065439.25e383fe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/17/24 15:54, Jakub Kicinski wrote:
> On Tue, 17 Dec 2024 09:54:11 +0100 Paolo Abeni wrote:
>> @Jakub: I still can't reproduce the nipa (rust) build failures locally.
> 
> I'll look into it. Just in case you already investigated the same thing
> I would - have you tried the rust build script from NIPA or just to
> build manually? 

I tried both (I changed the build dir in the script to fit my setup). I
could not see the failure in any case - on top of RHEL 9.

/P


