Return-Path: <netdev+bounces-180750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0D8A8254D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CB18C04C4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF3F263F38;
	Wed,  9 Apr 2025 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auREJMEC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC0262804
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203074; cv=none; b=i6GpbQdY6Zwyj2ebZbVojochSGsltmOJSCFwQSIVcOxiiyf5dvkgSJJ4L2+MOsCCMK8RtecX5Ym12iqqKldmP+/sWMJ9NZzg7Cep0gTyIs02bCv1Z92RmYGuH5uAFTcMRHAWQWRmcAwMnNumdAOuQMXjp/8N8z3TKztjNG9azDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203074; c=relaxed/simple;
	bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ow9gxqOE4gG5lhhCvzu3p/aAP2vn1p8l2G24ufDJqW5iCEpkGIV7+PWUUDYk6FYFzTzvVFXKLW1M37TWewepHFb6gziy+7TV8qCfi77gRMNbhfmrBv8YMG7HX4DXlknZ5v0kkVtUq01FlcCGpfcfAimTDyE46T8rJIe9Xr0wEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auREJMEC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so66108085e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203071; x=1744807871; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
        b=auREJMECQtqf1/83R5cECQS5xcItchS6jd1EYnYa/ekbs+ZEmszwt+TGqQSCefEMWY
         OswcBbGkzvyyCk7WP8TcLvzzomQbGGEcLHNSZ422ht72KtmrqJFsBeM+xf0ws3gmCqM8
         tv75J9XljJEm5lQJZY51MC9JB6BZ78FyWzJCM9g2LdbimuGCE/bzcnO5TTcie726/3vt
         14A2mOUThJXzE0/njCusQh7nQx/6M3EEVUAn6AqrP0Ca4GKREuXo2gxxFDxaE7Fh2JSp
         rDpTupcpo8Y0B+zyHTE4dakCxr2eUFDe5RTojCJzNHKzypVkp9qJoc1xul0tPzOcFIGd
         267A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203071; x=1744807871;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
        b=Nk2L47XtyDvQJFBZ2whoYdjVYWmuPAdL7illChaC3qmT1sIv87z5k+JVie2lLdFY4Z
         h/LPfeTMZzKCu8q8KlaYNqZBe2kSFxeMMoUtd1L4452GzUOyPX8x82ojwWoEC+ywUboP
         psLPzK01zqse/XTJNjr6y6+zNPCNMWnav+EHTuWyi+qKYdnBjNGT+vSUvXYsX/jrU82l
         IXqaBAue7wbAbIAoWiZN68kJ1y3BKxLWLETho2vYcESw5kBw3c9gse4gV0LblVS+6LEj
         8nAMzeQJxxby1VNKIJXHXLJnlZufptM71Clqk3Pw8bKlF0xPdzFFruSCXugYk/qXcVI/
         bu3w==
X-Forwarded-Encrypted: i=1; AJvYcCWDBzoanw8zt7alWEEpvr0Y8BdnL1la/vxFeP+W0FH9VAPDpaLbM3jGvDQtxI0CA/I88vU05nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgaR8rWVJzdtwzu68iwJFg7sdIzn1H3Iu4RggKryW0zHHLtt5I
	zOmbVz8B4+afpuKGHHPoVI2oxrCaDsSaiEWv2tQNmp10oB1ZEnPV
X-Gm-Gg: ASbGncsDbwmnigp3Mu798/WDlqB9B3WiuCgQblLV5P9kpMf3+B1OqPsywTDaQaMh8RA
	RpTQhSarEf+QEUzIeXjeI9eglTEJH5dR4VA/fQYGgJ8V7SLBeiePZwPI1ok6Xabrvx9NUsnU/Tz
	ywzoN4432Yw0DxeIEAO1YkMmuZbB3AFMcQowVTkagdwy6ELaHNhPNTgxRoEhbQuRWT2e+yD/cot
	fQOYyperNC6g/mrBW4FY0YkwpuMqukujzW7TheKaCi0JUspRWDPhf2toOaX2UiZBTN+KrMWz25T
	CF+SdCyTBvlLI0F30hdR6Qq5eYHDlsVJZ+aNL33r3qeKhO1e/z/wYw==
X-Google-Smtp-Source: AGHT+IHiLOdVSMtvpoIKuA4uYVgqm9B21pOt6s3pXBFiKpXW+FKGIUGQm7soMz6urQ6FxpUMenmjpg==
X-Received: by 2002:a05:6000:4021:b0:391:3124:f287 with SMTP id ffacd0b85a97d-39d88530c09mr2385792f8f.16.1744203070981;
        Wed, 09 Apr 2025 05:51:10 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:2c7c:6d5e:c9f5:9db1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89377394sm1559598f8f.29.2025.04.09.05.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 05:51:10 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  yuyanghuang@google.com,  sdf@fomichev.me,
  gnault@redhat.com,  nicolas.dichtel@6wind.com,  petrm@nvidia.com
Subject: Re: [PATCH net-next 05/13] netlink: specs: rt-addr: add C naming info
In-Reply-To: <20250409000400.492371-6-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 8 Apr 2025 17:03:52 -0700")
Date: Wed, 09 Apr 2025 13:21:21 +0100
Message-ID: <m2o6x534qm.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-6-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add properties needed for C codegen to match names with uAPI headers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

