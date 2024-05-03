Return-Path: <netdev+bounces-93251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712D8BABB5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 13:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFFA1F21DAD
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F915219D;
	Fri,  3 May 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XizIh0rW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F41E898
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736287; cv=none; b=ejZzw/RaxkYVbqTOuzFAt7eBWNoLvQZPCrpUlPdSWOUIvzWUNBOKIu7Aq0imEcyyJWbxTJSKFTcIiXqdHRyf8CKmdKXbzCOak+zYcblvyAFQWkvHXzL6W/km39uNBI2ET+7Z/oo9X2lGx7ewQ641svS6J9V5pol4m/oP4fnhYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736287; c=relaxed/simple;
	bh=2mFwIyJjhlyZVBLu3QUcc225c9YGrTsjtcIlVVK9h4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOajeLaAffWkdt2vBcJsmW1g1FjpSBy3ZD+xbbRNgLpoqlldJw/5V5RiO8wtEKy6LHK7+Zn+Ukm7kscaxCpRtSIJTNo3+caIPk4h1hQAiQgz3hrSyvqL1VCM6jzD8KvUJRVfPK4Fr9UQyKnrcWlwVPokVtDZF2r0V3jyJNXyY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XizIh0rW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b79451153so56109145e9.2
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714736285; x=1715341085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLQCofPdnJ63uOr5tDqjn2YZWUonrylBn211XOLOE44=;
        b=XizIh0rWMaGtGbkF5dUoT3wX2ZbEhrBEWDLxu3KA74Dk8WkpGgqsXSvlCyRaq/SPnt
         d2cpaOkZSUR/Y6M8KTAo4H4nFmQBQNbghTM3aHNeGjZYm/A+OvMbDdBviW1gMr+zoZT4
         MrSlqRIu1K4zbOHpHU4ThYpHfSzncy1vqlKvwNL3RMTzk92J7lMrPl+hU3kDn34AFaXz
         FF0Y29A3ouZjpLFvDHwHbVseEbC1RZLgYQXisZjmhqSh9NMmQsmbtt1q/65KFVfZffml
         xalTMZ40rCcRN3QURAgeb5tt8CkVZmJprGW/5YBwD+glgRqaCWeU7m070tevUbfVwk5V
         iqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714736285; x=1715341085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLQCofPdnJ63uOr5tDqjn2YZWUonrylBn211XOLOE44=;
        b=BP1/u4qUaoZj2xdsAkurMPpQPnC71qThhs+mmIF6F67koGZvNxCJkZWiviLKngSJ+X
         6GgZU7awsM+AZbdH7wGihm1jNmAGHNXjFuenesmmaMxa5+E4fUdzv9dqfBGQSykvyU70
         jfEIxK6s50WbUiN0bA5m1iMC9dYT9ZuH0d6Viou1cCOK20MpaB5OG2ZCnDy26PB6aSFe
         ekl5TMK2ztQN8QZFnROwyhiu+c258rM3FHuKXM9/JH8qYrrC0moWbG5V5J/JwS/b8eg2
         YT1gtC/OGMv3wNMwdbk7vFcUFscjl1BZYBc8tdDgQfRicHB2RLUO96Bq0+KJPlkERNZo
         tpKg==
X-Forwarded-Encrypted: i=1; AJvYcCVq2wslQv3YUk9YspEQ2TTpJ+ITvtnp4ONHAO7oqWQzs6dii7FbUY7m8ko4P8aHeEljjYHviCJMQSDIu3EIdiLPHqX6V2Bs
X-Gm-Message-State: AOJu0YxQyvifNZ9CFnS8uFmbH6UHf7T2Wprmq+10HYRcB0I+zs9RK1rF
	M8m9Zd1G2YqHQcQij0KoivIAoUn89x0R0JHh5YSt/kTOBxMrpbx/Nm4pPHMJJCI=
X-Google-Smtp-Source: AGHT+IEUFq74MPGIgnW3XCqkUsaInfSWPvUq0gwS1ToGTdl+wAiuIT9mb9JtsW4g2vBgPQlcLO6dgw==
X-Received: by 2002:a05:600c:4fc3:b0:41a:ff7d:2473 with SMTP id o3-20020a05600c4fc300b0041aff7d2473mr1857856wmq.4.1714736284563;
        Fri, 03 May 2024 04:38:04 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b004190d7126c0sm9131680wmf.38.2024.05.03.04.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 04:38:04 -0700 (PDT)
Date: Fri, 3 May 2024 14:38:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	=?iso-8859-1?Q?J=F6rg?= Reuter <jreuter@yaina.de>,
	Paolo Abeni <pabeni@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Lars Kellogg-Stedman <lars@oddbit.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 2/2] ax25: fix potential reference counting leak
 in ax25_addr_ax25dev
Message-ID: <e471ec93-6182-4af0-9584-a35e2680c66d@moroto.mountain>
References: <cover.1714690906.git.duoming@zju.edu.cn>
 <74e840d98f2bfc79c6059993b2fc1ed3888faba4.1714690906.git.duoming@zju.edu.cn>
 <6eac7fc4-9ade-41bb-a861-d7f339b388f6@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eac7fc4-9ade-41bb-a861-d7f339b388f6@web.de>

Yeah, it's true that we should delete the curly braces around the if
block.  Otherwise checkpatch.pl -f will complain.

The commit message is fine as-is.  Please stop nit-picking.

regards,
dan carpenter


