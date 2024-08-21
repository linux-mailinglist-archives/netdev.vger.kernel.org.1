Return-Path: <netdev+bounces-120408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B409592EB
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 04:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E904728306B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 02:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F201E2AD31;
	Wed, 21 Aug 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikbjvzuD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0345038
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724207585; cv=none; b=Kbel4FDxGsujZeQ+MXL2rwmGlmSv3cAGlPTgabeduRX7Ak9v7046sihfAZT5PH51GUgniP/bxKOVYODUkh0Gatnp4UxGMVMZoqosDtbNLk96YxgKGin9AlJ66lCF5GQPFZ6pzry3dEoNaer50ZIdI6qIv69Bemh4AdLRSyNJ7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724207585; c=relaxed/simple;
	bh=oXUv1/HwUyIXHFGcnAp2K9/g7taXSeVN/mkf4gi0p8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0ZV+qdKKB+045C3uiz21gzGuds4UaaWv40uMPndUGrHzKmxlHVFxhCnMUZBiJFso5kzHY67NfmBVtGRgQZ5oaaBSCsIkQW5dJ9UADyN0/qOGJk0zVXMz14zQqVz7COenRRXjGkXPWzbu6gQL2Aj0Q3FQyXpdLHgLk7SI5/kjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikbjvzuD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70ea2f25bfaso4606840b3a.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 19:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724207584; x=1724812384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ljlgs2lWksxGBdCItxotoYcEGSPRb3zay8TR1Y09hBc=;
        b=ikbjvzuDJ3axMGJTcQatAVu7b7b6cYP5Ehy1EGM+h3DuPmGG2TPvjBQXEctX3n4f+M
         TYKHlPT7O5kQr9ukn59AL7gW6AKxXPRBl0x0DI6+pawyr+wD7nS8eze8g7t34VE8ks3V
         YBim95YRUAUDU6vTc93l27I1uxXA1H8i7ZIKJOwdEKOeH2AJoAd98rGGW/xXxTuiYnf9
         AP5G0Y+jL5GCa5noRABgssJsONYoYS6zlwQidFbBdplDMqKMmeZntxPcVbvIUK26F//Q
         9n+TNFR22tpyikA4phlJhGfr+Z5/sUDZFuZu3fev/Nyxnzh3GYnV2GhEUMuE0i+uxfUK
         08vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724207584; x=1724812384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ljlgs2lWksxGBdCItxotoYcEGSPRb3zay8TR1Y09hBc=;
        b=h7Vv5FwYPsHVSpKEdmIZJiTHEhIfGgIx8gKVa0HuWMQNNhJTmivytGYfFAMkaYC9eY
         bVeD6WFC+hbEq/lRCSCHgzsKjwwKgJmyhNw5JSRQQeisr2wk1HG74ylIjWOU4I7nawUF
         kOjIOQLonxwx6T9aquPoR45WD00O4VHHITs2EUDPlaP2TggAeAgSed7yq1irRM+vknUc
         WbgwCnm/cuQs2xKflZBBgc18zjgkOgU0CoOmGA8moCN/Q/XiI6NcqMbpoGX8xT0sRWv2
         kra4FciLgPus/UwliZUHvgI5HOOaVNP84M8KOfkCelQuWe49UzDjpsQWdD+P4RNKdg/O
         ttwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzuwPkS6xQitSffrS9maHADpUPrf1WJ9jRTmjvABp7ouFoSQ+KTnUI3PQwLlUzzOlxT9Byos0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoaRoz3cdU5UG+Bt9+LT01RKAZk6R2Es5UKrWrvSorAZgoyg7r
	LV147cHCg0+i3Bh2hSIyiDXdqwz1AHVTXR7gOHvB4S5RxzfifPNE
X-Google-Smtp-Source: AGHT+IGd8NHOivadxvB4dcEsbrxKxOfTwwXteNhY3MR9FdFzKVJBF7BfPs6T3U45QkR4GHHX+I3fLg==
X-Received: by 2002:a05:6a21:3995:b0:1c2:8d2f:65f4 with SMTP id adf61e73a8af0-1cad820689bmr1655109637.44.1724207583483;
        Tue, 20 Aug 2024 19:33:03 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038a836sm84364885ad.194.2024.08.20.19.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 19:33:03 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:32:54 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZsVR1otPt36kVv2E@Laptop-X1>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsS3Zh8bT-qc46s7@hog>

On Tue, Aug 20, 2024 at 05:33:58PM +0200, Sabrina Dubroca wrote:
> > +	if (!real_dev->xfrmdev_ops ||
> > +	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> > +		pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
> 
> xdo_dev_state_advance_esn is called on the receive path for every
> packet when ESN is enabled (xfrm_input -> xfrm_replay_advance ->
> xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this needs to
> be ratelimited.

You are right. Warn on adding/deleting is OK. But during packets receiving
we need to limit it.

> 
> 
> But this CB is required to make offload with ESN work. If it's not
> implemented on a lower device, I expect things will break. I wonder
> what the best behavior would be:
> 
>  - just warn (this patch) -- but things will break for users

I would prefer this way, which is what we do currently. The warn could
let user know the ESN is not supported. They should use ESN supported device
or disable it.

Thanks
Hangbin

