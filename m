Return-Path: <netdev+bounces-175614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C327A66E10
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579871896837
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E41F09BF;
	Tue, 18 Mar 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGEaYkq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5711C6FF4;
	Tue, 18 Mar 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286179; cv=none; b=Oy5VkKvxSWF8UqSVL1LE2cvsdX/QK6S127K670od53LsYuCampClbEiOXzMlaJXB2ev15bK4Xc5W2vGsPy67GtmEGxEu3TsYpzPpJ0GuzTX2Br3nAMFR1sAMzDiq0Y+F0/TWh/v/+GjcATbjW8IKfFcMoUqAklILIDZidwWSy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286179; c=relaxed/simple;
	bh=MCjh2nLgKcoaLG5kdK+Wb5APkkLoIjS8PqH45EtRxnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3wFa8ZEcfhZ4ilt534G4p7LQRL4aSt40xXc6ukdS49aLqN7/D8SIFSuYiNTxcvAG+V5G3clL8DcyBJR/wSeVkczGAibQSimNpZDbzP55m94kvFs1OUCvZTt8iqP45HaFztaVz6qxiknpd1oVB4GCGhzpvmrZZtcZYkmWxR6Y3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGEaYkq4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso4924848a91.1;
        Tue, 18 Mar 2025 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742286177; x=1742890977; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66gdttRajZWJvR9DIeRu0efVzTG1k2XN5Qke5urMoJQ=;
        b=TGEaYkq4mDJIftlhahJDsWdcQ68ETkjwiIwI2kjwFbNmF2NPrBGAYC/2eVBceAIL43
         zqpoT/WsXqQbnwmIUOQYsjfBvV9AtQAKsX/Q0ahfniakqw8OiTcH2q7d6ogbA0nwbyT0
         845RYhzSX2AytHvMD9UB9jCvyfcyZMmUSQwRZkUFb1o6aYe/HHi22+bLRLFSH7k6RdLg
         D8qBy7KpjwFY+Pm7+erp0on7hXRwsoy/cTJ9MiWCnxavUcEHgstkjoNNrZUgOOuggYvd
         OJ9j1IemLOeA9sdMRV2lpuZI9ZGos/UVQ/QhEo/LRWXSOQiumbfHETfA5/1a0Y/0Ub73
         gNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742286177; x=1742890977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66gdttRajZWJvR9DIeRu0efVzTG1k2XN5Qke5urMoJQ=;
        b=WC3LQqKX/1Fn3w/EvaPIedS8OfNU8fj7Qz+pFiLHX9c8w2k37u6lezK16lcivkf3KU
         4RaV2X5SmLuLeb7ECpFg74LqVDQ7PZnhSisGH48kQqmj4xal5bbLU+5cNDqzcpc+3gGL
         mme52+2Kg0JzZ1ABvHSjWJFsZeEnNYJhpFr+Q0XW//h7kyzrWrfSQzD/WC0jD2XkMOeD
         NOlK/8HRSV/Q9lC2z6Gv6X/uuSGb/46G4c/NmO2w8SsfEdOc7eMxcC7xXcVtp/B+SOEJ
         qSZWtKYcSzIVHvz1XZLdsTPncBOb7Qj+Cdu3JUCXzYkj81nc9t1nvM5wowllpSrD2OtE
         TSWA==
X-Forwarded-Encrypted: i=1; AJvYcCUJoJbAxvfl5gXbeYN+OYSBU44uO0u0h1GA/u6QwlamEArIgDJZzeemdU6YOZLJY/7btk3WCz0J93J25AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZKIy4nOcwP0auo6Z9675IBh7LMmkyw3B7EAyIoTsCAqMeTpF
	lFvMZEvNWaLsQgi7DoucDLECQW1Msd5Rmb+fWMM6Sa3N2WaBA5ul
