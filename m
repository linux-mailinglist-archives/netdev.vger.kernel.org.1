Return-Path: <netdev+bounces-94341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB728BF3B3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A2BB22328
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12C621;
	Wed,  8 May 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j35DM3+W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625138B;
	Wed,  8 May 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128249; cv=none; b=INTYY/MgtpIDeidn5zJkr95loxPGUPeBGdJbEPXXSHDGz7pks5eeYH+MvqPYunB8ZpCEjb4jtQt22dvpNhFls9E6ZUvrsBhTi1d3vdXcVuAuCSakwXCNbp9vn/lhQ3Io1TVQhzIxAVvJgAK1Rt0lW/bU21mfyJaSccLxtXX8rA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128249; c=relaxed/simple;
	bh=E+MEqaMI2H1mlAS0yyvf/LG3IxZ91Jzmyg/2JNYYdyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JA3SwSuLsofCXhwInfC+op10jrM3hp7LMOIVIcrZa9of9iZXGCueQ2EcEAReMAekG2q8Q190FVOSeriaP3oJ5iu1bB+8IQf+NV81bDfOJvOnVxwqdbag7BqNYtPib9kYRbX+RgtXCrdPtk+d7Sfs0vD0gRrFEWE0LYC8mhgmTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j35DM3+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA4CC2BBFC;
	Wed,  8 May 2024 00:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715128249;
	bh=E+MEqaMI2H1mlAS0yyvf/LG3IxZ91Jzmyg/2JNYYdyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j35DM3+WvzaZPDJkrsXvUIYUHjeRcoNpWkUrxKt2msJMe64NGTAW0XXPUOdEKjBEH
	 UoWz9Gme/0BeVU2zCRPmoPOptV5EXwFZswU+wIMHM5BsSJR1yOKwidXubyrCxUGDOD
	 pJs4PvyDmXARw7hUgxObI8NbRih/gjgFJYLxJg18UL5GjXNh4MCe+Ya6yTsLweGXbd
	 2ZViQpXoCLaisTgpExfTwCFLosFF5BVtCSzetJ60k/9WsCzyK5BndjWrQEvEvKkSwk
	 jh/p7eXchQ772iwCnua2fL0HwlE+PxyL89qMzYaLyV8EQ+OmkCE+zBQAxqGL6Ti7Ln
	 zis/oVjGQpNwA==
Date: Tue, 7 May 2024 17:30:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
 manjunath.b.patil@oracle.com
Subject: Re: [PATCH v2] net/sched: adjust device watchdog timer to detect
 stopped queue at right time
Message-ID: <20240507173047.47586a14@kernel.org>
In-Reply-To: <20240506135944.7753-1-praveen.kannoju@oracle.com>
References: <20240506135944.7753-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

LGTM! 

One nit..

On Mon,  6 May 2024 19:29:44 +0530 Praveen Kumar Kannoju wrote:
> +				if (time_after(jiffies, (trans_start + dev->watchdog_timeo))) {
                                                        ^                                 ^

Would you mind dropping these brackets while you're touching this line?
They are unnecessary.

