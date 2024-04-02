Return-Path: <netdev+bounces-83988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E683A8952E1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B201C2031A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B78E76C61;
	Tue,  2 Apr 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wbnCOW35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29303762DC
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060659; cv=none; b=TpszAP1QD8rICB+BmibdzYrSJ0eQphmPvTOCe4bh7mzso7BdbsFJrDesRt9LbdkKK6/pHnG1mG4ad/fdojAZGJI5gX/TXcCZph37eB0AbZh7HJaLAtbfhy4/R91+2QHkmYO/bl5YslirCzlg3KYSJZR8AG2nPJwFq4alS16DJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060659; c=relaxed/simple;
	bh=3Yx2WU38zBqZR6fVpKCHz9BjSc8HGKkvHIEw+bGwOKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKauno4r2V9hbU90TGVPbFuDbyO+rZrHGyPlZxVZpohiI6z3mD5emtL4FcGztzJoYhKP0bLhdGWrAuNYDg5xNeXIMhel8hzkoGgIMFABuJhJwnRZ9EJf1OlljD8+iPGX1upMFtepzzi2JGwlpEd3aAaV9XXz1SuJJUivui9dgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wbnCOW35; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3434275ad73so1042168f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712060655; x=1712665455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Yx2WU38zBqZR6fVpKCHz9BjSc8HGKkvHIEw+bGwOKQ=;
        b=wbnCOW35VEAKhrxP7T2eqlXzRfBXOi4oLnVM3XSa8BDW3Peh0vWLrlAP9taSvmj33j
         tDFbPcJOCW0Y+IewaLlXHt6d5wB2o1Tby5gNUh5dKL7+od2VBYyHWyKD7FYVEdWv6srF
         gzjWEm2tGJEPBkfrfB2JDuzBmkwap/EwKkwcR74go4DhWeqHynZxskem82FiXBftlEkU
         tTh6FyijFI7cuglx2zfzNJ6FVuW+m9LzWT4E2Xwzx/8g6LMla4rJGJtNZKW8yihfd0l2
         jFgX3eefwdr9AfLJPFUSwXf2p6nHwJVwR3NkOq4vEhtpNw0CAmIdqenpCrekeBSdNGXL
         t9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060655; x=1712665455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Yx2WU38zBqZR6fVpKCHz9BjSc8HGKkvHIEw+bGwOKQ=;
        b=GKmDimFGATmhzNWOdiQmwr7TZfR1FiFYfyC85gZlBSGivkn7zcP94SxaYn/tX/moZO
         FCv9z5ySu+oNP+RVBm2OOkuzol2PsqIpd4UPfx6w6gp3US1AXN/3HW7CCwkDLDkFUmZc
         /Gq07TX4GzQn0ubL4fQ5w/7nq2SViAJAhv799Oj786O1/qAjljnRD5PQ0cHYD3ScDZRa
         mD1BCwP2D6OqoojM02dMgfKxfkBjC6j+Q3CM1hTZJjMLlM2i62I7vf1FP4jqR8XHdc1R
         7zNVDdkHogB8ATCg84k8zBlKTLwalPv4ns04gZHszvKQJz6SvcB3M8EnN6RUgnYH+OTl
         sMAg==
X-Gm-Message-State: AOJu0Yx5bC/mqnd4oZy3HcxugLZlLo6qlkUd0cwPNhtXzuQyBmIafPTH
	Tdg/9031C4P48E+5fNyQ9AepYb+Z2UTm2KlZnxYphbGGz0yvkrsS3ZFe6ioaePA=
X-Google-Smtp-Source: AGHT+IFfvxQsv1O9kQqfuFGdD1RTAzn0+0x2zEa2enP74TS88Fu4q1NGma++wIQrVaQbeshWwnQyBg==
X-Received: by 2002:a5d:4a41:0:b0:341:cf18:70b3 with SMTP id v1-20020a5d4a41000000b00341cf1870b3mr10654947wrs.27.1712060655392;
        Tue, 02 Apr 2024 05:24:15 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600003ca00b00341c563aacbsm14334732wrg.1.2024.04.02.05.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:24:14 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:24:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv4 net-next 4/4] uapi: team: use header file generated
 from YAML spec
Message-ID: <Zgv46wXhLer9Whbg@nanopsycho>
References: <20240401031004.1159713-1-liuhangbin@gmail.com>
 <20240401031004.1159713-5-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401031004.1159713-5-liuhangbin@gmail.com>

Mon, Apr 01, 2024 at 05:10:04AM CEST, liuhangbin@gmail.com wrote:
>generated with:
>
> $ ./tools/net/ynl/ynl-gen-c.py --mode uapi \
> > --spec Documentation/netlink/specs/team.yaml \
> > --header -o include/uapi/linux/if_team.h
>
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

