Return-Path: <netdev+bounces-269175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE5FEnsEu2kgeQIAu9opvQ
	(envelope-from <netdev+bounces-269175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:00:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4EC2C249F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F8F312D302
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F673F074F;
	Wed, 18 Mar 2026 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="NKxEdFkT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC13F7AB0
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863970; cv=none; b=UdPmkw5RvGQESn941Mm6lXvCiQwNalduX44G4hp3lMVnciB3ASC2SH1F6oKgG+JF6Seqxrte8fctsPnmd0c+xAvVYDDBT1SesAigljS+/hUVxEsdtmSltUDbnCZd4B5rzEZrWF3wkdC9/e3YnbqfSBMM4j4XZzcCzC2gnMtISrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863970; c=relaxed/simple;
	bh=NZ3PBpsnrH4qUDFs7WceuUl2eSG0ZkYxfsfNf15lXQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPk54VkZd14jTuLC5tnXP51bNakj6KR/CGc8SRrl/BIuLD1SzZg00DOLbOz02jj62pEX/adNnq90o0evCXJYomdwppa1CGBLXDFrYJhxW6fIgvE9ms04XAglg2PR+V5jNu0j2bs9naT6Au5hkeIddJWVmw1a5F98+SN+yn16vA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=NKxEdFkT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab077e3f32so786425ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773863968; x=1774468768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RRIku9+PwTbeMsmT5ylT4j/s+JyJ/D73WDIA3s+HOI=;
        b=NKxEdFkTbuT106OKV5f0H/TpvqzgTQvUn0PuJ1z+yB/sJuUdgupfc+FgMF0oz312rh
         DlwCKpYiM8vlaeoFanHP/dKex9qCNgGCUWaK+oF7ygczC8iaql6Qr+B9u96VhRdA8sSp
         O6NKt/RTVszwqcOJP0MFqCwCOQsHDqvwIyt+I4JvEUA6ZrHa2FucU1jQdrvXL2wJIJa3
         2SdvpiH1+p/zsJJHEH6QMvnlonoyx0tnyeB88S9jfftoTwKeqLRxc1h2aiabLNA+OkXf
         IJiNJKChljxWVMyquN8t8zFkdcuXnE1Digas3QNLtDvzIbSHiotK6joKU0ASk3kPZT0I
         SCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773863968; x=1774468768;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RRIku9+PwTbeMsmT5ylT4j/s+JyJ/D73WDIA3s+HOI=;
        b=A/POzDYqpRbKRkMpKg7VpZNz18uu/UdR6Cjm3NVToZcl5X4b9kwWNMMdbZvYps84OF
         YAokXmsSceIBmxB/voBhUv/TTGlnZjmX+64zOdKVpKgENm6zDOwHwm82mNcmBbRP5lUK
         l90WVotfuXQASEeDnGkr6UlbDjCzKiR8TaS9PNGVauqGLAh2L0NrVuyrFx1QC2ZQwIaf
         dwANfFJjgvSyRK0tRhqQMm6y9ny/SoPe39NClYlA7XhVjK0yYOkkRO7EWNshJBkhmxdD
         910EajtqAytUdlpgxYTQ9SzuYR+xTGOHf8TlMNg1Aq1I9us768i5kD1qXL5Us73uvevv
         mDjw==
X-Gm-Message-State: AOJu0YzGkmT5Q1nPsOdxGSKWIvt7qZxaLJKbW16DXY85KDxn3pVuaOWO
	AmFAaqzUl/5rEN9GzwvImnZq9m8K+DHVT1/HzPCRllzFskJQsoFa32UAodO4M3Xuou8=
X-Gm-Gg: ATEYQzxav8wb8VTOtk4+GSScgJvuiPW71Jf6FcUHX9hRcQVqehCRawH7dUBBfCz6JQi
	3gM48VOeFyWbiThvYcVqcQNQkGNF5wW9NIlH3JEWJDQh93DPgMqyMe4aNlK1U9PgOBwjU3hDcou
	CiLL7evx38tqlINlkeMvfO2/efbOtPxd4/k5/3BwIT44hJq01FEckkm5h1v3Yu7vwfeZLcPzMEf
	oWcG1AhKJXThipvenKNEIy2olAv4KH9pM/AmglOyhsePcqzS5evTjRh9KXGwZVY5GKui5csosIf
	oTSkvo271siSQOuudKREogsUEmqpr/XqM5Y1EqeUSWlxameQqb5h09DR72z8Yhq5nj+hBxe4laY
	OHSzrcnDTJ3uBsDW9kBDKJASbYhVz5/qAw807Ynubs6MNL8mUubPslS2QJ/gHCu8NnfRkmkCLDS
	vqg3E=
X-Received: by 2002:a17:902:da81:b0:2b0:7026:24c2 with SMTP id d9443c01a7336-2b0702627c2mr38006925ad.36.1773863967809;
        Wed, 18 Mar 2026 12:59:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e605108sm47248665ad.60.2026.03.18.12.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:59:26 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:59:25 -0700
From: Joe Damato <joe@dama.to>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net-next v5 01/11] net: ngbe: remove
 netdev->ethtool->wol_enabled setting
Message-ID: <absEHbnLK+k0Bmps@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>
References: <20260317073827.4300-1-jiawenwu@trustnetic.com>
 <20260317073827.4300-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317073827.4300-2-jiawenwu@trustnetic.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269175-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.971];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,trustnetic.com:email,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 9F4EC2C249F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:38:17PM +0800, Jiawen Wu wrote:
> netdev->ethtool->wol_enabled is set in ethtool core code, so remove the
> redundant setting in ngbe_set_wol().
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

