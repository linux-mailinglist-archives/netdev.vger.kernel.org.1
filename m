Return-Path: <netdev+bounces-28125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D3077E4E7
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E93B281AD7
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D7156DB;
	Wed, 16 Aug 2023 15:20:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C510957
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A89C433C8;
	Wed, 16 Aug 2023 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692199232;
	bh=nPgnGrW/AxW3ysL0uPT98hzgOeH7Jh7J3p6l1H8f+cE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I2/cVds/sLrUcBV6oXoKyVsbwyFYgwnD1FaAqXQcZLZbEazUHVpOLS2rjR0RNQVIj
	 +z7Bn8autQV9OBnS+7akDHxk4s2pLV3QzBQLgVCVLm5RC0Rs1zQ7mqsncIPQhPgTyx
	 MNlXeB0X/qdv7cfQuHcYocuENj+Q+vrnAE8ele6v33o/KIU/trOW/qL7HqXs6l6uHW
	 gvoVYJ4SKJqfO15j4Xve4dPMnuJelI/IC9J6zvsFJ8WiP65BwfW/+JJ20nMv4auIuY
	 a0rZDuyr8pakpGR09kToYQjEVaPqTvNWu+khiDjv4RI+e4RU5S2BV+/Kj8f2nla1OZ
	 xFgsEItOgHzcw==
Date: Wed, 16 Aug 2023 08:20:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Stanislav Fomichev
 <sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 05/10] tools/net/ynl: Refactor
 decode_fixed_header into NlMsg
Message-ID: <20230816082030.5c716f37@kernel.org>
In-Reply-To: <20230815194254.89570-6-donald.hunter@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-6-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 20:42:49 +0100 Donald Hunter wrote:
> +    def __init__(self, nl_msg, ynl=None):
> +        self.genl_cmd, self.genl_version, _ = struct.unpack_from("BBH", nl_msg.raw, 0)
> +        nl_msg.raw = nl_msg.raw[4:]

It's a bit of a layering violation that we are futzing with the raw
member of NlMsg inside GenlMsg, no?

Should we add "fixed hdrs len" argument to NlMsg? Either directly or
pass ynl and let get the expected len from ynl? That way NlMsg can
split itself into hdr, userhdrs and attrs without GenlMsg "fixing it
up"?

> -        self.hdr = nl_msg.raw[0:4]
> -        offset = 4
> -
> -        self.genl_cmd, self.genl_version, _ = struct.unpack("BBH", self.hdr)
> -
> -        self.fixed_header_attrs = dict()
> -        for m in fixed_header_members:
> -            format = NlAttr.get_format(m.type, m.byte_order)
> -            decoded = format.unpack_from(nl_msg.raw, offset)
> -            offset += format.size
> -            self.fixed_header_attrs[m.name] = decoded[0]
> +        if ynl:
> +            op = ynl.rsp_by_value[self.genl_cmd]
> +            if op.fixed_header:
> +                nl_msg.decode_fixed_header(ynl, op.fixed_header)
>  
> -        self.raw = nl_msg.raw[offset:]
> +        self.raw = nl_msg.raw