X-Gm-Gg: ASbGncuOIuRt4gYMTEvqYl9hiHscMEmoY2THUhFWR7hKQdB6rfFPlzIE87Hee2SZGFR
	nc1DgMzHCxrVLb8aCYEUbUxYBYocg4KZ/3qp8DgEkCME+uScPV8CWMoQGroY/RubwZdV2O2l10K
	Dr8MxeGyZvfB+/wVLirT1pYI02nrpx+NjLWSV8mGlHv1FGpOsL/NspAbyxAZ6ogphAuYrgO0A+8
	hHmNJNeFjC/uRA8etfGSnJNOcAy4LPl8VgehOUVAFphTAEsQcE/nDzqPB7xIea8mIqJiT1fRIdH
	9rRZkfGS69/qzyBa3FIClyJRYY7WWeinxuVjwl5T+Lbaet58BQ==
X-Google-Smtp-Source: AGHT+IEtHpGsBp0BgxcS9kaaMvlR/hXT7EDrkIPt4HkA2hT2e/dgaUHfpGO24IMLTWaArAhnmg77IQ==
X-Received: by 2002:a17:90b:388c:b0:2ff:69d4:6fe2 with SMTP id 98e67ed59e1d1-301a5b2b4bfmr2007594a91.16.1742286177145;
        Tue, 18 Mar 2025 01:22:57 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153b9949asm7526680a91.38.2025.03.18.01.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:22:56 -0700 (PDT)
Date: Tue, 18 Mar 2025 08:22:50 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: add ns target multicast address to slave
 device
Message-ID: <Z9ktWpfepFclm-b-@fedora>
References: <20241023123215.5875-1-liuhangbin@gmail.com>
 <213367.1730305265@vermin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <213367.1730305265@vermin>

On Wed, Oct 30, 2024 at 05:21:05PM +0100, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >Commit 4598380f9c54 ("bonding: fix ns validation on backup slaves")
> >tried to resolve the issue where backup slaves couldn't be brought up when
> >receiving IPv6 Neighbor Solicitation (NS) messages. However, this fix only
> >worked for drivers that receive all multicast messages, such as the veth
> >interface.
> >
> >For standard drivers, the NS multicast message is silently dropped because
> >the slave device is not a member of the NS target multicast group.
> >
> >To address this, we need to make the slave device join the NS target
> >multicast group, ensuring it can receive these IPv6 NS messages to validate
> >the slave’s status properly.
> >
> >There are three policies before joining the multicast group:
> >1. All settings must be under active-backup mode (alb and tlb do not support
> >   arp_validate), with backup slaves and slaves supporting multicast.
> >2. We can add or remove multicast groups when arp_validate changes.
> >3. Other operations, such as enslaving, releasing, or setting NS targets,
> >   need to be guarded by arp_validate.
> >
> >Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> >---
> >v2: only add/del mcast group on backup slaves when arp_validate is set (Jay Vosburgh)
> 
> 	Sorry for the delay in responding, I've been traveling.
> 
> 	For the above, I suspect I wasn't sufficiently clear in my
> commentary; what I meant wasn't just checking arp_validate being
> enabled, but that the implementation could be much less complex if it
> simply kept all of the multicast addresses added to the backup interface
> (in addition to the active interface) when arp_validate is enabled.
> 
> 	I suspect the set of multicast addresses involved is likely to
> be small in the usual case, so the question then is whether the
> presumably small amount of traffic that inadvertently passes the filter
> (and is then thrown away by the kernel RX logic) is worth the complexity
> added here.

Hi Jan,

Apologies for troubling you so many times with the same issue. Recently, we
discovered another corner case related to IPv6 NS target validation.

Previously, I mainly focused on backup validation when arp_validate is set
to 2, 3, or 6. However, if arp_validate is set to 0, bond_rcv_validate()
updates last_rx directly upon receiving any packet. The problem occurs when
the backup slave only receives IPv6 NS messages sent by the active slave,
these messages are dropped because the backup slave hasn't joined the NS
multicast group.

So, should we remove the limitation that restricts joining the NS multicast
group only when arp_validate is set?

By the way, another question unrelated to this topic. Does target_last_arp_rx
have any usage? I couldn't find any references to it being used anywhere.

Thanks
Hangbin

