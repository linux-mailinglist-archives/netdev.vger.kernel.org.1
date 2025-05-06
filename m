Return-Path: <netdev+bounces-188338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7588AAC496
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90E81C23E4B
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 12:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26227FB3C;
	Tue,  6 May 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCdoV1zX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7727FB20
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535859; cv=none; b=dnqN3cHSEQlQmJ0WWMz+oT2rhS6qauKbxqZ+whalq2c8EcI+Nnc9hHhBnMQvcQwLIAKVA9vnz7Q/fm7W8jxsRobEy/DalRNDUfuFhOAZaU1Qh881ds+ZH7cGq97GyvjhqAUGCnjePKo2J+CAkLSdLbrDqAbooZRtbqn7sNYhUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535859; c=relaxed/simple;
	bh=iuWVZjPND+KWjhJ9x/SFAnPnmVENpipJ/a6Z85Bx/rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEhIoXmC6vGN8nDtGkmXC3v0Je6fl1zdZ8kQUVqUGqZDPsx+FMhuXb3Qxg6RnNCFTBXhsVO2MEIpb5EwQF5kMFq1I4VfSqHXpr2tszaq4NXZ5wnlbrwL9aVYGOBCR123cobxoJBdBeHRbkIRFQEz8diyubJLjkFAnyqS7WqgsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCdoV1zX; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f8ae3ed8adso4063358b6e.3
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746535856; x=1747140656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ylefJrOM0At36TRbx//OwmJb/NbumE251FEl48mtalw=;
        b=RCdoV1zX+NvOqXZRHAInZdK16DdqIyx/gmC0ufElV3K7xzJf1VJRPqszpjrTx0CtKF
         NuWfyXpHh4FUnIHAdoxpvRWT9IsaZUNCXVRQlJvOI6G9t5wypDSW1ywKZrgnmvjbm9zZ
         RkZuBnBg4CQipjn7I2YPq/N1aO80n7UMtxAaMdtTZwmwrI5/2pOm70nkh24fM0RKUHzK
         OnvFHgSynQOn6mqEfmmDgHT/VdJxHtvgRBgbNxPg9ezA5f4+JI675lBnyztxyLLXsqMS
         p13KA7cRoeQK8vsfvSW8Y/CO6UnIRSHqcMMvpuwe5YMk0vnoAbtdVJrctv+F8PgIuHsY
         RaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746535856; x=1747140656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylefJrOM0At36TRbx//OwmJb/NbumE251FEl48mtalw=;
        b=hrR4GM7V732gnvcmzuXZXi9bzUVSOgdXIRykLge+UBdH0ra/3kg/8muHrJdlwEGxQs
         8fov/WCXnWziKKBFVvGWvnN8z/Lhb8azO0xH/ddM8gvHuYJ/MJSMGMh/+LLoqksN3oBO
         Z+M1fQd2HK6vkf4y5SVQuZqcRVYh3ddS8RjCPBO4jK9ew+07/gXIlC0b8/jRJrH2KkMa
         9VrvfV1DloZmlPAXTp9I+m7NPEoHGiOIVo+HFvQtLt4zS+PsnG0QJgpZMOab6vQzyaHK
         xq+zVJ1vSmoS3Xt7jDIDZhi5uFY9KOi5cCudkjaFL4OqJ8/R5exod3+GQvxqvkAgKvh2
         UUXA==
X-Forwarded-Encrypted: i=1; AJvYcCUuNAxqza7+FUxXSiAqPoC68FUq83c2Apad2lJsvpnnFc8AC0gGXK3WvLeH59RXniZr8HxjG0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZH3adQS6KsxTMBwfVxF6hlbg22zVfq0jcZOugHQ6vrRN9PObm
	f2IZc1WjiZqkO+hZJGtEsA95HV9WqRwRPl9ZyZuJ1FVpmXLO5RdeOxBoD5YpNx6jgUuhwH9og9n
	CUfHXMVA+D7kchr5z5oIvDetORn0=
X-Gm-Gg: ASbGncsJTX1zoOlO+3q7Cz48YsSe2w5GLlUCv3HSDrcINaUxa1MWyZb3yXka2BBjHVG
	nAfb/gWLUgP4uQonhorjWt5E7cYVgw6vaCIzibmR4/CQ4XcFxdCvr9OIILwHe07AmkezJO3ZnGI
	dUcRM1une11FI1j7xCq3zBf3y07F/CwLBMXEW45VOC+tX9eDBcPEI=
X-Google-Smtp-Source: AGHT+IFmwGBFGS7phY3jyDY3dBI/J+iafmWwUQmkOg9CUZCueJx38i5/OfPzybFafG53GAC4+jWYfHeZX1pXSUX/zLc=
X-Received: by 2002:a05:6808:6c91:b0:3f7:8f77:2a9e with SMTP id
 5614622812f47-40341a0f05cmr10721173b6e.20.1746535856453; Tue, 06 May 2025
 05:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505170215.253672-1-kuba@kernel.org> <20250505170215.253672-4-kuba@kernel.org>
In-Reply-To: <20250505170215.253672-4-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 6 May 2025 13:50:44 +0100
X-Gm-Features: ATxdqUGoItTmldn3wrHwkeVY9aEbbw7bECp26wv-_DBgjHYl8slP5nNz-rB1c-M
Message-ID: <CAD4GDZyFM0uY9WPPw3DF1F+tsDU=0PwyA1yFvbxVxv3amyfu5g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] netlink: specs: remove implicit structs for
 SNMP counters
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	johannes@sipsolutions.net, razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 18:02, Jakub Kicinski <kuba@kernel.org> wrote:
>
>          name: reasm-overlaps
> -        type: u64
>    - name: br-boolopt-multi
>      type: struct
>      header: linux/if_bridge.h

The patch does not apply for me, I think due to the above line
changing in another series.

