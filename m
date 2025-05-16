Return-Path: <netdev+bounces-191019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36566AB9B39
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E29503F94
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B32B239E69;
	Fri, 16 May 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBS5EVGi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C2238C2F
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395556; cv=none; b=DAdRsYu7uGvazpZkzei5nODU/QbWNwJhWKUvpNw3sXjS3BDOkqtoq87WrCEmvt4Si5/QRwkDNCCiFob72jHsKiS+ZooF+ufZ8YF3AG7WhnBE0kDOiCm/RJGUXL4WXSY5AhE8hPVKAOd9FsElyth6pjLsLueZmAmU6PM8wqSkDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395556; c=relaxed/simple;
	bh=9XA0zdRY1OHhSlvOUUg0KS4o6VixAe6SafkZYxa6wr4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=edXgwpzlydVumWoC/7+l4a/1bgKrtpwM2UaSz5VfqsFYVEQUWC9lO4IBgrwry2C2MMkyBHYNAp+m+VuKxNK6Ep7YFDt8bsKE4dd87hiuLEGD4gBMKngAP0VMB8l53gvPErbcX9iTR5xEFmHWHBrxk2i200FaNCtm3iQd9LtvhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBS5EVGi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso18053085e9.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395553; x=1748000353; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XA0zdRY1OHhSlvOUUg0KS4o6VixAe6SafkZYxa6wr4=;
        b=BBS5EVGiWMuU9dDqS+6s/3keF3wl63MlippiE2/EUQuTFiwdTuLf7w3ENbR+W++2EX
         pbx8zYd5eZxFUsMaKK3un5cgJFMnXA8kAAPC6XfVlBvJ6TXCZAu9hzOgyUWeik0z/o1w
         CP0kuYOqJSd8jLox/b8VkLChP4oq+ln/alCu0Fkf3lckrtA2RNu09Tp/+89n6DQvZHWw
         KxSib/s47Z4+fftnSz80DTLLOot8ZTs/dl1fh4PVftmhW4gbuMAOjL+uc4e7R2M3z0Ii
         I617p2sjTSobxJ8hJNT1B6DVw0n2FXoW0pB3I6hpNt0u2a0O6vCv9kl6xe48j2ufF0u1
         nJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395553; x=1748000353;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XA0zdRY1OHhSlvOUUg0KS4o6VixAe6SafkZYxa6wr4=;
        b=aDyq/rYz6Nfg6u1E0kqqeLS81CyeocDnNO9Jdfp96kSSO7wVnG8EJSr1ltBlL5Dtjb
         Z96s17bYkA+/jJjotj8TA/UwfbsJSraaWxqszGmfYZCaRHjX035lHXBqsnVsgVzKZLBm
         Gkx5wILbDHXgSIx9a0pxjM6vH9PYoxSRVx75mI+ehc1ho5kfQQP+er/sK1TFrd5UlcsA
         5yYZznrfltCClJDDbm077aFny0dglfZuzYbTx7iYR4gcswiuKPuIGy0QwppmgBB5KLjw
         L18ofz3cBzr3B1RKaQtb37UOvf/6nq72H4kHFjPWcmMbV/wy/J0tZs1c12hUP36vF4IB
         Ubuw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Th+om4EOZguWtxzHdPSTZUf3YSm6zKCchRzXX5k4sfKfWx6sFZabbkVXxrYUTwMOC6frJ3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFFJVhL/1lHMf43Rf6JFfjflxRIWFyaZMEDrSa5/9mvMTmPPK
	h6qoWJCXVfaCg/Rj8JUBMYJdmMT4cdcE3LLWnA/6t+d6U0B5iBCBpUaG
X-Gm-Gg: ASbGncuNp+/98FgaJf217FGFpZ3R8BBMBdlk2QIdg3Fjg67z9ajqqPC8xdRzWdambAg
	eEOV8hY+SxEFqdAaAwAwtxhU9AKWExdLjHm5aFw9pLBBUPwFL3bP3V/+sWFXH4vkDU9glZDbM0a
	nitpECEPObfXDhCXWj/Hxbp08R0QBhoOfuUZj9WxGqAUdyG+Xzy/ORUapf5YYhtyVSOPi9wgtIP
	2jRcdys0apJ3RA+OWcP5tsuOxn8pH1nOLAfDCeeBo4EnLEmpU++cRzm6dUcK5HUCyeBA5SftvbC
	d3BpkHMPqEe4JCKmnK4i5OPr5SYy2fnLHCfStM5g4uv6+iZNMkCe0+s8NXUX2k+l
X-Google-Smtp-Source: AGHT+IHE4dg4iqXuE+2jmCO/XGp3bN4CRAAAXbPsMRbYHUESzw/vKswNkwd5iSV8UAlGyvAX8EpuFA==
X-Received: by 2002:a05:600c:37cf:b0:442:f485:6fa4 with SMTP id 5b1f17b1804b1-442ff03c45amr24436725e9.31.1747395552653;
        Fri, 16 May 2025 04:39:12 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fc98:7863:72c2:6bab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd4fdc73sm32891575e9.2.2025.05.16.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 04:39:12 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  nicolas.dichtel@6wind.com,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 3/9] tools: ynl-gen: prepare for submsg structs
In-Reply-To: <20250515231650.1325372-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 15 May 2025 16:16:44 -0700")
Date: Fri, 16 May 2025 11:15:54 +0100
Message-ID: <m234d4oo85.fsf@gmail.com>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Prepare for constructing Struct() instances which represent
> sub-messages rather than nested attributes.
> Restructure the code / indentation to more easily insert
> a case where nested reference comes from annotation other
> than the 'nested-attributes' property. Make sure we don't
> construct the Struct() object from scratch in multiple
> places as the constructor will soon have more arguments.
>
> This should cause no functional change.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

