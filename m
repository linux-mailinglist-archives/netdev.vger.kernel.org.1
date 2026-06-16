Return-Path: <netdev+bounces-299777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XRnjMfwMMWpoawUAu9opvQ
	(envelope-from <netdev+bounces-299777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:44:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D9C68D446
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:44:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=q9oqV193;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299777-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299777-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B885300C0DF
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3034030AD0A;
	Tue, 16 Jun 2026 08:44:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51440E8E5
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 08:44:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599482; cv=none; b=NnMs01xnAQ88WimxfRYdgnnEbgZ50qVmIUK53n1FS6uyj7H4aQzYoyBHoz2qy4fIfjgyDTAlmMAXVtwof0oKrR2fANbnIYwspYpe1JMujxm6Mx4PnPJ6Lu1NUDmHZPFXSxfuEW5oPXlh/NaUVeHpzkHSvNOzdzWMvtoff+YKr4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599482; c=relaxed/simple;
	bh=gg7rTUPNLZTVrrfv2XgfdECYmR6PfJK49KGSdjpT9gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0aPPmlJmMC9zIYDwJmGYf7n2a2EdfaBCH0DlhqJv8yOxahh276TYIPxMQ2pUu1iRannmkAdJQ1jM7M8NSYGBDmfQ4BAL8skpnPlQ85tAN+pP0sWfPuLffchTKuGfpF1wMD25nckWfaIsjlDHtJji8Qef2SPOe7e4R+x+a9f4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=q9oqV193; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso2220137f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781599475; x=1782204275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gg7rTUPNLZTVrrfv2XgfdECYmR6PfJK49KGSdjpT9gc=;
        b=q9oqV193vKXHXh4xedW3ZrChBc3nMC4u8KxhpgZp7XKkbeWctPR9e3x0W09zjSYuQu
         SGI4Thddt0Kr/cTBN9BtxII5YPTwdcNJ8pJ0zcd9SrD+3m5dOkM5N27SQLZA53shl/EC
         YfVZApiCI91SdhipsCIt/7LGLi2ml5+ZL6dQCe4Af7IkmKdsjoYsm1OTED6VnognJ3/4
         kEUKcy3aHRa5Xo6wEp0EwJqP1tqKSHm/8aw+KNepXvp8n1I0BfEHMZxZR0llkCqVKeTV
         3SwvUvlYQhRvQHyMqROzqKwOiRG79NWvXx540UoZCP2aOI9JcowKzEKmGnXeG0qF5UF4
         ok6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781599475; x=1782204275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg7rTUPNLZTVrrfv2XgfdECYmR6PfJK49KGSdjpT9gc=;
        b=gan88zr5CMMbdqgrhS3PeixOgN9UBFBj2qP+wzHdJmv/xHM//2idoKJcpH4hiCXKVR
         MGJB0bY4qP5lmPCJnzEhty+tzRh9hn/Zfejtk/i0yebjZtp6k7IALOnFhN1HNyLdBjI2
         ohn0qxi+P70Nlw6ZSVV95X/iqJXY8MB990EjGqV46M5HLE0qqmbjbdtI2chryoj5tYkD
         wZ3ugICd5iEiO/8wHNUUo8eHO4y0jFsnKIFwOqAIbe4/MZ744ZMg4arvZJQ8vVYJTfnZ
         +sPLh/L3vDYR11aYPxpQWO/+dbDLXf/A77cdu3Cpru0v1165x1i3kM6EoPbuznTIXe/I
         /GIg==
X-Forwarded-Encrypted: i=1; AFNElJ8EbtIylfVet8wzLRrLxY710uOPwGVIp3NiTB+bl2uopWr3F6Fx0kxsJQU2S0oW89OYVScm8k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYR75pOwvUb/fzCp7NFklAEhhb/gmD4UbLrNfEVjpx+RYIEDqv
	nyy3yJ0j3eExw/HmbawTIhD6Oo5rwuk263pQuhO7aPtMgcP1JtTD28GfNEbRf1Mdk9E=
X-Gm-Gg: Acq92OGPPS/7mjH/131y+a3yZOQSOjPkVRrV/n0Do7DqvmDWkRcC4MWUD4FGf9wRqBh
	yxnS5Uj55U4XG96sAlWJdt2YuWRlD5hrK5u/cY9n0Vt9Jrwcvv5egUiaC7CE8j6HhU8IKxaLaVo
	cFDY/m4Lw6vqywdIPGQgwsLp2bA1JwwkYsUe9uF2xS1l3yW0OJq9G1f96qU6xWaaUHmkbD1y2g6
	kPk3iP25uXhbbbFWQuHD2XrzWfgBHY4NaR8STmFUDI35E2lNRAGGR/ddjmSRYzTt26ZomElS2XU
	+ipOrmOEhLrE/XpfsSVOmDFK+EM8cNdB/Q8Mu+wVapSep42zjR23Qou0MdT+sKODCkRYpsILhax
	zvqtZ9DKSXhoQTAmTysBP/65asKpZo0kSvwG87qsTr9NXScMKnw5xKq3edaS/aXj+kcN5zPOOLe
	3CMBvxtSvMk3D+U6J4r0lqWMjrqQ8HBj8=
X-Received: by 2002:a05:6000:1787:b0:45e:73b3:4515 with SMTP id ffacd0b85a97d-46074b87912mr19780266f8f.35.1781599474732;
        Tue, 16 Jun 2026 01:44:34 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f3dcsm40146140f8f.13.2026.06.16.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 01:44:34 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:44:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Weiming Shi <bestswngs@gmail.com>, yotam.gi@gmail.com, jhs@mojatatu.com
Subject: Re: [PATCH net] net: psample: fix info leak in PSAMPLE_ATTR_DATA
Message-ID: <ajEM5EOOZhcGP2ah@FV6GYCPJ69>
References: <20260616003046.1099490-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616003046.1099490-1-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299777-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bestswngs@gmail.com,m:yotam.gi@gmail.com,m:jhs@mojatatu.com,m:andrew@lunn.ch,m:yotamgi@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,mojatatu.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,FV6GYCPJ69:mid,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3D9C68D446

Tue, Jun 16, 2026 at 02:30:46AM +0200, kuba@kernel.org wrote:
>psample open codes nla_put() presumably to avoid wiping
>the data with 0s just to override it with packet data.
>This open coding is missing clearing the pad, however,
>each netlink attr is padded to 4B and data_len may
>not be divisible by 4B.
>
>Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
>Reported-by: Weiming Shi <bestswngs@gmail.com>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

