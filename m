Return-Path: <netdev+bounces-210985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4544B16049
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C67C189B54F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641EF27AC34;
	Wed, 30 Jul 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FiD+E6mi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C73156C6A
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878380; cv=none; b=HegJWpUf9RHO1vvI5wWyOUWvz6T+Hi/SaiiOiHUo1Vf2mkoSOAjd8/1kRl7TD0EiBfg334dTPtDbBlpb66mjRL52078fbiQ2DrSKIvt35H/yIS+ShZ+lOXVQcX/sec7W6dX74qlXB1EExAW+DQ9wvquy/gC3N3ioaxhVRGxxfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878380; c=relaxed/simple;
	bh=+LP51TJm8dISaosFKCpGTh4TYAMN3Q+nI+H4aWw5P+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/kAOMM1M9HUGkBbkDwd59kMrffHQfz0gnsE4wXhLxtYqXYlQOlmngYoA8HujEOUsqv1LwgAo8NASpjcCPKGHa61Z8LISsKPAcYlGXsmu51fiG2kN+jUalfHdmomaDmju0qtW/WoS60jAZ4RQdjX9jPVbYlRNmSwfpcrk3AnR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FiD+E6mi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae36e88a5daso1399053666b.1
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753878376; x=1754483176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LP51TJm8dISaosFKCpGTh4TYAMN3Q+nI+H4aWw5P+0=;
        b=FiD+E6miVc2QmDKAHSNYy+zSYbj9gf9IFsRvQdWiOxYkUW3CHfYPscxz+PoVWU4l7R
         qeVVTOMgSLvY4oFXEqM63gQUcojbCNzwX0ghvC6hCtWnDdrGQkHmYLaM04oidOKgOHiG
         BOwztpdtra6jyBnLCOLS+N/TVpuWKYf9Iu+NdS3jbK8SVlDUm0TXAoNaCdRNq6BCIvaQ
         uW+2oIc3B7HA2GteQG4aKkrm3ECIDKfP+B2gBdzbmOWoBRAPmiKppCE9DbDGxLI/7voC
         U7DlVzkc1vsXkJyzifJLWsK65xNc9Y4ON/We+2A8Ngv0hSCVMlwWGgyzMVJZWca+BYhH
         NCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753878376; x=1754483176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LP51TJm8dISaosFKCpGTh4TYAMN3Q+nI+H4aWw5P+0=;
        b=R6aeOhd6VSDk7xqxqSrnf1MuCjHzhGbvLS6WYafPhuM4xXXyUl8nVuJwXksp0RJLLc
         s7yHQ/7YiBWrJZuJifqNioR75TB0RJSWtnO+6B0EyzkiVR0hhrFWHeMK9JOr2LlAtbzs
         uNJv9MEXrkVmM0aEHa1A9CMbTD1y9HJJOIIlHtQ9iLAFs8xio9BVmi2d13+HZi+aGL7K
         RWnBIXY+lGWPfjlEnbNAVjIMZ+T3N2YR+hvdMQfBgTkfPHntR52x9KeWK59mjAqqhr40
         bqaOnC7RisMu31OwtCZZN9TWkeic28pq9hAJ3CrPWZpMRjMcsg0g+PdV6u2qARPpv8k2
         lBVA==
X-Forwarded-Encrypted: i=1; AJvYcCUx+jWUz7AFLbLNu4ZZia96PZXp9SWH8+tvdMmul06I8sT43Eq5qdsRNn6WDfO18EZE1jYzWEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIWVadd9M61UoIXYgmiSrFNcfiylBKTBcfTrCgctbTrbaueSD
	X2agfOj9aDJNNBHEQb+mgK06/323FjokpEs/HChIKJcCwRTor6RGe0444Gabd/NptjE=
X-Gm-Gg: ASbGnctuZVkLzXh38vACDRVmYEa2B/KamwMvGokwiuHVr0GekGF/b8B+fnjfmS4l36j
	j/6/n8TyE626ASq7lHhb82Mo59u0WvG3BHtzyoAaYTH7FQmBkKsIEvY2NLrifYyGvFW55qpbWcX
	ab87t7SHuT7SRUW6mDCnY43Ft+fpZMv5NTdUka2BUYLKpD2kJZRIr4Q1DoFIgidPgAuV0C261n6
	Pp//OZMcoLZagEgVAMXuCl3hKIBRJGL+xc3AmdzJ4p7WfZhbsvkR6TIbCYoBfGaJqIQThHKdlhK
	y6fAAT4dkyma6ygHr3D6qHQYQX2gh1wP4wy25z09C4UKsAC32/AlUu0Ld4NFfMMOfzg4dKOBUp8
	x5EMrkB61x3nelitB1yyCdzvdo9l+p4WHTw==
X-Google-Smtp-Source: AGHT+IHKmQuJBcyurJqjso+EQtT2hv+uRozjr/hSsB9kfXnfZX4KNBg+3NUqbOWeTkLYA6c562pzyA==
X-Received: by 2002:a17:907:e849:b0:ae3:7b53:31bd with SMTP id a640c23a62f3a-af8fd97316emr411726166b.28.1753878376235;
        Wed, 30 Jul 2025 05:26:16 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63586008dsm741418566b.16.2025.07.30.05.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 05:26:15 -0700 (PDT)
Date: Wed, 30 Jul 2025 14:26:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, almasrymina@google.com, 
	asml.silence@gmail.com, leitao@debian.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] net: add net-device TX clock source selection
 framework
Message-ID: <p4tnkuf3zh7ja45d4y2pas6fj6epbqdqdqtfai2vmyul3n43lf@v3e5dvvbphiv>
References: <20250729104528.1984928-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729104528.1984928-1-arkadiusz.kubalewski@intel.com>

Tue, Jul 29, 2025 at 12:45:28PM +0200, arkadiusz.kubalewski@intel.com wrote:

[...]

>User interface:
>- Read /sys/class/net/<device>/tx_clk/<clock_name> to get status (0/1)
>- Write "1" to switch to that clock source

I wonder, if someone invented a time machine and sent me back to 2005...

[...]

