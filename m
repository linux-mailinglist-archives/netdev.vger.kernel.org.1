Return-Path: <netdev+bounces-119251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B4954F99
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984491C216AF
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B31C0DEB;
	Fri, 16 Aug 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjPC9xBa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5221BC9E6
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828231; cv=none; b=MjDTWAzOYwoEOfFIkN5tSVYHYXW15qtUxQc4AZU1GUwPFuRW4EP7TPHoQH1YPoZZqVIsnaQfBe+v1X1Yo7cKM/UakUnQEwx9+ssY0Hs9AKKKVD9q5T8mS7ufjh1LeAEFzT/LvVM+W9rz9YlStk2WSaNByK2sWULyUUoNt8vY95M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828231; c=relaxed/simple;
	bh=ziGuvox4LSsX/Ds57CNZ3OkFZTl/sUvSSnrwCGpK6o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvCAqxWNgFYvWEBroqRlmP6dHu1KMizgMnLph45I7KQ8fNTO6cmwpxc5V6jddX0/FiHozFtFbhgUSrnEFMSqJSCOSN1F+afq+bTPNYF1kwRvWPIQZyw+Av3GVJIlD85ywC5Brpv/MTtHLBjzo0DJwiA4ncmVphLKVAtT9mJnDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zjPC9xBa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3717de33d58so1278800f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723828227; x=1724433027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6AVRSgnzoaM8QknPBgM47hcdH7a4WFxFCU1qOX2sIrs=;
        b=zjPC9xBaBfITT9iZpg2Q/95CUQfhsDmk9QtleKwhAqsUJ39vvNA8prH5aV4veN36lw
         OU71CVXUqJX1lQHeYYpxdOCkRbY/4JhDA16eSzKIUIGEVvVP8mHUOAgdae3QA6cjpdlh
         2MB4hh8wcBQJ2ROnJ+JW7dkNliiBbjc1HhfWJHj0BPV0H3cUd6ZrfeSBCKXIU9w2brVS
         3Kz53egBFGspG+AhQIM8P6AIXiA8gW/sHmDDtybXlG/lcweeb+MDF4HwNdRbvx3gWwqH
         lLwK+9ZCGulUX6BWwZ0s5O0ElUYNyd4T3UjOr9Sc/LMshIOupxmXWGNKSIncQoFEPX+M
         lUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723828227; x=1724433027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AVRSgnzoaM8QknPBgM47hcdH7a4WFxFCU1qOX2sIrs=;
        b=bQKbKtwbsCOoxYnKtZ0EuKm6sMUPQQhq/GluGwLt8BOoB8DTOLE6Y2xy0OMZpXsIHO
         aAjfMgCQJRVBvdJnYhUg7p5aDlkmhF/Ryw7K+dTU0NBB1GItKMPDzsqrIPCLxsK9/MIS
         w7EZSrI1xukmxEmo8GXsQQWFvItftobP5uxBiJGRK2Qq3mby8n7jQ9hBmTfe+UrZRqQ/
         78oKeLYCpOJGLV3b62BH84NoveWu9pwNT4LsIuSciyQ48HpP9iEzpym73dEciYBibJsf
         ynJbhk/Z0ujs6/b8xS6ziNifWqC5no2TckiBYdgKXYQD6BRiwpiV49m1sYRX9ocDusdu
         irYQ==
X-Gm-Message-State: AOJu0YyteLqq/g4nPTNOjrVqbVF24RzyZybxkgkRBLk9EOAc4eG94Sl8
	9saXv5CNrjdL7FmFUwiRw/IZ62RVDNoyaTQMSxCW+M0IKZBakapgpIb7YHATUwM5XT1vvpnkwmL
	8
X-Google-Smtp-Source: AGHT+IH9gznKn4YGbch+GmzQIMb86IP8LKYgZevR31Tg98OvtXJWeR/NeXyyUbrG6rvQgy6nV15fCg==
X-Received: by 2002:a05:6000:1112:b0:371:728e:d000 with SMTP id ffacd0b85a97d-3719431768fmr2435472f8f.1.1723828227178;
        Fri, 16 Aug 2024 10:10:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650402sm27585925e9.11.2024.08.16.10.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:10:26 -0700 (PDT)
