Return-Path: <netdev+bounces-207889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2052B08E74
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7CD585BA9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB9B2EBBBE;
	Thu, 17 Jul 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuDnSUJX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0561F542A
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759956; cv=none; b=o5ThaZGcu4UZx9Q25ZWZ34qB06xAcu/iLTDvy3nrDksol3hjVLlBneUKgBRs2tQX2r3rmjwbtS9oRWhsXNyAad2KGTd2Q4O35DFCemMxruwEiTvxgAufx4G+KZtf5CbOziHh28uLEt6JPXKvEPfhaKGK6+rcy8l85qTDlZjfmBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759956; c=relaxed/simple;
	bh=bQTfTIbqwvAU+Vu8jR04fpXE0aYXrf66QloGZ5x8drI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNt+Dy8cl3eaoS0z9XBIZwE5dh9YXV96VAyTNkRGyZZm+uMSTdLOuPJNxu9nwbtXacI8qLoNM88JxcdDmBfJc2MXgojA/ylq6SIzb+x8E8TSS7nVklO2Xgpg6ptVwjUkbWPeepso5oIeiRX1PF+OXhSTwvGWHL0kN8jOl5KlU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuDnSUJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCACC4CEE3;
	Thu, 17 Jul 2025 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752759955;
	bh=bQTfTIbqwvAU+Vu8jR04fpXE0aYXrf66QloGZ5x8drI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AuDnSUJX0BwsFMRDxsdIFuwY2MO30Z3V2Ci6oO6rzhrB0AXOv9Jl+yZPwhiBzJAX6
	 CRJmhw+1UDOO7O7ejTWoACh1O/mBWIsnDlsEnO4sS9l5XmPYgDrg69RkWV9osQqo2n
	 aN4sKZEdy0KbKgxK/q3ALlugUNK6atgZlrebOajm/ae19vV9pUQdRTG2tBZAID47J6
	 Gu3jOoykqADVhjHxWi1+Z6Uqj7/TdCeQZ734xdPG2FhTvSVxcjp23Z0m24PFxc0L0z
	 E3L5++SUhjjaRaJwV++nncadaQ+TEw54oxPyiTtGybXW3DMZVhmGPmmsH1dn2L7jyC
	 qKbOhR/OaGS4A==
Date: Thu, 17 Jul 2025 06:45:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krishna Kumar <krikku@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 tom@herbertland.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 atenart@kernel.org, jdamato@fastly.com, krishna.ku@flipkart.com
Subject: Re: [PATCH v3 net-next 0/2] net: RPS table overwrite prevention and
 flow_id caching
Message-ID: <20250717064554.3e4d9993@kernel.org>
In-Reply-To: <20250717075659.2725245-1-krikku@gmail.com>
References: <20250715112431.2178100-1-krikku@gmail.com>
	<20250717075659.2725245-1-krikku@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:26:56 +0530 Krishna Kumar wrote:
> This series splits the previous RPS patch [1] into two patches for
> net-next following reviewer feedback. It also addresses a kernel test
> robot warning by ensuring rps_flow_is_active() is defined only when
> aRFS is enabled. I tested v3 with four builds and reboots: two for
> [PATCH 1/2] with aRFS enabled/disabled, and two for [PATCH 2/2].

Quoting documentation:

  Resending after review
  ~~~~~~~~~~~~~~~~~~~~~~
  [...]
  The new version of patches should be posted as a separate thread,      
  not as a reply to the previous posting. Change log should include a link
  to the previous posting (see :ref:`Changes requested`).
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

