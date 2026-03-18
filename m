Return-Path: <netdev+bounces-268984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMiTIAKMumnSXgIAu9opvQ
	(envelope-from <netdev+bounces-268984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:26:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E51CA2BAC5B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE6843034C87
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7FF3A383E;
	Wed, 18 Mar 2026 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZSlP2F2+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D083A5E76
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833105; cv=none; b=VK3yK74ico2DBlseVuA/deipuYEjNy0uKhajVSH1AGdpfnRGXpBrNn+ahqEGdXrw8+m6Ovclx2sTdmbvYkK3XEsT4oo45hpOgmVS6IG4i2nmpT+OBV/DVS+6j3Bd9iEVjV7ZEhwaIa7p8LZ6Y2FNXuqIE81Ga1AESexg1ujXJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833105; c=relaxed/simple;
	bh=WkigAtS80jtn1MUI1TrupRSMGYxpWIhDzVxvw4bZqpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPjyBSVnimMFfIvs1TGewdtwqMAEPxeX2GBqF+F7mtRhul5JpDI62ztG2B0GB2UpUWieI/d9lBY3BKstPnX0s18JlK5rXHNYH1WkaV15yQdxe5yF13pODKs4ay02q1d6PnQB3HGS7F/XF/pl4YOCdCEwOfjP3k/KnEcUb9V6bu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZSlP2F2+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48541edecf9so73693075e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 04:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773833098; x=1774437898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WkigAtS80jtn1MUI1TrupRSMGYxpWIhDzVxvw4bZqpY=;
        b=ZSlP2F2+pMBxGEh4igAUEaME13j72KRa6VcW+Le5rP3c7ePAHL+r6BhVWljU/WAFQc
         RCFYSZYBLCyZozCFIIeISsbAv3pLG7Aqq08nN7K0HepEhnrxaq/GPRn3ieMb2jWFgNgZ
         wqR6jMYnmRSMAW5AmgmlG2Wj9qFulQGdnss6swmXkG/vL6D3m9HM+sm872q/+KRttUc5
         SGAykPPcYpJ3Qrn7hF6NUWbD9QdWqg6ChTkTqWWt1RVfERSUohwtOHFLAx4hYZ5p2LjU
         j95d3JLivyKeA5KA9L4cqnPPYpw1nUkPuouPYUI7EqMB9QMpK8BZ4NXQGdza09u1+zJF
         pISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773833098; x=1774437898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkigAtS80jtn1MUI1TrupRSMGYxpWIhDzVxvw4bZqpY=;
        b=Z2YUPK5ZSTqn/dfHu6Sv5Z/goEkHxIHH+KoexzI9HuZ0/a09suZBqRFm9q2FNjovzn
         pRm/lsrfSjGDX0Y1dQYz6aNSICcPHIXZbO+gf+5+u9gLQNgsud6Qe7Jm7j0ykjyjoqot
         qZvS9Mb7GUxd3C7eERCcNBD47MsTR05/PGrZnlXqh+G1KziBD/GqbQI7uY/btBT7aJp6
         r/hHlD0gGSBX+yCcttNafxo6VFbb72D5wa6kyHk349vm/glnWl+eCuclBmng0jkkKqRU
         lO71dAkZblgVxYeqx59FD3pdu0tZcre6knHXqhioA60Ta3AVSOOw8YQimsxCEv+sDXZS
         37oA==
X-Gm-Message-State: AOJu0YynMgMJOVefFj9e6Hxxuwfm5J3Yul266Tzdd14NIX2uSJF6xl72
	EL+9y6Vz4F8EtpLNdylurrw8YcfdUYKjYfFk/18VIDIifFsvwgWPwYRQQkIiYTtVU5+sG1ODjU3
	Z1++baZM=
X-Gm-Gg: ATEYQzwErba4lpU3UHs9ckbVSnnB1cDloHUsCcmwq6Qs6RYnllVBg+shgEydHCqTHHV
	XwO/HJ9zlkNCbrfI4Pp7oQfxuyEJTMFR7mCSFQ2C5ecAGuBrl5PDj6OG18FZsDdbbXS+rynDHqZ
	3oIivkAsrHmzR0iR8blAAmJHcWUbwmCEuUV6pNZZCsxitF2d84WRIKlKO3lao44VmXdgLN1n8Z1
	XdX/z9hc6CTMSKilDJpk/UCU1jpB6FaYNAcyEla4hNsuPO+nSDoJQwIiS8CLNU5SisZrncxpyrE
	sqikC85BdcFZ6NDDhk2TkarOfWMq8paCCBxm9YAUgjqmpR+LVwwVsMOSKUnFj7Om2tjC+yA1Ykc
	Po2C+ABkkz8YZ19DyqYuzKa8OOQzq/raSkBIhzMfK8pwKWZ63B+NL9AlPG4YpmYdiBteiYW61/A
	Uv2BempicDRRiHbnULWXkrCSpe52lbTs0oNR/yFOHVzg==
X-Received: by 2002:a05:600c:8b0a:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-486f44221f2mr50300795e9.10.1773833097843;
        Wed, 18 Mar 2026 04:24:57 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518986fcsm6652864f8f.26.2026.03.18.04.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 04:24:57 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:24:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] rtnetlink: count IFLA_INFO_SLAVE_KIND in
 if_nlmsg_size
Message-ID: <erokpau4aht5kczgttqm6orcnieh3frnklpwijhqagff6ty4y3@bnlx2wwbnpkb>
References: <cover.1773829376.git.sd@queasysnail.net>
 <52c1bac69cbbe82cfe0da2615d6a7f3f69254bb5.1773829376.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c1bac69cbbe82cfe0da2615d6a7f3f69254bb5.1773829376.git.sd@queasysnail.net>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-268984-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,queasysnail.net:email]
X-Rspamd-Queue-Id: E51CA2BAC5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Mar 18, 2026 at 11:45:53AM +0100, sd@queasysnail.net wrote:
>rtnl_link_get_slave_info_data_size counts IFLA_INFO_SLAVE_DATA, but
>rtnl_link_slave_info_fill adds both IFLA_INFO_SLAVE_DATA and
>IFLA_INFO_SLAVE_KIND.
>
>Fixes: ba7d49b1f0f8 ("rtnetlink: provide api for getting and setting slave info")
>Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks for the fix!

