Return-Path: <netdev+bounces-119618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA39565AB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414BC1F22C86
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402EF14AD0D;
	Mon, 19 Aug 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eows5kib"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12A13CFB6
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056477; cv=none; b=hWdzzE0J0t8d+0jEpKBttjaf7I4hR3s7laUFCQ8Id2FCq5WJcyR4Qtm4sqvUv3ZkMk/HCXEx28/vKw6LBuLAs5/G0wAG2eP2Un3i0ZFx9x6n7UUMnoCZ/WSW+3Tm3LDtHYq0NDRTyQEFLvCH/KcHoFTUfimEArV5Tv7X8TNZ4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056477; c=relaxed/simple;
	bh=Ls+AbKhRsRCEfTlrmW9FSCAob1D4mpMbNbEDLzux9yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0cqutv1b8nim8OEU7/tbR7Ft9qGiBtjyi6tciLmRk6tA/41tP11MlYgwX2YQrTMKzFifvUYrjT3yethhDyucyJc1yOPD/l/DhKuLIL7PuRDmWOI8oqFgZCqlUHCC6i+0pFWIx1xb2tQP4apK9dh0BXbjDsQI+UbHsYnxep3/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eows5kib; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201cd78c6a3so30986195ad.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724056475; x=1724661275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezHnfEM81CaiZM7VaA6oTA7gUqd+CdWwP/nlWh5ivIA=;
        b=Eows5kibhYpdfyX695EPWxYp4gI1l0SCtIXAoCPpiag9rz876qps3HkvnQI6sPSO1a
         1oeqiMn+YkOtK0vqX2Nlm6X449LVBP3M06QghhoDrqBDM/V3vHqQg0BXASkGnDM+HdDw
         dWJLYonYY+ZXH7OsefwqFIjmLtAGgPyoenxEIlX67yjZRuE+d2xz45ixfchsImAz+6Aj
         cAElYwKG1BfZw8OMWaRn0RnmoCA1t/3Tm6cdi/8wqjEVbtRVYJUy//nHVS6d6GTinIJ/
         eY2EvE9ecHODvpqmv3rBWUfci45UQ38iM20Q7XeohX/iA/KD4a3lNxJc7HBDraqUkhJU
         rNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724056475; x=1724661275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezHnfEM81CaiZM7VaA6oTA7gUqd+CdWwP/nlWh5ivIA=;
        b=Me0ruHabSyne5kE5QVpjATjxXptFfE9kT+Ga0e4VrxR5SeTJ1rl7vGSu3SbTiTsXTl
         yvpNRV5zphv2qlCo7tOeRJbGEurpLT9ZU6gcBjq20LNAwXFR3AJyjdTs7PP0/YE+818o
         ZbdVxGqQniuZzR6XDLPgFx7hA2q3R3x/ZZ5C72EuDwlNJoracJaH7BEY/UECjS+rXM1n
         6sQp+QK6ACinej32o/rgFG8kt9INz086AixD9d4H8fp3w/Hqb62l6ir040x62n9xuGNN
         JhJxjeHKLbxbooqeEQubYGzF86V9cRTOsWKPkqRUlTKycqCO8rsap+doEJae9a+D6N/v
         Vo4A==
X-Gm-Message-State: AOJu0YyRMMyv4R+i0FQH+mMkjqVG+Iebt+PCWBZcGn03MY3raY6a9gg5
	EDhat1Rs3xQwvLquDkA0khwd4dVZ1o34mkqOKJYu+F5hO8Hm/L8ZjBjedn9qnFTqgg==
X-Google-Smtp-Source: AGHT+IHQDgaDEck2axN1Qs4hcpcHQM+ih02rs0Ip9zCtjGwXH4Sy0mWcLBN+J6jBU0GSAHpnobks9w==
X-Received: by 2002:a17:903:247:b0:1fd:9420:1073 with SMTP id d9443c01a7336-20203f32995mr124206335ad.43.1724056474873;
        Mon, 19 Aug 2024 01:34:34 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031edbesm58897035ad.110.2024.08.19.01.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:34:34 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:34:29 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jarod@redhat.com
Subject: Re: [PATCH net 3/4] bonding: fix xfrm real_dev null pointer
 dereference
Message-ID: <ZsMDlTY5RS4GwbCr@Laptop-X1>
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-4-razor@blackwall.org>
 <ZsK0AJXxNtJqr9AR@Laptop-X1>
 <c6c965c3-dc69-4be9-8817-2146992f9359@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6c965c3-dc69-4be9-8817-2146992f9359@blackwall.org>

On Mon, Aug 19, 2024 at 10:34:16AM +0300, Nikolay Aleksandrov wrote:
> On 19/08/2024 05:54, Hangbin Liu wrote:
> > On Fri, Aug 16, 2024 at 02:48:12PM +0300, Nikolay Aleksandrov wrote:
> >> We shouldn't set real_dev to NULL because packets can be in transit and
> >> xfrm might call xdo_dev_offload_ok() in parallel. All callbacks assume
> >> real_dev is set.
> >>
> >>  Example trace:
> >>  kernel: BUG: unable to handle page fault for address: 0000000000001030
> >>  kernel: bond0: (slave eni0np1): making interface the new active one
> >>  kernel: #PF: supervisor write access in kernel mode
> >>  kernel: #PF: error_code(0x0002) - not-present page
> >>  kernel: PGD 0 P4D 0
> >>  kernel: Oops: 0002 [#1] PREEMPT SMP
> >>  kernel: CPU: 4 PID: 2237 Comm: ping Not tainted 6.7.7+ #12
> >>  kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
> >>  kernel: RIP: 0010:nsim_ipsec_offload_ok+0xc/0x20 [netdevsim]
> >>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
> > 
> > I saw the errors are during bond_ipsec_add_sa_all, which also
> > set ipsec->xs->xso.real_dev = NULL. Should we fix it there?
> > 
> > Thanks
> > Hangbin
> 
> Correct, I saw it too but I didn't remove it on purpose. I know it can lead to a
> similar error, but the fix is more complicated. I don't believe it's correct to
> set real_dev if the SA add failed, so we need to think about a different way
> to sync it. To be fair in real life it would be more difficult to hit it because
> the device must be in a state where the SA add fails, although it supports
> xfrm offload. The problem is that real_dev must be set before attempting the SA
> add in the first place.

Got it, so this time we only fix the delete path.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

