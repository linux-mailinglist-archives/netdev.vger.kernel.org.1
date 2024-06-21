Return-Path: <netdev+bounces-105728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0CF91282A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF54283856
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46B28DB3;
	Fri, 21 Jun 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOnbhaL8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27FB208A1;
	Fri, 21 Jun 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980954; cv=none; b=oZ6daLPA6KnYnLkT70GfIbGT6A4+PxZkM6jIRHFOytV2iJlNAexhcbdmQni1ElpqeNzlFGpy09+YDgGOXPlq5Mlyc/Uiarb8sGAkjih8f9pSdzWwjMaUuagMoAhOPQfvLJMAtXR7LHwGoi/QHjLg23gBB19W1fn7UqFrEiI/wQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980954; c=relaxed/simple;
	bh=7Ca94C8JkIunzlhBcOwSSiCqFFA13XEf/oiy183JF+o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=omXcVrkHagwUxT4TmJZnQOoP9Amf2u5ucFgZHAOF4uxaFVDXFwkLOsMcsDztsyLosR0p67+yqFLkiA0C3PJ3k6nizcg7JVJEPdo1c/8xxObB0e9K//PRM/76NAPf3aD7c+e+z+deilnD2Ul146OSCX8fUfnEAOOCPUQgXworaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOnbhaL8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso2929009e87.1;
        Fri, 21 Jun 2024 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718980951; x=1719585751; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ca94C8JkIunzlhBcOwSSiCqFFA13XEf/oiy183JF+o=;
        b=DOnbhaL8GPAtAzLgI421y/9xG9kIXCSrezv3VHDFKbUynp1pDklP6sabrDzye8jo4Q
         z/oPLukpI1lyE6NwKzslsb2Vn3wnlbFQrbOlDYTujuovONb+bFF/nZuvUh3EVWZGrXMh
         es+BxmqgDf1irsYmlYZouRBG8E75vlJEmOAiEn3TMo1qJj538yT8Z80u2FB3y9AEEzF/
         boLZPNzFRDi8Ic8qMpDrkpuAu/DY7WT0i/JzKZ3UdQaiv3/SnLoRg4E0XbaUsisTnSn9
         UNyuqQe2PqYDHr595PLSQYWc41+uBKZ520XQPieiEo6+aPidNCnyhmgFFPQ+eG2kH/NE
         olgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980951; x=1719585751;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ca94C8JkIunzlhBcOwSSiCqFFA13XEf/oiy183JF+o=;
        b=Aw+k+sal19r3hTuQ3PjBrFelJ7tD8szprp0yNO8Fwh3w/2D+UTBFeVQpShYIIT8FBc
         ZOwloLsc6cdNanoNSvsjNdaum20OCQO10palt1VQJ0vDldMXCex9B4XrUSraC3j+AqPu
         1kxPmZW/TOZq2ld4jRoRHa5iImVXFx+AT1a6v+a1GOWN5yDVuuRYmrwNO3KpE3ubK5ZG
         zVnX8BfNiANlBe2WQYhDQbvJ4XQeBdDW7+fnBI07hZ6in1pTCh4uNq+7/oMaGs22/9z6
         /l7KyuKCxRcZxTVeEZFYzXjYAqLWWXH8eUJHIdWpBwVjvgCLSv6wFh5S4oMpAioEP57R
         BFCA==
X-Forwarded-Encrypted: i=1; AJvYcCWnllJ6HcMpkmEPQdZHM6dNs0QryxDl0mQz9kMYMJMbUpYMTaBxTbuZwH7OtbEljq2rXFEG2f4z0qgDhELRCr8SKJv9BF07CRmegGYGgtKDQ5hs8uXBZR86YLGKxuBBM10gulrw
X-Gm-Message-State: AOJu0YwABOvnZ78Uv4G2EmxlK+WC7KseZhvPTwFdTmB3wnL2snzAddIo
	Xj9Z/0V4BeTKapmDCgdrkShPaGNxyM3BzDb3kIS5affPGSF0hE3m
X-Google-Smtp-Source: AGHT+IHNAl6TSOal7rNDMN4jFkHVXKUOx2xHIl4PTIIIkzovT0NEnmIIQt91AGzV1Da87Bxotzv6xQ==
X-Received: by 2002:ac2:5dee:0:b0:52c:baaa:ef8a with SMTP id 2adb3069b0e04-52ccaa37545mr5537645e87.38.1718980950522;
        Fri, 21 Jun 2024 07:42:30 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a033:c98:5184:cc96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208e08sm67964145e9.35.2024.06.21.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:42:29 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  Andrew Lunn <andrew@lunn.ch>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,  Oleksij Rempel
 <o.rempel@pengutronix.de>,  thomas.petazzoni@bootlin.com,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] netlink: specs: Fix pse-set command attributes
In-Reply-To: <20240621130059.2147307-1-kory.maincent@bootlin.com> (Kory
	Maincent's message of "Fri, 21 Jun 2024 15:00:59 +0200")
Date: Fri, 21 Jun 2024 15:41:44 +0100
Message-ID: <m2y16y8ijb.fsf@gmail.com>
References: <20240621130059.2147307-1-kory.maincent@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kory Maincent <kory.maincent@bootlin.com> writes:

> Not all PSE attributes are used for the pse-set netlink command.
> Select only the ones used by ethtool.
>
> Fixes: f8586411e40e ("netlink: specs: Expand the pse netlink command with PoE interface")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

