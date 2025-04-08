Return-Path: <netdev+bounces-180437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31425A81520
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B681BC29B5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91363230BF9;
	Tue,  8 Apr 2025 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG0bzQtb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CC1CB501;
	Tue,  8 Apr 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138431; cv=none; b=AHb9LIcPl/+pObOWevu9mhRjeHZ0NDjNaT810MrMHUsdvRCzz9GER5Ji2SE13qsB0DLo1iVg68E+phB4tFjK3dBRvPicNiPydSsBZFwTjMHRb6Vsv+tS2DMsQhnTfswtQqdLRS7MST4hfz4pjZnezbhnO6xMd2Wi5xOxLl3SNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138431; c=relaxed/simple;
	bh=t9WDCISyLU0OtSFlYPIAJbwW13zZs7DvP9XF3zTTqQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alLwX4ULjJiWg3tJcDhPVyC8cK2456xN13d5LgEKGlqmDMGw2X8rIvH9eGbgCcHHps+d/yygKBC/A7p1uoibwHHaMhIl6VjdySmi5tyYU6rAXzWnAtVTSr8fZSAGZUxbWX6lLiNHrJ+QpLWZWFIGa+YRfSPffqMv//HKtyhU+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG0bzQtb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2295d78b45cso79380105ad.0;
        Tue, 08 Apr 2025 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744138429; x=1744743229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJ9vS9EqkTncTqFn5a/VlQGoVHTrHvxxJ9ZuXG4yUr4=;
        b=HG0bzQtbJXuSOOqEIgtbuDXcnFwSNwElVJ8uD9K9H4NQAZHdRdvCv8yhe0rALhQEqh
         EfMGayPItnBQzAhbUFqg6ZZJm3oHDZmeV3Uj4B35B2z7g4mK46RaJaWAzcKN84y6dS3y
         G42zU9tlnyPUD4uhcDohaLT2l9ko5exscaP15qnYEcWVrkXAPxyAhJG5lkSqZ6wveQSw
         Xt9qUBgJCWis2tSuOVzTK38pPA3IBBpqnqvnDTDhU3pf4A3qRQhlAB6IIb1iglOUZdBs
         2D9RbxVX/O8E7zUf/E6uHYNUH3040oo1Iq4k4eUDSgZacG4QF3056wTDP4gwXdE3Nk+6
         xrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744138429; x=1744743229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJ9vS9EqkTncTqFn5a/VlQGoVHTrHvxxJ9ZuXG4yUr4=;
        b=kTM/DFKe7o3Wtjc+1G8Ky7Ne5Gvy3Hq66nuftAC1WZDhK2Id0JeE8XpTCR2heL41Wl
         CkZXUW5ywmEuSK6QNOjGwrnNHvfgzqznBiyT0zmq9uB/6uo28jD/+7esQWVotpt0Rff9
         fSKFG7GpvHBOPUiuVh68V8V+/1VxWnL33w49HU1n+T703P6n18zk5uNhOM6u55UPPfmo
         5MjeomEXPiDLdP3qe4vTvc8nHEV5zZ+PtCReckkzubPgtJ20a4Gq7aMCdcnTJdoznKu+
         QcJKRHBL+35JMRNZ5HYGGFnnY9Ji+ipCfUoiGyrjDl9nGchuWGglR4K4ii5fyLX1De49
         hScA==
X-Forwarded-Encrypted: i=1; AJvYcCVUpJACmspouuqsMv647SmQJbkPcOkhbN+l/LPE+YgL7VutExBMoVF03moVolodvDmIZbVRa9HD@vger.kernel.org, AJvYcCXAulVEaqbjkYirzPyI63SyClAnA4QhZEnZOrUUvfoDPuZjxxdJAMZcNSPFYkM3MaZ5ElSvHcot9MGFZBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxifMyof+1jaZDouuL7NPMsqPteBh3QAFeFZkfgzKbpZMGCHMr
	vkwkBlfnekwnW4qnIF9BR+WhGuQqKT2SzS/F8838QdD9+GkOXNU=
X-Gm-Gg: ASbGncspSCUX6/RiVaos02c/DPtTbckumGbd8fHECXk18VpUPZuaU7qwmS1uBhYJHTj
	TE7imK4UzGi35/bqaYxOOpC2N8JSwB/Mhb8a7fEl9hC4UPhD51UDm4ULyUzDnEKinD5+7v44JqM
	ShVrQ5GB99v576O9+yFJSWex2fsTJtqm5UuFDtW8tQzZW4NH7Hlb+txUjUzhARNYBLgr9YTpq3h
	FzL3IfG/8mgXtDGAbyc+Zr0YXXIlv+4Fjgt1YM5Cn8XKvc5xHCcDtzN8t4PRh5I8QeIm5fQjAVq
	j5pYgYXoWkDlem6XFERlIcMwcapTqQrZ65kME8Ajvkf5Ic0z6BsCzdG1S0qZ/lpob9QJijsmfrl
	dJY/VLqs07NuG1WUwZ941
X-Google-Smtp-Source: AGHT+IGgfDAOhk2QH4pxgPvRpx/sCzEvZBPxE7/6w6jBs7RCkO5Dq4xUzVyMB3TVsWPVnbUiWgnMJA==
X-Received: by 2002:a17:902:d54e:b0:223:f408:c3e2 with SMTP id d9443c01a7336-22ac29a99b4mr4849685ad.14.1744138429327;
        Tue, 08 Apr 2025 11:53:49 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:ed73:89b2:721a:76ad? ([2620:10d:c090:500::5:7de6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1bfsm104499945ad.168.2025.04.08.11.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 11:53:48 -0700 (PDT)
Message-ID: <1d570fb8-1da0-4aa6-99f5-052adf559091@gmail.com>
Date: Tue, 8 Apr 2025 11:53:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
To: Paul Fertser <fercerpav@gmail.com>
Cc: Sam Mendoza-Jonas <sam@mendozajonas.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, npeacock@meta.com,
 akozlov@meta.com
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
 <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
 <b1abcf84-e187-468f-a05e-e634e825210c@gmail.com>
 <Z/VqQVGI6oP5oEzB@home.paul.comp>
Content-Language: en-US
From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
In-Reply-To: <Z/VqQVGI6oP5oEzB@home.paul.comp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/2025 11:26 AM, Paul Fertser wrote:
> Can you please add the checks so that we are sure that hardware,
> software and the specification all match after your fixes?
Sure, I can give a try. Could you please provide an example or guideline 
that I can use as a reference for proper alignment?
> 
> Also, please do provide the example counter values read from real
> hardware (even if they're not yet exposed properly you can still
> obtain them with some hack; don't forget to mention what network card
> they were read from).
Our verification process is centered on confirming that the counter 
values are accurately populated within the ncsi_channel_stats struct, 
specifically in the ncsi_rsp_handler_gcps function. This verification is 
conducted using synthesized statistics, rather than actual data from a 
network card. Sure, I will provide NCSI packet capture showing the 
synthesized data used for testing by end of the day.

