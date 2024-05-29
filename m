Return-Path: <netdev+bounces-99039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B778D381F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393F2B23DCB
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F518E28;
	Wed, 29 May 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVdaWgyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715618C3B;
	Wed, 29 May 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990238; cv=none; b=mkdkctLUi+tx7SA/Lt+LT4q86CXs26m/MTHqkcyKX0jpNQO6THqZnNzp7vUP0TBqdyoY1dT75fHYs8aMG0l7LmoqwWB8Owbj+Y9N5JdxPJ5C3b460+xLCW7jPSbsV8sXdHM4UD/tGY+1TaBkLLkmtQtXHlGp6YgijTkXsOp+72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990238; c=relaxed/simple;
	bh=y50eHDPiA4eeToZUPT7UI1q4a00OqcEP+3LIS8fbqjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXqXYmovVlWzRlTMATaCc1JwEC99CC2PhoOb0OG76BM0Fcg9kUX15d5tgmKPgZV3nRSgg/nfgCzbLUVjcdXxJvHpwtVA1dlsZrmQ8JxrtAsm3DZFDWpcPqYcs6VhIaleTZuGHL5s9KplwOlX0g6DezMwSWVIGVZXoQ2bF8PrB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVdaWgyi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5238b5c07efso2396961e87.3;
        Wed, 29 May 2024 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716990235; x=1717595035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2bvKZ0Q+dcX07pGDQ1nprRulDtyjlxAHp+d8hq2FaD4=;
        b=TVdaWgyidYXeSahSTdYKfodnXJrrw9gZDwVdX3gd2OsiD8d7vBnr4Cs8Od9260PzvV
         SsHhLDo1M4Mn+GLx6/Shxm8ljykgMAF2ZAB18GDkctTWAVPIGwoWVhqZOUTLedi1WGVy
         pgizwG77m31WTnQ8ix0bet0PWLJFkM7exNToMLGFsmriOsHVYgGGbh6ejRip8cqwkMxa
         VINYsfHWWn5vKDZA25T6+nSAq3oscGLgI8/c09nEVqakoYhKsneNTGys9vi7Evbxua9d
         i26cik5mmDsK2Cp+g9OwyDnzjoKMoJQhyrbStrPpnkC+RkMUVZfSGlcWcdOJpFXUR6Id
         p8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716990235; x=1717595035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bvKZ0Q+dcX07pGDQ1nprRulDtyjlxAHp+d8hq2FaD4=;
        b=Alju82Vz7kCAoOvjsBXhiJYSQeLEGFLfAs0SA121XexqNhlnOQ6ldvJm3200AFnZqw
         AI6o7PPELFY/pr/5wkDQjzhhFRXTP+tQ5WimHCt6KHjOWBu3yI87KBQR8UPUsGLi6GwN
         F6B3UtVK8MboKvvnDhybYoSjeP/1EAUIPT6AZUpORR+/7/aN2lUNTcM7HxXbiFPcZbop
         M3R9MtaX+9q530ZPCj4LB6+xj6UGRn+x3dIKIwhuUmq/sO88n7TOeU3w/yVGO6e3u+Yx
         82waYigogzC7bTDefN+lVH20tPnHEFbrkQS/aS+snb92a+qV453dx3aHQ2PXBERLuaH/
         /KCg==
X-Forwarded-Encrypted: i=1; AJvYcCXY5GtpJxcGT4G8Hlpb7Gw72JaufIRfbSIrPjPK4Zbx9XCxDPThSTQNMRPbAcLbthwXK+EXIYB/TJ0OUOTdg6tJRNjmFuVnoanIKUFJWnOGEta+zRNkouihcI+AwuSldu4AjEtr
X-Gm-Message-State: AOJu0YybfBVP+9KKiGSa7jLD5VLmtN5QMeHa5I6j8LI/URqtj2+wfxZ9
	u0mdgtUfM/a3KkPtXzHaozQ4esaLn/Vms5TTJcL401uuXD+OTIoB
X-Google-Smtp-Source: AGHT+IGbv2Vs3UjE2x/aN+to4TibYxCXBjvUtrV4/fvbBMzcjrcvlJIhQyUvGX39ZrqiKfkBlg+wyQ==
X-Received: by 2002:a19:7717:0:b0:51d:8ff3:d156 with SMTP id 2adb3069b0e04-529645e3335mr9250528e87.19.1716990234485;
        Wed, 29 May 2024 06:43:54 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ccfacsm177780455e9.45.2024.05.29.06.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 06:43:53 -0700 (PDT)
Date: Wed, 29 May 2024 16:43:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Cc: vladimir.oltean@nxp.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Message-ID: <20240529134351.vtrh4oohb7g274ej@skbuf>
References: <20240528125526.qwskv756uya3zaqb@skbuf>
 <20240528130331.21904-2-radoslaw.zielonek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528130331.21904-2-radoslaw.zielonek@gmail.com>

On Tue, May 28, 2024 at 03:03:25PM +0200, Radoslaw Zielonek wrote:
> Hello,
> 
> Ah, sorry. I didn't notice that.
> The PoC has been tested by syzbot
> 	[https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723]
> 	
> The full link:
> 	[https://lore.kernel.org/all/00000000000089427c0614c18cf4@google.com/T/]
> 
> Radosław.
> 
> 

The patch, in the form you are presenting, obviously derails the phase
alignment of the new schedule when the core struggles to keep up with
the hrtimer. I am not in favor of adding any logic to taprio that
instructs it to behave out of spec.

