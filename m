Return-Path: <netdev+bounces-85453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619789ACBD
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 21:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680521C20340
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 19:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4ED4CB45;
	Sat,  6 Apr 2024 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="bPB2vn+6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59532481DE
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712431332; cv=none; b=byekLmm1LQPLqACEtyso89x+Z1c348/lUSI3ijm4Smca1koKMEGXRnPC5kOnNr4yIACbb+IKiy+GvpJrZ3psl7+oKexwCjIZpYv7ysboMt33IAUsN+VnLaBsobSjOz7xLxL1mzq+HtZ1bdDpX5XnbE53oub49Gnob+1vQzMgD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712431332; c=relaxed/simple;
	bh=5A+6f7IkS+EMvp55GPed2MsJPEeMMXdOrMYYL9nD6ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpUFWuJwTgNXb/eSTxNrfFSyLY+ioa7iyX/ttQwo2fdPDh7YVR5SMZPuhAvyNiycu5upOyKc1WiBqGKfM9ig7t42LzfCiIRmsXKU7jRAWz1AVhqnBFxjPCGM+LaFnd59+r3ePRSjrPi3TRAjZWJfzK4AWAe1pO39XlRXwnFb7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=bPB2vn+6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-344047ac7e4so432961f8f.0
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1712431328; x=1713036128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=756hDfjo3U5mrTvSlV/zzY9CFAqjhj0SOon+Yv0jZK0=;
        b=bPB2vn+6u8RAhKXV4/d52Yqa5/YwJ8bBz5NyHQNMtaadsVGTrYP75pnoOmd++z5UB8
         E/+q2u4MkO8Tf4DQ3XZKk0aBcB+DGxOUkW8VydBjt5j7YCKb3dM0QzWbtOGwlcwuoDYP
         nNP863suwm96sDV96IPvmQgS0b322mPby+IWUvpgsxpvl01rcbPVQKp6M74Mpfuj1wUc
         Dg6gQUUn8R54XrRPGEJw4CzxC3I8txXr0j+A/kkrcSVdb6Q9qJcJFnoIzSf8MjfqpvDq
         kc6CfECcSYSs4uA2f7OrYaoy8xyiqPn6vXHwZa3+ozy+js77CW8iKdA9AvMtDPpTvdcz
         2SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712431328; x=1713036128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=756hDfjo3U5mrTvSlV/zzY9CFAqjhj0SOon+Yv0jZK0=;
        b=KD+/es2KOurKGfVn7RXItlYGOgfA+S1K1ZAsSoBkditt/fIrHGHRTe3X7SyaJVFoW4
         GQr8M+jstmBczDm4olIGeOZ3RnATjHrDHXON+LV+S1sbBIm2CcE0Jm5rH1a4OtikapI/
         1rGhvlb1fI5d9uxPbvM+hR/Ho4r30wFa7hJkwZKNLz9yvK4yZbASvqVipU33lHh9kLie
         Ag8ju7sFiPUSNTSWOm0FCaLl5xf4qiR9m9E9EeiJ94jgiiH//w96Kvcakwer+sZSpeea
         oCO/w/IKqgrtTv1H1+N6/u+pyULROAg562rQpODC6H111CH2bawIGyYvasXvBl6a3Su4
         VvWg==
X-Forwarded-Encrypted: i=1; AJvYcCUCvBUCVUQAbOuayhuMOmou71LqxqR2HHu7EeZNPY76oT004AtDkuQU1PneUk1nWNbXHaTGmDWTAHte4IhpwcjZQ3Rt5xuT
X-Gm-Message-State: AOJu0Yw7mcYC/AY+83wUQV9fSGilGUHPLqdYhbZqCosAgZX5Qfh289Tx
	axa47tgm4edW/H5wuf0eNdN/SnRmHBU6d1UIHGw2gebFGghedFp418zWxBzQDLo=
X-Google-Smtp-Source: AGHT+IF12v1vBalJveHvkoU64m+w7vrJbJW8RGGa8glJnsx8VZ6952vGw2fa1a0O3oXBcHLTR2asNQ==
X-Received: by 2002:adf:a496:0:b0:343:dd78:cede with SMTP id g22-20020adfa496000000b00343dd78cedemr5963369wrb.4.1712431328560;
        Sat, 06 Apr 2024 12:22:08 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id y13-20020a5d4acd000000b00343eac2acc4sm4429440wrs.111.2024.04.06.12.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 12:22:08 -0700 (PDT)
Date: Sat, 6 Apr 2024 20:22:06 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com,
	sd@queasysnail.net
Subject: Re: [PATCH v4 net] geneve: fix header validation in
 geneve[6]_xmit_skb
Message-ID: <ZhGg3kRHpARQAv9b@equinox>
References: <20240405103035.171380-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405103035.171380-1-edumazet@google.com>

On Fri, Apr 05, 2024 at 10:30:34AM +0000, Eric Dumazet wrote:
> syzbot is able to trigger an uninit-value in geneve_xmit() [1]
> 
> Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield())
> uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
> skb->protocol.
> 
> If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->protocol,
> pskb_inet_may_pull() does nothing at all.
> 
> If a vlan tag was provided by the caller (af_packet in the syzbot case),
> the network header might not point to the correct location, and skb
> linear part could be smaller than expected.
> 
> Add skb_vlan_inet_prepare() to perform a complete mac validation.
> 
> Use this in geneve for the moment, I suspect we need to adopt this
> more broadly.
> 
> v4 - Jakub reported v3 broke l2_tos_ttl_inherit.sh selftest
>    - Only call __vlan_get_protocol() for vlan types.
> Link: https://lore.kernel.org/netdev/20240404100035.3270a7d5@kernel.org/
> 
> v2,v3 - Addressed Sabrina comments on v1 and v2
> Link: https://lore.kernel.org/netdev/Zg1l9L2BNoZWZDZG@hog/
> 
> [1]
> 

Hi Eric,

Looks good.

Reviewed-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil

