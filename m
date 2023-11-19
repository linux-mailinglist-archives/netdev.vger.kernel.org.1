Return-Path: <netdev+bounces-49056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB17F0884
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 20:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1728B1C20756
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 19:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE6D12B6E;
	Sun, 19 Nov 2023 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV8Ajgez"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F09DA4
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 11:37:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-283a0b0bd42so1187877a91.0
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 11:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700422624; x=1701027424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sY81OUKO7januhJYrCI14bRYmsaPi7S0SY/vFnt0YVw=;
        b=LV8AjgezpTpCpggyEjWlk0gfzM7lsatGZ1ikFaTHgausKe9RtNuN0ImTcPUFpUs1cC
         RQWpV9BQhqXDSEe/auGvQe+I9HfY1/TihqAnLLi85Po9JjI5R0eBWg/XDRyKi7If75kl
         PtONcYoH+3koeJfFpUcbNtPYi9EUV2qDRZcGYi2QkyB4ZuuDLa9I/QpKvLy48wTCa3ob
         XtKm/ZLFSAMRKnBuAfJIV9ZHdjtXhyMUcvIAUdVMWRTDINgq5zJNREJg2LjU3MBPEIuz
         2IoPiU8+enRe+HpNB6ytUf048oji4QFKJ4cDErVDkKq0MlYLf00BHcViEiWhIFwddExV
         70Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700422624; x=1701027424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY81OUKO7januhJYrCI14bRYmsaPi7S0SY/vFnt0YVw=;
        b=MeSZPmdXdiYkMGIQsraL0uz1nvupUzLH14jsvixYXYsoN64ANwyBcZaQNV7g4KCN7d
         CwFuAYsKPk0/sMYwvrG4j++s4UDnjSH2VzxlZHHCM6/X4Yg/Tdv94ScV7s6//R0lIwRy
         q4cGerO5n6Bagb02P5prUiGkcF2QF/NzdgrSEKndNfk+ke+PHn2L1NsZ86OjKur/evLH
         zitKDcd1nrb1VozXpc9qk+RX2KjoEAbtwrxnhWHPlVAxPubSRLXLWp57N1DTMAB8zoHJ
         oRI85I5x+C51VbF58nO5OFfFBH8SF8ENYMOb5I5c92R8EE7r3M8g6Wl89eJ9nGw8deE7
         WNmw==
X-Gm-Message-State: AOJu0YzOlTCkvhsAJXex9HdvIAEoF3gKdbzBsrmHFj+2hpEzqnRn9XfC
	Gv8f2xrdce5JYvLKyMm/DKI=
X-Google-Smtp-Source: AGHT+IHtfHCdBUzLh/R7ZTXP61tSrFNrSGGLU4abrguBDBFKgQdoQ4Wp950YMnHCji1MI/2de3wYUw==
X-Received: by 2002:a17:90b:1650:b0:280:ca28:de58 with SMTP id il16-20020a17090b165000b00280ca28de58mr7510306pjb.4.1700422624435;
        Sun, 19 Nov 2023 11:37:04 -0800 (PST)
Received: from localhost ([2601:647:5b81:12a0:42ee:58:6bca:56cd])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a001b00b00268b439a0cbsm4908406pja.23.2023.11.19.11.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 11:37:03 -0800 (PST)
Date: Sun, 19 Nov 2023 11:37:02 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: rjmcmahon <rjmcmahon@rjmcmahon.com>
Cc: Netdev <netdev@vger.kernel.org>
Subject: Re: On TCP_CONGESTION & letter case
Message-ID: <ZVpj3haO0V8Yx+zU@pop-os.localdomain>
References: <5dca57c7a699ac4a613806e8c8772dd7@rjmcmahon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dca57c7a699ac4a613806e8c8772dd7@rjmcmahon.com>

On Sun, Nov 19, 2023 at 10:36:03AM -0800, rjmcmahon wrote:
> Hi all,
> 
> Will the CCA string in setsockopt and getsockopt for TCP_CONGESTION always
> be lowercase?
> 

I am not aware of any such guarantee. From kernel's point of view, it is just
a simple string search in /proc/sys/net/ipv4/tcp_available_congestion_control,
so in the future we may add CCA with upper cases. And, since CCA can be
a kernel module, _maybe_ there are already OOT modules using upper case
names.

Thanks.

