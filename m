Return-Path: <netdev+bounces-191777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04215ABD342
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EC03A6008
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420AA265CAC;
	Tue, 20 May 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JqhKLJO7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF0263F44
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733003; cv=none; b=ZCD8DZCLvzjPv3n0gpWDpJEn/Xf4nOMkHDTXFavUeocpkZw1CP7bXzJK0YOA3b1F3zNilF89WO0MsQ+f3KrQaAH3dr5k4miWeMdm8yIttjV/8zhZWLhqlFSZywVqF6bPUpfR/1KrysBEjhRgu2aPJXBqnXH5bDIABG3U7E2vqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733003; c=relaxed/simple;
	bh=oU3PoYWbOuB2N5/61L0EZdrxVrNeUt8BXRgCEkVG41w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiFZ6nQZQPRxIr4qSiwcRO/cX9g4ypdb4VOjEZenf4a4YWWi7PjNOV1B5lLFv7re/fPF8KK2C+Ki7fdEm6jhg5KqaxTQWxV75OVsXtGh5jMC8aEJhvVGQ/jrgJKmXG9h7w+SD/29LmMepF/xizwoitxnCGGniq+lMoWMVEmoTh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JqhKLJO7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so38786865e9.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1747732998; x=1748337798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LD9HrbKHnhJ4K0C/4DmxBK8ifQh0KlDxWTRCTkR52/w=;
        b=JqhKLJO7oUXrz2iNzAoXGXbZHuTcQC6LwoDALzy7A1U5XuKlQdibwLFXnNIRuU4T+F
         lOMNG0ntjAEhbVC1UiWQYWk4HiWRqC2lgOZgCPTh1GXL/oTI3xFTMH3Z/4ZUDMu8zKQ8
         upVxYkUYUHKl8A9PWbjxEYpT78V0ohkF/dDBXGgHBmS/AI8yhgWBP5QksvPnAH/OjO2O
         JkkpcSYYL3c/8rDq/UzAfZnpze8g1Rf/Obbiousa9wCOBJCqXwWmjEANd5Iax0dW+fE5
         LaWDK5GN4Zt/rdrF196UMAZzt46IfpJaRG3foQIoDjsH8gK/XQzrjI8wiHylXPcpgdNk
         krqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732998; x=1748337798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD9HrbKHnhJ4K0C/4DmxBK8ifQh0KlDxWTRCTkR52/w=;
        b=hwZ2gJ1g4YURcmuq1/akLo2xmSRaBke0ptfN1NLuju8Vlq8wXU9nSFL4NlWlsD512r
         BWDzzyf18T3XQ9xmfNO6nmLGrYzHSZCypUMzYlrE83j7h8GiAaBRAIwMez0RnuwzItUZ
         YU1llv2Wh0j8KuIDJoMfeUlA/h3/6W0ZhwLTx4oA/fsuW3/Q2Zs0BWQLV+e3mX6NzlMK
         khUPR4gGxo/09LLTcHzrmi0K/+F9RGDmtZZ1V/NFhbczKxkAHI7bwVaSICici0VEICoM
         GU2xQIDqfOYVdM94F2nibNCw92F0IldBYEc68fiUyj06G/Lt0cjcwW+lzOxlJBVz6Gyj
         3/gg==
X-Forwarded-Encrypted: i=1; AJvYcCXIXwAl9ENgwKACsw1HHEJoLWLf/nC8UBJRVEAKfTOI7Clex/4aG4dwj4Jeq4Bk6bdT7ZB8Gf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLR01/D2olXDiQs5misyLF3Zn+m7tuWlfqo45eizxZjFpny0t
	qdpf4jYHR26fwe69lJBzlmxU3aIPio1uv5dEfhT2iPmZIneR0t/fViqUQbdcRZcJoRM=
X-Gm-Gg: ASbGncs7qYlXX+1NhgYdKRrbKEo1NzRDVQ3irV5EVHhQ6jvro4uuGriV8lj8FqinKQH
	B9M0vhcFi10LLeaW78aaKwn34GQW3SO1W0aeN1uX34cAWr2qQ/RYJhQOZ/xixAwV3aNC+TzRjfC
	BIOKTCK4/mEIwAuRv5j95/fn6y3ksBtEq36FQCFIk+Fq/0LA3OXCeNoKSXS1X4fzxPZDdEVnPbJ
	uX7LikqbLlZYu0tx1wiSRGfgeWqaNFpF5nV2YtiAt+BU7Eb++6KAfcRS3XwJs7Hy7BduSEikpDN
	2t+auZ0ojSbqCzsT8JvHeD9q63usFwBigNyku84Jwu3cPDBahlbSo3Pbw8OsJ3YJX3etY2OA7pU
	IHBA=
X-Google-Smtp-Source: AGHT+IFTNkO4oeYYd+isFnT8BAYXSbncDCnTalzxGlPlPp4KRDRw8uh9ZRJhgwZ2auOBgfYcmOOVFw==
X-Received: by 2002:a05:600c:1e1c:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-442fef3e822mr165415425e9.0.1747732998458;
        Tue, 20 May 2025 02:23:18 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f062c7sm23389385e9.14.2025.05.20.02.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:23:18 -0700 (PDT)
Date: Tue, 20 May 2025 11:23:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hillf Danton <hdanton@sina.com>, 
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH (EXPERIMENTAL)] team: replace term lock with rtnl lock
Message-ID: <ooxxjzmbid3jb4optotv5ptzdh253wgwi3v3omo5r7rxl6vqac@7l4rrug5l2z5>
References: <ff1d684a-22ec-4ea2-a6ee-fe9704a6f284@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff1d684a-22ec-4ea2-a6ee-fe9704a6f284@I-love.SAKURA.ne.jp>

Sat, May 17, 2025 at 09:32:20AM +0200, penguin-kernel@I-love.SAKURA.ne.jp wrote:

[..]

>@@ -2319,13 +2301,12 @@ static struct team *team_nl_team_get(struct genl_info *info)
> 	}
> 
> 	team = netdev_priv(dev);
>-	mutex_lock(&team->lock);
> 	return team;
> }


Why do you think this is safe?

Rtnl is held only for set doit.


> 
> static void team_nl_team_put(struct team *team)
> {
>-	mutex_unlock(&team->lock);
>+	ASSERT_RTNL();

Did you test this? How? Howcome you didn't hit this assertion?



> 	dev_put(team->dev);
> }
> 

