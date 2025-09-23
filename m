Return-Path: <netdev+bounces-225706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63889B97593
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 21:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9ED320CC9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D25272E6D;
	Tue, 23 Sep 2025 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8Qb5JmT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC85194A6C
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655845; cv=none; b=MQB0ALkGjLB/thWeC3g6aB8TyY3Hqgv+M5xj6AuZZwmWl6JmtbLfvUGueZTgpGezkOsMOMFk5Ahu+sqThVLf+/g9eLsw/03AMks1ndwUoFaI/sVnZtOtUdFu9JBllkaeWBM8mlr7i6CudSl/VeF91itb1fNhT8Xl/h514GISMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655845; c=relaxed/simple;
	bh=UwNgaI77PBjLSUE+r6FEG3m9gYMM55QqcYE/BwPrKY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgrpRHQVaTmSSjQ6wd1sVhi1c0xpzNj13eeTqBPrPpwFR7b/eQyvrTpxSenPmlaGnH1zU378ewc6D5ES5IrRe3jHpirN17s2Qo14yFwDRFAsKBXm4tAe2EOq3X+z649+ZI33mv0UUrF8T78zu4e9P2VFEnM6wvigPSxHhnPP0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8Qb5JmT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso44085625e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 12:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655842; x=1759260642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3XzVTxMO4iEx25I8nAUCxuLVUDgVKpjcSi8HGEwM1A=;
        b=S8Qb5JmTNvWjbsOSb4GzAmhgHDdETKBTg3543IS3Qia6TNW0CFMuwioXGfbjDhE28K
         RON5bUIKPcJTclpBw58c4LMKlfFRBuKp3GyL/Ba8nx1coiyCh73eB5mWnsgBtAE5lSNq
         jqdmee3zlJOiddzbtHMebCOEWp3t/Ume8JpmwU3xOxaSngua8lW+tzuzA9AkFix29MfT
         B3XJ+YVQ4k7I2S8XwBhzO82jA4f0kS3WQpiCiyLnShmPRT2JkjJXz/8uSwc1t/D+1VHS
         yzv+YTq1J+nl+gV8zD3Z6DLKSx+B2spziF5klIYq0krcZqJzXRaqfDY4B58+FE2trT7i
         7png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655842; x=1759260642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3XzVTxMO4iEx25I8nAUCxuLVUDgVKpjcSi8HGEwM1A=;
        b=A+VWiy+ZOAYSxcMsuIqpcQ4Z4yS5mnZ8CKxgosx4JMINbC8uehdfnG750zLuGHYIdQ
         /RFU4Q5GUGSxX7EQOwoj0SPIDDlrs1eI+xLRFdq3Qfp3Ms3lysFAgAuzKKjwN6sf+HIG
         Nw1ha7BIPI6SkLAmG1DFzoaJf6zFGSsYpTumFDsvatvchya6cMhnZP02RgAaBadNA6Cd
         SHnqv3SnepqYfE9zIfNfAwXLvvpr9YEzUb8jP7Vqa6DbkMlAQgfW5zJy1GZTUia/I0rK
         15iNPHfPBF35TrdIRetJ3qKB+dBY3RUBzYb58AfcG0czsP14aLR1HFZNPnaDLfzOIPqt
         CwMw==
X-Forwarded-Encrypted: i=1; AJvYcCWdJAT5Q4gN4zciODK3OqKb7ta+DjwjyM0T21Yu7mEZZ8Cz6LiYQ6TYoECurPmvc/mpehd1mjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4OmbKL0J7GE4fF0ddmGQ0nAU89SiI8vr4w4V8Nz9zg0SO5vR
	rFYSiRbFaOBUJ2fFw5LPjqCty//kippKgp3aEZJMc0uOXvGFTV3x8EEf
X-Gm-Gg: ASbGnctp2lky9sMTJ91WDeZff/cKOJXc8mYL93+cwY5axzJP2XUhiu4cROS1bf9Y1V5
	kZ+8+nS3HAM/DYbSpQmLSWw0t8xBk3TyQxRd7xT1uznaSvT0oNfVenl2tdw5vNRkxOAfDH7XMIz
	5ababHzhXV/2ChY09XNU/MJKCWNglH+E2ycjSM9tYtEb/WTr2IEOfDC9d5B0MAU8orMdm8448M5
	Ae2QAj2oZ3ljvx/cZUpqn8ULuHNqxPF+I+fNC3Sge0/VieVoQ104tuNjcF1odP5aslMOi65HQlv
	YETP3UgxsbzbNVWAXWUwkdzQXRL3gObtY+LdXkHdV9bKIBTADs4jXAYfMq0EQ8VJJ+4+SKzMlbO
	vOlSsgDewpnfBgmdJKaI=
X-Google-Smtp-Source: AGHT+IEfC1NNEAG6LGNFDwZmSsO6QvXxb0bSOmjC5mNFchosn0D8MEMu1s0ZAr8KAAjzIJEQm5U3VA==
X-Received: by 2002:a05:600c:1c05:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-46e1d97493fmr45353685e9.5.1758655841922;
        Tue, 23 Sep 2025 12:30:41 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f127660840sm19066278f8f.11.2025.09.23.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:30:40 -0700 (PDT)
Date: Tue, 23 Sep 2025 20:30:39 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>

Hi Breno,

On Tue, Sep 23, 2025 at 05:22:25AM -0700, Breno Leitao wrote:
> For targets that are set by the mac address, they don't necessarily get
> np.dev_name populated, do they?
> 
> I am double checking netpoll_setup(), and if
> is_valid_ether_addr(np->dev_mac), I don't see np.dev_name being
> populated.

I was not expecting it to be the case either, bu my understanding is that 
np.dev_name does get populated by __netpoll_setup, which is called unconditionally 
at the end of netpoll_setup. __netpoll_setup eventually does:

np->dev = ndev;
strscpy(np->dev_name, ndev->name, IFNAMSIZ);

I've confirmed that for targets bound by mac, np->dev_name is empty before these
lines but then it is correctly populated here. For targets create by name,
np->dev_name is already correctly set prior to this. 
Please, let me know if I'm missing something.

> Should we also compare that the mac doesn't match before returning?

Even though the above seem to work on my tests, I was not 100% sure we wanted
to also check the dev_name when we initially bound by mac.
I've also considered the approach below, which I think achieves what you are
suggesting:

if (!is_broadcast_ether_addr(nt->np.dev_mac)) {
	if(memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN))
		return;
} else if (strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ)) {
        return;
}

Let me know if you prefer this approach, it would allow resuming targets in case
even if their dev_name changes.

> --breno

