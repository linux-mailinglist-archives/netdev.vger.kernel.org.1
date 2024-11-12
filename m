Return-Path: <netdev+bounces-144067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652A59C56BE
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C56283B53
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21BC2309A7;
	Tue, 12 Nov 2024 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+bqbS4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499B230999;
	Tue, 12 Nov 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411462; cv=none; b=BHEz5LNcvrF5NbiOqa9lu9teK4dsbDjXyiuFi0iaeL+wDrsGAvHIejhJHRuovNkwFRLmIwfMlVItXMbABSitaZedudB9kURgClhQEmVNEnQT5bpwPM/8h5cyD4TneM2hIQ4eT6/CLmxD81UOH9eG2rfEVOPsOGdaEWx5go5JBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411462; c=relaxed/simple;
	bh=Vfrl3Im6GZEToB0Gpf3py3k7uTOf2YCEgh+4Yca4qLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mp5oqNlODdRnDuvxE70ZrWbRbk4C9BIaIEzO1HXoS+6A8gsjSX8wuUek6kYSESUBziipviS5vDy80Ok4pViObld6w11KLD55LXd09gA1MqibbdB3lx917w0iJZb1Mbl+rKon3PgDvW4SbeDno0FUC3r8oPdukR3chZ3CMXYnEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+bqbS4O; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbd550b648so42243346d6.0;
        Tue, 12 Nov 2024 03:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731411460; x=1732016260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vfrl3Im6GZEToB0Gpf3py3k7uTOf2YCEgh+4Yca4qLM=;
        b=O+bqbS4OLV8VGEeVsVA9HGsR1GvBKqN6Q1PGKdTiqWtOn66sP+H0qiwwOauT2nX5G4
         jpl1qoTQro/33BrePSQgyoZArjrOT2DbbTVqV9Cm9qEAIOhADWWCC7/1IxpE0FFAmAWg
         gx1oxW0LCpj33+NZQ8Crd7rNx1BY63FbFm8JGtlSInwI+TqvkNOvbOWKlNYyNUVnHOMn
         1II7Rk3Og4ZBnEh3cPknWQE6JpCUTVxsR1UJ33NZsZyXtpPnjF+WpkbUGhS7o6oa2Pdb
         2dA5bcRZZC9r+ubxTlVjc8XAYhr5UQMS9yBG8gJwLO3p5CB/0YzrzPsNfEwXE3dVZV2x
         tubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731411460; x=1732016260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vfrl3Im6GZEToB0Gpf3py3k7uTOf2YCEgh+4Yca4qLM=;
        b=KDRagcW0+utK4+P2z3EhoxOOKjJD7aycvhFuzcjggb81uwpDxiSkPsIJt2Z/p8a1Y8
         52fmrGdyNyoTCGD3FQEQOHL5txn/6E5SU1XkukYindb5dZKh7mzh70LKzWTjvchYMKr0
         V5syzXFRjpY5+pDylnhnloC+sdT8Wh9uycUzK/D4a5BKixEUJ3KyyMz2G6FsW4ySJQAJ
         LP1pJX/fDE5jS9leyJgilO1p+jYnZOYna/ivjlzpyqXEbuPvCOD/UJ4NWrrK6YITVav9
         qKxlXYgfQa2aIk6OF+Sc/6ixwKXFWs23OWCDeDmoH+FJHZVeAb4nXsR5vxBZg/QQFC+/
         03xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmjYRvsOGu0hK97l65W7v5DkgXXLHJ55LsoFkKeqpP6UmApi8SxwnR2BFOcXzC3A73RachMfRRxgc5gkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78bQmPsuFpAeIlNoprASeYv2WakVL+RkclJ5Y9AHfXPSzfpe+
	nDWmLu9N1DXhbeLLQfXvtqK84QXDufN+ofnyqchpLlwu3NpiDaDoS3+ElMkFNMCLz1WEg9qok42
	QmErlVUNSRZioPIg7iQLdAHRdXgw=
X-Google-Smtp-Source: AGHT+IHwlN//Kpl20G/RUC+3vT5GO7jitSU59M/eimS/04ANJ655/R6zZh8rbNEMuo9t0RWvM/PLJkNkynFh3IwnVZ8=
X-Received: by 2002:a05:6214:459a:b0:6cb:fe93:53a6 with SMTP id
 6a1803df08f44-6d39e107939mr212424006d6.1.1731411460167; Tue, 12 Nov 2024
 03:37:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112100328.134730-1-yyyynoom@gmail.com>
In-Reply-To: <20241112100328.134730-1-yyyynoom@gmail.com>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Tue, 12 Nov 2024 20:37:28 +0900
Message-ID: <CAAjsZQwvtOXBi=Z_aOzQR54QWav6OMUKTRj6QPAJJyjm1q1SoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dlink: add support for reporting stats
 via `ethtool -S`
To: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	kuba@kernel.org, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There is an issue in this patch where stat information is not being
added. Please DO NOT approve this patch.
Additionally, while not critical, there are minor issues such as
indentation problems and the lack of a Changelog. I will make sure to
address these issues and send an updated version.

