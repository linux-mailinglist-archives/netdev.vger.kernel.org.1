Return-Path: <netdev+bounces-250293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25163D28005
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 789C8304D8F1
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D42EC09D;
	Thu, 15 Jan 2026 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY7hMV/s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9FE2F0C49
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768504594; cv=pass; b=OjChCH3Bok3D4ihYMGLgy0gCZvBfJ1HgmMPcZIgJ5mEVTFrX5hBOH+QCXL8cDJcHF2I+PtRWy3vUBiBbP3jsMqPX/oqcj8Cavl0FRBsiFWXHllANSidTUiiK3akxDGG5cQOozCJ1J5fGYeWlZsvLQP/CYKvn6oA2VUHuYMBcxwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768504594; c=relaxed/simple;
	bh=sDpuNwCRzvlmKp18R+AkPtB2QLYS1YPiOUBQYXRP+nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLcqqACS6lzkPGSfRJ6zmoKjNa09/xcspVmrdF1ACBo5HvoKuXKrAsXJlgr51uPXNrkYXCHguZRTPMr1whrq/n94rWdKmcR3Cu9Z8zAPbk9cSZ+CZOfqSXOWGJAS/L1JFfBxC/W8r+Au0NoiNi+M7jRD4aTDb2InMW+SSa/RKvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY7hMV/s; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12448c4d404so455307c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768504580; cv=none;
        d=google.com; s=arc-20240605;
        b=UDiQm7VyJQt+jg0WA3oxuH0GGkStKeWGp3Zpk0g9bg6F0t0nA5hh9ljMQORR2vDGu/
         GKzzaJTWiFvplVm7Z6h2ziH7gaut89MzfMyrshI+wOabBMjlg5U6SMC4/m4ca98IKI01
         BoblS28GpuGtgacFw+44ksOeWLlBKT2wcuzbXtkmrCnd+7z/vGrIzDOy2FEmeoitXHK1
         yHFqG++nVJumgtYKCwvYDWrkSGPphUJgdqbJS7paW7EkRLpRHCynwFwwy9zrGAzCfgWo
         ra4C8LXKtTt6PJnQUEs/vWXUKKJnM9T8lw1AlA5LWcHGw/AmGYl+uz9qTWE1jIaJ6BHa
         AsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sDpuNwCRzvlmKp18R+AkPtB2QLYS1YPiOUBQYXRP+nQ=;
        fh=VnkQq7R/SJJ0sE2SNo3iR77mGn96UNXzSLADrYLbCg4=;
        b=cYxsUFHZKlanuuArqR9NKZ5rDu07V1HlOugig8tyQ2WXbJpGXC0YrnANMLkii3D4ya
         TrxiJ9zf9RZJKCKDnQFZGcbTHyCReXyGW4S2qFsb5DchPfE35NLmEb+gmDjmFqzsrPTP
         SPRZfjwv6ZdYX5ytxTnE2zvOzD5Ma/NiLmszMl628rrwHRlPDN2p4xroRS1pV+NPEXH6
         DGsPlymn3BtM5XorACMAhnXX9vWs6uaPSB+YEg5idyEO1RQ/YjZJFaqTI+fh7euhcpP1
         4GaqAbsPPXC6Z82glYte1s/wPxupJjSy60jYXHntLuqMRq53W+2RAmy+GMpgZbSe4bau
         2oSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768504580; x=1769109380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDpuNwCRzvlmKp18R+AkPtB2QLYS1YPiOUBQYXRP+nQ=;
        b=AY7hMV/sh+KlcU3GWLDYLJuRz4yC6CNtBZPL2FfYkTYANA4CIjYowoOAMUCREtqmlT
         ukyakhaa4vbTfJkpiG5XOThBLMcDYWobycbjQMt8aJ+gEY/ilXAibFqZ5n6VCocrcfX2
         02I6pGEnek97ndj8xtF5mCanRvqcCWn0r5+vZZncL5PkId34nzPrdtZPR1ZD72kRCGGZ
         z807RCFf8KO4Zxc6CzLj60jox+/yrVbgE6fUZxigxQ8bsitPh7O35IsD9BZDoal4xoZo
         DWjt3SpL2RXzHizDNBC1e4FUuauCKvKfBbWcC9sMBJF8MG0NCG2E1OQoReYAP0IX06en
         L9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768504580; x=1769109380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDpuNwCRzvlmKp18R+AkPtB2QLYS1YPiOUBQYXRP+nQ=;
        b=YnkwGKERKPUG41WuwsbcmVC7p8f0Ia2UwpoRVxlFX/IhNMpPsw+PdcFryR8AeXIMuy
         E4ZFMrHDxRKHrXNawkKeupgE59k59hqceeGAXNwCgIPo0Rvv9Bz3/nknzJH61/RmqnAX
         R1v7uxXORypOvFOMmlU923KxPDVgdoNYRXhkx/rvbn9Z9eGsJjSSff68xlvm210/MQz1
         CXfXXsJusRUnDZNv0592NRRh5PXFBVwoJGzGGq3hALlsQbOLykFdpDjLjGKaOoT41B2/
         sJfKyZTLuits1vqJfVIKr6nl5jdHv0sqYXw5EOOX1QTYnU1M4zRLlNA38SNDrHFPJI8t
         waMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMbCOKR2D6oRevvZUdv82QbVx2+fm9JyB7qNYdKyhHxPyIm9BTSCGmWPiarOoG+h7u+UbISP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQflVHCa8iIpthpr/kl7pnlGob2yd/wUcFT+LP5DN7rFNoVH8
	oNcaIVK3B2vmwldk9HsaF0VSbKOMrXWxcNMmH/vhVLy3HKwiJyM0ieMRtMQPduNSANMONAj5MXR
	nKqfM1zvGkPNcBKuTsptSnHCM9pXormY=
