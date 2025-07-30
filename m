Return-Path: <netdev+bounces-211085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CFDB1685D
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 23:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4E856360F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 21:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6821A453;
	Wed, 30 Jul 2025 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXgFv6Z0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AFA5383
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753911653; cv=none; b=isIulgACDX/hWYuJajDQY1RocbJPlmmjOlf2cPoa23QaZGdOXAsDKZHCmJ/LM0eWdHgnnl7Lbv5WGFoSgqI1ZlAkeCKOsfGE1ixFzboegZx3oaXshgCSYRaJF86P02hs/69GbwdKRczqx/CxpZzlp9k3KcB0JRtPgCCFAlSHiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753911653; c=relaxed/simple;
	bh=hrctL3rfwGFC9lmvsd7yb9ciHAQV/fGK6srOWlRmUYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv8CaW3PX9QqhZ8IdZXiSB3z1C6dS6qogHWNlZ9/y8Z4KfMBIGcYyFZ9kM52l4bJgOXVGwl88I9nDr+teNWNQ1iOup+JtrQz+1DXGITP8eR7xOVzxo8eY1w3IEqye2xTgrivfKxt/nLUGZlh+4VSkkQWCy8DRIDBV2Fm6MjHw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXgFv6Z0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76858e9e48aso250316b3a.2
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753911651; x=1754516451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHrU2q1H+9h2K0oK/YdoOrFRWBv/4RJHFAbAcktsXeo=;
        b=dXgFv6Z0IhVMrHqNbaqI8n6QTPsbBVXLSGNRviNZTP8F9fK0fCFWuv//I/aVd/3Q0N
         vlLBh+uh6dHO29imZ0XbqWQieXUdZ/aQil8u9kUdE2UWabCY/nJDP5f3+hSRUqtAcaHf
         oF768IC1PocT2cHt66zuGrIauLAv+4cqKD4FF36OGt+cCdfpy7IWRMuBXnQqwL7KuFnc
         w15udFv97bk3UVdmaHJ7Zxc2lZPqtoqbT99r0sw//HNLxam+KG8MAraMgw3YA4onPwLM
         KGHndJxcKwplQpTQygaIGYIYidtpTsL2C6YztFbcr4VesPQqPL/TNMhABmyVGe1tWSS0
         SWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753911651; x=1754516451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHrU2q1H+9h2K0oK/YdoOrFRWBv/4RJHFAbAcktsXeo=;
        b=o7PoUQXobM5BBw0jqOTlHPfCftxIM+3qCMQxatVcVT1BDrVY3kVdhguBKWEQ55tjkm
         HzMhieURW9SPzzGxjCWplXjGz2ZgC31H0FiR62CbASgFssjFEDeaWu1cA4H8SMNHi7Rn
         4sYtmTRgPAz+lEmzE7QzKYSwXxTMsppyI9+4vnFxL2VnYv6KH5Bw0HwA8X2cuCzS5jc/
         9/OAJMtC2mP0oo4xrulrB8ipkuKmVyL/zCF22JpX14c47VWTza3Euoq3dGnGcqVSi5RI
         AFI+9el6CGnAffSfVyld/e14eVf01DZIr6ENGxn0P/jjrHX5LNNq/y/GXKqqHDPizIUv
         8Pow==
X-Forwarded-Encrypted: i=1; AJvYcCX4uV5/6ydTFeBW6y+qT57RlEr/GNVAwYJXJkr4pYfGtbajTnoovvVryyKoVj9oaXTZeE3/fVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCAc0fGoE8zl0okZDIqCzGWgWuIIu+rntfn//GxL8DP505iFUh
	EbxP6B85ls5fBoroJMpdxcrq9U8QWS1Pa4CStxLCwj+xwNH9RR1R7aY=
X-Gm-Gg: ASbGncsf972p0UyAedEtR8w3fnT8210igFJN+Z2Fwj+HRvf3UN7sXOkTwBrruI5iC+7
	sgmGudz6RBAPlNk5y0x454dmwRnWc6gogfEScPDfX5pHNbaG8Qe0pPNg6utHyEN29VU/lxrGe7l
	rYvvBqefgHBKeWSekUBtJHRHqahf108gcjxo/6hTmQ/DdFzW97B6WPaSIDSl3fVkAYrUVxa2faG
	V0GIrTHD3Zc5NEpKPiLDm5AvERSzy923nYucu1XJ+OVFp+SmVhwr87jsxBy015K37RG3lrB9GwA
	lz2ISmn0JOktUOIVg7uRpctiXfN3OrM9LDG4AL7F4u20JEa1561XM6zs2k02MpfHInkmVbttH9q
	ACgPrCrYHywVjMeZtMVOu1VcXlHsaFx3pw0DLLz8T+9xUvUiV9BL0l7man+s=
X-Google-Smtp-Source: AGHT+IETcZYRxBKx3huqntJ5WTHWeYGxrY/Ls8SwTDAM5OKzPYwUOXDsZG8J/Gx3GzsvRn8fXJyjHg==
X-Received: by 2002:a05:6a00:8c9:b0:747:accb:773c with SMTP id d2e1a72fcca58-76ab2f4beabmr6907822b3a.13.1753911651236;
        Wed, 30 Jul 2025 14:40:51 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7640adfebd3sm11422458b3a.67.2025.07.30.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 14:40:50 -0700 (PDT)
Date: Wed, 30 Jul 2025 14:40:50 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Duo Yi <duo@meta.com>, andrew@lunn.ch, donald.hunter@gmail.com,
	kory.maincent@bootlin.com, sdf@fomichev.me
Subject: Re: [PATCH net] netlink: specs: ethtool: fix module EEPROM
 input/output arguments
Message-ID: <aIqRYhDPduCdGQjB@mini-arch>
References: <20250730172137.1322351-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250730172137.1322351-1-kuba@kernel.org>

On 07/30, Jakub Kicinski wrote:
> Module (SFP) eeprom GET has a lot of input params, they are all
> mistakenly listed as output in the spec. Looks like kernel doesn't
> output them at all. Correct what are the inputs and what the outputs.
> 
> Reported-by: Duo Yi <duo@meta.com>
> Fixes: a353318ebf24 ("tools: ynl: populate most of the ethtool spec")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(seems to match what eeprom_parse_request and eeprom_fill_reply are
doing)

