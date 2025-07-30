Return-Path: <netdev+bounces-211057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E61B165D9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2498A5475DA
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11962E0400;
	Wed, 30 Jul 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsVFNwEa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6E2DF3E7
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898065; cv=none; b=XcT2swU/SIBgEavWmG01TSyE1rvRYOWcvM1uZDhaMGjpyrje1G2BrMkEyHBB0o9nMdAn0ckQX0RWLtDbMzsEEFHAqLFwtmlIFbXOa4sOb3BbGm3b4P2/2eAwdLctPNUYvCMsty3aGp+MAGK19oPD8dl/6+/oTvOlt38i3vaE81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898065; c=relaxed/simple;
	bh=P23y/B3zb/luk0+bHpFCLDK4ESlhnL0iJAIO4WTV+/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYxoL0oPVb6jenKkv9OB0JlJegdA3iPaUDVnCtwc3hwpG0YSjeqTCeIMDnq4/zti3fhDod3T6bDE2TN/EIZBY35tVrWJx2gCaP2Q1R0txAbUujKOVnWrQCbf51weyXqMpQpbSWzT9dnyd2wVsjCLW7IYaBvxWfLjVRbRTDKRk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsVFNwEa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76b8d289f73so73352b3a.1
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753898064; x=1754502864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4iEGbxkPslPo/NIqIHoSj4DwekwV/z+9A2JVxnxq2I=;
        b=KsVFNwEaqXjufuJOlAUHtgjbyVxK/Gl6dR0D85cuhumISkWUlVGipyJnp/PbCJSmzV
         uCf6xN1g6aaJjEPiRQDXPSjlZ3O2/NLEMZxKwMlIiY/55TTp7hAOsw3HQx+CQYdr+vVh
         ieRwLf6xC2ImFiSqu7ukj8vyr24LnjaNUyCY6VikPyu+3bFu1JE3w31UIk/OvD2I3U9h
         9gjZwfUzQi4hs7LcZclN76HdJ4S97ffk0SD2znuzIyEjwiUnepVHnu/oIv/V48MGGx4e
         /m8piWHmJv3PhVWaMNR5CyMx/uidjS3Xsa7J+AHQkRwDargN4/ZICQL3zQUFp44d0zSu
         Geng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753898064; x=1754502864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4iEGbxkPslPo/NIqIHoSj4DwekwV/z+9A2JVxnxq2I=;
        b=QSay4yfhFZpEdLUc5RiD8WlQzi/3RlXCzzKDHf3WEcWAluslY4hMZpJWXy3OLLilN7
         Ef+A57818tEbbNwB+Y+6RJ7HoElPsxo1HmrjHLsHVWPBSm04C37ctY75cmaInp2SCFdP
         Faj3miL4NgQZRtwWTZRAeh7QxDrqkz1PFqCqhQR+i5Dzpi1iu3bJjZVVPZYH7dbKrQZS
         JBYy7i0pv2uDtLd8s3Jl5/ICxSIa/JLjOrwKaKEW1CFxa4/t8d8i6k+BoY+Zwdm4PDw4
         YAn1ja02IqKMh0UkhUFdiZS4i/1h3EwTk6B/b0rmOf0JobQYEdpPbYmk3ACg1kDNPLU8
         txAg==
X-Gm-Message-State: AOJu0Yx85gw3JzCivpIn5V1U3ZA+hJQgc14OP0llm/5QMTzoeDLizUzt
	8cEwCQvLW+inn19hzBv8ZRREKHR44LG/Htj23EB3NJ7Ggx3blZk25K1ecmLUTw==
X-Gm-Gg: ASbGncs0EN09BCmUhUHeoL4lwRtuOHir2SJ+co/EdI+N5MDBdGHhW6qIKwxfCfQiCe8
	C70Cf3C2iSV39b79rTe0X0J4UZKgQayXUEiqfyNEJJH69biorUd70vnIurGszhYBbmNTolIlTI8
	NkVSwE7ppyHBmWbJltZv0f0y5rfBEXD54VxwCP503gurigzzJ7NzHHDvOBpiRHioTT/+uBwcIbM
	p9kPeBZGwBOBUc7ZquMzrqzbu62VnMPaZ+JYHNR2b4LebvVutnDXMMO63rH0aC1FSAxlyY5RRZS
	MlmeW8kN58Oe9Sb7/hG9ZNohM0mUQk68KCPTPfJN88oTRPrn5aBaSGjsWZYYYK2KgByk9vSwUep
	ThC1nIPWZ5877/JYFcnS1a5lOxf6BstPqMVJ1
X-Google-Smtp-Source: AGHT+IHpdcVVUdduyhu7eu6l/Mz3hprBF3rmWfjavdfr1uFptzq5ku9//hv1MEposTv08ShueuNf0w==
X-Received: by 2002:a17:902:db09:b0:240:b3dd:9eeb with SMTP id d9443c01a7336-240b3dda073mr33824695ad.36.1753898063649;
        Wed, 30 Jul 2025 10:54:23 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24011d5bcbesm81357935ad.10.2025.07.30.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:54:23 -0700 (PDT)
Date: Wed, 30 Jul 2025 10:54:22 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, pabeni@redhat.com,
	kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io,
	victor@mojatatu.com
Subject: Re: [PATCH net v4 2/2] selftests/tc-testing: Check backlog stats in
 gso_skb case
Message-ID: <aIpcTv4ayyP+ya25@pop-os.localdomain>
References: <20250727235602.216450-1-will@willsroot.io>
 <20250727235642.216527-1-will@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727235642.216527-1-will@willsroot.io>

On Sun, Jul 27, 2025 at 11:57:10PM +0000, William Liu wrote:
> +        "setup": [
> +            "$IP link set dev $DUMMY up || true",
> +            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
> +            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 100b latency 100ms",
> +            "$TC qdisc replace dev $DUMMY handle 2: parent 1:1 hhf limit 1000",
> +            [
> +                "ping -I $DUMMY -c2 10.10.11.11",
> +                1
> +            ],

Sorry, I still have troubles understanding the magic "1" here, and I
don't find any other selftest using it. So why do we need it here?

You said it is in the original reproducer, but the original reproducer
is not part of tc-testing. This does not explain to me.

Thanks.

