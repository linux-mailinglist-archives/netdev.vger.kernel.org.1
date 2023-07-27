Return-Path: <netdev+bounces-21674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5997642EA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 02:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628E31C2149E
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197D37EA;
	Thu, 27 Jul 2023 00:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50519C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6DAC433C8;
	Thu, 27 Jul 2023 00:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690417368;
	bh=wsFL7PRt+t0InkGKyo3Ef7hCCdgDTFQH8ggIv+rfFQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HbG14v5/kupp42ye2pjqEJILEpRZjgVPH3vpoaonmfnfE98K2LPVKTpmNt7Ht50W2
	 nTEGQOF7kz+r9eN6zKKAcUFRxruUFabYqMGR/WDULn6dpc4lr3ibRcowIml1zJWljq
	 80paXeexgu4V9lWCaL2/vTBWGWX57lNmNlNePRH1rlRD9yaoHiv4AS9dJ3gT6wYat/
	 5lh1lK2CsIX9bhyjOUht5N6rh3wUpTpAZXNcRBrZ33PYcoGw7qLcmKgaSG8k5z53HQ
	 clrHRBGR+K3bVbf3VcPFh5B0w/uYkvg9c7VjBkdW24AT2fuZXC+u5WFVUl70W4WrMf
	 b44Ek1QN2Pl6w==
Date: Wed, 26 Jul 2023 17:22:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 3/4] ynl: regenerate all headers
Message-ID: <20230726172247.021045e7@kernel.org>
In-Reply-To: <CAKH8qBvix3YLwrFjMspk3Wttc=CfYW5xJgQt86x2Jg98v2Y55w@mail.gmail.com>
References: <20230725233517.2614868-1-sdf@google.com>
	<20230725233517.2614868-4-sdf@google.com>
	<20230726163718.6b744ccf@kernel.org>
	<CAKH8qBvix3YLwrFjMspk3Wttc=CfYW5xJgQt86x2Jg98v2Y55w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 16:55:07 -0700 Stanislav Fomichev wrote:
> Oh, didn't know about this. Something like this maybe? Ugly?
> 
> diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
> index d664b36deb5b..c36380bf1536 100644
> --- a/tools/net/ynl/Makefile
> +++ b/tools/net/ynl/Makefile
> @@ -3,6 +3,7 @@
>  SUBDIRS = lib generated samples
> 
>  all: $(SUBDIRS)
> +       (cd ../../../ && ./tools/net/ynl/ynl-regen.sh -f)

Hm, I thought the script itself would handle this. I guess I did a
stupid. How about we extend the script to default to the full tree:

diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index 8d4ca6a50582..bdba24066cf1 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -4,15 +4,18 @@
 TOOL=$(dirname $(realpath $0))/ynl-gen-c.py
 
 force=
+search=
 
 while [ ! -z "$1" ]; do
   case "$1" in
     -f ) force=yes; shift ;;
+    -p ) search=$2; shift 2 ;;
     * )  echo "Unrecognized option '$1'"; exit 1 ;;
   esac
 done
 
 KDIR=$(dirname $(dirname $(dirname $(dirname $(realpath $0)))))
+pushd ${search:-$KDIR} >>/dev/null
 
 files=$(git grep --files-with-matches '^/\* YNL-GEN \(kernel\|uapi\|user\)')
 for f in $files; do
@@ -30,3 +33,5 @@ for f in $files; do
     $TOOL --mode ${params[2]} --${params[3]} --spec $KDIR/${params[0]} \
 	  $args -o $f
 done
+
+popd >>/dev/null

>  $(SUBDIRS):
>         @if [ -f "$@/Makefile" ] ; then \
> 
> Or, now that I know about the script I can actually run it manually.
> But with a makefile imo a bit easier to discover..

Yea, agreed.

