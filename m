Return-Path: <netdev+bounces-163872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C896EA2BE3C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165387A594A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611FE238734;
	Fri,  7 Feb 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="30aOKOyF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB5237716
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738917460; cv=none; b=CdPsC6H84JLCE3e5PxPJB6wNuEXcM9bbMCDaH7ToyywBN6Sbyd+x3/rM9wFz5pPAdYaTeVbQTZ7dzF2c0KxBkqnWYoZt6EnD1Kq9M32a4JGz195IYv7RoLDt9QKDr8Lx40RtiX3wtgnpEZoFEQ3aPkU7IebyudyL18RJm1/LstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738917460; c=relaxed/simple;
	bh=uI4TlHZZiIwqBWmNQc1Th593qKERIXWU7cw6B+hkRZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMky8A+GbDw3+BQV2I+k3ZuVi40CieFy+tXdP3HrlC+ay1n9MPoeYP+GP/0jTTLg+wtOkNvqw+qs8TjS2SOhh0RCkL0M8+upG2CB/EMFJH7qSnSvhq/Z1wVXahJE0I7+VRxx7qp6SVuJuJv9HvDG++gOLfSpMuhQZITyWiI54Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=30aOKOyF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de4f4b0e31so197142a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 00:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738917457; x=1739522257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIzAgXfTA/p0WCNTKl+kHVHAiTN250dD80Bu/crNQVQ=;
        b=30aOKOyFKJriHNHxfzdDtdPQhMbETjUHWuoz3UGhqZNLy/bElyY54g9H3tkswLxJop
         I9ROKCTNJTXtJecO8995f4DEZRmfQeUPOB2K34SW/X7JBLZNIripoRHYF+TIMjGyuz0G
         l8Vzx2xSn9JfcJh7wkdqjlFY0I2Gsa3So9SkDyWeUrruLsezQ3YHf4MIGkELGb3LOswA
         IbIER5DUzLQ/Zbn8em7ryJRHmBfa+CLniv02GfDiCgjmQqgKmb0Izx7bgpC+F3yosspS
         XpfqUgruO8CdlrkVgOKnl49OsKmZa0CSS2Zm8ZCnXK1NJDBswUtu300FQJxNi/nXVoIF
         yb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738917457; x=1739522257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIzAgXfTA/p0WCNTKl+kHVHAiTN250dD80Bu/crNQVQ=;
        b=pUMuFC3oFWxamjnLvBTiVH4Rjrig2WEs+4LyStEpe1LZvIY8DiHaVDx/RKMj42oH/u
         q7tpzch4rdRZd2c59f+dxJ+JNiWenxT8JzEPXLz1Kycduqgp65O1HCfZWhicIk28iRiz
         IdnuWsCjvk/E6Tk7eLqkq2V1t/6juD9ozVncvgJ+8jecaKs/ymKmB6BlgbBFBIXlNszO
         34JPTglIe0wVxpTlk/8oWpu3kpS2ST593NLOv/dxKlCNXswx2s4hGOr/5LsSr0p9KY4V
         aTtaXqpCNOeoo7X+5PWp9YXSHUUslXJk0CA+J5//8ZG6Ac8/Yt5ujNhs8sjon8lQD5ZN
         UZsw==
X-Forwarded-Encrypted: i=1; AJvYcCVjwL1JyyasdhUE3ATnnpq4H9T6J80fUM/lNPsgcDFpVnxlBoBSdZ7LL+tCgab3ij5UZMxJqrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+d3LRqch7iaWN8lyBTZLGQMuN20A800cseH5zrT4WizBmBf8h
	ZHjD6jsuylQebKKGDwwKIyOg/uGfFEGfF+xHu1TVsONT27DSCC9c+kE5JZDqXoENLOb64C90/M/
	vPf+YBBL+ShF1cc4tnTFrvyZdkspGuYzygKPw
X-Gm-Gg: ASbGnctO/ZZ8ONEJObbnpHnuM+SZ/+TkNJhp6/ADc3IlJaGPX2AmfsThFHouGXbGJ6q
	usri483nPNWC0fhGYbC8NNqPDskpmol2xsTj5fnixXginCfJLvY+ENvEBN8BNPpOTemFWL4Fg
X-Google-Smtp-Source: AGHT+IFHyU70Tvk2QvIdFy7JmMG2/aC0AHs0JE+dBv7iYJhqk6AwTtzgymHVWv9L8SmeL9uahwra+DySC1B8vkRWowA=
X-Received: by 2002:a05:6402:3907:b0:5dc:74f1:8a31 with SMTP id
 4fb4d7f45d1cf-5de450b0d02mr2233560a12.26.1738917456655; Fri, 07 Feb 2025
 00:37:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207072502.87775-1-kuniyu@amazon.com>
In-Reply-To: <20250207072502.87775-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 09:37:25 +0100
X-Gm-Features: AWEUYZkJSLIUmNEL4hQzqVv72CWfoiQTtgeB-h3EINFG4fAE6TRY47A76MUwYBI
Message-ID: <CANn89iLRX3Hg1jvoBrYbRf3NgmBzXVKWNMXUZ-zppG4LdK5yiw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/8] fib: rules: Convert RTM_NEWRULE and
 RTM_DELRULE to per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:25=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> Patch 1 ~ 2 are small cleanup, and patch 3 ~ 8 make fib_nl_newrule()
> and fib_nl_delrule() hold per-netns RTNL.
>
>
> Changes:
>   v2:
>     * Add patch 4 & 5
>     * Don't use !!extack to check if RTNL is held
>
>   v1: https://lore.kernel.org/netdev/20250206084629.16602-1-kuniyu@amazon=
.com/
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

