Return-Path: <netdev+bounces-229511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCD3BDD33D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF40E4F77EB
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6750F313E3B;
	Wed, 15 Oct 2025 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AP6FJBPR"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DADF313E39;
	Wed, 15 Oct 2025 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514656; cv=none; b=RBTzFyOzPgR1t1JUu1ozGVtpFzRNL0ew/JoWUZPk5xQ6V8a/2FtOPQmWxgcKAq6h9m/t5MeGUjvxCVISrK3iRNRmISN4uq1wzTKtocliHUNh5AZ2hrqtHH3k0eCN3LYflYLnes5GRdRr5W8WUX+j59iOjdBDEssFRtcv9U8vNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514656; c=relaxed/simple;
	bh=ZNR/1vZHBuEZZ1lROgCkXjOzslv+2Dewz4AC5zPfhIE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtX0gaRWoagYYfhv8HmpW20z4qjfa6dTmyUnammo7SHKtg/K95cAGmxJ+elsKrK5BGyfEdErdqZ6CFI3gkZYkx6U599oYmI0ZlSWGlU0k0vDWyyeuVQ1a5L2bFbz9TqfJ4MyNaKm0pRDoh1GFbM9d3XUrAPkXqGhNfHg2UFKi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AP6FJBPR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 80EF0207B2;
	Wed, 15 Oct 2025 09:43:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lxxDAAhui_Ho; Wed, 15 Oct 2025 09:43:13 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 771D1205E3;
	Wed, 15 Oct 2025 09:43:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 771D1205E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1760514193;
	bh=8DAGPi9RRU3NyqKZzw7sWRwKSj7xVgafKgfGA9J4HSE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=AP6FJBPRR+t6JvtgYIFR2wVHWR/TZdm6ikQu4S9x9hcttmwYZpG5GQqs5Azp2MNDj
	 Cpj5cPBfQe3bpnKeCk1v61JIobXQpjiTSfFzNvforlegqaIVQfMLsYpljQPwV9fNh6
	 ku6Towru4ywx42HJY8H29CBvc5eENPa2m9lSP6wZ9h6nvMvn+9OC1erHYPtZdBEHSF
	 +KpRPK8nlTnz/IxH4tQ3kArTzohXM84CTWKag6XuTbcPVtgMDKztZkdJ0PzC/pBiAM
	 WIqBpdfyIMXG5o1tiGY8jG75U5M1A/cltnYolDoZ3xJA1WCvs7mIwlhH4kx2EI4kA/
	 ea91ltf89aN2w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 15 Oct
 2025 09:43:12 +0200
Received: (nullmailer pid 3606862 invoked by uid 1000);
	Wed, 15 Oct 2025 07:43:12 -0000
Date: Wed, 15 Oct 2025 09:43:12 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: syzbot <syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <herbert@gondor.apana.org.au>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_migrate (2)
Message-ID: <aO9QkNNkZ1JLnnIl@secunet.com>
References: <68e2ad62.a00a0220.2ba410.0018.GAE@google.com>
 <aO5PnU4dhUuzM34e@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aO5PnU4dhUuzM34e@krikkit>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Oct 14, 2025 at 03:26:53PM +0200, Sabrina Dubroca wrote:
> 2025-10-05, 10:39:46 -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    4b946f6bb7d6 selftests/bpf: Fix realloc size in bpf_get_ad..
> > git tree:       bpf
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13be46e2580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5cd6299ede4d4f70987b
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/f0ef71bdead6/disk-4b946f6b.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/0c8251d5df12/vmlinux-4b946f6b.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/29bad3cdad16/bzImage-4b946f6b.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 __xfrm_state_destroy net/xfrm/xfrm_state.c:800 [inline]
> > WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 xfrm_state_put include/net/xfrm.h:928 [inline]
> > WARNING: CPU: 0 PID: 30386 at net/xfrm/xfrm_state.c:800 xfrm_state_migrate+0x13bc/0x1b10 net/xfrm/xfrm_state.c:2165
> 
> Steffen, this looks like we simply forgot to set XFRM_STATE_DEAD
> before the final put() in the error path of xfrm_state_migrate (and
> xfrm_state_clone_and_setup):
> 
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 9ea1d45b79e3..7ae10fac7b31 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -2074,6 +2074,7 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
>  	return x;
>  
>   error:
> +	x->km.state = XFRM_STATE_DEAD;
>  	xfrm_state_put(x);
>  out:
>  	return NULL;
> @@ -2163,6 +2164,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
>  
>  	return xc;
>  error:
> +	xc->km.state = XFRM_STATE_DEAD;
>  	xfrm_state_put(xc);
>  	return NULL;
>  }
> 
> 
> Does that look reasonable? The state was never add()/insert()'ed, so
> it goes through put()/destroy() without delete() first that would set
> XFRM_STATE_DEAD.

Right. Looks like this is broken since the migrate API exists.

> It also looks like we're missing a xfrm_dev_state_delete if
> xfrm_state_migrate -> xfrm_state_add fails, since
> xfrm_dev_state_delete gets called during __xfrm_state_delete, and this
> new state will only see xfrm_state_put/__xfrm_state_destroy:
> 
> @@ -2159,10 +2159,13 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
>  		xfrm_state_insert(xc);
>  	} else {
>  		if (xfrm_state_add(xc) < 0)
> -			goto error;
> +			goto error_add;
>  	}
>  
>  	return xc;
> +error_add:
> +	if (xuo)
> +		xfrm_dev_state_delete(xc);

This is correct as well. Thanks for catching these!

