Return-Path: <netdev+bounces-167074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 177D8A38B21
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E16171687
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C28522F383;
	Mon, 17 Feb 2025 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+c6CfRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570622B5A3
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816005; cv=none; b=X6nZD5bCJRyWH9RoeIrL3hH64GZVW30QkeMC53Jm8p6b0JdGW926/PqKvoCTBY0zX3mXwt4H04LRoVg4cx2xFd4PSjhnTvxlBNTu0wWINE0o2/1YNGFDWUwdfGSCdhMoqbHco+K2taEG7ahuy66tQgGd//QztvO69dbBwVhrHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816005; c=relaxed/simple;
	bh=S7uojleg166F6GoEE7dSYAVn2hzMD2W+CpfaL1868Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjSli3SJLSdOP16cPMzQHfHcitVUJD4RxOGA+ygWNJQI+8yB9KOf8+53B+iexFjpzA7KMMQJFdjvGYn3NP8YmXVc8+WaJZAVqNhrhCKUCazFBzVGeMdGdt4fQwqF1bvctv7nFScaIGHb3lhdENBqDp9SriCa5ANEFzH7DfkvOZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+c6CfRz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f42992f608so7024408a91.0
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 10:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739816003; x=1740420803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lhCKTKEribQTfMxRx9Vwe/XqqvQlaJm44Ont/yeuyc=;
        b=Q+c6CfRzltYdjB14YRlBfdCM0UJfGC1weeMp94EDV5Iwuq0Ko6BHpgVnVvCexll3C8
         FgPfHk8zwISaqQB1MvfoTtlbcMUkA/JTkB+7R9ljm++WDgOF61LCQQGOx3/fF2XYnQu0
         T8woUqfN2sr/OWvSEyVKX+RdxEXTkFakxe18sDXhPxw99CJ854X6QBRgAu21arrjE50d
         w5Widm7k1sIGbQ8WMT0etTlWXmZW8zg+XKwyik+oCD+MuaYX2AetbTwZlNwmYadWGjcI
         sno4BmUUL8pEeBSj/m/v2MwBhfif17nYVCZPuqQlumZ8mzFfy99nOM3YHwIj1aY0NLOX
         GZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739816003; x=1740420803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lhCKTKEribQTfMxRx9Vwe/XqqvQlaJm44Ont/yeuyc=;
        b=cDhVthFTbSDmuy0jEKVgViQ2PNbPnOcL1+j7b5LrGRS5+nF8a8KOUkzU8rcW9P2O9h
         Cx13G2SddNdcprW4FDbpsHUFkTMA6TvJX4LkID/x1c5fUFwqULGtxIFNDc4xrEtxUuzY
         XId+TNHLOKaSrSCZ5cF1cOEdv4EW0gw9mNfFxYFVMDcT7bwuGL4SPeHXlw0lOyZHEV7J
         Acq1eT4wH5TffHFrX31gEx7F91hsBEifW1DAFf5y3ydLbOei8CvQr8v3X2EkC5U2HtGd
         C9umpmlt5qMmaPlGwEKGPlPHHMEs1OitF5rsYpr62vF1U2upUQKFo7J+YY6nBELPPs6j
         KsTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQCc60IiQ8JzSVuqRkxQaFLYCrMLf/eGKBay58ai3nb5Sm8YddT4Pl81c3Vb6HC16Pi4IyU1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPaf+0SNgNX0Ib57kvg/VeTsClLG3aR+f491PW+xj3AkAqfVol
	nIVbWQCSfs9GgpCzCa1vs3jaDjtK6MpRAbhukQiKwznPSr0wN98=
X-Gm-Gg: ASbGnctZ9R+gDSdUF9xyRCQ6Wp44KFqO44i8cJHghP5UfVw+CYoBd+5EvMBwof1hBbu
	ngSRMbbuddD5YBCBjUIlGW1YdC0kxlxCCNeM4pIdi1wspevg0fH7IB/KE4ibif7O0bnbQbtud5B
	djzg9nzFr+Ykz02J6I/yiXkWE3YTISEe1RNlrnoOU/IFaxYfl6O7zpVxWXtmiN5rhFrb6O2ZYD1
	Bi8zyKaH3uQZYLFb4JQAjikn2SLa352Gx66AIUXwKriFWU9hdet3cAEQyHim4sd16KxzYwPvAl5
	nv/vzvCixWte9Qc=
X-Google-Smtp-Source: AGHT+IEN+TcJ4qi0hFVi5kj2RvtW7hOhmgRAv0GwIRdRypWYNoO9IwUOtbjYJHdbgiHsAa4hbdLDdw==
X-Received: by 2002:a17:90b:1b46:b0:2f8:4a3f:dd2d with SMTP id 98e67ed59e1d1-2fc40f22bf0mr16684252a91.15.1739816003279;
        Mon, 17 Feb 2025 10:13:23 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13ac0a5bsm8264155a91.18.2025.02.17.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 10:13:22 -0800 (PST)
Date: Mon, 17 Feb 2025 10:13:22 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v3 00/12] net: Hold netdev instance lock during
 ndo operations
Message-ID: <Z7N8QgXWP-DJU5Yg@mini-arch>
References: <20250216233245.3122700-1-sdf@fomichev.me>
 <Z7NTE1DlI0nQjjwy@mini-arch>
 <20250217090818.390e4efa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217090818.390e4efa@kernel.org>

On 02/17, Jakub Kicinski wrote:
> On Mon, 17 Feb 2025 07:17:39 -0800 Stanislav Fomichev wrote:
> > Teaming lock ordering is still not correct :-(
> 
> Mm, yeah, looks like patch 9. We need to tell lockdep team's netdev
> lock is not the same one as the lower netdev lock. Probably gotta
> add the instance lock to netdev_lockdep_set_classes() after all?

Adding it to netdev_lockdep_set_classes triggers cleanup_net lockdep
warning. Not sure why my lock_set_cmp_fn doesn't help with that, will
try to debug.

