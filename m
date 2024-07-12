Return-Path: <netdev+bounces-111084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79D392FCF8
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3491C225B3
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4B172BD1;
	Fri, 12 Jul 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5JaZNGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460DF1741D4
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796082; cv=none; b=FH6VQjQcXTNQBX9RepvHmpH4On9VAl+4sr07ct2yJ+ATbTd32Z9pcY6OsoWRn4te9mLnrRCY69TpwWFLQ5DVKdZMcHXVGr5zbxbo/4mIjRQmp6NwwUiy59kdU3oqI6Wd1KpinKsF6sNKjjNKcSC+RX+b7L+NZydqSXasze9W1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796082; c=relaxed/simple;
	bh=/42u5tOBK3DmneyO/dWXEB4gsWKjJ/DxXBVy9Gm1Zhs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nPkoYxGJm1LmOnL9SiMS27uY0lnAOPWe8kC4mTNfUDl5y02/C0i9YgTcIDwRXhckoZ+joP383u99BmsUYX4wQsfiWDUotFuSR/P6lWeGQWGbnFQ0J3WA92flcxcO1WvUWCPkkkewWAUJTnhD9fSnf8OjeLqCL7N2ZWgasdztw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5JaZNGQ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79ef810bd4fso139898085a.2
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720796080; x=1721400880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RW3/Nj9/9Mv8ufkpNF8ht6um9Bus4NZDvgaHTdS3HtA=;
        b=D5JaZNGQ8CsT5wNtXoJ+u14W7GRG242HzaOOD2Mx+TTmQW2jbpZZKigY0BJASozP6W
         Su6ZPsaFmAop1iqSKX42K2yQspYjAFQc5Yz1NQTYZU/jY9ZyQz8Q5q+UF10GjLFUXBWw
         +5NOoBvYziNCmAQ1SVhcHaF7eKd4psq879yXE2PVds0cx8ELoRBHP+FIoUu/k6/SUe6X
         JUtAQu0NyDM36c53Imk+nTvcXDuXLKC3LU3dh7UY0dtag18WLcjW7s8LBg8oU4eECSPc
         3mwywqllshlzeKYoWztvgqEIb5stTyIUGJ6pf3xOtZO7aGXKWyqyEeeQppGDKrabhdli
         QsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796080; x=1721400880;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RW3/Nj9/9Mv8ufkpNF8ht6um9Bus4NZDvgaHTdS3HtA=;
        b=AANjwIUinfP8pbAND2ifiIDvzj9QNiXNbg0SyAbD0vhzvw381ngU2d2EwN070bKTCo
         JBW/PSy72uwIj3KFgRLgNL6NjW/Ngrp+L6ISq6uAUynF/9BiqBIakLts0V8/5ZckikSS
         fH2JDXuf18ROhEXKX3IlNNWRjE9WRu2hDyg1+TRk41aUL0qZRc+M3OdfsSbxPz2MVz/R
         uEueoNwnn8CN6yCtF8F/IMjNQs8jSOrZW+cq2MYUl8ksoQWEPlDFHK0GVqLeB4xGBZBE
         1NTIF03N1eKUC2lKZVWFGXiy15S4YXSlCF+cVTIY02lCUswj9gNMtf1bsRs0OzvT7ya8
         puJg==
X-Gm-Message-State: AOJu0YyXFzSQ7vT12xvqPGwBxuvyY+JTtab3KMw25NTYyMjb3am7GzXC
	xjjWdv4QAO3muyrAPjFWksEifIjMYeCJZHPOM0oC7hijm1yOQdHHJJrZeA==
X-Google-Smtp-Source: AGHT+IFX340H488wQP5jkhrsOkiAX85tv+D9O5ef2kh3/MwdZDiWIyE8pzQLt/t+jUPwa0OzSLNFqw==
X-Received: by 2002:a05:620a:2952:b0:79f:af4:66f1 with SMTP id af79cd13be357-79f19bdff8cmr1618132185a.50.1720796079942;
        Fri, 12 Jul 2024 07:54:39 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1457912f9sm224054385a.114.2024.07.12.07.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:54:39 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:54:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 grzegorz.szpetkowski@intel.com
Cc: netdev@vger.kernel.org, 
 kuniyu@amazon.com
Message-ID: <669143aedb989_24ac882945e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240711174123.66910-1-kuniyu@amazon.com>
References: <CY5PR11MB6186C896926FDA33E99BD82081A52@CY5PR11MB6186.namprd11.prod.outlook.com>
 <20240711174123.66910-1-kuniyu@amazon.com>
Subject: Re: [PATCH net] net: core: sock: add AF_PACKET unsupported binding
 error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: "Szpetkowski, Grzegorz" <grzegorz.szpetkowski@intel.com>
> Date: Thu, 11 Jul 2024 13:48:07 +0000
> > Hi All,
> > 
> > Currently, when setsockopt() API with SO_BINDTODEVICE option is
> > called over a raw packet socket, then although the function doesn't
> > return an error, the socket is not bound to a specific interface.
> > 
> > The limitation itself is explicitly stated in man 7 socket, particularly
> > that SO_BINDTODEVICE is "not supported for packet sockets".
> > 
> > The patch below is to align the API, so that it does return failure in
> > case of a packet socket.
> 
> SO_XXX is generic options and can be set to any socket (except for
> SO_ZEROCOPY due to MSG_ZEROCOPY, see 76851d1212c11), and whether it's
> really used or not depends on each socket implementation.
> 
> Otherwise, we need this kind of change for all socket options and
> families.

Making this change now might also break applications that
set it even though it is a noop for them.

