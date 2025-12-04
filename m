Return-Path: <netdev+bounces-243651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA838CA4BAC
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6E1D302B123
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30B155C82;
	Thu,  4 Dec 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiA+oq9p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F22FF67C
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868583; cv=none; b=o8Hq7QW1tvOu/wR4EBEHURG5PjT9zrX2iwGLnSKEM0zWZwC10Eh0PfRbxLXgyXKlPNXCbnQTvFiDekgDDrEXi5472mafo7GYqM7Y40AtZSGe/VK2gcw4+qEvmQEcetbTYwsDqyHDTGRen/hM0CakQDnUnTnxNQ6qyv+oo/Z9ZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868583; c=relaxed/simple;
	bh=km4Dh9hQxInKzZx/6CVtSmfiE01GeOx+hzC3RItzZCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ0+qhbHZqNLaS/wHNpEUTcc/ZDHeGlwkzeSM1caTpX72W8+lV+DZ9vV+tU0yFhzcJoUe3gbXMdTowPHKOEjPPueOA2fRj+5e3k/o0Zok6k5t443WFiyjT0f5D+4iqe0Aie8FIKgWtvU3+/4YSLOVPeIwE+Rz625n0oQCwypBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiA+oq9p; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so1224724b3a.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 09:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764868579; x=1765473379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9as9K2dHITRu6IU+yIjl4J9GL6vgxblmI/uo3LDmiDA=;
        b=BiA+oq9pF4b6fLwzzpFCXc3BWr2q7jmMqSh7Y1G3BALUyBhaEmta8HkkX3qUHa4H9Y
         oI1s5FC66uKaW3k42HXLHdqG46JyjGZunzg2oLW/K+bPSuzy8xapjecNrnPBs36TocvU
         Dda+FuY7i5Ti6TinHUN95K2A27UkuBy6HBtwflNYQDyeAzzvh3PyqakZRmjx7jsUWKv/
         OhCy7DGnm92V1HCzfcRyas5gImTgQkXm8t1iFW4TcZTHcJLWRzwn2u+GerHMs5QaCHsW
         PNr3lCrasUwnrxNv43Fr3223E3yh55PFoxRmR+hkl/1T6QS8yMqm2ham5i+fXwetIaIy
         CUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868579; x=1765473379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9as9K2dHITRu6IU+yIjl4J9GL6vgxblmI/uo3LDmiDA=;
        b=NR546jPnbRqgi6K7SmzVCZLlrJQzzqSPXD/6Ev5HDQJ95CwgIA3DbynoWxXFMQGYga
         KO/rh24nYGELVEEBP7iqfbLSFNcDKhBEsT+74QahatiGL0euGJi85NAUaCmL3MUQfAMY
         uIWoCJ1aj+jOCDg7fYYaYCBYHuAVK/iUvcf7gkuUTo5B7i6JyWw6Yj82/KUfonvLYTOX
         St2wV8EniUCWx590CHnDlr3scxrmI3MnAFIWR+CHjR0QOJBaY+GXOFMsdn5N3Tjf490i
         kJnj0C2SVlY3teLwxu0PIBD9v5g8jj3b7O3bk3YO9Izi8gxQkmW6TCdVK43PkcGSCTUc
         G/ow==
X-Forwarded-Encrypted: i=1; AJvYcCVEorg/Kw4FGO/MI5no8hlbz5XdtPubuSozI0279yXQfckCmMr9NSIgtvV+XLagwjFeaKfJfZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcE3yCMknKM/HN2055SkEobG8iYasPbbIRBJSibeZzyjZ3x583
	pOQYqGsCdx5QaJEsfYsvr4149FBwT2cfnYALoChHgtCs5ksUE+UoND3t
X-Gm-Gg: ASbGncvNZqTs/M0mJzL7KpplPeE5BtPjvsDwZ1kqfwLALBRs8XftHdP64XFkNv8UV5j
	XKDOeurIMlfeZ/6taWXRPavnOfQnWkUmRJGNSKRtLQuf7WvWSqCrej8SxHjRnkVY8XiHzuXborx
	ZRhgSRMuSH7OCl5QEQ6DUxabzawQvgNlC+oRboPwBpCvbugbTM/a3fcOaxD3wo95bg1YNyuN2lF
	20PqzmV76tUyIx1YTHKD8cfDDzyOTr/IZgg7514TOIDpsRRLAFj4+ONo/Xjr/se/TV0/5mJOSlA
	Po3emdpD9lj51mRE5k5bkJeivbi2y66x8/l++t/4b5J8jY0BU882lhMTImD05LSaIiEAVnI+moU
	2P/VTvaftS9RLihaOzs1XLvlq5ChWrtJmIejt1u0IIiLYIAF7I4sOtNPhAvW81A2R6B8gy68lf2
	ThDDxlx9T2d/98CbHQ/d7iTB0=
X-Google-Smtp-Source: AGHT+IHAXVYFQ4q367vSeW5sz0uxGvn2ZjIkZaA1NzUcPpPtZ5Mf5JbmRDgnfViVXo5wuRHDOwdH8g==
X-Received: by 2002:a05:6a20:958e:b0:350:1a0e:7fc5 with SMTP id adf61e73a8af0-363f5ed53c9mr8451647637.60.1764868578709;
        Thu, 04 Dec 2025 09:16:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686b3bad4sm2375297a12.10.2025.12.04.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:16:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:16:16 -0800
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
Message-ID: <536d47f4-25b1-430a-820d-c22eb8a92c80@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204082754.66daa1c3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204082754.66daa1c3@kernel.org>

On Thu, Dec 04, 2025 at 08:27:54AM -0800, Jakub Kicinski wrote:
> On Thu,  4 Dec 2025 08:17:14 -0800 Guenter Roeck wrote:
> > This series fixes build errors observed when trying to build selftests
> > with -Werror.
> 
> If your intention is to make -Werror the default please stop.
> Defaulting WERROR to enabled is one of the silliest things we have done
> in recent past.
> 

No, that is not the idea, and not the intention.

The Google infrastructure builds the kernel, including selftests, with
-Werror enabled. This triggers a number of build errors when trying to
build selftests with the 6.18 kernel. That means I have three options:
1) Disable -Werror in selftest builds and accept that some real problems
   will slip through. Not really a good option, and not acceptable.
2) Fix the problems in the upstream kernel and backport.
3) Fix the problems downstream only. Not really a good option but I guess
   we'll have to do it if this series (and/or follow-up patches needed to
   support glibc older than 2.36) is rejected.

We'll have to carry the patches downstream if 2) is rejected, but at
the very least I wanted to give it a try.

Guenter

