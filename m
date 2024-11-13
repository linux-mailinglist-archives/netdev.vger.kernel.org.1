Return-Path: <netdev+bounces-144611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED39C7EE4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C2F2829F1
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C018A6A0;
	Wed, 13 Nov 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR8WvcAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A23189B9C;
	Wed, 13 Nov 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541525; cv=none; b=KFEh9iULfwPQEC+bmt30uRsfF7ObVNhZyZZSMTU34hlQvAVcAoOtCCVU4ANAojxt7eed+mmi8LBkZzfe+/iJJvWxm0uWlImFi35DoJz+WHmI4ToZlDDaBDPIZgq3nrVcpPwZfkyUK73ISJOOJaUe3zrRXR/gyfBifewByP9bBtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541525; c=relaxed/simple;
	bh=IMLs9KkFJyVmaqboIlPs3BMwmi2roRZoyx89UzqtrmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMIUVWgrGbkJLroARIjo1c2WvPPs6UqTd56kC9ng3t01leyrImEFGW2KtVt/xz9VhM2zL7H1afR+AibGigWTiK2hSFV63J3jYQZn62bRj+IMCEqUXl4Gyrd5DwF6B6A2UdtW7uw91Q9JtiCGclqnqvS6qG5/YkT44ZPgR0vTnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TR8WvcAr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-211c1bd70f6so1559305ad.0;
        Wed, 13 Nov 2024 15:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731541523; x=1732146323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPhjZYx2OlODU8ortt8Hc7z2L46GX/Fo4s2RD5xLsck=;
        b=TR8WvcArnVsbU4uUoU1uCOctFolvp1PhAW61M2sGwQn8WtT9iOwaN9hieNuKFkVhqr
         vXZ1/YS80faWYCvGAsYKwBAWFVNDObp4sKyADBuHeNuQG7YrpUemsL3e4C/AulCBK3/8
         6HZ+tol7XQZ34h0iB6wAfd/W62RBTSlypABRI0n2sVTpGaO9LrnjYy9QecIZNBSCgzBA
         QZeSyGMADYDJkfXRZr8gdkaDCOtHLWbV/k3HU23GCHc4XZvl4ApP5E132u3rcccRlsdY
         MaFWDO9QCGgvVXvJBRSSKjsztO/0ZOJljBlV35bqujJYvQCOcv1tWkiLbF1xEt5IQ5CW
         1DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731541523; x=1732146323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPhjZYx2OlODU8ortt8Hc7z2L46GX/Fo4s2RD5xLsck=;
        b=nIlWSsbM7wgWjNkTcYK64zM2bP6ddDcLpLDOkhEpohTNHuKEbI1JE6LOzNQODZlEDb
         kEYJ3naMO8S+vrGnftgSne59ZIvs61L8Tl7W0WZjxdcHbd+wicTqXtXRbDvILo0GrS2X
         2ltsRev4tUQxPFZP/mku/rGvYf69E3q9bSubY/EZ9Lne6IiXpWrvUej0AbS/Cn8Vh+KD
         Ua+kBhlJd2eDWzVWcKTjejJV14iKEb4nFpyfx2fXiyL9v8kIV0A/fPamooQgVwIddaGy
         2eIX05GGT4/9+mSLdWfc3ItPVsYHuTPO3Fqqvk7zeNrV/nI8NEHy3FwBuBq1zFAhBb5+
         2VDA==
X-Forwarded-Encrypted: i=1; AJvYcCU/JYvbYu1L9U3PMA00/4N1D8UWY1N209V1a0H65iHfIzj7SJfextzydBGcK3Va9xkdQ2U2jZ8E@vger.kernel.org, AJvYcCVy6C98zN318/Qzq2mnWYVPCKYcQR84OuNtrWAuVhruUXkcROKifsNhLa18uiJXOb1BPlbFd1X9BT4Vjp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOOpNZtXiRb0uKwcOSl7jnUh2fS3QpHzMm3VarRm1HJwgVLbY
	yHn7lw4O+iquy8Ds2BJWWXb9cLptVCSWOWTJNCVCPBr9isfxOG2kqAqUYmY=
X-Google-Smtp-Source: AGHT+IEajxRUkO1UyL3U8M/8qPWXdxrU0BaLKFEqOTc3kGL63whDsaluZ5UTUVrgobe1KIrM/gKqUg==
X-Received: by 2002:a17:903:1c3:b0:20b:723a:cba1 with SMTP id d9443c01a7336-211c0f0a026mr17257635ad.1.1731541523039;
        Wed, 13 Nov 2024 15:45:23 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a187f4sm14243854b3a.144.2024.11.13.15.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 15:45:22 -0800 (PST)
Date: Wed, 13 Nov 2024 15:45:21 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	donald.hunter@gmail.com, andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 3/7] ynl: support directional specs in
 ynl-gen-c.py
Message-ID: <ZzU6ET2KV-D9Av0a@mini-arch>
References: <20241113181023.2030098-1-sdf@fomichev.me>
 <20241113181023.2030098-4-sdf@fomichev.me>
 <20241113121256.506c6100@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113121256.506c6100@kernel.org>

On 11/13, Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 10:10:19 -0800 Stanislav Fomichev wrote:
> > -    supported_models = ['unified']
> > -    if args.mode in ['user', 'kernel']:
> > -        supported_models += ['directional']
> > -    if parsed.msg_id_model not in supported_models:
> > -        print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
> > -        os.sys.exit(1)
> 
> Don't we still need to validate that it's one of the two options?

I removed it because I'm assuming only two modes exist (and we support
them both now). Are you suggesting it's better to future-proof it and
still keep the check in case we add some new modes in the future? (or
running against some rogue specs?)

