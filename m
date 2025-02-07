Return-Path: <netdev+bounces-163830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267EAA2BBFF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380FF188649B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2563915199C;
	Fri,  7 Feb 2025 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5t8/A9l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ADA22094
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738911711; cv=none; b=f6bgHjgbP/QiuA6fJei20szxn8KlOAyh/MlVhdB4x0vQCuF7kv+xR+9w6vhvo/SM6DMWsbE2gUWhxwYQXC7r86fgoRShnODdO+p1C5sgdNam+sbtuxlbzUgBAAZ7KSflY1oU/epCPIs2gKViY8kINo7h1fxtBXRbCIoGCVP1cNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738911711; c=relaxed/simple;
	bh=urqgtn5fN8Pn0Be9yQ0esk59RnPlrDzuwItKjf6a3yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3FWa6Swmqyd3Rm24qQVsmrz30N8UO/XIEfnL5hE54NAZ8Culc/cfvOLCVxBz7IZLjYKD5wJUopPyPc9c5U7R5Vi5dH9KBGqmwm1Ui8JcJ+r2YqoQwbirTS/5WwX4hfbDrY67fCkjTh2Tka2gmscD9VX7wZBpsZzJOzUClpa/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5t8/A9l; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab77e266c71so188202966b.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 23:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738911708; x=1739516508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urqgtn5fN8Pn0Be9yQ0esk59RnPlrDzuwItKjf6a3yw=;
        b=i5t8/A9liYg6gpjiLEyy9mi7ywE6LlCXyvD6+syvbFUh97vUXLvunz0MQ/9FGbj056
         wzGk4TkDsvFIehY9Pt1NId3e9KOBLGt8uHP7b+IhYcAs5TFUApw6jbvLKoSt74Pu8Pkz
         utGhj4xn8HKhF6fxNV9/AaMSvtrm4n7nmJ0AiwlLo2C+xzlcof34/iqk0odlpME+rSq2
         IuamSkSmD7cT0754AaDZT3o4oRmQZB7ROm0LI6Zo7VZhsyZxSl/kcv5MG040hI3n2Jak
         tAHXnhWaHunFdcfxwILA2AwiVn4s+V/YR66sXt2qrjobmCAjTbyz6+n3BD1IwzDCh8s3
         SeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738911708; x=1739516508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urqgtn5fN8Pn0Be9yQ0esk59RnPlrDzuwItKjf6a3yw=;
        b=DI/ZX6R0gZSigG/cKgKDvb/ofMu0i7gMzbgO8zBnYQenbefzHSTFAtHc/VNkO1ENhX
         D68fQOskaNfKyCQ1e285LlrcX9ul4XSaIHHdH/adiJ6MI9urKfFPCvHNe9DPoJSVOWfd
         MTjzNBKZ6UDg4+8gLG1BiMO7vWCPwYkqEyZm4OBnxY/GGfkL7r5UKoK8oxhq89iKRFvX
         q5atHRq1bBtFX2IdbEr8gf3pEXKdZWvY8KDr1zK26BJYBaNoO7DXuuiP+faWVBdjdx95
         JvMioGmf1C9wpwjmpX+MlxMFaDoLh8DHX1p8LKALgvkeVy/wJO6OPiwifs8Lftr5NsJn
         sQIw==
X-Forwarded-Encrypted: i=1; AJvYcCWgY3cDMOUkJJtIC0P5GjnZ2v1Bi379Qq0QTsigfTirbOr1uMtRujFkfh4vNFjw88nPDWUtVjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5y5a6/oB4hAf26y7yqv1DhLXPFAxOWs6qSgli6IOBp/APZlGw
	3KNJT6i8e5lV4aQJG8fa4ao020B/47JaPf52F+G80WMREFGPeE9+I6a6WCa0q5ser6I24BMFB/B
	0ZFQhYqPPIZ7BeCdnnBdPt29CnydIx1uTr4zQ
X-Gm-Gg: ASbGncvFp5ClIugY/OG47gWI33hmd1ljoDtDW8CZWNCvKiv4jB1YPtocaUypklD/VAu
	NXP65Dk3vSecCvF9kDwlEJ5RQN+MwjaRTeCEkfIn+FtL/0HMIF9GjHLVCLmgyAAc6CwgJ2Qvv
X-Google-Smtp-Source: AGHT+IHi52iiOE08wzFCpoMrSwK1tJkB0PMk4aqrhsBZdLWNGNdh4u9Lulxe4foDb1Rdtc/PmmGNdNMMD+ey8ocOfvQ=
X-Received: by 2002:a17:907:9627:b0:aa6:6ea7:e5a7 with SMTP id
 a640c23a62f3a-ab789bcaf0dmr140052066b.28.1738911707567; Thu, 06 Feb 2025
 23:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iKdg=_uf-gis1knki-XSTbp-oHSXM0=kP-HFm2H39AWcg@mail.gmail.com>
 <20250207065847.83672-1-kuniyu@amazon.com>
In-Reply-To: <20250207065847.83672-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 08:01:36 +0100
X-Gm-Features: AWEUYZlXY7A_LgiNK2QmIhDQy2xjA83wEfP834p4tQwA5fYIQ7wz7nWnVCTUXFY
Message-ID: <CANn89iLyO=sXP6hvuDVxnJpq6Y_AT97NmUO6NK+DrQZ8UvQ6Yg@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/2] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, horms@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, ychemla@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 7:59=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Eric Dumazet <edumazet@google.com>

> > /* Why is this needed ? */
>
> The following rtnl_net_lock() assumes the dev is not yet published
> by register_netdevice(), and I think there's no such users calling
> register_netdevice_notifier_dev_net() after that, so just a paranoid..

Please add a comment then ;)

