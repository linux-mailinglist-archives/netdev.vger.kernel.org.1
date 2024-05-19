Return-Path: <netdev+bounces-97148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6488C9755
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 00:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A922810A9
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 22:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6441D4D9E8;
	Sun, 19 May 2024 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="BbnBozM/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726F101DB
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716159565; cv=none; b=uCSiA0wAWZqNXX4Zn7p9UiFpoLqz42Lmhw8e4H7csgrMdWtHFnGptsuZEJUfPUMfwnPSRRWUg4bc/VseFUTlIeJfh72x4lWLA57RBwQto1p/kRZo+sxHjGv5XCuTraAaCRYY1CNksPpomGA7sw3iWN8XdqfvT29Ulj/Y9C0whOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716159565; c=relaxed/simple;
	bh=A7c1TsAQf/Y7hJkEwjkEEE0WngffptY4iAdd30QDJa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPOI6plIt5Wc0MRBfjWnhWDcmGb0nPxX8gFIDaYNG2CH4r+fgedZALjDY/70vEi+oLwPa/txhM0CAcgocibrfUq+FFuGbSdrnByV6/ytm5XP9R1bW9f6INyhvbppMaBI3uODdargwfeDOBk9PDgC+2vJDvkCcb5muvWlWDN4M9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=BbnBozM/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecddf96313so39961155ad.2
        for <netdev@vger.kernel.org>; Sun, 19 May 2024 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1716159563; x=1716764363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x09uDObDpJNHnRXEU9vnE29zSYza5LxvY7cub7w7qWw=;
        b=BbnBozM/dRz7caLwnOK93sPt+3at0GSkV8W6zRiefNNQeDAU+oGSiB6j/XVXX7+ur+
         MkyesfzVIjqBBmVGYyDA4c/sMjqhST9y7ldCgsCo/L/u7dxl6icNy4Pxljyq0fQmj6oD
         csvoyzNJ/YrneTwRIuTiF0TMqD88w8Lek98Xui5qZwuHS/xXUaR0Foj4NMSTiSriCTeB
         9/QpTwQVxNoJ7mz5v09ak4tnNSQNSRfMQnH1d8IMiJuu81em3rgEB4Ors9f/5OJ0DV6d
         b58zjrS2nkP22TI7eUx+E+CEsX+zbA97O9G5vqkqEYK8qWlli9iTZ6XQq6zGsRcZHrUs
         8pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716159563; x=1716764363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x09uDObDpJNHnRXEU9vnE29zSYza5LxvY7cub7w7qWw=;
        b=brpqPmA+6xxYThsSpbr6Co38MC8/yG7gp1vWCJaqyqbGLAZqKQ86fKiHsJyVa29XlW
         kM6lgCax0qhipN2RjvPDBj+GDeABPtPGC4W/uxcY1ll7O2pzjoEJZml4tA8QTTLmub8a
         GssiT9NnKTVQpwrpuIZUUjGDwI5u7JpWYPqkEOJhNPR/jZ+76Q+FJ6+EOtwX6Ic4Xp1t
         X0/HnVLU05CvScv25knfIiHl3chNQ7aXNsOoqUcrWzPCpvY7qKfpC9fP0WQa1DCrHMr4
         1fcNwBu9NVuZuUa1pY7KgU10UloetC0/nVwHZzbiXtrJiQO9/r6Kb8QrdmWf07C6ooVE
         rKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk9ixa8b7tlUkqwprbQ/rSvnaUo2TcIOvhFC4Hvvh+JOpzu0gPNw3QPBwnL7v+7fAyRPkSdV3RuSbIvqmkfRf3qZmKTPHZ
X-Gm-Message-State: AOJu0Yyup0NBCCfJ5++ScV8O8feOj9ulf+LjGjvo0hz+zCul97xmBxuE
	ENfMIjdYLVzM9fF/BYlVcr/Qo1vYf0NcsgwcNlSm+96fLeV0XypO7AQAh4+vG4Q=
X-Google-Smtp-Source: AGHT+IGSlr4ZLoLjbGRX4HwM7J0TcHsmOU0WnRG+4566s0qvmdUS5yzzxM7uRDFcqa2pa8klpna8hg==
X-Received: by 2002:a05:6a20:12d0:b0:1b1:d7d1:c0b3 with SMTP id adf61e73a8af0-1b1d7d1c135mr3180784637.27.1716159562941;
        Sun, 19 May 2024 15:59:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b6710564b3sm20713236a91.10.2024.05.19.15.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:59:22 -0700 (PDT)
Date: Sun, 19 May 2024 15:59:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>,
 <devel@linux-ipsec.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>,
 "Christian Hopps" <chopps@chopps.org>
Subject: Re: [PATCH RFC iproute2-next 3/3] xfrm: update ip xfrm state output
 for SA with direction attribute
Message-ID: <20240519155921.1429f20e@hermes.local>
In-Reply-To: <4b4b45dfffeab66c64cf560f20b5317e0a3ad55f.1716143499.git.antony.antony@secunet.com>
References: <cover.1716143499.git.antony.antony@secunet.com>
	<4b4b45dfffeab66c64cf560f20b5317e0a3ad55f.1716143499.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 May 2024 20:37:45 +0200
Antony Antony <antony.antony@secunet.com> wrote:

> +	if (sa_dir == XFRM_SA_DIR_OUT) {
> +		/* would the fail occur on OUT??? */
> +		fprintf(fp, " failed %u%s", s->integrity_failed, _SL_);
> +	} else {
> +		fprintf(fp, "  replay-window %u replay %u failed %u%s",
> +			s->replay_window, s->replay, s->integrity_failed, _SL_);
> +	}

Errors should be printed to stderr

