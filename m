Return-Path: <netdev+bounces-103188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66CC906C2B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23765B253FA
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75531459E7;
	Thu, 13 Jun 2024 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuKQCQsR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5D13D512;
	Thu, 13 Jun 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279189; cv=none; b=M3ep9ftr6F7sS/RQWQDyn4p7uapKZxTIqGY3LGobpH2r6Jk+buF/uk9wKUXLCiVEsiFknlaaeLQxap2NlQ8GlFdP/xcT4tW6KWh4/reSBkCoXLkQb3ObUlAxa0H0goSgJhoRSK4DjM6uifvLv/t9BJ6yz6Pb3sq1so2IjPhhVvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279189; c=relaxed/simple;
	bh=IDbexf2eZfmUwoSFLiwp25cs6cJ31ZbydyJsNFer6vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apEyVAgbCLrdS1uqtCLytY2GSRISLmgLA8qojxsSkay6rAE4mVwzlNIofz+nuJbbN1D4ueqUKjde/WQj7nl59IoiHqPBtawvTrs55qEdWOU3f2FCsJKrBDm89Pz+iAorWb0l7hnwECW0rqTMmM+i5pTPTzX9M2V2ohUHuUVI8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuKQCQsR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso167259366b.1;
        Thu, 13 Jun 2024 04:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718279186; x=1718883986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyyJwIzTGdI7/cKBl1ZpQe515OjfKK1XStdbGSx2zjg=;
        b=RuKQCQsR5AReDVCdbLjgkHCUKscLQ+rh+DnQkGLsSJyx0ePRScIq4QJat7GO6aflum
         znJ9jThvvy6GZH0o+bNLPe/9zBvdaUwzRsDfaWSdvrR8czmUdNHI7fXqL5L742y1phbs
         p1Q1f9UuKicpwJb3kShh86gGvuYA77y7tHT+cDhiD0V837GKpWvV/jmRrzGW8F97e6lw
         4IXVuFJNXPADvE5I2wiCC0XUNG8Wt00S4KZb9uk33exEEo/mzJfri9aBHc7F05FTvavb
         alpSKzDE3B8Sc4x/j4q4a0S91I0InoJ7q4p8q2uSFj1bBJF9tj+2nj/f8yPhdh7qlZw5
         8NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279186; x=1718883986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyyJwIzTGdI7/cKBl1ZpQe515OjfKK1XStdbGSx2zjg=;
        b=mXtwp4GaWSv/dAhNFF3No4bm0DUkk8dGXUmNAeiZvyCjl0jCk6KxsDe1cFWH/gZiR6
         r6NhjdwYvuv4IApXxLYDAJt0A/OPfBosu75qeQQYIDvrx8o4vFiXIOdugcS5+yOZ+Pbn
         9RUy28lvVcXbRz3P0TLTQYE3CRQRX+v8i33XdBJfp/8895ajIhiTxCh8AeB7p+Xj/USv
         6B8Gn8aZswAiEH4+f0ohywB7A8hjbFHdxmt+ElgJKKfkwdRfpkthLtUt0PmqxfPJutRI
         E0vMkY0AiqRCPD/+ztiZmKVCK6KXK9MOiIuBPKzh7jMHxYu492Pi+1CQa41gaEVFK9dI
         XPFA==
X-Forwarded-Encrypted: i=1; AJvYcCXrXlWytVTRWGvs6EX2Fqg03TfugV79HBK8tMDjTEC57kXCIwHQdY0J8/wJF4wFBiWymRzTeY3ilfaBORtdWYWzw0tfsy8obXDGEpKpwkxHGhuu+i3Slu70w4W06jd1Hy2U0l9v+K72Wv3xydpgrhtXhtmjWOxssttQiUERpVvRhA==
X-Gm-Message-State: AOJu0YyXaWzwYN8O5MahthgKvBGjUBmL/Hn031vm69jOQbH8MFqBizJV
	+Tg63oe8+AWMmFMGiugzh+C8UzXJlwMMOet922Xfh310OKoo0fGt
X-Google-Smtp-Source: AGHT+IGTrcMO1Z2soAspslbJyyJxA7M8r8c8TUltY/hfEEHSRlZqeuP8QinLuR7qrTKZJfOegaHRCA==
X-Received: by 2002:a17:907:6d11:b0:a6f:3b3b:b7cb with SMTP id a640c23a62f3a-a6f523eae18mr224121666b.7.1718279185893;
        Thu, 13 Jun 2024 04:46:25 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbbb5576csm165439a12.89.2024.06.13.04.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:46:25 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:46:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/12] dt-bindings: net: dsa: lantiq,gswip:
 convert to YAML schema
Message-ID: <20240613114622.hajwrbcrzm3mtg6f@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-2-ms@dev.tdt.de>
 <20240611135434.3180973-2-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-2-ms@dev.tdt.de>
 <20240611135434.3180973-2-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 03:54:23PM +0200, Martin Schiller wrote:
> Convert the lantiq,gswip bindings to YAML format.
> 
> Also add this new file to the MAINTAINERS file.
> 
> Furthermore, the CPU port has to specify a phy-mode and either a phy or
> a fixed-link. Since GSWIP is connected using a SoC internal protocol
> there's no PHY involved. Add phy-mode = "internal" and a fixed-link to
> the example code to describe the communication between the PMAC
> (Ethernet controller) and GSWIP switch.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

