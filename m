Return-Path: <netdev+bounces-160944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85753A1C638
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 04:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203AA1887E55
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 03:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021E18A6C1;
	Sun, 26 Jan 2025 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZm+kwlh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58825A625
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737861646; cv=none; b=Pd4ggYYsPtrilB03/jqEaaUQ8zROm8iuQN/ytSjraO8xLqJsqugAhU7mrw4rCcrm4257WykM/DN+RUqg9dia1P8PIUmM/CvQI42PPZI1jbFmlzEYZs+DZx6BmEBYt5mXErME66YXUX5OElGXNyQOhZM9jMZhj4Hihms1HQXib4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737861646; c=relaxed/simple;
	bh=U2MyCWORE89PeZ2znJXk9kPHEhnY6Rjm1x+oZegnVgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r26xCZDcem41wtH7xgGcwDrqKnyL5v3vJ+f5/yx6gAeiDxkEdkbizp6/2DBN2Gf3FCw/UP2fPEqX9zktwiygL6PRxO352C9WWa+v30zLpmYXcUPv3IDwPmdBaOyHJprrv5ev96AdUqPL92yKBFQ3NRGaGrJaxUqtgbI2+lcsT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZm+kwlh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166022c5caso52468515ad.2
        for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 19:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737861644; x=1738466444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TRtL2xzyiGdQS97Wcz2aw4GFpLfYkB3Fkz4MRLMOsc=;
        b=iZm+kwlhwvFGbH7Z6OJg8xp618YFbEOM0xCfK6E/P0HQV1+wr0iPEN6n/MsDzxWc78
         qp974jBsl/CBUAiylzc+mpKGjEdYjh9nBUC5+lbcbHUChSnTO3aSBtuIcBuukjghgaUC
         r7p92YVCdUlXcR3aFzvklHI+5NySFflV9vgnCwXFq1F0faOOMrEITyRrDDAPDx9If2K4
         uEZ5HjgN/u7aMc48SDx8EsJD8e9DHR9HBDpmT8Ljha+7tcqiuNGBGKd0bGQOBNjtYNFa
         LcpT+LCIwuKLlwDoYmyVJM0ph+A6XNk79Xbh46JDte+f2++A/xHoH4IYgjJHD5O0CCFR
         phaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737861644; x=1738466444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TRtL2xzyiGdQS97Wcz2aw4GFpLfYkB3Fkz4MRLMOsc=;
        b=G+DWfN8uO16uHTEO3mgt4PxuBqgdhPOS4cxMtXls7ESt/oaUczNgqM99NG7fh/ez+u
         3wznREsFUXu2RsdzamL+aifwBd26M6TsFAkCWfcCva+oH+rc43YCbsK7r+ZVYFRi3u1S
         5unuRSy7PjVv1pfdAzxrm+yQ+FsTUce1ikqlgHqXn6QyvxhUv3/pP8zMTw0cuBwcAJuT
         UnXTHeDkM3p9lAR2tLcr3tAiwHtBw3eNaWKwJM0jJ0jo9cLGCQR4ug57uw7yLOW1C5e5
         GTquS09jah2ogmrVSXIBZrPQwm6UnYIiJPedXBOptfud2H8Q7w+2J0VKUkSxdlK5gTBC
         m8Rw==
X-Gm-Message-State: AOJu0YziAEGjizSin5Zs1AFyum/O0zV3EC9AdfzRmyzYM9YhpzmEACWc
	Y8Uln/iCiOpZDX3+bQdQvuloI88BVcCXXzTpiPBrnUCbKWODKBpr
X-Gm-Gg: ASbGncugpe8c7lVyt8XMYL1CoILPAmrfdAw1EdaOx/UJHye4WffZZEU9SHQUdoJB8RM
	tJ3FQ0R+Kjh9xaT6ngAv0aKiHZiRQ8lvB8kSKXVteyQ0u+rEl0cXfMFTXy0vUybM3F7S/i9HHc3
	4bybtLDnVhvgAY5CilrIKRgHzkLz7Np4eb0GXJ0r9lrLQarN9NzDx6xR042ydvQcunBjQloTE7B
	EKsUP2kHXyqdn3NbnZ+eKmlRQhseK/s/HrNK+5jmiO90cQ94LoA3byN3sbo9bAUTIIk/OCygJ6x
	Zyd/BYk+Puo=
X-Google-Smtp-Source: AGHT+IHObC2H3mD4cqkREGLkmvlz0zKebLYs4c8C0vqay684gGW70LE6rRRS2/Mw4NmUy9Xfbj5JMQ==
X-Received: by 2002:a05:6a20:7fa5:b0:1e1:c8f5:19ee with SMTP id adf61e73a8af0-1eb214dfdddmr54400982637.25.1737861644181;
        Sat, 25 Jan 2025 19:20:44 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:86c9:5de5:8784:6d0b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a78e3cesm4485090b3a.168.2025.01.25.19.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 19:20:43 -0800 (PST)
Date: Sat, 25 Jan 2025 19:20:42 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	quanglex97@gmail.com, mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net 2/4] Add test case to check for pfifo_tail_enqueue()
 behaviour when limit == 0
Message-ID: <Z5WqCnOiSF72PGws@pop-os.localdomain>
References: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
 <20250124060740.356527-3-xiyou.wangcong@gmail.com>
 <20250124113743.GA34605@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124113743.GA34605@kernel.org>

On Fri, Jan 24, 2025 at 11:37:43AM +0000, Simon Horman wrote:
> On Thu, Jan 23, 2025 at 10:07:38PM -0800, Cong Wang wrote:
> > From: Quang Le <quanglex97@gmail.com>
> > 
> > When limit == 0, pfifo_tail_enqueue() must drop new packet and
> > increase dropped packets count of scheduler.
> > 
> > Signed-off-by: Quang Le <quanglex97@gmail.com>
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> 
> Hi Cong, all,
> 
> This test is reporting "not ok" in the Netdev CI.
> 
> # not ok 577 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
> # Could not match regex pattern. Verify command output:
> # qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
> #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
> #  backlog 0b 0p requeues 0

Oops... It worked on my side, let me take a look.

Thanks for reporting!

