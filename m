Return-Path: <netdev+bounces-219351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CA0B41092
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E155E70C6
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08598274B57;
	Tue,  2 Sep 2025 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsrI4VmG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A422836C;
	Tue,  2 Sep 2025 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854449; cv=none; b=FoNpumsKGgGEfODfuWYCxM8ybgnzHnieT+eZAkkNhphiQD+kjiR+Z4QuzPGNSq8f8iBJLHZZVFaq9v2pctKNgttTmRMaAoV44/Onq75H014yv6Q91c37w+qxeTQGCJp3FKyseJ1iY88ZuDquQz3nLerNNPyYwVpl+tks3uEGAWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854449; c=relaxed/simple;
	bh=/uq6p19+kImpEi0OoSJrJGM2gwYSXlB+zJgcs3LOSgM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IVnd5m6Psx36S/CqiveN29itm9VKpXQKTOXikTKsEBapsrPQ9Zk2oUwSwJaH/oQ2jdnRsiKetrBBHheEXv3/GkQiebkPQc2MLAhOChUjI+JKIHwQVA/PS7aELqOLaZV+f/TTUffxBSR1dbzTQY4283l0UiwRRhdW7SWtap4hAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsrI4VmG; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54494c3f7e3so1582024e0c.3;
        Tue, 02 Sep 2025 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756854447; x=1757459247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woWpwso7cgKxykh/N4zBwinfTsbNHangAXByJYsVVKA=;
        b=FsrI4VmGgciw2JDwmd9B3/uhf7/clroJCjqlHcVpzLHCSk6d1YqviYFHQR3p+QwvZK
         htq5shio90KT7Y6ZLL+wMTe0THR2C9onr3iOtjfEE+rTXCP56V1tGJ9MenCY+VNoa3UC
         741FRss25BfnLGhwAOwKyDc5pmBS+KsWobkVMN5v3GzPRKjuZ59TPUlskaLCbOt0LIjE
         VyrP3qP6vhyUUPmIdRl0N2u2Azc2bid5eadmhVZUYCJW6RalIsf8+JVVdRqjnqhLz4Fc
         Tq5CCb8aVC+BQJ6UHWpMX1Bf8X77/j/2m37m2PRrryHh6K98fCcjsAtI6yUEeJ4xUWoo
         lEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756854447; x=1757459247;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=woWpwso7cgKxykh/N4zBwinfTsbNHangAXByJYsVVKA=;
        b=Jfci/tB4zucE1tNuDQOVhG5lvati6mrh+S0ONzZgJLjP3zLK44xwqb+rL12An5ZHC4
         7CxEXveBjAS5wTdfvQs4vzGtd0bHDag9M6FmN8KbB51xQiLXM+9LWC6KzNxvSkYq3As5
         lWaAD0XK1SX4qW+1EMOkAXGUAvt0CfoySt7PvDNMvGCDcI932hMPAbRsSWuHiigszPkF
         0A5YWP1zk1RogLR2WJnaDloSMFR0DIs6HZBRcfejruro03EzlC9d7fZj8HzMtB3cJFsy
         4HHy/PQ4aHVpiaGXMhorvZmkLaU42W/To90y/P0XM7tz6FpaKXqcfIYVeLTcMlMeK9BB
         LogA==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZLRkOC5OULKBCyHf/zCPk4qBHOWiQAi+zPyH9V/4mtK6kJb7a/j1A9mVSlqHeZEJ9P0dQBnjovO0bSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN9cfQvwQi8ztpc+S/P3YWT+EgaBynQPIIeDMj6uwwJA+THtLa
	4QFEMp0mlIv7u/2dMK+a1RoAISw7q92LR9z/orYoPQjN5c0klwhXR0F0
X-Gm-Gg: ASbGncvq8pDbeH0Igy1cN5fXlJX+QpnXpZ6QefH89d49KqhkOmyaFyBcT5If0r1WXZf
	iop60QXjlIFyrzuyAL5YWbdzKUFQTnYtAmrcdtBU1LmaEt0eRnm7oZwQ9DwBEiDLIfyDyPWOhih
	r1rLL/IF1zeCRuc7zh9FNdPJM+r8vi4TyVSdG1pBzq6HoYY0FYgJsOjl6pcCMq9ISu8OOeAbdYu
	+T0VYRwJoKMn9SC99YHXOHNLvYY/d7eu44/hF8e3nc2gjG1rkpmxjqXiPRPtDeSq4ljiiw62tTa
	lhumGRUUkWCASiSmTkzCqM9wagAEPc/Ao7V+lGwk0RBUbMxty0vdUF8GJD3/CVjzRDM3eLGeQIm
	JdsXu8xPQ+Iiu6+S5jp5FP8jljg/7D6wmZnQjgex6CPgQDjmY5w4Ml424XgAN3ZS0qVIg1Qr5mr
	JNn7r+TWHUe1hh
X-Google-Smtp-Source: AGHT+IEZTjN2jVE7iIOvoJv2mmhQmtLnMlwuRxMJZ12YFhcWNXX5n2JgpSNvjoZVZahXX3eevAbUAA==
X-Received: by 2002:a05:6122:1805:b0:544:75d1:15ba with SMTP id 71dfb90a1353d-544a01d3622mr3763896e0c.8.1756854447040;
        Tue, 02 Sep 2025 16:07:27 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-544912c6f3esm6255218e0c.1.2025.09.02.16.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:07:26 -0700 (PDT)
Date: Tue, 02 Sep 2025 19:07:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org, 
 Breno Leitao <leitao@debian.org>
Message-ID: <willemdebruijn.kernel.7e2624ba7462@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-6-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-6-51a03d6411be@debian.org>
Subject: Re: [PATCH 6/7] netpoll: Move find_skb() to netconsole and make it
 static
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Complete the SKB pool management refactoring by moving find_skb() from
> netpoll core to netconsole driver, making it a static function.
> 
> This is the final step in removing SKB pool management from the generic
> netpoll infrastructure. With this change:
> 
> 1. Netpoll core is now purely transmission-focused: Contains only
>    the essential netpoll_send_skb() function for low-level packet
>    transmission, with no knowledge of SKB allocation or pool management.
> 
> 2. Complete encapsulation in netconsole: All SKB lifecycle
>    management (allocation, pool handling, packet construction) is now
>    contained within the netconsole driver where it belongs.
> 
> 3. Cleaner API surface: Removes the last SKB management export from
>    netpoll, leaving only zap_completion_queue() as a utility function
>    and netpoll_send_skb() for transmission.
> 
> 4. Better maintainability: Changes to SKB allocation strategies or
>    pool management can now be made entirely within netconsole without
>    affecting the core netpoll infrastructure.
> 
> The find_skb() function is made static since it's now only used within
> netconsole.c for its internal SKB allocation needs.
> 
> This completes the architectural cleanup that separates generic netpoll
> transmission capabilities from console-specific resource management.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

