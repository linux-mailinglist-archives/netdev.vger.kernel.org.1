Return-Path: <netdev+bounces-64865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB56A837521
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441891F2741B
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBF47F7D;
	Mon, 22 Jan 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SaiTxQdK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D047F57
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958182; cv=none; b=NNBOS1OF0dRfm9TbDBEH3z6I0qSHCtZj5g3BrtlPQL8/W5g/Wm5mLNqgbI99WGIoNrfEEFDq1TkazziN+HI7cgIU2JWXIWLshnOVexo4ubMkkzDptVhazCQi7RhNrNyrYemKXXgqVESEcwrSKExXbV2YdpDueeE/8mY392cBKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958182; c=relaxed/simple;
	bh=zMXc6tor4fJWUFbxItJ2+5r+CRBPP2/dvta/6uILgnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKpmXr9QdlTfizeNoSR15nzgqJgXCwvAIAX31gCrjuyI5qPTa8iImaimffo1P6FSaKrJpKZZameUhgn7VjZjv7kuBQL3Vqtnf7szKl6DdIPXRWkEkLS/gD0i0t91aufRIMTZIpcHSeag3I0rzqR8579qvZZyN4cCkoWwmL2L2BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SaiTxQdK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d71207524dso12484375ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 13:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1705958179; x=1706562979; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK/doAZyyGzQuUQ64pMN/IegoB0Y5GZJ/6bMRTJUZOs=;
        b=SaiTxQdKSvdfDHf7FsAVB4Up811/prozfadikTlsZcpgqyu//7JGkD7lZap1WTv3/3
         zpsWEw/NFgolwwJgdoS3CQWtu6WWaltSUmnndO6I1eDYlP4mLNvPCOQ1U/7X2VPOVZCg
         mITcET3n22GHWVgtPIu4buWcJiSXEc5lOA120=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705958179; x=1706562979;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK/doAZyyGzQuUQ64pMN/IegoB0Y5GZJ/6bMRTJUZOs=;
        b=YirDOepBq7rzD/lR6FC3gjU740igZ7ecKpE+JCgNbkeQ/ze69tg39pwsZXi3ioyG74
         dF46RKpnW9y2+urhDJU1SbloT2OmWH2xKlKGtOO2D8s+vnrP815kZPKjGjLNuNqtVYGP
         GYPRFOWIDSLwxlMQ4apdbcgTaUUGZUUkaz4ZKmA83LtxcFn2ha/ARLrxsNM0puDextFj
         dPW/oW5nlgjcQKbw/xFJX1heYQxMJihqLKoUPTv2C9TH9nYIbOS22Rt1wNLNruypcDlF
         eTBjdTP1Vb4QJmZkuBHnc01hZvGxKIg2cYUJMqa1kWOw7FUQeCr9k/YZIGVuWye4bPLw
         rE1Q==
X-Gm-Message-State: AOJu0Yyap9wwubnPqZiGWWfI/OsJ1nArWC+NYLXvfpPl298uQCEyaPZG
	RmpDG1jgPhV8+Hf4PX6DKuv4wkEENzZaD99pMMrH4Yue8jY/pJPlWDltsoZkptI=
X-Google-Smtp-Source: AGHT+IHY6QTp3+L73kbC1yAy2VNJUlYykSfBPUTr4schnUh02OhLk1d1DJUhybB11UylKM92YKo7RQ==
X-Received: by 2002:a17:902:e891:b0:1d7:599d:ed25 with SMTP id w17-20020a170902e89100b001d7599ded25mr1272345plg.39.1705958179526;
        Mon, 22 Jan 2024 13:16:19 -0800 (PST)
Received: from fastly.com ([208.184.224.238])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902b28400b001d720c7ed48sm5693728plr.286.2024.01.22.13.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2024 13:16:19 -0800 (PST)
Date: Mon, 22 Jan 2024 13:16:16 -0800
From: Joe Damato <jdamato@fastly.com>
To: Christian Brauner <brauner@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
	kuba@kernel.org
Subject: Re: [RFC 1/1] eventpoll: support busy poll per epoll instance
Message-ID: <20240122211616.GA1244@fastly.com>
References: <20240120004247.42036-1-jdamato@fastly.com>
 <20240120004247.42036-2-jdamato@fastly.com>
 <20240122-erwidern-erleichtern-8a04080a4db3@brauner>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-erwidern-erleichtern-8a04080a4db3@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Mon, Jan 22, 2024 at 04:25:01PM +0100, Christian Brauner wrote:
> On Sat, Jan 20, 2024 at 12:42:47AM +0000, Joe Damato wrote:
> > Add F_EPOLL_{S,G}ET_BUSY_POLL_USECS to allow setting a busy poll timeout
> > per epoll instance so that individual applications can enable (or
> > disable) epoll based busy poll as needed.
> > 
> > Prior to this change, epoll-based busy poll could only be enabled
> > system-wide, which limits the usefulness of busy poll.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> 
> This should be an ioctl on the epoll fd, not a fcntl(). fcntl()s
> should aim to be generic which this isn't. We've recently rejected a
> memfd addition as a fcntl() as well for the same reason.

OK, thanks for the review. An ioctl makes more sense, I agree.

I'll rewrite it as you've suggested and send another RFC.

