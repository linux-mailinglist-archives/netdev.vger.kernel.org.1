Return-Path: <netdev+bounces-243661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE43CA4E23
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE2CF3071C28
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAD13590DE;
	Thu,  4 Dec 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEFIw/ay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C353590BF
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870999; cv=none; b=Etjow6q340ddGgR9vZrn0xJScSw8Dc0hdztgU83J4ZYsxJ0CyOsGpV/UVLydvUQvahiq60tBSb7zjv6ytsm3RkesQ8AnqszGG/FV6n9NQLJVRG0iUxLbPnpSQBtdKEaItLeXR9w8paUV+t3DPW2P2Kd39/MHZ3vRpU6B8dUV22c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870999; c=relaxed/simple;
	bh=LssZyxnB/Qt9JOrc1wZ9fPSlCWdCRitPmmyrurmq8kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTG8oCz1L498+DHQJGBS1bLxBzoHS2a13NfLK3tXbtkjo4bp+GBjfZvv3NS4KhpC1Kj1MysxLGZtbBrX0uFeG8z2myor1vDGf9m+58X7SdkYWCJLcvdoXzL9dEyOTRxMn+/phgmmoGzDF0ibPt94I1Am6SdsTuSYsc0PFcuzJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEFIw/ay; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1224260b3a.1
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 09:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764870996; x=1765475796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRdN5rrU2peC6f2Ho/CsA9zM52zEMWOlMu7pxRw/JVQ=;
        b=HEFIw/ayyhHN8KhM6O47o3ytvOcTKfR4wcPQ+DbAc8FZpt84Ejwyp/pXj/rraBRcVk
         G795k7cu6Gs1uOnmQWc+HXG3C8UxJ4+z64LAtszbwRzgGnrCPJomRVcXGJpoOSSYT1UE
         fAyefQCFn/3nnbF66t8aecoDTjOcaLar8CnZspzpc+d70UEcAYW9G8D/I/ZKHQIbM/vg
         bs9VuL+Z3VBUACQHzIfQ01WSA0c0Q1G0dt4QEK+ukUl2jFxVTNOsF6qkBQU6axesywRW
         pqlMpS1Tl9qZ/FJaB/6YfS26hptQACIQH+RT6iVTLDU2EuMqRVp1xRnymTmjBG4tKeG3
         vfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870996; x=1765475796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRdN5rrU2peC6f2Ho/CsA9zM52zEMWOlMu7pxRw/JVQ=;
        b=HtLT3MmZR+7l+HBI5CGI2bqO1bfin31MbOiQl6yLDW4NHuAoREDvHrKtydS6tkgeQI
         qY51Mvgymvm19TgMURRuwJiFJ6fgGFPBJsR+QSeyxrpdzeAk4Uh867lpiT+2v98y2L3S
         hr3dVbagSor3xIGMO+x0MqZgWwpU+Xg/NYPbvuaWpQi7sV17/9DG+lqTJ5AmNKMNx+ih
         m/8FoI/f9Tyk1YRlHnRB018jf9W+p3eruykVuYbPePfnm0PqqDwqdGOWY3fTyMEHjF72
         HnzcoCTiyK6l/Fm/3bOlV8NoFiMz4mREI31hBZvoeou4OXx8MuhBXLiIuD8ipnj4SibN
         Z3cg==
X-Forwarded-Encrypted: i=1; AJvYcCXb5AIEhZ2J828kTans6s9BAtbf44cACtuyRDYgd4z1drdd4BzpAP9R1KZzea63ojIl/afDNy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1CdPi4UgzzogXCGFoXP0eHcF7IC02rddcrTQ6Rw7Wt+JCyVT
	zopItlc5lH/Pj7azgbfUTntKjGREjpWBF+e4lehKV5XvQmQGz/Q17kpi
X-Gm-Gg: ASbGnctYQHCN+OxORTXrU6z4MtCIGvVmo31QbiNgL9MgBSleNDUHcLMoIG1NhITdUun
	kRzSWx/QWxLhX4WKgfCG6jC+DiQF6oS14kKQvwn3lR4EUAoOqSWgU8OYMKMVFEQ7e0O0fJIKJtB
	fZ67VNAnGZjfL6ptkahf6Gk3t9vBmXdxK8ZmXL68xjBx1fe/a8WmWWg3PDglfReBFrCPPUG8QV4
	1WEalxO4WTRPhq2IDua2L/AV+tlJgsUnrR4OEXsEth/kD7nHXWUU42huJXc1ryhKHyNzDGDPtHj
	fLT1jJ/yyZDgx6rg36bQ5pIRtxyfNAp6iTbuWwyCsxdv49GDrS0f9s1T/A5qvMsfmNa9wOfhLX+
	SOzDnieoP4+8/SoM61fm32BQ/kr3An6zCv5icuCvmqDbqlJRmvwZCqxokb/owi7l8ELNyURzqdh
	rtZSBhniPyn3voNLG+CYJFwSc=
X-Google-Smtp-Source: AGHT+IErVS2JOE3R5hBQa8n4PbPRX0Rck8OX69DTgD6n4Zc+qBzm/AdH+8FlYt/3YOXPNZAECFyIAw==
X-Received: by 2002:a05:7022:6094:b0:11b:ceee:b760 with SMTP id a92af1059eb24-11df0c3b2ebmr5592261c88.23.1764870996269;
        Thu, 04 Dec 2025 09:56:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm9415387c88.9.2025.12.04.09.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:56:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:56:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/13] selftests: Fix problems seen when building with
 -Werror
Message-ID: <2e069056-645e-46a5-b1a1-44583885e63a@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204082754.66daa1c3@kernel.org>
 <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
 <20251204094320.7d4429d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204094320.7d4429d1@kernel.org>

On Thu, Dec 04, 2025 at 09:43:20AM -0800, Jakub Kicinski wrote:
> On Thu, 4 Dec 2025 09:16:16 -0800 Guenter Roeck wrote:
> > On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> > > On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:  
> > > > This series fixes build errors observed when trying to build selftests
> > > > with -Werror.  
> > > 
> > > If your intention is to make -Werror the default please stop.
> > > Defaulting WERROR to enabled is one of the silliest things we have done
> > > in recent past.
> > 
> > No, that is not the idea, and not the intention.
> > 
> > The Google infrastructure builds the kernel, including selftests, with
> > -Werror enabled. This triggers a number of build errors when trying to
> > build selftests with the 6.18 kernel. That means I have three options:
> > 1) Disable -Werror in selftest builds and accept that some real problems
> >    will slip through. Not really a good option, and not acceptable.
> > 2) Fix the problems in the upstream kernel and backport.
> > 3) Fix the problems downstream only. Not really a good option but I guess
> >    we'll have to do it if this series (and/or follow-up patches needed to
> >    support glibc older than 2.36) is rejected.
> > 
> > We'll have to carry the patches downstream if 2) is rejected, but at
> > the very least I wanted to give it a try.
> 
> Understood, of course we should fix the warnings!
> If we're fixing warnings, tho, I wouldn't have mentioned -Werror in 
> the _subject_. It doesn't affect which warnings are enabled, AFAIK?

I'll update the subjects and descriptions accordingly.

Thanks,
Guenter

