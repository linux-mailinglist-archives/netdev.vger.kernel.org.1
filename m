Return-Path: <netdev+bounces-232419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4669DC05A6A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508633B028B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE11127F75C;
	Fri, 24 Oct 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtNoeQp9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD88273D9A
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302724; cv=none; b=aEpSOYYXC68LIF7svifugb329b6hncL2YsItLxYjY4SeFm09cJhn+CKn10qO6gHt9o2l1D9oXotF6/4QwGKUttftfq5vr3+GNp4iiW1sxDRXr760qG9TSA/qVVpTY98RL25MjOzrEagBL+qnE2c/VoabdeIaVpHSMGGOZvYDI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302724; c=relaxed/simple;
	bh=zitpUfd02mHfmWmKbxxXVMFAcuXxYP9GCRpf0oeD/9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHl76Gfyt4vnCbGOGNZ0sP3UdMjwlYlD+L3iFaOj6piSf3YFSYtgPV9nM56AlFEedbZsp72HuDhSAdYTodjNOuqpfk7FMUEixUTJ64nD1o2GnpbXri8t5y+O9i+N7nxoExJ6samqLJh0XIpzjG3NcJ7o8cp5LqR711954Jv105U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HtNoeQp9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42420c7de22so923895f8f.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 03:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761302721; x=1761907521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LzYC4CXNtIhbU33+vNcLU3UwFYwR0NDqLzt3aZXlS8=;
        b=HtNoeQp9JLCTH6rHZfTLnO3p7RnUjvCDk6KwZQYZ4/QbVbWV6WlMXpvXCiEAOsRVbm
         LlXw8hekf3XHIYP2b//FxrTwO5g1Xu8g7v49t10Uzut4M2WCL3Q8TZgdH3X8n39wisQd
         3Au6JfXCk2+cbtBaSYAo54+ujmQn3bCjyWEGNFXbRQcbZ0Afunq9mhN0FZBSc65DmtCV
         IQbbk4ptLbpZroXzLhxN/vDCWGnClKNef1kj5GXR2X58DbbwzWfeAH8QWIa+re86tdfS
         q8a1CknnjTyvy4pJGqRkZFdxx5yK1Vyiam7K5k27AzbBaIusDRHwmPUKQf/N/HHjPpZa
         bybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302721; x=1761907521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LzYC4CXNtIhbU33+vNcLU3UwFYwR0NDqLzt3aZXlS8=;
        b=JwXzg7bHxTm3El3vQs9HUaJ3FVTFNbu8cICKVZt3Em9V0Pbdkm7U0pQVmmMzyx1Q1X
         K6Rm4z7RYd+eDoBN+RvEieXyEP5p8Cx6WxjUOKMHZswbj6tqhtxUn9jAHJ3x7j00/fTK
         ztX8lONa4rJL0JH2mv0Q/0cHWCz593Ax8hiEZ5uP2dFxJnY0VZ55RPTZ5y6jzgmXcK0p
         GYk6R0Qtf40iqRIKfL6fZwg9uhr9LaSndTbLJg2kzAQOcNGdbqHzehGDYkq1Y7CKx+0n
         B0MymRRNWwqEeEJ+waMkC5hTL7fhC3Rr05rrFEH2Upx6ShdQeRCXhMzp09dYi8VkSNTy
         Mzow==
X-Forwarded-Encrypted: i=1; AJvYcCVV1+U1KXYxJ8dAXw3vRIv2cfNh56rKRmCkhKlswqrhDwVaMe4RvEJI0nZHGH/8sjdhvygYiGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8RYSBe+Jfp5sTinsHjKrxxDNKITZNvXIb9Wch/UOETpAuUmH
	LmI3dOyw8qYMcRnPL8MPOZgniRbNlaZXrpS/5sC4RoUCezhMYsg3Y4f9Jgkmpp+S+dY=
X-Gm-Gg: ASbGncuiQ/Reem/5dqEEtez94vG0tXXjpah4wQ5KZFK4MDZ0r4EknGI0OdlMFqLy9+E
	FMGOcNQXdcnI+LHvcW0NbYtUn3BvhS5NX+Mlhk+NVqdwz/Tk4HMbLwTqz53KP0INymhhbbK/gPe
	e6HL/t59S8k4RHvk2F/9/RCXvjmQXsd4AYStsilx8CGtTfOcM2GIGqFE4Zt489JLF8E4YYSAu1s
	Vdh4ZG7TKwh0TU3M3hFdkMWphWt2BEmi7TjVQpRUyIUe4zb2nTsbBdmDHIuRnJSHT2lRWQ2PxOc
	dAQegbPOut+9OLX5ct30lnH4evDS+j3q1C21/luBz3RJ//FOYE+3gYNpET6nIHlGcHUpxlkbNpl
	KW3OslblqhEG0RdhomRQzoLiKQwVD7ZNB3nZBy2QlWFK37THbZd604NkxInnqv8UfHeEk+6ESIJ
	kHtIxj7nuLC4scTRMH
X-Google-Smtp-Source: AGHT+IFndIZtTS7LJDDfqCt6ZeNmFhEZyimvvM4KVVCj0BAZcLMsAD53m+FlpSvkb1XScbIdB5nUsw==
X-Received: by 2002:a05:6000:2888:b0:3ec:dd12:54d3 with SMTP id ffacd0b85a97d-42704d9396fmr20083040f8f.35.1761302721251;
        Fri, 24 Oct 2025 03:45:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429897e75a0sm8916219f8f.5.2025.10.24.03.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:45:20 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:45:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Lizhi Xu <lizhi.xu@windriver.com>, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] netrom: Prevent race conditions between neighbor
 operations
Message-ID: <aPtYvPq12Txu9JCG@stanley.mountain>
References: <aPcp_xemzpDuw-MW@stanley.mountain>
 <20251021083505.3049794-1-lizhi.xu@windriver.com>
 <7232849d-cf15-47e1-9ffb-ed0216358be8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7232849d-cf15-47e1-9ffb-ed0216358be8@redhat.com>

On Thu, Oct 23, 2025 at 01:44:18PM +0200, Paolo Abeni wrote:
> Why reordering the statements as:
> 
> 	if (nr_node->routes[2].neighbour->count == 0 &&
> !nr_node->routes[2].neighbour->locked)
> 		nr_remove_neigh(nr_node->routes[2].neighbour);
> 	nr_neigh_put(nr_node->routes[2].neighbour);
> 
> is not enough?

There are so many unfortunate things like this:

net/netrom/nr_route.c
   243                          /* It must be better than the worst */
   244                          if (quality > nr_node->routes[2].quality) {
   245                                  nr_node->routes[2].neighbour->count--;

++/-- are not atomic.

   246                                  nr_neigh_put(nr_node->routes[2].neighbour);
   247  
   248                                  if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
   249                                          nr_remove_neigh(nr_node->routes[2].neighbour);
   250  
   251                                  nr_node->routes[2].quality   = quality;
   252                                  nr_node->routes[2].obs_count = obs_count;
   253                                  nr_node->routes[2].neighbour = nr_neigh;

This line should come after the next two lines.

   254  
   255                                  nr_neigh_hold(nr_neigh);
   256                                  nr_neigh->count++;
   257                          }

regards,
dan carpenter

