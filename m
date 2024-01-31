Return-Path: <netdev+bounces-67499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64872843B16
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200EB28DBBB
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096C666B25;
	Wed, 31 Jan 2024 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MdxY/Ueh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F86350C
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693311; cv=none; b=YhbAeI4y7Bi907wIzMN//G1nmgignwasTeOcujGtHiX2IWbVJ2ji+sw3JY89fDIwXAinZ5tQa9FikOG5PlYtrkXyTjrm9Wv0M34wJ5xug4b1frA8kRV4KvHGOjRAq/jUzJk+0RCkAY16w5E2z96sc1faZOnWHFAs3H6vM7JkPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693311; c=relaxed/simple;
	bh=G+3RzESNcmAoi+uLGWx/knR8mgmMQGkRK1gayncsGk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm3gnRiXpRLET8fb8I8/AZKPGr4B8Ws5xhTRIA4l50l/Fef50oALAFI+AfL+PsTqq8HGGbojvUIgSl1NOljZlVQ4USVpeQ/KtLnr1cZMTtV+AhkyHtXoWEpfBAM9ubISI1/pxdnTs+wg9sudLfQnzqZpkWn00kcuC/vQtdlBkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MdxY/Ueh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ae42033e2so2989374f8f.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 01:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706693307; x=1707298107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+3RzESNcmAoi+uLGWx/knR8mgmMQGkRK1gayncsGk4=;
        b=MdxY/UehoFDwJ9VpZVKRFuHHPSl2r9+g4G0tEnKUSjZUKxEe2iie+ZzgPeQGd0urfp
         vwzseFTjYsGG1W32f1vPVYe5nL4jnRnxGz872/NClFn5eQV4MOnGsFPzJ1qU+744Yw+P
         NGNZ1VLANLlPar9pQiYlIA5lkHkZ41jBKawCx+NX3d7ceb1OJw0VlS15nmcAabh9YbJQ
         VXUSSNH8q0v+1BJXWavpT9/mzu70HTfsPMtAracSywNtd46m8y+iIW4lAPHLBIGZwGc9
         9OGwdnrjQ3bYIgQ0+wnlOOV82D5Sgvn6y+M5Nt1lPBm9qOHZyjbpKH9y0IEpR9QWnBty
         To2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693307; x=1707298107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+3RzESNcmAoi+uLGWx/knR8mgmMQGkRK1gayncsGk4=;
        b=EUjofvFHl/QAPxW4bqmLbZAonyRPdRy/5sO073v/xtUqtLfp/fHstQV2u31MaX+9dR
         aJuU2qtSSSlDoHCE+QxoPxGZXXn4yHF8w5j5y6013Hqa9TBRapp69ECDoHyakncwVmtP
         eM7u4CmsNJkCiVrjcUEoW6SzovlhN1fF5xtCBuWPAulsBdym1j5dx8ZY4Rc2FqqJxj06
         UPU57yRRlYeL6z+0IC2CIpvYjRioZtxGBp1f/EuCOsLSnurkxKQf2bwxN2tUf4rzrPoF
         WNAVcBvWaaog0hUPejwi1M1yJIiueEFIUzqmV6u5j4fodW4kmv0phw0eM1Nza/pg5hBy
         GMZg==
X-Gm-Message-State: AOJu0Yz0w9ZvdrFGRLregHiMIr4dldDcivP5DVo5cGRS2tI+xuEmOTqQ
	rvyRtqNG/deOlP/B4MgIhYaBl6jSae941iUqyT6L3pK+q9Y7uDT8/jVEXpSajZA=
X-Google-Smtp-Source: AGHT+IHJREvWSkK7ke44DI8zd9EkEPvAaSd5pDM7GQajqb40UB1rxg4O0ZA1wUumnKQwlKhYmNzXzw==
X-Received: by 2002:adf:a408:0:b0:33a:fcfc:d5d1 with SMTP id d8-20020adfa408000000b0033afcfcd5d1mr919635wra.69.1706693307033;
        Wed, 31 Jan 2024 01:28:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV02MuHgO1tzsSApXnXIHx6F8wDdgiFvo7azMzwLbnHcjKAWeZUbOsULEK6YjF/4XAgbe+2B7XtFPIGtgan6Nl/WYsxq9KXvET/uTmouwnYokJXpbm1Vy5WPdXQwekg1OdLUYHpSDJcMPz+2ncMNiJm4Mq10obYKbW8ox7av5alLGUsHFwdMqfk92h+qsXEFWCkYUyjnptqMKF4QtLBsBvL11ek/ET7e+8hIVKQEVolw1Q+DkAJ8PnLl5wJboSchoSOxw3/y/VdU2sHkR/4+t5N6tK5XiiN5I4Hj4OTD8ycRimOzoTZNUgYrWVCJ351km7o3MPZ/gM=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bj26-20020a0560001e1a00b0033ae6530969sm10191409wrb.85.2024.01.31.01.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:28:26 -0800 (PST)
Date: Wed, 31 Jan 2024 10:28:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sctp: Simplify the allocation of slab caches
Message-ID: <ZboStzDWAhuB-xTZ@nanopsycho>
References: <20240131084549.142595-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131084549.142595-1-chentao@kylinos.cn>

Wed, Jan 31, 2024 at 09:45:49AM CET, chentao@kylinos.cn wrote:
>commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
>introduces a new macro.
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

