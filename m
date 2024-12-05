Return-Path: <netdev+bounces-149429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B659E59B0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B06D168C48
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C68121C180;
	Thu,  5 Dec 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbHVJtfi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E1218AA3
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412546; cv=none; b=LmKakHCE3p7GFG54ydwby4hFIAouGwdInL5Inrbyzu49cm/4tozty489wrx53M+m22x88YblpwlvPjJuPe+EJseEKJN9H1ogLSd/2HIyyet3e9mq6vz0lrr6fhoLFYWoEvEGp3MJNqK4B5w4XA33GBKt4vMEzwE80tsCbVGnTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412546; c=relaxed/simple;
	bh=wqE76+jdjCp3ArkRmWtfPb7wRoN33try+cR/fQb6/ns=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WPDTVO+OlH90SrYxludMs4EbOjlKKbGtV4jse7JfZJDdK9DffaSvqy/HDXKO9dMSNFEmKJaSSdd5vVB3H27bYBCXqftkB12isqcITR1X2z25+UAo29an5MYFfQrGCNfKTsNeT2GLXMgYPtVh+wRQYVSW32t2Ew9w2fGute4tLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbHVJtfi; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6844074e7so52615785a.2
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 07:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733412543; x=1734017343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXeECT8l3lRGP/5OjdueJd/E5RUjAMehqlmGgKdIO1c=;
        b=mbHVJtfiAVzfM8DRoJSnPZo4iacSCHB95eoZfJrHJh96NxR5h0CDw7c0Js+KyZN6ES
         BzKy7AZ89/dX7lPv8XvbAvUrYHJG3IyVUZdy8eXILWU8bqHdW3l0IN2M5nP/h9KHtnbl
         P21jQ14qo4vqArP4QKd/UPaH9x7xzXR3CjO2t0vnrIkra3Pmvfvv+K6iHh8DlWphKbj3
         +4IAfAvoigB7oR2GKPtKj1F+Y6ZfpYXfswwMO9qX1YMnCBAnJeaTv69NaUUBUJOxUPh2
         RogvYWBGD5pjZ7mVauBeFcJH10X+UFgxtwYmVFwtkkORGoAsO6JIkhaMjo31p8JM9MVW
         mtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733412543; x=1734017343;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jXeECT8l3lRGP/5OjdueJd/E5RUjAMehqlmGgKdIO1c=;
        b=XR7Zx5Uhm9OgQBkoWffsPef9Cw/HS6jFbJT32OiRl2vXLQspSvGMwcrsPE7GidQ/Si
         R05bRg1CslLiGovHfsG/hbQc8o/0yIXd3UnOZaIKMivvwcsJzs8V7vF/Toi26Jj2KlKG
         T8fUN8P0dSDA36sntdHwNFxJwN3jwteNvldHn5qRTgX4uCDT8QFeZl2e4UQFaTK8ODWC
         p9cAfbT6XU79DMUxnLv7ikCLPD1bJRHBEVBqsb+V7k6rQYoJlhPTaB2KFdbK6x09c057
         cFwgyvC6IjFV5p+D55wI+jx/SElXjjJ1RF2P8pUI65zwvyH2F4Q0c5hK9rFcKmWrIBE2
         e1cw==
X-Forwarded-Encrypted: i=1; AJvYcCXwsFx1BGAG5Smq7e/p+N+ZlFsQ2ExvpGAQaPtUQdUpKVeestRfTpCPFBUoWdMrA+RPDC6VDH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMwqth0+25ic79WDCrumeQJehUB9qeipvT49+6mHVvX9fjHJNR
	0CGjxWLGV75WnlAE0zkTmfjIQ5y5BWSuTGK1XgFU4hGZ7J+p3C/p
X-Gm-Gg: ASbGncuO778uhdU5+jLCNC6uWzWRpX/859175LSLR8T7twXFClm97T18/OfpIazkJIr
	vtKhqOjfpfSMgi9O1jqwb8wt4mlcOThaz7KHeZ5DOG3IXdxLBxsuKxhdXB4XmeQQn1ZPVjtf9Cp
	8OR/3paDYZH76xxWeLhmCr//gypoSvQz0mSxtxrDys1zVRNmGz4SUYURB0FO3SGFWbHnmBmvwKi
	KVl5vDNicLXPDCG2r2piX7QL3LP9lys4QN6BO2/Vaqpz/sl7T4est1HtDD7gZwaBnU5Qz1hQGV0
	cfGUmJfkGJIIjw0ogC5NgQ==
X-Google-Smtp-Source: AGHT+IE6X1WKgB7gMHGyqlZYtw/vCZhBZzFJTpFcUne9GBqpmuRFXxo6w5HMxE5xvvB8PIEihK2oOg==
X-Received: by 2002:a05:620a:4109:b0:7b1:4fdb:3a1c with SMTP id af79cd13be357-7b6a61eb655mr1044076485a.47.1733412543460;
        Thu, 05 Dec 2024 07:29:03 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a66c32sm69922885a.57.2024.12.05.07.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:29:02 -0800 (PST)
Date: Thu, 05 Dec 2024 10:29:02 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 idosch@idosch.org, 
 Anna Emese Nyiri <annaemesenyiri@gmail.com>
Message-ID: <6751c6be453d0_119ae629474@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241205133112.17903-5-annaemesenyiri@gmail.com>
References: <20241205133112.17903-1-annaemesenyiri@gmail.com>
 <20241205133112.17903-5-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v5 4/4] sock: Introduce SO_RCVPRIORITY socket
 option
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> Add new socket option, SO_RCVPRIORITY, to include SO_PRIORITY in the
> ancillary data returned by recvmsg().
> This is analogous to the existing support for SO_RCVMARK, 
> as implemented in commit <6fd1d51cfa253>
> ("net: SO_RCVMARK socket option for SO_MARK with recvmsg()").
> 
> Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Small point: better to not expand existing patch series with new
features on subsequent revisions.

