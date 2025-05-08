Return-Path: <netdev+bounces-188998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B66AAFCC6
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75831BA2D1A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92CB22A80A;
	Thu,  8 May 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4iJ9ttD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5212CA9
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714124; cv=none; b=X31HRGic/t7KaVP92WqIYzCKt8NNJMok1gL5lj5IAHaBF4tNAVgUzCBlVqsJrGmHL4xZHDGK45FjEUMQDZPPxhGkKgMUrtkepQ1xwrzTTLP/0xlbjqCAWH06XbI+C6rlewiE8t2pZ8jk6ZR1coAtGsKQ9uT1VZRPaCqdIc3TG7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714124; c=relaxed/simple;
	bh=AH4zDLqVdTAorFqWn8YSUKgyLkzK+3dDSYlJyedldUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUEcNPUJvyDGeuzE+H0Z6Lkz6T4NOpWk6yKlyiZ9Om5z7t2b75Fb6iyHI+gnzthbiTZ3x1tQMZRYFh6K8T5SQhkYb1ndsoE/QF+C2PeWAnGBX9fzGHJijmkmOiu/FsVp4E5oJmnKMyJ356urBQOsCsbZU/ELH6VYszpGn1MFQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4iJ9ttD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fb55d8671dso154913a12.3
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746714121; x=1747318921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNWI+Nclv93Aye+gTppmcR/l9SWzqbEWpt2nqbIN0p0=;
        b=i4iJ9ttDAGZStkKnMXuvaODoeprfvxz/MWiNzy0x5UWhVQiz2958wq8LYj+yT0eXfb
         ZunUQY9G4nXVo4fQzXrQF7Xs47Dv8EOPwezprV6PT4ClelV7doFMS5zgA9x+jw9lYzzI
         DC9Og+UNWXL5u2+ZnJV60O+ugqrENGG1TiiZVmkWi1ynQ/Zi2iOkfNxiDukFgzk+7o/4
         0npELHG3L1M/eJO2/0H5yIUoQsTI90HXhUcQuwzBGZShrQEfxZw8nhh0fDfUID36/ucn
         OmfsiA1qsofD3dc5QhXc47SxeCc6sErtCIr7kw9TSFA52ovRjhYvuNeU9o1AYHTgtJiE
         cQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714121; x=1747318921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNWI+Nclv93Aye+gTppmcR/l9SWzqbEWpt2nqbIN0p0=;
        b=hGNrB0oKYTvZz8RjHCrqNwyZabfOvx4mbW7HH7HEv/wx25scv06suG5v7GId2CPKOK
         rJWB5dqG5//P58XmDilZW95NgRsGRz0s8BKecuQSjGJk9+p9HPD2IvSdnv6yksdm72QV
         aw+TDkEM2rmZiSCvSAVk7uCDGTdEFvsLIVx+MVUssuJMBusyCgpsUXLi3liAeKYqpEXS
         7Y7lq+n6J+xoywZdg+3e3hVVBHX0n7baaG/ZwlNG6SQapXOUlNau1F+tE4EFoVZw9bDs
         cRT0N/EvjOFIR+ZrTUzYWte5sDS4aqteX8gcNW9bUycjuGj9hRSyzfZsdGsZolHK1fvE
         146g==
X-Forwarded-Encrypted: i=1; AJvYcCUpe78mLYZK/jmn1/9lqV4s4qCmoOD4kyI005vQyIYjghQyj7deM8/90loFKFdk5iiNTcQz22A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+rA8ov6Y2WBiPCTq+1+TtPRKOFGBZKVY6FUHpql7Qyk1FArki
	lU8xs6bmcrmEd/Pumg1E1nLUQKpcTL+Vq77aORtTzctCCkQT0Xy1
X-Gm-Gg: ASbGncsWsn7OHOiCI4lh1BSg5JEGuLc+G/+ulCYz+m7w/NykVtxba1GImNZhHD1c4gu
	vhqAdDZVM+2yB9bNZz/A4ZTaHa0ixDeL+eaF9fMSZLmUqhPW+V88VO+ZMFn1F58ig0aLBjnBnud
	D5sJHfFwKl1wj1lHpyaJYRKTSAsKpTW0wUQ5vMf5W2xeou40tIO5bHKNSBCiycipGW1v/YSKQO2
	JhUvFgTQFweK2cIl0d5SsbOXq4eFl2nxTXKQbuCl8SPt9D8QGUdl5Hjhsm4EbLPun8HUe+oK9MW
	MTo7coqex/LrBaNV9gxQ/cFQTndi
