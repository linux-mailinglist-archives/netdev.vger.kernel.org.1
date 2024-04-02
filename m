Return-Path: <netdev+bounces-83925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC2894E25
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79B71F23807
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03FD56458;
	Tue,  2 Apr 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cDjjv68p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932153380
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048469; cv=none; b=u2C+OEiTuQjXEtbVziSi2pxJebTZi/jTvagA0ncIVNw6MgGBRtNBsuoYbUQ1KprxUgtleK4RbYOPTS2bQaMgA0c8SPwWo7WsrQx6XVCEoZ2cmRjadAE1PytGuLPjLMePhlYhV6UGZ2gTYVwPV2xQn89en9wu3Qf3yFPeb3X4mTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048469; c=relaxed/simple;
	bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbv1XoM30zf4QDRUxsMEcTiKYy4G4klPM7SttqQyYAAYLHkEHGtU2t1W/D2wxMCzN1qW514LkIm2rnhVomSYlVgwHCMAonIjEN2OP0vCLgPP4vs2gTHCwKRWrQK15CzbF6UcXFHhOfpAcd7BqMbV87P5Y50oywlq+c049ZZWyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cDjjv68p; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29ddfd859eeso4046635a91.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712048467; x=1712653267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=cDjjv68pp8Lpkc4pFaT/whgl3Fs+P6d5V2OBtHJkViOaKCAn51bVEvF0g1r+A1/7/m
         d7g5Z2lPLhOmNKyUFalTKtMbg4oBMLRMUUHm0thDbsrcrNmkvAWoBBeigo7BK2QMifAk
         AUaOIWTRxbQKcTx6BkcaAgf8UCEK3weuTAWj1dlnlvFqpxZlVjn5IACWJ3rkpwh16xld
         rOqP5bgDbA98uRMPGmbrhHnab+yl40xcsCuocGxFl8xlR8svxC6ZeTIVLo6AZCxR+jL0
         867QqlF6Y9/0s6szyppRANS9oR0vC9BfjcazjRCOk175vzLvTtW1jfxinE6dDgU9CU2z
         +Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048467; x=1712653267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=CZWoddQRvosm7ToxKZ8Zt0K/sSnmQaYN/Fx+rKMQtg5NW+1CGhbYL0TCNMCWs/svQ1
         P9AVMwFt3Xs8NkTNpbKlkPSxrDu1n/w/QSd47rPfDIhCLLZ69GG0P2rhcF5QK+5hsi5R
         XSllKGkSu5/rTBIH+/KRlgR2BPyCVR5Tm+hx3iLiG9hhFPDCXZYvqEdqwI3sDPQS8nQ5
         wiRZFNaXIWtZfBO3Hdjfn52egQEpDg7BQCZioauhWxYVgW1Nac440BSrzsXJTTq7OG99
         NrYpnLAg6XPXVBg81ZtNN+pml8cUpwOP6eUMOdwyiJ8V/fkwlfyCOJq49IiCkLpyw78u
         VYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0S2jmFTrvGHNSqPc2zg+wQOSbHLEjCbmDV/iRTqcuaGUb6xoGossL/VkQGoWYUFea9zKNwce6EEQwcz85PQ8ckwZSZ4G+
X-Gm-Message-State: AOJu0Yz0GhXob/Ecetavbf1F9zZolj4WXt6AAEzNFUIP14J/9z09Wq3k
	ebO3y3fm3FhLFysSvZEZlD2I15G/97pczaKkpturDfahvHjGgkNjo7DeeDIm6TJPqgWFmiOnWBw
	Cb+vxhNuJR2QI9ejLIZiXqEgPKw3nPThw9Rre8w==
X-Google-Smtp-Source: AGHT+IEsH5g/yQ7549h0WSFp/og1oUajTS1sjB7Vh97/Wgv/VHLuGRQTOVZXjAhxRMgyq22jN/7H5kj6HX5rDOi6i4o=
X-Received: by 2002:a17:90a:b111:b0:2a2:47a2:9bba with SMTP id
 z17-20020a17090ab11100b002a247a29bbamr2890042pjq.3.1712048467530; Tue, 02 Apr
 2024 02:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000090fe770614a1ab17@google.com>
In-Reply-To: <00000000000090fe770614a1ab17@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 2 Apr 2024 11:00:56 +0200
Message-ID: <CAGn+7TXh4gzeQ3EktnYQ=TXO_LutRU8iSQ=VbBpPpVX=Cr_UEA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
To: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr

