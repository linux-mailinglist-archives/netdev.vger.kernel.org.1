Return-Path: <netdev+bounces-133763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A857996FC1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9265A1C220A5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A738D1E133D;
	Wed,  9 Oct 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpMQVrY2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A70419EED7;
	Wed,  9 Oct 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487336; cv=none; b=p0bv7kD6rxiapCF6J2ffDQCNIYFtU1cTb69bVcLvg8rkVWnOpE1gVgdhOIzB0kd9tJJwOCTPhAaBEH96qAtuDu9oOTsFZJpoDsjIoTPB9jBVJiYGEXtDkggMQXO2qbem+hKV36t6LyjEVFlIEOfqtjO9MLMAAFL7kiJYrToNxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487336; c=relaxed/simple;
	bh=rfG3NG0F4WKGAPp0s+kcQ2M05K3xc7lDAlk3oHDgJHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okLi1cn4zE1ZgPGAJgE57joq0oxVVSsETY+i0DftekzvgNMOyHSDNPazuat5EF3IqYNP6pV1LgSJ++uXSiSB6TOF0F4tX21e0jureKJMUn1gJiBzMCRqKtqC2yp3uWiesjUZBkBak+582+NYBJ13WHTS+svwzeY/clbboP1sP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpMQVrY2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea03ecf191so3062641a12.0;
        Wed, 09 Oct 2024 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728487334; x=1729092134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOo7l585oFLWi0h48Dv3F6DZGgpv66GVVbpXLuIWYn4=;
        b=dpMQVrY2eVyy0kMDtIyy7aJ8NnR4Hfa8ySv6fbukv8woPhlmVnRtX2A+M/L/eIfeOD
         6KSiUJOGXhmBWVGjlHwe7jp8O1xIx3XyBt2RN42uwPayI0udvFegW+ofd52oEQI9LqaO
         lWPrzSonf4BE4N0j/JNevOA/TaaoXJMaErrqan2F/vupUsU1Mi40ceYBMNc1Sk0lbtq8
         O8tDCH7/eXrBcancAxE3y/vFh41O9DF1IJO4VayUwnz1s28/Ems2XIKRxvAyjKJnBmSC
         KYqnsZ2A9ViwalXIUm40TYMsDAGzJbuBgnjCj38/AOhR1pFemDya87oJof4enW3nahgs
         kaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728487334; x=1729092134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOo7l585oFLWi0h48Dv3F6DZGgpv66GVVbpXLuIWYn4=;
        b=oWWq1tkuSEEeDlYnyXML7b4rDmOQWr+s+W5ciWflxWOIo+CGqwtghIy8qgy7SuM5Uq
         u7+GC3T33crni9ADcnc3thH0hmxAh26Gnmvk+llD++7/WGJ0APlgH95+oBQBN6lp/NQL
         RWqkFLlQuH+HFvIMkbZpO3ns47/VFoo75E24+iZN72+dvRPzu+b3JaUNANqgDyiQMIeh
         891skbMgj2/zCBC7MG+EOKzD9u2ZtQas+tZtre1ErDiX3gPn1fo58ykeMNBqmOI97/Ws
         eJ9qhKG7usKk0eiR9El1A1IF1SC+Tbb4vnY7LrKEygAxyFBUGVUXrdj0gC2eyRSfCzTy
         TJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuFmWqtKKpUp+DIgESTJXiuE/CYDiAWmo1tCuC9rVowDry4Fv+B/AG2gEmALvDbEfX6HSUq8t3@vger.kernel.org, AJvYcCVVOFIGvGq0WxbB1MnIlIhY16x7j4X4uluTt9eWW0M4EYCROnPdQ6OmumurBlxCeK9MwRoLsxIEzU2dq0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3c9f85sGTeRG9HghP6YP8k/pkVo1t/4ueIck+j80clxZrNNqD
	NrtJeY14X7SLG5dbcj7/F2KZ5t24nNdjppK9IKbLZANNvPovgME=
X-Google-Smtp-Source: AGHT+IERHI3+TFSOApS7wrTlzvJJnpbUQPLq1l4NM+ohbHOPKk8gUIRbIhiWO2lycgR0CBUYtCxuqg==
X-Received: by 2002:a17:90a:ac0b:b0:2e0:d1fa:fdd7 with SMTP id 98e67ed59e1d1-2e2a2528a00mr2927991a91.27.1728487334320;
        Wed, 09 Oct 2024 08:22:14 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55fe0cdsm1803203a91.23.2024.10.09.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:22:13 -0700 (PDT)
Date: Wed, 9 Oct 2024 08:22:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] netdevsim: print human readable IP address
Message-ID: <ZwafpMwkVtcGjk0v@mini-arch>
References: <20241008122134.4343-1-liuhangbin@gmail.com>
 <20241008122134.4343-2-liuhangbin@gmail.com>
 <20241009122122.GO99782@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009122122.GO99782@kernel.org>

On 10/09, Simon Horman wrote:
> On Tue, Oct 08, 2024 at 12:21:33PM +0000, Hangbin Liu wrote:
> > Currently, IPSec addresses are printed in hexadecimal format, which is
> > not user-friendly. e.g.
> > 
> >   # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
> >   SA count=2 tx=20
> >   sa[0] rx ipaddr=0x00000000 00000000 00000000 0100a8c0
> >   sa[0]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
> >   sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
> >   sa[1] tx ipaddr=0x00000000 00000000 00000000 00000000
> >   sa[1]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
> >   sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
> > 
> > This patch updates the code to print the IPSec address in a human-readable
> > format for easier debug. e.g.
> > 
> >  # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
> >  SA count=4 tx=40
> >  sa[0] tx ipaddr=0.0.0.0
> >  sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
> >  sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
> >  sa[1] rx ipaddr=192.168.0.1
> >  sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
> >  sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
> >  sa[2] tx ipaddr=::
> >  sa[2]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
> >  sa[2]    key=0x3167608a ca4f1397 43565909 941fa627
> >  sa[3] rx ipaddr=2000::1
> >  sa[3]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
> >  sa[3]    key=0x3167608a ca4f1397 43565909 941fa627
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

Can you also update tools/testing/selftests/net/rtnetlink.sh
accordingly? There is a part that diffs this file and it now fails due
to new format.

---
pw-bot: cr

