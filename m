Return-Path: <netdev+bounces-264415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH4QL7qTqWmKAQEAu9opvQ
	(envelope-from <netdev+bounces-264415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:31:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628522137A4
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D09A3058F44
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970083A783F;
	Thu,  5 Mar 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNbCXDA+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEBC3A782C
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720741; cv=none; b=VE+/9MKNLuYv8np1dx5U9FfGqxIaGfuFgtOwbjeWXl61h1hkiGmlAepdAXU/ovShl7PZbJ1yU9dKEiXmw8RfpGHHd6Be73kefmhmXqMlEGPnZcqCpu3+kmo4CmE8sxpZDcxJLSalUHqRUw3+6kx/Ysq/pOdcpeyjvsJODydJRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720741; c=relaxed/simple;
	bh=CIe3I3BMIxTMVb80BbBMNt5clI9eF31sJ7Z7AYIJMdM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EPuuoTmtbN1Ah8IzY6EFU72HcIKAsk6HukBA8x8eRoBWHfTL/Bij/Dz+S2lNbIf9csjNJ/6CGzSuJ2+TqaMCDQF2MAzct9vDUeGDXkasEEfMHVgO1sCt16PRAgiZtRycjp1I9pXeWG5dgrcIJP3ZjgM+SbDqM3k0vtoQ7mNAsNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNbCXDA+; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-798578e2918so75959547b3.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772720739; x=1773325539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIe3I3BMIxTMVb80BbBMNt5clI9eF31sJ7Z7AYIJMdM=;
        b=LNbCXDA+fmt079JOiKiij0daHfl6PV/VP64Oen6iB87FeZOmsI/m0u82MQ6GMIRUGA
         /jBrhkEfp5Dr0h0yaizFCN9boaEFgiKGx6B46LxyS2frfNr+OYNBRSwA4SQnM05VpHts
         xGQnJbv+9Py4rBHTgazZ+CGZPQcRt2pDyzXJT+py+qaVNXfues3LfIpcRDaZsq+OvGjY
         nJPREZzG3Vnwpru5xmi7YFd1qhn06FBJUGG+6A34Ikq2+YNbAITdUUOYI4opQlHlU+KD
         e9cZHh1R3FxnmJxURq5rQ4zvHxusB59liULwv2rPp8WqwjcsfUiQLKB2MhVIRWRkM3s9
         +VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772720739; x=1773325539;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIe3I3BMIxTMVb80BbBMNt5clI9eF31sJ7Z7AYIJMdM=;
        b=N0Krb1xMYBFLxcKDOedMDWIV28amKEG735sIesHX/xz+ARtXWA6/DZiVUxXOEayBx/
         Dy4xowu1R1O0b22Fu4YGf8eAvnEdrr1iHXrpRelTpI/C5ySfaaMjMdc47zCEtrfwmB+7
         YS1+kkJkJNNRIL1yWu/vSqDCrcqDu/glUhipOCcT93JuHZJEa9rmmDdpuz+7/dIRoLKq
         h45CRCCs8JKS6AW6JJGQqskIoT46nxXSVlrSCzF6X3ZdYlsN5Sjo27m7rcSoouKEVsVq
         BET30qfCfmF+yDvSXrxk3YtB3jFiaFVRRWw8+F57QJNUUl5BHGSILIDj1LmX0sGour8w
         MoeA==
X-Forwarded-Encrypted: i=1; AJvYcCX0gdHq0tcA9pkp+6LHG+r1GsnbAoge9k7yeaDVVmMGfOMPcOEfdTRlvUMAmPRKBqB/7dHL0xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCRX9XOYthRR5D9/8CNTJmkiIzRhQoDPm4QpZS2j29h8iBQDTB
	g69Ec24UzCAv9yLshnCOhMAJ0Ya0qFpvojZJ9L6mx/pI9zNCTRD9bGMO
X-Gm-Gg: ATEYQzzqYWKUc3OsihWzW+c9kLQB3vOLTlQBMYV0v7Opk6cocEx1eF13DJRtHTtC+3j
	UbS7LZBiW3+c+qhKpc0GztEqPH5mz3WYtwpBbBblpydoW0Dx3I14LuxJy7z5IVLwQc8olsZEcB/
	SMhqSiGV4vqVDAVCln9vIahMAHG54uVk3ax74cr4XgZSFbq5OOEgzMpBNFWK0ymKb+MGtZAYjYj
	WseEtrQaGCyXfOCzq+tm6yQws2IpA42UWa4B0yMZ6gh0RIVlGZ/9UemJZielwbKS46z0kl5DWcq
	OxkqVLG7XQ3wuZAkroQ8ktgqMkPcnd5Lwh+G01iFbWOxBdPluzlideKxjMAVH3hUZ0Am9EUELpl
	LrtblktAiO/FRqBeSjUG7A2hhQmxNGJgLNjBkjwKm5YnPO+OhNnlZcptV1lbXk4Or5hBa2gcNWP
	87Ver5dtxrrnEgxwUwq8ovVuJ/mxbncB5L+sMvmxlnzueQKZHf003aMaS9aktDvdIx5xA4WKI=
X-Received: by 2002:a05:690c:f04:b0:798:670c:d235 with SMTP id 00721157ae682-798c6d07121mr48667137b3.64.1772720739251;
        Thu, 05 Mar 2026 06:25:39 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876c53644sm88927127b3.39.2026.03.05.06.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:25:37 -0800 (PST)
Date: Thu, 05 Mar 2026 09:25:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jayakrishnan.udayavarma@broadcom.com, 
 ajit.khaparde@broadcom.com, 
 kiran.kella@broadcom.com, 
 sachin.suman@broadcom.com
Message-ID: <willemdebruijn.kernel.128851f8834b9@gmail.com>
In-Reply-To: <CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com>
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
 <20260302195352.1015990-2-akhilesh.samineni@broadcom.com>
 <willemdebruijn.kernel.270f71617ce0@gmail.com>
 <CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com>
Subject: Re: [net-next 1/3] psp: Support resetting statistics on a device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 628522137A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264415-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.992];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Akhilesh Samineni wrote:
> On Tue, Mar 3, 2026 at 2:45=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Akhilesh Samineni wrote:
> > > Drivers may need to reset per-device PSP statistics to zero.
> >
> > The series does not include rationale why this may be needed.
> >
> > What makes PSP counters special in this regard?
> >
> =

> The PSP supports dynamic administrative states, allowing it to be
> enabled or disabled during runtime. Currently, statistics are
> persistent across these state transitions, which can lead to baseline
> drift and complicate telemetry analysis.

How is this dynamic enable/disable configured, and can stats reset be
part of that, rather than a separate API?
 =

> This patch introduces a statistics reset mechanism to allow userspace
> to clear accumulated counters. This is essential for establishing a
> deterministic baseline when re-enabling the device, ensuring that
> performance metrics and error counters reflect only the current device
> state.=

