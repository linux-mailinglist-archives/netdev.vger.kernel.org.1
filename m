Return-Path: <netdev+bounces-134052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC08997BAD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43451F24476
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5019AD7E;
	Thu, 10 Oct 2024 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0EM1WTzy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8E19ABD8
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533595; cv=none; b=L3YhAossYzIy7vP+tLy7fg+L3mEoZGg6T4Nzt/t4tQBQCoPvjrdJLA5btyr0KjssA4qt5WY2x96cGE/p9vZeIVHGOI4oqsBWmt2p00VnQxFRUb3h2q635GJ3JHg1cggJEAW5BVkyWwCmWWJonrLVzELfR9bE9k6atCumk3j+0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533595; c=relaxed/simple;
	bh=NeY05LlwBc0ajuq1r6Lvp+ySX0MuSaKuKFkUvi7MQXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZ+epxGjuNomrQEj8/u60z5iEFmZovq4TItBJSdvq2+CzBY/GRVDHplsC3+bAyFeiqpEkOYFhs8jeRawvGSuiIVrtfQhdPCUC2Oava+S6N32khVUCyPIdO5T1ENzz2OkBHbvzwHZIKrot6DDuTNECYYgzbPbiEFlSKJLuknciEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0EM1WTzy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c876ed9c93so519874a12.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728533592; x=1729138392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeY05LlwBc0ajuq1r6Lvp+ySX0MuSaKuKFkUvi7MQXQ=;
        b=0EM1WTzyfqEdVvrzi4s8pAh+ov2jymKnhbhUkSe4w8tgknr4M9A2n5tqynYtjFwuwF
         BRLAzPREE9IiyPEwWRvmZbu0FTHFMRRXeWDx8GH+rGDGQh+oaS/QMGNmGYERqQsvghAu
         XfV7I3FeNooMdZDIg6DznMY8sy2OZ8jmrCvNj+/nkIYFoflhZSfSzcQ6RLco4NFs4Snj
         gOI8ul0qpKx0hD715gOuaLwfiR3RqQ5J/dg45w8S4kptcMSFfNwf/SgjBzhSSSeXNIr5
         QqluuNBZUUEC4QEAuwyF4ywpKA0iebvVnxYiO1g45w1xH3XqzGJ/zy/FP9crbasKpQVB
         rl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728533592; x=1729138392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeY05LlwBc0ajuq1r6Lvp+ySX0MuSaKuKFkUvi7MQXQ=;
        b=p86qacYxP33PlKzOSxWBzzuIXeu6PHjeMiebaNdtc3gvq/LXNVR16P9M/l9bxDr2OL
         HIdJ5BuJ2+MMpNs22EIwvce4H1qzip7sqvc/g+5WsoCXNm2aExnNxnsGAvWJap2OClwH
         PNUY4+t7ylZvfeIa/A97+HQu0PFb6RErFAQURnpa9FTujMaRMwGO1hyPqWaP9/i/H5XS
         3N/4273LVBv1xS01fNj52liWgtss4sNfSPx0+sRtTWVZJJ7jd0whjIbtScDcg3jUR2ma
         ihkEIFNNYBYWGU+vzF57fZCKBtVDrKuHICruhO3qjlyATfsK99mfFwnpkPVo3DjxLgbp
         UJnw==
X-Gm-Message-State: AOJu0YwRJ5PJAmK7a0XiSynHEE4XqI0kzlwjnINMBnpWbQiL6g95bfYx
	OOcn4ZZPtWBBLf6pfjU3ICdUzARSvWE43YMmUvjHE0Jm16tbVN1rHdbfoZR52SlFO84nGDmIHEm
	JFyYwx6uLTXq5moxZ/ciWI3bgNhlFMZYGWkEW
X-Google-Smtp-Source: AGHT+IG+FVwH/Qj12xcjY3CkGWjMkdfNSI/LctZhiS6nktk17XPL2NZH4mbMaPk+5ew/hx877PmjHC+OTnmlCYT8uX0=
X-Received: by 2002:a05:6402:2742:b0:5c9:3428:20a4 with SMTP id
 4fb4d7f45d1cf-5c934282139mr901645a12.12.1728533591505; Wed, 09 Oct 2024
 21:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-4-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-4-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:13:00 +0200
Message-ID: <CANn89iKD5eMrQY2wz1JKMygQRhGn71ATSjhV_qWO7LH_693-3g@mail.gmail.com>
Subject: Re: [net-next v5 3/9] net: napi: Make gro_flush_timeout per-NAPI
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Kory Maincent <kory.maincent@bootlin.com>, Johannes Berg <johannes.berg@intel.com>, 
	Breno Leitao <leitao@debian.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Allow per-NAPI gro_flush_timeout setting.
>
> The existing sysfs parameter is respected; writes to sysfs will write to
> all NAPI structs for the device and the net_device gro_flush_timeout
> field. Reads from sysfs will read from the net_device field.
>
> The ability to set gro_flush_timeout on specific NAPI instances will be
> added in a later commit, via netdev-genl.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

