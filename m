Return-Path: <netdev+bounces-157407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB45A0A3B9
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46623AA029
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ABD1A4F1F;
	Sat, 11 Jan 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="f2rV9iaa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB941A8415
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736600411; cv=none; b=uDjRvsnXzzfU3HWy+I5KyyTwmepKAf3TyoovfJID/KMvDqeOIiX+d6FWPUkpVWVhm8G8R0udpyTM/qOZBSVihIKNgSVJglMT8JkTdqd4/8SSWdCfBCsxWC03UZhFmyo3ui9vqV7q1cmtRQKmy1IsKH90ocMWNwN4Tk4A0myINlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736600411; c=relaxed/simple;
	bh=9F3Ba+XxQ3jmO2wLpnhS4UoBBHkYJXW9H29z1ZlFy3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzViAHKvWzmglMOc2sHHRpFxWJGAIQvUTqHKYCjPnwk8Os11ClYJ9vDiXkLtP5sf6lpUWA0RuE9SPci3Sy4sK2nYx171gYyqQcfjmZZCiC7ZpvJrLXG2SaDRbsWfX+8twLSsuD97X0IV2W4prM46qTFvT/xDAEWU5xjjRoiNiTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=f2rV9iaa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163b0c09afso51638715ad.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 05:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736600407; x=1737205207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F3Ba+XxQ3jmO2wLpnhS4UoBBHkYJXW9H29z1ZlFy3U=;
        b=f2rV9iaaVLWPaHmP4RNIGVCZlD5AH5oOr7eTMMTWgd5Aml29XdqypKpMejHvFTRiry
         QbAf33VTEDGknmD0uXm1OgHDZPBHI6NFQ8MQcxM0MEpcelsX00uIk6m1OH99DNtZuPlN
         CttsEPxnrcOKpb1+DlYrQJDoJgs+JA4Vdt4EDH1FojxNkoJFQsk3RhUhvuVUUoAMWCzP
         IzAwFk17rSXwdlzd//sw2Ni6OKgnRxgQv/ATOkpsyj2g3T+1b735sDeLMJuZ+OEWOrrH
         YlUDl7EKYUScsADc6bAWDbcWBBc3calsjjuZh9OAa5E5p2lnKWIv3nzK5lNarA2VqISX
         KTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736600407; x=1737205207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F3Ba+XxQ3jmO2wLpnhS4UoBBHkYJXW9H29z1ZlFy3U=;
        b=l6LEE13j2WEI2UqIlga/YClxrkWbNHPZE96AsCnqxSY8Nn8zjQeV9Xgvd2jjrzeP0L
         HhbHBWvM4KJUtt216phlFRqVVbmp/NDYBatE02pIshdBwWAcBHtN/OygTh6QIjFzSxL2
         tfdm6jf0EftzS3yC7PQ7h+wTS6QFpTnOzSfrH1jlEeEBW2VOP4Nm3sf3rLL5TJmRyMjz
         5Emka8zBQecou0flFGNLJpdqlIIxOwHcaxTPpfMMEBlNCcRy6K4at/gggMt5yAI97B9E
         UCqlQwX79Y/2AePqj2xZeljFukjVVuaBRvGgru7G5bOJdHwE8JHmk0u0kgOwIoZgGjwV
         udHg==
X-Gm-Message-State: AOJu0Yw0VB7GyLE7Na2F5UUQkkFqxngwfYEAKyRXhHGGvTTHU5TB8oz6
	AWStJfC4XTwFUSLpAlQgLEpBm/eAYlOOt5iWXX92e7c6ZND6RBkaca9aYFos1RtVNPP8+P44jcK
	hjd4LstZwONXA2MoOgIV1o0CFBHUFTVIIwrlR
X-Gm-Gg: ASbGncsDfr9/E8HBgFENaNbhR5zuN3B2bcTVWtUsbwH1MEYrquqlXDXmClXQBstgW3T
	5ZVBEXIRnQkmiNxKGN0Qynh6Lf1k3XpR/BC7X
X-Google-Smtp-Source: AGHT+IH1rvkgweMSr1Ckv8M3GasOD0HmN3umSaXfeiBFI9+zPVnDjSMHKunQeQ4J5uIFeNwCEN9bo1n6X9k8b6VJyq8=
X-Received: by 2002:a17:902:dac6:b0:215:b058:289c with SMTP id
 d9443c01a7336-21a83f339f2mr208595145ad.8.1736600407450; Sat, 11 Jan 2025
 05:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110153546.41344-1-jhs@mojatatu.com> <20250110155055.04ddaa2d@kernel.org>
In-Reply-To: <20250110155055.04ddaa2d@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 11 Jan 2025 07:59:56 -0500
X-Gm-Features: AbW1kvYHGxwa-05NwUjGaT5TVkLlvsUeinDcvYz0Kgw2omqBMWu21URD232Vxd4
Message-ID: <CAM0EoMngnES=EXPz4Ym7JAm3y_SGtnxNu=HeGhuY=-FSMLYFbQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sched: fix ets qdisc OOB Indexing
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, petrm@mellanox.com, 
	security@kernel.org, van fantasy <g1042620637@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 6:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 10 Jan 2025 10:35:46 -0500 Jamal Hadi Salim wrote:
> > Haowei Yan <g1042620637@gmail.com> found that ets_class_from_arg() can
> > index an Out-Of-Bound class in ets_class_from_arg() when passed clid of
> > 0. The overflow may cause local privilege escalation.
>
> ets_class_leaf() does not nul-check the result, which crashes
> the kernel during selftests.

Ok, great we have a repro. Looking into it..

cheers,
jamal

