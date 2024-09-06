Return-Path: <netdev+bounces-125887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AB296F1C6
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E084B1F24D08
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A871C7B99;
	Fri,  6 Sep 2024 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFIXYvTt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116FC1C8FD8
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619362; cv=none; b=joTArokavT3RvrbQnQmnYjoCcaDLgSpFaO5/Hf11yqC4wgDdvMo+OBXFIvowyUw7l/CHeYYrdVgFoRdT1x7aVJNDXw6K9WLjtS7IGKZMsLXxbklaFxy7DTSK4PpQAsx5A025vldyJdZlPk1zXp+DeXnP3igv/lBg8IlPAEwEJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619362; c=relaxed/simple;
	bh=tNY9OVEPUkQCRSddPRzTOAf5gv35Extw3hCzBkqQms4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWRuo++2rZ3Iv9BTstCdMdT+sMLxNKYv15zVjfiHPpvYz9Z9BeHdzkIiyigFjKl8JOr3/M38/scO+eERGpLfV2S4/7mnKLYIxX7Ra/HDtiI2z6ruIwdOgR5SnCUdwtfap0hP2NZoFu5JFxacjQWE2/3ipTcFItH1apJJ2aVsEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFIXYvTt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725619359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=905m8opF6CNI6XYyrVzmDB5LdV3CVxo9gXV96gjKlww=;
	b=PFIXYvTtBVahyHPHQi4NsO7AVndNzcnzgoFESk9bvP6nKH8l5cQ6iMrZe9yC/1Fi44CemU
	VnLJQ2dovPVrOF9Bwbxpcx9Kq0QGTw3ybBbna5wwtRxBfOJyRHsRUWJsL48Fv+JFisg76e
	qFqBvkOaTAnPQFzNTU6EIN6tLmNLbSQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-SFpcYCCMOuWtdyZ9Yi7asw-1; Fri, 06 Sep 2024 06:42:38 -0400
X-MC-Unique: SFpcYCCMOuWtdyZ9Yi7asw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42ca8037d9aso748755e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 03:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725619357; x=1726224157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=905m8opF6CNI6XYyrVzmDB5LdV3CVxo9gXV96gjKlww=;
        b=uttzJNvX/Ko0SeknUnACVbDfLe7A+isMZDOfA/ggSoy32HXW2izCdoqmzRJZYHVoV5
         qUUWEItDZHWKSEBgyy2/KPv2YBiPt+KBB+bfIeOnrP0R1XzcKqijaO9wXy/kzaLIgcDI
         NeiPEO/0hcVD4qhPvYt3RTpwIFZolaF6rZegjJmWDKkX0+yPOn5IZCwG34Qth9Eanx5G
         2ndUf4P1ITqpdBl474Pe4+zufeI4JAJSddKtKsB6bgQeVDqVOKx54kuQYz9vGlDlbIqQ
         Gvi4fdVtw6N0VmIh9armXCkVGOPnRWxwg+MmXhHat3r0XEqSbUjfEaCeY1PMO3j1ciz2
         FcTg==
X-Forwarded-Encrypted: i=1; AJvYcCUc/L+QssDoLOFOGamPLGY2Xj05U9R2C5z0xnZ/K4n8uHnffJ0NsESiNKTZHHDbOsIUBVp3DOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweXthfZ0TPd+tUrUybDJoRuXlotG74vCOwD8r+Xd/jiMB5FrM9
	MIDka5dLHNKZFNrB9HjFPySjqTQYBzWuXGAkDiuhneymGR3Dz9mSWLqs0EyW6FfVnE+l7UpIHOf
	pY18bHqgiKeZHZmAI7DMD9jhbQKa/GIjPhL9KqnH26XGY+UsbcVcmbQ==
X-Received: by 2002:a05:6000:d05:b0:374:b399:ad6e with SMTP id ffacd0b85a97d-378895f20damr1456865f8f.35.1725619357479;
        Fri, 06 Sep 2024 03:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9xaxWlV1CFwdDJB70m9ncOa5CrwIrzwdrdZxqP/YFkx8/CH4mZvLAUJL8JxWeZPilWhv9/g==
X-Received: by 2002:a05:6000:d05:b0:374:b399:ad6e with SMTP id ffacd0b85a97d-378895f20damr1456817f8f.35.1725619356155;
        Fri, 06 Sep 2024 03:42:36 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3779867942fsm6157268f8f.105.2024.09.06.03.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:42:35 -0700 (PDT)
Date: Fri, 6 Sep 2024 12:42:33 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
Message-ID: <ZtrcmacoHyQkqZ0h@debian>
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
 <20240903113402.41d19129@kernel.org>
 <ZthSuJWkCn+7na9k@debian>
 <20240904075732.697226a0@kernel.org>
 <Ztie4AoXc9PhLi5w@debian>
 <20240904144839.174fdd97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904144839.174fdd97@kernel.org>

On Wed, Sep 04, 2024 at 02:48:39PM -0700, Jakub Kicinski wrote:
> On Wed, 4 Sep 2024 19:54:40 +0200 Guillaume Nault wrote:
> > In this context, I feel that dstats is now just a mix of tstats and
> > core_stats.
> 
> I don't know the full background but:
> 
>  *	@core_stats:	core networking counters,
>  *			do not use this in drivers

Hum, I didn't realise that :/.

I'd really like to understand why drivers shouldn't use core_stats.

I mean, what makes driver and core networking counters so different
that they need to be handled in two different ways (but finally merged
together when exporting stats to user space)?

Does that prevent any contention on the counters or optimise cache line
access? I can't see how, so I'm probably missing something important
here.

> bareudp is a driver.
> 
> > After -net will merge into net-next, I'll can convert bareudp to either
> > dstats or tstats, depending on the outcome of this conversation.
> 
> Sure.
> 


