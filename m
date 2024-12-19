Return-Path: <netdev+bounces-153382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F189F7CE3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943B7188965D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D6224B01;
	Thu, 19 Dec 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIGxQYH6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA2C2111
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617678; cv=none; b=mVXBSANgB42Ok++CRAsceTVtdueuY8mI23Lwy/nTVGOCpVy/KM1CwV9yAI2gt8z5WxBG052cK+0+1rigdDVL4qYJxkPkkmomIwgEEgWPT7dhN7J9FP4sDKlnv8X6AdoQmTcZ9Fv4o1Q1Y2G6fXVlvbShLsIW0Dm0MEMHRTYiur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617678; c=relaxed/simple;
	bh=lgKZF4zvvkbECCn+xYWgJZknMRaxis+YBOpiFbGkzas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQvRpPPVAopiXErMDO9g3OfocMtT5O3jBd0KO7CmRsBGSrdX62ds2xF2dxG8Wn3LhQzj/Zay3N9zp5t5chVxa2701joxoPjfGXIUAzgIKIHdWnSn+U4DjcSwXE3OK2ez9luoDVhgE/FJ1uzTm7Sxy9pCQLGqeuXwa6mu9JMLTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIGxQYH6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436381876e2so1281615e9.1
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734617675; x=1735222475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMNlGxlyeaZR/QB6rbcrF+GneyqZgiXIm5nJSFwUFaM=;
        b=XIGxQYH6+BeMShI4aptlY2trUx4JQjUXIEJgX4KYPD1XquUDuWQ5lauFwTuG6qWrnd
         sT7SpuzBRqMnhVFXN8/se0EilupqYP+BkhaqzlAKO67m49l6BVniwLEbA9h/xs26NqA9
         cElETIN0RNWGC9NcvigEPrld0SxHlr5diB/2nGq7r6tjKr2goZUMB1fWP39aFpRalMWN
         JRoCjFQbYYkHJrSeATwx4C1rKbsDq3Jwp1orM0vzxXxwNo3v/yXoxxLimyK3lAAudLvH
         Y2lwvP4Jn046SOQTAb/6sgMEhY0wsEXv1fyzniGl3erniZE8tLloJ4+tgnYBLxYlD16y
         CcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734617675; x=1735222475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMNlGxlyeaZR/QB6rbcrF+GneyqZgiXIm5nJSFwUFaM=;
        b=HtAz/uL7eFOjMsoO0SrX4/eXtlb8wRq8V7P0mT0EZ8qFLVJs1dz6SYtBx3nRVKQk8p
         c1SKq8e8DrfEv2r35ZXgLpvbm/tujn0L2UjLPJ1F/+lmNFy3gNFklfCkxoAECbg9nktJ
         7p6keV9BjXHNZHpx9YY9QkvbxYL+pYlV9K3oASASWyCeu7En1LC4buU4mM3j0xe15+XZ
         pjiuPGYo0VBY8gV9lftzXvjroQ3PmtI1eC+0S967O/r6wirpTCedgpnoPRBB2T+yo8FR
         II414zN6idtff/vqeTFGHSHd529WqttorigzBtdjCUCdGT8MwKRP1GWdHpeIHVjKUZ4V
         fIog==
X-Forwarded-Encrypted: i=1; AJvYcCXyjpNsF06aZzNBn7xq9QKAzZ77wOwz/az4ksQvPHzu34gkk3HFJ6Hadpsf8PAWy1y2QXh8SpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwQ4gKq7UJk7m2qMGJzgTZBG5k5oOIktH/Oo7VMQjBab6ctFL
	KVCF0f5kR2fHagH0zW8TLfVzmvhS5UiINZkOz/08laparBqtQuQP
X-Gm-Gg: ASbGncvFjIbQ9SIINrMzP73EeA2RIO4JiOcCqiCQLJ0O7LCd3SdwbW4BkwsPmYHVx0s
	tCXUYtSY6o2cUdNSLAvPFWyCT5tHifHl0KKEjQIiPBmB0YcvnnpXyxtLUDC26HTrJ14ThPdSID8
	8RZLhi/7p9ijuia7nTgPzX5kxIzQFCR4ErX50YfwcGR0aEX8dveGDHowrjCmLw+H8ekGleLRW5k
	UMRCUYHuruWPj88lnpwnKn8fTbz0Pc0WttQw+mEGXMh
X-Google-Smtp-Source: AGHT+IGn+XmDLhL0vfWCZ+Q4CvmCKPQsoH+39ycKQx2VUxy0NDripzk9eJ6hj5UgUyD5nQ3IeVgU6A==
X-Received: by 2002:a05:600c:3d0b:b0:434:f001:8680 with SMTP id 5b1f17b1804b1-43655341abemr26642785e9.2.1734617674849;
        Thu, 19 Dec 2024 06:14:34 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4365d116d8fsm26889885e9.17.2024.12.19.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:14:34 -0800 (PST)
Date: Thu, 19 Dec 2024 16:14:31 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 4/4] net: dsa: mv88e6xxx: Limit rsvd2cpu policy to
 user ports on 6393X
Message-ID: <20241219141431.qaosfbhlzk2hcbca@skbuf>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219140541.qmzzheu5ruhjjc63@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219140541.qmzzheu5ruhjjc63@skbuf>

On Thu, Dec 19, 2024 at 04:05:41PM +0200, Vladimir Oltean wrote:
> On Thu, Dec 19, 2024 at 01:30:43PM +0100, Tobias Waldekranz wrote:
> > For packets with a DA in the IEEE reserved L2 group range, originating
> > from a CPU, forward it as normal, rather than classifying it as
> > management.
> 
> Doesn't this break STP? Must be able to inject into ports with an STP
> state other than FORWARDING. I expect that you need a DSA_CMD_FROM_CPU
> tag for that, can't do it with DSA_CMD_FORWARD.

ah, I made a stupid mistake, I though locally generated STP goes through
__br_forward().

I put a WARN_ON_ONCE(skb->protocol == htons(ETH_P_802_2)); in DSA xmit
and convinced myself that this is not the case.

[   67.115425]  br_send_bpdu+0x130/0x2a0
[   67.119187]  br_send_config_bpdu+0x12c/0x170
[   67.123559]  br_transmit_config+0x114/0x180
[   67.127842]  br_config_bpdu_generation+0x6c/0x88
[   67.132562]  br_hello_timer_expired+0x44/0x98
[   67.137022]  call_timer_fn+0xc8/0x300

Please ignore this comment.

