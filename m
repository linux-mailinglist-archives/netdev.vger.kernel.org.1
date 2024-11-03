Return-Path: <netdev+bounces-141273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB0B9BA50F
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 11:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 928F0B2177C
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E2515ADAB;
	Sun,  3 Nov 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlieeP4c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405D1CAAC;
	Sun,  3 Nov 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730629471; cv=none; b=r8K/PHavTLoSrIHxpgqpbz/mo4yfzJRc8UpyytI7KDw/T2J/XI9Rn1Rygfjatqg1UIVTt+9chd8250M2OP4VpljwMgFPx5ea0uwjvuUxixgqY25Ga69VsqzTGlRDyUCxBS4uXU5nPXT6NT+/6dyH//pnQh7MUoiLSLK4iZWFCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730629471; c=relaxed/simple;
	bh=Ku5BtKeUZNyRHZSUd3FpR5AUjLENrpqztyFma2f4nQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS6b/t+ZodOpwLEarwKXrZ7ugSpbgbyOh9dGkBVNBCIY5DIiLuXpgnyOvQaFDJU6Ydfyi9yuJ0W+tlxK7+IMq6oVHC4UZQFKgYWltJyED+FDXxznqYU82t6Zt9c6134faJHfMzbZLBohoN+JxJnG8/rxIWBUaEs2MbLpoefItxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlieeP4c; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e309d50f194so3121448276.3;
        Sun, 03 Nov 2024 02:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730629469; x=1731234269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGx9S07xRmQ63rZyuxZmRETlbDg20eNMskqV2EUe2cM=;
        b=QlieeP4cR036KwS9Kc7YuSKNh7rksMD5r4WsH3msO6qAWGAWplUMXdE/ZxPrbZhotp
         KzsXwojenBF5rm1qMENv6ZKLXVTHRQBqwBEfDBr2oTu+OpAjeOq6hRzg8SEzN3SpZdf6
         q3kkuwNDf2IVPZH54t+YusZ0lwO0xfownWTbCuNDNBNbMraotZyrS4EDTfG5aLK+3sHa
         N+EMQgGtrJVFznMmK8prLLGhRf/uUbNxLdnUoh3PE4JD6BFIwH9C3WqnqsV9RnaeWOnH
         AABKBTHXXlqfQOzIKQrAenUrqgJTOXzOIadUaOgofeaClMoL1jsXCMQgioUkZ9G7NdKD
         9B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730629469; x=1731234269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGx9S07xRmQ63rZyuxZmRETlbDg20eNMskqV2EUe2cM=;
        b=hCSi5TbrHOiS9nVluMggw336Ui6JQvGMyx/MCoadvjE6l7JhpvQ3mIguQIaeFeCxHh
         KPoW1XudGj/yIuNOfSe5T3BqrPfiM+k3Yyqn8Qqnon5henZLxadYs6nzPCT5FwEVOF6O
         twoadtZS3spHsfVJKZKjpK5OH0AhV0Egsis+EDKIL47cZ8hJX1BLul6JE/h0k2kHDO+5
         t52+ARQT074rYhp4FMalBsI7U8HvGgw8rImTvpCCdVcFK5Bwfaa2KdUjgfmF+ut3fy1Q
         i10s4ETyD++2ikuzOT89mG4Jf1mtTZPR70wpo52pdudY3aAUlx2aidZchApAJskaAIf0
         vFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw1hTrEnE9cDLrUn5YZd3jIxP3EG+w5DZUEJ8yRXXXTq9kD8YPYjzAPalzVhoE4xjZStjwLKjY9Ny/S3Q=@vger.kernel.org, AJvYcCW1HMCMHCE0Al72NmptkN1sX3yWKe+YNCkVPtinysX3fejymvjowkS5z9p2GpRAmBE+HbQ8zAe0@vger.kernel.org
X-Gm-Message-State: AOJu0YxCsluQZVzc6t3XeJp/Vu5+YnoEqtAfq0WASj6ndpoSBM97nENu
	vP25QmWkr3ocyGCqV+h579DLswfrwr2GL2KQ3VWnVOyV4rOui6ovob4TxY9bAgc6yx+6I7rC7FX
	C1EieS7oFlWcfjl7qqKY2QZxQnUA=
X-Google-Smtp-Source: AGHT+IHtEvdKdumNzx/7GPnqZM0BnHRRIe1Z5mZzuIBMpnbGxmRx0WOysHIOqHLntkSq3JJuP4yUiFZbg2k+BjKmh68=
X-Received: by 2002:a05:6902:2384:b0:e2b:d505:86a9 with SMTP id
 3f1490d57ef6-e30cf3e5b5cmr14822299276.4.1730629468958; Sun, 03 Nov 2024
 02:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102151504.811306-1-paissilva@ld-100007.ds1.internal> <900d2449-ff88-45ea-9b29-da145541d42b@lunn.ch>
In-Reply-To: <900d2449-ff88-45ea-9b29-da145541d42b@lunn.ch>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 3 Nov 2024 11:24:18 +0100
Message-ID: <CAJpoHp60o9UWEsCurnWJ4Phn9=SzyhovTp9vXCDAHeB5YhTm1A@mail.gmail.com>
Subject: Re: [PATCH] net: phy: ti: add PHY_RST_AFTER_CLK_EN flag
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de, 
	tolvupostur@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

I assume "TI DP83848C" and "NS DP83848C" are the same device, just
rebranded after Texas Instruments acquired National Semiconductors.
For both TLK10X and DP83620, both their datasheets have the same power
up timing sequence as the DP83848C (as far as clock and reset goes)
[1][2].

Best regards,
Diogo Silva

[1] https://www.ti.com/lit/ds/symlink/tlk105.pdf (section 9.10.1 -
Power Up Timing)
[2] https://www.ti.com/lit/ds/symlink/dp83620.pdf (section 4.5 - Power
Up Timing)

On Sat, 2 Nov 2024 at 18:03, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Nov 02, 2024 at 04:15:05PM +0100, Diogo Silva wrote:
> > From: Diogo Silva <diogompaissilva@gmail.com>
> >
> > DP83848       datasheet (section 4.7.2) indicates that the reset pin should be
> > toggled after the clocks are running. Add the PHY_RST_AFTER_CLK_EN to
> > make sure that this indication is respected.
>
> Do you have the datasheets for the other three devices this driver
> supports? Do they all require this flag?
>
>         Andrew

