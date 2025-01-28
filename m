Return-Path: <netdev+bounces-161350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A16A20CCA
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2061716188F
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B221A8F61;
	Tue, 28 Jan 2025 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyPYcMlh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A219D89E
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077520; cv=none; b=XPkmz38D7xshI1UaVRC/cwb+ZoAmdIizKzqJhkjt/dCCJ6M8WrROuty865wX1hraexsF/erX2BppHosKNOLpWEHL9dEzEBlCNq9qPSMEHKa+JIXpIrjDy5wOyMiqe+BeYvrLiwY+An6w/fkE3a7g1O+zvTzM4ThDTWrHt6DfAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077520; c=relaxed/simple;
	bh=NXIJ3eDwODOlpn4JnzkvWeqfAMdZ9QphNrkip79zRr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/CoEW6T+ST/uFWqOSWalXsrQLSJLQmGZgxXWZuFQgmWZ8y/ef+QJcVCzxYpmFGlTPtNxExsFO8SS+HrRkgIj01MqsNKcXjcn2/1B1R5fAuUeaSiAiV70xkLwMaW8DNgFx2YTdVKnz1JDenlUZS5Q5pb/6qL+KUDHb94Thuhx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyPYcMlh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738077516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFPnhqCVHtQ0g8wBiO1Yz2GhiU16LkKy+WLeKeQg1Lg=;
	b=CyPYcMlhZBv8V9W6p5oy3eitQTb/+6wKoSm0yhQH1tz/HsadnQc/mtS4CxMXniDN70Lc/R
	rrp6T2o3I7cBkRaZEaGLIoQnAG2UUzGVXTd4FJCFr+WtlOG72FsLnovXRshKx8rsxuSHAJ
	4XMktnXNhgp2Tt7TLFBaGWUFd8UPz2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-0jYgombYMoOJaEV2Tk7WSw-1; Tue, 28 Jan 2025 10:18:31 -0500
X-MC-Unique: 0jYgombYMoOJaEV2Tk7WSw-1
X-Mimecast-MFC-AGG-ID: 0jYgombYMoOJaEV2Tk7WSw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436289a570eso44611285e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 07:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738077508; x=1738682308;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFPnhqCVHtQ0g8wBiO1Yz2GhiU16LkKy+WLeKeQg1Lg=;
        b=VUTzSVZzyZ2G48O0GsitvridEPXHNoROiZP9Ehel41T267UE8dQAebmXiKlg2GVfe2
         nBL9aerdtQnmBdpOnMJMgRanudHXkFoOH06/aOr3Q+FLiL9gk/HwyVNN1O7Mp0Xsq520
         vD6qcths0FOU+9uHPdR/HbIMdZI25PHtSRfhZv9FcWSqQH2AKJ6EtrvB1sG8wjAJ+v2t
         dUqvQLvfq+8aCGoN8iROdKM30RKxwYYKR97ygYu9is4TbuRKZuOQf30lq1uFAfL3rdZv
         GRz1K3LIRlBUjTBkBCF0P74wCI0bxERP9MFkcDa7aaPswoQA3DAQHUm/hFaL/fBXNLN3
         EBag==
X-Forwarded-Encrypted: i=1; AJvYcCUss7MgmRkNifq6jooKzmASDsUX9xrBoPldzCd5wxDxbX5/vOYA7Pa5YVSNi2Bfk12f4DFrumc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1betwxQjwtvGrkKHDl7+5Cu77mn6jZK8o8D09eU9kIqMr8HY
	uH/Xfo/m+c1JQOd86AVd6d7UB8HDrYq3TqsREM8kcf818Jho+sl4rm+7T7VIUDg54lbrwbQLETm
	A6v4Y2l2EO+Uo4crymf6DxuTwAzLBvDq1SxWJx3vdWrWMTwhEZ+/RZQ==
X-Gm-Gg: ASbGnctJ8dxGgxFb8yUc3ulLonye4hdSk+17Snryfeua2Ubyw9jUnLtzBgF8ICqei1e
	TYm4yMXQ3xZ/cS7wr7N+FnXsNsKIPiCQeHHvqpOWPud3hu/EamqAJoT5tSF8uUSDr3h76NAcOS+
	ZnWgkiI5E+OsioU/A6AjSP6ok/kHOrVOZQYiwbrfWBbtfX40CO5SjTDY23N0ql7GFarsewWuubV
	vrqwThoSoJ0N8uSuyOjNpWwrvX1mZ/sgoVT6didip1LbIr/gSHjYnphdTQGc5sv0ShbftvXxRxq
	qaPIy6oxNHsWl0n+RC9I5GLEFatFHMxAJQ==
X-Received: by 2002:a05:600c:3b0f:b0:436:e86e:e4ab with SMTP id 5b1f17b1804b1-4389146e66cmr485919405e9.30.1738077508391;
        Tue, 28 Jan 2025 07:18:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNPISlufWG63aroeV3cVQXFwsl1eXOmgLdn6Gyv64rMEA3iN0kV09ZG2mEyLSZWwSvM5Rdsw==
X-Received: by 2002:a05:600c:3b0f:b0:436:e86e:e4ab with SMTP id 5b1f17b1804b1-4389146e66cmr485918885e9.30.1738077508075;
        Tue, 28 Jan 2025 07:18:28 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4856d8sm172306495e9.11.2025.01.28.07.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 07:18:27 -0800 (PST)
Date: Tue, 28 Jan 2025 16:18:25 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: jmaloy@redhat.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, passt-dev@passt.top, lvivier@redhat.com,
 dgibson@redhat.com, memnglong8.dong@gmail.com, kerneljasonxing@gmail.com,
 ncardwell@google.com, eric.dumazet@gmail.com
Subject: Re: [net,v3] tcp: correct handling of extreme memory squeeze
Message-ID: <20250128161825.339f95ea@elisabeth>
In-Reply-To: <CANn89i+x2RGHDA6W-oo=Hs8bM=4Ao_aAKFsRrFhq=U133j+FvA@mail.gmail.com>
References: <20250127231304.1465565-1-jmaloy@redhat.com>
	<CANn89i+x2RGHDA6W-oo=Hs8bM=4Ao_aAKFsRrFhq=U133j+FvA@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 16:04:35 +0100
Eric Dumazet <edumazet@google.com> wrote:

> This so-called 'deadlock' only occurs if a remote TCP stack is unable
> to send win0 probes.
> 
> In this case, sending some ACK will not help reliably if these ACK get lost.
> 
> I find the description tries very hard to hide a bug in another stack,
> for some reason.

Side note: that was fixed meanwhile. Back then, at a first analysis, we
thought it was a workaround, but it's the actual fix as we *must* send
zero-window probes in that situation, and this commit triggers them:

  https://passt.top/passt/commit/?id=a740e16fd1b9bdca8d259aa6d37f942a3874425c

-- 
Stefano


