Return-Path: <netdev+bounces-17643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3F2752808
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5D21C21364
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A57E1F176;
	Thu, 13 Jul 2023 16:08:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C91ED55
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6256C433C8;
	Thu, 13 Jul 2023 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689264517;
	bh=cgoCTLI4OTJDfEpmcG5UF3T9ZZ7lJf2XtwEhyJF4p70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IsgyPzg4f9KHfFsFpa802Ag+z3YYaqVTWd+DQsG6F2YsWQaiyel+Tnx90GtZZUftZ
	 lOhjuJkvuALwkFjS2a8D3JJv8Sb7axG+JV4n+sRZEEAu11tsu7j9T4WT5oevzgBjnl
	 VCd8/pG2/VSWIaNJclJmIVRz9BWkuR5EnUzvfgmu/vBeTOeXLC3XkfS6dnd5k6JVuC
	 CfbTomsTsOL3Y3sEp+4puc3YelPMK7F7FghTGsFnO39SkFj/zFmWAOYOy6rtEGONhE
	 v+thNzsqO6lls1YLfBkDoTLJ4hh010s6zGCrCMKNhnO041liT9z8kvC8UvZ4gAk+Ol
	 GLRESQOGWOqDg==
Date: Thu, 13 Jul 2023 09:08:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Donald Hunter
 <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com
Subject: Re: [PATCH net-next 2/2 v2] tools: ynl-gen: fix parse multi-attr
 enum attribute
Message-ID: <20230713090836.13c946bb@kernel.org>
In-Reply-To: <20230713090550.132858-3-arkadiusz.kubalewski@intel.com>
References: <20230713090550.132858-1-arkadiusz.kubalewski@intel.com>
	<20230713090550.132858-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 11:05:50 +0200 Arkadiusz Kubalewski wrote:
> @@ -436,7 +435,7 @@ class YnlFamily(SpecFamily):
>              decoded = attr.as_struct(members)
>              for m in members:
>                  if m.enum:
> -                    self._decode_enum(decoded, m)
> +                    decoded[m] = self._decode_enum(decoded[m], m)

Yeah, not sure this is right.

Adding Donald, dropping Chuck and LMKL (please use this CC list for v3).

Given the code before the change we can assume that m is a complex type
describing the member so decoded[m] is likely going to explode.

I think you should move the enum decoding into as_struct(), transforming
the code into similar fashion as you did for responses (changing the
@decoded value before "value[m.name] = decoded").

