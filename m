Return-Path: <netdev+bounces-132389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D866A9917F3
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 17:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CC11C21294
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FE115444E;
	Sat,  5 Oct 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF9P1d52"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8A155756;
	Sat,  5 Oct 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728143439; cv=none; b=KnJRMGJ9BiSij7ydNc/BCoH7CNHeNm/NHc6bJyzWb8zZ06xyy0c31X+10p5k2OZbUoWw74UjbGubiuZAfL2kvo0ZYKoUgN9bzFVf0jXhD8w+Nb6a/DoyEmPRaWqv++IebLTLqK61NhT85nTsqT2NdGguuqk92pyAifUbWEi9q2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728143439; c=relaxed/simple;
	bh=gVufgi5ieEUb7c+F0xqwV/AYZvlXBZANCJxzJMrFhr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6DCCZOfPvo1fVtQ8sJupoZSBc1smo32x7U7uIjavRWFBBkLDjNDBdn38u7SJEdurFwMMF3TB3NHAV0Xph3WN24/Pi5PHCNlJgArpINQj8Wks7cRz8/FuKoyqhViKvJ4WtnobZVft6XpQmP3Kz+TMeLMtCE4FzX+MfHm2Uy8ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF9P1d52; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5e77c6ed92bso1891300eaf.0;
        Sat, 05 Oct 2024 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728143436; x=1728748236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=REtgKggo44ri5JobvZ/IoAC5pGx/FtllU5izUlzT7yA=;
        b=NF9P1d5285GfvLygSY58Ic05bodxjevDiCDyjoonw5P35dy/j/nsaOCOVo35N9srrK
         E0bOQL0kCRqkZ0FkxZ5uM+L8EcLDfcoOjQPmP4SkfZ8SYE3TGcl0t9Eu5D4d3iphwTwE
         6rtVHx7vCZ4eds+5EwDFUD5cER4BYgHhGrRVZanG2DAM0TBPPIWAcjP89RncG7stpxC/
         1N2NkI59glVG23sUTUa7EpxSTFLFVSYVMzrLfbMMfuOf9xCf2TQ8B9ah6byGST23Wh/E
         Dl1Oxv5w0DwPavZ52mROTCVpSuP4wBS6rXo6C/9mmQKiZqVrbVhPCii/Lextb+LU5M7m
         Sptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728143436; x=1728748236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REtgKggo44ri5JobvZ/IoAC5pGx/FtllU5izUlzT7yA=;
        b=uMcJNAxKwJLcf7mG21X22gMicJTq3fm4c0gRBtJy9SXljV7ZluWOPHIYrFZ7Tv1yGS
         2PSiCHkFIoM13xCSBMHMogTdllS+wfRwAt1MArC1Pf/sy7YxsePomxLLQpam6VoP0laS
         K6uh6BeYIdmEklaO9+SNlvy2EGj9noB5S0N4sILxrVgIKIn7cWcIFEkY+9nqd2NV5fhP
         L65WtPDAlf+qadRynq0qFFQD5rNxj0c77sUfFlG0ppWcSGa3gfAR8AQItLO0hw4M8blN
         IaUbyP14w+M5G8vJVMWGwKLXuscBFSlQdzY+r/0bD9WoP6lKGxSn9sNJMDUdX0JZcvsA
         qg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4LTIlp3LO3fmxN8JpElMYndtY42XenlAeOimLOdnu6moWY7nSjutfLgKxoC3bFk74TvMndvVUkwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEjYHM46ZwsPJHySG0e142IMVMX6qjyxiqXHFF2U97G9HK0uX
	9i4h/n5aNRRm5Qbtf8VwRS+E/KOCegLMGC8cGKPuomSThiWPkrYSw8dtR+EfCK+M3pgdTT3euaP
	7Yflx7gguO8QrSjClkBR8rMWRzX/ZirtJ
X-Google-Smtp-Source: AGHT+IFVdEhPRpqhXaq+Jz2/oKykkRmjg3r7SqCiHnq26reG5Z7DbQmKRM/05Ce6J5JJLF1ROlpjtpFii1UCztcUkSY=
X-Received: by 2002:a05:6871:2b24:b0:27b:583b:bfa8 with SMTP id
 586e51a60fabf-287c1daff03mr4219815fac.17.1728143436540; Sat, 05 Oct 2024
 08:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005105646.7378-1-donald.hunter@gmail.com>
In-Reply-To: <20241005105646.7378-1-donald.hunter@gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 5 Oct 2024 16:50:25 +0100
Message-ID: <CAD4GDZwOD+=EdSUv9zYcLKvFxiUhOkr=Jxcv4UZU1-2GDRXg_g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] doc: net: Fix .rst rendering of
 net_cachelines pages
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-doc@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>
Cc: donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 11:57, Donald Hunter <donald.hunter@gmail.com> wrote:
>
> The doc pages under /networking/net_cachelines are unreadable because
> they lack .rst formatting for the tabular text.
>
> Add simple table markup and tidy up the table contents:
>
> - remove dashes that represent empty cells because they render
>   as bullets and are not needed
> - replace 'struct_*' with 'struct *' in the first column so that
>   sphinx can render links for any structs that appear in the docs
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
> Changes: v2 is just a rebase on net-next

Apologies, formatting is broken. I'll spin a v3 tomorrow.

