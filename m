Return-Path: <netdev+bounces-129978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC30987639
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 17:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52151F25492
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5068EAD5;
	Thu, 26 Sep 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq450EPL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E367F477
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363203; cv=none; b=oPtK6jS44vkZOdbuCFaH3BF/h91u8n/etPOfyr/5kxX7fEsUNiP7JeHOmSu7r6Jd6yQvN4+j4GsozWm5OP6+F3s+ZGp4J4xRTAZnFd54tweyQTvF06OXok0bLV84fRiIrif3atoFfBa2AO1T9Eo8ceEXTaInHJtzgc8IUVu3L64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363203; c=relaxed/simple;
	bh=JipPUZGdyTABxCfIzyk9/1nJgohccU99DSLODxVSD8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLWCI8qVzkHToHgtheusmhOOSZIJMEtAjldiIfLzfZVgjgmXGNgP/0qYCsVrziZU/uu9iZpsERYM8ZLmCSzclPASzAcRKdEEGrP46niItcU/Qh7C72UlGLrLUeLLQHXrUhC1ZPNWd+Y3jo60PXjfrmiUQxXmx+pMpChgr6btOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qq450EPL; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e5568f1b6eso568635eaf.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727363201; x=1727968001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JipPUZGdyTABxCfIzyk9/1nJgohccU99DSLODxVSD8g=;
        b=Qq450EPLCGZNDqPZXGidsKTIL6pWeEL6vNHePkO6FKKocIjyYL7ve7Eoc3ZWZqrppJ
         Y/uKrgSftOzhU7Lo2ISgEPKtDU0K6Pm2OWIt87cGJY+rXKSYqQAyGq/3c/DAUekxmrSN
         DZ9mOGNLJwSs3QWyPIjDlpdoOfkhd96DiH4KpyhqKP1BKdeuSumBDhCF71J/YIh8ULhO
         OVzH0mAHDjQPmFbeL0bE+z06a+sSAAX/HW2KBy5mA1HL0b0iACaLFYCE++xegsEOpHp9
         sr5H9Vf3EDNw7Ls4vOalW2G8g9EYUBiOPeZDJfcdZ/6sRTM88kp6P8tq3FSmAFabmeVn
         qemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727363201; x=1727968001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JipPUZGdyTABxCfIzyk9/1nJgohccU99DSLODxVSD8g=;
        b=qTWM8/kZLtbKYdMTVDjPCX8QjOaxQe1ZKjGy4fLC4bU4HoeX8In8wb6K9kbXEaTX7b
         G+EZ9L/fhlvfj4qRQjTz/+sFdSsLwaNLoGD9qAbCyhD2kp+TNZD5oqkfU6D/rve/p3ot
         xby+5SrChE8c+OtIQ6hHsYAwd8P6CfOIE5aV72M6RS5rDOQNLny4cCevzoLE71xJmLiA
         rsFNSbRdn5FE7wWSLG38ixQcGwakvhNyGHgHAZ/M7ccyryMV4GgaDxLqi1qi83C/8Ebv
         DnUfL8U4NzHsrTCbYFdcFw29X1vQq+gtI39BT7FuscwYDA2vXKCaTZSmgpeWfjaMRwfc
         cCdA==
X-Gm-Message-State: AOJu0Yx85uPxTc9LM533zQh0K7wcJGyVmals/5R83wzgzWVPSUFTefrP
	feBCzwpUn2HZQxg0rZoJniTzC3WK8gvn3m+yTY8cQcMrYvzpEsfCTMDQDSeLEnJcfY6JzGqKKGi
	BwnQbxzQ1LzbuE8eC+MhtHBsbMJYHTa5K
X-Google-Smtp-Source: AGHT+IFvYN3yM4QW1Qp3id5JvG39VDeWPjelOeQKEg0clDUSOp3lQ/nM1o49/CfHzQByb7rnNQpqSE8XADQn9OeRwLs=
X-Received: by 2002:a05:6870:e310:b0:25e:23b4:cf3e with SMTP id
 586e51a60fabf-28710bd9a0fmr133957fac.44.1727363201415; Thu, 26 Sep 2024
 08:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917010734.1905-1-antonio@openvpn.net> <20240917010734.1905-5-antonio@openvpn.net>
 <m2wmjabehc.fsf@gmail.com> <99028055-f440-45e8-8fb1-ec4e19e0cafa@openvpn.net>
 <m2o74lb7hu.fsf@gmail.com> <1f5f60cb-c4a5-44b9-896f-1c1b8ec6a382@openvpn.net>
In-Reply-To: <1f5f60cb-c4a5-44b9-896f-1c1b8ec6a382@openvpn.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 26 Sep 2024 16:06:30 +0100
Message-ID: <CAD4GDZxShO4pRaYvzeo+wrCKW-VX7Ov2XDBz8990qv24v+TUwA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch, 
	sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 12:36, Antonio Quartulli <antonio@openvpn.net> wrote:
>
> Donald,
>
> I see most (if not all) modules have named ops dev-del/add/get, while in
> ovpn I am going with new/del-dev (action and object are inverted).
>
> Do you think it'd make sense to change all the op names to follow the
> convention used by the other modules?

It's a good question. I'm not sure there's much consistency for either format:

Total ops: 231
Starts with (new|get|del): 51
Ends with (new|get|del): 63
Exactly (new|get|del): 11

For the legacy and raw specs that I have written, I followed whatever
convention was used for the enums in the UAPI, e.g. getroute from
RTM_GETROUTE. The newer genetlink specs like netdev.yaml mostly favour
the dev-get form so maybe that's the convention we should try to
establish going forward?

Cheers,
Donald.

