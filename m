Return-Path: <netdev+bounces-44232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CD57D7317
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 20:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951E8B2127B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861D31580;
	Wed, 25 Oct 2023 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDe/gHo7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0E2771A;
	Wed, 25 Oct 2023 18:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36172C433C7;
	Wed, 25 Oct 2023 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698257922;
	bh=kSM3vOOcW5CFXl5q/eeq+LmraQ7RzEGdltScNPHIqNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDe/gHo7OOeisux1y0GkiBWWjSbCIqHajiBPbsjkrj3vPr2+rRiuaq7zTDnOGLIVk
	 Vs8Xm0lLM0bRzvhi+lCASXVRYtgdAPxzqscCTFlw76jhwXz+nnLwN8CiV4yxNxK/FR
	 0fWjly1qTwEsi/UozJdteVjGsyT/pUJUFES9f5lAbRhH3JKnPcK9H+a+pwCtnSC10+
	 dRrPEk/kCAdRYiDyS7EZlX0glRqDeDn+HnGpEh5kDF6XZ7e+OqjJAAV8PVrCcttcYD
	 M95B4IRKlUmCV3Fe26CEf7cj7KiUatbU8PZZeMR9MqcaoJCOQQNSYfKteQgS6XbqQl
	 POMyFwyuqIfGA==
Date: Wed, 25 Oct 2023 11:18:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Matthieu Baerts <matttbe@kernel.org>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] uapi: mptcp: use header file generated
 from YAML spec
Message-ID: <20231025111841.73a40904@kernel.org>
In-Reply-To: <CAKa-r6vCj+gPEUKpv7AsXqM77N6pB0evuh7myHq=585RA3oD5g@mail.gmail.com>
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
	<20231023-send-net-next-20231023-1-v2-5-16b1f701f900@kernel.org>
	<20231024125956.341ef4ef@kernel.org>
	<a29b6917-d578-35c4-978d-d57a3bccd63f@kernel.org>
	<20231024164936.41ae6f3c@kernel.org>
	<CAKa-r6vCj+gPEUKpv7AsXqM77N6pB0evuh7myHq=585RA3oD5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 18:40:52 +0200 Davide Caratti wrote:
> > > Do you want to intentionally move to the normal naming or would you
> > > prefer to keep the old names?  
> 
> given that nobody should use them, I'd prefer to move to the normal
> naming and drop the old definitions (_MPTCP_PM_CMD_AFTER_LAST and
> __MPTCP_ATTR_AFTER_LAST). I was unsure if I could do the drop thing
> actually, because applications using them would break the build then _
> hence these two "backward compatibility" lines.

It's up to you. Only mention on GitHub I see is this:
https://github.com/ngi-mptcp/mptcpanalyzer/blob/d6f5a4a61235f40dd17b1ef394a91ec50eda53f7/mptcp-pm/src/Net/Mptcp/V0/Constants.chs#L34
No idea what it is and whether the define disappearing will break it.

If you're confident that no code will break we can rename.
The downside (other than an angry user) is that if someone reports
breakage late we may need to keep both names, to avoid breaking any
code created in between..

> For the operation list, I see it's about exposing
> 
> cmd-cnt-name
> 
> to [ge]netlink*.yaml, and then do:
> 
>   9 max-by-define: true
>  10 kernel-policy: per-op
>  11 cmd-cnt-name: --mptcp-pm-cmd-after-last    <-- this
>  12
>  13 definitions:
> 
> the generated MPTCP #define(s) are the same as the ones we have in
> net-next now: no need to specify __MPTCP_PM_CMD_MAX anymore.

Ah, I was looking at the documentation which is clearly out of date
already..

> For the attributes, I thought I could use  'attr-cnt-name' like:
> 
> 169     name: attr
> 170     name-prefix: mptcp-pm-attr-
> 171     attr-cnt-name: --mptcp-attr-after-last <-- this
> 172     attributes:
> 
> as described in the [ge]netlink schema, but the tool seems to just ignore it.

Mm. Looks like we only use this one at the family level.

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 1c7474ad92dc..f9010fbbfdfd 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -789,9 +789,12 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 pfx = f"{family.name}-a-{self.name}-"
             self.name_prefix = c_upper(pfx)
             self.max_name = c_upper(self.yaml.get('attr-max-name', f"{self.name_prefix}max"))
+            cnt_name = family.get('attr-cnt-name', f"__{self.name_prefix}MAX")
+            self.cnt_name = c_upper(self.yaml.get('attr-cnt-name', cnt_name))
         else:
             self.name_prefix = family.attr_sets[self.subset_of].name_prefix
             self.max_name = family.attr_sets[self.subset_of].max_name
+            self.cnt_name = family.attr_sets[self.subset_of].cnt_name
 
         # Added by resolve:
         self.c_name = None
@@ -2354,7 +2357,7 @@ _C_KW = {
         if attr_set.subset_of:
             continue
 
-        cnt_name = c_upper(family.get('attr-cnt-name', f"__{attr_set.name_prefix}MAX"))
+        cnt_name = attr_set.cnt_name
         max_value = f"({cnt_name} - 1)"
 
         val = 0

