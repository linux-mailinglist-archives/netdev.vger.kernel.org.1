Return-Path: <netdev+bounces-155900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24EA04404
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619813A28C2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02261F37A3;
	Tue,  7 Jan 2025 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOrCKjXS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84478F40
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263021; cv=none; b=CMWw9plTvQVCbSof1npSUPQRQDU6B/yEUBgNF4cpOMwiA8Zs9TNL9PsXzgksD4D0yoa25kuGnk0X2oP94Bpse13WGtUoCaK4/gLNMcnOEvM2NWFYQC4XH14tFIEAbGSZR2hLsl1SeXpMnlXgdbgdrrMUjVEZy4BlvmQuUnWxiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263021; c=relaxed/simple;
	bh=RwN/lrAZsAjCMTnhqC2xgvYxGg+cOZnmGbr33UdCYBc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fL5xqJ/yd5ZkELWcZQS6pBfN6O+27nuBYQ6OiHy0CdGC2bBDWWPqzS4ee9a9+4GRwFMfIkxQg9TmVHvKRbxMmdB3STOdrM8ZNL8lVpcissVjTv6bN7nrvN4pH1BWioNp4+8SqhvqgZlMLibqSdhbVzLSEeT8TOhNgttaRlHCtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOrCKjXS; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a6781bc8so111811171cf.2
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 07:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736263009; x=1736867809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZTAm2D+7Ch4hO9EHvj4b6CkASKspwuVK6PIRSjSAq8=;
        b=ZOrCKjXSI+Ml9A7kKSwhSIqIUyH9PIQziByvOFEEDgERZ8LqQP+Mf8k6vg9bl8byFL
         mIe5teZC5Nn15T8ArpBXuwVGaQnXJtKuaIIu7aut5oHCjSmK5cuBzpSUGaZIsrNlEdj1
         pF1JgLvHddV5QyKuEv1ERq4r1Tf1xJiOdrX049r1zc1Gg5nUC3nzDtMIF1Vloij3MrnX
         7R4lFKv5uvnFFJPcIJuIAyXKPhfqIPHDa2jO38XJVzdCEOd9XI3uy3O3LpAnCwUFcgW7
         YBU4CnZtDd6SbLsQDYCNC5jZrW3bvTlsxCBi8D+YvOV+jSo9c9H2KZaj98LhM+6oyAtl
         t79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736263009; x=1736867809;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GZTAm2D+7Ch4hO9EHvj4b6CkASKspwuVK6PIRSjSAq8=;
        b=HnLSqCzm5PanDpxue6g+1y8E/AEh+tPPEqS+UYSMNoZ0hzIY06bdNR9CbtOFoXEDsb
         7wpRH8mg/Jm/7CO6fQQxmMD44sgJYAtGD9tRcVM+v7BxuFJ/x1KKkmxL1j4eimuOC6+I
         RN3xl08b99ccnUtclHyyRGWLbNorDG6dN3OQWX5ntU8vTJnLDzVFda+n3B5FglV/M4Sp
         uVgP3wVuhBsocjh7hDkLasEKUJQeOVUpwcCBK8QyK2NAlhjlDed1124K9e60dRnbXn24
         gHXKPqkVggOZQCv0IwNRqeZYvEmb5fRMWonAftVrQgmG3iEcDJxO8ZfyziaCywLfA9ao
         tezA==
X-Forwarded-Encrypted: i=1; AJvYcCXFB8aaPIDRz1M3/5e6MhA3bKdLmF+0i3cE58NT/hhknkNlnXNu/DXjrdcjodMdm1PEdaCuFSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHEyXfl0V1LfchAMEais5wT5FvIIH0ENVXw5NnspTMOipxgnO
	W8NSpGe4n5yDLHPTA+VEN+y5y1I7FwnVBeycq5elfwwwLslYiVHiIgRMtfUu
X-Gm-Gg: ASbGncs4NOxx40wflj+Z8wDinmvYXcU7u7ATiNpM5l33YCsufyKRcjDh4EGLPNysnEU
	xpqC+/BDE3izHz8imY+F9fCF4IxiD0yyhlWb3+w9OxGCAm0EHKDALtTl8XmYwm/IsrzjL3+l6NR
	1Bef1pDNu9Bmxgw6ZkXmKSE4iTWNQj+aUFMQttvpfVZKcDzefeFqkFg4teIHmd6lXkW8iKBWikn
	44cRzk4ZwKlRD9lvCYdNAldbvplejyvopUIzZO2dxa7gGy2Uo3nwxP3F7sxfE5SKq+kfUFp1pUO
	ex2+GmXRM3cG5OXFo4/GxiJ1nYFX
X-Google-Smtp-Source: AGHT+IErVlyMtz+gCDVK72aSFy0HZ7jA+0bCqHCO8X3m16NgO82ZKZrtsz5qMAKRPS93MlUCXmkAbw==
X-Received: by 2002:a05:622a:355:b0:467:692b:7569 with SMTP id d75a77b69052e-46a4a991e20mr1214966221cf.52.1736263008698;
        Tue, 07 Jan 2025 07:16:48 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e688cd3sm186877021cf.36.2025.01.07.07.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 07:16:48 -0800 (PST)
Date: Tue, 07 Jan 2025 10:16:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dw@davidwei.uk, 
 almasrymina@google.com, 
 jdamato@fastly.com
Message-ID: <677d455fd9613_261ae42942d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250107064951.200e9dfd@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
 <20250103185954.1236510-7-kuba@kernel.org>
 <677d344a30383_25382b29446@willemb.c.googlers.com.notmuch>
 <20250107064951.200e9dfd@kernel.org>
Subject: Re: [PATCH net-next 6/8] netdevsim: add queue management API support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 07 Jan 2025 09:03:54 -0500 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > +/* Queue reset mode is controled by ns->rq_reset_mode.  
> > 
> > controlled
> 
> ack
> 
> > also perhaps an enum for the modes?
> 
> I couldn't come up with concise yet meaningful names for them, TBH :(

Fair enough. I don't immediately have good names either.
 
> > > + * - normal - new NAPI new pool (old NAPI enabled when new added)
> > > + * - mode 1 - allocate new pool (NAPI is only disabled / enabled)
> > > + * - mode 2 - new NAPI new pool (old NAPI removed before new added)
> > > + * - mode 3 - new NAPI new pool (old NAPI disabled when new added)
> > > + */
> 
> > > +	/* netif_napi_add()/_del() should normally be called from alloc/free,
> > > +	 * here we want to test various call orders.
> > > +	 */
> > > +	if (ns->rq_reset_mode == 2) {
> > > +		netif_napi_del(&ns->rq[idx]->napi);
> > > +		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
> > > +	} else if (ns->rq_reset_mode == 3) {
> > > +		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
> > > +		netif_napi_del(&ns->rq[idx]->napi);  
> > 
> > Just to make sure my understanding: this is expected to not change
> > anything, due to test_and_(set|clear)_bit(NAPI_STATE_LISTED, ..),
> > right?
> 
> Say more..
> Note that ns->rq[idx]->napi != qmem->rq->napi

Thanks. I did misunderstand this code a bit. Reading the config stuff
once more..


