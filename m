Return-Path: <netdev+bounces-218391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F182B3C46A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 23:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0497D565558
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D4266B72;
	Fri, 29 Aug 2025 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xf89aXU7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD641C5F39
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504650; cv=none; b=b7s9drLRI8CNez189PtNLkfR4HRqOEo6sQByMS9TCNXlhXW6GKrYlZXv3nS29Vdx09anLFLZ9ZvAiIyM8j+jAaw1PwzTHa0EbjsKlfebB7x9VV9WI/T43yFs3GiY9YUKQcRFWXbwb/ym4DIA2g1OZ2rDcNoMKgr/CAg1u+k6+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504650; c=relaxed/simple;
	bh=Z2XUfDI9VlUUgvuoH5C7vNxFCTABucAPevIMu68XIjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ummVNbs202pqJ1dCurayKWibtKCdn/RXYrvOI1RRH8PcPI/r/GlTCPk0kWgdpSo/XDxdsvRTuJmZlEBQ5G7u36K7SaWgOXlLy0xfM8Vj+6aCYeGWVeS5810hVFYfvFOOrQrJX5kbxiCbuuZqViXv2McS1XMvmiAQQtoJ9WCN834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xf89aXU7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f61de53a9so2653e87.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 14:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756504647; x=1757109447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2XUfDI9VlUUgvuoH5C7vNxFCTABucAPevIMu68XIjs=;
        b=Xf89aXU7YsE98KPa68tKMaxf/665Wte87Ysdt4i6aRMlX4AzBaWCJKHMzrj2yzor/v
         AbWHpT3XiMKHG8JfrDdwCBOG3hmF9fzc15ESpl+GZjPnR2MRATwbxr4xNVwmIP5IKu2g
         rxAHhqKkjV14XMg0q38rEu7DgVhFzStAJuLcLGp9Wlftn+w9XUtxGeo8eCRwYP99iBX7
         vwBz0ArGEQUO9X+a6xk+zvTq6QOh9gl0+rCTijKefMBNTjhdeA9XaMTRLvYUXDIUxyb6
         Mr6DA4yta4rSLkUuuh2+1v3a8hnZ+PSNW9vRk6vkQW+4FrTJ/hxCrbwcurXEbtvcxgId
         Cw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504647; x=1757109447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2XUfDI9VlUUgvuoH5C7vNxFCTABucAPevIMu68XIjs=;
        b=VSiD8RBvKBrYC2ZLCsIh2WtmfjhJni667E8mwtjyTlC/dgs9OSYb8jbqjfUbM/96oq
         v7P8C6DNsV0Xd4LhD8Bv7s7drrHrGoMBZOIhGH4sSv/5SWvI5C+7pMRKIvGPL/DHEUn4
         AbUUt0Ac+pSQiH5DS4uUP9UQ9GbjcuZ+8zGJZXRCVimgtIZrnKI5/i+rREwFGw9S3nT4
         ZE7HlP2ZT4s3YVgx+sZn4DvfdJBl8RoY7eR3fLlxOUucqb0TyOxxwrbsSmanIGvL3ha5
         hi0BzovvpDVhO2JAl0bRVGYJ0L6Df0GPDx/BILYFaf2VfJZ+oIHTIudVPtLxjjYEo7gS
         Cs+w==
X-Forwarded-Encrypted: i=1; AJvYcCVdJ1zsWWPufQjMoWLr9KU26hHLZct76zKJinDl9sqCKWW40lM9rBOKI/aIwojxOBpN6t2fPio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkk0R3vSh/SBGVM+xz3OrUXVGfmDwNyIMCQb5PAQlEIx2axAlf
	h/qeSGs3+4gg0Opqr5i1Zr1g8sITHQkQ7OSs+ym5akAWPvnofIZjPXZXKEXKXWJXMKJFAlSBLQf
	6RyYG71/bEGX32PQGNP9G6fnFxjCpLdtp8XOe/kBD
X-Gm-Gg: ASbGncvOt7dCbzbJx1pmle/H98lkokAtDjDnGr4nXoR9gnZjPjPFRQvg22oEw3XDqO6
	yXpvZBjf72wsfHk9mGKhAbNV+px2rayyOubXNKOKMp/3RHExSO8xF7wxt9JjIJdNZCduYxbmKjO
	2uWd8K52iBf5jajuloCGJbSebXpjizmNcwPN3aMWjCgNtlWZ+OdjmUnjJY/D+4jEEcFvfIdkq7Z
	DvMYiXrSFOCmruUaNoXX+D1HZjGbQ96pdYIeRcECCto
X-Google-Smtp-Source: AGHT+IEfbc2Zxwzi1GfEz6ew9yL4Efpexul3klRQqzXkM8MVE9K6KCS7KLXZUWTrMyqQbkg52RokMCN3/rGwOF5Bl14=
X-Received: by 2002:a05:6512:3ca9:b0:55f:6762:c35d with SMTP id
 2adb3069b0e04-55f6f512b5dmr106398e87.6.1756504647152; Fri, 29 Aug 2025
 14:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829012304.4146195-1-kuba@kernel.org> <20250829012304.4146195-13-kuba@kernel.org>
In-Reply-To: <20250829012304.4146195-13-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 29 Aug 2025 14:57:15 -0700
X-Gm-Features: Ac12FXyV6niJxKruYU1CUX8aMg8h6zpdn03nfN2GgoA6U946ENXumcSOWBvq5wE
Message-ID: <CAHS8izPgBw++BGnfJsR3eAsnOvp=N8sov3hPsYgcsdGdo+0vcw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 12/14] eth: fbnic: defer page pool recycling
 activation to queue start
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, tariqt@nvidia.com, 
	dtatulea@nvidia.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	alexanderduyck@fb.com, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We need to be more careful about when direct page pool recycling
> is enabled in preparation for queue ops support. Don't set the
> NAPI pointer, call page_pool_enable_direct_recycling() from
> the function that activates the queue (once the config can
> no longer fail).
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

