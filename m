Return-Path: <netdev+bounces-179972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2883EA7F033
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6F53AD74C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3222370C;
	Mon,  7 Apr 2025 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzE1iM4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317EF16F8F5;
	Mon,  7 Apr 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744063931; cv=none; b=uCl6vDxRkVULo7Tu2+KjiDEYtYe/BS9OaTQwpEJZ2eqlGS+ZERnrznztiTtM15NTzcwhzT4oT4dX5sDpUVy7B1WAXcUVzCuyEoeZy87NNJTL4iqqKfJKG1McnnKAM7jKAvFM1hNoGcuxskNTVkp5PugDqFhKob6djZObKGRBY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744063931; c=relaxed/simple;
	bh=+KO5FDR9NB3gjHpmBOa8QAjj0hR5oW3JHAtOLCvZUOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgIbI8FbFsuKhH4OYss0PVYnY42fQ3dkTW75LajORhZcul1V6OHctr907bcu5L3Wp7NMRGlmd8Zux+eX9GlEnzYoGZ4eOgCCW1vZnc7tejSCIf4vhi8ijSP0Zi21rOAL2P44osVd/+Fmeo6cyLtD6NiYIUbYe8+oNkGxeQI++3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzE1iM4q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2255003f4c6so43715045ad.0;
        Mon, 07 Apr 2025 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744063929; x=1744668729; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+KO5FDR9NB3gjHpmBOa8QAjj0hR5oW3JHAtOLCvZUOk=;
        b=HzE1iM4qxJ0O8Cj6hufFRBxkgGDfuvi83oyhtkuCYMeH2nTgI7bjHO6eRyP/I7gyj5
         LBJO+dZPWOBiTQPTK6/sdVrGbG1Py6AunvHQ9MGufGAnYfJ8hRVX274nGXxcoex3Nlsb
         3Ja/7GPhKtfVhhQjGcC2viBLelN/opxIVlMWhDmzF8oGKsWRs+QIXh4PaeD8otxJtSbI
         K6LmgM7sF0y06fVie2ZdUrCyc7t0wK+1540wFfR8/kaHp7AoxSFyvA0M8KX8No6eej8J
         CKKXC1xy+jsR2QKBD6aL7wREYDVsG95E3IYzqA5njKx/rDnvemJSj03F1h+7RxJbaLmA
         pCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744063929; x=1744668729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KO5FDR9NB3gjHpmBOa8QAjj0hR5oW3JHAtOLCvZUOk=;
        b=uxLdB/qi5r7lX1DFiGwhcYe9fq5KOhKMA9tCdGN8qP6Gn22w89MiFc5bD0rY8lBIju
         ETXgu6WZlqC+4mJII3aieXDltSTrZwYeErjgm5EiSkDULqmUdEHouvqWGw2Y/mfruayZ
         fTHX/uLlyhXl9XJa8FPIb2b+XreOW5hIX0P5QvcM8zh/vZs3/ULP8+laBEXavcnRiMR4
         GSyvPK2sIh9x+0lDz5gCCoO8rSmDiB5+wxyxl/6fXv7+EvYgRoG2TohBh9OxFN20v+OI
         mRvlnlWtTUs7ONtuOhzfyYdu8N8VagxVXbfZVQrW+xVk42x0zMySZbm1CHUEaRoTYPHb
         s1fw==
X-Forwarded-Encrypted: i=1; AJvYcCUrst8ZeGTGwCUoxH4igWhM7vZpsoq18yYJBwPMfia1kNCJ4lSszZ8CdwqUclUBYfI62VouiX4vX2/XoT8=@vger.kernel.org, AJvYcCVW6sJSouL9lDn7ZyOGGydmfFGi4P84tX0eMKbffQlf4/0oqfS2PNicTOTyyWjQBtmwZqTXCdsg@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXwkry1mx2PwdQhDBQtNxtQ7nFgAOHcD5guyZp007v7AtET7f
	D5MaDZwYb+1otl2e7QDkshHE+kjSVLLdT3pgP96d9q2/PKzRAInU
X-Gm-Gg: ASbGncueJIo1w2m4Jtiw5cV++sbi9PpAtkeyZKCElKaJHPtJg2rhWmaoPxAnf1m1Pea
	qS7/Sh++LQdHU0JNEdzNSlPJdyyfqWg2mvrHadNxh8zsduYhGVN2bKEhmDEd6ehQbRCAB0f9Lto
	k26oei2wD1/EeAzpmE/SwR4BU5BWSK+New14zonk8VMzrGtrUmhO+jrF6+MRuChPCcz5nneoGV9
	/SHq8D2mHihS0K8g7sxTPCWyBVc1yTt5Dyt4aXfJanuNplPHN/mw/+iaJupJb0MkozTy84p5bLg
	+HNTyWVfiFFnhmIGyMPDme0rQPe218MfEhJOkk3sehM=
X-Google-Smtp-Source: AGHT+IEvjikd/I77m2fm22oAI4Ks5ABnEUbcCmTxIM1VAO9N8vzwrz5hN/axnWQLVcFkyCGKsBihsA==
X-Received: by 2002:a17:902:f646:b0:229:1717:8826 with SMTP id d9443c01a7336-22a8a06d686mr210345955ad.28.1744063929357;
        Mon, 07 Apr 2025 15:12:09 -0700 (PDT)
Received: from mythos-cloud ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad9a0sm86483995ad.39.2025.04.07.15.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 15:12:08 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:12:04 +0900
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: dlink: add support for reporting stats
 via `ethtool -S` and `ip -s -s link show`
Message-ID: <Z_RNtOY5PPS5A9v4@mythos-cloud>
References: <20250407134930.124307-1-yyyynoom@gmail.com>
 <122f35a6-a8b6-446a-a76d-9b761c716dfe@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <122f35a6-a8b6-446a-a76d-9b761c716dfe@lunn.ch>

On Mon, Apr 07, 2025 at 10:43:41PM +0200, Andrew Lunn wrote:

> That is an odd way of doing it. It would be better to repeat the
> static const struct dlink_stats.

Oh, I see — sorry about that. I wasn’t aware it might be considered an odd approach.
If you don’t mind, could you please explain a bit more about why it seems problematic to you?

Let me briefly share my reasoning behind the current design:
Each ethtool stats function (e.g., get_ethtool_XXX) gathers a specific group of related statistics.
You can see this grouping in action in my patch.
So, I thought managing each stat group in that way would make the code more intuitive,
and help simplify the logic for developers who use or extend it.

I'm still new to kernel development, so there are many things I don't fully understand yet.
I'd appreciate it if you could feel free to point out anything.

Thank you for reviewing my patch!

