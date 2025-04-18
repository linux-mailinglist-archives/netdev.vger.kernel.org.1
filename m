Return-Path: <netdev+bounces-184125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E17A93640
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361104462EF
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB422741C2;
	Fri, 18 Apr 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV4+2HSK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCCC274FE7
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974008; cv=none; b=XVAcmQ7Rt7Ib0US/qdZ4EaTUXL2bYy7SJ+DYXXJjJbZGc/wYlA6SxWtGLm1QA0aVzIF0u+TL11oFYB/R98+zAW6kmERGNjBTrylhpuOvh+DClDT+r5pX2cyHp7Rd9YyNDe/SeOkdTgt8Da4IZbGcDkCgnt1P4T/pYb9i/EIvj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974008; c=relaxed/simple;
	bh=TjdBeVSZHqls4A5Itu22IjukyIERvamlV8dQT3jXZH4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=jluLSE+/H0Z9ctGbQ3888IkjIxhMdvvlxJY/QVxQ3TuykrRJqtM1tMxUJ/VHVIdnVfZNI1pUfBhnNpiR8fAKAUD/Sxgw9gD9Egl7WPDRQRzpirI4T5sDArHrw+ScyZC25EXfDS/32PVw8J11KmugGMtpVhuUGs7EmM/KaZW2nT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV4+2HSK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so1174962f8f.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744974005; x=1745578805; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjdBeVSZHqls4A5Itu22IjukyIERvamlV8dQT3jXZH4=;
        b=cV4+2HSKagu76EgrNs5Fg4v7WTR/P66+05j8ANA0MM4e6e5rnUiHIfqkc9LCuwmi9V
         jV5c8BCFXb0t2BUD63gQnAdDsoOVZXU7lxfT+AcDaxngYZXjX1SlU//dtFiESDcQlPCk
         TMtoZ02BBd6E3SgaCGKTEEYLNiql3m5DypDVgl3YXdASZSijq8xKLeHJtFYtzelpuknI
         uDqXb4AFFb/10tRbQXQvU/8S6FO6Nl794BTV2Rth9957/HqKmZJj6B53seeAXuUHUEs/
         OVKLUVz/9Ewxro4hRC0uRIU6nRwstijko0MDuHuW95zvP+xgRfGaQ8n79r1Vun8t24Hk
         04jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974005; x=1745578805;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjdBeVSZHqls4A5Itu22IjukyIERvamlV8dQT3jXZH4=;
        b=bCYEX7AtsCusY+Or9igIpatQQQ1L80uliR5h4NuULFkbfRztpqnMWSYhQpYyBRKyu3
         P1yhUo02FmFTVQmo+H3iQFZvhYeIT9+sfGTp2VoXSsp/MkZItYvx2RFn3ZqinqsJI6dG
         l54FUtCxVr4E1XXRXOtSJ0dFHYn6vx+DjAKOi+0f0figuRVAt1QiNiZxSAC0eepFumbl
         r63uHjrldSSdNVLpp6DsvrQhY0VrJ0IA58FZpAhL/bIX8dh4jG6Lk+Jx9acIMg1+ToW+
         97IJi35qnbnmrRVVwQ5/GYJ4kbdhJiYG57x7sZaAOY6b43DRuqArTmrhswqOFac3F0Bm
         CwMA==
X-Forwarded-Encrypted: i=1; AJvYcCWUC+CiRl/jJaxNcsnkOHpXbe/+F95OKiSSsQ7VOhwy2ypkhjM0L9j5/R75FPZFcxuuh9r9qu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3C+wXwZGCaxWe+9EmhIcmzCPGYbtoV/TSsjZX0kZzAWMIU0SD
	rEEPtf4IqdoHwdfsUCuFSamg1DlSncS9BQTQo2HUpzlwBN/PDVlLmkS4ww==
X-Gm-Gg: ASbGnctt+rBiys8NjnP/X4d6UJPJH3egY19GRRNLcTqqPD90SIjHfqhYgONTDKQwRIx
	gHHcHWVNALAzoHWXhTUyN8HNm0u24jHB+33s9IUpZnabTVkHwtXEYtGSuQV56MtOMviyusjfgFg
	OykhRb577RKmO4PPHZfq1lviQRKlQo3/lbdfPGl9J1c1W0UmkDUacpTMItwOlfxVZMisKsLrSUq
	1RiJAkdu2oGFIburPXvWFJiQCTjlW7l5bxgOJbolvXkYVOtAvQLM++nhOkftok/pjlXPBnJqCnl
	jFs+G23ep6xIrRt8wBOTZVPuLJMA549fC2Kzv5pnYNcW3S+qczf8hU6l8RU=
X-Google-Smtp-Source: AGHT+IGR0iDPQ3a00Y5O5mY956YIzyqsQAVg6OdLE/AKrF2CpBCTGI1OY67g4Rhnt7kAMAd472H12w==
X-Received: by 2002:a5d:5985:0:b0:391:1222:b444 with SMTP id ffacd0b85a97d-39efba5299fmr1772717f8f.20.1744974004818;
        Fri, 18 Apr 2025 04:00:04 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4331a9sm2468683f8f.36.2025.04.18.04.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:00:04 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 08/12] netlink: specs: rt-link: add
 notification for newlink
In-Reply-To: <20250418021706.1967583-9-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:17:02 -0700")
Date: Fri, 18 Apr 2025 11:41:41 +0100
Message-ID: <m2fri5iwey.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-9-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add a notification entry for netlink so that we can test ntf handling

nit: newlink

> in classic netlink and C.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

