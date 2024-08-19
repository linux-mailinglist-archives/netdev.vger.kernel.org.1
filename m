Return-Path: <netdev+bounces-119688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 659FA95697E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F47A1F2250A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72A5166F01;
	Mon, 19 Aug 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG1c9G9y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F627157A48;
	Mon, 19 Aug 2024 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067643; cv=none; b=lzp4yA56ZKrnjTm+5QxFIdIJK43jjpRmOyaymQk9rfF/KZs52SMZPlTNPf6OPc7K8MRUZQyOjzk69yzDN0wWAIZ81uVnhTQbpbF3vsxYO6HC9J/3x2R7ijLZjA4TUK5s9bzFttggl5P3+l6r3mwNwHhMuZ6FfF1U43aXAz5tAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067643; c=relaxed/simple;
	bh=gV/zmEgbR6nXqHllg32Eb6Nn1O1SKGVRk7PnZngwO0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxdcX5RLrgssXZlmIpS7GJK7GtRF01kst1fsYlw1U3mQQk/ubP4WBIllSc143gWs5GFIeMdjWRm0XIDAK6o5LkBgmRQ/VCX2BOShCtf8YBiGQMRWPs5R5FTtoByJgtGJZMowFLxglt0KilZv91O4jGVQ7bMxWJoDc6yqq8NGpl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG1c9G9y; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a94478a4eso909437466b.1;
        Mon, 19 Aug 2024 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724067640; x=1724672440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1LPhpIw6zUplYseeK4Y27omRELGjVo6B0WUUXO19x8=;
        b=aG1c9G9ywCsKKEx6SsQMTgzQxLCEym08MmRm6zpRfuCCFdJEUmzK5zfqe/cPnnSj0V
         DajWDXqn+G1YjVmLREqDqg8rbrNo9iC6Q8mX3ZHm1dJsToOl+f6Ec3NqwbItJT8Qeghp
         wcFahB8r+LQ4sbQHosNZ2JwSv9/fpbe/gfnyQRoe0tKBku/Hvi+0YLdOGc2oZ/J78bRc
         dVj10x2YXlIhkYZkliKcrjvWGuT7QUzNXAHUjJa+Fl8s4bcK/T28UKbanAWo1xkkbJno
         7Rw6qmHC3vz7kVPsMS55XOIvIHGVnaAnhFkULfl1m4enoC/hocI5fmd64Z7ZmMXbmI3v
         IngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067640; x=1724672440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1LPhpIw6zUplYseeK4Y27omRELGjVo6B0WUUXO19x8=;
        b=gU7Krb58xm7X5QWgGnCT7h40n5woBBVHjhUPhFaQeSqnMH7yWc7fmMVrxyHIVYpZsL
         710zNvEImxJBNikyX3bkYL/RGcUFSBG6WR5/dIEAS1A0ZTbW14vQWGOxIEHfeMqNp2Oq
         r4tYnF6+cFbe58qFOeJL0i8FDj/kCJakehy7RUKFvY4t92q6oAvphSRDm9DHFwgj6iG/
         XNAYCXBO5H19c3VYvI4k1st9wnPEUyUALK3Z6awaZ/t147GP5gYB/ZXeE7Kdor9vnEJN
         esl4MEVPM5ig1zkANN9KaxeC0Frziq4zhbCTZeRXjFuJa7EVyFpod5/pU5eFP5pCsGa3
         gacA==
X-Forwarded-Encrypted: i=1; AJvYcCVADNMuDCBfXdGUclxZpYs5WCnrscibnBWx6kdD+igEPrO7ReHHDqaxsALCbqJNskeW+VWTScsAq0fAkdcCkzceSzC3LYlBbYTWhrXOGLQrCN7x0gpzegQWkwlc7WFqCRfE/vLj
X-Gm-Message-State: AOJu0YzO8knZa7RRZiTRg1wEvVTyv5yWmFDzQ9uDhllk1ERodjkPBTc6
	N3nugnY8Egsvo9qxBC3IClhZwHftT2BD7/u+WKBO4D60vgrfNm2N
X-Google-Smtp-Source: AGHT+IF3kiosIQALUEVpVEF+AHu5uPDBEnwfKksdilsy2OZ6truteS3BEbGZJ5aRsdPuzaV7qhc0FA==
X-Received: by 2002:a17:907:970b:b0:a7a:87c1:26c4 with SMTP id a640c23a62f3a-a8394e16cb8mr900443366b.17.1724067639927;
        Mon, 19 Aug 2024 04:40:39 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c67d3sm624082966b.1.2024.08.19.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:40:39 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:40:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com
Subject: Re: [PATCH net-next v3 7/7] net: stmmac: silence FPE kernel logs
Message-ID: <20240819114036.af7gjv6j3p2r3c75@skbuf>
References: <cover.1724051326.git.0x1207@gmail.com>
 <375534116912f13cb744c386e33c856c953b258b.1724051326.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <375534116912f13cb744c386e33c856c953b258b.1724051326.git.0x1207@gmail.com>

On Mon, Aug 19, 2024 at 03:25:20PM +0800, Furong Xu wrote:
> ethtool --show-mm can get real-time state of FPE.
> Those kernel logs should keep quiet.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---

These prints are equally useless?
	netdev_info(priv->dev, "FPE workqueue start");
	netdev_info(priv->dev, "FPE workqueue stop");

