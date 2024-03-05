Return-Path: <netdev+bounces-77632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C78726FA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF141F261DD
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC3405DC;
	Tue,  5 Mar 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATSQjK+4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291A38FAF
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664795; cv=none; b=MkO2tL6r+z1rnbAunBAh3z5KwZ2vv2cWqvVWiNndqaosZ/nSIJBuFwcgc4TDuo+DxmIdapb7zuaeaTwo11aAsflL6hGGPDioSbyLzXaK2FaHpFpDwcPxuBOmTripy+MoJACGmUbpsZMYG8dg1ovQHzu5NS4BrvcaPp2nzMCnNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664795; c=relaxed/simple;
	bh=f7a4kmYD5D12cr3zCZ1I17BtEB1AzFq8VOmwRulND7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InorMPYPDssDzQWv1DMf6+f77WMTTN69ycLL0LwpzV+6yO1Dv7NfzenVL4AOEtFXru0DxTjw0I0AFpp5kD7drWRFOa1sFCzJ9Dhn+EnSZEi4j1wTSJtjkVuqYru/sZmIejS/wOQPniOAlt1zc2j8lV7T/420huk4xaTQdCwU0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATSQjK+4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso2085a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709664792; x=1710269592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7a4kmYD5D12cr3zCZ1I17BtEB1AzFq8VOmwRulND7w=;
        b=ATSQjK+4hzipng71q3qJWmp2t0TgupKS9AyWilxKIh+sGv6ie+GinSuSaH9KX7ktn/
         y9pbv5eHkRTUHJrwlYi6Zk8DvYLMcSQNEtBrEFtmz//OFySPTaR3gvJpbnwOQzgcGhvT
         IeIkLcWkKZlc01bUqahvNQelWzNy34/z4HjjekiJWtweDw8Yf+CZghwMJ68Sp+nagqep
         IE4souuiEkUFAurhZYZMDqxGjZHs6XZBxG0RxwgBYdgj79QAeTdpaE6LOJSJ9RLUmpwA
         Nll2GhxiaXRNU8LQOLrUmt1PoPL951xMFeFkwdWbBE0Wc0mshmqI40GctbrF5QRP9HMu
         cG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709664792; x=1710269592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7a4kmYD5D12cr3zCZ1I17BtEB1AzFq8VOmwRulND7w=;
        b=JNvHhbL3wjYkLf/oCfW2WoUG2EIgNkvOQS+eDHNuer1uKgq6QqzWCk77dk4FcDU8q8
         bvELMXgEBfTNGLBPK85VKVX954yJaZWAZLqNU4h7+7Uqdd2LBwkx8UqtWkjJcgTjfBKo
         rQ1q0o7W88JAMMkgQs4pik0iOPKk193ghWIiqD2lvi2DBz9lghE2xr5us8a0Pl3Kg/HS
         lzjj0PBWo6/u9bcZje93w46FKHnXt+sYaznniGiDfYZ7ECXc6BizzsQ1Oi0czTY4mFBK
         LLf2X/6On9KIm8I+J0JhSFA83KRUH6TyjCcjhC2p2pEfapGX6XJ31QfSNXPvEO36kY46
         eo/A==
X-Forwarded-Encrypted: i=1; AJvYcCVu2KgMFURYVP4YkDik8cITJ4Re8m2rxbTnB5dAaSt20QCCfZSDfeUxJqvtf72ObyPIbA+l+fCWMNrd82gZyq4aWqVtDx94
X-Gm-Message-State: AOJu0YxB4YMsz3ZrRRLYznVCdVrjZ3otjp+ZJ0TMDvBr/Dpg8NEv6/4p
	+6840OtYRg2y/dNsgm44soeLd3y3vNxtikR0WN6EqHtRio4JixA+6hgexrRS2lPv8gTGN1gG+qU
	qVnXcxgz2fzwNFtT/sBn5FGj0+GkdsFy+j2E0
X-Google-Smtp-Source: AGHT+IF06frUFFAxmQuRSBzDiKgaV7kwWjb8ogk2d+6Q9QuwdhgEPvrlEBt1s7phHW/vjQ57//NDcIxjze8JE+Q0sXM=
X-Received: by 2002:a05:6402:1c89:b0:566:e8fc:8f83 with SMTP id
 cy9-20020a0564021c8900b00566e8fc8f83mr166500edb.7.1709664792087; Tue, 05 Mar
 2024 10:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305013532.694866-1-kuba@kernel.org>
In-Reply-To: <20240305013532.694866-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Mar 2024 19:52:58 +0100
Message-ID: <CANn89iKkzU-0WXWs1oGD9puXXOhh2-Cx2Nt_4dc2YDRKTOSd0Q@mail.gmail.com>
Subject: Re: [PATCH net v2] dpll: move all dpll<>netdev helpers to dpll code
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	Geert Uytterhoeven <geert@linux-m68k.org>, vadim.fedorenko@linux.dev, 
	arkadiusz.kubalewski@intel.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 2:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Older versions of GCC really want to know the full definition
> of the type involved in rcu_assign_pointer().
>
> struct dpll_pin is defined in a local header, net/core can't
> reach it. Move all the netdev <> dpll code into dpll, where
> the type is known. Otherwise we'd need multiple function calls
> to jump between the compilation units.
>
> This is the same problem the commit under fixes was trying to address,
> but with rcu_assign_pointer() not rcu_dereference().
>
> Some of the exports are not needed, networking core can't
> be a module, we only need exports for the helpers used by
> drivers.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/all/35a869c8-52e8-177-1d4d-e57578b99b6@linu=
x-m68k.org/
> Fixes: 640f41ed33b5 ("dpll: fix build failure due to rcu_dereference_chec=
k() on unknown type")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Oh well :)

Reviewed-by: Eric Dumazet <edumazet@google.com>

