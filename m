Return-Path: <netdev+bounces-128184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E085978689
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14910B20B6D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E506768FD;
	Fri, 13 Sep 2024 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWVBxsS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF87BE68
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247950; cv=none; b=ryadOEFk2ab28ZFiP5EdGKm+7EHK/SFYUje7SPqztpH5lf7D6ZxIoBcTFah1OFqh8BGaCHv9dB5WchT/ugAhx10m/3gbAIObyG2h9we55/C1CfpoZ7LZr0fHDgNeRx4Ii3qJlYdLjaHnyNBtFj91obKheLKFzOzozUeRi/5k3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247950; c=relaxed/simple;
	bh=fqYUP7hmUkyophihl6JJk5+SbuxREpIU53pzb7vaaUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB6p9sI501O0a5T7Mu5EKc9ALgY1SYmspbHktwprYQF68T9nVtEJJ7PvOF4T/mxjll2ETOvzSw+HM5QFx825F4Ht4fNpDBlzD+sbgJjQkZ8QXO1GSiXm7DXJ6Qg6tsmQChBu6Wn28OBxbGyGRLZXZL9VV8AD4KV/ir8HREOH/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWVBxsS7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71798661a52so1863574b3a.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726247948; x=1726852748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xv56LMcI34GSmQ+bPFIMi4DVZUArLk3WkuPzEs8EXks=;
        b=HWVBxsS7pUsct9tA91KrW/X9H8ACMVoNe59SU0erWAMZJhUZa8VFTxzXrTwF/zyX3u
         rmFVytxN2TJ53r0K7NL8zXMBwdkI6uyx9Y6KjhT2EgJLRU4ndS6pMIAmAO+1qUaw/qjI
         n3qdN9TxikL3GxB5DgdmO/35UzWBspNthhSuUykRn7Pt82aX7WFfuOeVpgN8MYLuVS7T
         oQQXSAX3WjVGA62To7Br18EcHU5txcs3yRlhO/qfTF1lJpBrbuvH/h5eT/gq5l7bCAgP
         bcQ3gM3/dkcv8Cm5bWeauS6zj4ZKQUhQFojFc0s66z/R1XJ5tJpWjqAEOvWlNZQgriSC
         HKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726247948; x=1726852748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xv56LMcI34GSmQ+bPFIMi4DVZUArLk3WkuPzEs8EXks=;
        b=boTtGyiSBIdBd266cdhzo7hApQd56ILQI6QWwMdLEXyrrUE6jpPneAwzrBUK6yvU10
         /Uyq39IG+4KX+qi2Qu09YK7gH6yBx9RXVD4eZbmWakxCiQZ2wCiSr1SIFeBhsYGj5Awg
         iRo8avV0P4QXkk4yCKnVqVihMSuPqD0Ugi6haQz7UgH3DKdbEpLLV1QQ5/UPPLmUlAzL
         dPRwmK9AjsadfgRd5PyuounPLF7OXAw00TXeBdgcS1v2+X2eFUdm2LGiQ4uhdY9Iqayy
         OWxIqLJs/lopa1UrYoI7G4Ib51exexblM9z/UxGKyjyXvFf/xFl6rICNwCUN0tp5LD9u
         /Qwg==
X-Forwarded-Encrypted: i=1; AJvYcCUqEAm0uk+5smR918x1tJ5RncD6EyNAfy/WKSPHH266yi/HC83jisGfLo0qmN8hIP7CiCCD4Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxn6cAQEpdETDBYNACZrLH/K8RMD5Yp6SKQ51Itt8e1XxNjslW
	dIELTLUT0FFif/Bg5f8XeXVCVpYjjiNtqybWdacX8XYzmivh/wDsn13h
X-Google-Smtp-Source: AGHT+IEgF31NRsZi988WK5Y15QW058e6T+hax7LZrinL7aQOoYn9YtlXmaWdvqzhA0PrwkbodJB+kQ==
X-Received: by 2002:a05:6a00:6f18:b0:717:98e7:3d0 with SMTP id d2e1a72fcca58-71907ba053fmr25864217b3a.0.1726247947646;
        Fri, 13 Sep 2024 10:19:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909095124sm6351030b3a.103.2024.09.13.10.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:19:07 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:19:06 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 12/13] selftests: ncdevmem: Move ncdevmem under
 drivers/net
Message-ID: <ZuR0ClWpxEk2I179@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <20240912171251.937743-13-sdf@fomichev.me>
 <CAHS8izNTgbf-654fB84Wiz1kgA4z5HoicDm_MuGS_72561AnuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNTgbf-654fB84Wiz1kgA4z5HoicDm_MuGS_72561AnuA@mail.gmail.com>

On 09/13, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 10:13 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > This is where all the tests that depend on the HW functionality live in
> 
> Is this true? My impression is that selftests/net verifies core
> functionality and drivers/net verifies more lower level driver
> (specific?) functionality. There are tests in selftests/net that
> depend on HW functionality, I think like bpf_offload.py.
> 
> devmem tcp in my mind is primarily a core functionality and a lot of
> effort was put into making the driver bits of it as minimal as
> possible. Is there a need to move it or is this preference?

I'm wrong and it is actually drivers/net/hw, not drivers/net. But yes,
the driver/net/hw is the directory for the tests that depend on some
HW functionality (NIPA doesn't run the tests in this directory; but
the vendors eventually will). And until/if we get to loopback mode [1],
there is no way to run ncdevmem without special HW :-(

1: https://lore.kernel.org/netdev/20240913150913.1280238-5-sdf@fomichev.me/T/#m4fc52463857c19ad432db656c433cffdf74477a4