X-Gm-Gg: AY/fxX5xf9y9Dr95OBxQoDZuSrCaGjfCndBGkzQXnUtrqp5Jst24/HPbXx7U02F63hj
	Ll4BMLKL/3Bu1OJn2ID5lodjayJXjgyfJNWi+++TBRBpnv8crBCyVACaqgPR0SANQa3N9fnJr/g
	Ru7uMJZMyE8ZnIawlppaTL4cyXYMrEw3VUaL3SVGf+ZehH4XeAeKsGxtJPcbmPi7SW21Habm8dy
	NGXFk7vV45Q6gWk3pymLGtJPFD0nuAXdDJ0vNxwkFDg0UsO7LRto6Gz/QFIME7L9KrYuHPErXNr
	oGaH2t8EcDnvmKYLe91K2NmA5uTe
X-Received: by 2002:a05:7022:f96:b0:123:3488:899c with SMTP id
 a92af1059eb24-1244a7830f1mr746130c88.40.1768504579629; Thu, 15 Jan 2026
 11:16:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114160243.913069-1-jhs@mojatatu.com>
In-Reply-To: <20260114160243.913069-1-jhs@mojatatu.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 15 Jan 2026 11:16:06 -0800
X-Gm-Features: AZwV_QidQxApnQLQgiu5IcqJVxHC4045zevqPf4gTUhdH-bLZm0KURNx1ekV6Ss
Message-ID: <CAM_iQpXCD4pvBy4fd82d3OGungnXvC7VeR=QG+7rJYFJzAcsZg@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched: teql: Enforce hierarchy placement
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	km.kim1503@gmail.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:03=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> GangMin Kim <km.kim1503@gmail.com> managed to create a UAF on qfq by inse=
rting
> teql as a child qdisc and exploiting a qlen sync issue.
> teql is not intended to be used as a child qdisc. Lets enforce that rule =
in
> patch #1. Although patch #1 fixes the issue, we prevent another potential=
 qlen
> exploit in qfq in patch #2 by enforcing the child's active status is not
> determined by inspecting the qlen. In patch #3 we add a tdc test case.

Is teql still used by anyone? If not, maybe it is time to remove it.

Regards,
Cong

