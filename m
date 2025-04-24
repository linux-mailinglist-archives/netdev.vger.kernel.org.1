Return-Path: <netdev+bounces-185712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A92A9B826
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FCC7A8644
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CCF291169;
	Thu, 24 Apr 2025 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8puR/KZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41513290BDF;
	Thu, 24 Apr 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522255; cv=none; b=TrxhC7rmS9jfbTH79JM3V1qbNLwA4VAi/WGlog5EBGWYNB156Zp63bZKh5tqmOy4rFk4CtL5QSKCx4hbGePCPK33d0OGvchrVR5kd41YajXAZ5nMPDSJmj91osT4E/NKbiVCSvryL08K35oD1PBbaRqFYkxU/l8hvr1o5DWXPWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522255; c=relaxed/simple;
	bh=4FAg9dOCib/NxKAtEqDq/2c3ne9EVt+MCqwoJUr75Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWhycHY4vPmFTLJKiHtQ+vm3Xax6eWYxA3AQGmBe/CJsYKtP6DlbWbcFNzI4TM2jWfPznnkXkW4b7qYgjtxRY9UiBb4n/8olKyGvvxcOxv+wSwPCwmrqLHZOOBVrREWCVV6OVPwG2eY0ooOYLTG9wpGImCbiKBkbSsR+QygUuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8puR/KZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso10267845e9.3;
        Thu, 24 Apr 2025 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745522252; x=1746127052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hKtiIR8/1ANFiI3jvmxK88n9ocUCdqWIViGNXRe9MXE=;
        b=i8puR/KZraNY7E0qX2Lipx+TzaQoWu5SgxCdwcgzsou7gIzzRvVU+8qXyv23NL1wRi
         hxBR6NEKeQ7l80ciHmcKlXWrjOaJ1c5m2RTDQzwx5nQDVgOxkFzWCxnarkII6Ta81dAT
         BSZ+t4VkAA/IY2XpmNlb3+QVTnJQO8xvH30nW7pN1w7pIiN+HWBjB3UDod4rMtNs4DwT
         51o1GFkptr1UvQc88cZFq73+1yNsIzo56K5Zmpkkv+x4T2X2dH7X49Y/79rn10kI8c74
         ViGyT1vxDd1iz0j4I8CMi8RagrBEVFcb/6tfhH7EfE7JXk8EXAo6rWIS3QoUVMuZ+Bk/
         sIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745522252; x=1746127052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKtiIR8/1ANFiI3jvmxK88n9ocUCdqWIViGNXRe9MXE=;
        b=b2xZhqX/8nxqH1OfpIEGzKvOUbSbSl5TX7TG4RdE2Yf/o1meJ/1WjVr1avD8MEhEiV
         lGsNDxEV1xL74abB/9X64H/tZ64Yw8NMEvhH7DPkZVoeZgxZI4eH0WF148aHFyoD5ULk
         JJJsFig/DzsE0DG6D19Ru6dT2SM1uOF7F5SFk2/OKA6MZjYgda+VWHMjT63veotsiGzc
         Tw2Tkzkgopugia5tn1OUq655MtUgq0vxQD1mBR/45rcg8KFryP1gPMl0Rm5SlwAdQLBb
         x4lyY9bs3BK+CaNr3GBWEIUrQdExFZKsJEDfWuA/4sJdzF+2xO7uch2HOZ+DxCf4yamy
         45wA==
X-Forwarded-Encrypted: i=1; AJvYcCVwMgtnKKMlAIJFqc873MqnzVyQxkAZ3lu2OW+dGR7PtKlkpl8qYWXknB4chkjlTXiMEng0YuaFhdst@vger.kernel.org, AJvYcCX+/ErKojFXATSNVK04c956VjD7hpSKTYxe+5S8gLnaYs2VYTDXOmhS3HTj0BU8pKFJD6B50ZpMq0Sgq3p9@vger.kernel.org, AJvYcCXw7oBDBUV8CF5IAXVZJqzn80zhP1s8TgVrqpZ+aA3R2HhnwIKQstx5KS1vLW1l91aFZlVrresa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6drSsnDeExorps0VFBaln4pdAhXgD/MW7H8XijHSBZdkmdpF0
	Wg2s/WdUMkmWCU4N6I86ElPQ7cME1lOphDOEheHaYQccc6r035pO
X-Gm-Gg: ASbGncveTDSBHSqvSaWAWcaR/qW7TyeKvkmh4z+FNlSlhCZUCGrs4P4T+93yEgcRf9d
	tzzccBne+f+MNUdmLssJmpxxvVbp7gjetcGoW0jRKZW9ILus5+tQkCuNAjqQpLzX4OZJHz5NwO/
	bw9SZBUp2hjgnLO7EhTcmtNSTTZSvolyrPt8bg1C53UBvf4+sR8L6CXfShdp5H1fGQllI7gNEbi
	63e8QsA4Nlm1al5UGJ8FOPK5gUS4jo91LZgZewSq3OzNiThLkQvu2RaWsrsIBQ3JUN6I9GHCrEe
	3auushU80CCtBJ7qbKs19MwF9Khwq3LBwSifij0k
X-Google-Smtp-Source: AGHT+IGHUagr5uQkmxlICqpS4xt1BsRnNl8Y/nS1PqKVhK6DbPifS1o99SIUo9WiHCLLy1FyDQtZ4g==
X-Received: by 2002:a5d:64ef:0:b0:38d:dd52:1b5d with SMTP id ffacd0b85a97d-3a072a4636dmr351698f8f.4.1745522252237;
        Thu, 24 Apr 2025 12:17:32 -0700 (PDT)
Received: from Red ([2a01:cb1d:898:ab00:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a073cbedc4sm156237f8f.47.2025.04.24.12.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:17:31 -0700 (PDT)
Date: Thu, 24 Apr 2025 21:17:29 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/5] arm64: dts: allwinner: a523: Add EMAC0 ethernet
 MAC
Message-ID: <aAqOSRQCKNuezyUK@Red>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
 <20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424-01-sun55i-emac0-v2-3-833f04d23e1d@gentoo.org>

Le Thu, Apr 24, 2025 at 06:08:41PM +0800, Yixun Lan a écrit :
> Add EMAC0 ethernet MAC support which found on A523 variant SoCs,
> including the A527/T527 chips. MAC0 is compatible to the A64 chip which
> requires an external PHY. This patch only add RGMII pins for now.
> 

Tested-by: Corentin LABBE <clabbe.montjoie@gmail.com>

Thanks

