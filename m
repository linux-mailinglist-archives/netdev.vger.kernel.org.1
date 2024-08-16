Return-Path: <netdev+bounces-119212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D622B954C49
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F6EEB21008
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCFF1B86C1;
	Fri, 16 Aug 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/4D4kII"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18D85270
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818158; cv=none; b=t/n0ngCqWu0TxFJxTU9Dk47khZ4XxEZdD0VEZOfvzV2CuzRIONFTwZOxepC+hK3kjYLzS/h29Q7TSqKpwn8fssYUhT4ElAGbUhLuOZEaG/UztJA8ecCDcsUsZkCaZpUUvxswgSSz3Hnwm3g59yCKkiOTYzo4PZsdUI54OvigRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818158; c=relaxed/simple;
	bh=ldEfgjSvrlYO+j8A3+5pFp0N+U44pO9DIE3KQwtnbD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OOwQ0+oTLqAvAxKUrf8Z6DWhWxXUS32w4pNHqlJGz7uDfUFQP8yg8pP/lGPg8U2NHr2CfOklW5dMszG2z14JGT4/d/Jgs9GJIwQA8KEnTNTiToAFKmznac+sYzD6OrRv2lihkTOtZOZGGeENapLUMOtXU+mTgnUwxOZrhzfNRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C/4D4kII; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-530e2287825so2048789e87.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723818155; x=1724422955; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jimNm+5PYvpG2rfnGN1p7tnY2o3UaaaVM0INh4uOJaQ=;
        b=C/4D4kII439RfNL7leKh7gn0GtGC+0BNn+1XN59HJJtqjmKVWs5I9+CXLLK2ZBsuji
         lnN/+YI1toBJ5efUnuQ3S30u1FSxxwnKD1RQbjbRQQJaVZr8SEK5KxP7PfCx4SkkHxlr
         eQrN17GSGitHUSxUFZgySO+CF1Ricy4pmVLygxG4DcssHCSKfFTVvb6Bz6Jtb2cTr2uZ
         KYBQIwbU33AfGmvSHrYTaDwATAzNEzEu3d762zGZbKyZpj3WXW+XQ89W7rU2Qj/R8fiE
         x/8xP1CsV30OpjL4E0KT15AD2TE9CELLh/EGFljdAW0NmB8kpiCUsIFW9hwoi+pdXoD+
         sRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723818155; x=1724422955;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jimNm+5PYvpG2rfnGN1p7tnY2o3UaaaVM0INh4uOJaQ=;
        b=PFRBA205Kaxt9jsn7TlRasbLQENf6R/Ra3PWob+wwab/JoOqGe/2HmyJ/7CDd3roxV
         N9n0S19rV+1cUFZ5T1L4WN8j4x0mTRZS4ZFSVeHVN2AxobCBT61gC8VDG7kG3j9gthpq
         KIt1XhpG/ExL3JTnge5cHr6MA7ftpR0jKhOL659m8jX6uuQTdkaiYzvwRkoikP/CSVPt
         wPyTwdOT6eZJrXm4zNcbhiaE61C+p5JjZddBKu/I3gPj6OO4qfTdUoux1hTaQRfVcGXJ
         FEyuBEsVRK7xmdLPUW/zwYrk3o457/6nfS9IWUqgVd+kzukahKCSu8frD8UAqO9QY4mw
         xy3g==
X-Gm-Message-State: AOJu0YybHvxLPfRDOsNXdOlcwfOPh5JcFrJJIenyTUE6DcAKQY8ri+6i
	MevTWRBcoDoH4ajcbRE/K57zMGLVH/Aw0f/mYYHoR1ylnAF2LVLSys9xcNgjeu8=
X-Google-Smtp-Source: AGHT+IF1pWTuwybaNLHVr5Zdz4yRS/+g7KtdPX2Zva/1cwJbhQVkh3l1ev5ywowvpCc7uahneb9YXQ==
X-Received: by 2002:a05:6512:220b:b0:52e:9b92:4999 with SMTP id 2adb3069b0e04-5331c690ce0mr2181620e87.2.1723818154423;
        Fri, 16 Aug 2024 07:22:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897029sm3741479f8f.74.2024.08.16.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:22:33 -0700 (PDT)
Date: Fri, 16 Aug 2024 17:22:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rao Shoaib <rao.shoaib@oracle.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] af_unix: Add OOB support
Message-ID: <44c91443-3ac0-4e67-8a56-57ae9e21d7db@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rao Shoaib,

Commit 314001f0bf92 ("af_unix: Add OOB support") from Aug 1, 2021
(linux-next), leads to the following Smatch static checker warning:

	net/unix/af_unix.c:2718 manage_oob()
	warn: 'skb' was already freed. (line 2699)

net/unix/af_unix.c
    2665 static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
    2666                                   int flags, int copied)
    2667 {
    2668         struct unix_sock *u = unix_sk(sk);
    2669 
    2670         if (!unix_skb_len(skb)) {
    2671                 struct sk_buff *unlinked_skb = NULL;
    2672 
    2673                 spin_lock(&sk->sk_receive_queue.lock);
    2674 
    2675                 if (copied && (!u->oob_skb || skb == u->oob_skb)) {
    2676                         skb = NULL;
    2677                 } else if (flags & MSG_PEEK) {
    2678                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
    2679                 } else {
    2680                         unlinked_skb = skb;
    2681                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
    2682                         __skb_unlink(unlinked_skb, &sk->sk_receive_queue);
    2683                 }
    2684 
    2685                 spin_unlock(&sk->sk_receive_queue.lock);
    2686 
    2687                 consume_skb(unlinked_skb);
    2688         } else {
    2689                 struct sk_buff *unlinked_skb = NULL;
    2690 
    2691                 spin_lock(&sk->sk_receive_queue.lock);
    2692 
    2693                 if (skb == u->oob_skb) {
    2694                         if (copied) {
    2695                                 skb = NULL;
    2696                         } else if (!(flags & MSG_PEEK)) {
    2697                                 if (sock_flag(sk, SOCK_URGINLINE)) {
    2698                                         WRITE_ONCE(u->oob_skb, NULL);
    2699                                         consume_skb(skb);

Why are we returning this freed skb?  It feels like we should return NULL.

    2700                                 } else {
    2701                                         __skb_unlink(skb, &sk->sk_receive_queue);
    2702                                         WRITE_ONCE(u->oob_skb, NULL);
    2703                                         unlinked_skb = skb;
    2704                                         skb = skb_peek(&sk->sk_receive_queue);
    2705                                 }
    2706                         } else if (!sock_flag(sk, SOCK_URGINLINE)) {
    2707                                 skb = skb_peek_next(skb, &sk->sk_receive_queue);
    2708                         }
    2709                 }
    2710 
    2711                 spin_unlock(&sk->sk_receive_queue.lock);
    2712 
    2713                 if (unlinked_skb) {
    2714                         WARN_ON_ONCE(skb_unref(unlinked_skb));
    2715                         kfree_skb(unlinked_skb);
    2716                 }
    2717         }
--> 2718         return skb;
                        ^^^

    2719 }

regards,
dan carpenter

