Return-Path: <netdev+bounces-236958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAD6C427EC
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 07:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59E174E1BEF
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 06:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8B42248B9;
	Sat,  8 Nov 2025 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="OpF2M3Dh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A1800;
	Sat,  8 Nov 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762581820; cv=none; b=rcm5gyBTB4VE1fDbQ6z9fzqYOGTCeOAoOeWJLofQ0wxBpWfF75ntsIcDfgucU4qHWV47908eGeKhn8WicX64NqC2Pph5UTOStoRIOVc8XGyshdm4yFmxBCquW0e/unNofEt5nTw10CYjNLf9dXfNzPWjyYWBootH33BXXBFFiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762581820; c=relaxed/simple;
	bh=E1zMOuHLo5HrFCo02ewf2DH9+Lyh+E7j8NuZaDLVyfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5OWR89us2NptbdbI1YgZm1zYNxz8dP+dCYWE8PRgfppsA+3eB4cO+LMFPwXbERsy4ImoQXRm7XRMF10QwXs/4fBy/q7104LeTkHJIj3plFT7mVEBVjqUPC7Tr3Jlo49vorgTkCECTuRimFq4YZJmH5HciqbxZvXK/mZAQr2tx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=OpF2M3Dh; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28d8d2699;
	Sat, 8 Nov 2025 12:47:52 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: horms@kernel.org
Cc: chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	jianhao.xu@seu.edu.cn,
	kernel-tls-handshake@lists.linux.dev,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH] net/handshake: Fix memory leak in tls_handshake_accept()
Date: Sat,  8 Nov 2025 04:47:51 +0000
Message-Id: <20251108044751.1229123-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aQ3HJRwkz6j512o7@horms.kernel.org>
References: <aQ3HJRwkz6j512o7@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a61cace6603a1kunm693c2da794dfac
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUweVh5MTUxIGB9JSU8YT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OpF2M3Dh7/LUc8wzAlflSGi0kjjzPfctdVZjmbvTTkCPhdHF6bhwSGCVvVLijrWqlUIbYSQiKFJ628T0zTNtNuuRNDFA6lxgXrGASpVnoXMMEGTUT9HiGH51L1zrr2uv5UlaDcP/6Q1zjoBCcn6nTT+paM3VOoI5Os/qsAEwIlo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=TAQmMO31HLgMDtOVSeqgq4qykOpghHX0B3OEYJv781A=;
	h=date:mime-version:subject:message-id:from;

On Fri, Nov 07, 2025 at 10:17:09AM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 02:45:11PM +0000, Zilin Guan wrote:
> > In tls_handshake_accept(), a netlink message is allocated using
> > genlmsg_new(). In the error handling path, genlmsg_cancel() is called
> > to cancel the message construction, but the message itself is not freed.
> > This leads to a memory leak.
> > 
> > Fix this by calling nlmsg_free() in the error path after genlmsg_cancel()
> > to release the allocated memory.
> > 
> > Fixes: 2fd5532044a89 ("net/handshake: Add a kernel API for requesting a TLSv1.3 handshake")
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > ---
> >  net/handshake/tlshd.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> > index 081093dfd553..8f9532a15f43 100644
> > --- a/net/handshake/tlshd.c
> > +++ b/net/handshake/tlshd.c
> > @@ -259,6 +259,7 @@ static int tls_handshake_accept(struct handshake_req *req,
> >  
> >  out_cancel:
> >  	genlmsg_cancel(msg, hdr);
> 
> Hi Zilin Guan,
> 
> I don't think genlmsg_cancel() is necessary if msg is freed on the next line.
> If so, I suggest removing it, and renaming out_cancel accordingly.
>
> > +	nlmsg_free(msg);
> >  out:
> >  	return ret;
> >  }
> > -- 
> > 2.34.1
> > 

Hi Simon,

Thanks for your review.

I followed the pattern I observed in other parts of the kernel, for example,
in cifs_swn_send_register_message() in fs/smb/client/cifs_swn.c, where
genlmsg_cancel() is also called before nlmsg_free() in the error path.

My understanding is that this is the proper way to unwind the message
construction before freeing it.

If you still believe it's unnecessary, I am happy to send a v2 patch
to remove it.

Best regards,
Zilin Guan

