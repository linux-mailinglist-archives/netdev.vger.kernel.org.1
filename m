Return-Path: <netdev+bounces-99261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2248D43E4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1961C21E42
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCAA1BF31;
	Thu, 30 May 2024 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nadHGXyU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BA168B8
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037768; cv=none; b=rY0dxwh1/8gdJIBrFJo9Gb/BMzQdnD26gyJJzZFlzdA301wbgUOAd3FN1l984cFU8uxWPfcnGg9WdQClkUBdz4+DUGfT2TWxnaCaIyQEWXHoVArywU0pT8L4rKx+c99W8oMjR7kfwDTaMBQBOB5j3STClmMov6hfRLlthzuIZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037768; c=relaxed/simple;
	bh=gAuHbMJMk7GTdvxvUxxKzbhmEciim21/rzKXqjM9ouk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HESM6FfLCcH8T2WuoJeZkzFZMV3f17Kq0VywNRwMCNmW9rBeXZAdHhzYP8Xq622hd2azI793aFJEE8nfNKDyFHeJw8/2QO8jHD0FIfRblrjB3h763beHp4nQqDKMrlF8ZZgM3cC1nyiCKVWgOnh9vrADkJZ5h21vh0Yzwa8N+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nadHGXyU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-579cd80450fso1106454a12.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717037765; x=1717642565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAuHbMJMk7GTdvxvUxxKzbhmEciim21/rzKXqjM9ouk=;
        b=nadHGXyU8vYJzh/TaTeK9W3eHQdCgCErcG1mqbnZ2Kx8LzVNV8YodlxMJsZRV8Rg1h
         59MucXuVxc08o5mACjySa280HS3eo7S6xO+qu8TdOuj0h8Jov/NF9wFOlPP4Nt8ZHQwK
         kupDQGJ3xPo6CWvS01iEb9H4sCHfMoI4gUUAni673DeRSyGJxYhXIkuFNVsdS2Ka+dli
         nSEGY7ioDZDWAIHHDhQuIKcbhIIHbYQZFkzsgQ6WtB0kjRjN+fInjGyHZSB6ZcUFBiYb
         NAib6Cw4fFvD5Q4y2OhPi3S3QXlbjBb3aa/77zsBjeUTG0appEynGQ6+s/SlL32u7nEz
         bKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717037765; x=1717642565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAuHbMJMk7GTdvxvUxxKzbhmEciim21/rzKXqjM9ouk=;
        b=PcFwLOM3MQ1SXjgvjpw5JQ6ttlJItoT9eyvT8wNZS0Yl4owITbr1k8vhd9m4vI9NLf
         y+g+8Wq8iUfSZI9eeuk3tN1UTcgJUmxz4EKTnyzGSdvewzVD4me7OzsehrV5VaRO/VNP
         uMriVZ3lzykl6mYzqmwSKxFLxocd3AFbsQV8quHC5Pr9Qhjl1c1zygEL+Lsji9MsfFDW
         aERS0joOvN9Iihe7deSFHeGodmaK6dhCo3XDpWfFL9k16PMJlzWCAA59UHvcaRjxDcla
         nXk0AjneY6OooNhrSh1YEeS0XOx+W0qC4Zswh+QrtsuFaYh+dSaypLG9gpKdKBhff7ag
         hiHg==
X-Forwarded-Encrypted: i=1; AJvYcCURNZkhEMCCvTW8eOsV6iuvF2Dm9M0j8Ri2LpXBAl2W5uLGtd2HR6XjieTTUsvMXc1QR8oaH66bbmwNzyBu+Vh43JmiFRRR
X-Gm-Message-State: AOJu0Yx1btLe0+0Qb3/GL0G4+N/dJI4+RvQLQ0mIR7FNdSPaytVTcmH5
	KX+aHkWPZiylM30DgAuZsxbQdySQwmdHSS4BWr+Uo80sRI7brln9JcbAnb+LO1MnkhXITzEytSK
	7H5wdZeGVGd4DDLeWzyn6evY3c5A=
X-Google-Smtp-Source: AGHT+IHYTArLgLBCWfuuZ6AQ6fCgvKqhVlapNj7wLsrgxt1ZqnDWqklmeoS/RZ/Ack+nKQSAWdoMFMQ1bjfElNumGbU=
X-Received: by 2002:a17:906:1398:b0:a66:20d4:adaa with SMTP id
 a640c23a62f3a-a6620d4d047mr197166b.17.1717037765448; Wed, 29 May 2024
 19:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418073603.99336-2-kerneljasonxing@gmail.com> <20240529203421.2432481-1-jsperbeck@google.com>
In-Reply-To: <20240529203421.2432481-1-jsperbeck@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 30 May 2024 10:55:28 +0800
Message-ID: <CAL+tcoB+a2+5cKsQMyXgc1wewVjwLJGFg7CWiKWVEpB-XTP5LA@mail.gmail.com>
Subject: Re: compile error in set_rps_cpu() without CONFIG_RFS_ACCEL?
To: John Sperbeck <jsperbeck@google.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

On Thu, May 30, 2024 at 4:34=E2=80=AFAM John Sperbeck <jsperbeck@google.com=
> wrote:
>
> If CONFIG_RFS_ACCEL is off, then I think there will be a compile error wi=
th this change, since 'head' is used, but no longer defined.

Thanks for your report. I'll fix it today.

