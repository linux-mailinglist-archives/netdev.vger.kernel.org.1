Return-Path: <netdev+bounces-264434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBrYLGSWqWnYAQEAu9opvQ
	(envelope-from <netdev+bounces-264434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:42:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2910E213B26
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88EAE3078F86
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F593A9636;
	Thu,  5 Mar 2026 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Qled2l47"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925D3A901C
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721625; cv=none; b=YbYDtV2hzoTPDiXMasWsOmxOjVbgIa4WfSW0mp5pQ8hxclffayYcRyFEfFTUPPO9s1eFZrQNkKXEqvahvEFd87PU1+4p9NKqFWXNX94BTdVyeeK/511JfGBIZT1ENNfz8nG4BINFSP+W2WJqtns2XhOikUktoA0zS2SUdcMS30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721625; c=relaxed/simple;
	bh=GzdrRV3jSJ/zZ1e738PNQWyueoRMAomGpWpecK6fHpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv2NLpPl00QtR4RCaCyi6kdXRb1DjHnm84VSi41KaqyHS3yffpBQQ7+VZOb3JYsE/mmQyaw8YrdwYnkkHYNKd2UMH0k0d3+WiFLTjNRnpyH2xFAdO/SKuE321kX0ABaDRJs1XP/V7jwCOS4Ys8diIZx65cze7JKrPBWqDWVBKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Qled2l47; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae527552acso16680225ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 06:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772721623; x=1773326423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzvwSp+J/sXpJ4omuzbLYqwo/49PuBoozjtLvyBYlac=;
        b=Qled2l47a8dDRYISNpcH1AzPWVT9/dTXT854dOUDtnGL0j+z+2U7izspzskx0DKsw+
         fZsuMa3FZynXRNKz6e2aRK/HNu3IAGfs+WOYzWlBCmHVatUl+hgQW9TqcPTMjU26EpPs
         aVg+vDVygcPH7fygMFlfYGl0NavWX5d+5DBEFuH12PatyOZhoy3stZBxPyBPtJWei+p/
         1XuGQOQbniXcXWYbxpR/SahFilBDcZEnnAIVTeJsvKF1IUEjrE8O12dvlx9jGlTadcQT
         M8FUlBbQPEcLFvWsIb4Ay+FPib9xBz5Fo+MhmrW5cNxxvE9zdSZyRiANIkn4ewuQAn4+
         8VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772721623; x=1773326423;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzvwSp+J/sXpJ4omuzbLYqwo/49PuBoozjtLvyBYlac=;
        b=osTin4P8QTDFuW9cQF5XB9emaZ3L1fgqYi5CqSWSPUKAfbs23ig6t2qkFjOXgXb/ri
         XuZxInJ9TkTjNfevbYxCio4QVNc4aVKXMuh05aWnaFcnH6/ERjkKjMjLvT2lXxg+1kO5
         DSPo1Pa30okgW9vG1ypjTS9bjL3JwuOiHzP5WKO2hQeYs4AzeSClJuuYWe7OrwSq97qa
         Zum39z5TqhSgodpk4EgTnCidKE13lPIoERSKjPDs5nl3kcRW2rvzU+XzLDL9BAOxg5gb
         OVG8OBIC4jFvAjaizBoYHSqTTKvpyicgzgAMbtawsipWKXfk/u+mVhss+EVNxvwo5f/5
         nsgw==
X-Forwarded-Encrypted: i=1; AJvYcCWFoHzrACh/QChkQHivUioprH6DuREVg5KrGEmvynyPw54C9kzRfrXFdxzjFEmT2m4KEH4eDi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxnSMiv4g+u6ueFbggNj1lKc2rMEjL3dLWN0tTtD6qm7/mAd3o
	seekHhp4p4t+4uiQ5gHlzP6BPWYZyDVSnpEVA6ApOhhJ6O6Rl8B2iD/wpoWAwKW89O4=
X-Gm-Gg: ATEYQzxgCnH9GyDFeev1Ade/45vBHwgLqh+JQv9L9Kdhj+ZZC5h+Ug/XNDzWNEwsZc9
	bnhVgLAaVQTK8/wNByhVv3rlVPdwsFc+zESKJEG1JHDB2McUO5O27zBof8obmFAa5V6VWvz6A8+
	w5sWOKyV21l78+mL7ompyf5rKtvwyrVsLmTVqN8s0bq2cp5QSUCGTl3yZs9mXn4noIDUzuMerZg
	iVq7jSz5EIty8DvH9eZKoj0/4j0U93lrMJeFFKNdggGnu5s3ZFapiRnloNjzcOJf7lCPj2SAUkr
	Yg++PNAZE1rLqvhgaWnmesMxcgVQ64/Xwe/T5WzRK1eEQQ7gzWgi/+LfZKpPN56r4MZlsGfV4VH
	wUcaXa6A2MQiVzeAfGSTiYLHxBPMFoLYB+jtFmBxqjKKclFvyVGgeIO0227ZO/2W2F7nfBSW957
	QsR8eEu30rG/F9KQ==
X-Received: by 2002:a17:902:f64d:b0:2ae:5598:1da8 with SMTP id d9443c01a7336-2ae6ab80a25mr57121095ad.57.1772721622971;
        Thu, 05 Mar 2026 06:40:22 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c183bsm234187105ad.24.2026.03.05.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:40:22 -0800 (PST)
Date: Thu, 5 Mar 2026 06:40:21 -0800
From: Joe Damato <joe@dama.to>
To: maximilianpezzullo@gmail.com
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] igb: fix typos in comments
Message-ID: <aamV1aAG1TKPKqkN@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, maximilianpezzullo@gmail.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-0-b6a9f1d336ff@gmail.com>
 <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-1-b6a9f1d336ff@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-1-b6a9f1d336ff@gmail.com>
X-Rspamd-Queue-Id: 2910E213B26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264434-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 08:21:19AM +0100, Maximilian Pezzullo via B4 Relay wrote:
> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> Fix spelling errors in code comments:
>  - e1000_nvm.c: 'likley' -> 'likely'
>  - e1000_mac.c: 'auto-negotitation' -> 'auto-negotiation'
>  - e1000_mbx.h: 'exra' -> 'extra'
>  - e1000_defines.h: 'Aserted' -> 'Asserted'
> 
> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_defines.h | 2 +-
>  drivers/net/ethernet/intel/igb/e1000_mac.c     | 2 +-
>  drivers/net/ethernet/intel/igb/e1000_mbx.h     | 2 +-
>  drivers/net/ethernet/intel/igb/e1000_nvm.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

