Return-Path: <netdev+bounces-237343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C762FC492B9
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98EBF188EA98
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7B32DF136;
	Mon, 10 Nov 2025 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0MMjHYL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDE62D7DC2
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804939; cv=none; b=o34CPlbEVcwEFjuUojfBvsGh3hT6PY3bIIb4w3kk2mPkszZtFvFtqdBXShS+aZOIlH6ldoAGVjyVSy9sGkC25NsevNuWcKJQFKTV006VSHEObgzhqVqA14O3G9KfD4J0lGjyuTzVcXuPr9tOVD5DVYvC8RulpDWADt0qmPe6uic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804939; c=relaxed/simple;
	bh=WEbUCqKPpqNwVY1zEPDo64sJfZj+DKjf0qTpZ5wdgfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtL1oz66OHshskL8HQfHQE9Eq7IQB/PMY22itshk7erM+A+8Y93uWg0ggASyBFlcnygoXu0f4rfrnQACsj6vJBMxx8s7fYkDG9RKoZ///1pfZRNKuw2S4O+4dLooyjCDoWLtTlsMC+Wes5ji6WRUB1IpBTICfHEjT+OiQI2bBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0MMjHYL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29555b384acso32289895ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 12:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762804938; x=1763409738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NLYN6jTBEGwmHxj0J2TeyxS9PbPiD4fPo/j2nnYR3E=;
        b=H0MMjHYLFhbaiGud6XqzQNAlgdWZuWDFA1MdfQjuaI4XTFwkbEXIkeuK9swa3VbLgl
         P2NluPnBZSgQ7gI3Ir6904KbVN2DSCr+FsH+ftX0M9/kYAuRpmmeCWUusdhK1SEiNjGC
         0H+Qs6+xYj/xDN5KGTx3nZ8pnLtc+lPOYS22nnkz5if4dILv/6ZCp6eXv1OLiZ462ur1
         j8Wtjz3XJlSk6QI2+QnnivCKcrbL4m/agB9f+aQWDLB+B/IrXiSQn6ni5a6BcX2kWpNk
         IYk8uoSofJc91BfW8koVHNTqCSvoUZEh8FMDGu7BRsY5/bH7tbFXW/JYFWfH4SG47oXU
         FvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762804938; x=1763409738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NLYN6jTBEGwmHxj0J2TeyxS9PbPiD4fPo/j2nnYR3E=;
        b=pa8QhchxriVCaMrBsdb6CDf9Hf0wuNxFwSQ+3WnDAm5CI8+VtISPNeWgrUvz81JSzr
         fQ+DXM4Y0JWqVviSHwZjKp+AZ+wzAgQEd9SlWfKhwevnti5Pyyx5sB7m3A1tnJSLc2Ir
         z1IeDhqvHPag8H3IbXfRGS8w7Ce6pCQ2MKe2JIY98e221tcDDxlEnKIvWvn5ZMLO2sf5
         k7A8inTE8z74eJu3qLECaIPiPSJAVilW8bRyu0/M4DG+Dyo5K6+8cFdv919bQf5e+GJv
         sbikZTLbjPQC6wKbEFduPpg8M/GNe/6G5JpwmKEBQyOSxMWAtrIHihrfza3cwKrju4NZ
         lZeg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ah6S9zdhyPjCX0iXOnz9QdjbcN8O3GTTEIxIMcfUt6a9gf9Oh6vLT1kFugwy5si3qnphc+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygvDQKl1KNHcymOvf8KMKKMQFTn/55U/FlGS0gRw3C29DfhjW6
	nBbkICyNGtDlCUcXxb5hK7eMb1wINaXFghHO3QMXGCm+Bicn3K2LVCkc
X-Gm-Gg: ASbGncsOQhCVdr+XkuDrlF5btXPeqY7DTnadYKb0CFXDefrKY/aZzD80ATmPCW2g5nc
	D4h8jeUFGuN3gWMI7025yGGjabsrQ9KDvQfpG9K3yPvuUlaxRm0W28zeRDMd+6t7xprj7do+Duq
	LZVJI6b9tQSoGL04U03rXdMmtI+9hVX13X9To3Ljh+UOVvAWR0PTDuS+HyASkc25Z2VUBv/9dse
	a0UseGi5GI/615pJv2+Fz09/oP0PUT4baJqUzWBB1qpbrReyVG81N8XZWSxtaTHFtE6XE1eZS9O
	H1endQx9MHq1UhLQO+Cam/uJcERI5LbDa7RqPm1Tv4tdaN0y0uZWsqE7SKAgWDO0CK/8PMkWo/4
	TbH71bMYmbJeovlMxsjNH7qhD9zppUAgpJwF/RuZ01gF1MOyGy4LJZbZSXenhUnalYsw5J0GfOP
	q86WUvBw==
X-Google-Smtp-Source: AGHT+IEx5DrKUEdpyrpancufPKZNJjbcQnhJSxpDOTbqT+ORySyjiLg4DxwBtCBYpfTv90p5Dx8iQQ==
X-Received: by 2002:a17:903:1a27:b0:297:ec1a:9db8 with SMTP id d9443c01a7336-297ec1a9e0dmr131667795ad.49.1762804937650;
        Mon, 10 Nov 2025 12:02:17 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:9974:abff:f64:1199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a699c011sm18596997a91.14.2025.11.10.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:02:17 -0800 (PST)
Date: Mon, 10 Nov 2025 12:02:15 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, david.hunter.linux@gmail.com,
	horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	khalid@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 net 0/2] net: sched: initialize struct tc_ife to fix
 kernel-infoleak
Message-ID: <aRJExzyyqdt1V6cP@pop-os.localdomain>
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109091336.9277-1-vnranganath.20@gmail.com>

On Sun, Nov 09, 2025 at 02:43:34PM +0530, Ranganath V N wrote:
> This series addresses the uninitialization of the struct which has
> 2 bytes of padding. And copying this uninitialized data to userspace
> can leak info from kernel memory.
> 
> This series ensures all members and padding are cleared prior to
> begin copied.
> 
> This change silences the KMSAN report and prevents potential information
> leaks from the kernel memory.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Looks good to me too.

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

