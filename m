Return-Path: <netdev+bounces-239176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D885AC65085
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 927A028FCC
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339532C0F7F;
	Mon, 17 Nov 2025 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X24Peyfv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E6F2C032E
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395547; cv=none; b=bwjLWZF246ETLNJb6iWS7vcDfzqfu/WIkBE9DigQ3Bo9tb5ijLHm5ya4R8zrMviTiwPsxXQLzaQdWQ8SVgWDCIDlIGuU/ZK8X1RA0hQ1UjKjvVsajOUdlUrYZ+eByBRw6U+9/iXtBYvWf51gS/6syjgbfOLGqQvwLvSghRy8i4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395547; c=relaxed/simple;
	bh=UXuVTbFZfxhi/CrUJ0m3gOEFVfhuQjoRzNtauAvd7JQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=FhhHm342L8TLC1yrMiaSoZICRbd3R0doJoTNguBX+O9XVgR/F9KhjIdui+zb1CFkLJ66fXmchjVV40OItONQoJCNMvXAcV6lFmY7drB5FDt0PfjaXhTXr1btypRkNekkiQwlI7BG+Q2Ng+ab5jQRial/KrhFdhIHgy8peC3KfNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X24Peyfv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso22794475e9.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 08:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763395543; x=1764000343; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv25gH3/0ppvFW0ahX017ugBnCLfGg5eMQGqgnwTcyQ=;
        b=X24PeyfvRZp2RguBNMgmmF+dVokStvtag656iu8St9CqCe79eMN5BaHNgrT1kEz0Re
         YtoMq8JQHOv8s5E9ywpCAedbwzVzfQxcNEVrx/0w+QYl2LW11yiD/BlHJWW/D+KyvbG+
         6iKtcgcjMnNLNnuQUw1VLrLPSDo1VGCCrdR8jLl6/Cx3Z//Ef4dE/yENUSurAuVs5bBR
         odXsnGPqSFdpxiXp0nx6KSURVdV3JWRwZeV9TI5buLjD8DRVC04CIZLa+GpnoCkk3OaE
         Nr4p856KEqm+xhsxW2jNGF4OMj6Th6wrIvrnA6vBR8lJvUiUaRoSm+TFMOhZ+I8fLWIV
         Gqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395543; x=1764000343;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dv25gH3/0ppvFW0ahX017ugBnCLfGg5eMQGqgnwTcyQ=;
        b=WGKuJFgSBn0RKscEuKID67TZwnHespsqa9jCTHGz3tFlFA036lgwZr5DWjcjE+bYlX
         LABxr4thIff4E8ub37YsbmEq/Cmdqq14E4Jqc6CCRIo27mW9P5Fp+2wsz7n0+Y+YBMhU
         5gfblswMs1YSFxIEkN2VMch5l4KZwYsY65TuDyuGTkTwhNo/N4/TALzMxyAQeH6rna7h
         CeKGMIMOiNaJs35qlnBGlqHbwG81fxLsBKZHESYEPraU5iH8LJ8Yr6uqFWY/vbqFmtSY
         pa9epAGPRhiIgldoxwrVwGPHrAApaupaeD4st4SMQkYUGdLsByI+nx1xrLLqa+bTQpzf
         7VBw==
X-Forwarded-Encrypted: i=1; AJvYcCWSTdvDH5m6SDSAheySXEnqngZnYJQgr0FdbZfvCdHT5ehEUvWmFW46KGhFXjq7QhAcu4KXslI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/l2dFjWqebDIeZHtSSaa+DVaiFrd9gO/I1JZsPwVPJF1YEdRN
	7BZrXVdgSO2R+e+v1i40PCfVg21zA4pryQP77rMZi+IU658IQibJUgnQ
X-Gm-Gg: ASbGncuaNzLh1GuxqVVxd+G4IDqWvJn5fkL34KEuS8okaHgTGh4DyaFsV8wmcoU7ELI
	cK7jabX1xya+A58A6P1tsC8XCf/s3ulhSiLc3NHI427TQ8cRuKQmS8BMlnTOn9Tlaz+BQbYgtvP
	gQu9hzRcYog9GsvTGjSKFNeUjb0YSMllG4n33qxEvtMwUv7fFM2qzI8QDZs18mw0AvuufW4wpWJ
	bc8ESeFoMD/baqYKViVvLbHY7ZJ29C2o14Jw4QLlDQuKmx9ZLX89bpZ5LlFQd7a5uiGtBaUWdpc
	IxAVlg9p5xXwdGOwo4tcG5xktz6bmaCdV5bcbwLlFl3nV5IqH6DB62oKX/KEFOuhxIaMZCoJAGH
	PZ1fd/jLic3hP7r+pQx8QEzcZJ5mEBPWr7+G4XX2oWp3MguCndwboYsa2yorpwuqq9yM8FsP1Pg
	fCkf4W7REwIrAhJkEOErJVJqdnVS/X1vi4Bw==