Date: Fri, 16 Aug 2024 20:10:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rao Shoaib <rao.shoaib@oracle.com>
Cc: netdev@vger.kernel.org
Subject: Re: [bug report] af_unix: Add OOB support
Message-ID: <883c86d2-49b0-4d5e-a360-286865890180@stanley.mountain>
References: <44c91443-3ac0-4e67-8a56-57ae9e21d7db@stanley.mountain>
 <6c3c2b2e-4fd4-498c-8347-1a82b0b770a6@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c3c2b2e-4fd4-498c-8347-1a82b0b770a6@oracle.com>

On Fri, Aug 16, 2024 at 09:50:56AM -0700, Rao Shoaib wrote:
> 
> 
> On 8/16/24 07:22, Dan Carpenter wrote:
> > Hello Rao Shoaib,
> > 
> > Commit 314001f0bf92 ("af_unix: Add OOB support") from Aug 1, 2021
> > (linux-next), leads to the following Smatch static checker warning:
> > 
> > 	net/unix/af_unix.c:2718 manage_oob()
> > 	warn: 'skb' was already freed. (line 2699)
> > 
> > net/unix/af_unix.c
> >     2665 static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >     2666                                   int flags, int copied)
> >     2667 {
> >     2668         struct unix_sock *u = unix_sk(sk);
> >     2669 
> >     2670         if (!unix_skb_len(skb)) {
> >     2671                 struct sk_buff *unlinked_skb = NULL;
> >     2672 
> >     2673                 spin_lock(&sk->sk_receive_queue.lock);
> >     2674 
> >     2675                 if (copied && (!u->oob_skb || skb == u->oob_skb)) {
> >     2676                         skb = NULL;
> >     2677                 } else if (flags & MSG_PEEK) {
> >     2678                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
> >     2679                 } else {
> >     2680                         unlinked_skb = skb;
> >     2681                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
> >     2682                         __skb_unlink(unlinked_skb, &sk->sk_receive_queue);
> >     2683                 }
> >     2684 
> >     2685                 spin_unlock(&sk->sk_receive_queue.lock);
> >     2686 
> >     2687                 consume_skb(unlinked_skb);
> >     2688         } else {
> >     2689                 struct sk_buff *unlinked_skb = NULL;
> >     2690 
> >     2691                 spin_lock(&sk->sk_receive_queue.lock);
> >     2692 
> >     2693                 if (skb == u->oob_skb) {
> >     2694                         if (copied) {
> >     2695                                 skb = NULL;
> >     2696                         } else if (!(flags & MSG_PEEK)) {
> >     2697                                 if (sock_flag(sk, SOCK_URGINLINE)) {
> >     2698                                         WRITE_ONCE(u->oob_skb, NULL);
> >     2699                                         consume_skb(skb);
> > 
> > Why are we returning this freed skb?  It feels like we should return NULL.
> 
> Hi Dan,
> 
> manage_oob is called from the following code segment
> 
> #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>                 if (skb) {
>                         skb = manage_oob(skb, sk, flags, copied);
>                         if (!skb && copied) {
>                                 unix_state_unlock(sk);
>                                 break;
>                         }
>                 }
> #endif
> 
> So skb can not be NULL when manage_oob is called. The code that you
> pointed out may free the skb (if the refcnts were incorrect) but skb
> would not be NULL. It seems to me that the checker is incorrect or maybe
> there is a way that skb maybe NULL and I am just not seeing it.
> 
> If you can explain to me how skb can be NULL, I will be happy to fix the
> issue.
> 

No, I was suggesting maybe we *should* return NULL.  The question is why are we
returning a freed skb pointer?

regards,
dan carpenter


> Thanks for reporting.
> 
> Shoaib
>  		
> > 
> >     2700                                 } else {
> >     2701                                         __skb_unlink(skb, &sk->sk_receive_queue);
> >     2702                                         WRITE_ONCE(u->oob_skb, NULL);
> >     2703                                         unlinked_skb = skb;
> >     2704                                         skb = skb_peek(&sk->sk_receive_queue);
> >     2705                                 }
> >     2706                         } else if (!sock_flag(sk, SOCK_URGINLINE)) {
> >     2707                                 skb = skb_peek_next(skb, &sk->sk_receive_queue);
> >     2708                         }
> >     2709                 }
> >     2710 
> >     2711                 spin_unlock(&sk->sk_receive_queue.lock);
> >     2712 
> >     2713                 if (unlinked_skb) {
> >     2714                         WARN_ON_ONCE(skb_unref(unlinked_skb));
> >     2715                         kfree_skb(unlinked_skb);
> >     2716                 }
> >     2717         }
> > --> 2718         return skb;
> >                         ^^^
> > 
> >     2719 }
> > 
> > regards,
> > dan carpenter

