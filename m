Return-Path: <netdev+bounces-41516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A47CB2ED
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A1DB20E39
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B8F2E65D;
	Mon, 16 Oct 2023 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diudUgFy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF26341AA
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD44C433C7;
	Mon, 16 Oct 2023 18:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697481986;
	bh=B8/x9ls6sPXEQZdjdA/1Yzy6SKilsx/zDXm3VdxmhPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=diudUgFyt5l3ColzWRbXmOrUWtDF+m0C6jEtwSPziDrWFwExi/vuAQhshm5gcNabf
	 zcxaQaamtFZ/BsYH9HJpXlJ+EODlF3k+3ERIPfC8RPm/3Tk1hr8mYdUuAOszQnTk4Z
	 ukfmJC7AN5pCGHP/ieToqxb7clgMOHRJ/gL/OkbLl7c3N81ews+2OCx7swZawC8VbG
	 InvAfMBW6VSUJweWnLc7BaOXARiDiLzZAH/vckatw9m6nyvD7oSIV6+Vgnx9mk2fn3
	 rU13tk5AsrL6AdhC8iX63jFI+gPJQQQhKM04xkd170hdNJyehvq976Qk99FJc3rF3R
	 f1MOf09RaS7Dg==
Date: Mon, 16 Oct 2023 11:46:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 lorenzo@kernel.org, willemb@google.com
Subject: Re: [PATCH net-next 1/3] ynl: netdev: drop unnecessary
 enum-as-flags
Message-ID: <20231016114624.3662b10b@kernel.org>
In-Reply-To: <CAF=yD-Lx7eWLHwNaTwarBPmZEJZ-H=QJVcwpcrgMUXDSkc6V3A@mail.gmail.com>
References: <20231003153416.2479808-1-kuba@kernel.org>
	<20231003153416.2479808-2-kuba@kernel.org>
	<ZS10NtQgd_BJZ3RU@google.com>
	<CAF=yD-Lx7eWLHwNaTwarBPmZEJZ-H=QJVcwpcrgMUXDSkc6V3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 13:43:07 -0400 Willem de Bruijn wrote:
> > Jakub, Willem hit an issue with this commit when running cli.py:
> >
> > ./cli.py --spec $KDIR/Documentation/netlink/specs/netdev.yaml --dump dev-get --json='{"ifindex": 12}'
> >
> > Traceback (most recent call last):
> >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/./cli.py", line 60, in <module>
> >     main()
> >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/./cli.py", line 51, in main
> >     reply = ynl.dump(args.dump, attrs)
> >             ^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", line 729, in dump
> >     return self._op(method, vals, [], dump=True)
> >            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", line 714, in _op
> >     rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
> >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", line 540, in _decode
> >     decoded = self._decode_enum(decoded, attr_spec)
> >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/usr/local/google/home/sdf/net-next/tools/net/ynl/lib/ynl.py", line 486, in _decode_enum
> >     value = enum.entries_by_val[raw].name
> >             ~~~~~~~~~~~~~~~~~~~^^^^^
> > KeyError: 127  
> 
> Indeed. The field is now interpreted as a value rather than a bitmap.
> 
> More subtly, even for requests that do not fail, all my devices now
> incorrectly report to support xdp feature timestamp, because that is
> enum 0.

Sorry about that. This should fix it, right?

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 13c4b019a881..28ac35008e65 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -474,7 +474,7 @@ genl_family_name_to_id = None
 
     def _decode_enum(self, raw, attr_spec):
         enum = self.consts[attr_spec['enum']]
-        if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
+        if enum.type == 'flags' or attr_spec.get('enum-as-flags', False):
             i = 0
             value = set()
             while raw:

