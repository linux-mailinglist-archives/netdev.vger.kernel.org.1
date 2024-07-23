Return-Path: <netdev+bounces-112538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842BC939CA2
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCB41F21914
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8514BF8A;
	Tue, 23 Jul 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDUYPHVI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2E14AD22
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723312; cv=none; b=pqmIeaTLh7lajLEs8Wp0tXyLDX5s4cUAJGNASfcZDqlo/4AwQCH32eL0VXkLN3nPho3pS94ODWBFqPV3HMp7Au53ELe7bJTgQBCNIOyQvZsDQVajdcGj8M/ibKp3QxwuamQiMUK2oxegeWiFIQKr6VNFZILZYpfs9Nu6cBa43gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723312; c=relaxed/simple;
	bh=87LPnRxAwq0qVgYtmAP6rfez3yLfDuM9Myiv4L8t7Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0AdUjqkOfcaprDrU2Vf5HGbjBeRt0dwhXohFie/TMdMPrqMcsmfRpYT3OBMBiyZ2vH4zJBmTeNdQkjQd16rrT3RyV/4OfTyqCkuQWS+2tV5aQ7de45Su/UtT28UdaMopePwwXUQ1WGzDajCtUMRBGZ+zXfi2cmEoJeekaKvzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDUYPHVI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso11967a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721723309; x=1722328109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpSaIJz7Dz5ilWwBGo8KpfrsI22OPQJ5ujE4om0cTig=;
        b=sDUYPHVILqxryRRaznHtid/ImB4UDxVLsIiHjN8R/gpI4iR3LHVY+FcB5l9/n99A9w
         3darpHdHRdiGrxtb/+2X8n/XR4dEJi3z+1O/ncDwrrlnie+JfFaIYuxe/hHy9W0K3R4k
         RA0BLvpPj7P1PCNBCzsavtt65ZCBbWi6YOY5oQNfqeSlAdHNfvFqpJM8jN1BmhiXHOuC
         ZO5tCAoXq/LYHdypZQAjfX6zWq+uaTIjxyaOt64tASfXkfBggUW1xcTiMIrg86dYVjxY
         ZsqelotyDK1N4I5u6P7dOmzG9nuz1c8s9nL5hfLCdBv7In2tjCFoEulMGHJn+x8rB9AC
         FbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723309; x=1722328109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpSaIJz7Dz5ilWwBGo8KpfrsI22OPQJ5ujE4om0cTig=;
        b=o1sYGxffm8ChMv2I4WGAgqgs3WRVWcRUKCphF8nU0IJjL+vJvkaysw46/Oz5ks1iMt
         QPdRSCb3jX0mBG2qFt/z3RC7J5+uiUhL2vS2m+fTdRkyYV0SxewgAlg/V29Y7oRKQGE8
         guUlItywclmn4MvcRLlSzB8qoLM0DWzZfzeAgaZrTQHUXHuu9UDU0PEjZR+wI/STn5Q9
         wXul3nABsvobiFTHtkW1jjPfiYgE3Myu3RN794KqlllTgh6hjM0/1NmDlr/vAM6yyHuq
         5ceOA00N5LQVnkG3/Hrn/P81v2DJIfx78Z1wQYyaXnsDQPbN6fhStU5eh8vUODerydzE
         lVdQ==
X-Gm-Message-State: AOJu0YygAiBbuZ8l6Q1k1sQLsYuQKYOoxVXkNF2c9cjvS6f+lM/3lQJk
	r5MVeHC/4i2naSdvKcSqp38MWadXjHm8V2BIihgnr3bRU6Qy/snTKSShRLdP665whyNQ+ut9UgJ
	6mxrDiyeFXrUsYpPyMa7uRL2YT27YEJ2/2n2+CwCtflJ3Fx6A7QBa+Vs=
X-Google-Smtp-Source: AGHT+IGUsJ23axFKbLw/h6tDqgKvi522rkbCed2vAtvFeqISi98yaE8W5qB6MxniPm++JgNUlpTnM+19V3FpqmmP1to=
X-Received: by 2002:a05:6402:5254:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5a456a63b69mr461088a12.4.1721723308479; Tue, 23 Jul 2024
 01:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718085633.1285322-1-vinschen@redhat.com>
In-Reply-To: <20240718085633.1285322-1-vinschen@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 10:28:17 +0200
Message-ID: <CANn89iK60X=ugZysD3Njs2FUQth0-s3anEHUv50EKzqZvDm6jw@mail.gmail.com>
Subject: Re: [PATCH net v3] igb: cope with large MAX_SKB_FRAGS.
To: Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 10:56=E2=80=AFAM Corinna Vinschen <vinschen@redhat.=
com> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
>
> An easy reproducer is to run ssh to connect to the machine.  With
> MAX_SKB_FRAGS=3D17 it works, with MAX_SKB_FRAGS=3D45 it fails.
>
> The root cause of the issue is that the driver does not take into
> account properly the (possibly large) shared info size when selecting
> the ring layout, and will try to fit two packets inside the same 4K
> page even when the 1st fraglist will trump over the 2nd head.
>
> Address the issue forcing the driver to fit a single packet per page,
> leaving there enough room to store the (currently) largest possible
> skb_shared_info.
>
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRA=
GS")
> Reported-by: Jan Tluka <jtluka@redhat.com>
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

