Return-Path: <netdev+bounces-210772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C18B14BDF
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 12:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B92188A4EA
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37B62877DE;
	Tue, 29 Jul 2025 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONxF/jQC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717401799F;
	Tue, 29 Jul 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783449; cv=none; b=BHCgFKshJAIQcQuTF8S+n8ZzTsFsNUyK9dEi9niPrKU4AjzmLrJJ6OORV6gpw4cdi8wO4IGXklKAPggDK9NSDITDpWczzsjp0Q4ixxPs117wpvGHBBOGamQhPYnKbM5qGGH9wexGwWWld0SGDmzN6HV21SHQF/XLpqirQu3u6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783449; c=relaxed/simple;
	bh=xJyOOvRbIK/Edjpe4ZWNEmnyI+CxVBoQinKIQo7Ylmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQRhL6COgdHVQmN3JqWpHKmh+Xg/NFJOEJDUzNWDusNwSjXpnalB/X0dfWUuV4KeYf/yu+JuJuG0TQEyz0rDhJRSbHde1xNGVLsTa95d2s08uJID3zwKKSR0VsoXvqiYeXqD98vLRiKziT070x5uun5AAKeWwqtsmWE+lWX7hDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONxF/jQC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-236377f00a1so47484705ad.3;
        Tue, 29 Jul 2025 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753783448; x=1754388248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJyOOvRbIK/Edjpe4ZWNEmnyI+CxVBoQinKIQo7Ylmk=;
        b=ONxF/jQCjndchZ+o3MQSeFzedcnyro+yTZMOHwBrZcS46Kli+BqM9ijmDsk0gQXOrP
         tDQW0X0NAwozHi6NN8M9q4R2BlIgsETTKIFr0onLiHIb35YmsaJhWl1SH4yDaKXwDUor
         m7bdMtAd2E1fcSrXmpFbuHd8TiVajl5/POVpA5D2KoSnVtR0kLI1DitOqZ1rqtUHCPvv
         szaiPNf1ialy1QIUpkK+Xc9UQEaKN0CBekJYJTkkOKda5VFjBZWHKnHJHZM5ZX0V6gGp
         uv5CEwbkEB5bGxBfX0T38qTKGZYbuoJtds6xZ1onM3ULUxJMDv22U2sPZBYLKaliLiXt
         rkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753783448; x=1754388248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJyOOvRbIK/Edjpe4ZWNEmnyI+CxVBoQinKIQo7Ylmk=;
        b=W9iMnk2RcqVG3vjcBdgWbhnfgI+1EeqluC7rYpc1CvldzgCt5gmHrSXusIACoNbwy0
         Ey7Zcsbn8Y13wSUSE0agPRjw5OyOyn98+lKz5ooWKN0VKF4LOhkK1HvfG5us7xUKimBN
         FbkoC6jPaBWproinlZTrIFciko8K/+lcqjE9CEDxNnySvery/UXkkCPSBAPZP1BeEnty
         yV4dQAlvimmymI+0uTwzUn69JkOAVaWJaTVIK6Xz6Tll5fFFb9Of8dCnfrAqW6Xj3x/S
         y940SYcQYYRWCebPLskiBf0PvHuK23yOcz2QdE93DTfO2KObtOgPdmau7nvJZOLs1zio
         J+fA==
X-Forwarded-Encrypted: i=1; AJvYcCVCkTh7yjqgGo5e+pSoRnL+KvNopkH3S8uQaw2MVURBcaBtII0cv9YoT+TkiEDyvHysyIGN5XkSDS01s00=@vger.kernel.org, AJvYcCWgwbnBzN8rnuGAHzJW4vLw2exiJQmWou4VZWXCisz061ncev9MyWRSCY4W5j5z5lE3R75YyqQV@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsZKyHQIKMN6PvaDWok1DlDPiWMIsUfqs29XhNXUW3Imw9op3
	WBZqEqMBJ6xTliTBvtJWE04MLREVullWcIw46c804vAD+Vu3ZFG7cfUl
X-Gm-Gg: ASbGncvzWPqIiKuexj1qVcMtLsvtFArriOJwuIZ2ZKXfsSA+Gn3Np4aQXSQBWXsD1Fk
	2SfJgTUmXvacIARrOu7NuMFBJB2nhFujLOXVTMDHVWU485eJ1rYtMoW7rPMC0qWKUh6ddUn9V4M
	EAD2/fVU8kkANuLG7xD3LE9rngAdJlswbi1JBbFpz3rRW2yiSn4tIK+33rc8S4N/Tty390VfhDy
	xKWaV9aiBADbNXEoCi+abolgvBr5myAs+YUdYLTGikjBNjKm9Y/0qe+xB2UXlwhrplpPjXCsj6U
	WdDpnUzpORZex9WjMSLEdKvpjO5bC/0HwnZabKcc1JmWVK12NHVSpa+UoFxVMJqNXbM7tqfadzh
	W9UsEgnW30gN4UNLO1RiyjsWrlT8=
X-Google-Smtp-Source: AGHT+IFTdHSp9NgiWSU/KD3LlwKrTJHnLWquGMVOQZLg1fMZbvZQBkIQ8zu9VqqzcAxyLgCfT/dKYQ==
X-Received: by 2002:a17:903:2345:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-23fb3040f6cmr192609795ad.18.1753783447637;
        Tue, 29 Jul 2025 03:04:07 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffa37f078sm55751215ad.115.2025.07.29.03.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:04:07 -0700 (PDT)
Date: Tue, 29 Jul 2025 10:04:00 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>, Jiri Pirko <jiri@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+8182574047912f805d59@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in team_change_rx_flags (2)
Message-ID: <aIickIPr0wPuTyQh@fedora>
References: <68712acf.a00a0220.26a83e.0051.GAE@google.com>
 <aIib_MyMj6jgCOVC@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIib_MyMj6jgCOVC@fedora>

On Tue, Jul 29, 2025 at 10:01:40AM +0000, Hangbin Liu wrote:
> Cc Stanislav

Sorry, I saw Jiri said it's already fixed by
bfb4fb77f9a8 ("team: replace team lock with rtnl lock")

Please ignore my late notification.

Regards
Hangbin

