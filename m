Return-Path: <netdev+bounces-163224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8286A299D4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB216188160E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D0D1FF5FF;
	Wed,  5 Feb 2025 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="J6FNVC2A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34B1D86F7
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782721; cv=none; b=X1wllgleET4kn48gSejzdDT9eC93OYK6L6DaTyfjIwXKGrhiGEyA9qzGBQHyWsx3E7yeS5Zb0RSGxDWe746ir4WxXuEcch1r5kDbrx2pY/dXWN33D+PQe7TaWM/Kht6rYNG1DirtYvAadIYxBpAoPcr7eTWdHrVsJ93JQ2AdRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782721; c=relaxed/simple;
	bh=ahVt8nDfUz+XpTW0caq/I/kRRTZior/H7Zt9IrUB05I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8MvcGHNJKz0+SxXcPY791s/jnfodl1wZf1hPoGyyMQHQO37FGiS7nPteX6P4rrgzOKtMctj0Kqy6E92yoG1ZW9H0V/rvPFrdN03fN4GhLxAsspJsG6k6xrJ6CD643w662J6aeJY7A6cJklPkna9bthAkz/biMv0DJYMKKscFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=J6FNVC2A; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f301269cdso1099675ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 11:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738782719; x=1739387519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNceWuHxVHP10FvK7+0u+5/nQJsP7cLB5a60cYUAF7M=;
        b=J6FNVC2AsjBZ9ehfNmsT38n6MDMcBII9OOLrZMgGYCicHwwIV/3fYCLTCLCVv19tT8
         25k8Wf3D8jHXgX4QHoNknX0XDZwKpyvl9IapDYskf5PrbaXcNn5JmDgqfxNhbHxOr3eh
         25jD8Xysijv/sPfi09pfOjEanNWfU+/nD0Hiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782719; x=1739387519;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNceWuHxVHP10FvK7+0u+5/nQJsP7cLB5a60cYUAF7M=;
        b=LdVU7GiDmAYK4xenC51ghK4NDoa5CitCB5FoI2qQCfvccAUX4T+/MqFYAInurCiTRz
         jTHRzt4P0z0vgCDiXc4bSGOgSXm6vEdY+/RPXC7wXR/vqFfIse/AbtAua5AD+Crs+HE+
         WyElqqLNOupeQcqCFeJfMG1cDwWc9MEMVDtMWU+cSgfOK3r2512dyRBu24JM4Y3XbZnE
         SAwMAaSMAtHqUpMvf16aBCASeD234nIdk4lE+pk1MhxBTlIQdZL9uNgn+VnMuTLnJhC1
         W2jW9KUR1qmNKGd/mJUWcuTTyvyLezBzRh4hy3eP+MqYN4t4OYJxcvjb1HIF54iSi/jw
         5gKw==
X-Gm-Message-State: AOJu0Yzs9rRgoTmDoRZMZFzsMNWF3KT6rhcdcm0xzx36l8AFbBEcFYqc
	JJQ2JHgYqVfQ8XW1hqO8FPNgkmtUevso0ee+QhXbFJ4odqrMHV5OHbMEQRUTB8dI1RgxiQfJxGR
	xTea/JHA6354G9/8LfRbvnCrqkHWgBHwsmXgkW5ADIWdzfm5HOCvYevsV7NHzhEz+WP+3Hb144b
	iMkpyHpP/o/ZDc1vQqIs8faZkQxOUzvWXJnAM=
X-Gm-Gg: ASbGnctdzNJx8XgTgg3/81clLo4AqGTltgiRbCuB7VNwpTAZFFyo+2XGwlioEWdxKQL
	qrLcGj7haQuMRiXoq364YPI9STcDHROhQ/mRgmW8wbiwEN1HVKZJ5gW5ipMroNrUxSQNs82fmLL
	HhA6F1PlMSMWryPm+fGM1zOixRm9Vj+bFGCzTFi1hMYNoRJycdMYTviplKuXI15C9rrC8JrB6Ku
	9wCwv9ORnh6IzDQkIYu4AsEoJlHaJcsepKwyrpHfJ9LEzy+uAomkByYsxunpg9/fwNZqt52dcjQ
	jg7cePnBuOZgfrid6tRvnhZKgEba5JUw7idNl1Y5zGZEOO1EtrIltmmxTQ==
X-Google-Smtp-Source: AGHT+IFYOundQisslmRmdQ5tay+inwk4vtVKmQvFOxokjjtp7IdQ8m0WxGdwfmWxDxVWILErH5utPA==
X-Received: by 2002:a17:902:d4cd:b0:212:55c0:7e80 with SMTP id d9443c01a7336-21f17dfa16cmr68725365ad.20.1738782718643;
        Wed, 05 Feb 2025 11:11:58 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1dbfda0sm1958799a91.48.2025.02.05.11.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:11:58 -0800 (PST)
Date: Wed, 5 Feb 2025 11:11:55 -0800
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, edumazet@google.com, sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] netdev-genl: Elide napi_id when not present
Message-ID: <Z6O3-1rZm8wBazxG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, sridhar.samudrala@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20250204192724.199209-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204192724.199209-1-jdamato@fastly.com>

On Tue, Feb 04, 2025 at 07:27:21PM +0000, Joe Damato wrote:
> There are at least two cases where napi_id may not present and the
> napi_id should be elided:
> 
> 1. Queues could be created, but napi_enable may not have been called
>    yet. In this case, there may be a NAPI but it may not have an ID and
>    output of a napi_id should be elided.
> 
> 2. TX-only NAPIs currently do not have NAPI IDs. If a TX queue happens
>    to be linked with a TX-only NAPI, elide the NAPI ID from the netlink
>    output as a NAPI ID of 0 is not useful for users.

[...]

>  		binding = rxq->mp_params.mp_priv;
> @@ -397,8 +403,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>  		break;
>  	case NETDEV_QUEUE_TYPE_TX:
>  		txq = netdev_get_tx_queue(netdev, q_idx);
> -		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> -					     txq->napi->napi_id))
> +		if (nla_put_napi_id(rsp, rxq->napi))

Err, looks like a typo. Sorry about that, will fix in v4.

--
pw-bot: cr

