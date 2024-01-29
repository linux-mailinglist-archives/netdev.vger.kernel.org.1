Return-Path: <netdev+bounces-66672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C711A84039D
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754E91F237C7
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD2455E7B;
	Mon, 29 Jan 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BUcj9eY0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC395D73B
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526923; cv=none; b=fC4A6J1sMRe43DFf/yA6cW59HwXDADeNaqN2fWqnXwWJf1KSh3INfIvz+cNd9SiPGwQxAecofKaePpt3CakYiWPs1OZXEs8oJhBnd4znb83pLamGs5xslN8zY1AXD3Bp01upzYy5CW3+wZbD9PiFaEhd+bbfC9XuTJB1dz0dMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526923; c=relaxed/simple;
	bh=BX+rM/qqL4vIeqR3QjUC9mp02kK27G6nZaH0PvsbrPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2n57Kw5iDQC6kHZ489z8oxX6XqA0sHjDxtu2Mma3f/YXHVXyhwl/S5EjByQxKIRyJBnPAZuBTCo/64syczqmBIubFhUj8dCx5O7YRLJepvXjJ739mPNiCeQYxMqD/Mws3yd4dA7a2xUPzckqwK/CIXn2r4wiLUO7uTX6vweaAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BUcj9eY0; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so27702571fa.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 03:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706526914; x=1707131714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BX+rM/qqL4vIeqR3QjUC9mp02kK27G6nZaH0PvsbrPE=;
        b=BUcj9eY0QOKlKsynzXj8Oqm4fpVc4qeJ8uGmO1l+Ql/HW9abjYjqK2uGSxJV//llfH
         ai1HtqQwvpWfVSQoz3Wkzuti6Nn/TdH0mzUh37/9jlapoKuBe//sOZgSGP2IhIajFe5c
         Zdzpm8b+EG5VoefzMa54nnZgMlVMC0rWJVw2x5+LV5op2K3bU4fe6At1/MSGCQHY+CHC
         ikLgmFEkDhTHT2cCyNQe7XnTw5XOulnObISlHhxxkx/uDb99+opZ+2Gnqj9JosL6io0V
         hXWQXVibBgvgDGnoeLzJxhfcPxG5QUl2Jey9I101ZFYUv+0A8BFwmdvw7dQQj8zf6Wo3
         UvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526914; x=1707131714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX+rM/qqL4vIeqR3QjUC9mp02kK27G6nZaH0PvsbrPE=;
        b=qQAKLuSU4xOiP1BfREOY+ucMV/hpDDCCzB428DzkqTT8aItVBVi+kewtBA8k9X5ebe
         nzaY8PJJFltIke/ta2wp4iT43unlEPvmmGmX07oeguJ3KzP+STNSxhHRF4ixLZfaKIfU
         OuBKqHfPeaNeA50I8CzRyCQL/EgmBZbgwbBdyQcU4vBaYQNCce1YkzushDjSXiXZWlBO
         7almxCgicI47m2T0oA1cFcKBznGT5eQtc+9V/DUq2AcrUCVoliV6XLJHLmCSKMZzwbSP
         wUUQkpcjYIuxwNd3WMsrs+8ke1ybz9V/1KNwZJHtY8eon+bxhC2byDMdHdRcPhxf1Sj8
         h0lw==
X-Gm-Message-State: AOJu0Yx50tQfAWcqI3CTub7glktEMTNwonD2Fk1vrw5H8JEBzY8/DZOm
	lvMJtFefAuKtqZQZW7PyPQ8irCKw8BMBpUpaB0BNRhmsyPlq2vIPzw3ttg84j24=
X-Google-Smtp-Source: AGHT+IGlfjiorTwBhnEiGcg3aEyvGBzs8JLaYRKd7UVnt6zICUeQgTWLolxYuanLO4n24b8Oa/mWTg==
X-Received: by 2002:a2e:b172:0:b0:2cf:14ce:e101 with SMTP id a18-20020a2eb172000000b002cf14cee101mr3399777ljm.34.1706526913459;
        Mon, 29 Jan 2024 03:15:13 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d69d2000000b003393457afc2sm7769546wrw.95.2024.01.29.03.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:15:12 -0800 (PST)
Date: Mon, 29 Jan 2024 12:15:10 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, daniel@iogearbox.net, lucien.xin@gmail.com,
	johannes.berg@intel.com
Subject: Re: [PATCH net-next] net: free altname using an RCU callback
Message-ID: <ZbeIvuPJi6K5aUF0@nanopsycho>
References: <20240126201449.2904078-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126201449.2904078-1-kuba@kernel.org>

Fri, Jan 26, 2024 at 09:14:49PM CET, kuba@kernel.org wrote:
>We had to add another synchronize_rcu() in recent fix.
>Bite the bullet and add an rcu_head to netdev_name_node,
>free from RCU.
>
>Note that name_node does not hold any reference on dev
>to which it points, but there must be a synchronize_rcu()
>on device removal path, so we should be fine.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Looks good to me.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

