Return-Path: <netdev+bounces-101789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EAC900161
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B34284C2E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FD186E38;
	Fri,  7 Jun 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj5xyic4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111AA1862AB;
	Fri,  7 Jun 2024 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758004; cv=none; b=SkbDEYuc04LF/cVo8xI0YH3n9mwjyAUNAwqp7UD6bB1n0rgfolflSP3ZWc9o+KyoHf1wmn351X8SuATEAbnrAFXHR8Kz3yFYu1LbFHYPSu0S4aDJK24xivMGQ+AyPFdPSW2vpCTuOsH1x3QhosPpGU3VPCzLpfN9htNeA65HZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758004; c=relaxed/simple;
	bh=QBrdfx1/XX/UOfc71j27Wb5CzWJX1323VEZ9MweCRx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXiI5XZ6NSa1PqbVyOx0kIafQesi+CUYNJrQRWA+WSPJHQDdLHNODHRJN/NRRXZE1EI1AaoQU1XZTkzMuEpfY1JIF4X6bJRq+1PltPJXbSVqPHQshTEuFWXFn1of2To0jvl75BGWM6Uc9qwhq1qJPpvBOM28c6797CfQXMvUY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj5xyic4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so2385858a12.2;
        Fri, 07 Jun 2024 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717758001; x=1718362801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJpv+qEzMSn0QFirqNpPSLDGgqavfET+JJwd5C1YxY0=;
        b=Jj5xyic4x7Y69PTU9ElbXkRGN1yt9xxpQx7nNU5oyE1wAdezjF9VQzS5Ol/HvYFRNE
         zRaYLrBav8/hMVOUBbZHcSqjNTJujSeUHj6e5C5M+iowpxRyqzctyi37pTXeJOHzxUbJ
         ue5fiR1FW8NDp5pwwllaLB/OdmNndPkGl4HuuXF1EGc6uJSpjEFHvFThngXE5djkS+Qb
         Hv2Ux9qybboS33NkiHZaMnsvxp17E/Wk08ErZzfqcz5R4usKs3c7EmsElcu4odrQtjL2
         36+O0T3OYHJdhVsJkA418DRi4BByP4x1nRJO/w1hn5nc5edrtFW9znUmrFa9mdsN0VVq
         Ef6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758001; x=1718362801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJpv+qEzMSn0QFirqNpPSLDGgqavfET+JJwd5C1YxY0=;
        b=FH3IeQ/LgFFRYcJj9KpXILYz88XHJNjQvzAuTud4tXSGw5bWh4rJ8MxQ82ZIni1Ozv
         6sYdr3C0GEtGZPqKyTtfGl+QwLpXzjak9i/mFQ3U6RVpGZFjvMPbG71X3Fc1qRo8QdSp
         xl/JbqjCJvkdA6AWEpPJuQ1GooQ1DlksfGC6PVRT0yb0qvv81LfBheeVUwsTK0imr1aW
         pnXF+RxuZoUCOyhFKxRXQFK3PZHMA2UctY8Y5qyh32/ed2K0fEnKjn2qy0LqOp9UTRqX
         8yRyJY8UNpXObRvvpU8nZk90yroI9wCfiLGiVaWW86s1fqwk91xLulKbZbBBPoWE0rjc
         OjYw==
X-Forwarded-Encrypted: i=1; AJvYcCW47rwpCctO4G5z46h0k0GBVVpvnQvxOGLKqlqPESVW8x/xKpPBL03M8GuA2ffN9o/G6hPcsxwgIHXBFT/9WKGRkn0F+S0tRC4GRV+4NJxctzOBWmbxNbSI6Nd+NChw6qIZeF8uUaII384T3eU6YkmAp6iqBTRthFfCoP0QGp3y9w==
X-Gm-Message-State: AOJu0Ywxx3Il1cBrezf8fL14ZjPhxUD1qXBMMtym+2E8mziJnpTEMuVR
	mwq+ilnggQYElH3t02KwRjlaUM4gK5yjxsr2zhEcRzAiY+aBg4Hd
X-Google-Smtp-Source: AGHT+IHO6rkhgH9s/+C5yI70NODrziwqjP/bhKa9RIxJJzcxAr79hJNFYlsokOE6jD6G7Tq+btlYGA==
X-Received: by 2002:a17:907:1704:b0:a68:a2e7:118b with SMTP id a640c23a62f3a-a6cd665e4demr164857666b.19.1717758000854;
        Fri, 07 Jun 2024 04:00:00 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eb101sm229827566b.121.2024.06.07.03.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:00:00 -0700 (PDT)
Date: Fri, 7 Jun 2024 13:59:57 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/13] dt-bindings: net: dsa: lantiq_gswip: Add
 missing phy-mode and fixed-link
Message-ID: <20240607105957.kkcogto7wtn35mlb@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-2-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-2-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:22AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> The CPU port has to specify a phy-mode and either a phy or a fixed-link.
> Since GSWIP is connected using a SoC internal protocol there's no PHY
> involved. Add phy-mode = "internal" and a fixed-link to describe the
> communication between the PMAC (Ethernet controller) and GSWIP switch.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Long-term it would be good to also see a dt-schema conversion.

