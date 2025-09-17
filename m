Return-Path: <netdev+bounces-224143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA6B812E9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9F9464C4F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A52FE57F;
	Wed, 17 Sep 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0yP/l4N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6BF2FE578
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130444; cv=none; b=hE25A5pzavByRjEr7j//BVkiknKLletXaE0kv9MA3Kd7Z2s+SzqgjxfJqBa4/RP0FQZLPiweUWFiAjyUfOkvcG7n2nvOBDAvhFpQuqwdX4H//z9kJI2gafD5oNXyfGcbeZ1s1BfD4tkv/Brymq8NpBtNe4xSeo0iAJMJT0AYPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130444; c=relaxed/simple;
	bh=yL5XyHaFwcuHLoUx1QyC95VoaQkl9On6tV5d0jN31ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKp9HT6PlMqn2poiw3Y6tNqwJDl5MuNvQ4V3gjqdVf0KzhGj4DM5yCclawg2mWDqKB4opMz9iq4lkoR53uEzBze+qlORV6UhoMQbnGyOYsd5AKV5CIb9HA2yM4F0gl4jhluWuWB9soltLE5qUG/bOFP+JyL/gEUVJGYtZf2l4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0yP/l4N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ebc706eb7bso1902886f8f.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758130441; x=1758735241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL5XyHaFwcuHLoUx1QyC95VoaQkl9On6tV5d0jN31ds=;
        b=J0yP/l4NItgfofzDi1vOnSX26SRhdFol1FMmRTsqFXQh0Fr6ppZCUIyg6h7Eg+Eqck
         vEEHTfg9MpAF5t88iZ0Vm04CLIBttvQ4CiV0Q6jzjtDCge7ZsUbODPp7YmE0iEmM5XU1
         Gredxml3XQ3fuFebO/JutSNe4xWMniEbtwL2kVAOsADsLYyCplCduvhLUuRzeuZWQvJI
         AygXK+srDR7OibJWtI7eKBpYcxUxbJsd2GFqrdw1ejy1ICbgM+JoklsynzZwRAAyOqej
         5DAQANeLKmykyVCYd7NCpVPLUCRQh0IexrCpJzeZGLVUtzaFe17SXc08aHuhRYEeiNrE
         QJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758130441; x=1758735241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL5XyHaFwcuHLoUx1QyC95VoaQkl9On6tV5d0jN31ds=;
        b=N9k7qZTmTW8BQH0vIXMXv0P6I1YwitPg4nlKSeisbnZ8JyD4uW1aEhTTQNGFkEXx8F
         oc0YYEy7Lmy72wEi9RqRXuwJMVU3CxfMQiyLsSCVtAQH8jt/hzSyO9RzIcimXMnCKq8G
         xRZpwL+CbuT4Kq7RCN+mysdLLGRmjv1pHFxKSjs9dCfLFvMGQZqsx2QPYeLOECStlzf7
         3k1l8plRsPxQc1FXEIbofWBHj4dY1HfjQaPHVBfQRs2iYvQi56fgaObSsDzkmj3Gjjzu
         k1CYEeCK3LlwbWwjn5Jtj8F7qASWTqhAUZc3/wTIWO5d6KJ9r4ewXTFXvlt7ytnvrhUL
         lcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY4pYxEDCLd7z8cA1L5Z63Cw/cMwpo6vnU85dgP/av3Qw13orVD2tSGehvEyn5+myUwyveeKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfJ4jFC5LY6KxYgqjybR4h2Op9v8Kb8qiMlvjDoBcQkxIja/q
	cHGzown+xQkoh8GkOg6Tc+TTNg7JiGTtrUGEkbd/cXsiPVLj9Em/woVN/iM9AImUzctB5+C1RfP
	5zHbgDZg+wl+Uv5kV1gmr7gJh74pCn/4=
X-Gm-Gg: ASbGnctlF0KDTo0CkkXOwyKIB+vpCShbKo1akU5z8CdARptpmb89BIKXL4TpbOefc0v
	IKzCPST2iLUAc8A4/58dIXbFSVxB17XamrYZiau63QD0YHYSidI4v4blCwkM6VVCDqCDUWDQHPC
	hgbTsIAP71yDXPtT2KcG5FGXRF5I9IlgTK+CzjTsQ6R3ovT5q7qBBweo189pbOnh+IoA2ezqiyk
	wFduEknF93rlgGtEO3aUM/7qiKDcGgDpn1FtZ+4gcCOXT8jypKWDykYQ2vKJ5S7tHFQou+w3w==
X-Google-Smtp-Source: AGHT+IFIekakt/qtCBuXHKbWzVPXXkmYhlyTYvqsmvchet7NYv9l3Wm0KRMpUtJR+6AdMpr7F8wEAHBguPkdlOWo5wU=
X-Received: by 2002:a5d:5886:0:b0:3e9:d0a5:e436 with SMTP id
 ffacd0b85a97d-3ecdf9c0293mr2893049f8f.23.1758130441067; Wed, 17 Sep 2025
 10:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912163043.329233-1-eladwf@gmail.com> <CA+SN3sp6ZidPXhZnP0E4KQyt95pp_-M9h2MMwLozObp9JH-8LQ@mail.gmail.com>
 <aMnnKsqCGw5JFVrD@calendula> <CA+SN3srpbVBK10-PtOcikSphYDRf1WwWjS0d+R76-qCouAV2rQ@mail.gmail.com>
 <aMpuwRiqBtG7ps30@calendula>
In-Reply-To: <aMpuwRiqBtG7ps30@calendula>
From: Elad Yifee <eladwf@gmail.com>
Date: Wed, 17 Sep 2025 20:33:49 +0300
X-Gm-Features: AS18NWCWJm6Q3Abh0YddM_GDXrUEQTX4N6NPDflaQKnikVlXZoxbAvkVWuncPyg
Message-ID: <CA+SN3spZ7Q4zqpgiDbdE5T7pb8PWceUf5bGH+oHLEz6XhT9H+g@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] netfilter: flowtable: add CT metadata action
 for nft flowtables
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:18=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter=
.org> wrote:
> Just to make sure we are on the same page: Software plane has to match
> the capabilities of the hardware offload plan, new features must work
> first in the software plane, then extend the hardware offload plane to
> support it.

Thanks - I see what you meant now.

This isn=E2=80=99t a new feature that needs to be implemented in software
first. We=E2=80=99re not introducing new user semantics, matches, or action=
s
in nft/TC. no datapath changes (including the flowtable software
offload fast path). The change only surfaces existing CT state
(mark/labels/dir) as FLOW_ACTION_CT_METADATA at the hardware offload
boundary so drivers can use it for per-flow QoS, or simply ignore it.

When a flow stays in software, behavior remains exactly as today,
software QoS continues to use existing tools (nft/TC setting
skb->priority/mark, qdiscs, etc.). There=E2=80=99s no SW-HW mismatch
introduced here.

