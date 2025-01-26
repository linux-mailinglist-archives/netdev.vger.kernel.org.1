Return-Path: <netdev+bounces-161035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C55A1CD42
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 17:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FC51659BC
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB47E156C5E;
	Sun, 26 Jan 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="StEsqs73"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799F25A655
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737910687; cv=none; b=KlO4HhddOw9e2a/ssJWUmBR4ELtfP2fbEqV7uwO2ciE7Lcf7mno+2An+gIGZmZTTnRojeCr1ky68zp7zcfRg97/uSvCuNGwFrG09HqsfPm+veFEMrsmLvCYMbjhDqI7y9TeyuZs0t8MsdJYYeOeoftjQHF2J/gMSUsSD5ujMNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737910687; c=relaxed/simple;
	bh=n5bqR2zcpS1iwunXt/z8LKRlUmMlnGeYffJ6XmI2ngM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4EiesiYJvL45pYYjzkZlpq7fAKwXv2PFIVaUaCzegoy+gpB3Ro8MNtuVFRo/UUOmXfkO1DDbRGbJkYKa5KXaGsUSTtcajXr8HMPlXvlzmdEjqhEe8U28gdSC5D9GGL2LetJsnyXcZBgs2AoN/QWwXnlzS6I20EPOJ+g2VZ3LKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=StEsqs73; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216634dd574so43010665ad.2
        for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 08:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1737910685; x=1738515485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcvxy4nKlemlt7/Ka3xfuQSO9MCTeooyY8ESZW315JU=;
        b=StEsqs73EP9yZRrjr9peMqUXuC2LNFcMFBsSOVGdMbwVOUpLQ/F071HzIr/XTBKb6l
         Xo1gYygflKOCf9SfgB/NQ4lBgqz4gQDyz5IWUaAgR97qE8JbAOyZh9SkKLn+ey/OGQFr
         waJVN6vbw+bZxGW6V4Fq7ubRgo5rHqARYzxtvTQ2yYLiLFgQdgMVCXvDWNofoABlU845
         TQ4Cl3uYhT5YzrxF2dpfeWFhw2FS9dUPPc9iBCMpUENTqNxbMrI5qtGQJQtPzDWuFfY5
         qiwJbPous94i0TRBB3mPne1LrI6O1Q93DJGVtFtQpRc58FxJJbRHPtMzOR6pEQFCgeys
         EPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737910685; x=1738515485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcvxy4nKlemlt7/Ka3xfuQSO9MCTeooyY8ESZW315JU=;
        b=GatPpR0C43zLsjwJCP59oWmG9zgLm2NtL+9wS/TwRXfypo30GLMmnkDDEhjsSUNmsi
         SyOEfHcVBaD1KBxzxuC4aL3uxHgEa+CpAx6sD75Fk0TOzmRzfczCa4v+tvXzCevT60PX
         Mz4t9KKQe3YkI+oHf3wSCoNixflcDh8ilIeh1A1BvbdAHKypmYgVGPRDhoGVeUiBhyQk
         ebwDCs6Lbo84lgqBGI+gThXVw/C8VnVnxDRcW032dRgHt/0jaCfBaHxDnFEwMxgi15uE
         seZFE6i+kAbM2hqfwxyKUi2Yjr8CVJKrOieBIyrO/J3vKnQqWwm6vaT1FzSwORelA18U
         rCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDIrdKM0sL3Be7baHOxzPS1CmxfsYt2bFoRlpjJiD1U1hxEHTrbX0CR3o9WZVxfTUe5HeTdxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo+CDws4XLsnjrZPHKF1XAtm6iXn3iX+gN3pncugGaFy04FgEM
	zl7AH1bh4B7XJFlBcj553BhAXk7m/m9o/NkvEsaCvcPb3LKP2WDiIVtUdEZl+XM=
X-Gm-Gg: ASbGnctR6RUZBW4QzsF73NQyS7VUHslBr+bhQ5ZJKysX+EEsLZwIfVeZsxMk3nmuw9p
	F6VkV7dXispPF3/K5f8bXBOVP7gY70waLdfH8CT+A+nEAVIcwUdJS7c3qPtBriiv+aLQUgYgOI/
	lLHOy7nvB7+FUWFmLVKpbxT8gx1WBbJb/cBk38SxpsWSCtp9KJOWz+2ekfSBiCzG4rSJjY8P76i
	4qV8feKy8xZferbnPyuCUbQZUay/lyLhDkOw9FaJEg50sKb9BVkLBtwuaFx9W2GOYDCFB6m17i7
	Z/yYnxWtz2hruWzH+X3liA3FdFm1xCBtOhdQKTjt5H3XboqxGhry7r+XSw==
X-Google-Smtp-Source: AGHT+IFKcuMFIzBVAn4fvwUlOHJ974xUrHQFYFOHc3Ezb+x5Mnj/MWQQPOfl8KshDn4+qChvM3JR7A==
X-Received: by 2002:a17:902:c94d:b0:216:55a1:369 with SMTP id d9443c01a7336-21c3540179amr537883925ad.18.1737910684705;
        Sun, 26 Jan 2025 08:58:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424e7a6sm48309885ad.231.2025.01.26.08.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 08:58:04 -0800 (PST)
Date: Sun, 26 Jan 2025 08:58:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH iproute] iplink: emit the error message if open_fds_add
 failed
Message-ID: <20250126085802.5af23e35@hermes.local>
In-Reply-To: <20250121141642.28899-1-kirjanov@gmail.com>
References: <20250121141642.28899-1-kirjanov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 17:16:42 +0300
Denis Kirjanov <kirjanov@gmail.com> wrote:

> open_fds_add may fail since it adds an open fd
> to the fixed array. Print the error message in
> the such case.
> 
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
> ---
>  ip/iplink.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ip/iplink.c b/ip/iplink.c
> index 59e8caf4..1396da23 100644
> --- a/ip/iplink.c
> +++ b/ip/iplink.c
> @@ -666,7 +666,9 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
>  			if (netns < 0)
>  				invarg("Invalid \"netns\" value\n", *argv);
>  
> -			open_fds_add(netns);
> +			if (open_fds_add(netns))
> +				invarg("No descriptors left\n", *argv);
> +
>  			addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
>  				  &netns, 4);
>  			move_netns = true;

Not an acceptable fix.
It is not an invalid argument, that would just be confusing.
How to reproduce this?

The original patch that added this made arbitrary choice of 5 fd's.
If this can be reproduced, that should be increased or switch to a dynamic list.

commit 57daf8ff8c6c357a5a083657e5b03d2883cbc4f9
Author: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date:   Wed Sep 18 18:49:41 2024 +0200

    iplink: fix fd leak when playing with netns
    
    The command 'ip link set foo netns mynetns' opens a file descriptor to fill
    the netlink attribute IFLA_NET_NS_FD. This file descriptor is never closed.
    When batch mode is used, the number of file descriptor may grow greatly and
    reach the maximum file descriptor number that can be opened.
    
    This fd can be closed only after the netlink answer. Moreover, a second
    fd could be opened because some (struct link_util)->parse_opt() handlers
    call iplink_parse().
    
    Let's add a helper to manage these fds:
     - open_fds_add() stores a fd, up to 5 (arbitrary choice, it seems enough);
     - open_fds_close() closes all stored fds.
    
    Fixes: 0dc34c7713bb ("iproute2: Add processless network namespace support")
    Reported-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
    Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
    Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

