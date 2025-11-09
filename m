Return-Path: <netdev+bounces-237041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A074C43C33
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 11:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C853AD626
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 10:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925026C39F;
	Sun,  9 Nov 2025 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aM5fnHb4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB111CA9
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762685501; cv=none; b=fQnWQZQQ03mmquLlNsDi0qlutrfROgzJWzuegUtJe8LXKs1WL9ZLGH9EJSHW95AoqAQH5c1BQjCM87Dd1XSS5f4V4iQu7x7C8soh4gOqc41onti6/IfUn+nrBaNgy/6QFTnO39sZNoH54wQ06Yc7xgywk+kTvkmiUb8GKgHeMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762685501; c=relaxed/simple;
	bh=TA5oNwLliGp/HMOpeu1wOIh5Y4qZznufK3ZNPcsqfLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpMB0/2PBi7ARuJ+wy9UsN334ODzH0m/u6IFAlhq0sIYTyKLRVqNkyGQkn/xxw6XsSkt9lfGz6H3PXsfM/Nig7NfQVcCq9KBRFYGbcEkEB3q49+btBmsji2rmWAKVResWPI/ApGYLPxwBg0DWTANqhwrzxc/PaTuRboKXqWEabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aM5fnHb4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso3827257a12.3
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 02:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1762685498; x=1763290298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdxH3vWlvBSciiZ0JpGiEzoOerU5KoOZeSvSp889gLk=;
        b=aM5fnHb4p12ea4U2tICbciotFL61jV9f7QDPomttxHSTadOooMRPfuhDc0wQvy77p0
         /qbcxTHtOEjsKqwlN6RdUhDZ/dQfdjxP6qb3ai1eH+Ad1TawwCmV/5UUTyIB5vOhiZ5o
         6GVhJmPFBeSnfl0WxZdUaW5k0EtASwSU5uK22Aikna/GjH2U+LPqqOiO7hDPGoV/a2ut
         sMcNAgKTOiNu/pkPANLrgGEOhzwVNRiPUe5tEJpX+UtV7pX6W6sTflQ4Cbz/5592jbkO
         P1pJGyZ24DkzatW+dGKc6zVt+vrNcNM8DgW5v3qhcB+2xlU+yPulR6JDa6J0JTP/C+wz
         YHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762685498; x=1763290298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdxH3vWlvBSciiZ0JpGiEzoOerU5KoOZeSvSp889gLk=;
        b=vgQ2U//Fiki6WLrUdJXZyQrpWT0sphfv2rPFIKc644mnJ35aQJPRS3YiMTlAgXrFYI
         uyfCzkdgrJoAwm26cdXfN03FrhgLLl5xclE1KUaByXRuSp4g/1FaKHmViTQ1w7R17T/Y
         2CigBUNW4nqfFj4K3zEBVF/yH3i+Ol3c9TVi1bY/oBTAclGwo/e57FEsL3aRyGlBOWuo
         l357mleggrFmHUhtoZM+waf29IHjKc1yiEQG55MoTgogmlzZ5kpeKvJ1Ng7oOFw0iAkU
         eI5KawwnXdeP199d3eczFqzlf9OFhB1SKAUD49Y82+rwsfiCv7yosM09maH10Gkk+mjh
         rI3A==
X-Gm-Message-State: AOJu0YxxRE62+Adx+PB5LlvCFr+QfiKIoKVvdYdW+Db0ablqDAPhmU5k
	eVvJ/ggMiIzXXkWGPtAfU3GAWUlFGPsMk89ICT6bCUGq8W0+6y4rewg3d7DVB8lNSuxtFIR23+B
	ybeWD
