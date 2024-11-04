Return-Path: <netdev+bounces-141635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85909BBD73
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C071F22FBA
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230218622;
	Mon,  4 Nov 2024 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/cW+U8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54E1CB9F1
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745938; cv=none; b=TygTdoZ6VPVVIh4bpz7R5L++P3pK2tO2zQgK9CTevUkRAqzhOq+pejyQWSo/rWPelz6W6rh8O63mmvbgIMhqe4bwdqfdZfMaFUsMqc6xaqh+OcxDmO808ozVZbnBv8+GwIYGOITdn1AcL4Hs6y7TZMyX0SdCqtO2yoiUokKix7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745938; c=relaxed/simple;
	bh=hIDdK68oZDHF6AOg2BrhRsl6CUDpF1j+r+a5/O7rTPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ8lbTsmpJ4Uj2ABctdjw88npHOz62aZP7/pJ+hM+DuXom+B7Zy5iyefOL7lnDEoNJstjwPSo3CAxfOqGn5RCm4fQmx7U1ccrke2PF3auMn3Te2au0Vx9fCmtmp7Y5ZV9z142yusoNoo8qU/4NdUxPGr1WVcCdPlJ8g2oclonbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/cW+U8Z; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso3577243b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730745936; x=1731350736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1kvRNmJD5kG8Mwv5Sy0Gd42DT9y0nJpCYMoFJ2FQpE=;
        b=c/cW+U8Zv2+iKaWLhls0H2WsQrNBoNlmPZtc4LkODlyeSr2w9jECuW00mTciY0wV6G
         /iwQd4SCWx0hdqm6qE1PlKUvnLNHA19hU1Kc6xo2EQR610mXjWy5/0gjImK/zGBFHGnI
         tJwSWayKS4ZDibfFDgSzzodHuqVJwJQX+/JUWS3gXcl979nCnbbhPwA9EmQrFA8kjCHJ
         O2/MdyCSutgbXvzpgSyxJogZBUQgyuExqVfX078X/3A8mNOiMsV44luv7fuvxSbZPpEE
         SFg+Xjm5I2pcH7KYqg6PhB4oIssHCFZ2qMitvJyycDKyTISYIWwNVj7zJLabIHxm0TZi
         rLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730745936; x=1731350736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1kvRNmJD5kG8Mwv5Sy0Gd42DT9y0nJpCYMoFJ2FQpE=;
        b=C1DKYqv4FQIRncX1qQS28Q9etrUGCAWHS7Rep6XVahbbzW2MInjikSf1LVc4kBD/ly
         E8rgBz7sy7UCMKboMCi8EUN9VuQ7dFogtENdOp4BhrC2rkno5w24/6NrT5gQKzkIMJ3H
         5J9mhR6wo298aaL7AxvcHsTpOdQFml5qKUcAt8deh0cvRNJ5wG2tIVL8hyR29NjlypqU
         VVJUcditFZQiFuDJqGdkHGIcKPMmEIXacW91YUVGHCD+RXx6d+IsqfqyaGgRXCTZ7t5t
         W8FViJJLKkGQOUEOrtRnDpZSxQhSXME6hNgJnDp+KaeBegWAR5nmstghfd2OqwKiYl6J
         Wk8w==
X-Gm-Message-State: AOJu0YxdjwjWaXk6gn1f2R/XgrLVkHdBmukt3MRnAmowGcs4Sg9e3Ndi
	4HX4nBxxIE/AG+6WYmm99idc4Faim+TNImD0vppmOkRIUzC9IR0=
X-Google-Smtp-Source: AGHT+IFMGVmPh536BH7N9JOttisHQmHfXDLIFFqFoLIdRw+74U+eOIB9J64Jdqbq2flwGk1djc+J5Q==
X-Received: by 2002:a05:6a00:1d14:b0:71e:6f09:c0a8 with SMTP id d2e1a72fcca58-720c97f58e4mr25754533b3a.10.1730745935697;
        Mon, 04 Nov 2024 10:45:35 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e5717sm7860359b3a.54.2024.11.04.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:45:35 -0800 (PST)
Date: Mon, 4 Nov 2024 10:45:34 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] netlink: specs: Add a spec for FIB rule
 management
Message-ID: <ZykWTs9a3EqJ3nz5@mini-arch>
References: <20241104165352.19696-1-donald.hunter@gmail.com>
 <20241104165352.19696-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104165352.19696-3-donald.hunter@gmail.com>

On 11/04, Donald Hunter wrote:
> Add a YNL spec for FIB rules:
> 
> ./tools/net/ynl/cli.py \
>     --spec Documentation/netlink/specs/rt_rule.yaml \
>     --dump getrule --json '{"family": 2}'
> 
> [{'action': 'to-tbl',
>   'dst-len': 0,
>   'family': 2,
>   'flags': 0,
>   'protocol': 2,
>   'src-len': 0,
>   'suppress-prefixlen': '0xffffffff',
>   'table': 255,
>   'tos': 0},
>   ... ]
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/netlink/specs/rt_rule.yaml | 240 +++++++++++++++++++++++
>  1 file changed, 240 insertions(+)
>  create mode 100644 Documentation/netlink/specs/rt_rule.yaml
> 
> diff --git a/Documentation/netlink/specs/rt_rule.yaml b/Documentation/netlink/specs/rt_rule.yaml
> new file mode 100644
> index 000000000000..736bcdb25738
> --- /dev/null
> +++ b/Documentation/netlink/specs/rt_rule.yaml
> @@ -0,0 +1,240 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +
> +name: rt-rule
> +protocol: netlink-raw
> +protonum: 0
> +
> +doc:
> +  FIB rule management over rtnetlink.
> +
> +definitions:
> +  -
> +    name: rtgenmsg
> +    type: struct
> +    members:
> +      -
> +        name: family
> +        type: u8
> +      -
> +        name: pad
> +        type: pad
> +        len: 3
> +  -
> +    name: fib-rule-hdr
> +    type: struct
> +    members:
> +      -
> +        name: family
> +        type: u8
> +      -
> +        name: dst-len
> +        type: u8
> +      -
> +        name: src-len
> +        type: u8
> +      -
> +        name: tos
> +        type: u8
> +      -
> +        name: table
> +        type: u8
> +      -
> +        name: res1
> +        type: pad
> +        len: 1
> +      -
> +        name: res2
> +        type: pad
> +        len: 1
> +      -
> +        name: action
> +        type: u8
> +        enum: fr-act
> +      -
> +        name: flags
> +        type: u32
> +  -
> +    name: fr-act
> +    type: enum
> +    entries:
> +      - unspec
> +      - to-tbl
> +      - goto
> +      - nop
> +      - res3
> +      - res4
> +      - blackhole
> +      - unreachable
> +      - prohibit
> +  -
> +    name: fib-rule-port-range
> +    type: struct
> +    members:
> +      -
> +        name: start
> +        type: u16
> +      -
> +        name: end
> +        type: u16
> +  -

[..]

> +    name: fib-rule-uid-range
> +    type: struct
> +    members:
> +      -
> +        name: start
> +        type: u16
> +      -
> +        name: end
> +        type: u16

Should be u32?

struct fib_rule_uid_range {
        __u32           start;
        __u32           end;
};

Otherwise, both patches look good:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

