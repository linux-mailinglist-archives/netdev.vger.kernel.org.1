Return-Path: <netdev+bounces-113224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CAB93D3F0
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5354287BD4
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7081417B507;
	Fri, 26 Jul 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlHXNVm7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63C17838C
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999718; cv=none; b=CvLFxTEXrff31m02h7IjYkS43t82uSuBnwqHspDAF4dOFfiEwN9iOuEx+7/uf4oiX0REugTYpEeEwmIm3+9wJx9QpeAidd3MATJpFmGZd6PLL7rEe4NhMg2mNpiOwnqrFgoMvLIu1rMm0r1PqgqylkeLf7b78JDppjpzzTW+K4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999718; c=relaxed/simple;
	bh=LF0PKlCsDKYpv+HQFt2fCkqg6jtEYdv7eFCfliVOwPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is5fiFC+lZcofRLQAGVwErOM54eH8kOY7s14CGtk62EeKyl4kjFAr27BQoGgpSS6eUTSa7qqC3memOI9ytmY/oIL/Dc3wEal2mg/D4e/XZelOA3YcRmvbtvY7zCO77AQvlnTr4qZBC2ZhFMRS0NyQ5vOOedTiQnxUWCXvNPgQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlHXNVm7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721999715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2EhpoWb0AurDY6o27/mIIhlnMNFRUh7l8fb/1FOa9EY=;
	b=PlHXNVm7svdY3g8H46rm28z3ue5sa7UOOfCybj662trzEz9uQhNV+iW0as7L4+3MNZAMux
	OquFV/0gFf+rnaoGrt25lMxMJ5HA5FXxwtR295ZQxiTxhnedjV9uMo0mUd2uwePlZ8mtvi
	Qsld0uR183gLuIDUqtDbvFXktYEsbM8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-WM3bAqzcPuKpb9YPn5Ax8Q-1; Fri, 26 Jul 2024 09:15:14 -0400
X-MC-Unique: WM3bAqzcPuKpb9YPn5Ax8Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36873ed688dso1135271f8f.1
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999713; x=1722604513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EhpoWb0AurDY6o27/mIIhlnMNFRUh7l8fb/1FOa9EY=;
        b=uB15ErAEuJlj2n1a1xS2MXMAecmRAhrcLFsuS9OKIxwoRWCkBgCqSQpd5BxhKs38VF
         UFby4TZGIdKG1nrLp1uKTD52SVJeU9Q21PnJbvCOIkkpUa57g3wz4tyR6sM8D4/m/4U/
         mT30LVlIQsSa/XGG+qVHXlRdqAepbHasOT1HsjwUXJr8wu1W70Og23eXLvwZdlZXEcDJ
         hZzO0sMiOoT+zt4f0nwtNNsWC4CKS6D945QKfA5gTbyVuRa1IR9vIjBcIuXuUb1WSdn5
         w/gwKe20A88CogolTOr7o27MADC8hjNdwRsFUm8pjrWwQQGkHwhWa5lz49xgfeYHFAc7
         jVKQ==
X-Gm-Message-State: AOJu0Yxk4I/O5JKC/WRGAV9geSRnK/QGfYD49x5jSN/iRTK/DuAetMhV
	SW1Am+Bx4uhCoKtwt5EWyNKOeVwhQMH4/37bKSVrwaUzcgnnXLRGk0isikibTBJp+63k59Yh8S+
	/kAKMNvGZjCgg62wzEh2vfMrWFOgcx90k9hFaG+SUe3gN0oEJ30E+Gg==
X-Received: by 2002:adf:e792:0:b0:367:96b5:784e with SMTP id ffacd0b85a97d-36b31a795fbmr3817597f8f.50.1721999713446;
        Fri, 26 Jul 2024 06:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAIVE6aRZFryUDPhlNqaJ4GXjinhwOOFRqyjWsrTiYldwpHCv9/AZ2LGJXXQtrl5tKP35uLg==
X-Received: by 2002:adf:e792:0:b0:367:96b5:784e with SMTP id ffacd0b85a97d-36b31a795fbmr3817568f8f.50.1721999712852;
        Fri, 26 Jul 2024 06:15:12 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93594b6sm121233975e9.5.2024.07.26.06.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 06:15:12 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:15:09 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de
Subject: Re: [RFC PATCH net-next 2/3] netfilter: nft_fib: Mask upper DSCP
 bits before FIB lookup
Message-ID: <ZqOhXSYp6yHlcNmy@debian>
References: <20240725131729.1729103-1-idosch@nvidia.com>
 <20240725131729.1729103-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725131729.1729103-3-idosch@nvidia.com>

On Thu, Jul 25, 2024 at 04:17:28PM +0300, Ido Schimmel wrote:
> As part of its functionality, the nftables FIB expression module
> performs a FIB lookup, but unlike other users of the FIB lookup API, it
> does so without masking the upper DSCP bits. In particular, this differs
> from the equivalent iptables match ("rpfilter") that does mask the upper
> DSCP bits before the FIB lookup.
> 
> Align the module to other users of the FIB lookup API and mask the upper
> DSCP bits using IPTOS_RT_MASK before the lookup.

If Florian and Pablo are okay with this change and the long term plan
to allow full DSCP match, then I'm all for it.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


