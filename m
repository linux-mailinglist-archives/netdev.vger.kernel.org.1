Return-Path: <netdev+bounces-167416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B14A3A2CC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1103A5AA3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7B81C3054;
	Tue, 18 Feb 2025 16:27:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFFE23C8BE;
	Tue, 18 Feb 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896070; cv=none; b=W80arN7vm73tW/26XrOjqPLunMzZimZ3mZoD52/VPWD5kf5zjHAjm7dJ6x6vQuzHMIuSv5QFtCSF5Y2fK4hgTPCAJaInlgoFlS+OTGjwae4wfyUgA4fNKN09lBTXJGClNtb8hlob2744LwUN9jC5wF+7ziFXWQju2gA7F6CmpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896070; c=relaxed/simple;
	bh=Bzg0Km35DlXXVb5eeapsfDVuokQPyF37BnISLfv6KLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk+/1JTuE2ZcKjwqIcZ57pHmCYJ9YXKWIoedwowWVJTfRlmvF2/J34uYw7rLtzTjrhRZao/5NQQjmp5U2EJcZ8uksaO9vytrGD3DNDf4wF/gemAkEms+pHOcjVBJv+ck1MHl+w4OmzhMpcfyGwrFN9JBCSdOkufzRXx6VKuBESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso8687622a12.3;
        Tue, 18 Feb 2025 08:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739896067; x=1740500867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+r/L/xiENQ5SU08e0zx5Uf6bYAIhoz1X5yBYSp2LPg=;
        b=RiL8B4iW00v6JdgnncHM2cwpwAZJ6MGoR+IeCVjIIYF+V7/70c/U/k3j+Xpf5N2zzV
         w7j9okRPvObG6eagwMOVDmr6JNvXm/KJYiWVg0Br6DRlfzfkc8knOcNrVMxswBZz97j2
         /AGqajht3JyERNEHKIpp00Sp6MlTgzFL0fRzi3WAFz1HTPx/Fd+vhaWUTLR9zsu5Rre+
         gs+LDlvGN/vaAyEfTY6m7ZuZr+26poTSS1SIbsVfu4QKEGNKbuDf0XigOPOodFnZI0z/
         a0F01//QiPE+ZA9LcsllFJo7uv1p+1r3cA+XGHkM/dS2S7XJeTw2XC6DvHCMedRqwkIv
         kjrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeLabiEx0VNPjFdceeHz2r9DlbgnCmebODL0vyRfUXkI6gQbq4TihofJQk6Gm5ksFfKQv8knIn@vger.kernel.org, AJvYcCXiAA3YVKLqD8Ki4feGs/jUaL9n7910/L/wVRkTGN2a9egHHhxrb7LEjjbL62N/1K8GcrV2D9rm7gQZwYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNtmbZe5bQNAdmMCuQtRRqUAps6SjpKRWKAIvYAAOiLNhN2kX
	6b7OEDMzH4Ss+4aEYIyW7FBKj9D509PxLdMIWMcd6d4nYb5GOrXJ
X-Gm-Gg: ASbGnctSimhRTL1jh3lMok1oDTfqyNk4Uv4IJMZayiPyY4+EXB41jo6tb7H0+iNFwXu
	AInyUAwUTRBV6xRgQQaoQc/Q1MUw8N8dtUU4M1zeoKm+m1Fp7J+Qm8lTbhB+GNQVawkUeschjaP
	F7Rfxfy1/c0YyAkxq3Zf21VVO9xSJFybtG8EpQEQn+3AzOdKOv0Dym1pZyjQMGTel2CCTYYMzSU
	0WgbkV5klb2paiRzbJT4r6AXBjcFMtrP4i/Zb1HHi4SBU3W9RLQx784Bzir2PZUL767wxDn7BxL
	wiA1f3I=
X-Google-Smtp-Source: AGHT+IFebHlPCJuLoRzJYx1TVPW7FDYE4O1y5DJ+L6VMrGS3f2PQ/pJ4I5ssMe/xm7C3kbm5IAuUqw==
X-Received: by 2002:a17:907:9494:b0:ab7:ec84:10af with SMTP id a640c23a62f3a-abb70b1d813mr1510952866b.16.1739896067079;
        Tue, 18 Feb 2025 08:27:47 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322e6sm1085425566b.1.2025.02.18.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:27:46 -0800 (PST)
Date: Tue, 18 Feb 2025 08:27:44 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	kuniyu@amazon.co.jp, ushankar@purestorage.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net v4 2/2] arp: switch to dev_getbyhwaddr() in
 arp_req_set_public()
Message-ID: <20250218-garrulous-pristine-nautilus-fcc676@leitao>
References: <20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org>
 <20250213-arm_fix_selftest-v4-2-26714529a6cf@debian.org>
 <20250217163344.0b9c4a8f@kernel.org>
 <20250218-debonair-smoky-sparrow-97e07f@leitao>
 <20250218062920.40aaaa6a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218062920.40aaaa6a@kernel.org>

Hello Jakub,

On Tue, Feb 18, 2025 at 06:29:20AM -0800, Jakub Kicinski wrote:
> On Tue, 18 Feb 2025 01:36:30 -0800 Breno Leitao wrote:
> > On Mon, Feb 17, 2025 at 04:33:44PM -0800, Jakub Kicinski wrote:
> > > On Thu, 13 Feb 2025 04:42:38 -0800 Breno Leitao wrote:  
> > > > The arp_req_set_public() function is called with the rtnl lock held,
> > > > which provides enough synchronization protection. This makes the RCU
> > > > variant of dev_getbyhwaddr() unnecessary. Switch to using the simpler
> > > > dev_getbyhwaddr() function since we already have the required rtnl
> > > > locking.
> > > > 
> > > > This change helps maintain consistency in the networking code by using
> > > > the appropriate helper function for the existing locking context.  
> > > 
> > > I think you should make it clearer whether this fixes a splat with
> > > PROVE_RCU_LIST=y  
> > 
> > This one doesn't fix the splat in fact, since rtnl lock was held, and it
> > is moving from dev_getbyhwaddr_rcu() to dev_getbyhwaddr(), since rtnl
> > lock was held.
> 
> Are you sure? I don't see the RCU lock being taken on the path that
> ends up here. arp_ioctl() -> arp_req_set() -> arp_req_set_public()

Ack, this will fix the PROVE_RCU_LIST issue.

