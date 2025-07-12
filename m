Return-Path: <netdev+bounces-206381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2874B02CFF
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765604E4447
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F9225768;
	Sat, 12 Jul 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/ubP0Qt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D52AE99
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353936; cv=none; b=q1eb9LgBVVxFmG1l8kslZXiFsiS8kFbD+WssZ2/i2D0+ZxrJndAcbD741sKZFzM1pWGe9zsqYXhtY8K/6V6G4BKDWtilwYMuiXAiepndiIKRhQF6AnfhIKnofMS0stvkRmFTZOtP1elpW4PDEWmutJcqJYF3cwbQBZNmE+zFUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353936; c=relaxed/simple;
	bh=mvHfM+6ou192F5gtNrhxvnf/nielyFLiQaO6Co2mWw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXE5FC2SLgvcDfjw6kPFHPVq5DS+kE0WYYr8SBWXSUwDTWuU2HWZflrlj/FRsWnvOlu+Ntl9b9YapnlwxzNQ1qMz1V1IQXgONfx46qQgQ8xXfLfm1x5sFwqu3xz7aemEyHFjVxG48I1bDgofylNl6iRquvNlLY/GlnceXCdmPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/ubP0Qt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31c38e75dafso2693488a91.2
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752353934; x=1752958734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvHfM+6ou192F5gtNrhxvnf/nielyFLiQaO6Co2mWw4=;
        b=O/ubP0QtgcHPGr3f3Appdc+fdnW6wJcxxyMRxIfYyHyGJTNBGV4sgqPoKlkJ/dm/54
         azkuq3lPShS2qG/oBvibW/q/lTB6ixlzZ8HIh2LkbANQa4SDMBch/v1shiS+wFM+WWpp
         n1MWYgKCGTRZA0C2iHf4NDmrfnwoA+gUZ7xU3n1uf3MGZGzbguASEoij1WMZSYf1pm22
         btz6ETgaoFL9K8Ba4RteveJBOI2GEOEAzmLChIveLHrMDmBLyGQFf7/fu8rkx+QHfSCB
         nmh16/dd/JTu1eR6Xiq7tkPHohXNqPNMFh2eG/Rltu9+/S7UcL58C+wkOyHpQmgweONG
         p4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752353934; x=1752958734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvHfM+6ou192F5gtNrhxvnf/nielyFLiQaO6Co2mWw4=;
        b=xGQ3MeSK+UoWprw9qfkl6z4ZwaXIkfx0HpKFXyohWMdalbsvs05GXdYtEYFmCXNHlE
         raTzddOirl4H0kfA2+B1LwdQTYhxUlEtfzcmf/1I8zk8MD5CHxEGrzcuUH7ilVjv4lDi
         4wKxmfVmmB0SwyF0SwoyyNM4olimrpAktTl0Ft2lZYDz7ob7dv64B3wom9kqrAZPxrNB
         g6VdDZTadEP8W2PSovoWJOLp7y47QFfVrvOrjkLaUnfs4R0UZSu4s+IHF45ZxvblDZqT
         arS3kC8rIV+uw7HqJAillsG+frMWF5Dgp2+jxaIv38XZp4SXc2gDpMaEG+DU/MhVOgvX
         1gfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm3sdLDGZRXrr+IZ3h0Uidds7UE3/Ewjnod0Dc/2Yr3EX63MTHoXhByHeIcXzsMOJzcs5vNzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/sMSTHXCW21zlV0/bW6oqWqsqErRf6Stacd6/LHoMaeRZjwiX
	ak6EuqRPh7COFIO79YKCNqBUkj17cKnzcnhAwpFc50AA9FJSJDvXsfFh+42T8IMXN6PM4UQaTxf
	TvDKdmajsBnDG3cR08ivTaVKnb5pUmIHIQ8qTk+wd
X-Gm-Gg: ASbGncsZsP5MQ3EqNMSi9dTbL1sFPGdLVEoFNSc/ekz33CtSCUMfEPLmoDWvWtIIIrz
	rSKKX05C3cC3Kq0jtagzSgZuh7RyjgQ5KEJesWKiKDu+Ob4Wjapmleblk7lGPg3svp2By8Eq6M0
	DOpSMNr6tpfr56yPFa+06ngBJIPPpf+jw6JX6O0zjiOoy3fCIHMpw79AXAj/nwAHePvw5xIOwpb
	qrtiorIdNmrkMsAl2r5yDlo/OJudzJU5gwalXQu/z8gKj0u3Ts=
X-Google-Smtp-Source: AGHT+IHwuTBe2AkMaSKWcjAP12NsbwTol2ykBJH2Ia2SXFXP4jLXMHae6L76mUwt01MsOBdWInr2wnbRgcn0kJkTZlM=
X-Received: by 2002:a17:90b:3d87:b0:312:1ae9:1533 with SMTP id
 98e67ed59e1d1-31c4ca67504mr10284223a91.1.1752353934486; Sat, 12 Jul 2025
 13:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-4-edumazet@google.com>
In-Reply-To: <20250711114006.480026-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 12 Jul 2025 13:58:42 -0700
X-Gm-Features: Ac12FXx9ZeD3wQw6iYX_judV7kAKGB8_i4fC7-XUXf_V8-6gfphVgkw35_DFdvI
Message-ID: <CAAVpQUC-yHcV1iwMMm-MVX=CB+pK40-TcygEcvTTBJhXSi6=pQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] selftests/net: packetdrill: add tcp_rcv_big_endseq.pkt
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:40=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This test checks TCP behavior when receiving a packet beyond the window.
>
> It checks the new TcpExtBeyondWindow SNMP counter.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

