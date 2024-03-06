Return-Path: <netdev+bounces-77971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127A8873AA2
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CF5283BAE
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98E134733;
	Wed,  6 Mar 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="klx0W1/5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF6131E4B
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738743; cv=none; b=fCd49q0jK0zS0KxHUTVdn5O9csTvdkA7P2k6PtIivsVslei+IQL0METo6n/cVwNvOpK0AGq++KylSEo2FcNufQmpCGp26cckIpg64FlVho2n+0sSFjEyU4nL0Ky6yZ/GzmK9bUBArLqKUL0ax1M+D/s81jPsDt5p0FgbZGI4HZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738743; c=relaxed/simple;
	bh=oOtHYr2Eyt041TkFpTgH7RlHgJIKFbcRLDUz9Den9Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRi0G1X7qJ+VF8Czn13RPMjKNZN/MJauwjMnhSIQD79Nvqm+SBK6/CbRnGsK2Za1IuYmhHq9ztPbfLBb4y2c7EQlfS9D/FgUfMX5cjGgJHJzMrzjOmUuh46miQqLwA5kf7fGVPuEWRWthftZcIKbBxH6R2bmer5u51cYQjVS9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=klx0W1/5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33da51fd636so3792863f8f.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709738739; x=1710343539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOtHYr2Eyt041TkFpTgH7RlHgJIKFbcRLDUz9Den9Ug=;
        b=klx0W1/5Dokk3bFUh76jXcOxLS6+V0bCV1XL1GPETJnAmwFmaWM3umKEWso2JyrgYr
         EtwGmDZUjvBpaJdwARFQBISRhyi9TzquZpcrKDBACV7GrzIjFDp6H3oiqGP8N/O/mt49
         BWKd+NRGwmMsn74Laejo/Gr/sEzgPJVrf4OGhLF82LgjB0rOkT2wGUAaRJQYnC/4Jn8N
         v4vN7JYGRkHVtmuWDaB/pkjlMN4ByPtw2311m4drZo9zhsupg9mJzHMNiZLtO5Z0IPrn
         8DJy+RdWcjZxnKbM3UyJIqTT/EccwBMt7LZwB1hb/sB2zzFdTbP09yAa++ZNbU8Gk+Cm
         wwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709738739; x=1710343539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOtHYr2Eyt041TkFpTgH7RlHgJIKFbcRLDUz9Den9Ug=;
        b=Mhf2Bz7Fdo3R3S1sJqSCAo5yc0bmoki+FnI3M0ReR/x2tbUBChUDh7tcBNKT62sGve
         HC16Wzslo2R89ENy5iRGlL6cUhrVayvC7I5bud7xwUGReuI6CZILk6Lfr8LI7UozyC8p
         hBUdRVE/4Q2+GACWZQPb5wcmBQoDDPxHW++OL0dmBv2MVhmp0Zv+D7psmO2vwHJTKXuA
         ITDj0See1b8TEIl+GGvLDGtuNYEczsX5aPNpgbFGluzDTBjpM4Vl1yxQ/pOyIeO3aiTO
         XGh0Ag7H9ps9dvMmZKosLf3OYt+Ssh8idDxpI80L2Xpco4z8pGZLfIn4CM2vK3XCM3Jc
         9sXA==
X-Gm-Message-State: AOJu0YzWdZhq1I+nk3tO/bXxxR4j2gOp4nCDZ3was4mz+hDoViY34NT7
	3grjLMBaieSiA5La1762/AG0hcxO4+kVezKRX9WyNOj3Dte3eQ+h1Oqx++jvbbiIe2RAnNRSgPN
	z
X-Google-Smtp-Source: AGHT+IH/iz3S2HxHo8Tgs2qMofZI393AmB7cOp61sqROHmlvR0c/c1WSK+regY5KJAcSjMaIraLgsA==
X-Received: by 2002:adf:eb4c:0:b0:33d:eec0:c5 with SMTP id u12-20020adfeb4c000000b0033deec000c5mr9812581wrn.9.1709738738919;
        Wed, 06 Mar 2024 07:25:38 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033e052be14fsm17795707wrw.98.2024.03.06.07.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:25:38 -0800 (PST)
Date: Wed, 6 Mar 2024 16:25:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev
Subject: Re: [patch net-next] dpll: spec: use proper enum for pin
 capabilities attribute
Message-ID: <ZeiK7gDRUZYA8378@nanopsycho>
References: <20240306120739.1447621-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306120739.1447621-1-jiri@resnulli.us>

Wed, Mar 06, 2024 at 01:07:39PM CET, jiri@resnulli.us wrote:
>From: Jiri Pirko <jiri@nvidia.com>
>
>The enum is defined, however the pin capabilities attribute does
>refer to it. Add this missing enum field.
>
>This fixes ynl cli output:
>
>Example current output:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-get --json '{"id": 0}'
>{'capabilities': 4,
> ...
>Example new output:
>$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-get --json '{"id": 0}'
>{'capabilities': {'state-can-change'},
> ...
>
>Fixes: 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML")
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Note that netdev/cc_maintainers fails as I didn't cc michal.michalik@intel.com
on purpose, as the address bounces.

Btw, do we have a way to ignore such ccs? .get_maintainer.ignore looks
like a good candidate, but is it okay to put closed emails there?

