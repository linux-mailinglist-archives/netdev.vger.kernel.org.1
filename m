Return-Path: <netdev+bounces-232660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A10CC07D1D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F18C94E2324
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6B342C81;
	Fri, 24 Oct 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVQmupvK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74151231832
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331927; cv=none; b=NWF7arnK/YzQnPTPjDJfhzEgky9DPdGn6rziaVQZMna2VYHjUI1kIds1Z3pHHHLtmMJYaip+mmGCsTmK8hf3L8rdBJgPM+huNffVqwzSs133LwLdcxWBGog2RPh5eqcKb3MQWIFObxuIQVlswEAKl/rd76UXkvd7JIqVbmQy6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331927; c=relaxed/simple;
	bh=Wz135uwetxCwe/8eH3Kl+AzNgbfF3r35YAD2LnYmJvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upghIhUEkmkdvIYawey+ILd1y9tVZRxHcu07LcfEvyj1Il1CtV2pMIvKWX5w35sORBT0MxGEgWQXqmvJKsnuKuSqlLM9VEPL4bpIGoa+aZi2sHC1x8S3Oivv5vO+zc5tX8jXYuqIqTL/rvU0HKDSALMlhOJTCU045eLUtxexnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVQmupvK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290d4d421f6so22453925ad.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761331924; x=1761936724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPSvA2tqe3+8UGVytFzavc2q7JOKTx1l11r2cyagv24=;
        b=QVQmupvK1/jMSKut4Kkk9hiapnVMZkDTSO65inOKsgynHPl9tB92JjxyiuSlZwiM6Z
         NElfdE8296L5VgvFwuBE286gxaNgsXBE8HwEjckzqmpn5UZlEz2ALzAyxrD8jkosmtcW
         wpLs55cfCe2EvuSRhYKc9KRAi24nKedgpb4tLXaLHjORbBOk5+67kN4/jajlEC5/ZZFb
         skkoWFNinGbrNwW+RYIK5eh47icnLxv7JP7Wmh2rr0qx2UHNG4HVzeij80c4LIqH11wP
         YVyMRCD528BVTRwyd0JBHB9/SG3ybeGqrsUl1DXslLlsgoAxDdHxXdoOhUQTEXw3Bvr6
         xK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331924; x=1761936724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPSvA2tqe3+8UGVytFzavc2q7JOKTx1l11r2cyagv24=;
        b=noFGhVa5iMeTkZjoNMTHZtiPeP/M1I59Ji0bn0zZ1v/S1HWhQHByeJyNiJTFFGggSf
         oDsT6j2qjDnsxrsV5Ve2DbRQ1m994II/SzsRDqxxc1kPUtW858o8ROdWaFOMzOgA8XPC
         VJcGSMpCHaSyxggUEqrMbBzoNkx455pj0FV1K9Yi4h4y4jqWr0c0MISRRmPUBQplgcvc
         IWi8huq2ugjFRnlpW6mg3PUGzwtQ5nK1b7F9+v5JmaaSHXnhMb/kSEIlVOTSIGT2GJUT
         4Qi/npM0SWJ6qpPIYgk0i7CwMPbEoRWk62rmXt8aFxiGfL+KU+Qir3WnCT1XYfNoVVBS
         xOHA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZVC4fNGAKwoE5NZ7xnz6mc9w0I3gPfsreNbugB4S5ZXsUVb2iEONvT8cZ5dfh939IJYdfeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjXGq4s3rIn4sZ1TqyZrf/HmcAqb6x66Zqry8xD842eobtWzC
	rPpotxOKFS6vc0ngbmKmfEyLumTRCmjJ5i+Xv1Ry2VbqL7ItekWrw6A=
