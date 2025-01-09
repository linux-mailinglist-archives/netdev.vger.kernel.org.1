Return-Path: <netdev+bounces-156884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4419A0835B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7838F188B4B9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FB205E01;
	Thu,  9 Jan 2025 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zVX55/Im"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7821FECB4
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736464787; cv=none; b=Cdt1ZAOVuXdNMMTcHZ07sKFcorl+kSVts1AmtsMiSvf9pm2te09nkc5ABSu4NzcoAmQGVZjiqOxjrCoDUHADsxpHecK0Mb+NDC9QuDimYAtX/FNcxhdzULE+Z7JvBFqq6y7zLUtXw3gRUCsqxvmGtRgut+Sft3Jh5sl2Hqp9szI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736464787; c=relaxed/simple;
	bh=KouWdL/Ro/NawNsOGgzco7I92kyaGlxbjwySe1i5cIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgZ2CyvBPUzjIqZYuvlTw3j4T49m7Vvd9UNMCjMK4+0VI6yehZx6R54e4B4I00clRlZ4c+ddZThBlssV6U2xWXIMPu/XpMO5jRBNUYhWXWQqRWX8OpxqOCyga6M0SZTEmNLiCK+AkZf/BAfqfCtzgIq8c0zqjfsEtwjG8n+Myhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zVX55/Im; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215740b7fb8so53015ad.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 15:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736464785; x=1737069585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q1PkYbGFJEdslOfFcxj83YTAVMXcuo1qR/Rn78KGBhI=;
        b=zVX55/ImohmYEwJm3HqOAF3Vjbykyi08PyhWU91FxS+sgijpUp/PWTCSZ9wVwGHEQ1
         bp+sieJXFWVJu21PBiK3+5/I+duw1CV0GVCO5XRFKphuNDS5APzP5BPPqRDi6QIEOsJ7
         EbLJh3PAN2l8ICfsNIt3eJzd5SGN2ZEY3LZJejH01pclt58iu1hRBwrX1dmxvctaELNw
         qUocRtUUQNV9NIwJ6BGTMLAg0ayIQ7jihWUtVbM91I0d+Fbnm6gmV+AIjfb3Kb5NI7Gk
         fS44KifUoaRREBakxQtoeMSYml+9Q9UW+nbbaQ5dkVAgsw7K6PHRUkfh9mlVRL5jKPAb
         XcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736464785; x=1737069585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1PkYbGFJEdslOfFcxj83YTAVMXcuo1qR/Rn78KGBhI=;
        b=aQrPmXICib3Gu63I8aYILUu4DZxHE7z7AChMTzA8PZsaY4A29R9ScTO+rbSh6Qe9Rz
         6LN5VI5v49WyShVZtEoEd3fHWEtJyHRJq1QjCXA9UNXu0po7pcdcMHnFs3ipNwcdbuKU
         Jvia7wLc9vrKGJmXGXLb2P9p4n7ceuwh/az8CAHbsvoMuhj/1KYkMwQ9cOiVYPG4xkhU
         mVa+PzBCwzI3rN2csTB8fqqJhmLAX+GAl920kqhXROp1fKt1KiZYRpLZ9bdtJHRpex9q
         1IVFltvPN7TT8M831fEVPoQJtYBHZtd/lpqE8Vjt3pH/+extTnXHiDv3BTBIg4tqse8q
         2wUg==
X-Forwarded-Encrypted: i=1; AJvYcCWLw71GHSDyb0urqbMHPDAl15Yos+eMxKJk1Tm6o6CnB/rcfhEIc+Xw31iSi4avFtIRy4R/x0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeuJVgbn5kSa7mtkLNTebRhtomBEhN6euixMdkRiqWIJxFLPqE
	21C4Kwrd+9jg8d3TYQbCIB5btRJSTWxA+5T+uo3+76eV7EQEQ3ooNjuVHzBapg==
X-Gm-Gg: ASbGncsQCNrTbIDuj1G+NrE46KvNfQoLjb2N9jqXDQWeakvgQSMYENpKEZLrLWd2t8i
	u/Zb4Hb79DlYj9gTbaF0HMZGrtu+ClW1qChBjuJBebgqK84MbCC92CbjmVPEjAGCY4dQIO03A/u
	XKycn0pz1ZSDb4swKJklEdqmQvXS56MZTMvvF1SzJBG/G44g5JHFAEDw9X7WAfM7Y0Je03h222K
	t0tsWWi0uulz4yR9+xLPdzVHPP/cfDXUoSzsr8tdyvutQjCa/2Xf0efxGPBX/WcmcT2/1BxlX9O
	/J3QbsoKEA6cKc0ERAo=
X-Google-Smtp-Source: AGHT+IEHNg3KQNkDJkk+KVCtgbVcnKqUUPICpFgI9fFO1Xu457d4ai2cWyh2ei9TOQgrYG3Htub00Q==
X-Received: by 2002:a17:903:4284:b0:217:8109:e85 with SMTP id d9443c01a7336-21aa338c570mr342445ad.13.1736464785230;
        Thu, 09 Jan 2025 15:19:45 -0800 (PST)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a26ad41sm4599210a91.1.2025.01.09.15.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 15:19:44 -0800 (PST)
Date: Thu, 9 Jan 2025 23:19:40 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
Message-ID: <Z4BZjHjfanPi5h9W@google.com>
References: <20241218203740.4081865-1-dualli@chromium.org>
 <20241218203740.4081865-3-dualli@chromium.org>
 <Z32cpF4tkP5hUbgv@google.com>
 <Z32fhN6yq673YwmO@google.com>
 <CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>
 <Z4Aaz4F_oS-rJ4ij@google.com>
 <Z4Aj6KqkQGHXAQLK@google.com>
 <CANBPYPjvFuhi7Pwn_CLArn-iOp=bLjPHKN0sJv+5uoUrDTZHag@mail.gmail.com>
 <20250109121300.2fc13a94@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109121300.2fc13a94@kernel.org>

On Thu, Jan 09, 2025 at 12:13:00PM -0800, Jakub Kicinski wrote:
> On Thu, 9 Jan 2025 11:48:24 -0800 Li Li wrote:
> > Cleaning up in the NETLINK_URELEASE notifier is better since we
> > register the process with the netlink socket. I'll change the code
> > accordingly.
> 
> Hm. Thought I already told you this. Maybe I'm mixing up submissions.
> 
> Please the unbind callback or possibly the sock priv infra
> (genl_sk_priv_get, sock_priv_destroy etc).

Sorry, it was me that suggested NETLINK_URELEASE. BTW, I did try those
genl_family callbacks first but I couldn't get them to work right away
so I moved on. I'll have a closer look now to figure out what I did
wrong. Thanks for the suggestion Jakub!

--
Carlos Llamas

