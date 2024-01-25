Return-Path: <netdev+bounces-65844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C872183C0D0
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65035B26B8F
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6FC4123F;
	Thu, 25 Jan 2024 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEDjE4B7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130840BFD
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180407; cv=none; b=UOqt4qYPF9luIiQHwCTBekGuod/3p7zUt7JOVCxsylHdFtDwCbX1mfaCa3/4XITa/jB1vIEpLjorHsKh6DMmCI0jtKAXtAEUfDf3Uayn3LKzn2d/13rZMst2Rujr2Q0dc0v1KLfcLh5vBcgUfYf4vCHqO8fOc4xPERMJt/qRB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180407; c=relaxed/simple;
	bh=2jJg9ACGpQJ0nc6yPa5y3m3HMV4VsGb0riHRp/14quY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkgHqVMCzpKWPakKn4862ztX7jhfCrRxppNmhDBqft3kAXEW/lI00ytqh7KhbcGKTZ/wDnH9AYF2ZUSSGAmoeWnOuaWEu2TZycvSXEtmv67VePryYAnsxTLmRDutKo/sqhi9aYB1Q9F5hCbEf27EHSmVCpvpOE8yZ1yzhR7+qKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEDjE4B7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso675489366b.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 03:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706180404; x=1706785204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yZYuyJs2dkiDap5MlQCaX0xU7fiTdHRxbdjMLtZHgI=;
        b=IEDjE4B7/rnlNH8KeBvDujUDdaaJ/qt85pIuOc59kpugd7sNJRAmu4/RCx0n8v1T4O
         D8q5TJF5Rc3vY9N6xDJp6kZIOxEYwtp+gIPtQe0l1ZmOyJ6Li/Mc6Y8XpBR0msHUg9k/
         ux4NBe6mdEiuXkRyWEgBm8yJ6lXycR0xK/7shmLObQR/cMqoqOikSeLdSN/mflhE2qeq
         GRowm3Q+/7kZLda7m7pKViJCJzb0DjcfVf/6XhME1ztR0D/8nuHyEowiQu0UsklKStvk
         u/ak4KdydgzoyTY+X52PyM0KBj0SeG6xyzj4EujU/CEjleXLXt/1j/Y6JjRPZBJVzw96
         SgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706180404; x=1706785204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yZYuyJs2dkiDap5MlQCaX0xU7fiTdHRxbdjMLtZHgI=;
        b=CDxa8Qgfa5CU+472S9ZO9Cnh0wrcUruy+g39Fp1Lpqh4L14EgdiuETsaiYWSYY64wr
         el17UPE4U2DuC0uqOQUVBtd7aeD983UUyE7jOFCRfiOwbzBE4V3pwZfXPiTtcTToh3ca
         WZs3EuD1M+QdLvhklwJZBhpEju+Ro3ByvB51dS0uMaCSZ+kP3qf6OpL/UgisdDKUT03/
         msHlayddScdQhIjavQGj8lq1Ht3MuDqOmrfBNiuRloBGK6kZ24iTlmlUc3Kn2WxTFV79
         HE8QN0MRZIyRhQypzXnAlIBUMAtoeiPDbactQasJC4tFkS8thnmgdV5xZJuPDaZoUnND
         QWiA==
X-Gm-Message-State: AOJu0YzTBjvygks+g9Sx/v7W+RJhRbr/6I22bB7jHjaMGxqPcCNeFGD/
	gL2/gJHGnyn+0c8APf4eYnC9KlS3CEzp4H69x8jLEs7EgDAWqXBM
X-Google-Smtp-Source: AGHT+IF0c1uQbGBiIuhnQ5HAGU3oMQ+BiPDtJsx8Z0o8EFxxDkIitlwtzN3qxe3URSAcm+EZOCpmow==
X-Received: by 2002:a17:906:5f85:b0:a30:c662:233e with SMTP id a5-20020a1709065f8500b00a30c662233emr376431eju.135.1706180403541;
        Thu, 25 Jan 2024 03:00:03 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id cx2-20020a170907168200b00a317346a353sm588759ejd.123.2024.01.25.03.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:00:03 -0800 (PST)
Date: Thu, 25 Jan 2024 13:00:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 06/11] net: dsa: realtek: merge rtl83xx and
 interface modules into realtek-dsa
Message-ID: <20240125110001.2tz3uzcngkqutcp7@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-7-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123215606.26716-7-luizluca@gmail.com>

On Tue, Jan 23, 2024 at 06:55:58PM -0300, Luiz Angelo Daros de Luca wrote:
> Since rtl83xx and realtek-{smi,mdio} are always loaded together,
> we can optimize resource usage by consolidating them into a single
> module.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

