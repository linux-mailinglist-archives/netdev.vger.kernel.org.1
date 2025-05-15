Return-Path: <netdev+bounces-190655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26DFAB820C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF703A6B33
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440092882A8;
	Thu, 15 May 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6LPuYVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58D28B50C;
	Thu, 15 May 2025 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299861; cv=none; b=KUKIA75HdVXhbljJG9+fo4hKkJUzARSRLNcM2LwB4lqcwAFgCCEdqh/ACKs8CcmBAu4rysEZE4ihzPyy0KoaxSAH5pJNqcy3Uh1dItfuj8KqtXYXkL/Pxtuy0HD3TktXuWoklHyGtRhuY2epEESbUX2sOO0SJF8oaP7u6G7L3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299861; c=relaxed/simple;
	bh=W6IDOr6SEMFsf+ug6nMYdbCBpnZGhInsUS21olC7uWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2urHBb6W2UM52IBUFzGcolbKz7M438+SseVnV/8FQTqsZ5bpL8cmbi/mv401hCl8JgqYLMgh+kP9pAVFJwpmc0Kxf/VZhT7kp1BvRDdHMw5RCVJ4HybdcTpy89/YOp6bP/g4o2DuK1aW4nGeB9hjsDU3343/kXmTdkiw+2SBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6LPuYVk; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32803984059so752591fa.2;
        Thu, 15 May 2025 02:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747299855; x=1747904655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6IDOr6SEMFsf+ug6nMYdbCBpnZGhInsUS21olC7uWs=;
        b=M6LPuYVkKSbzqQs66HdOjEeH797DjVF27Zpntla9tKYsYCIBLRu8n6I4G1/v/Gouue
         YUbqZFgC9fydBaz52WQ3NwjxVuw8bn42Q5tRZLIHl0ZZltx3n9rTXc5reiGZpdC2s+nA
         71NOZZ/OwW1GjH6RgiUO2C83rjSKfmRzayCFhKRZkjabpdQBU/CfJZMaZB3dRQqBJMie
         xmV+4MRsPAc5gXjjwC0QwWifKg0UBZG+P3be0YwZaVZEin6Ezg1++9PGW7vf92mrUu03
         az0BnaO3JuZWVT0nTVURMrdETuJp99f73JEW3894u9HR0tESdM+jTPJrNw9O/5eIOMYT
         C0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747299855; x=1747904655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6IDOr6SEMFsf+ug6nMYdbCBpnZGhInsUS21olC7uWs=;
        b=d4yzgM4OD2BCZfO6lJzcZJPJZe62wV6kPW6VUM6NKZkvaNGOlaTlpc0Jbg3sJDu7XY
         xfYD8Vi4kZ9ASM/GUYZTclZ2fQzdHqsFUQCW0Gi/7NfbRKbPgaSgYMjLw3gxBiuXs2T/
         5RWLkL2wCV/pnK3MxGBNAsAUkhYM6GG5BP4kvP7NdCgo6txJJQ3c3mlCN8GTm/q9vwlt
         CLA3/X/Dh0AmUjawtBVuMa0LQqz914RBo60xjClxA8XOvcPJLPtXeLbR7RS6J3dpZvDY
         1mzp2MbWJ/VzWeIGyTQ2Dq2IPgMP2rdG3E9fPfxqcj40NSszPI42AAes54H/XJ3JMEHQ
         E5eA==
X-Forwarded-Encrypted: i=1; AJvYcCULOgqHE1646Svh3J1A6ypg/y5dycpcUtTSpCtXioz5282qob9P7S5d/hF0jDFXQMwOOJUHtNh+@vger.kernel.org, AJvYcCVmCiIR9/s+w3eNZECJfwyFrCNE5KOv9VeYh4ZsUFP9cpMGfkxB9ZCjhLGV0s1NgXnqJk30iO/DXMVy9eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2USeZAXSsLB2JiR0q3MRPIoMEPLVCCFTw5IRZ9HqBZG7E+Oe
	MiqsFYuPYCayM81bxM5dZK58q131YEoCIyiF7V12VQfgK1YIlu1uSiw2qw==
X-Gm-Gg: ASbGncvXAAeIH/2QwOxUa2Ewa6ffyvRaV/Ux7hxHLJZCqKyP264t/a+fpxaHyJNR/3d
	GeeZ1vh6XpPEt9jFDAj1uOPXsSRuONKqYS9FBA389k0NkKKLEYBRwFLbsJ4P9QaoN2MYHyU4Jc3
	62Gp9RninLSO4xWkspV4HvvwsAJAfYk3y7R1bftQ7NW+/XMiQUdcJggEEKJR0gyNg0yOOG7+Xpv
	piuMCCZ7EhrkBIilQQti62OBw3YIw4MDxAZSvLaP4A6jAbTWA+qCnnVPuemW5VVrNFwtwIN3O/H
	+9E/AHuZ1cEQEtaVGj0sckZPzIllANrEAKIrO8kLwkFEJhLzTHivZmnfyja7ebutSQ==
X-Google-Smtp-Source: AGHT+IFOFCKDbmDkxjyzWMrePZt7te9M6n7FOlOgj1hzkBCyLRszuUcglAS+kj2UxU4pG6BnKsLhHA==
X-Received: by 2002:a05:651c:2222:b0:30c:1fc4:418e with SMTP id 38308e7fff4ca-327ed1ee262mr27670421fa.26.1747299855139;
        Thu, 15 May 2025 02:04:15 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-326c339a303sm22891961fa.9.2025.05.15.02.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 02:04:14 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 54F94BDN005942;
	Thu, 15 May 2025 12:04:12 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 54F9486U005941;
	Thu, 15 May 2025 12:04:08 +0300
Date: Thu, 15 May 2025 12:04:08 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Jerry C Chen <Jerry_C_Chen@wiwynn.com>
Cc: patrick@stwcx.xyz, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net/ncsi: fix buffer overflow in getting version id
Message-ID: <aCWuCPsm+G5EBOt/@home.paul.comp>
References: <20250515083448.3511588-1-Jerry_C_Chen@wiwynn.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515083448.3511588-1-Jerry_C_Chen@wiwynn.com>

Hello Jerry,

This looks like an updated version of your previous patch[0] but you
have forgotten to increase the number in the Subject. You have also
forgotten to reply and take into account /some/ of the points I raised
in the review.

On Thu, May 15, 2025 at 04:34:47PM +0800, Jerry C Chen wrote:
> In NC-SI spec v1.2 section 8.4.44.2, the firmware name doesn't
> need to be null terminated while its size occupies the full size
> of the field. Fix the buffer overflow issue by adding one
> additional byte for null terminator.
...

Please give an answer to every comment I made for your previous patch
version and either make a corresponding change or explain why exactly
you disagree.

Also please stop sending any and all "proprietary or confidential
information".

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20250227055044.3878374-1-Jerry_C_Chen@wiwynn.com/

