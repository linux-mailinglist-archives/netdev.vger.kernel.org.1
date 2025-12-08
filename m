Return-Path: <netdev+bounces-244023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA59CAD8D1
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90DFD3010052
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7642797BE;
	Mon,  8 Dec 2025 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gh012QR3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2472264B0
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207162; cv=none; b=Ltfa5kqBuEX5uF+EKt15MiDdEWV8jpS3Rubg0Np+PdePGjCCjPhw3C8ri4RHH1eIJkC3/FAeioIWaa6cQvqMLeWKuMI7liAiREPkpYb+B3FXhsJQSoUzlbCmupEgc0ZCrwqurv58MB9YnKzZDPpOu+VODGz5PYSK26vtC3b4LN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207162; c=relaxed/simple;
	bh=rrdDEXaQDKdd78sDlmC/cXdeBqqxfvjBLemaYxqI3Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMBsZZ2rCrQnPIDUzhekFAPMZ6PBZhwf76gBDUS6XYhLw1ow4RbGS5WEoyNGsY0GecubnfVSn32EwLKUEFaM3I53gST9X3XL5FcPwVwGf+cmsNFMtC+82FytUKU5Vo1Py4PbB6tnLJFi8lbVBYQA5hv9u+8okymBNSOrobssbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gh012QR3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b1f2fbaed7so441343185a.2
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765207159; x=1765811959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrdDEXaQDKdd78sDlmC/cXdeBqqxfvjBLemaYxqI3Bk=;
        b=Gh012QR3LLxP9MBxljOT06kPFpJ6QPKsKTTTOYqPt5jIiVvpbmSczekyzWQ60xuk4r
         Eydwe+1y+tyHx+js+WooP67FRBY9tbw+jp6fS5bMb4PdDMS1iZ5U91T9mZfungD7rG+Y
         JE4SbPaq1fcwLbAPGk3ghiaui6XPifERcx2oVnPVRlYpfRYmuFhTpLZ3nz/R++77iTKD
         osGRvATukIIzrhUypya4Gr1tDZvglKEReiW2iHJq/zF2sYsqOrKqkKuvEuZDGgpGEsd9
         dNBIg50/yaLk8qrxNUwUwp8BetTQbus3XkUCn7L0Cy0qrxZVvyQqYUTtfzkAqOBPvFCv
         2Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207159; x=1765811959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rrdDEXaQDKdd78sDlmC/cXdeBqqxfvjBLemaYxqI3Bk=;
        b=o/+hJCJ4wImQn5k1S9oN7YINfntyjzsSRTDBNC7RkZHoNsyErNBXUBViyL0E93qqnh
         MVBrOa+6qkwa3+EEqqxIa7lGPht2Da6rHvydktBdDUr13qUMYvsdwnel3eZNSoo6Dogk
         Fm4zOQ2K7rQ5/SvApvyY1egxrco4py3UBsNzavHN0oQ6BDKnNVTP8zgQsH0nSYw0KekW
         uojpJ4nsxYh7Ag1YFT8Ia2hGSxbUpfDNyPAXZZntVpjdFT8txiozEYv7akMtOR7hzEJ/
         wEFJtBDuVn8TzNva+ZdJt/r/jX3bSaH1R5/OGRbW7OwAmO9+ggZIjn69BhMTabFtbgvP
         0sMw==
X-Forwarded-Encrypted: i=1; AJvYcCXMwjgeK3c/WXZjLq0Mh7tjO/T4kKOXxVKz8+k5mwPdjB6kOTlJzrUI/CIm1uU77gHaIhRhcvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bcdaAXuHFuYeO0BBbLtK4jO7ouDh2vXXaevFyZxAiFlOPWux
	K95m4hEIAVHe0y8Q6jCyW0bVwd6KtT8StzA+ChOTGBnkb+1s+MkDn8bdZjhwohouEMHTLoh/ySo
	Qr4GeMPsxPfOmG2XlhlXIVZ1XoLKPLiOcT3FygUUm
X-Gm-Gg: ASbGncslQCPkDY1ljBpC7uOsbPZO+uZl7KtVmuoCb7gz/3ZPILWZLyUlZG5YEDMprUM
	d/s5nZLksAwqP/UrSaKOpXOpidk2yZhBteUAqLdezV0z3/BRSRVpuW/ujHpo0t7T6GOxwPD+dRf
	4x9HGL3sbwTRMZiFCA1JfzCJfSzJi6AdEFjZYIiHGSmahmIvfEI1pFmaz52dkHqy/g4ssJlpdkH
	lPMrx6+B4+ofvNFpeAZLRQBAYXmzG4skcsYNv2/2vUVQ0pZ5/Xfl8h0vcd2cDKCHcQEaHE=
X-Google-Smtp-Source: AGHT+IHe4WA98gFHxYr762BxNDmBlFmorn5sO8OdaJZMzpm8W64y38FR/DVOgYQKTkY94qsrhOPfdLdCYtvZCKgy2Gw=
X-Received: by 2002:ac8:58cc:0:b0:4ee:4128:bec1 with SMTP id
 d75a77b69052e-4f03fde874amr116057811cf.1.1765207159131; Mon, 08 Dec 2025
 07:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207010942.1672972-1-kuba@kernel.org> <20251207010942.1672972-3-kuba@kernel.org>
In-Reply-To: <20251207010942.1672972-3-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Dec 2025 07:19:08 -0800
X-Gm-Features: AQt7F2rVVCpqYBSftNjsko_J_IzumACZhYPrp0Ab4JflsbmYv8jDi6XDutiOzLo
Message-ID: <CANn89iKku9guhTVbnc_zGSMBtZm+r+dD03APob1q8LuijFLvcQ@mail.gmail.com>
Subject: Re: [PATCH net 2/4] inet: frags: add inet_frag_queue_flush()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, fw@strlen.de, 
	netfilter-devel@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 5:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Instead of exporting inet_frag_rbtree_purge() which requires that
> caller takes care of memory accounting, add a new helper. We will
> need to call it from a few places in the next patch.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

