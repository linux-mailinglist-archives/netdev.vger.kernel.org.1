Return-Path: <netdev+bounces-207239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55623B06546
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C693C3BF689
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C7A28507B;
	Tue, 15 Jul 2025 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgyPUXB4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010311D79BE
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601067; cv=none; b=d7ac6F00GfHPObXJjuMq5O7K1sQmjCNUXpDxR/XFVGFvTAPgyJPYXUBXCCyjvj/J8ru00ZWYaberEFdz2B4uDcQvfkYMf03eRKDQ14oosE88sJ1WPZZKI3wuGErrGbTywhMcuCfZN0+eyT1NabPlUSk6fP2jWCll/fKWkXi5p/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601067; c=relaxed/simple;
	bh=XfSVpD9Z7XphBM4ixb2rCWDLMorg8f3Q4PGNqpR6KAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEgpGxduhskVvtG7rSJBIphdIgfC83Ttv4EBCXVBh/7TLuRNgMheP9etkbf3cjtTvXOPEM3Jvdgba33pPFmyoqmfqs5SJ8R2Iyhx/eigQkEhsUW3Hstgr64nQdAUEi7Z2JIKrJurkoUY9AXF1u3f9mZLK7KYWnq83XVEJiA5lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgyPUXB4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752601063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cdcx7QAfZlAuJUAK+fb/wqda3KOPzzyARCBWyre1UeA=;
	b=VgyPUXB4kBilNEBCjaVRvMPJjFdGrAL4dDjuXwdkSBXI2Z+oj9iRItEDAoCfabeRuWkuke
	nVfWIZmfNEgE1kJdfAF5H3Z0XAMJ+wfw8RIceJ5R2Wo3KRJX+5DgLI6gYFGoI0idZZoifu
	du6m8vpx88VxG+9FgFHRxqMeGIW86bQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-zPy6GhQ_Oiy_m92EHoQTfQ-1; Tue, 15 Jul 2025 13:37:42 -0400
X-MC-Unique: zPy6GhQ_Oiy_m92EHoQTfQ-1
X-Mimecast-MFC-AGG-ID: zPy6GhQ_Oiy_m92EHoQTfQ_1752601061
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so23049655e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752601061; x=1753205861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cdcx7QAfZlAuJUAK+fb/wqda3KOPzzyARCBWyre1UeA=;
        b=QaUbSP2Zumn+zHUpC1BdX6N5nLHRP7q1vDZWnXlt7Qq0EcLE3BmQkUFb+pK1lRQcUA
         mLBqFz2CmpAUDVASd6ADkeCXyjAumrPPsWmDorS4L9PuFxtwbIGYVFRJdkTN5j436Hol
         kqPWlZavWfAQJQESod6yXX+IxfAMU5/A0sJSjxQOtavf1mQdBNbE/L7APOrkHpz/YIRh
         AUg080Jps+4JUo/rPxlPdp3/S0YxjNqTHMXcTTCmSrL0ASqnAxzSryyqW8En1vThHJbo
         IUtoOMXaGLJOUIs0FwP3bkz6KS+bb3ZIxCEsws+y+UAWgW7zU56Rsql1ubzDeEVBDJnv
         1doQ==
X-Gm-Message-State: AOJu0YwPpjrrFdQoJ+rEHo9fDAIAagZTJvaCLYK6caY/k+ycSW76zN0C
	ER5vN4XvXvS8kdfN7kH/8WbXmRNSmEyB4wE3GidHWqNVarB6tSTdsx+kPK7ZyHU/S/rYpkHY5tJ
	Xhua42ZvHjtB/ZHXwdRBt/zRClIHsE1p3CebByE9vnZGv/v7zaxQtAQ+uIg==
X-Gm-Gg: ASbGncvGCLFi0Bw4Gtn9B13DlKWZMr1jxPCtoQyhOtt8liOzEM1XrQXWClMUz6iYX/U
	IxSpCQEUY21oic+JFVpyAtF4TC3nxXCrOyO9eOjIWxuwcuL8NhWNWmoEZUbIuSRkclGKwlBPz/l
	hCBXm/Zp0UvxV7dySj6Kkxfs5IOFIDWzzdLrYmHPTCAumiY4vciW0tfUPy9L9MN0pGDf5wK6Qh9
	GuRtppVuoAdMNeJeYwU8ZMpHiHzT1rJ8Kv43GnlaSiSuO3RAA3z1qkvX0AlrkpEr0E9dqvi/dsC
	7YKk/YWblxCVT7sOSJLkVajSGJ8=
X-Received: by 2002:a05:600c:c11c:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-454ec146a71mr126236645e9.11.1752601061309;
        Tue, 15 Jul 2025 10:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEav7jSZeI2X7Lu4R457llVbI4CiXULRrrPNd8TKiDciKzpga3jeaECrjhf/ot1tIBrxWWMDw==
X-Received: by 2002:a05:600c:c11c:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-454ec146a71mr126236465e9.11.1752601060964;
        Tue, 15 Jul 2025 10:37:40 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5050d34sm209336735e9.9.2025.07.15.10.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:37:40 -0700 (PDT)
Date: Tue, 15 Jul 2025 19:37:37 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-ppp@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Williams <clrkwllms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next v3 0/1] ppp: Replace per-CPU recursion counter
 with lock-owner field
Message-ID: <aHaR4QzKvCDi/LYx@debian>
References: <20250715150806.700536-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715150806.700536-1-bigeasy@linutronix.de>

On Tue, Jul 15, 2025 at 05:08:05PM +0200, Sebastian Andrzej Siewior wrote:
> This is another approach to avoid relying on local_bh_disable() for
> locking of per-CPU in ppp.
> 
> I redid it with the per-CPU lock and local_lock_nested_bh() as discussed
> in v1. The xmit_recursion counter has been removed since it served the
> same purpose as the owner field. Both were updated and checked.
> 
> The xmit_recursion looks like a counter in ppp_channel_push() but at
> this point, the counter should always be 0 so it always serves as a
> boolean. Therefore I removed it.
> 
> I do admit that this looks easier to review.

Thanks!

Reviewed-by: Guillaume Nault <gnault@redhat.com>


