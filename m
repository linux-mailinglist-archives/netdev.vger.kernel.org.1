Return-Path: <netdev+bounces-80204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3391487D8B8
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 05:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7ED1C20E70
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 04:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC04C83;
	Sat, 16 Mar 2024 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ye67B/LX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81754C7D
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710562314; cv=none; b=InLwjFnFuEMlFO+qShbu/cyV3rCUu5ScuJaCW41B93iqssIxwm8X412f31nVgh2PTGVOjmDD089LRb7qTGa4UQQmTHwIZq44wrFd5+VK/EMPdlYGISZpJuL1V3x53QaIjIQ/QADRq6tiWdZrtbIymG4MLSZfAr+J0OcfnUjuk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710562314; c=relaxed/simple;
	bh=Rt6aMzr2OuQnLBliXVO6f1PBBxyeswtksvS+Yn8xdFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ajwOxWjo+U85X58C97pweiBXeHlJjMK8tgwkj0Dv+oLLWxQIL94zw0Q0t8fPzkK2qMk4XzUtDaHCkrqyokpMjl/1ml1v3Mpw1BT1XVBUVTpVZqFJk8NTO9fHFtZM4SmABwz1x+Aq5yCiHxgSm3OTzIQHEHO+hjfbINA/bZAFY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ye67B/LX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6fce696dfso1074643b3a.0
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710562312; x=1711167112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVgOFP2Zu1etY739TvoykPTTCP+tXV1+/X2pr3iQXWQ=;
        b=Ye67B/LXjEBOcPjI+cY1X6t2uAQo0ZG08h3tCacTFq6Da0lVorzuBIR+IDphPWfEZM
         8LI2Snoc844sSLp8ui1Fn74ofEW2a+aVvpM7fkpjhP6S4lfNRdHh2gW+W1lc/wSzvBRq
         syMwhP1JNtBaGMKnRONVaB1Ec5fnrcYVLLh0EAU15Meakp436QrSPKNGHAp0grgEpM+T
         /odNZQHTQGyhWjkdcb7NRHPI+ADiCPIzlP4DbHpVxPW84FRMEUPRP4upaOq7eV0147U5
         LS4XTxac6WH3i7YiUgj7rDn5bMHnXIaE1gTkvmQyQHPJsmvhCK5xirh8wAntGdqup5PI
         ROMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710562312; x=1711167112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVgOFP2Zu1etY739TvoykPTTCP+tXV1+/X2pr3iQXWQ=;
        b=fyZ90DzuIweS5Vsozk89GxbX77YzOXHMRhgDin6JF+K7y97GqGNUAXPBAI/ZaroX9Y
         wn0jCLIHEC70Nkhjx5cL5z25zhHzQQxH4EYll0Of+rzHlq18PX7tfn8U43PQO2eB3l35
         fUzHwG/0VBv234MEqiXTgIJS84muvTROGAh/cnNzk0Tu9EuWTZgUMY9Oi+JnvdFSD8/4
         LiOCsYkY825lMU2O+ccBXUqywHvWqM2OQXcb4LIiO17nLqKfxqmmZ53XVh2izDrKdl3a
         iedlcYPxW+gsR4+d9qBZy5fg1Skqs8jn2L69q1+nu/ecTfD8aaz00LKAZ+KxRkFdRYdt
         3Zog==
X-Gm-Message-State: AOJu0YxuCUsTB0EAuexX14TyIdQLwKPaCFcrnh1HRWM3RunyVIL3gMoT
	R2Qx9sxs/bO6QsPLVkQIvEWHGoGPkX9oES4A+KwNtByk1gaGHR8FQTFozvICwK+/pQ==
X-Google-Smtp-Source: AGHT+IEmC++9sbMbXcpKhmbeCHyzQ0JhvYubzdbhQ5FaNMKqUIHCRxBi1dhziJJoMWG9GZVJky26JtU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:234c:b0:6e6:9dae:20c6 with SMTP id
 j12-20020a056a00234c00b006e69dae20c6mr243993pfj.4.1710562312080; Fri, 15 Mar
 2024 21:11:52 -0700 (PDT)
Date: Fri, 15 Mar 2024 21:11:50 -0700
In-Reply-To: <CAKq9yRgO3akVUoz=H_vKgMjoDowq=owq5snPhmKLi4c=taLTnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAKq9yRgO3akVUoz=H_vKgMjoDowq=owq5snPhmKLi4c=taLTnA@mail.gmail.com>
Message-ID: <ZfUcBnDCepuryS3f@google.com>
Subject: Re: [mlx5_core] kernel NULL pointer dereference when sending packets
 with AF_XDP using the hw checksum
From: Stanislav Fomichev <sdf@google.com>
To: Daniele Salvatore Albano <d.albano@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 03/16, Daniele Salvatore Albano wrote:
> Hey there,
> 
> Hope this is the right ml, if not sorry in advance.
> 
> I have been facing a reproducible kernel panic with 6.8.0 and 6.8.1
> when sending packets and enabling the HW checksum calculation with
> AF_XDP on my mellanox connect 5.
> 
> Running xskgen ( https://github.com/fomichev/xskgen ), which I saw
> mentioned in some patches related to AF_XDP and the hw checksum
> support. In addition to the minimum parameters to make it work, adding
> the -m option is enough to trigger the kernel panic.

Now I wonder if I ever tested only -m (without passing a flag to request
tx timestamp). Maybe you can try to confirm that `xskgen -mC` works?

If you can test custom patches, I think the following should fix it:

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 3cb4dc9bd70e..3d54de168a6d 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -188,6 +188,8 @@ static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl *compl,
 {
 	if (!compl)
 		return;
+	if (!compl->tx_timestamp)
+		return;
 
 	*compl->tx_timestamp = ops->tmo_fill_timestamp(priv);
 }

If not, I can try to get my mlx5 setup back in shape sometime next week.

