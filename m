Return-Path: <netdev+bounces-142830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5D79C06D6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 099F7B24582
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B616F21218E;
	Thu,  7 Nov 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCwRFupW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4304A21218B
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984450; cv=none; b=JwUJtM7s/RdtBCPovP0UUCawSWWn2ApTXcAeXbPPlPOqTDNo1mpIj2+wRQi4RHY0GkT8kBcy3gyRyv58LrtrXuqOWoc46P38X0H3v+25ON/Alf/0q0S7wjJGFUYo18lsMHq3AuC2VpE2zJtYdGN2yXChogvK3rWheaMoJ3ZhWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984450; c=relaxed/simple;
	bh=p4UEKjXCdABntYejobRIzxDpqOYdvcSt0E1838hsm8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcO+HAK5dslDgLxncnzS1mv9H5Gi5MbsdMmiiBxL+JITroKgWygJYQe2SToq99SaVWoBFS7LP8UdiVzMptXQ0EagkiRo2s2QtZWQSqfMCGDqruRAO7lz2wl396m4L4o8VN8beJPBnQE0NECWGFVDDkF2X+DaKStZJ5c86xzjmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCwRFupW; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83aad8586d3so37055739f.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730984448; x=1731589248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4UEKjXCdABntYejobRIzxDpqOYdvcSt0E1838hsm8A=;
        b=UCwRFupWw+JktWP4pwjBDobTKh6OZk3ch6R/8PPujFQvvdrjoLCTJZIiyTaqpYeW4t
         8f1Lqa6SNzK0j7yisBKF1h6wd5ZMnyZoQz8dPr+8NdexQC8oemXM6/u0N1uNY/HwbM1p
         uIvrOcLZcO2wgDYqWPan+7RLgpw26YBLcROQQfqtMpyHZaVuTyAgihJwku8Fz3HOjQ/8
         mmpf/AsdBJUuowMdDQekFdrsdKxYDqPUnnyHz26O0ks/PmbbV/h4nR8ZIkxRTSVyyuoF
         MoEH9/HNcJNNkoie4on/zIhhqWk4SHeDYmMkUZv7M+2fXUQHSZ4FDLSweynXUy9Mz2Uv
         bF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984448; x=1731589248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4UEKjXCdABntYejobRIzxDpqOYdvcSt0E1838hsm8A=;
        b=nk0JSJ+SOgjnp49DUAWVPAiPdRTKb2ibs2RZwQUcAIUDMxbpHijwOYMoMkivKqJ+8H
         hykCjhyacmp4WLbi4XmPnIywklm3NvvvZwyUG3k2X+tBG/1jPDwoAaoYfJ2v9Nameodx
         bmDctPq5XJTMDZ3BEvYr6hY7wa0jVvSxhW7hsFOzYNfqYOJGcuotSt7/qWBmnX6V81h+
         iEHmRsZvSL3ljtu7skpP11EAbtJSMiyT4EP7/ov/WqrrHzzf651BjNf1UOQnmgcxDmAu
         Z+8Odl5ab76HeqW6+YRsivwROomiaXpY2cstp2YbXSgnpAj6QgRByPdiXnalED6X4ba5
         DrWw==
X-Gm-Message-State: AOJu0YzF2ZEhHNMKC8WEltB47FWp+qLBSuo3To1GmqBhJAKdCgTlnrP4
	j/DQHifrgt8SZTscrc5hP6GOuyjbuBXCPdBMi3yUN8ZGtFkYTFMNquRnLsIp6KLNEImtMLzACfe
	6W/eMkPieQ5T5sCc/PTJYrFSDuGKroXw5I0Tq
X-Google-Smtp-Source: AGHT+IHZQS/HhfwkvGWUZIAeVlAFJWzHuuER3nlOt+WywBAjpvJLtzoplwoRmTjIUwT28kqkEHyJXODIdEmT2sTfWLE=
X-Received: by 2002:a05:6602:19d0:b0:83d:e526:fde7 with SMTP id
 ca18e2360f4ac-83de526fe52mr680897239f.6.1730984447792; Thu, 07 Nov 2024
 05:00:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com> <20241105100647.117346-14-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241105100647.117346-14-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 14:00:35 +0100
Message-ID: <CANn89iL3Wc9FGBGB7s0jHm2MZ0i+xA38NqR31AJpL-4nnBHcJA@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 13/13] tcp: fast path functions later
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> The following patch will use tcp_ecn_mode_accecn(),
> TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
> __tcp_fast_path_on() to make new flag for AccECN.
>
> No functional changes.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

I guess this patch should not land in this series, but in the following one=
.

