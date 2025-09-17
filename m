Return-Path: <netdev+bounces-224133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A63B81177
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511121B26393
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18A2FB0B7;
	Wed, 17 Sep 2025 16:56:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC62E0927
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128216; cv=none; b=pG08LP9NG6saoISPOMW99tMtK/Z1x1XPaA7QfBeqgR49aynvLPzatF7+6lJ2kqsbQpbGWK85ly495rN4KGGpZJyk0SGMDaSuglzSn3zR2tNFrAKo4xv3rggKbJWNndT+l8WsHjsHU+Ve2fsjAwnJa6YbjCePlVhohc0Nvc9i+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128216; c=relaxed/simple;
	bh=2hPN7ILfVqTEJ+c3AG1t5AUjGGnDy82Y4ctwGuvzzZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDdp3S0uCJLCwmixX02Ld7n1+lXk6im7msHivQFt5MDtrx6rmsDmMpcI5EOCSjTQpKNsBRm55dXDmm3fMxa5YwqlpL6QgpgvQtNgMc8KAHjDk91eFfenGH/zz1hloqGcCUhtYh5/WpgvrInb1j31obPbnx1uqtuFFZdFngRWYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso8792163a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758128213; x=1758733013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U8MKFNdluOhv4aa38RV9TP5AYkB3xRCykBzF0UIvoM=;
        b=Xjg5sNUTWdxT7Fj7bTJHXBH3K80XnDEDwNtJqIW1od8OgKwJen4IZjZF/dJ+zXjpfM
         kSxF31jnv4YkRj+HX3wvm6xOUcXljhMVjogIhvF8R4chv6nzxBNB9ZJu4rTsia/8o1A6
         +/qYwElphEtjkL9MjktgpKQ+DIZoIWOYAlwmW3zMY8OMg41qI67/xPnGCDSPktohvL8f
         r7zUOfDozc4IdmPpAqOSyaRIqBv7+SS9johFD6Pxazxe+vbS6oafSq4dqraKQY5ZYN++
         E8qlLlNPUKMLEq463s9yOsKIHyNUFpaiGY3DUhbiQADtZiOeEvTRFO7lFcGL2ksbNiPl
         i7jw==
X-Forwarded-Encrypted: i=1; AJvYcCVu6gd5HJSLDPhUpHNp3Pda1kNa7FlRbDpxNek2kggUb18GVUWQufMEl0omFRrD0c1URGr9L6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtl5DxEODtfUnt6LekanEVyQXIruto404KhA8K0kaYVdYZN9ft
	ekhrmOckgGSZ499BsHCCqWB9hCpCZrsTOMyKB2Jnkt+hoAcMiLbiSSwb
X-Gm-Gg: ASbGncvL+dWq5OeyqqXqgnUducwTxt39D1UZocQakVihJfp0Py5GMHB2w1mq0tpdMzq
	SuWZvZdo4qpbnA2V09fDNwROcKl/YLTT3NoxE5Fb8oCGmffLfFBmHlDVLvPjvW7B+gWEYJZ5sQG
	0dBJKmYA/x1xFZvqSRkCK7LRXZlI1jpmNWWSjScHlcmnSuzk8ZNAsiqwjaOgM7ZlJKMUCebOBNi
	SXcCJFHe0D1pYTVQ3EyMJhdF9sjWghshmFOevDdomENN060dvclRIhiqSy+5+WPEBl4+xttuzCK
	mkG2DbYoT5oJfeQABogOLsCEOqx1YIb96uhsHwHcKpnix3M/u87h4GcFOKRq4uEav3quhbc8way
	gXehkIOCPseCn
X-Google-Smtp-Source: AGHT+IHJpIlHY2aCZmF0CH+nbnFOFzfFn3bboh6zZrx2bP16Eyzb6LmBuSNHyS/M1WQcJVBhRlM65A==
X-Received: by 2002:a05:6402:2816:b0:61c:e1d6:6bf6 with SMTP id 4fb4d7f45d1cf-62f83a06fcemr2995700a12.7.1758128212480;
        Wed, 17 Sep 2025 09:56:52 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62efe17e03esm10425340a12.47.2025.09.17.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 09:56:52 -0700 (PDT)
Date: Wed, 17 Sep 2025 09:56:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v4 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <xskolllpk7re4qptsyznfbqngns55hetjwy2psdio2b5fyr7qe@26qv7rpschzs>
References: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
 <20250917-netconsole_torture-v4-4-0a5b3b8f81ce@debian.org>
 <20250917091309.1149dc5a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917091309.1149dc5a@kernel.org>

On Wed, Sep 17, 2025 at 09:13:09AM -0700, Jakub Kicinski wrote:
> On Wed, 17 Sep 2025 05:51:45 -0700 Breno Leitao wrote:
> >  tools/testing/selftests/drivers/net/Makefile       |   1 +
> >  .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 167 +++++++++++++++++++--
> >  .../selftests/drivers/net/netcons_over_bonding.sh  |  76 ++++++++++
> 
> We need to add bonding to selftests/drivers/net/config:

Oh, I though it was using selftests/net/config. I even wrote on 
the commit message:

```
This depends on CONFIG_BONDING, which is already set in
tools/testing/selftests/net/config.
```

but, in fact, It should be selftests/drivers/net/config. I will update.

