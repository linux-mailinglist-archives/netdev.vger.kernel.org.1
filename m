Return-Path: <netdev+bounces-130931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F4998C1C5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70546B22435
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C41C9ECD;
	Tue,  1 Oct 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dycfTEnT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568B1C6889
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797053; cv=none; b=BdEA0z6LoGeIpbYyW483AHlGVfS/uBlECItYx9mAGkIvyMaITK+a7taQpTQzGRcuArTjmxDjzdneLxTHPFIldgDg4VSYFJ5xWs6WpXw0vhjhGNrB80uARPnl0vadhsKDy0NVqoa3I19E9TG14oWDA3tmEH6AxtvA0Yv+LeP2pHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797053; c=relaxed/simple;
	bh=LjHglGMY706Tr5dbLNasgjlLB4kreypJeeDife+hHzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afF3fzN8oYjismUpga+cnvoLe+O9pj0WR/fxZaCZySfWYPtsI2kZ52SMrpzNo9AeKvB+B6TdYUjqJNvXh2GRGQseGVCWGcACZvcPw++vwZLPtnTc7iuvirAGjsqeowF/RVWFLD/EeU2q6eFHv/ZBikYZ7Uadlxk+cWJTXplGgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dycfTEnT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53988c54ec8so4823064e87.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727797050; x=1728401850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmEtXA1FAMbbnHD+9X5NPyPzlPyCs6lfwZoyUF1ba+s=;
        b=dycfTEnTbOdhm5YdVp9JdgPj/twrUIgGzL4a2MGA+1U48sYmGLO85gXLXHCEpDlb9j
         KG9+3JiDQHCqTvOnaRXeec9robbq3REPo3Xv03Y7XF8QGVxOtZw4lipkIlBeYout7707
         aMHsuavuIo7ymkcE4rwRBiMoRvw1k1j0b/NPmUuiJJMVOO+kZUOObfUz9dZXjTL3Z5Gy
         E9L70HtyE9a3+iEBPPkkVdaTwPRFs3wAr/6vVQtvm2ItxAefsov/O0qhEGJqrijggIkv
         YL9S80V7cWEPrPRDsl/6Lhe4ZNUu3dFi2fUwnRCEMHLxScqDr0zA7V0ttMl8QPB57g/G
         B56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797050; x=1728401850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmEtXA1FAMbbnHD+9X5NPyPzlPyCs6lfwZoyUF1ba+s=;
        b=KTAFqiopenoOb/h/rOdiX2M9DFO1uLv2ilSMkBX44v5j5bjShO/XU3aaulQLiz8rB/
         b8QXTQi4Q9ocljNhaWvotYqyHO0YcrqW9GNnsbTlxAnHZbrKYmHOYezVdVlqmaL11U2m
         4kS+wBRK+Rcz0f79hQtssY5BEJQhXu0IXHmI4cqVP0jtdwAXjjvmk1fG2/NLWujTfbkn
         LKCaIsKbW11FjN5bdg5yvi3BgUHNXokC4x7NoSYRamO370sYRfehAg1LDXAYeIcuZ6Ma
         HOAj4y1X3HL4jL3qZ895teiObae4RoLx2925v3L1GJa4iVNclKbCDW4iNADSfrpRQyFH
         gU/w==
X-Gm-Message-State: AOJu0Yx8vfocoJg65r/nQr8IXxP8kuVSgHVYZTmKea9zSmCvAQpA+ByQ
	MmCLQX+1sx1Hr8lvhsLBxkMgCkRRgQXcfmFuinJSl+iim8CR5RUo9TouXeGgu1vpHcHzbeQ/LBp
	gfHxIbjZkAC3kAR0Rb4a00k66T/ljeVEhiCy+lb0zqP9fZsUQWUEX
X-Google-Smtp-Source: AGHT+IH3cuoy22x4HBhXQm7whNFat+U7kzsexIE2837l375FU7s1xw+osKYMrcPSEGeU/x97nEBl8SdtN4u+SNnBavE=
X-Received: by 2002:a05:6512:b81:b0:52e:9762:2ba4 with SMTP id
 2adb3069b0e04-5389fc468f0mr8690427e87.25.1727797050178; Tue, 01 Oct 2024
 08:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930210731.1629-1-jdamato@fastly.com> <20240930210731.1629-3-jdamato@fastly.com>
In-Reply-To: <20240930210731.1629-3-jdamato@fastly.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Tue, 1 Oct 2024 08:37:18 -0700
Message-ID: <CA+f9V1NWHDnX0Y7EzAkKnwZL3VLxnvTBfWyQwtrYdA0hp7Z88A@mail.gmail.com>
Subject: Re: [net-next v2 2/2] gve: Map NAPI instances to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:08=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use the netdev-genl interface to map NAPI instances to queues so that
> this information is accessible to user programs via netlink.
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json=3D'{"ifindex": 2}'
>
> [{'id': 0, 'ifindex': 2, 'napi-id': 8313, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8314, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8315, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8316, 'type': 'rx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8317, 'type': 'rx'},
> [...]
>  {'id': 0, 'ifindex': 2, 'napi-id': 8297, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8298, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8299, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8300, 'type': 'tx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8301, 'type': 'tx'},
> [...]
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>

