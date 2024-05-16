Return-Path: <netdev+bounces-96782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59528C7BA8
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 19:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A83A28446B
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 17:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F811581F7;
	Thu, 16 May 2024 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uvk25VVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45756156C7C
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881567; cv=none; b=S9AhnEMIc4kHWgwOXCbPiaB9z5/OAUaFgebeaIGqsd9jKA35LJ/gETeJKzhpoJ9wF4M1AmxyvVHv4qVsL5/zipyfavYhj6VgsQGQtEPt7p/TSdkxqXvM+pC+O8ZBjevP6sHqcgxjmTbycyO0MMgMiD77Z0slMZzpgGHsuDYKon0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881567; c=relaxed/simple;
	bh=r6E6bcuwh58uSy+ZKgcCZUW+Is/CdxBIlTsB4jQwdaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngA140XM2CxusHP/wPEwyxaHXm9h1C9bK2OYtF0zf47mgcBCrTdagRiuh4Lou8pDj+KE65qwVFJbYjNX5Ht1IfuJhQiN7LlXSimCu+D4Bxqo5ZVFf/UtDDJf+2mQR0gP5W0/4CIZIGnqECDhDGWgqnQBqgpRurmpWpcEotG1Ryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uvk25VVJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a88339780so373872466b.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715881565; x=1716486365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6E6bcuwh58uSy+ZKgcCZUW+Is/CdxBIlTsB4jQwdaU=;
        b=Uvk25VVJ9qbuzNpsL4oChQJRfYlnagT5+r09sGWMK8+VC5E7d42aFumVLuCBUx2R+H
         O2/I4e4BQgCX8VxtxTJTuyE4bTivpQW+DwcPpWLpknm36LMKsbzc2KQERnhnZfWiG5B9
         mFdxJ3h8TGu4sq3yW09XEBiv0CfJCgILIT1H6vBlRjqit0UNJLPx3BMdn1rTRkrYW29z
         fAdDmgN265mqTniWjLbqUUgGLzMoCxHLyvBSsDM8uUCv2gguF8YyvFjEozHTpBWT5aDG
         Aec2B+fYLVJ/lWU8+5znnJ3hxebXUwF35Pi6mUGtjQDQyGpFULmoj6LjVi0n8JC1OJhR
         +k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881565; x=1716486365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6E6bcuwh58uSy+ZKgcCZUW+Is/CdxBIlTsB4jQwdaU=;
        b=gBPQAWqfynWaULKlKNNxfD2Op0cOVpjGF3H69Q4Inw+PsIb1moeXQhb3HigjXdbOOl
         f33EwGepcN3/AaXVtVHMcfNQNFdczbUd7Iz+bVEe02bdq0wDCXY672LcnDrzGjcSLF6F
         uKkJH6PXppf/+bTEnu0mAR1zlh8QHVT1ZtFjlrEyQhmN8+6MzC0KKU/r/JCWGS/K2ckC
         3iM/Be00PasqJzxJXVqjLnEA7K84bCsHRPZusokCY/VtieJqrLO1JFPc0X97q5r1HnSw
         VqroMTyFzOGY9QKgSDwpfA0E/08dmaYrhuOZxr34Ghzk2j7hKntpUK6nD8bM1GnBqJq2
         9eFA==
X-Forwarded-Encrypted: i=1; AJvYcCXRmdwcYdVzR+vwoN5Sy3hQ/5sByefUFz4HXeLykKae8sXxzg/Gg7JgUt5iMGT5vZUbcgWLC9iYyiqcMBD07YVYb5N64VuR
X-Gm-Message-State: AOJu0YzBO29//SDq55v+pWI4aWPe1JSAsoJgF0gyEHbEy4u7Cb3vFuPJ
	RGg7aiWvLOdAtnbLY3PNGi2rNYw4Rt/VrnX1R9n9gvH0BrnQP++idmMvfGqvsxfVxRA+m7D6vjg
	Mu24zYLva6bpa0Rbq08OH+7SL8K9FcibQF40g
X-Google-Smtp-Source: AGHT+IFtVHnI/HeI6RHiNHcOM4sVWOXQMemsaRcFuf/AFZHYdohKi+ZquyO7RYepjpYsIMd518QWrm82tL8e3zmrYb8=
X-Received: by 2002:a17:906:7045:b0:a58:c80e:edd9 with SMTP id
 a640c23a62f3a-a5a2d68127cmr1194167166b.77.1715881564304; Thu, 16 May 2024
 10:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510152620.2227312-1-aleksander.lobakin@intel.com> <20240510152620.2227312-3-aleksander.lobakin@intel.com>
In-Reply-To: <20240510152620.2227312-3-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 16 May 2024 10:45:49 -0700
Message-ID: <CAHS8izMRaw3TyURSwdoAnd67EHpgdfazm7-jOFUAWuCAOd39ng@mail.gmail.com>
Subject: Re: [PATCH RFC iwl-next 02/12] idpf: stop using macros for accessing
 queue descriptors
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 8:28=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> In C, we have structures and unions.
> Casting `void *` via macros is not only error-prone, but also looks
> confusing and awful in general.
> In preparation for splitting the queue structs, replace it with a
> union and direct array dereferences.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

FWIW,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

