Return-Path: <netdev+bounces-259020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEfNG4dclGm3DAIAu9opvQ
	(envelope-from <netdev+bounces-259020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:18:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD914BDC2
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C500730292FE
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B413385A9;
	Tue, 17 Feb 2026 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da2TxgH+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36A3358D9
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330691; cv=none; b=WW2hx25vUphBU8VsvIgCgSiqWjVpWQkb/srRSFE66an9ZaPncpTisbIoPqit3kVRMIJhaPAmfYowtDeDI1i3uknkXPc7ufngWUWu60Vqd6VBIi/UgN0Xdqo8CEoh8wcYVyPkGbyJhqVlliv6xvKO4WwJ8U8M94QdSpbXTkEcvlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330691; c=relaxed/simple;
	bh=8FaViZIsFFjduqimpKIDkioopbikGif5gxHaLIaZkTU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=XWOZCESF17BSdhJnuDgWQL7/1jIoOpkF2wXSaBw2TffjeHr9eueBg+GjN8L9cNuxoIVb0AFvzE3z8sPnxkHbxYioGqUuC2d4aFUYJoxdEZxKxeccRle31t6ADAHQNwDEueOskzPIxLMNiaXs/ZBEJvk6hCcu/QTmZ21aFZEHMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da2TxgH+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48374014a77so36174245e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 04:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771330688; x=1771935488; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTONtFoNtbkbeYo5PUcTqFHZpngRg049E98Be51k7a0=;
        b=Da2TxgH+1BQpdBJZ5xAHJXGDcdpQNPdHyEXoFBkOVDVZeYA9eYINi+tnm7IkIyw2io
         GX8uVWesRR5Mi1zYIgD7DlxvUmOZiuOnHPzcse/ftTTuf/zvY3+cPtNU56g+SpHa83ue
         7a5MD6tqVNgGgC4CyYH7PgEU99+sc+xJkdxQj3OSYB6pImqUE2VogXRd2WJgrwnplhSF
         984/ie11jHjeh//hJo3vu9Zauu99WttRnP6bcFfxKAWe2WJEiyoHUPNNDvKPlMgd/iqP
         Cr41TdVYNBnA6cXGL2kJ6tmT6l9Pi9Igq7E+OQmBPScKpSJXdwGsTOMSFKZ2v85BH+5J
         HwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771330688; x=1771935488;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QTONtFoNtbkbeYo5PUcTqFHZpngRg049E98Be51k7a0=;
        b=mArRFGt3EAfNBKp5bT7DirTdvERBTuq+LFcJsP+I+VoovDkTOH9QU+4jAHcwpWLnPf
         uWUxF1Hty3vaIJfJwhUdVb6iCt7TLQs/MguZcitJsbBXeecB0+AbpLoECs/KqPch/PAP
         G+QBjrEw/m6FWnf7w63SkIz5RZZXe0dRf803v+taK3UliDzreVT48LiF4SKeZJkmzULU
         h/8tTnXjV8feI66xnPU4nsWbSMdCAP7HdJRP0vpf0eq51W6cC4aTkpbtByGCb4Z6WQkk
         4Fqf2FtsnXj7GtvfwI1kSH21MZAgR4zyjYwRxuB+gX/o0vGSnjnE/7m99prm8V4N8pN/
         5vvw==
X-Forwarded-Encrypted: i=1; AJvYcCV7ftyID833+cbZron8BIyY1kNCtjPlQJ4v/CcvVRebT/mO3eg1dAqEZ3rXUvvBCAYrT4telk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXELAfPxey/GRQp+D0mChGKaLxYHJTkAPUitdjKpFHgvgLZ7d
	dctISGuT+lJmMgkC/coDla4WTaYU1nHvwi8FSiCGBOrZ4kRrUIymqoo8
X-Gm-Gg: AZuq6aI7NzFhXJ2QmK+dDw2z5ZCzOgLZRrsz5ERQJ7+s/2NX0hgFd796Odso0tIm8B0
	c86LOv2P8tG1KiziCG9TKi3/dtkEvirWu3C1jhYqZmOY0mkd8Tp3oqe7rHWHAi+TYNfdfoaP/Gi
	KDDvdRURU37+f5U2t8ePYBhMzrU5yCtBtKYLBfGuiKyvJQPkxPP2fokPSh/dIDPUqZrz3LJ+5iA
	Z+y73Vj2nuhIL5tKXrvrhyB2gIlA8NkfGdg7PDR4whpYyUkO6T6w1EGNfhEYw3RA5zsMx/lgU+t
	CP7s2DA4B6YYJkSqtGTdIIACDrVpPL3ExaObtrJkRPql75H9DcucL+3QPwt+fqQCAgoV1I7DRL3
	uOuvVlvccufbhKTFTvicIPGT93dvuLPwAlasYpm1ObKYjWflmU1E4m6aiDZouwGK7k/Z9yPQBEO
	X+k3QX35S2RJ4JwVj/2/oofC9jeEwMnjNCu1rn91G6V/pRxg==
X-Received: by 2002:a05:600c:6990:b0:483:8f38:a928 with SMTP id 5b1f17b1804b1-4838f38a961mr40324805e9.34.1771330687636;
        Tue, 17 Feb 2026 04:18:07 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7dc3:4609:42c2:f18f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d834ebesm525985725e9.13.2026.02.17.04.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 04:18:07 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hristo Venev <hristo@venev.name>
Cc: Jakub Kicinski <kuba@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org,  Josef Bacik <josef@toxicpanda.com>,  Jens Axboe
 <axboe@kernel.dk>,  linux-block@vger.kernel.org,  nbd@other.debian.org
Subject: Re: [PATCH] netlink: specs: add specification for NBD
In-Reply-To: <20260215180309.2255721-3-hristo@venev.name>
Date: Tue, 17 Feb 2026 12:17:25 +0000
Message-ID: <m2o6lnlg2y.fsf@gmail.com>
References: <20260215180309.2255721-3-hristo@venev.name>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259020-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[venev.name:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30BD914BDC2
X-Rspamd-Action: no action

Hristo Venev <hristo@venev.name> writes:

> This patch adds an initial YNL specification for NBD. The specification
> can be used to produce a UAPI header that is equivalent to the one
> currently shipped in the kernel.
>
> The spec appears to be accurate enough so that commands can be issued
> with pyynl.
>
> Signed-off-by: Hristo Venev <hristo@venev.name>
> ---
>  Documentation/netlink/specs/nbd.yaml | 206 +++++++++++++++++++++++++++
>  1 file changed, 206 insertions(+)
>  create mode 100644 Documentation/netlink/specs/nbd.yaml

There are yamllint errors:

make -C tools/net/ynl lint
make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
yamllint ../../../Documentation/netlink/specs
../../../Documentation/netlink/specs/nbd.yaml
  159:81    error    line too long (104 > 80 characters)  (line-length)
  169:6     error    syntax error: expected <block end>, but found '<block mapping start>' (syntax)
  170:7     error    wrong indentation: expected 5 but found 6  (indentation)

>
> diff --git a/Documentation/netlink/specs/nbd.yaml b/Documentation/netlink/specs/nbd.yaml
> new file mode 100644
> index 0000000000000..a84912a867d91
> --- /dev/null
> +++ b/Documentation/netlink/specs/nbd.yaml
> @@ -0,0 +1,206 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +---
> +name: nbd
> +protocol: genetlink-c
> +uapi-header: linux/nbd-netlink.h
> +doc: See :file:`drivers/block/nbd.c`

Prefer to see a meaningful doc string here.

> +
> +c-family-name: nbd-genl-family-name
> +c-version-name: nbd-genl-version
> +max-by-define: true
> +
> +attribute-sets:
> +  -
> +    name: nbd-attrs
> +    name-prefix: nbd-attr-
> +    doc: Configuration policy attributes, used for CONNECT
> +    attributes:
> +      -
> +        name: unspec
> +        value: 0
> +        type: unused

No need for unspec in the attribute list, ynl codegen does the right thing.

> +      -
> +        name: index
> +        type: u32
> +      -
> +        name: size-bytes
> +        type: u64
> +      -
> +        name: block-size-bytes
> +        type: u64
> +      -
> +        name: timeout
> +        type: u64
> +      -
> +        name: server-flags
> +        type: u64
> +      -
> +        name: client-flags
> +        type: u64
> +      -
> +        name: sockets
> +        type: nest
> +        nested-attributes: sock-item-attrs
> +      -
> +        name: dead-conn-timeout
> +        type: u64
> +      -
> +        name: device-list
> +        type: nest
> +        nested-attributes: device-item-attrs
> +      -
> +        name: backend-identifier
> +        type: string
> +  -
> +    name: device-item-attrs
> +    name-prefix: nbd-device-item-
> +    doc: |
> +      This is the format for multiple devices with :code:`NBD_ATTR_DEVICE_LIST`
> +
> +      .. code-block::
> +
> +        [NBD_ATTR_DEVICE_LIST]
> +          [NBD_DEVICE_ITEM]
> +            [NBD_DEVICE_INDEX]
> +            [NBD_DEVICE_CONNECTED]
> +    attributes:
> +      -
> +        name: unspec
> +        value: 0
> +        type: unused

Not required.

> +      -
> +        name: item
> +        name-prefix: nbd-device-
> +        type: nest
> +        nested-attributes: device-attrs
> +        multi-attr: true
> +  -
> +    name: device-attrs
> +    name-prefix: nbd-device-
> +    attr-max-name: nbd-device-attr-max
> +    attributes:
> +      -
> +        name: unspec
> +        value: 0
> +        type: unused

Not required.

> +      -
> +        name: index
> +        type: u32
> +      -
> +        name: connected
> +        type: u8
> +  -
> +    name: sock-item-attrs
> +    name-prefix: nbd-sock-item-
> +    doc: |
> +      This is the format for multiple sockets with :code:`NBD_ATTR_SOCKETS`
> +
> +      .. code-block::
> +
> +        [NBD_ATTR_SOCKETS]
> +          [NBD_SOCK_ITEM]
> +            [NBD_SOCK_FD]
> +          [NBD_SOCK_ITEM]
> +            [NBD_SOCK_FD]
> +    attributes:
> +      -
> +        name: unspec
> +        value: 0
> +        type: unused

Not required.

> +      -
> +        name: item
> +        name-prefix: nbd-sock-
> +        type: nest
> +        nested-attributes: sock-attrs
> +        multi-attr: true
> +  -
> +    name: sock-attrs
> +    name-prefix: nbd-sock-
> +    attributes:
> +      -
> +        name: unspec
> +        value: 0
> +        type: unused

Not required.

> +      -
> +        name: fd
> +        type: u32
> +
> +operations:
> +  enum-model: unified
> +  name-prefix: nbd-cmd-
> +  list:
> +    -
> +      name: unspec
> +      value: 0
> +      doc: NBD_CMD_UNSPEC

Not required.

> +    -
> +      name: connect
> +      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_connect()`

Prefer to see meaningful doc string (same for other ops)

> +      attribute-set: nbd-attrs
> +      dont-validate: [strict]

nbd.c has strict & dump, should this be [strict, dump] ? (same for other ops)

> +      do:
> +        request:
> +          attributes:
> +            - index
> +            - size-bytes
> +            - block-size-bytes
> +            - timeout
> +            - server-flags
> +            - client-flags
> +            - sockets
> +            - dead-conn-timeout
> +            - backend-identifier
> +        reply:
> +          attributes:
> +            - index
> +    -
> +      name: disconnect
> +      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_disconnect()`
> +      attribute-set: nbd-attrs
> +      dont-validate: [strict]
> +      do:
> +        request:
> +          attributes:
> +            - index
> +    -
> +      name: reconfigure
> +      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_reconfigure()`
> +      attribute-set: nbd-attrs
> +      dont-validate: [strict]
> +      do:
> +        request:
> +          attributes:
> +            - index
> +            - size-bytes
> +            - block-size-bytes
> +            - timeout
> +            - client-flags
> +            - sockets
> +            - dead-conn-timeout
> +            - backend-identifier
> +    -
> +      name: link-dead
> +      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_mark_nsock_dead()` / :code:`nbd_dead_link_work()`
> +      attribute-set: nbd-attrs
> +      event:
> +        attributes:
> +          - index
> +      mcgrp: nbd_mc_group
> +    -
> +      name: status
> +      doc: See :file:`drivers/block/nbd.c`, :code:`nbd_genl_status()`
> +      attribute-set: nbd-attrs
> +      dont-validate: [strict]
> +      do:
> +        request:
> +          attributes:
> +            - index
> +        reply:
> +          attributes:
> +            - device-list
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: nbd_mc_group
> +      c-define-name: nbd-genl-mcast-group-name

