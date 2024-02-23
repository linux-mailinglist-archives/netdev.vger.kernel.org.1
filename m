Return-Path: <netdev+bounces-74407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 613388612C3
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 14:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C90B21277
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBBD7EEF6;
	Fri, 23 Feb 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="TMYvSRZY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2F7C0B7
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695181; cv=none; b=ZLGc/uvo26QQ3vm52nX61esJkKz9Nav+vBor+itxmk3l+lGPtPdSSATyRUxZUtrTorEgBDe7jx1AYbFUH3szymHrHHlbvRQnde4CUraw5bd90+0NdzHPWE1zQsEwuO0ImNxfTRu3NMtc4TUr5yCuqDGS55honpMiGNov9GxKL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695181; c=relaxed/simple;
	bh=TYj0vsS8kOQ9VkVUUuvlQ3YC0KNiHKxLnrWWeRg9H64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K++b9yf5L8gRiCZtizq7m9fQru/KeHRUP9c7hX0MOMOlQwRktJFjahwyaZSix9be86MIjsDFzIUUJimGCyOt5YnH8LI8KoNvngMx7aP/45kBzdqaM76NVFz+pUJXETVtB75tS+FvUWDOGLavr4PHtnbxnnyQj6x9IlS/kJPNfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=TMYvSRZY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607bfa4c913so9015677b3.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708695179; x=1709299979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEPvYmBor7byGESiLhAdXBTErHJXqPd+arW5WsPf8DA=;
        b=TMYvSRZY6dW+6IJ3kLk8Qrqp+trps+k2F8lloQ/h3bLLc80d5rOm1WhY3pT2xqqkW6
         YZo+Z/ljx5Ei6g53/3qKThgKVbZECHf2ePD6AlLHtqFRnzKrJOApO6S5WH0Wa3eARcU6
         /DxBdr8INZYDW/5UgY65bqJowjlITfDwWhSgYQJq2OTSxraJpv+r7VoQdSOITTjmT+qM
         GV0Pe8DWyfhDW7w51WUMIiVADVMz4j1VAEdJcQWArTMuPbVqhrMfH39OC25y30mRLPRi
         n/c9DbQUTvKpsg/Lx0AlizRBX3ev4rPfFDluhlTRhsi+cy36kOksU49pZjhVIWevHMrY
         T/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695179; x=1709299979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEPvYmBor7byGESiLhAdXBTErHJXqPd+arW5WsPf8DA=;
        b=XktC0WCFmLrwMQ6tUqluFMZZtVk3/yWoeYK9cnLLd9dwv4nTQM6VX3qeseMS09JwLk
         pLRn1p4RvbKvkml0lZBIdlb8Vh05Dm7c+0nwINmzo/CB7Q77lklyERtj1BLrkaYaA6DC
         OKhVkPff9LVc1mIzdhQInltt+RZmhYcv70wS9eRZVJCLYje0zV+I7RAHAx1kCvUFC5f1
         reoNpK3XQeTxyknRq/PG5htj0QXmAGVPJ1C52x7iY5gPohYIcdbhsXqJ8GN/TjS6BP9v
         x6w/aAPI4W7fJ0/ipYj7AWKkiwmINx/YfmyNJUXQjEQZfBjKVhOJuJd2zTGjK8VKkmrn
         9tfw==
X-Forwarded-Encrypted: i=1; AJvYcCX45QsIXrrX3yvzdzBXsFo7D9GlbWC6glaeSmYgUYGvAxRaKsNoIB5ghkdp2RfR9G2r3TPKrgG97DniHCgie1emLVbq4JWj
X-Gm-Message-State: AOJu0YwdR3Qgd9/qhU06cdBJIgoqOYeEwV40ANYXq1PCchDxtUbv6Nel
	uE7NLv7m27pRJPd8NH//iMDddSgWaTdiPdteV90YpE0TEem3xxs/Q9DpQl9nG2Me0Y2IUZ7tBNJ
	Vr/e0x1IevAvx7tT/XWrheEG6UOLwvwNXDSjC
X-Google-Smtp-Source: AGHT+IFItDOZckGBT5oG5831PeGU0D8YWbuGaeqZwC680eoJ2FbXg7JKWd2Rugkh46Mynyke4KvooxJ5O3OWn4WfBds=
X-Received: by 2002:a0d:d68e:0:b0:607:a0ab:c238 with SMTP id
 y136-20020a0dd68e000000b00607a0abc238mr2174482ywd.8.1708695178933; Fri, 23
 Feb 2024 05:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
 <20240222184045.478a8986@kernel.org> <ZdhqhKbly60La_4h@nanopsycho>
 <b4ed432e-6e76-8f1b-c5ea-8f19ba610ef3@gmail.com> <ZdiOHpbYB3Ebwub5@nanopsycho>
 <375ff6ca-4155-bfd9-24f2-bd6a2171f6bf@gmail.com>
In-Reply-To: <375ff6ca-4155-bfd9-24f2-bd6a2171f6bf@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Feb 2024 08:32:47 -0500
Message-ID: <CAM0EoMkdsFTuJ-mfqBUKZbvpAzex8ws9jcrPEzTO1iUnaWOPZQ@mail.gmail.com>
Subject: Re: [RFC]: raw packet filtering via tc-flower
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Ahmed Zaki <ahmed.zaki@intel.com>, stephen@networkplumber.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, corbet@lwn.net, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	"Chittim, Madhu" <madhu.chittim@intel.com>, 
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, amritha.nambiar@intel.com, 
	Jan Sokolowski <jan.sokolowski@intel.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:36=E2=80=AFAM Edward Cree <ecree.xilinx@gmail.com=
> wrote:
>
> On 23/02/2024 12:22, Jiri Pirko wrote:
> > Nope, the extension of dissector would be clean, one timer. Just add
> > support for offset+len based dissection.
>
> ... until someone else comes along with another kind of filtering and
>  wants _that_ in flower for the same reasons.
>
> >> How about a new classifier that just does this raw matching?
> >
> > That's u32 basically, isn't it?
>
> Well, u32 has all the extra complications around hashtables, links,
>  permoff... I guess you could have helpers in the kernel to stitch
>  'const' u32 filters into raw matches for drivers that only offload
>  that and reject anything else; and tc userspace could have syntactic
>  sugar to transform Ahmed's offset/pattern/mask into the appropriate
>  u32 matches under the hood.

u32 has a DSL that deals with parsing as well, which includes dealing
with variable packet offsets etc. That is a necessary ingredient if
you want to do pragmatic parsing (example how do you point to TCP
ports if the IP header has options etc).
This flower extension, if it wants to do something equivalent, would
have to adopt some of that language.
For the record, I am not against this being part of flower i just dont
think it's a simple offset/value/mask. u32 for example decided that it
will work with fixed 4 byte lengths to simplify, etc..
I wouldnt trust user space to do the right thing either otherwise
syzkaller will be feasting on this ... I empathise that using flower
will impose an operational challenge of having to use two classifiers
(but I want to point out that it already does offloads).

cheers,
jamal

