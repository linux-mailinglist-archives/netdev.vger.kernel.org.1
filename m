Return-Path: <netdev+bounces-132807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E79933D2
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8156F1C2396A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E001DC043;
	Mon,  7 Oct 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="jH5Cc3Zz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45471DB371
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319742; cv=none; b=cxwpBwmVLf5yAt8CIQXzfnrtNf8yGvm3199y5745EEdneV2fo+TCgNLFHQlqlR1oadUCPu1PFd8cD3yBt84rGy5x2rxdGacSSJJJ9F8j8KRyai1BLORk+biH1sxKMD+1fTh2ay73M2Xk2ExigBEUWVqee0kovUfrrEef8oWUXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319742; c=relaxed/simple;
	bh=cERl7lb2qgL9NZHJA3Ecxm/9IlLMU573JSLYVbJsl20=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DgP2vOD9sPtjEiCO7hxz8Qv1EDw7DkfkTKGe/YczlOhszWs8EZiByppp90ze9ukmgxqqaP31QmtRvX7Xe9Llq2QvcMq529fFqH71H+eCoAA9G3Hai95zAyr7YaseMXH0xlWahHqjIXVZF42MRuZfqOfItDwrN4EEGyZfKsb4q/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=jH5Cc3Zz; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28e9fba7c5so170256276.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1728319739; x=1728924539; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cERl7lb2qgL9NZHJA3Ecxm/9IlLMU573JSLYVbJsl20=;
        b=jH5Cc3ZzXM0/Om1+Wf1dH618Ks8ED//uk3gaV4YRX3Djf6lxQcPttqDUgMiCWiJ7qS
         g/4H3zjRyDLxlnO1lfVdYTiww1uXulVD6GbTppUFNSH2Aj75ks/Q7vAuOwmjtu3J6kEL
         uUg3CZgTIT8mXjot3QMDAeB1b6aI2i+RcGkI9fhHvXSyjzm2imSkQrya1Zow8CKTvWfS
         goCpVPo2euEaDGO7mwajdKhWORJE+l3u0svePmrKBVLveNtyP6iYUMiYq+46m/A3EYyj
         wxje7jZnMgyMqoX/Nig6yup+OdPWXFljSKj/f7QqbctCyXqKpaDAuecBppnCkrN09DFX
         6ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319739; x=1728924539;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cERl7lb2qgL9NZHJA3Ecxm/9IlLMU573JSLYVbJsl20=;
        b=U3oXMRaKg4R8Dnuc4EAi9s2E1RefycXtQRT/CG+74z5ig/Yzwg8hkErwUaajNeY05X
         wV2yhTZO3yLUUUG/7OIbd9lzCgAmyHetAAB2HTVgS+RmYPy7ku/zF0E74sY95EelC+XL
         9RewcY0TJ0KkjVlUSw5R3TyLxLbVRxAyR0RVKNJB7BcMGB/IlBrQNvuF4okrNUt0AgS9
         GGTcxpgLhDYHqBOB0M9PV0OYMPxWzWmHbcurkoQNfBHy22qUXOTZnLoAiPOu/inreP8Q
         gRMOiienj5K1UPUE6o/5XbYfmiUZeQNRBMuNhQQozrEgLf7QT52o3EquP+12TLWQax0i
         0wOw==
X-Gm-Message-State: AOJu0YytlszsT7gMbBj53ltrYCCYkhS8blIG1mgEyoqrc2xY9t35bj8y
	oxEY6Q1xvn4VgTQ5HftWTvw1wEmrK1ElxPxh/u4GDiJxDy69Aor2jcO6HU2urUdeso/Jeuh3zZz
	NiwxensF4oDwgiO4REVcBRuAPcQyo11TexEjWSXD8b/4vhXMT
X-Google-Smtp-Source: AGHT+IGEVjEM/AzGg68WK16NBjRRplzn4Po14WUmXqbKY7nW0lEC0XdBTmrJjwnfU1mC/CKIbmr0A+4SV7iSqTgpUPg=
X-Received: by 2002:a05:6902:2192:b0:e28:68e8:ccc0 with SMTP id
 3f1490d57ef6-e28936c62e1mr9282529276.11.1728319739318; Mon, 07 Oct 2024
 09:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 7 Oct 2024 09:48:48 -0700
Message-ID: <CAJ+vNU12DeT3QWp8aU+tSL-PF00yJu5M36Bmx_tw_3oXsyb76g@mail.gmail.com>
Subject: Linux network PHY initial configuration for ports not 'up'
To: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Greetings,

What is the policy for configuration of network PHY's for ports that
are not brought 'up'?

I work with boards with several PHY's that have invalid link
configuration which does not get fixed until the port is brought up.
One could argue that this is fine because the port isn't up but in the
case of LED misconfiguration people wonder why the LED's are not
configured properly until the port is brought up (or they wonder why
LEDs are ilumnated at all for a port that isn't up). Another example
would be a PHY with EEE errata where EEE should be disabled but this
doesn't happen utnil the port is brought up yet while the port is
'down' a link with EEE is still established at the PHY level with a
link partner. One could also point out that power is being used to
link PHY's that should not even be linked.

In other words, should a MAC driver somehow trigger a PHY to get
initialized (as in fixups and allowing a physical link) even if the
MAC port is not up? If so, how is this done currently?

Best Regards,

Tim

