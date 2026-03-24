Return-Path: <netdev+bounces-271044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFNOLgWGwmltegQAu9opvQ
	(envelope-from <netdev+bounces-271044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:39:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39A3086CF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0045308B3D5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF13FE656;
	Tue, 24 Mar 2026 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="g9/sGMhK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8803FA5EB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355482; cv=none; b=qiMi+9iNzUMdz6QDNwsImAO7vh+0396Yr+H7kDMhq2wU1BJPnetsV28Cb2soNIge28DJZ+dkC738apYKo165EbnDD6kAcbG2qSWi6ItDTA5zCUN4iu3uQQByIbEmklG9JBH1nVF8SBDv45v9IZ+xeNUiX7gPZg7n5vP2YutxoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355482; c=relaxed/simple;
	bh=DN9QG712RR6lTFc1B4cCoM2R5uHblNYBTpFN1+j7etg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsDoa+kg2zONbrQyN0srnqII/c5Dz1lmw8VxuxOuogPQYIUtoQhFYDgkTbOT+GlLDSRQ4QFBERISYJKtM/907vuLIm+wgTv16ixKIWgTtzwTMl26vUU5q/VryhoHoTn2FpS+Iz3u5S3/CIxItuTJR364f3tHmqiJcjxMD8/leLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=g9/sGMhK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48704db565eso30384145e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774355480; x=1774960280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DN9QG712RR6lTFc1B4cCoM2R5uHblNYBTpFN1+j7etg=;
        b=g9/sGMhK4PxQBq6SCuvkYj15QCLV5QnIw4wKP6O6qwYZwNDbFxFBU/oW2OgW8skjQh
         76BKsp1T4SnWWtLX4bx5B0A5tVMmLGmQR/9meT+HdW1bSF1owSH4TGy/5ogtZtrLSKM1
         Hvi5qPhaklLRIq/LGZeXBSWSDUP1Hl4xPBsomIEySKvC25f/FxqG6al1NzN0uNiHoevm
         oZQ2c4K2v+xA8K8/n/fteV6QaPZwIy/FX+kPyZgVf6ercjLXRa+Ldqxrh/9UZEQxQm1G
         4gd6Lpmi0bG441kmOWgaqXzZD0bK1FPrHcGWEc2WMtdBOgGGEFqUxeUItRIeSAvSEeFG
         Swfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355480; x=1774960280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DN9QG712RR6lTFc1B4cCoM2R5uHblNYBTpFN1+j7etg=;
        b=DLPvq+SnmTbX/j7qOKEQvivJcZJOaq1kqTo68UOmZx7zMeiUqqBCqQVZ48WLlw/K7q
         v0wHwbBAMxquZisQtCUHqmGoOY9pFw8yarpUVfPvDhR8tBvNJJqyuuyE42IlvK9sj9U7
         gugYRFHjIFW0dEBXDWHnmuHatn6PrxMJ9wOrTNpWiZWAt23wa7zG5pu9uZPwyFDJIWDE
         Q4v3DWU6VkFq9Tg4NHdy2gJrZgCxbyhMBGxDL69SdIzfywRGeRDpWZoyubc8EvLF1Nw9
         xxMOxzoyjID6Fq/qjjiXcz9l29oAYzjJvrmIayid+ztdJBnZbeeMHR5e0K0alduIX0Kg
         X1/g==
X-Gm-Message-State: AOJu0YzQmF9z9VfHK4H5Kdsy4tTR3Z8aGxlIUHv6BgbvVaenfByOr3mw
	73l/MaRQFR07yFnpr2Q8FxvHQzsNPadnwOObM2WSTHVdupIQWc1rin+59LkaYnT3FTA=
X-Gm-Gg: ATEYQzzSf599jLue+fJ8qVnzjRrgkkeivXyvMwh9WxlGBj8PCn660b/vsiYVF2fjtUg
	vLgUPLaOb0NXKvRy9PSTqDXgo1Yk3fko4wpiPN3fHBqQ24LofEdNEYAmDV/viyJeLqKTk4cVZyV
	qCVy90nZ2yF7BMYLtFVPh1eS3F3/xX5+YFg1IdRAKoYvNgv4CSgwUWcibnahGpUXPZB0JjgnVTk
	YGBwha1tJ8bLgFi7AvCNygUzOVeVxKn5jAdmkwtOcYJUuUCGqJPtrFWShQE0QSnlPGqvNRTkiWS
	IL6Ec3Oupjnc5Atufpk/myChRCeOhnLhE9PP5Ax7x97nJlzmw3WeCEavsNS+ZjId8pwTkBYDpyQ
	6PVH4EBZrsBWip3SJuFPgA/GERRU5ERVwp7gtDG2lpUMKwSpSOA6OWRtDrzgvoVk/nZJoEdz7Dm
	usOOogp9nU4sUzc4qZWwQzLACZAPMMn+vHM9BLU0mzvZLIKg==
X-Received: by 2002:a05:600c:8710:b0:485:35ba:1d81 with SMTP id 5b1f17b1804b1-486fee051camr217093495e9.21.1774355479578;
        Tue, 24 Mar 2026 05:31:19 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487117077cbsm45730395e9.6.2026.03.24.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:31:19 -0700 (PDT)
Date: Tue, 24 Mar 2026 13:31:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	Prathosh.Satish@microchip.com, ivecera@redhat.com, arkadiusz.kubalewski@intel.com, 
	vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2 net-next 2/8] dpll: allow registering FW-identified
 pin with a different DPLL
Message-ID: <4h6vp6vzu54okdnckxd52tg6oz3lhf3wy52xfkbluytc3gs6bn@dyu32dx4pnii>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
 <20260321222627.1193603-3-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321222627.1193603-3-grzegorz.nitka@intel.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271044-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,linux.dev,kernel.org,davemloft.net,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,resnulli-us.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 5C39A3086CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sat, Mar 21, 2026 at 11:26:21PM +0100, grzegorz.nitka@intel.com wrote:
>Relax the (module, clock_id) equality requirement when registering a
>pin identified by firmware (pin->fwnode). Some platforms associate a
>FW-described pin with a DPLL instance that differs from the pin's
>(module, clock_id) tuple. For such pins, permit registration without
>requiring the strict match. Non-FW pins still require equality.
>
>Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

