Return-Path: <netdev+bounces-97365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB79D8CB15C
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 17:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F69B22548
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 15:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780AE14430D;
	Tue, 21 May 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5MoUKjs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3511FDD
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305331; cv=none; b=JTVo2npQ8jGFGoBi3JrNJpUkfrt0CU1nOqYI7GL9WLuf/P1jTOAgatRhE01cs0JmoJIuF2Xh8n54XMtqUcy2BlAxMSPasofZ0HBySWOoYiGYt/+mPMXLiOuULZoOe+G3whG3gtujNzRFCZfri0tbK2kl5HFzXKr8GRBOOeTe+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305331; c=relaxed/simple;
	bh=QdvNN4ux3vftozDxbS9yFQvNqh/YWSRTOOgZELawYjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCYARQS5EnWNuK9+q+8pMSmjxpvcbZNtFRragzANh17UbYMahiMGiPcdXNv3b8dQ6bvgHyxelDvJ5R4j8/43pC+44WFLGYH4z6bPTSdTASOjgTe/zgxnEhMmNJALtdVzHsa8vlDFU7Fv+mdCSP3gxTRxjhNV2XJHGg3g5diFPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5MoUKjs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716305328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvalVcpeJBX7T4B/fcPMOd0QFgC1iXDiyKWmYajeijk=;
	b=M5MoUKjsUZaorPK5vXzjwBbgCpUWysY1tzkX7YQJ5uh7TfpdQRBrxQhcg72p1czaxNTczP
	ICj6pmfDYoLRgN3tcwlQwianiVNw3D4KChkfIoyyjRPhmFhMb3XTrseg207LcwDugRMMO6
	rGGS9jIYDuFnB9Kl7bD7zsY1LeIt2TE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-zGI1ygxWNgGwPGS0zQZzbA-1; Tue, 21 May 2024 11:28:47 -0400
X-MC-Unique: zGI1ygxWNgGwPGS0zQZzbA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ec48e36217so108669735ad.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 08:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305326; x=1716910126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvalVcpeJBX7T4B/fcPMOd0QFgC1iXDiyKWmYajeijk=;
        b=HzKhCsyxrFDJjogE4eK2cixSOFcgLNDfrZEZZ/Hw/Zjw6HleC9C0gyiO4E8tW2b5uB
         hPdD7LR6kbFhO+6EOy2TS083QniWUtf7bgqyISSklLpA3wEUWh0cRx+898lNT/SwLubY
         CVwww+E3Hj0uWKhXU/MW8Mm16XJvY0LlB0I7BSGGxyYpTuPERW8uTWbpUm1atVf6WCij
         t1WCkGw0VUrOnxYUPUM9BTH4hk8EjUe1iZl5rlQaHqyN0sdjm5ptqreruJMWmDP1vNbq
         jkvcTTjgpKsWr9vhhUphbjpzHtUAhS9agozTnSQ5gVpUvkqWJfbfojbj5WX9NJJcwLAX
         sj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVY4cCXV7oDT08XVMtpt9lN7wtw987/rQCe9WbWYK/EH4+TswveERqsT2/9OwY8E3ofix/pPF2zOrpS5Js1UrcC+0SOmpGY
X-Gm-Message-State: AOJu0Yxw6z9hVgLBBUwpuYvyP70m8g4Iygph1PjeY0M123JGgWN1r7JQ
	ng294vKD2FvjOLbv+rLMQ99cburTokKCO4jTsmi56lLvgXf9FuXzEq+HaGjsZF4eIYVRfRki8rg
	B2njNbAgK/apb0Q6/yfVN9ZJbF93PR5yyBBo//Rj10wmcgAlU8aYR+w==
X-Received: by 2002:a17:902:bcc4:b0:1ee:c491:ab62 with SMTP id d9443c01a7336-1ef43d2ea47mr294190355ad.25.1716305326126;
        Tue, 21 May 2024 08:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx1n4JLjA52CrbGijWG8t6of/hs9QNgynVg+bR4Tq3GlBgh09Hyleep4PO0WPhhy+YxSgScg==
X-Received: by 2002:a17:902:bcc4:b0:1ee:c491:ab62 with SMTP id d9443c01a7336-1ef43d2ea47mr294189915ad.25.1716305325600;
        Tue, 21 May 2024 08:28:45 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2ff0b9027sm39741685ad.94.2024.05.21.08.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:28:44 -0700 (PDT)
Date: Wed, 22 May 2024 00:28:41 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, syoshida@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: nci: Fix handling of zero-length payload
 packets in nci_rx_work()
Message-ID: <Zky9qU3QKziLAQDN@zeus>
References: <20240517020609.476882-1-ryasuoka@redhat.com>
 <8947cb3f-39b5-4483-af1d-82d3fa4bb7ad@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8947cb3f-39b5-4483-af1d-82d3fa4bb7ad@kernel.org>

On Mon, May 20, 2024 at 11:58:47AM +0200, Krzysztof Kozlowski wrote:
> On 17/05/2024 04:06, Ryosuke Yasuoka wrote:
> > When nci_rx_work() receives a zero-length payload packet, it should not
> > discard the packet and exit the loop. Instead, it should continue
> > processing subsequent packets.
> > 
> > Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> > Reported-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> 
> That's not a valid tag here. Every bug we find - like hundreds of my
> commits - is reported by us...
> 
> Drop the tag.
> 
> Best regards,
> Krzysztof

Thank you for pointing me out, Krzysztof. I didn't understand how to use
Reported-by tag correctly. Now I'm clear.
Yes, I remove the tag and send a new patch.

Very sorry for sending this patch again and again.

Ryosuke


