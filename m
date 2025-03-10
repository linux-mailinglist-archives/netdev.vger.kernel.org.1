Return-Path: <netdev+bounces-173391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A51A58975
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 01:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE84F188B08B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 00:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F9801;
	Mon, 10 Mar 2025 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="RilCGogK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC236B
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741565177; cv=none; b=lvgn4mLo5JL6HZAp96jC1XvV+xGWOjHWQnsbdoJsN/iNnVRuYcElNWEJUxLx3p7BWET5ot/KeCq2rWxK2a31Yl692Gi2RENwElFUcNqO7q4Z6rWPzkZKbzU1Lh/6cZ135PXx9CcdqHCVBMTlIWnEiVi4J2dkZINk+0tZn0lGkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741565177; c=relaxed/simple;
	bh=m6XEUcrTpPwZEHflrjnh/BPbH7Bg0GPomcNh5442eok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANvX1vWEqgZ+b2P3l97VpkAMUYGfxisac0QhMLy7khyUN4Yx8KZTMgzITqd+3nrXiiktNzrqHSNUeDnAFcpXsrchHcW6RRIw1XMu1rCcIncc/hggBFmTN0nNhTgINGOyEwPE4urf2b3j5krQUiPbw2LURl0W6f8/5Mkfl6QBHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=RilCGogK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22185cddbffso81658945ad.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 17:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741565175; x=1742169975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr7b1aIrTaXs8xinUufgOuqmdYKM5NqRRUzXoEihUSs=;
        b=RilCGogKatHYIgYw5wHJthDzakICxj0gEiEljq4wmo45Tk2FO4O5ZzCHMZt0SkHf82
         8WwOVsR6UUvXec38H7MQbHUM6GV2pserSISBLGJMmVvAHj/8SZeFBRkOnIGxhwNOFpkX
         DDwsY3rusON6fhVx3Gu7uIhg1GRAcmxZs3B978qbjRrHEZRvkllk0R+lpk2UI19tEnWu
         vO7jp4bZ3UOnGVFC/+kV4A+Ye9ZGrdEUvngsDtFWdpGrN7C5KVpva9ffVjpCKD4CeBA9
         xwxL3jqle+6Ur4Qy7mwC13mInYgCbqEY3wNoMvKUl+sxDi8xRssxdFDUE1kmTaU65Kla
         uj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741565175; x=1742169975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wr7b1aIrTaXs8xinUufgOuqmdYKM5NqRRUzXoEihUSs=;
        b=NgmHbr7wr1YGArzXQ69oRSuF675TFegh/tbwav6DzgBfP6UucSa1ayjoiHa37nssPD
         Ndoj1aOqeZblho1oFH1e6SjImaGoQtnPhOS0mO4sUTt5vKpEbGmHQ7rhittcBWfbN992
         iF5BFO5BFOryMYqoQAX7+DCXHgvx/n01+V3jgd4Yr+WT+iwKTnIeMQhXCa+jXuNaSn0I
         2sufgQfUeSVBUh5VBKJ87gLCGG0qYMdwEIwyyH7qrEkozrnP9td1Ydn8F6vB1rVxFsht
         eOicjMkkwkbyBhZ2eykpSi3TRRn5yDKCmvMdgFoaN1gpWpstS54XEX6S0598GbRVW/5A
         Zrlw==
X-Gm-Message-State: AOJu0Yy4j5KLVUNlVRVYAYq9VbJ6GegE7hAHNuNs3ETEGGFjEmE5NaRr
	78JoZjoe7foSLueuP/udfNgpTmfzWz6g6ZSUUyVl2PFrsBISGifHG0kHZa0dq8o=
X-Gm-Gg: ASbGncvPGt8TLBBQiC2QW2r6sK9Lv+f9nAOeefGOxxsTj1xd9nTHWirCv0FWLo58I4O
	EBvkgdvs7/r08UhLZJjYOrV12LXOeAQdqtzGZopnEnJ4Fr8+Jh628Mhwj9cDli8re82lOpr1bH3
	JUx9nAhw5fahSPcBswXTTVrVOlnzZVxqwiAnBRIDzTxwar8tbBJsuBO9UbIZvfm30ATEmvi2cqy
	2imiXBBdDTV4hmyaB/PfZN8TKBxDOLqf1jkat24A+OzcgSFQsjGAoA1yHUcYX1Ds1F8K8+j3hBq
	pChI1/Rar+TpEmAKwnd0pzrPC3ONdYZjF0vf7Fq8Vkkfr6203PX5ajwJKSDDLkftccUtkqNO7Ur
	ML+mFzESnk8/niuUwvLwJPWCVULgFO+Pi
X-Google-Smtp-Source: AGHT+IH8Hzf94fUYsar+p2E+CLm7/XS/ao0As9lG7mg9tHHKa3yPWBe9tHbwAASkCO9/R6WYMB06WQ==
X-Received: by 2002:a05:6a21:a46:b0:1f3:3547:f21b with SMTP id adf61e73a8af0-1f55609e768mr9830488637.5.1741565174744;
        Sun, 09 Mar 2025 17:06:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736a5f9032fsm5875313b3a.166.2025.03.09.17.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:06:14 -0700 (PDT)
Date: Sun, 9 Mar 2025 17:06:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Andrea Claudi <aclaudi@redhat.com>, Jan Tluka
 <jtluka@redhat.com>, olichtne@redhat.com, wenxu <wenxu@ucloud.cn>
Subject: Re: [PATCH iproute2-next] man: document tunnel options in
 ip-route.8.in
Message-ID: <20250309170611.6f495971@hermes.local>
In-Reply-To: <528cee6bcfd8ff5b4d294d5b59d5c1ccfec18e19.1741030368.git.lucien.xin@gmail.com>
References: <528cee6bcfd8ff5b4d294d5b59d5c1ccfec18e19.1741030368.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Mar 2025 14:32:48 -0500
Xin Long <lucien.xin@gmail.com> wrote:

> +
> +.I GENEVE_OPTS
> +- Pecified in the form CLASS:TYPE:DATA, where CLASS is represented as a
> +16bit hexadecimal value, TYPE as an 8bit hexadecimal value and DATA as a
> +variable length hexadecimal value. Additionally multiple options may be
> +listed using a comma delimiter.
> +.sp
> +
> +.I VXLAN_OPTS
> +- Pecified in the form GBP, as a 32bit number. Multiple options is not
> +supported.
> +.sp
> +
> +.I ERSPAN_OPTS
> +- Pecified in the form VERSION:INDEX:DIR:HWID, where VERSION is represented
> +as a 8bit number, INDEX as an 32bit number, DIR and HWID as a 8bit number.
> +Multiple options is not supported. Note INDEX is used when VERSION is 1,
> +and DIR and HWID are used when VERSION is 2.
>  .in -2

Please run spell check on any documentation changes.
I think you meant "Specified" not Pecified

