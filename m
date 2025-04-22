Return-Path: <netdev+bounces-184807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD7A97428
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E4417FC30
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489162918D0;
	Tue, 22 Apr 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Xwh97PZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D181F0E39
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345005; cv=none; b=YpFMIbDipU0XL2tAU8fx9lmClQ2HDNQiyALxHzsgK7FgqJcAC/2n3nF5J6IRWjwZ9tILPCDdjA4LxSchj87FE+JkelJGBZjTGqektESR+YCcQFoiVVfL7Oa2YZRsC3VsTtT7c7bBZ38J2NNiiz1t+gdt4DB/JoQ10VaSZ/oN+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345005; c=relaxed/simple;
	bh=3+aI91T8njP9jH2i655h+MWTIttIKFogzim/bJ8Fn0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4UKFL5C4q4IMwlLOQMH26b3Gb5zsGEzvTwdrSkHie4KyfPNnON6GT8Xb4Uj59iZhsuvQmNbTf3r47cv6pK01+XNSYlAOseZG0tdcPdkM8MlNVjoiXJ2yILnDEhc+XbngPZz1wVOjwD76bkZV4kdbglSuHMoqNwx7pRO1NUYsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Xwh97PZ0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c57f2f5a1bso55997485a.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745345002; x=1745949802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32ZdXmTovN0OSD2r5D1TaWpbCe6i2haD+JASg5H9130=;
        b=Xwh97PZ0Spffq3Zqf/tQnF1bH1u5MrXgXugtGy2epl5cmz7+kvg1MWKcpMMPVqHDyd
         ZVWWMRexU0eWLBhItqx148Uw24WZf+fdEkOSTJRxX/tZxwiGAID1gNM2aU4oThQKUokG
         sXZCiy70ve0WORJ4GTItjAvj1c25L0tWEkCHlrVAXqeEcdksMoVlM0fkklAjK6JpM2B0
         uAHJcQgijnhTzrAC+p9n6DvZL+gI2AXvupDYeZwdjyiLEFR6MbuiuPfKzRDvWQc1aaRq
         ZCC+zbRKnqpNrktJIvNysWttkWTZp7aIWrq1f/AO+XadJElOueBnFxGL81QyyyiN2CSS
         SdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745345002; x=1745949802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32ZdXmTovN0OSD2r5D1TaWpbCe6i2haD+JASg5H9130=;
        b=SfzG1utqFNDJgY5V+Vu4SX2Oz7KeeWUPPj2DQV8NVBK+jxEgDnCRxPBJVKXA8BKtUL
         gc6ffvYcPaz56NAhnOi5o6dDFoiUk15pF+K7WTVrbvwiG230TyYXc+FR4UfTGGa2ckO8
         nwOc40U0vza8H/rkHT8b1VC8fjzVMOG8pM09eEnZwBM3H8ylo34dODbxf9ZBDFeEImqu
         koPAxrpkf08eTMXG93YsHFCZbP6A7Z/YVypSV5AQxacFS5nGG2kmZtubIITQ6d5bqzxa
         7Wri/QzCNN10LH394z/zjM3dyfxedLioUC6Y+UvvvGYvIdSUdbpUljpwsUEmNbLaGiYx
         DqNg==
X-Forwarded-Encrypted: i=1; AJvYcCW9kVxZJcYZApLZgaLPvxEfKYlc0Vxu7i54oilHWym5HrR8w8+q8gMEi95K4uM2BTiR1kbIhbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQwO9z96mfvQhxHb/oKquIb9sdeJFmxT4thT5+alND7I0O5U+
	Mbstpat8YZoEyENQSztWIVYiTFLRyFsecwd+yhn5PDBEqMAgfa1uyrhgfL5fLhGJRP0JBqYZ57a
	VHYZfnIH0Uy3YHmDljC1Hv3U/OnEYhzz41VZlUA==
X-Gm-Gg: ASbGnctyAlOElaF9XQIwcXm6kPydbIS53wK7PRGTve2qWQacdg8By+9BVnmH0+u/rDz
	5gnQ6r3ToL3qP9/baWyBvLChGRLqCvr1XTC8QdmlWLD6zkMd2P1J2ZZbWA6SG4y5IBX06/BuFja
	Ma8g8KW8vrk6cAWLfaN8ZKyvZH9ND01TLDPPV0p0CU1Vo+smQoK/v8
X-Google-Smtp-Source: AGHT+IHn2+ubFPPZO34byhkuVufTiiOQJVnr2PNFIuBegB8EtnRTBKAh4BuNCHk4G309qdx16jaZBXdKHcwpWOin4bY=
X-Received: by 2002:a05:620a:4496:b0:7c0:a898:92fd with SMTP id
 af79cd13be357-7c92805f944mr950134585a.13.1745345002485; Tue, 22 Apr 2025
 11:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419155804.2337261-1-jordan@jrife.io> <20250419155804.2337261-5-jordan@jrife.io>
 <11f8a2b3-ad4d-4e59-b537-61e1381de692@linux.dev>
In-Reply-To: <11f8a2b3-ad4d-4e59-b537-61e1381de692@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Tue, 22 Apr 2025 11:03:11 -0700
X-Gm-Features: ATxdqUG3eH9xhuX1I8fAQAnh5CCetq4Fs34CLFN_M_Qn5KnOUFHSZ4LNCwQ-22g
Message-ID: <CABi4-ogRXQGc7ucKj=jp1AtNprZhn55g+TGhbYnfroMgZ+gVwQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 4/6] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 21, 2025 at 08:47:51PM -0700, Martin KaFai Lau wrote:
> On 4/19/25 8:58 AM, Jordan Rife wrote:
> >   static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
> >   {
> > -   while (iter->cur_sk < iter->end_sk)
> > -           sock_put(iter->batch[iter->cur_sk++].sock);
> > +   union bpf_udp_iter_batch_item *item;
> > +   unsigned int cur_sk = iter->cur_sk;
> > +   __u64 cookie;
> > +
> > +   /* Remember the cookies of the sockets we haven't seen yet, so we can
> > +    * pick up where we left off next time around.
> > +    */
> > +   while (cur_sk < iter->end_sk) {
> > +           item = &iter->batch[cur_sk++];
> > +           cookie = __sock_gen_cookie(item->sock);
>
> This can be called in the start/stop which is preemptible. I suspect this
> should be sock_gen_cookie instead of __sock_gen_cookie. gen_cookie_next() is
> using this_cpu_ptr.

Good point, I will change this.


Jordan

