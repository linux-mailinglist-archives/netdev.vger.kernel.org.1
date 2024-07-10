Return-Path: <netdev+bounces-110589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD55B92D4D8
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391DEB2529F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA7192B82;
	Wed, 10 Jul 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="kMdTSJ1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBE15F876
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624707; cv=none; b=c1GZDNyXFc+BAVBpJ09qX38tD8EKwEV42QTpXueseqb7zD75U0sdZW3PhGWV2de91rGnvoH+6pTGg7le9dyBhwsGOpQFhV5baERv/GOB0vlFSaNGQ8aQMqsBfbsieABBZf59kkOOKLoSTc7I/EF0YmAIMfnZEGnkxWW+rI/QI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624707; c=relaxed/simple;
	bh=jpzBOoXJSv3Ese5AR+4M8yvPKwf2cbwNLADhRx6Gw5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNTTAXxCBpqxJRNgq+WMk5mEm71lTf5hn2s2yTVydRND8ZCGVE0kzwJ7T23V16L00cWr/GQVvJb6S3aLNNgWkS3Ps1oUHCK/T4vTPV+siVPCTpkmQNcoAxV+2zgRIUV1xpNzptbmSyd4iAS+SLsMF8C22zurLuFQwol+ryLUZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=kMdTSJ1X; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb1ff21748so35522715ad.3
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720624704; x=1721229504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpzBOoXJSv3Ese5AR+4M8yvPKwf2cbwNLADhRx6Gw5o=;
        b=kMdTSJ1XohDORI8RhyAN8UweGk1gyOBAirBodeTQsYzZGp86GHJ4tD5yNtDeLzLmoV
         Qv3xpP7kPrI9OoHYmDgctck+AChr0SXY7GuFrxD5hOFQPuHuaFEAyWFaZfQPUbEl3bLf
         +H6AEClVKNNZIEo5eUAzrCqokzsaFEDmR2gArZeVhwdMPzmXkced0m2aS5v7uDXb91T9
         mTyGsoaJMAdroR8qFbJqC1/T4HRcodWYs6LduEqLdu3MqPZmCxSffQcoV6Jc74xtyOWM
         RXGMaa94UVx6Y8HVmGAc4/tvwLQPdkTm4FisowbEuYFVJZvTEoHp/JYtDwFSg2KLf/0k
         1ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624704; x=1721229504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpzBOoXJSv3Ese5AR+4M8yvPKwf2cbwNLADhRx6Gw5o=;
        b=Gw7mtbcOVttihKiEw30skLzKwaNgHY+6bCdzLM8mthUsiHc+JGhXoTTSSNjxmvFLna
         g3nPLtBWsipIsIA4fLNx8vcYkrFUogTH+AL5Qx7jlVQWawv9l5h6H0k0EU300KHpCMlR
         kuT5nFYhSeXP7yvaTRw2QdueVae/3ShR7znlMlshOC5zsv+Y1rIJzB9/lpdEVx3oMLyd
         hgRW34Kpi7aHa4c6MBdLokCKTm2Av6oOABE0bdrhAlx3NViBvuneQx8EAD+poIpvb1Hl
         NbaebusV519SRCURInn1gU4eD8Uc/bd0ARgb1t8iwJKSXP2dZxANb8O8PXekqpt3Xpcx
         0p7g==
X-Gm-Message-State: AOJu0Ywr1EzcbeMFR7AuKIJtPuK9kvSujuvMcRvMPR0i2DnBRJf8bpws
	Ed1Xd9TDHht0YsgGlip1Kp8hDYsDPT5jFAm4rkt0hAeICfzD+HPMjz7LnlIafBvJ60UTCUxGo8E
	M
X-Google-Smtp-Source: AGHT+IFVvEWP2AObzJ0amh51NDqchbtREeF28Jajup3z5Q1LhKu2YsTHASPqLxfvVK8SZQCx4zsrxg==
X-Received: by 2002:a17:903:6cf:b0:1fb:358a:2f65 with SMTP id d9443c01a7336-1fbb6d52f69mr33559225ad.37.1720624704202;
        Wed, 10 Jul 2024 08:18:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac0ea0sm34955505ad.188.2024.07.10.08.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:18:24 -0700 (PDT)
Date: Wed, 10 Jul 2024 08:18:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: ayaka <ayaka@soulik.info>
Cc: netdev@vger.kernel.org
Subject: Re: tun: need an ioctl() cmd to get multi_queue index?
Message-ID: <20240710081821.63b6f6d1@hermes.local>
In-Reply-To: <FABA3A61-3062-4AC6-94D8-7DF602E09EC3@soulik.info>
References: <FABA3A61-3062-4AC6-94D8-7DF602E09EC3@soulik.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jul 2024 17:40:46 +0800
ayaka <ayaka@soulik.info> wrote:

> Hello All
>=20
> I have read some example that filter packet with tc qdisc. It could a ver=
y useful feature for dispatcher in a VPN program.
> But I didn=E2=80=99t find an ioctl() to fetch the queue index, which I be=
lieve is the queue number used in tc qdisc.
> There is an ioctl() which set the ifindex which would affect the queue_in=
dex storing in the same union. But I don=E2=80=99t think there is an ioctl(=
) to fetch it.
>=20
> If I was right, could I add a new ioctl() cmd for that?
>=20
> Sincerely
> Randy

In the case of TUN, each queue is handled by a different file descriptor.

