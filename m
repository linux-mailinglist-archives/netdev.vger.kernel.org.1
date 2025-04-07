Return-Path: <netdev+bounces-179572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDEEA7DAFF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1DA18899DD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493AA230BDA;
	Mon,  7 Apr 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="r1T/c85G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EACA920
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021436; cv=none; b=VzLTdOd1ejF6Q8FEQm/5gchg4I9I/Nf+YRHyNsq49hoN1gbp9ZHyNFmOipZixQAfP4V1LG6phkba+TkdOAm1hOdLBZA81viVuxlYK2+Y+ALjPWe6TjXzdBOk4KEr1VAx/ihPUIgI1DCQY6RKjLERd1c88Ahw2anZyfXFA2FhGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021436; c=relaxed/simple;
	bh=yA2pldDRfyq3TzSzuNn26G6TADLA9fd7bTTyaWZKJDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm9IDPR37a8HxazUq18fvhynMOTPfn3mZFs9qOnvmNbTThB6+a5bgdPZzCAvXINkNxEcUjU9SM6ZeBAAi56bV5Iuy2Wi+OUW6Gis9QGg7mwgXDv7mpjIqvgOj3bYf5ulwPuHz4BlQPrrXftNVzZeQU2dsuuISKYyMnfMoAW2kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=r1T/c85G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso41595795e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744021431; x=1744626231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yA2pldDRfyq3TzSzuNn26G6TADLA9fd7bTTyaWZKJDA=;
        b=r1T/c85G90I4nMvXd/eYemM7YSsyRSoz8l8TxdYkEOlCUo7MjrMGh3abjkZwjoCf+s
         jzLCjdoWYUgvaNKIEEfCMZ+WgYgimP+q+4TtxMqJFQw7RQfa//wxyAZYg5jVTbpJqqeS
         eQ1qSry25P0MmLvTCjPrkQ8ngvGei85Z68MNGxbQBJLayTnJIO2NfB7axFPTifBUFAGH
         CY7EbnX6uVKTjiwcu2s7TYRe4mpTRYiMHkyN47iw4qqjmaG2k4xLpHPGUuW2pqg4Jo4W
         vIqY8aaqT99KMx7RvKGs9bpvbgflJFHJuJlUccHCnwYjBVn1coyPIgtgu1cjLsiLhJkI
         PQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744021431; x=1744626231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA2pldDRfyq3TzSzuNn26G6TADLA9fd7bTTyaWZKJDA=;
        b=OdnMm4BO2uMSLRERnVQ7iFD8MBJ8sByldMrv4UzwxICNvthZBI6K3gvYGZIZimFioC
         TfubyjbBzEpVV3bd1d2OFPmgagWVje80USwtxobHxpW1xW8V8k0gpxBglts6doBI+scz
         4By0Q1J2CPdu5/EQ1VuBH27PJZkp3YZyifmlcfyGRr2G3sc2vlUOOGf6vSARAGs60MDY
         kYGAlr7YF3PKCHQrXYq/0V/47ZGPQr3VPjdD+PkgaxOeru62rlNkQ0zUtpgP8ZdcM2EC
         aIByns7kPGu5LiAytTnhJ73jYVJl7uG7BizX7hn6Ym/suLC/X2gRx7sWWgwiziDJ4ma1
         CMsw==
X-Forwarded-Encrypted: i=1; AJvYcCXgNUatnaJS3IzD0FRiNp1sl6a3hHCGN5UHdLKG9/HacEJxZ1R+xG8V+ea9ANMBaq0pNXcxtxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQl6L14ze5YNO0NI2y9Ed7v1YPCmCq7pTV0ItzSYtSalcQ0Dl
	5TSSXBHDljWiK50RRhlECXgM2tjGfI2Db99Zj33jZNsW+RMaMWUFbChWFc+w9jA=
X-Gm-Gg: ASbGnctYB8VZK+EN1WUhUyNVbtu3SaNR1fwZ0oL+vSeGyOQ4bMTG2disfE4dO/aPP2W
	8dufhE3iNZ6cweuMQU6AcYAZfwmMfEblrZSFyPH4Rkvip1zNg4JvNph5dkxZnvEDherODXWKsZ4
	w3unRZ+V7YEKO54OFSfg3yNfk63G6EVB/nxJhuaMzwLFZdOVZf/8Mhe1AZmNXEkGiHblOBOSkKH
	QOYd8CYEfsRHEUy+oEjpGx5EU8/PGFQKo/VJW/v4fFcdaBYr1XnQlV5AVebGpAruHkwpvMMKGwu
	j9mqwicG+rFabD5T2R1bANDvFLVJ+jTGsEL1iWfS1bUhkzfPMCUu
X-Google-Smtp-Source: AGHT+IHkDPMugDvDivRAy90+fG08jCXMlXjh7ZNxBKIwM7yJK2W30P08QYdhl0syGJDNl1euvgeCdA==
X-Received: by 2002:a05:600c:1d16:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-43ed0d98e7cmr94394565e9.22.1744021431207;
        Mon, 07 Apr 2025 03:23:51 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1662feesm127282655e9.12.2025.04.07.03.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:23:50 -0700 (PDT)
Date: Mon, 7 Apr 2025 12:23:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rocker: Simplify if condition in
 ofdpa_port_fdb()
Message-ID: <vumossr2v5hmwjxo5sdevqwkz3cwmorzw3f3pknibh3my42mmw@vhp4fdoq2h65>
References: <20250407091442.743478-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407091442.743478-1-thorsten.blum@linux.dev>

Mon, Apr 07, 2025 at 11:14:42AM +0200, thorsten.blum@linux.dev wrote:
>Remove the double negation and simplify the if condition.
>
>No functional changes intended.
>
>Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Why not.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

