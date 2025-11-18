Return-Path: <netdev+bounces-239622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B12BCC6A828
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08AC24F3728
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC536A002;
	Tue, 18 Nov 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0q6a7PMk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01853148B7
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481766; cv=none; b=PDjaLkEecoByqiSygzKDRkU2WJrvIcxf9aniFGujMdggjdzDOkP1U8RfFCGKpR8YDbOei0w6F/m9HQ7HUKbiizGeQT+3l0pPlM6jHnGiM+W3/goRSIpvwoP0lzaJdyHORlNxmFfmbPGjbYeMOu4hYU/54mGy1kgmVy6BqDHqqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481766; c=relaxed/simple;
	bh=GfqTXkXVrEJpb5atUqf8HNxbs/hLvVCpb7QwD8IwGVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpBcV8UzyBiRVVyGa9WEhKuo/UrS7d7eR4Hq7bAJHJL5Nu9jiVY+DtU3PM+mk3gh6P1P4L9dBMs1rBPw5nfXOiLbt+elAelppk6nrj8TQe8ptMdk9rm3QJTVA9Mw3xUYFG2wKZDnk2mkWmifLNYqc1hMUhbq54fanhEdrnBjEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0q6a7PMk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so2928349a12.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763481764; x=1764086564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScVXv43JwkQ2uSjub0/NPG71+GfionxesRG+Ys4Pw6s=;
        b=0q6a7PMkXHrqRHhWMGxESP8cRK4F95AsW9LEeaI5g15NY7UV+d4oYJcwOR2wLPVBTy
         jYNdU6VW0xUagisL4kDsfmLQryyAB5FYn4zdridgBFeVQOWnWntW1zA6yd8peogg3RPa
         bPERdrgF7g2dnU1Ff4hZqxmoo/DLwZzwakNV1OqhI1j6hcmQi1Qd2UVZHNS4p0BGJtG8
         qgPMdX2umV+qVRQ8tpowOl8O8AXwlrqJyFr4ezn6BE/d5trzi5lmaAOzZ2e7EOjwQ6UA
         UMxYVWpea+viU7yDw5f8AXPfFb5liN5HObF14sOnqWnBGmtXWq6RJrMfuQFlLhg0pZc4
         vZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481764; x=1764086564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ScVXv43JwkQ2uSjub0/NPG71+GfionxesRG+Ys4Pw6s=;
        b=MYGv2pdZnwGcjTpUrHnI3vzPgAfT/1VFJlrMpWjmelSc8GsOJLnfPQSA8YiyyvOCzw
         DuCvRxygDO3lQPXi11JdfOH4U3vglqEorQAd5UE/u4NgO69wOQzeD05dc70wQFraSuWw
         aEYeuQPcJN1hw8lbP5Ki6thDNVxcraMD9AxlWvdUg6i6KGlT5Hi78tti2IhoCqscmf+6
         aUqJRcP+aTH6AGIvCrEHSE9SOCnN2bhbrb8XHyVlJbGKYtb3+DIWqZLSP9FBGzUZALL4
         PiIfW6Ipq51113NKH+oPWAgEYHaKZbDVjOCe8x+1/BpOobbMujuEzYqkZazflgtsRQYu
         KnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUhRoR0Os7rlJjda0NiJk1i3c6Bq6YA5MK6xA/BL6f0b9XO8Ww7RXMCG4kb7ZpnK5xyv121vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLmoFBiXwW4oJtIHo3f3m+xpz7d31Asrz3YGTf6njTu4FBhXI
	vKeBO2KgbBCkgSmscktObrY1IIO24RT4LB8t6cznMt7ic+zRYdgl8eJo1Ytm8VdhmeI=
X-Gm-Gg: ASbGncs+KjCraWRgoo0brUSBRYdOPuAdjGv2C1vTzgAAbu3Fw/w34e6E5AuRk0I8ODm
	tuRrhmO//WjVD+Avtdk3oEqaiLyAzos4Btzx/DFz+W9T1D5PuSVkYxu4alEmkTc3qqHIX40/3+H
	ncZnFvjQ2ZwQzLcdSaM9U79WbveYeo3BMlln9sOMnaJYzUgsuJGSWoF2AonqeFYu4rKLlEqpmNu
	EeJ6isYyHV5F4stO+5rP+V+wJEgt/ERHiOn3yTkHKhZ8LSUpYFWZWvkTJrN+yYVpVeA0vQzdAIO
	qfYLrn2hDLV4cuwyLoXSMqqaPpxiTF/idsGRHcXVd05H5B+60FM6ErcjiWIf1U9pFmpWKcdtuUd
	YaLSPlUmJyEMRsfymTKZgSkye5eeqDLcnkwepzQqtipfVn8P+GCciCXVF7YXBgyTCqPxfuzckoF
	YjHBBe9STUAXRY+fjEp8u3JovJMcZpI2/9q3LekmpdI9kWtqU+NASi
X-Google-Smtp-Source: AGHT+IFTRD+pIPszE9N/Ony6HB6DPT/ovJwMRVqsvZ8dzqg8FLfSj/2s630xXVH64J45zJA2cOLe+A==
X-Received: by 2002:a05:693c:6090:b0:2a4:3593:467a with SMTP id 5a478bee46e88-2a4abd973bamr8027943eec.22.1763481763720;
        Tue, 18 Nov 2025 08:02:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49dad0aefsm45188960eec.3.2025.11.18.08.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:02:43 -0800 (PST)
Date: Tue, 18 Nov 2025 08:02:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, David
 Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iproute2-next 1/2] devlink: Pull the value printing
 logic out of pr_out_param_value()
Message-ID: <20251118080239.405507d6@phoenix.local>
In-Reply-To: <20251117-param-defaults-v1-1-c99604175d09@gmail.com>
References: <20251117-param-defaults-v1-0-c99604175d09@gmail.com>
	<20251117-param-defaults-v1-1-c99604175d09@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 16:40:02 -0800
Daniel Zahka <daniel.zahka@gmail.com> wrote:

> -			print_uint(PRINT_ANY, "value", " value %u",
> +			snprintf(format_str, sizeof(format_str), " %s %%u", label);
> +			print_uint(PRINT_ANY, label, format_str,

The problem with generating format strings is that it makes it difficult to
impossible to use any of the compiler format validation flags.

