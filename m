Return-Path: <netdev+bounces-167879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 648BAA3CA06
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B473BE249
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F1B2417E2;
	Wed, 19 Feb 2025 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="XVEwtH/q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56D23C393
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997287; cv=none; b=n06Z0O7OKytvrjz5DNasPz8BxqaEllxC0Xiy8v/Oo12lN2VLpVNynqdyFVCXjKrV3b0dtPahw+9rcM2tz5L1/woQoMTtORVaen7f6cEbpdVx5Fb9hLFj8csNye4LiydGwQ2Mn8JfBiehiSXX2IsAm3WRfWh/CcxjZqWSKvBrxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997287; c=relaxed/simple;
	bh=0Jqf+omiFLsX4+96qMFq8xeNWsCoOr/inj2nXuUmJzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nh+ld45EsywseGqy6t3U3juQNp8Fk9bJWDiccJiS79vzJgRo8GSdSmui/MsO0KxsjhFiRNQzwhEuWdcCzj+Y8HMQQCKdzT3uejv7eXmJyWdWoczMyjFa3hNQc3NssG8hSTmXMkhF58dosEyxlKhmTfgpGVFGCWuluSE1zqI8wHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=XVEwtH/q; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e573136107bso230821276.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 12:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1739997283; x=1740602083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jqf+omiFLsX4+96qMFq8xeNWsCoOr/inj2nXuUmJzE=;
        b=XVEwtH/q3uwtahemtZIZYeVgKt2oPwscKFU1Ma8Fa8b/Pjkl/G6QTzN5W19YmDZGUr
         L8OPMduNH/bepK7iBePi7EJYxObBXWUSD+3pgcVJ7O6FNAYYhHgZ+E44WuLQ80k/dHQy
         J+FJr1wDHF+uTNt6rwyzIKPjUd89QCAkphiKLZiWR4HeS6TPlX82p6kcTsLFB8oIn9TV
         aZ/5KRF1prwWkJUKByVqZX6dnCax8MS153Vzc9opihcJs9vDSfExdMFTHtKV/fxIGjWX
         JHpBCaly0Za5g1oC0oXzSWxwwp3TSYKlNRFRMxe1nH7RzGdFR47JXdfpylDsrZEF6U0v
         AzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997283; x=1740602083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Jqf+omiFLsX4+96qMFq8xeNWsCoOr/inj2nXuUmJzE=;
        b=fbhcxP8w+pRer+mSJRzAGRrYmrTthFMoSP2RY7iRgiI52NYk460+ln7QLPqB9OT9jF
         ET1TZPY23A8ONn0qTaNyZ6H7CVfGPQ594ks4g7suuZeTWygVgrFoDH4NEyNbSIIgnLif
         b9qshekSiuLKjdbsKEYSyhRJeI8dZjHigNr55KqOt6Q4W1832R53xXsF1b7XRheSpVLU
         gjje9P1si/BdvsbQjkRpubwZ2iYAm3mP0cFLYasjKix/Cg9tqPbNHR2NJVvHu54evkuU
         uu+Lbi6dMqe/96fLmubz/bcBsGbi2r8dTdQkRpnlpwVmmUBjEQ0flwHLjLfjZi0ChcPm
         C3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWRdlhHrfKD+Tm7l6wKQMvLuRrtW1LhCmcIy2/3WrdXSK8IzfcpvJdwDJdglNrB1ePTt1wIPQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyeAj4PQCyUr3sXx23/wmronRmodN4sC7T3L1PI0avtYW4Cql
	Wiycg6iM9I4xS5OAYn6etkHK2izu/x/N6jmGyfaKwukedMTDsJvwE2UKRDg0CEQuC7LrOXWG1R9
	cSs2lR1VeBe4HdtIHosAh1FiRmxbFABZ43t+dBQ==
X-Gm-Gg: ASbGncuZXldwyaOV+xDUMSApF8W1PAiRLVdPNf/8/rVoGGopXJOvpyPg1tU/K3d3QTJ
	EaeeGZ+WgQCU9twXdyOF8jvB77KZ15FKI00HHhzP3URM/xDc8CZDO0+tp7qsZJStnK0ePYKU9
X-Google-Smtp-Source: AGHT+IGePlpcMLMtkO0p0cMKs45EJcgHTubpVnR0FVFgPsZCN8wY2WvKVp8xiCuIu+uMpB2IgJhvErQ0UfEdqhRd4gc=
X-Received: by 2002:a05:6902:f0c:b0:e5e:1433:d93d with SMTP id
 3f1490d57ef6-e5e1433d9d8mr2320341276.29.1739997283704; Wed, 19 Feb 2025
 12:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net>
In-Reply-To: <20250219-qt2025-comment-fix-v2-1-029f67696516@posteo.net>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 19 Feb 2025 15:34:31 -0500
X-Gm-Features: AWEUYZn--jUstxIYkGocBKiiriYS1hZyBvCJukvbSsj7phyx-28qwZS8FcNku2Q
Message-ID: <CALNs47uJKvdL4r9r=4iv6Y1TJn93aizOfXYoPCFc2ifwvSyTJw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: qt2025: Fix hardware revision check comment
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 7:42=E2=80=AFAM Charalampos Mitrodimas
<charmitro@posteo.net> wrote:
>
> Correct the hardware revision check comment in the QT2025 driver. The
> revision value was documented as 0x3b instead of the correct 0xb3,
> which matches the actual comparison logic in the code.
>
> Fixes: fd3eaad826da ("net: phy: add Applied Micro QT2025 PHY driver")
> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