X-Gm-Gg: ASbGncuu2331mQT7x7VmrQPpWEtM2EhRs96RtIinKgWONmLjQuRAFzP5QFIh5s1aakT
	lX7EB0gdE5mb39cBpPDRPN0th45I76r/fnCFJnBRCOq8v7UuMM3Flgkce09celOwii4EbCAPWwX
	AyEAuNcLJTRGygp75AJacWghcsdhcfx6wXwbMbAJHNfiVbPIdk1KuDHwdibKdx2drjT8KcVfhma
	uuQezc+d4M8Poi6deS88N3wCXuoO0yY55y1469I/4uqZ9BpBHEb5bkb0YCRznHZE0vyHYChb5Cx
	pNqn0Ah0gccNqdOMk2QyvqXlMEOotCA+Tz1cV7Alm8mRhnAKBdodX+ZJggM8nAUma5LpKxVlJMr
	ClPQSq3i9CLbug7lLvFDAiq54HCvEYkwDL6U4dQtdg3NgVJtsN8WzcX8fwTey0Fi6syQieyVdrI
	9TM3hrbo8e7gMqi7S7mIKiLqkmTmm/WIgHSp09QsEVEvzvhFlByjh/aAihLGPpYapK6KyZQvtlo
	f4QTlgWC7FeGm/vVLAV2HEJWcUdxLLHhoanGxHig/LM8E0bdF0+upaO
X-Google-Smtp-Source: AGHT+IGqWSsq0Vg7wkMd2FZCssMLWr4Rkrrt1nos4O7oKC+6IfLNMi+/H9tWY/uOFIaAlybXBdO1og==
X-Received: by 2002:a17:902:e944:b0:290:a3b9:d4c6 with SMTP id d9443c01a7336-290caf831b6mr375381935ad.36.1761331923437;
        Fri, 24 Oct 2025 11:52:03 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33e223e334fsm9906023a91.8.2025.10.24.11.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:52:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:52:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 8/9] xsk: support generic batch xmit in copy
 mode
Message-ID: <aPvK0pFuBpplxbXX@mini-arch>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-9-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021131209.41491-9-kerneljasonxing@gmail.com>

On 10/21, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> - Move xs->mutex into xsk_generic_xmit to prevent race condition when
>   application manipulates generic_xmit_batch simultaneously.
> - Enable batch xmit eventually.
> 
> Make the whole feature work eventually.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 1fa099653b7d..3741071c68fd 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -891,8 +891,6 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
>  	struct sk_buff *skb;
>  	int err = 0;
>  
> -	mutex_lock(&xs->mutex);
> -
>  	/* Since we dropped the RCU read lock, the socket state might have changed. */
>  	if (unlikely(!xsk_is_bound(xs))) {
>  		err = -ENXIO;
> @@ -982,21 +980,17 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
>  	if (sent_frame)
>  		__xsk_tx_release(xs);
>  
> -	mutex_unlock(&xs->mutex);
>  	return err;
>  }
>  
> -static int __xsk_generic_xmit(struct sock *sk)
> +static int __xsk_generic_xmit(struct xdp_sock *xs)
>  {
> -	struct xdp_sock *xs = xdp_sk(sk);
>  	bool sent_frame = false;
>  	struct xdp_desc desc;
>  	struct sk_buff *skb;
>  	u32 max_batch;
>  	int err = 0;
>  
> -	mutex_lock(&xs->mutex);
> -
>  	/* Since we dropped the RCU read lock, the socket state might have changed. */
>  	if (unlikely(!xsk_is_bound(xs))) {
>  		err = -ENXIO;
> @@ -1071,17 +1065,22 @@ static int __xsk_generic_xmit(struct sock *sk)
>  	if (sent_frame)
>  		__xsk_tx_release(xs);
>  
> -	mutex_unlock(&xs->mutex);
>  	return err;
>  }
>  
>  static int xsk_generic_xmit(struct sock *sk)
>  {
> +	struct xdp_sock *xs = xdp_sk(sk);
>  	int ret;
>  
>  	/* Drop the RCU lock since the SKB path might sleep. */
>  	rcu_read_unlock();
> -	ret = __xsk_generic_xmit(sk);
> +	mutex_lock(&xs->mutex);
> +	if (xs->batch.generic_xmit_batch)
> +		ret = __xsk_generic_xmit_batch(xs);
> +	else
> +		ret = __xsk_generic_xmit(xs);

What's the point of keeping __xsk_generic_xmit? Can we have batch=1 by
default and always use __xsk_generic_xmit_batch?

