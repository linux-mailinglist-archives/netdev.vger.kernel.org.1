Return-Path: <netdev+bounces-99262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B688D43E5
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55F3B219FC
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F241BF3A;
	Thu, 30 May 2024 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfdYpuVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED11BF31
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037801; cv=none; b=kgwr3AeCbxb+gsj4RhAyOIDm58PryWesc+J77cSljQQiT28D+qOPrH3AT/xiDv2KFRbwDLy7HpvJ+oK9J8SxcbsNqgYG4y8ALbjiYZQPJ0r9+7I7ZUv67bpUAfA6hZQP2hbKOFEMLNWsaRnfz57A7cwgc2TKyubOE/diMGTEzTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037801; c=relaxed/simple;
	bh=Z+hpQdvcvQ9PESIfkNmywsqqDksZLtzjGGDpZiW42vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odE+JcupHpS78joKr+3yzWEzbKDcnZNq2JG3oBQRkvIfjs/jxTfE5mXi4gYkFnR1Y/ruPQDUyPz0byQEkb1xHXtDJBtwXAQ7x7mF3oQuqkCkmg5RGMGh8LodPpGRVxpQYT2m7S+xybLvnJXVQ9VrI9S4XD9MMXZawM9CayPRNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfdYpuVC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a62ef52e837so25124466b.3
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 19:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717037798; x=1717642598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgG9KFxtFHpn0FJLrIqs009lGKnYPtujpapw5yhLlNg=;
        b=LfdYpuVCWj+ugCponzfGNvrlL8dLPwOMtnhFN7xDFSgIMkuvVFNi1XYSPWjFb3HdSW
         peYGpz9mViXGokYev83g5RwwfreoBNU9iCG4ErFM2IA6vfkGmPivPWf9DPsretbwe47t
         OlKqb36ZPC/AjE1Y0eppj7G58cETPVciTuqjT5s1h1Qs4UJdYQFCsYTtNOa17+cKnBtl
         xdaRAz7wn2hYBBX2eTYj1kQd+Zi/p2HMxS/kp0nIDjCaLULm2/XrGeXKXX1ru1HOAPRd
         T9kNs9xoNFBgstA6l9hWbzfb78vzpKbiZwdrhq5FM71O7738EgmdpXkk4q8Uj1rZtYqN
         5T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717037798; x=1717642598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgG9KFxtFHpn0FJLrIqs009lGKnYPtujpapw5yhLlNg=;
        b=GbXUViJsaaLmR14nr8fjnceSd5o3nxVspn2EvKDdO3TATrMkxxlixOPuwS9U30TK08
         mipWudqCSwOsTmrR4ysbaxREBYsyKhjE+LCaiwfwAXcI2Upc5zgp3SIphgqwF63YrVZ6
         SEY+gZhpESO37G81gNitq21gjGJOqqUeDEZPTcD1qvbaciC6naJBgcnxYTNjdI9jOMlB
         OdXPFLGQPesGN4tsuW9aezK6anrcY5VCKa13I/18jnMsWB40S6odkdZTbWTbmGbQLojx
         uFYdMFV4ByG9mXsFfrbTkMfdDGKv9e8yMXwN0MW5mHIaWenNM5HpDj2oFGoR/kK+BiOH
         CVSg==
X-Forwarded-Encrypted: i=1; AJvYcCWghJ7aL4llcAFBT9j4+DWny3rUjTyznP+R7zFtdCjN7kSFefus/tH/MQj7c+LV1bHOV2w5KwR7OW3JwpVjBhF6RWcOCCt7
X-Gm-Message-State: AOJu0YyJTKwfwR9zeBOCGkzKaBdEeSDjKSis8Ffh3oEXT8JSjn6cf5IZ
	OpDnoWR3+cXlT1NWkUr+f2FipK6wfPc4zc11Cs6Or2QNJ95CLOUCcFtr5cnHShkY/gfyCSBFMKj
	1w//BB4CfArOW1ZXzzYqQxulRalkuWQ==
X-Google-Smtp-Source: AGHT+IHQF+RkyeSRackTuszgIg0R1vFBAciqdFhPR4zxN77fxbE53Y0suD9mQY1jLpHph9mZh44MA/LUiGgv8tb+J3U=
X-Received: by 2002:a17:907:9252:b0:a5c:fe8e:cf6f with SMTP id
 a640c23a62f3a-a65e90e85d2mr47461366b.56.1717037798409; Wed, 29 May 2024
 19:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418073603.99336-2-kerneljasonxing@gmail.com>
 <20240529203421.2432481-1-jsperbeck@google.com> <CANn89i+rAbZwRR6Lor1f7PFFzQiajFx6a00sehmu4B96KqVhSw@mail.gmail.com>
In-Reply-To: <CANn89i+rAbZwRR6Lor1f7PFFzQiajFx6a00sehmu4B96KqVhSw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 30 May 2024 10:56:01 +0800
Message-ID: <CAL+tcoCEJDrSS14MFVtKe80HHZ7LkBeYwZ2tUp_0yzCZ8SiPEQ@mail.gmail.com>
Subject: Re: compile error in set_rps_cpu() without CONFIG_RFS_ACCEL?
To: Eric Dumazet <edumazet@google.com>
Cc: John Sperbeck <jsperbeck@google.com>, davem@davemloft.net, horms@kernel.org, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 4:45=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, May 29, 2024 at 10:34=E2=80=AFPM John Sperbeck <jsperbeck@google.=
com> wrote:
> >
> > If CONFIG_RFS_ACCEL is off, then I think there will be a compile error =
with this change, since 'head' is used, but no longer defined.
>
> I assume you are speaking of this commit ?
>
> commit 84b6823cd96b38c40b3b30beabbfa48d92990e1a
> Author: Jason Xing <kernelxing@tencent.com>
> Date:   Thu Apr 18 15:36:01 2024 +0800
>
>     net: rps: protect last_qtail with rps_input_queue_tail_save() helper

Yes, I will fix it soon.

Thanks,
Jason

