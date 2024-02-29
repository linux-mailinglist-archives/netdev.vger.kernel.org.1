Return-Path: <netdev+bounces-76174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE2F86CACC
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67CC1F2194E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBB612AACE;
	Thu, 29 Feb 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMCD8Jow"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08624185B
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215072; cv=none; b=cX/sD17u75VugXDm08qWoOeUzjKP3oqKxBZehgKa97jZzWzCeFB8UZGH4+/074AUC9Dc3UXef1GOCrF2A1/rBWD8iLqEmdx7IhkJuY0yS6mGtO5yTLV803/Bp2XPAj3h0uYcgZ+eHb1LVIOwhYlTEgXAHGABuhWaAotPBWcnalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215072; c=relaxed/simple;
	bh=Fv2DYrsyPjgpEz3MHo0zFPdfEXKEXfaymXirNrhuTXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuRciADPMledI99Xa9KpnXV7RYOqKjf9fNk9vWQN1MKivMzZDR84nOyD9QGjCdsiAIXU8clL+6qvzqltYCmbZOva8Mran7suEQ2vrZuMSGb/DrH1szk+jvWqw2IMGcrSvHuICet/lkvYFvd/uznpYTCX3dmg5VQ+rF0cuLJSZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMCD8Jow; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso3474a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 05:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709215069; x=1709819869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fv2DYrsyPjgpEz3MHo0zFPdfEXKEXfaymXirNrhuTXg=;
        b=UMCD8JowWYLgKVaGQr/LoTR9hDOV3rdbS+Y0RgLIXgh0jQzd0G3j9+i083DC+x9PZT
         zi7y17bvaXuFIsA+bArPr6qLFZcUbPWnHmbzBRWNPJ671KK7WF1hR1NaEzy6e5dgQbSm
         qQJTWc/gLt1U43L0Sd+1LyXAJxep1ImbNh0SkkQ+YbzFq89q7TXntYq70j1Hz15Zj0hq
         m6a7dj3id2nGu9EMp7yblinL3z/aqjOBsaUUtLzhxvOvD3dBK62uuVvwqDkjstpGOTRV
         R7k/ynwKJuluDJyw8jWyUc9MiRrRPY2ATOxzNB7DHTODZkDoSSyBI0J8g/6BFLMbDhRw
         EPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709215069; x=1709819869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fv2DYrsyPjgpEz3MHo0zFPdfEXKEXfaymXirNrhuTXg=;
        b=TqETXrW33OXI4GR7S5KmOdL6nf/R5IgRNkp3wvuo2RLs5Vm0wqEUmeA1yipeoK8+YP
         lpBTqV64KG+fKz+cU80odSEVKNVbKsEPyhXs4piizNiOsJUU61M5j9KyTcm9yjA1p/Yn
         WKMUmXb6hXKr8JdR+GEG5qI93oNkLEtiBJTxyFQ9ltEkzmVi7wjJtiSvXkr/ovLJPetK
         IHItnxWMR+XkhMmTUnMXjoAtXPmHkoiTPhapkkMsg124a1f8oc4L1BwetO9i7rBUMoaN
         Il4SAQwVt0f6EyjbtOGZKEaSnVe7/HV3/L9HaPvJ/ih8KG3hR17+hmxA3PeQR4vyey5j
         0OVg==
X-Forwarded-Encrypted: i=1; AJvYcCVcTxuBPrH6OkL8rTwuj2uaJQyJkEI+Q9eRHZSOO1KjF6zP5LsKxrYzKKDhtmFMlOlaY6FXMRjY9ICpJEyh9xlkKO+DHKcG
X-Gm-Message-State: AOJu0YxrOkp5i35OnYIOKoGNMH+8G41ac3vOPrx0M7+DutCOta9G6aLK
	vowAojQKVY0V9EyIXbLq4WQOU5oUcGigFSm8zn5mOGxurwTBAbcjkfhXgmgbUC6TV1EbXiHoOlB
	uUik1o00lr7hcXo+WwS2FHDi1aqI+FPXjVNt2
X-Google-Smtp-Source: AGHT+IF+gav+vAzO4/SHoscbVikex8sNZijrcv09ps+/s0hx1QOf/4snxhbCBOp9tC0DvSZ6ErOR6AciA4cOQ1FHu6A=
X-Received: by 2002:a05:6402:714:b0:565:abf9:1974 with SMTP id
 w20-20020a056402071400b00565abf91974mr128587edx.2.1709215069181; Thu, 29 Feb
 2024 05:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229131152.3159794-1-edumazet@google.com> <ZeCMygAPmudDnqbS@nanopsycho>
In-Reply-To: <ZeCMygAPmudDnqbS@nanopsycho>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Feb 2024 14:57:35 +0100
Message-ID: <CANn89iJGqaT0YzgxgDZDHB7YuH_8X8HWb2xTveub86gHQks9Ag@mail.gmail.com>
Subject: Re: [PATCH net] geneve: make sure to pull inner header in geneve_rx()
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, 
	syzbot+6a1423ff3f97159aae64@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:55=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:

>
> Odd commit name :)
> Fixes: 2d07dc79fe04 ("geneve: add initial netdev driver for GENEVE tunnel=
s")

Indeed, wrong copy/paste. My mouse is becoming weak.

>
>
> >Reported-and-tested-by: syzbot+6a1423ff3f97159aae64@syzkaller.appspotmai=
l.com
> >Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

