Return-Path: <netdev+bounces-65220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECF6839B38
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAF02860C9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FCD3D392;
	Tue, 23 Jan 2024 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RZWZDETR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D63984D
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045559; cv=none; b=CEiZlnH8CFD3clMM/SMqhuWkex2rN2xaYl8i+B53RHTLRmZhstkqY3mRbtn55G65EtWGCHjIBoDLr6/GdORT/7X9tW3gS23ftRZ31UIYxJy54TiyDCIXSw5pjweJEWOgY/9bXlD4romWFGJyqMJIvhQC5eoXVRe5Ko8oopPqDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045559; c=relaxed/simple;
	bh=N2eMKxGKC9fb0PjB8BggX+mn9jsS+yaW0VK2ox0w8Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfzjAIX0C3gBQ30sB0MUyt73DqJ4ISKtGYobT8j4M6aXvcKMeU/zn/1+UzQfmCjVQCWYMW4TnMEcbVn4R8+Fw9J68EELkVQSI2McOrayYYON3dinaEGPUrNbhSfmgtXAMNmC8FEhWl3v2ee0gjLdRA5AE1AwGSFOPBUVeKmIAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RZWZDETR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d74678df08so16070825ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706045556; x=1706650356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swQh+tXC7wjzygjmlvxoa7jnM24RYNaNqlf/2tnlFpM=;
        b=RZWZDETRJ3tdK1x5X6K5KNtiJ9OFq2PbD0OBYuOj5ncE/kICqyYGWyiipWArPUcV+R
         I+VcKv+e80Px86gl3C4eF6UjVc0z6kUBEQ/9X4Yswd3eUeustu+K4+ttSrKMPRUpJqOF
         Sj0lAePTvUusLq9GYw+KSHDTQyNdvGhRNvpBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045556; x=1706650356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swQh+tXC7wjzygjmlvxoa7jnM24RYNaNqlf/2tnlFpM=;
        b=iRBC2q26dzNx0nZI6jJ6gzyyIvhwSZzLgPUTWkTCdXdbSiIHowYjwcnc8YFVq0g3dP
         YTLQPmrI/y4OmMB32P+st23++MuHCK74QyNv9V481tG0m2s1+kMNHBcHgV+Z4UAxnwOD
         p3Py1hesjZOxKgr/N81YaWYeBlwemzNZrYRA0uma5KeqgK26l3tpbEcoZ+L7MrNTyoEh
         KISDWIOHNV5pn2NUjbcb8ussQkrw9uYB8n/p84W8GTQt0HAE3rblMy6JuVLc+4QmEThi
         4lwu0g9gnAunBqZYDZA4tUDrO1rdZg6iViC1wEacVq2TnchasQSROtYKJ/KW0XDbxEcs
         gcRQ==
X-Gm-Message-State: AOJu0YznjMZWoiE6QmOm1XGg+s3Bg1jqWLe2KClsrbV+NY/OJwdiYRJe
	hAw3ca1lEFVuLam/jLLy0vwbt5SNgOkk6sVdeeChMDdUfUXMl46xdI2U1av/UQ==
X-Google-Smtp-Source: AGHT+IEQgobK3CRi+ljenTCG6shvI0FXYyD3FQGn2ZQQGUseg7yif9UwvyOavRLNcvr02zSwCtZc7A==
X-Received: by 2002:a17:903:120d:b0:1d5:7316:c9fb with SMTP id l13-20020a170903120d00b001d57316c9fbmr3866864plh.37.1706045556284;
        Tue, 23 Jan 2024 13:32:36 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g8-20020a170902740800b001d714ccf7b3sm8100220pll.180.2024.01.23.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:32:35 -0800 (PST)
Date: Tue, 23 Jan 2024 13:32:35 -0800
From: Kees Cook <keescook@chromium.org>
To: Jan Beulich <jbeulich@suse.com>
Cc: Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 80/82] xen-netback: Refactor intentional wrap-around test
Message-ID: <202401231331.0BD2925D4E@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-80-keescook@chromium.org>
 <35ff4947-7863-40da-b0e7-3b84e17c6163@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ff4947-7863-40da-b0e7-3b84e17c6163@suse.com>

On Tue, Jan 23, 2024 at 08:55:44AM +0100, Jan Beulich wrote:
> On 23.01.2024 01:27, Kees Cook wrote:
> > --- a/drivers/net/xen-netback/hash.c
> > +++ b/drivers/net/xen-netback/hash.c
> > @@ -345,7 +345,7 @@ u32 xenvif_set_hash_mapping(struct xenvif *vif, u32 gref, u32 len,
> >  		.flags = GNTCOPY_source_gref
> >  	}};
> >  
> > -	if ((off + len < off) || (off + len > vif->hash.size) ||
> > +	if ((add_would_overflow(off, len)) || (off + len > vif->hash.size) ||
> 
> I'm not maintainer of this code, but if I was I would ask that the
> excess parentheses be removed, to improve readability.

Good call. I will adjust that. Thanks!

-Kees

-- 
Kees Cook

