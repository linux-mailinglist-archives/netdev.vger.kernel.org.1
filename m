Return-Path: <netdev+bounces-191020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E063DAB9B3A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F004504A53
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5BA23771E;
	Fri, 16 May 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGPXvSm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C0A2367DD
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395559; cv=none; b=KUrp097VZUJSFESDLDsYg1yj9CDm2/sipze6eP5kQ0T7Rft7Jh8YndHaBXVIdWyilP5H0V5TXtSZRL/PAKy/2t5p0hf7GPM2VOHFYBx8GUz+/c+fLTaA6U5b0zPaSSQ9JoJdsUY2ObB7EcaOF1uwR1IJ2HWQNPlafOY6m0I5Mzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395559; c=relaxed/simple;
	bh=wNbDwszki+w92Lua93SHODEPPmnKIChbZ7/BRtV7Y54=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ca08rYVusisEQPXhFuDR4gWrOLqoD6SQZQ9RRYse2UvhTpzbdDc2qJ2HasyE8I/GSTXdgfLXZgvZBUufFKLA8O1djP2piidLiU/bJ5L8PMMnq75VtgpJVZMh9fRv4Bk/qRS04r03Yu+uS8HBJ7rjRoV3tpRAP+qlrRLHP5+HJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGPXvSm9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edb40f357so15180915e9.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395554; x=1748000354; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNbDwszki+w92Lua93SHODEPPmnKIChbZ7/BRtV7Y54=;
        b=bGPXvSm9ls782fU2cW/01WHIieN051iII7TqHiWfmsrkBWZV74K9ABK3R58g8aYQ6z
         8PySfakU6UriG7nRpZ8MdAeFGtPPHXXV+BX52hvTRwDmqr3eroNunxgYzjsXWffvdHmN
         B0aj5ObkG1BZ1jaArmU/VkUya5GJ89coUEQv0kzpkTxlAFFUs+2ITLf8Cw1ENoo/H2vl
         4EU2MLvySpuAYwB0/G0ABaiU3rIDVb97SMJyQ3IANqLU1pjHCPEyO3odspXafBVj/ZPy
         KqeeEwNxrLZ0gM87ZRPEwzyNBoancG3522QYT4eOYKsUqO9u9p1HwUH8DCtT25cO9e4L
         IGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395554; x=1748000354;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNbDwszki+w92Lua93SHODEPPmnKIChbZ7/BRtV7Y54=;
        b=K1aG6z5TkIUkgZk5cvMrbhX1qf2viuIlh8UlVu03kbjzGEf1Fq85okYBdlp5xj0dAW
         srNR1+t5+nzRxe8arjTIoPXtokWovSpdVmmpSBdEvz4rwtOJcGRK65iQkvlj4eyIJh2U
         SVkRXucAt1eLQOAxarcH8fZlYaqhYAfc0lp1Y0hPP9iZu+3Q5n678ONq00TvR5TNshGX
         BeVevI5vsoocMpmqeeEzfiZyP+6XUnu21k8n1dKrFdbJs18TbaFoEg2Vn0CgtTvXro5J
         yS7yUcdZVyAADFKncL49XADOCwzcKi4sb6YZDWPustP5lDetlyIefrhlTygM1gBKjclF
         j6zg==
X-Forwarded-Encrypted: i=1; AJvYcCUAlMEIawSk/3BSkFeAXUrgkmqpg+hRpvtZuotAVTgMjk2/s+BXrwCD+Y+RxuPolP9Ay59JCsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGqwo1CEdxQ7lhYchdQStB/jfixLCHKve9TNR1EX6DpDwSF+s
	LHlaWBtOO67EOJKHcjFo2ytqllUXWElPCT/B9dvy4G4KEAD8oRImMD9p
X-Gm-Gg: ASbGncsmHmrS6VZLoAWgHaCpZvh+FkzKuJhIp5320wdes6Sjmy+8o/dQYyNr97jE9Oo
	io9Sll9gwc5qmCA7l7vJO0fzXjgainZRA1VAElRiOzXfQviY3zGqK0HAUsackLfWQKjSPMIQK9q
	gcDwLVav31/gNh8f7cZR+9tfaYKScgM7qhJ8MN236GsDc5YL+WhxT6iDfHW8KbpiMbxJkx6LvOQ
	d5hXrdG8lXK8uUjC4zKZX0Dos7+dcxk5Qevux+WqUAeFb4vbzlUZiYb2fVjKbbyvhaDAuh22rGi
	fFA46vspyuebEiaiwHgsk3QWIFdN/qTgetcLG15P0Ju4PrH175LUz1AfdEDDeHCx
X-Google-Smtp-Source: AGHT+IHhNoMvGE3U7myRAksZa0BZK/5ZPFacaYSDzUtkAPUK+erHhhrgyBOrlcMV5ZiLykI3Qq0Ofw==
X-Received: by 2002:a05:600c:37c5:b0:442:e9eb:cb9e with SMTP id 5b1f17b1804b1-442fd66f0cfmr29188785e9.26.1747395553989;
        Fri, 16 May 2025 04:39:13 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fc98:7863:72c2:6bab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e852fsm109341415e9.27.2025.05.16.04.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 04:39:13 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  nicolas.dichtel@6wind.com,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 4/9] tools: ynl-gen: submsg: plumb thru an
 empty type
In-Reply-To: <20250515231650.1325372-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 15 May 2025 16:16:45 -0700")
Date: Fri, 16 May 2025 11:20:03 +0100
Message-ID: <m2y0uwn9gs.fsf@gmail.com>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Hook in handling of sub-messages, for now treat them as ignored attrs.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

