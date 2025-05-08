Return-Path: <netdev+bounces-188953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F638AAF8CD
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E21D7B9078
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81AC21579F;
	Thu,  8 May 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqVjc0wX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6A01917F4
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746704187; cv=none; b=L6L37XPQF15XO25RxJpnHm822N0GUIomqrJqz68s474a3HhJsjG7vpnb/291+gfbeO4aeOCo/Unqmlh6Xdwih5Y4nmiq0TlwrRd5CMUAosYDD+PTeWcHFRs2VY1QKCe00bSFX2UEUNDod2oBMQRHNdgfx1BoqfYYe7LfZ2euOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746704187; c=relaxed/simple;
	bh=ar2heg7Yv3zNTcx0d2YxPNC32HxSI+T9HsukzvPabI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvVPkub6+8UrfhqKJnXTKMN/VcxljlwzjZkN78u4GEtugVsDbYwJsjvV0cRlooW1nnQqcBfwbxuVE9rYJOn+2LEhmnoffbd9ZuQvRIxdqr7zH3QdvLxjpvFVeehpxOQEEEL166os5anqe/QtAwFPepmniQXvOPDt4x6TUT9Rp0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqVjc0wX; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-601ad30bc0cso1278407eaf.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746704185; x=1747308985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ar2heg7Yv3zNTcx0d2YxPNC32HxSI+T9HsukzvPabI0=;
        b=AqVjc0wXuc43V3OkKUdrH/dkFx0qz0B1L3CqU6y5SliXCyZgrx+dd7mZPosaj14R+T
         YlbQbIO4pWIzTDs/z114BNnvOZv4aw1jv2j+Ffppi8EYTovE19S0fNrrv7w0KoCUZe5N
         6wUFfqli6kFeQL5BAruCSGKaDudkJrK1KQJhHVRRLcb1K9naasR96qJZARjz2zE/8KgD
         AtUqIGUcyxA3bAeSTOmqejt7R90kStmykVFWDwLWRf1Z+KtMegcoz+O6CKJcBU18zdda
         xjf4pNAQwJSf70Td5CJxTLkhU6lyfenZJOZRF0OsKqvualNivv0vgQm/vKM4vA+cA1QZ
         VHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746704185; x=1747308985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ar2heg7Yv3zNTcx0d2YxPNC32HxSI+T9HsukzvPabI0=;
        b=aZHkvDxU8Oc4Jg1/ShjZfgEbHPQHUjPLYQx5f3G148SSiSGooRhmWmEqiEfaLQZUsB
         /uafP9EeOy98UKaFWEURcV7GpOXnmJzx+6+JrfYOfuzTBFMo/cz9e2yaDFiKMV2nmoMe
         mJbA4u1wRx6hfUdRyGScUgeMTliSkCS/kxxQgD+1H3+G1lCNSMRP0YRzqIXLyr7H32hr
         NFOB2UhPA5NbJzEbRSzMg7Kt7KYD2gRtXxolXotUPc5bXWHSo4rLlKPGuLYEZ0WLb3zc
         Qa4H0bROQQkpnaQxkhFmCkzrsTtnTzCAzAJnlsdhRtfV56tEcnwc89J6uxCanH34BZUb
         +VFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbd93h35uOLYXf7fD8Po0Eo+DJwIRswhDr4Asg+IGMIf4oyQFnzElBhLhfmeKFpVMrijktzt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObZrG9KOeZhwuf1NmkarVzRVd3Fy1nwHCr6rrpJas1oQQlbQo
	gvZp36Vkwhgbx/nI52cWAlNTrmAMEzYqXGC++Kdaa2k+Jd5W0wIBizPxOa1gPP0iKmbYeumakEc
	pXhfC2koxhmYZJ9mWmB3G9r0Upr8=
X-Gm-Gg: ASbGncvvnA1o2PUVkiCkxWAPsVQpDQMHLKBUtJfwlEZ5SRpQEyNYFt81TzD/YAiAUJF
	U7cVD4uVqUyerBCIBmEyx+lQ7Mqro2Vx2pNKUMnw+8J+rfHvjZGV7oHFjlSIsOfMgLR3dt7otGA
	EyFrNpdrsMD62i7GcEYHijowjIS9BiDBW2nP2mlyEXAZp8AkCU8PJdYSySPq6BZa8=
X-Google-Smtp-Source: AGHT+IGCoX/Klw+j+1sgTLkVb9CF/p6z2Is7Lb7t/GZCNqOX96lCHy0eetE7W4AaSp6WrFZFxkA5vGybqn68F/ufYfM=
X-Received: by 2002:a4a:b799:0:b0:608:3493:b807 with SMTP id
 006d021491bc7-6083493bdd1mr1629186eaf.2.1746704185189; Thu, 08 May 2025
 04:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508022839.1256059-1-kuba@kernel.org> <20250508022839.1256059-4-kuba@kernel.org>
In-Reply-To: <20250508022839.1256059-4-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 8 May 2025 12:36:14 +0100
X-Gm-Features: ATxdqUE3CWz0ImK_fz5lB9BlWew_MHBJmHr0nFRFj4XjwXiE6hXzsjQxIyaXPWw
Message-ID: <CAD4GDZy8mUXmNMVmY7c3vRcOthEFsa10iLynh5VxdqLWunvQpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tools: ynl-gen: support struct for binary attributes
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 03:28, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Support using a struct pointer for binary attrs. Len field is maintained
> because the structs may grow with newer kernel versions. Or, which matters
> more, be shorter if the binary is built against newer uAPI than kernel
> against which it's executed. Since we are storing a pointer to a struct
> type - always allocate at least the amount of memory needed by the struct
> per current uAPI headers (unused mem is zeroed). Technically users should
> check the length field but per modern ASAN checks storing a short object
> under a pointer seems like a bad idea.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

