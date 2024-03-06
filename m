Return-Path: <netdev+bounces-78131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16512874290
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D4628255B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B01B95B;
	Wed,  6 Mar 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSdhPhEX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C61B947
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763311; cv=none; b=akgikh4eIY7BqwQnoEu2CvTBdbpVY7Xu7jWRMIo5os3KihzHF9pez7/MP1AUZVj9Ov1DDIwgXX9zfRbF5W8u0sCkNx9F8mS59bQnvhjaha7uwzFs1OFHgJz4wkLanamdH6an9XM0BxSzYo07CpQQ/uJZUGZsBXmVzvT+wSoCqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763311; c=relaxed/simple;
	bh=YhuYY0Xg0Zi/c+DHpgoK9g/mNWHIwIS2jDt4/qNNbBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMVZffQl+BfQUUjZb4QqC8BcEgBWYT4ey9hRWy/KwOMu+oQde+zKX9C9LYcAKnxEtal8mcQ+rJwCk86DIXZj3NWyXhVgrLwybdzK3EliGG2lC4/Q2xLQk67ewnYle/jbkDXK31IuMZpZUKQpx9HyR5LUomOm8X0X6K6mQmcWvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSdhPhEX; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21ffac15528so72157fac.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 14:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709763309; x=1710368109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9nYL0QSTGLvav/qU1CARmYFAx3+BK1/GhFtKVlXsdo=;
        b=OSdhPhEXGrnKcy1TKitu2EDhU1/uCDXVUAXsIlDPCgfqV70aSmBdRxKOtuLQCEZpky
         ixqg/ETNm9XH2nop0hGm5J4Jjr9/pl+sO6quRzzJR9G2zqJfjumLZgv0Jm4fpHTdUNJ2
         j3dSB59w4dsOUTqq0aM6OH9AmPpSbTu3TuHY4YYZ3ibELwubQ9ZrBImkuPT2utp83zH6
         ZM6YAixVP3VmJAwuGejAFVin1nFLGkkIdJdkoYjPP5bieS6phfQphVopXmLX8D+fulyN
         ChwwKEmeujYy/bGm4NV/aoyg/JH6peXL2KMZCSHJKzTq2N7EMDXaYagffR1DZM8I2QOj
         E+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709763309; x=1710368109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9nYL0QSTGLvav/qU1CARmYFAx3+BK1/GhFtKVlXsdo=;
        b=I9DZ1AEIdznVugTp3FC/wX2pY8ZrHVG9mJkQQxpu4I1syXs3MNeRpxKv/l8rtev+9J
         pcp5Zpg7mTtw0SxYIzw7/3s3R+QqgTZI56t3T8SNvO9+gr9MgsgWVFkvvOUcme1t+pkN
         d7qPvtQSOBCyJSgHOG6ZdDcatdTtVQtl8tvW2QQ8yaftJIeU4SwmYhjtW5JmuuklAbYa
         XkD3EjO6rhmX7ChHFXv1nf/7DD67FCdtOH7BcqQefyu6AzF6dK0nMKF0Ljovb7DSliSV
         kSpKwZBl1nDCNfEX7DIK3qKHl40rm8k8IwBe/RQtdRiHqIuGpMxe1YUCXdH+xKvP33KR
         MUTg==
X-Gm-Message-State: AOJu0Yx+C+HkT0K+bPT5pCdZlVkH/VFowDhhmHr5oUFH+AIzaftXlGto
	45Ygedqp7jiP2lFS+NOKyeSrcp8CTVHJUTjJ97Nvz2JpcI0xM+ja9UgEMha8EdWCI9Al7f+qYLu
	XdhD5EE2xDKRG/g9Vi30mo/KW93g=
X-Google-Smtp-Source: AGHT+IHXHaYlwZ7SMGO/tFCqYByg49IscqHRwQ2w4IXtDy33yXrp65z4r5KJJkmhqLYN/hJsRJYb2ESxRSD2fVJJV9c=
X-Received: by 2002:a05:6871:d08d:b0:220:10c3:15f2 with SMTP id
 mw13-20020a056871d08d00b0022010c315f2mr6343347oac.57.1709763308715; Wed, 06
 Mar 2024 14:15:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306125704.63934-1-donald.hunter@gmail.com> <20240306103219.0a2a29e0@kernel.org>
In-Reply-To: <20240306103219.0a2a29e0@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 6 Mar 2024 22:14:57 +0000
Message-ID: <CAD4GDZwf4dBoTgm_fWgyk0JiipidRntqRq9a3q0gVO8i==V-cg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] tools/net/ynl: Add support for nlctrl
 netlink family
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Stanislav Fomichev <sdf@google.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 18:32, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Somewhat incredibly the C seems to work, I tested with this sample:

Wow, above and beyond for writing a sample. Was it ever in any doubt
that it would work ;-)

> // SPDX-License-Identifier: GPL-2.0
> #include <stdio.h>
> #include <string.h>
>
> #include <ynl.h>
>
> #include "nlctrl-user.h"
>
> int main(int argc, char **argv)
> {
>         struct nlctrl_getfamily_list *fams;
>         struct ynl_error yerr;
>         struct ynl_sock *ys;
>         char *name;
>
>         ys = ynl_sock_create(&ynl_nlctrl_family, &yerr);
>         if (!ys) {
>                 fprintf(stderr, "YNL: %s\n", yerr.msg);
>                 return 1;
>         }
>
>         printf("Select family ($name; or 0 = dump): ");
>         scanf("%ms", &name);
>
>         if (!name || !strcmp(name, "0")) {
>                 fams = nlctrl_getfamily_dump(ys);
>                 if (!fams)
>                         goto err_close;
>
>                 ynl_dump_foreach(fams, f)
>                         printf("%d: %s\n", f->family_id, f->family_name);
>                 nlctrl_getfamily_list_free(fams);
>         } else {
>                 struct nlctrl_getfamily_req *req;
>                 struct nlctrl_getfamily_rsp *f;
>
>                 req = nlctrl_getfamily_req_alloc();
>                 nlctrl_getfamily_req_set_family_name(req, name);
>
>                 f = nlctrl_getfamily(ys, req);
>                 nlctrl_getfamily_req_free(req);
>                 if (!f)
>                         goto err_close;
>
>                 printf("%d: %s\n", f->family_id, f->family_name);
>                 nlctrl_getfamily_rsp_free(f);
>         }
>         free(name);
>
>         ynl_sock_destroy(ys);
>         return 0;
>
> err_close:
>         fprintf(stderr, "YNL: %s\n", ys->err.msg);
>         ynl_sock_destroy(ys);
>         return 2;
> }