X-Google-Smtp-Source: AGHT+IFfZ2LnoFTAbLbT59dqIXofCuoLaOmROgL2oU2ZsTZgEECOqFTuOXZEyDYUdQu+N8uFOfThsg==
X-Received: by 2002:a05:6402:524b:b0:5f3:7f49:a396 with SMTP id 4fb4d7f45d1cf-5fbe9f5ad89mr2172801a12.7.1746714120949;
        Thu, 08 May 2025 07:22:00 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b8fe2fsm11502312a12.57.2025.05.08.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:22:00 -0700 (PDT)
Date: Thu, 8 May 2025 17:21:57 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, irusskikh@marvell.com,
	andrew+netdev@lunn.ch, bharat@chelsio.com, ayush.sawal@chelsio.com,
	UNGLinuxDriver@microchip.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, sgoutham@marvell.com, willemb@google.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v1 4/4] net: lan966x: generate software
 timestamp just before the doorbell
Message-ID: <20250508142157.sk7u37baqsl7yb64@skbuf>
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
 <20250508033328.12507-5-kerneljasonxing@gmail.com>
 <20250508070700.m3bufh2q4v4llbfx@DEN-DL-M31836.microchip.com>
 <CAL+tcoCuvxfQUbzjSfk+7vPWLEqQgVK8muqkOQe+N6jQQwXfUw@mail.gmail.com>
 <20250508094156.kbegdd5vianotsrr@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508094156.kbegdd5vianotsrr@DEN-DL-M31836.microchip.com>

Horatiu,

On Thu, May 08, 2025 at 11:41:56AM +0200, Horatiu Vultur wrote:
> > > > -       skb_tx_timestamp(skb);
> > >
> > > Changing this will break the PHY timestamping because the frame gets
> > > modified in the next line, meaning that the classify function will
> > > always return PTP_CLASS_NONE.
> > 
> > Sorry that I'm not that familiar with the details. I will remove it
> > from this series, but still trying to figure out what cases could be.
> > 
> > Do you mean it can break when bpf prog is loaded because
> > 'skb_push(skb, IFH_LEN_BYTES);' expands the skb->data area?
> 
> Well, the bpf program will check if it is a PTP frame that needs to be
> timestamp when it runs ptp_classify_raw, and as we push some data in
> front of the frame, the bpf will run from that point meaning that it
> would failed to detect the PTP frames.
> 
> > May I ask
> > how the modified data of skb breaks the PHY timestamping feature?
> 
> If it fails to detect that it is a PTP frame, then the frame will not be
> passed to the PHY using the callback txtstamp. So the PHY will timestamp the
> frame but it doesn't have the frame to attach the timestamp.

While I was further discussing this in private with Jason, a thought
popped up in my head.

Shouldn't skb_tx_timestamp(skb); be done _before_ this section?

	/* skb processing */
	needed_headroom = max_t(int, IFH_LEN_BYTES - skb_headroom(skb), 0);
	needed_tailroom = max_t(int, ETH_FCS_LEN - skb_tailroom(skb), 0);
	if (needed_headroom || needed_tailroom || skb_header_cloned(skb)) {
		err = pskb_expand_head(skb, needed_headroom, needed_tailroom,
				       GFP_ATOMIC);
		if (unlikely(err)) {
			dev->stats.tx_dropped++;
			err = NETDEV_TX_OK;
			goto release;
		}
	}

The idea is that skb_tx_timestamp() calls skb_clone_tx_timestamp(), and
that should require skb_unshare() before you make any further
modification like insert an IFH here, so that the IFH is not visible to
clones (and thus to user space, on the socket error queue).

I think pskb_expand_head() serves the role of skb_unshare(), because I
see skb_header_cloned() is one of the conditions on which it is called.

But the problem is that skb_header_cloned() may have been false, then
skb_tx_timestamp() makes skb_header_cloned() true, but pskb_expand_head()
has already run. So the IFH is shared with the clone made for TX
timestamping purposes, I guess.

Am I completely off?

Also, I believe you can set dev->needed_headroom = IFH_LEN_BYTES,
dev->needed_tailroom = ETH_FCS_LEN, and then just call
skb_ensure_writable_head_tail().

