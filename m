Return-Path: <netdev+bounces-120279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95668958C6C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507D82822A6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3871C37B3;
	Tue, 20 Aug 2024 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVR42cFa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD671BD507;
	Tue, 20 Aug 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171909; cv=none; b=Bxr0cdhIorWCI1BqOITrJndLkVnZ45536yu6ZFs9jO39ImSQyHJ0v+zCeF/KYjzLMDqKPlxR9bib1uxZPrXGN1SYIR1pOKNcxEv62ZGVRdgzM+PrbqKrEu2ci8pHQQj1GxDa/JEmKGfNkUjSrlHArUWFe3DpHV8RiukeA5gUYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171909; c=relaxed/simple;
	bh=Mw1LxusMjjqBNLoacxcUmgihSJw0kPVkaiDlpQXYOLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE2OWHnWW+uLQT6D6uPEAwWqn3DldxLCQhn5PyMKBuoyjDZig9uzBy713E8KhrPd5RxG2LVs8XkfmSJHEqi7vlcv/uk2q9Q8Vv/7K4JeYrChKnoJ/xzFfoxP5R2294hufwdUm/Dq3iUH7ppJts2KzvNfAgg1K06TYpNX5/QHshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVR42cFa; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-70b2421471aso3599910a12.0;
        Tue, 20 Aug 2024 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724171908; x=1724776708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0hyVOwFFKAnzk2Hm15nF3hPP+DbyQF/Es4VmHJ450g=;
        b=eVR42cFazmhr49oT3SrHn2Q28UVSvkbwRSI/WsL7tcaTMCnyZQDqUoAI1Kge4antCL
         XT0vEd5JgqBNH4ZcXhBkxxSZupaxhMpXRlZDlK0+r5EMbs2Mvuf7pWQA2A1ACeLwZ15o
         qgY9V1ooSWJLgNZ8Oj/r5rhoJYjEeXoYvKPbC5XzrEZhzqzDCFOxZX8uxmnc3S3Ys0wH
         cVL/wkvCKP2iW5eD4fSqYHj2xIMXCuERnnu1vldHhODsCnhMzNcqV84NbvutBuTinlcU
         VJb3+X9jlk2XlhZlFPbv7eE5+tOicycS0OOGGp3nbaWaXm6hCMj5qV6fSlof/Rp5/aa/
         stbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171908; x=1724776708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0hyVOwFFKAnzk2Hm15nF3hPP+DbyQF/Es4VmHJ450g=;
        b=F8WtOZM+Wju0qkvGNfRyBJoljdawd/Al5FnVIIInf7y0Y5RQovp4opRRqkMEQ9BOuP
         KLHA99qdF5eKAO77AJia1RaCUyK5cHU3cPdLF6RT/w2qjnB3QizQdZHA2MPziFirx+7z
         iyNX8aX3xGu9S+GFGHP2C2N1FlEKYHCuZNOTOk7U1HBQ+fqy2DbYczE559rZ1gQOlZsx
         bSZwCmQHcpJvGM8CAGtwI3loy5HKBf4PASfKU6SRm8OREaMv4etpBMJCtZSOTo+yVo1o
         NBWcuq5uc3wn8S2pyyMcxGGIdYSb9/DzUHmQu5cSEtna2zQgpY7j6IGXGDOypKwHSj19
         vxVA==
X-Forwarded-Encrypted: i=1; AJvYcCUGkDioPYLFU6sSV4nvtr7OtqDTYRK+5Gzqj5yJTf0TrXIlZ88V836w6/LYhkXiM8R6kbj9hHsQky4pUIkN0qfQAqWzuCdW3hZk8bfCjkyGu3qsOHc0NdCbUkHQ1AaO0NzxWB+B
X-Gm-Message-State: AOJu0YwF4/P4mEcl0Zd78fPKH6gXIpDq5ctJWWJGelLuo/BcFsbkGlbU
	1as/KtQIgi+VucV9DpT2n7V49Wokdddvf/mfnysMBCkOzrI6OvjXjWd1iQ==
X-Google-Smtp-Source: AGHT+IGAJrfjnZvmVwIc3YOjj5TIHjx2B7adQpzd2L3ghNk8xvjgGnDO9fFZXSJF+nQHVeb77ilxxw==
X-Received: by 2002:a05:6a20:c99a:b0:1ca:ccd1:4b33 with SMTP id adf61e73a8af0-1caccd14b9dmr2245189637.7.1724171907098;
        Tue, 20 Aug 2024 09:38:27 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9f8b:d2d2:8416:b9d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1e773sm8691363b3a.174.2024.08.20.09.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:38:26 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:38:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next] nfc: st95hf: switch to using sleeping variants
 of gpiod API
Message-ID: <ZsTGgMWvD8b6_8SN@google.com>
References: <ZsPtCPwnXAyHG2Jq@google.com>
 <9b77e25c-8942-42f7-b82e-42b492b437d8@intel.com>
 <2a72c443-2aa8-4a98-ae2e-62a781e0dd94@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a72c443-2aa8-4a98-ae2e-62a781e0dd94@lunn.ch>

On Tue, Aug 20, 2024 at 03:53:21PM +0200, Andrew Lunn wrote:
> On Tue, Aug 20, 2024 at 10:10:37AM +0200, Przemek Kitszel wrote:
> > On 8/20/24 03:10, Dmitry Torokhov wrote:
> > > The driver does not not use gpiod API calls in an atomic context. Switch
> > 
> > please remove one "not"
> > 
> > > to gpiod_set_value_cansleep() calls to allow using the driver with GPIO
> > > controllers that might need process context to operate.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Code is fine, but why not as a fix?
> 
> Why would this be a fix? What is broken?

No, this is not a fix but a tiny enhancement. As far as I know no
existing devices actually require it.

Thanks.

-- 
Dmitry