X-Google-Smtp-Source: AGHT+IFjKArWkw1DSxq8VyVfr3BAgiXDtfD7+MsJ0RaIGRQ1j4scrOis/SC3f5RBEf1d1A5CQWt8Rw==
X-Received: by 2002:a05:600c:8b4b:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-4778fe50df1mr117952345e9.2.1763395543365;
        Mon, 17 Nov 2025 08:05:43 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7408:290d:f7fc:41bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47796a8a695sm152861485e9.13.2025.11.17.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:05:42 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  <netdev@vger.kernel.org>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  <bpf@vger.kernel.org>,  Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option
 to show operation attributes
In-Reply-To: <20251116192845.1693119-2-gal@nvidia.com>
Date: Mon, 17 Nov 2025 15:56:17 +0000
Message-ID: <m2seecmz4u.fsf@gmail.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-2-gal@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gal Pressman <gal@nvidia.com> writes:

> Add a --list-attrs option to the YNL CLI that displays information about
> netlink operations, including request and reply attributes.
> This eliminates the need to manually inspect YAML spec files to
> determine the JSON structure required for operations, or understand the
> structure of the reply.

Thanks for the contribution, it's been on my wishlist for a while.

[...]

> +    def print_attr_list(attr_names, attr_set):
> +        """Print a list of attributes with their types and documentation."""
> +        for attr_name in attr_names:
> +            if attr_name in attr_set.attrs:
> +                attr = attr_set.attrs[attr_name]
> +                attr_info = f'  - {attr_name}: {attr.type}'
> +                if 'enum' in attr.yaml:
> +                    attr_info += f" (enum: {attr.yaml['enum']})"
> +                if attr.yaml.get('doc'):
> +                    doc_text = textwrap.indent(attr.yaml['doc'], '    ')
> +                    attr_info += f"\n{doc_text}"
> +                print(attr_info)
> +            else:
> +                print(f'  - {attr_name}')

Does this line execute? I think this scenario indicates a malformed
spec that would fail codegen.

> +    def print_mode_attrs(mode, mode_spec, attr_set, print_request=True):
> +        """Print a given mode (do/dump/event/notify)."""
> +        mode_title = mode.capitalize()
> +
> +        if print_request and 'request' in mode_spec and 'attributes' in mode_spec['request']:
> +            print(f'\n{mode_title} request attributes:')
> +            print_attr_list(mode_spec['request']['attributes'], attr_set)
> +
> +        if 'reply' in mode_spec and 'attributes' in mode_spec['reply']:
> +            print(f'\n{mode_title} reply attributes:')
> +            print_attr_list(mode_spec['reply']['attributes'], attr_set)
> +
> +        if 'attributes' in mode_spec:
> +            print(f'\n{mode_title} attributes:')
> +            print_attr_list(mode_spec['attributes'], attr_set)
> +
> +        if 'mcgrp' in mode_spec:
> +                print(f"Multicast group: {op.yaml['mcgrp']}")
> +
>      if args.list_ops:
>          for op_name, op in ynl.ops.items():
>              print(op_name, " [", ", ".join(op.modes), "]")
> @@ -135,6 +172,24 @@ def main():
>          for op_name, op in ynl.msgs.items():
>              print(op_name, " [", ", ".join(op.modes), "]")
>  
> +    if args.list_attrs:
> +        op = ynl.msgs.get(args.list_attrs)
> +        if not op:
> +            print(f'Operation {args.list_attrs} not found')
> +            exit(1)
> +
> +        print(f'Operation: {op.name}')
> +
> +        for mode in ['do', 'dump', 'event']:
> +            if mode in op.yaml:
> +                print_mode_attrs(mode, op.yaml[mode], op.attr_set, True)
> +
> +        if 'notify' in op.yaml:
> +            mode_spec = op.yaml['notify']
> +            ref_spec = ynl.msgs.get(mode_spec).yaml.get('do')
> +            if ref_spec:
> +                print_mode_attrs(mode, ref_spec, op.attr_set, False)

I guess mode is set to 'event' after the for loop. I'd prefer to not
see it used outside the loop, and just use literal 'event' here.

> +
>      try:
>          if args.do:
>              reply = ynl.do(args.do, attrs, args.flags)

