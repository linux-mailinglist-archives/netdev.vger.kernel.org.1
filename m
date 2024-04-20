Return-Path: <netdev+bounces-89800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2809A8AB947
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 05:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4D81C2091C
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 03:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF98F6E;
	Sat, 20 Apr 2024 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgSyx3jR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E306205E12
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713584876; cv=none; b=JaVUTJkheY9d3MDtCXeeNFF1Sn09Xzc+pZffhndHJQgW6vSYxBrgXIFc7XDgMPRp7Vc698M1ZeIz6jYik3etUjtEIEKNfggUDzI/GZhJ2/HRa9JcawRfJ44uyjs4uNS1AH7075TRV51SdfE6MRvfTK4hdKTwuQvZYOpmSEhah0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713584876; c=relaxed/simple;
	bh=J8O37Lq/C1eRN/zu7B23GwnAjTIkM6TSJFkBO5dKPFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6ZSbsRDuGbM16juwV93jfIGJz26cLJHmhOYPJB4h+udmqlJlPuq+V9DfcWgPJpXb597xZLavibI8rrZXGa+g0+DE9Ygxa78DvS/pmyII7TlPQ22k6JcVmVRP9f5Waw+mB4daAaqWcX4mDT0bmLv49OSDdPGm5ZdfKvbq1gqMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgSyx3jR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5E8C113CC;
	Sat, 20 Apr 2024 03:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713584875;
	bh=J8O37Lq/C1eRN/zu7B23GwnAjTIkM6TSJFkBO5dKPFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AgSyx3jRHPZ0nG9q1CpSvdaG2iCSlgvqMUBtcCNCx24gVnuULgR0aKA3JxPGFI40P
	 Kqv0sZ+o70hjbVHadO92/zI6xGyzaHRBoQ2jYw8mJd4tgaMhAjL4Ckd5Bqa2ASQyZh
	 dZTDZK7dvCA39DSDyzaxi6rbJ0Ik8+EhIPRY7izu54448tCtHVvdX6Z10OgfpZjWc/
	 mS3JmLpwqG0UPJV20SfkzNx1uWYZbqDgzie73L1H/4ErMW0D8YX0Repu+fm31hDlGW
	 rE5sVQkK4ttmmNapU/HP8rqN2+EuEi8aM5K5TKscUbFTozBnPmaXObx2UyAMjvfo2x
	 D1TM9OCbiALQA==
Date: Fri, 19 Apr 2024 20:47:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
Subject: Re: [PATCH net-next v2 0/3] net: A lightweight zero-copy
 notification
Message-ID: <20240419204754.3f3b7347@kernel.org>
In-Reply-To: <20240419214819.671536-1-zijianzhang@bytedance.com>
References: <20240419214819.671536-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 21:48:16 +0000 zijianzhang@bytedance.com wrote:
> Original title is "net: socket sendmsg MSG_ZEROCOPY_UARG"
> https://lore.kernel.org/all/
> 20240409205300.1346681-2-zijianzhang@bytedance.com/

AFAICT sparse reports this new warning:

net/core/sock.c:2864:26: warning: incorrect type in assignment (different address spaces)
net/core/sock.c:2864:26:    expected void [noderef] __user *usr_addr
net/core/sock.c:2864:26:    got void *
-- 
pw-bot: cr

