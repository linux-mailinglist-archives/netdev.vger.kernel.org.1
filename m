Return-Path: <netdev+bounces-225491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50676B94B68
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365331901B4C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9100430F95C;
	Tue, 23 Sep 2025 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwi3bGID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB32EAB64
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611518; cv=none; b=iXFD1gXz72JQVWj5OO1zrwAFvZB+CgJw0FiiwvkPNMLIYIyc7XMMx9MVy6Ogp7PWIfXSYBPbsr4+thu6F3Sh7mO1enhHWhTFX7+Ld8V10eEzpCfbJcN1rFaDO90BBAI1sgm8jrJghYyX2x2BsvPeiYzdnpp/INpJS95I9KC4E+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611518; c=relaxed/simple;
	bh=7iONL8v6z0oTB+q7lJGr39cvG4XyvJ1rttD84Eu2h2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK+o8h3ywIcIEvCg380ZHvVqZEqGGhV+nbtVgz4zJnEl5wgk/lz3F5f3J9pzozqxkom5f47XLEpgNF/tV7dN6hCjPQffpKsFLlDkmP/65CMxRHw0MNJ6vWOja72GF5Nn6h6xhlp6C7wbq63wVgLr/hHWaiHbNQwftk98eqIy9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vwi3bGID; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46b303f7469so18718055e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758611515; x=1759216315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kF/vwsek+TX0jz1XNJrsBzbivVnVQSsSlm9v5mtUJOI=;
        b=vwi3bGIDGziXrwFv1nkTIk5cUht1UKp+3UKXSHHPehT0CEmJN3hnho7TKLSDVnPS9u
         rOXHf83ZXVdGswYFCjAgNqrfm1xmB/+UwbqbFtPjMIYFITJ5wtC5IwQmsmvfyfxs3rig
         yRaZ+5HLIeSGHiG1w9j2HQpLqo63qWbsbziPS0QJnmrqLonaEI44bfaug+LbVtPfvzpQ
         W5SQ0+g6e5xrISreJtIQFnOpknmVeQT4Gw2vBc8Bwr95AHDj+8N3868EQ1xi1phgBV5t
         kav50VMNIHh+ixhvu/ny+uivSLC3s3zevng5G4LXjUGYQDCCowZpDtyfTlU/S+sGPAbl
         kgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758611515; x=1759216315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF/vwsek+TX0jz1XNJrsBzbivVnVQSsSlm9v5mtUJOI=;
        b=UehA3O+CdaDcTZFAPsKf5O9MefIEPDmxxD/uM1YzbdqO8F4XYPXwPL28tYiFA+dLT2
         zBfPicdsZ6t3ECqhW+kSMB97CfTJMIPN8QLGGrUF8CXTfJ/3IC+gNLJstSmC9lWAQcZn
         2tw0s6cxd4UiuTfQbN7dcbSSJKcxEQow8WRylW93/B9CGvvmorBD36zfF123/RAHAQk0
         vyjqPB9/j9NHvbd21m+uMZTAoN2WkDxHi1043H0moiqQJI0cFUvUmtFTXTJIZX/EjK4c
         QwWYNrbCiCWkmb+pArbGw70l4Eoo5XfwIy1wBELZs0zFkYmz11OKvT8BppQDDOeR0waD
         vCEw==
X-Forwarded-Encrypted: i=1; AJvYcCUkGoFTmHHpPBKei7+hn3KS/RTfH6YHiI73nmwaRN4sr+Mp8HOHxGQJ20hIbOCJ+YGDyVOMN8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf64gLq+OMXO8q6AJ2jyJ5nupkHJ3g3IMX+frO3o5IPBDmT4fG
	6Md8wOm9c1VrEcnOQyS26TGfIszd/LU1XADgxJaFVo8VxdFZDvmh2pbdQv3+23gC/S8=
X-Gm-Gg: ASbGncuHFfEFkscz2M8rqUMmMYn+McgIYxCrrGzLtzqLObaLPBUn/NWwLD/1/+u5xFZ
	VW2Qxbqvxwfcue4VVQ3y4oB4dE3+vW913LuFYuRZ/pXfXvowHYkru0O7EPMf2XDXSWPJOIt/XLl
	T+SUxJiJpWHXMtXI4cqoYF+xoCrE8IFEql4MPV9TxaoQlKKkxtI2Cl7bz6XaVbQMEmPLsce48wJ
	k76OrB/ag0v+A6uUDMd3NCA7GJsmZMMunKXCSB54b7nAwunoCXk7oVPwX1ymYQfLjVl6l2VpT2j
	FOIyT/r0Rvw7+48/Ihg7SgnzdV+3ipSAIDGcdgQhN2xyrp5eAi7h69SeHcMk4XwJ15yFbIsQ+yU
	/1B0lGOosx4Du9i5cgx8qtSlldHQX
X-Google-Smtp-Source: AGHT+IETXRK4dmUcU1OY//+IY9VX2wp9AdGkgYqyjEDbbOe16hsBsbPJkcHHfAihkfG9eCqRmXw0Xg==
X-Received: by 2002:a05:600c:3ba9:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46e1f86b296mr11638615e9.17.1758611514684;
        Tue, 23 Sep 2025 00:11:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f527d6cdsm261777615e9.12.2025.09.23.00.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 00:11:53 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:11:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] 6pack: drop redundant locking and refcounting
Message-ID: <aNJINihPJop9s7IR@stanley.mountain>
References: <20250923060706.10232-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923060706.10232-1-dqfext@gmail.com>

On Tue, Sep 23, 2025 at 02:07:06PM +0800, Qingfang Deng wrote:
> The TTY layer already serializes line discipline operations with
> tty->ldisc_sem, so the extra disc_data_lock and refcnt in 6pack
> are unnecessary.
> 
> Removing them simplifies the code and also resolves a lockdep warning
> reported by syzbot. The warning did not indicate a real deadlock, since
> the write-side lock was only taken in process context with hardirqs
> disabled.
> 
> Reported-by: syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

checkpatch says:

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report

Which is relevant here because Google has apparently deleted their
search button and is only displaying the AI button.  "The email address
syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com is an automated
sender used by ..."  Thanks, AI!  I can still press enter to do a Google
search but there are no results with syzbot ID.

I can't find a search button on the syzbot website.

Ah.  Let's check lore.  Hooray!  How did we ever survive before lore?
https://lore.kernel.org/all/000000000000e8231f0601095c8e@google.com/

Please add the Closes tag and resend.  Otherwise it looks good.  Thanks!

This code was copy and pasted from drivers/net/ppp/ppp_synctty.c btw so
that's a similar thing if anyone wants to fix that.

KTODO: remove sp_get/put() from ppp_synctty.c

regards,
dan carpenter



