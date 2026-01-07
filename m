Return-Path: <netdev+bounces-247907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D39DCD006BA
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 00:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F483301C3DB
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51F2EBBB2;
	Wed,  7 Jan 2026 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcAsKVGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A4231A23
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767829901; cv=none; b=cHfu1+iITvGzvcQkwOeiMxkP4W6RBQMG76v5/huc1bpkZgELC5Fjrf+UP6nZPusUekMkv0xb03axDeUYlZ7FCn7mF66WxTSW1zr8Z+uJw9RZFSqcEJ8vPpppu0GG8tEPDRmlQ6sTA477jocHyJlIXTN4bArRwq0z/REh+Fs8AkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767829901; c=relaxed/simple;
	bh=zO4H4umt4L3BRFDuQvlC1XdVHY/+64DL9QCeaA2EH8I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jn1CeHN98Z1bck6s4xvSHAsq3lbkQxe9DArGKnqCFqNjg5UVm7j9goJM5T259dxjg5+AI1fVC9ffEZj+JUloFVYXKWDqG8T6EvcfsYmA6Ovm/rxLqR4GV+Xv5VHab3etxlwqRV/AK+z/4vzGVcGJ3iprsTK2AqiO8IH25MH/778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcAsKVGq; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78fccbc683bso32152997b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 15:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767829899; x=1768434699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW9hLedm7MESDpf5Fo3MzueU9wwSLuxJSmWhhBRYPJE=;
        b=IcAsKVGqYF8EANHFpjwGrHz1+6V6kdt9y9bNu6R+QBzkBYIgKL4V6mX5LMlw7uWduE
         bPjzicpjybvDDZgo+pzbJRvKggbceugecG7OazKJO2XhK811LuKTOxK+/8rkWG7aQXL4
         fPwnmYU+Vu2mWD6FHyjW9Y4CJ6vFvYL0gRSEgYS7RZ0pCpBaQofOlIm/LB1R1hjOVOUQ
         LRNYqlUy4ETLrOKIEfzXu9YQ30sO2aG9UmVnHSSRXuGVMD/3ffnrFWSqO84aQd7aUSLm
         URUaxYIz8YLTW9wBJLsehBjhd5T3HywubO4ezDHbaZ9EqAFA3wgYf1iLh8+xKM/BOb+P
         ztog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767829899; x=1768434699;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qW9hLedm7MESDpf5Fo3MzueU9wwSLuxJSmWhhBRYPJE=;
        b=KM833+Zyf6e+m+rOT0muSAIHlMmqBVYRBe+wato0RAnAfNV6HDqsDIrzFYeeQlD1i5
         SYPBMe5kTOXtikxB/jqKWmtlKtsdqiegrFH7J1iymUML6sinVa1hS+10+kM/gnPcZU7/
         FQ0BIWPQ5aRQIXmbctjrb2ACujmBaczZU1Jc7SPj7hpUdIVBxpkjKmBArc72mjodDn/M
         NO3JNQNADA0LldDJheiG+Igax1wDzG6fVdMOalrsauKzmqOMYiNjFoZe+BoPznPLycwu
         NN4cVtGjGp5jrhJmj97zU6KotV9/4TlWCkSo4m7nidlBYcjLD1O9MfxCx2EftAtAUovu
         JDWg==
X-Gm-Message-State: AOJu0YxjFUYC5b3AlQfq8opq11k1BRS0WFpGSfVX3R4D+9DTycjof6Ux
	f64yEvjPkmGri+ywhNOPD8aCU/72onYccLt79iBgWDzYy10a9ifnQK2p
X-Gm-Gg: AY/fxX5s7o+oPt07JFX20ctYlhimH3EJqmXbkTyl8/ksGK7NKByE379AB9tj7iKx6mE
	pgsY6zDmZQ2au8Pl1GqlNILI/kH7+bXNun8rhT+6UCIBO/zTxHQTXXafvpVDL5RguPCHAolLEpd
	gLBPx29v+p1wyrzlkkCYzEWGPI6LwismLbTOFyXk9bx+rk+mxfUEze/t/zALS85y+f4AXBPXP7o
	a54v5ipS1ZuCA8Rp+ufX8dlp1KXUWaoFQhfL7n5F5Mo6nhVblwCCwWmzelY+wfUTwnvg1E6gXpN
	g7C8feNdjbADJUUATVRm0BFY5vUIjqEGdHx+I83unRCH4Jxuxr+6U+51PF+8voCEByH75ECbmtX
	9TVYTZzP5rUecG+ohP0ilDIF/Wlr94u/pAAh2LhZnDq1/V8OChveDeHYVJt6ho+reuNQpaJS2uE
	K5vrCLXBW+Mr48pQ87k4GcI7Cug/vEzuG6raVHkHjn3xMWsmE8U+2RV2Cl3OU=
X-Google-Smtp-Source: AGHT+IGHEhH3PA8r4SVCH2s2vrFtBLO+6iLES9vczOLNghdBZckvlVIWh5dwq2VKoBR/jDv62AGdLA==
X-Received: by 2002:a05:690e:1404:b0:63f:2b0c:2d61 with SMTP id 956f58d0204a3-64716c390aamr3631420d50.60.1767829899393;
        Wed, 07 Jan 2026 15:51:39 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d8b2623sm2643462d50.20.2026.01.07.15.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 15:51:38 -0800 (PST)
Date: Wed, 07 Jan 2026 18:51:38 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 willemb@google.com, 
 anubhavsinggh@google.com, 
 mohsin.bashr@gmail.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.191adb8734bbb@gmail.com>
In-Reply-To: <20260107232557.2147760-1-kuba@kernel.org>
References: <20260107232557.2147760-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: gro: increase the rcvbuf
 size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> The gro.py test (testing software GRO) is slightly flaky when
> running against fbnic. We see one flake per roughly 20 runs in NIPA,
> mostly in ipip.large, and always including some EAGAIN:
> 
>   # Shouldn't coalesce if exceed IP max pkt size: Test succeeded
>   # Expected {65475 899 }, Total 2 packets
>   # Received {65475 899 }, Total 2 packets.
>   # Expected {64576 900 900 }, Total 3 packets
>   # Received {64576 /home/virtme/testing/wt-24/tools/testing/selftests/drivers/net/gro: could not receive: Resource temporarily unavailable
> 
> The test sends 2 large frames (64k + change). Looks like the default
> packet socket rcvbuf (~200kB) may not be large enough to hold them.
> Bump the rcvbuf to 1MB.
> 
> Add a debug print showing socket statistics to make debugging this
> issue easier in the future. Without the rcvbuf increase we see:
> 
>   # Shouldn't coalesce if exceed IP max pkt size: Test succeeded
>   # Expected {65475 899 }, Total 2 packets
>   # Received {65475 899 }, Total 2 packets.
>   # Expected {64576 900 900 }, Total 3 packets
>   # Received {64576 Socket stats: packets=7, drops=3
>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   # /home/virtme/testing/wt-24/tools/testing/selftests/drivers/net/gro: could not receive: Resource temporarily unavailable
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