X-Gm-Gg: ASbGncu76SO0w5OgbaadOxFzW0C4+d6B0uvZMz39gIBnVLRaytNx/qI0XbqSpyuuFTv
	gEyVcMeXetTX9jZSo23DE8i0qIlnLSwx6BjDfJcHlkitewdPctVICA4JXHR9CBcptQs4O0n1NmZ
	4s4CHzcp44ZlTfgeztv4JE8hEn+C8Af+xd7eH9Zf0N5S2Bb+0JwnrLwNQkHXkHl3rSqkEKNRTqq
	p5SQlylVocz7EeJ0mPUA26KeDdAFPZXi9NVWiGMheQ7vv2KpI/1mql35nuwV9xiF/ac+sV4kZTL
	KiQ4yN9GubL12mqhLOrJlYCskpGmSGtS0MxoG03+2lgb8FxVxH35mP4rH7HO7tj2jeVcWWEDWq/
	4Ktxqq9Mh7ALLbji2r6jfg8BKgUsg6KwdBK0c4fbWC/O20/5cMK4QeODz3dfTrvMFvPOn4zfZgk
	+CQSjLjg==
X-Google-Smtp-Source: AGHT+IFkV8pGT2E9pRwvxi98FUwmNjxqOo2MMzsEhYrsfz6WWzi5yO0twttP+TSwTXUg8RJEtb4RCg==
X-Received: by 2002:a05:6402:3058:20b0:640:f994:b887 with SMTP id 4fb4d7f45d1cf-6415e8312d3mr3031894a12.38.1762685497822;
        Sun, 09 Nov 2025 02:51:37 -0800 (PST)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm8644490a12.2.2025.11.09.02.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 02:51:37 -0800 (PST)
Date: Sun, 9 Nov 2025 11:51:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org, 
	Ivan Vecera <ivecera@redhat.com>
Subject: Re: [PATCH iproute2-next v2] dpll: Add dpll command
Message-ID: <4pl7njahgvk4rfl7lamjjpg3ycoqghd4urdbzg7p6qo6my27kl@ugke7xximgtp>
References: <20251107173116.96622-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107173116.96622-1-poros@redhat.com>

Fri, Nov 07, 2025 at 06:31:16PM +0100, poros@redhat.com wrote:
>Add a new userspace tool for managing and monitoring DPLL devices via the
>Linux kernel DPLL subsystem. The tool uses libmnl for netlink communication
>and provides a complete interface for device and pin configuration.
>
>The tool supports:
>
>- Device management: enumerate devices, query capabilities (lock status,
>  temperature, supported modes, clock quality levels), configure phase-offset
>  monitoring and averaging
>
>- Pin management: enumerate pins with hierarchical relationships, configure
>  frequencies (including esync), phase adjustments, priorities, states, and
>  directions
>
>- Complex topologies: handle parent-device and parent-pin relationships,
>  reference synchronization tracking, multi-attribute queries (frequency
>  ranges, capabilities)
>
>- ID resolution: query device/pin IDs by various attributes (module-name,
>  clock-id, board-label, type)
>
>- Monitoring: real-time display of device and pin state changes via netlink
>  multicast notifications
>
>- Output formats: both human-readable and JSON output (with pretty-print
>  support)
>
>The tool belongs in iproute2 as DPLL devices are tightly integrated with
>network interfaces - modern NICs provide hardware clock synchronization
>support. The DPLL subsystem uses the same netlink infrastructure as other
>networking subsystems, and the tool follows established iproute2 patterns
>for command structure, output formatting, and error handling.
>
>Example usage:
>
>  # dpll device show
>  # dpll device id-get module-name ice
>  # dpll device set id 0 phase-offset-monitor enable
>  # dpll pin show
>  # dpll pin set id 0 frequency 10000000
>  # dpll pin set id 13 parent-device 0 state connected prio 10
>  # dpll pin set id 0 reference-sync 1 state connected
>  # dpll monitor
>  # dpll -j -p device show
>
>Testing notes:
>
>Tested on real hardware with ice and zl3073x drivers. All commands work
>(device show/set/id-get, pin show/set/id-get, monitor). JSON output was
>carefully compared with cli.py - the tools are interchangeable.
>
>v2:
>- Added testing notes
>- Added MAINTAINERS entry
>- Removed unused -n parameter from man page
>
>Co-developed-by: Ivan Vecera <ivecera@redhat.com>
>Signed-off-by: Petr Oros <poros@redhat.com>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Looks good to me.
FWIW
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

