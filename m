Return-Path: <netdev+bounces-116447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9266294A6BC
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C05B21D48
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C01E2134;
	Wed,  7 Aug 2024 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cmkx/22q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D314F1B8EAA;
	Wed,  7 Aug 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029257; cv=none; b=MN38R2yItb7lKW+jLqyGaAMKIYZ7uarVEAqA4HBTPqybnYcA7n+VoKWnHMZNmK8Fu3xpPnyxZutpagEVOQB3GkLbfuPyCGRkDeyKBKN1f3fVH9NwyvyfA6s9W0b+tl8BARlA9nlz/44rGJcEhgL1Ptsd6VY+F27M23nip7QMyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029257; c=relaxed/simple;
	bh=zqpqUonVOPKz1vwkSnNtCE4Cyy7xTfZIEwVrxcqnQuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK2DpKNeeTdt/fE+heHAqMkO2vOeeFtkFuMZUF1+UaB2qkF/U30iM2TMg4LyNJbWsFBYGCrHHnXvtl/N9JLEtsTujbQRU07oddno2bpcncyvx/ngNpwJo4AHPY1gKShXfpYWRMaGyePSmrUcvVlpRaKSN1eDhmNERsic8r9Hx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cmkx/22q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3710C32782;
	Wed,  7 Aug 2024 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723029256;
	bh=zqpqUonVOPKz1vwkSnNtCE4Cyy7xTfZIEwVrxcqnQuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmkx/22q6Yu5iUxqv41dONrmrFFRKEthaWSHnzAx+uJpTFOfy4RBBa3+PwSDXCns6
	 fTFqgd0F16MHA8hEvMjH//BFp1Rq881m2N0pHW+WiyCFPkPFRq/J63L1YKMUN6uHe3
	 OQ5XknIG78HfjJifkI/U32Cl7FLeFNkxd+WWfBPE=
Date: Wed, 7 Aug 2024 13:14:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Douglas Anderson <dianders@chromium.org>,
	Eric Dumazet <edumazet@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>, linux-hams@vger.kernel.org,
	Matt Johnston <matt@codeconstruct.com.au>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 00/13] tty: random fixes and cleanups
Message-ID: <2024080750-percent-tuesday-9dff@gregkh>
References: <20240805102046.307511-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805102046.307511-1-jirislaby@kernel.org>

On Mon, Aug 05, 2024 at 12:20:33PM +0200, Jiri Slaby (SUSE) wrote:
> Hi,
> 
> this is a series of locally accumulated patches over past months.
> 
> The series:
> * makes mctp and 6pack use u8s,
> * cleans up 6pack a bit,
> * fixes two coverity reports,
> * uses guard() to make some of the tty function easier to follow.

This series breaks the build for me:

drivers/tty/serial/serial_core.c: In function ‘uart_suspend_port’:
drivers/tty/serial/serial_core.c:2400:17: error: label ‘unlock’ used but not defined
 2400 |                 goto unlock;
      |                 ^~~~
make[5]: *** [scripts/Makefile.build:244: drivers/tty/serial/serial_core.o] Error 1
make[5]: *** Waiting for unfinished jobs....



