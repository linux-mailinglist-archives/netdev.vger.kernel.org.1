Return-Path: <netdev+bounces-32886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA1D79AA8F
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 19:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9272B2811E8
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70653156CD;
	Mon, 11 Sep 2023 17:21:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303718F5F
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 17:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161CDC433C8;
	Mon, 11 Sep 2023 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694452858;
	bh=X4bjx4WcSwqD8tvxg/8TGlrCU9XsGv/Cxoi4cyfXb4w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JE7K/34dQLAWJQUXeglzWOEUx52VKhMv2IDeuHk1RMsM68pqJlcplE8BnuLHHDM7P
	 eAgGAdwdg98Xj7PloViMG5tSHYM6JT8VYwpL7bHwk4jMj4cl2KnfuXHOKkBDk6StsV
	 itrScVgKiJrxC0pJs+eJJVhl7cwiZ4JhHb2AgUIxW8ftb+c69jorJnYGCpjt9zaT5p
	 6ayAn9xZrb2/9l5CTrvczWquZRHpNH8J7IaICPt1zJZdF/zKMmgHE+Uy/F0KTSQi05
	 aCQ7c12uOUzMCuB8OkTcBRcW6CDWUX8Cr+RXGBL5cWarIlxNPk03AiFROlvqG0zEy0
	 RynbmzHDFe3ww==
Message-ID: <a90d95fc491e8c1037b6dd7670fbe5656ee75a97.camel@kernel.org>
Subject: Re: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, neilb@suse.de, 
	netdev@vger.kernel.org
Date: Mon, 11 Sep 2023 13:20:56 -0400
In-Reply-To: <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
	 <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-09-11 at 14:49 +0200, Lorenzo Bianconi wrote:
> Introduce nfsd_server.yaml specs to generate uAPI and netlink
> code for nfsd server.
> Add rpc-status specs to define message reported by the nfsd server
> dumping the pending RPC requests.
>=20
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd_server.yaml | 97 ++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/netlink/specs/nfsd_server.yaml
>=20
> diff --git a/Documentation/netlink/specs/nfsd_server.yaml b/Documentation=
/netlink/specs/nfsd_server.yaml
> new file mode 100644
> index 000000000000..e681b493847b
> --- /dev/null
> +++ b/Documentation/netlink/specs/nfsd_server.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-C=
lause)
> +
> +name: nfsd_server
> +
> +doc:
> +  nfsd server configuration over generic netlink.
> +
> +attribute-sets:
> +  -
> +    name: rpc-status-comp-op-attr
> +    enum-name: nfsd-rpc-status-comp-attr
> +    name-prefix: nfsd-attr-rpc-status-comp-
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: op
> +        type: u32
> +  -
> +    name: rpc-status-attr
> +    enum-name: nfsd-rpc-status-attr
> +    name-prefix: nfsd-attr-rpc-status-
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: xid
> +        type: u32
> +        byte-order: big-endian
> +      -
> +        name: flags
> +        type: u32
> +      -
> +        name: prog
> +        type: u32
> +      -
> +        name: version
> +        type: u8
> +      -
> +        name: proc
> +        type: u32
> +      -
> +        name: service_time
> +        type: s64
> +      -
> +        name: pad
> +        type: pad
> +      -
> +        name: saddr4
> +        type: u32
> +        byte-order: big-endian
> +        display-hint: ipv4
> +      -
> +        name: daddr4
> +        type: u32
> +        byte-order: big-endian
> +        display-hint: ipv4
> +      -
> +        name: saddr6
> +        type: binary
> +        display-hint: ipv6
> +      -
> +        name: daddr6
> +        type: binary
> +        display-hint: ipv6
> +      -
> +        name: sport
> +        type: u16
> +        byte-order: big-endian
> +      -
> +        name: dport
> +        type: u16
> +        byte-order: big-endian
> +      -
> +        name: compond-op
> +        type: array-nest
> +        nested-attributes: rpc-status-comp-op-attr

Is there a way to do unions in netlink? We're sending down the list of
COMPOUND proc operations here for NFSv4, but it might be interesting to
send down other info for other program/version/procedures in the
future.

> +
> +operations:
> +  enum-name: nfsd-commands
> +  name-prefix: nfsd-cmd-
> +  list:
> +    -
> +      name: unspec
> +      doc: unused
> +      value: 0
> +    -
> +      name: rpc-status-get
> +      doc: dump pending nfsd rpc
> +      attribute-set: rpc-status-attr
> +      dump:
> +        pre: nfsd-server-nl-rpc-status-get-start
> +        post: nfsd-server-nl-rpc-status-get-done

Looks like a good first stab though.

Acked-by: Jeff Layton <jlayton@kernel.org>

