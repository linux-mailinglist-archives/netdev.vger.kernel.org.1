Return-Path: <netdev+bounces-135252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAB899D2E7
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604E71C21681
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936E21ABEA1;
	Mon, 14 Oct 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEANtkA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A43A1B6
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919706; cv=none; b=LyRlKn41B4jPWr160jMJaJ7n/eiLOjogUBRSGuiLuX5/DUkQfC/hsb8btdtkRngIwsEUtqbTa/r3asPsa/zii1ke2KxYy2J4yvhFbuUwp7ntmvR3KxfiU0B/yUUDhlwh3xaV+Rlu+AEmseYchjH1p2BpPCHVUctvqbRWAGMUR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919706; c=relaxed/simple;
	bh=0P4l4nqrml/wLZYJPD2RCjtiA4BSb/Ro+syvP5o91xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn25DLS2EnqGLiKSgHZqlR0QUlVJ4GrO2LFho3iWbIWxlkKpSgsJwrg9cF1ZJjz3PwxnyFryQ5Po77K3nd0GhE3nZAAmuXkXNPFIrvXx1JfTOd3pHJPPKTurbNVIpwS2CkBUTo99itx2zfKmTb9RdpFyEd95zoOixe9TDqJD+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEANtkA6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4991eca4so247676f8f.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728919703; x=1729524503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hr4KruDqGPvB3MYQhCV8uJ8O7bY/SjE0rHN1iGvvME=;
        b=FEANtkA61/FqZMHQ8NEUBvPQ3ybASNUy7QU9oRuzYjIv08faMVk9eZupaufNmexZKJ
         nvr9T6+zBac6tvut4j8fhCPonT/Ww74sn2zimt3fKHKOFPfxXebVren+2oMuyKTs3U9s
         ouls41BHv87njWypZYsnZ6uUJVvSYOS1UQYkASy6Z8SqD4bJGIUd1aEk0Ia4yUGguUDI
         F1WAUfi/NqjZvP+mTqCIPvbyfT8LmEWau07sBEacmx7I6k6dd2A2xyR2aosztuuUoQi5
         CjCYqITxsmz6s0uesNKKB/kdbV66KcDsY8BdGDE1U3ZtmhG2iRW5c1wsZTI67OkUsfb/
         zjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919703; x=1729524503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hr4KruDqGPvB3MYQhCV8uJ8O7bY/SjE0rHN1iGvvME=;
        b=QKuhi7MfJCCVhy89fw33Y0I1zCMb6z7M06JysreZP7chdcHYEkf4K5lxio0xowTLhA
         7PezWvvHLQIdm43ILSwa32Ib6pYNE9MU2UKLS+ZLi1Ot87QyEOTT24GXN8hnHoL0rLQW
         ujIkho3Nis0yajslw2LpMYk3PDtYjCc9Vwpp/5lNpfMxO6a0+Kp+VfokPRtnzvF2YZ2W
         x0Qx1UkWUMCk9PSeVV1N5uPMJo5yqddiQ0ZY8mfhRvrm6SAdIgWfS8esduGJJjVCxKDz
         k49waC2wPF1YYkXa8O/aZ/JRk1qCtqNxM7ReIDoTMAX/HYvlhWw4ZKlKI68pHuvMsJWN
         LaEA==
X-Forwarded-Encrypted: i=1; AJvYcCV/kOPyE8jgDjvnqq5BO/r4cSWSBjk0BwFYeMhaEX0b+XAXV4XkkM7cGUHWBEcJAAw72s0LQos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxayJSTmehLJAwMobkIyEzF3t5d01djKK/89CfIqk0fZvgn4kha
	yuDDkpU5ttFKQ4uFKCmpjAyrRykwQO+Tg9ZfRo8BCttTeWCnphh+
X-Google-Smtp-Source: AGHT+IGWSI5CI2CCDOH00L1NE/I7RibCem8szp/DYSNzrfI+ZDyOHfcNb/Sb1k7K6Rt7VHR9KqFuqw==
X-Received: by 2002:a05:6000:1ac7:b0:37d:3a04:62ec with SMTP id ffacd0b85a97d-37d551f5b80mr3784999f8f.8.1728919702960;
        Mon, 14 Oct 2024 08:28:22 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd04asm11580349f8f.27.2024.10.14.08.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:28:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:28:20 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] MAINTAINERS: add Andrew Lunn as a co-maintainer of
 all networking drivers
Message-ID: <20241014152820.kh22zkxqtzx5dlpc@skbuf>
References: <20241011193303.2461769-1-kuba@kernel.org>
 <99156f69-e168-4c77-90c0-fb2ab1de382e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99156f69-e168-4c77-90c0-fb2ab1de382e@lunn.ch>

On Sat, Oct 12, 2024 at 09:03:52PM +0200, Andrew Lunn wrote:
> On Fri, Oct 11, 2024 at 12:33:03PM -0700, Jakub Kicinski wrote:
> > Andrew has been a pillar of the community for as long as I remember.
> > Focusing on embedded networking, co-maintaining Ethernet PHYs and
> > DSA code, but also actively reviewing MAC and integrated NIC drivers.
> > Elevate Andrew to the status of co-maintainer of all netdev drivers.
> 
> Thanks for the recognition.
> 
> Ack-by: Andrew Lunn <andrew@lunn.ch>

I don't think I am relevant enough to add any tag here, but I also wanted
to congratulate you for the great work in always finding and highlighting
the "common sense" point of view in the embedded networking space.
Please keep it going!

